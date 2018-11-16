From: hare@suse.de (Hannes Reinecke)
Date: Fri, 16 Nov 2018 08:35:00 +0100
Subject: [PATCH nvme-cli 2/3] nvme: print out controller state for
 'list-subsys'
In-Reply-To: <20181116073501.7867-1-hare@suse.de>
References: <20181116073501.7867-1-hare@suse.de>
Message-ID: <20181116073501.7867-3-hare@suse.de>

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 nvme-print.c | 7 +++++--
 nvme.c       | 9 +++++++++
 nvme.h       | 1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index b728975..5cdfabe 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -2772,9 +2772,10 @@ static void show_nvme_subsystem(struct subsys_list_item *item)
 	printf("\\\n");
 
 	for (i = 0; i < item->nctrls; i++) {
-		printf(" +- %s %s %s\n", item->ctrls[i].name,
+		printf(" +- %s %s %s %s\n", item->ctrls[i].name,
 				item->ctrls[i].transport,
-				item->ctrls[i].address);
+				item->ctrls[i].address,
+				item->ctrls[i].state);
 	}
 
 }
@@ -2820,6 +2821,8 @@ void json_print_nvme_subsystem_list(struct subsys_list_item *slist, int n)
 					slist[i].ctrls[j].transport);
 			json_object_add_value_string(path_attrs, "Address",
 					slist[i].ctrls[j].address);
+			json_object_add_value_string(path_attrs, "State",
+					slist[i].ctrls[j].state);
 			json_array_add_value_object(paths, path_attrs);
 		}
 		if (j) {
diff --git a/nvme.c b/nvme.c
index f15d372..c3295c5 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1363,6 +1363,7 @@ static void free_ctrl_list_item(struct ctrl_list_item *ctrls)
 	free(ctrls->name);
 	free(ctrls->transport);
 	free(ctrls->address);
+	free(ctrls->state);
 }
 
 static int get_nvme_subsystem_info(char *name, char *path,
@@ -1416,6 +1417,14 @@ static int get_nvme_subsystem_info(char *name, char *path,
 			continue;
 		}
 
+		item->ctrls[ccnt].state =
+				get_nvme_ctrl_attr(ctrl_path, "state");
+		if (!item->ctrls[ccnt].state) {
+			fprintf(stderr, "failed to get controller[%d] state.\n", i);
+			free_ctrl_list_item(&item->ctrls[ccnt]);
+			continue;
+		}
+
 		ccnt++;
 	}
 
diff --git a/nvme.h b/nvme.h
index 32ac96d..668c6fd 100644
--- a/nvme.h
+++ b/nvme.h
@@ -129,6 +129,7 @@ struct ctrl_list_item {
 	char *name;
 	char *address;
 	char *transport;
+	char *state;
 };
 
 struct subsys_list_item {
-- 
2.13.7
