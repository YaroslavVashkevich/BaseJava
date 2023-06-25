package org.database.resume;

import java.io.File;
import java.io.IOException;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) throws IOException {

        //printDirectoryDeeply(new File("E:\\Workspace\\OLD\\BaseJava\\src\\main\\java\\org\\database"), "");
        //collectFileList(Paths.get("E:\\Workspace\\OLD\\BaseJava\\src\\main\\java\\org\\database\\resume"));
        //System.out.println(Runtime.getRuntime().availableProcessors());

       LocalDate NOW1 = LocalDate.now();
        System.out.println(NOW1);
        LocalDate NOW = LocalDate.of(3000, 1, 1);
        System.out.println(NOW);
    }

    public static void printDirectoryDeeply(File dir, String offset) {
        File[] files = dir.listFiles();
        if (files != null) {
            for (File file : files) {
                if (file.isFile()) {
                    System.out.println(offset + "File: " + file.getName());
                } else if (file.isDirectory()) {
                    System.out.println(offset + "Directory: " + file.getName());
                    printDirectoryDeeply(file, offset + "  ");
                }}}}

    public static void collectFileList(Path path) throws IOException {
        if (Files.isRegularFile(path)) {
            System.out.println(path);
        } else if (Files.isDirectory(path)) {
            try (DirectoryStream<Path> files = Files.newDirectoryStream(path)) {
                for (Path path1 : files)
                    collectFileList(path1);
            }
        }
    }

}
