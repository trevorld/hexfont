src_dir <- "raw-data/src/unifont-15.1.04"
tar_dir <- "inst/font"

for (doc in c("ChangeLog", "OFL-1.1.txt", "COPYING", "README"))
    file.copy(file.path(src_dir, doc), file.path(tar_dir, doc), overwrite = TRUE)

plane_files <- list.files(src_dir, pattern = "plane", recursive = TRUE)
plane_files <- plane_files[-grep(".html$", plane_files)]
plane_files <- plane_files[-grep(".bmp$", plane_files)]

for (f in plane_files) {
    f_src <- file.path(src_dir, f)
    f_tar <- file.path("inst", f)
    file.copy(f_src, f_tar, overwrite = TRUE)
    if (tools::file_ext(f) == "hex") {
        system(paste("xz --force", f_tar))
    }
}

precompiled_hex <- list.files(file.path(src_dir, "font/precompiled"), pattern = ".hex$",
                              recursive = TRUE)

for (f in precompiled_hex) {
    f_src <- file.path(src_dir, "font/precompiled", f)
    f_tar <- file.path(tar_dir, "precompiled", f)
    f_tar <- gsub("(-[0-9.]*).hex", ".hex", f_tar)
    file.copy(f_src, f_tar, overwrite = TRUE)
    system(paste("xz --force", f_tar))
}
