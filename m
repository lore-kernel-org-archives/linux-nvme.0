From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 19 Jun 2019 10:36:50 -0700
Subject: [PATCH nvme-cli 02/13] Use NULL instead of 0 where a pointer is
 expected
In-Reply-To: <20190619173701.8263-1-bvanassche@acm.org>
References: <20190619173701.8263-1-bvanassche@acm.org>
Message-ID: <20190619173701.8263-3-bvanassche@acm.org>

This patch avoids that sparse reports the following:

warning: Using plain integer as NULL pointer

Cc: Muhammad Ahmad <muhammad.ahmad at seagate.com>
Cc: Quyen Truong <quyen.truong at virtium.com>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 plugins/seagate/seagate-nvme.c | 8 ++++----
 plugins/virtium/virtium-nvme.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/plugins/seagate/seagate-nvme.c b/plugins/seagate/seagate-nvme.c
index 4b5b0acb9244..69f3667d5b16 100644
--- a/plugins/seagate/seagate-nvme.c
+++ b/plugins/seagate/seagate-nvme.c
@@ -173,7 +173,7 @@ static int log_pages_supp(int argc, char **argv, struct command *cmd,
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format,
 		 required_argument, output_format },
-		{0}
+		{ }
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options,
@@ -735,7 +735,7 @@ static int vs_smart_log(int argc, char **argv, struct command *cmd, struct plugi
 
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format, required_argument, output_format },
-		{0}
+		{ }
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -832,7 +832,7 @@ static int temp_stats(int argc, char **argv, struct command *cmd, struct plugin
 
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format, required_argument, output_format },
-		{0}
+		{ }
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -1004,7 +1004,7 @@ static int vs_pcie_error_log(int argc, char **argv, struct command *cmd, struct
 
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format, required_argument, output_format },
-		{0}
+		{ }
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
diff --git a/plugins/virtium/virtium-nvme.c b/plugins/virtium/virtium-nvme.c
index b5b30af5dacd..ca5f5774af8c 100644
--- a/plugins/virtium/virtium-nvme.c
+++ b/plugins/virtium/virtium-nvme.c
@@ -287,7 +287,7 @@ static int vt_add_entry_to_log(const int fd, const char *path, const struct vtvi
         strcpy(filename, cfg->output_file);
     }
 	
-    smart.time_stamp = time(0);
+    smart.time_stamp = time(NULL);
     nsid = nvme_get_nsid(fd);
 	
     if(nsid <= 0) 
@@ -353,7 +353,7 @@ static int vt_update_vtview_log_header(const int fd, const char *path, const str
     }
 
     printf("Log file: %s\n", filename);
-    header.time_stamp = time(0);
+    header.time_stamp = time(NULL);
 
     ret = nvme_identify_ctrl(fd, &header.raw_ctrl);
     if(ret) 
@@ -881,14 +881,14 @@ Just logging :\n\
         freq_time = 1;
     }
 	
-    start_time = time(0);
+    start_time = time(NULL);
     end_time = start_time + total_time;
 
     fflush(stdout);
 	
     while(1)
     {
-        cur_time = time(0);
+        cur_time = time(NULL);
         if(cur_time >= end_time)
         {
             break;
-- 
2.22.0.rc3
