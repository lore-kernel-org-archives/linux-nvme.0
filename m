From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 24 Jun 2019 13:05:21 -0700
Subject: [PATCH nvme-cli 3/3] nvme-cli: Fix more endianness issues
In-Reply-To: <20190624200521.28191-1-bvanassche@acm.org>
References: <20190624200521.28191-1-bvanassche@acm.org>
Message-ID: <20190624200521.28191-4-bvanassche@acm.org>

Declare little endian variables as __le*. Use the proper le*_to_cpu()
conversion functions for little endian integers. Do not use le*_to_cpu()
for variables of type uint8_t.

Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 fabrics.c                      |  2 +-
 linux/nvme.h                   |  9 ++--
 nvme-print.c                   | 53 ++++++++++++++---------
 nvme.c                         |  2 +-
 nvme.h                         | 16 +++----
 plugins/intel/intel-nvme.c     | 16 +++----
 plugins/virtium/virtium-nvme.c |  2 +-
 plugins/wdc/wdc-nvme.c         | 79 +++++++++++++++++-----------------
 8 files changed, 96 insertions(+), 83 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 780dc9f65a80..32c3a9c07e4a 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -397,7 +397,7 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 		goto out_free_log;
 	}
 
-	if (*numrec != le32_to_cpu(log->numrec)) {
+	if (*numrec != le64_to_cpu(log->numrec)) {
 		error = DISC_NOT_EQUAL;
 		goto out_free_log;
 	}
diff --git a/linux/nvme.h b/linux/nvme.h
index 69322fee1ec1..a2cd1bb555b7 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -616,12 +616,13 @@ enum {
 	NVME_LBART_ATTRIB_HIDE	= 1 << 1,
 };
 
+/* Predictable Latency Mode - Deterministic Threshold Configuration Data */
 struct nvme_plm_config {
-	__u16	enable_event;
+	__le16	enable_event;
 	__u8	rsvd2[30];
-	__u64	dtwin_reads_thresh;
-	__u64	dtwin_writes_thresh;
-	__u64	dtwin_time_thresh;
+	__le64	dtwin_reads_thresh;
+	__le64	dtwin_writes_thresh;
+	__le64	dtwin_time_thresh;
 	__u8	rsvd56[456];
 };
 
diff --git a/nvme-print.c b/nvme-print.c
index 5ffc1b7514f7..bbf7b972415e 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -713,7 +713,7 @@ void show_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 	printf("fpi     : %#x\n", ns->fpi);
 	if (human)
 		show_nvme_id_ns_fpi(ns->fpi);
-	printf("dlfeat  : %d\n", le16_to_cpu(ns->dlfeat));
+	printf("dlfeat  : %d\n", ns->dlfeat);
 	if (human)
 		show_nvme_id_ns_dlfeat(ns->dlfeat);
 	printf("nawun   : %d\n", le16_to_cpu(ns->nawun));
@@ -1132,7 +1132,7 @@ void json_nvme_id_nvmset(struct nvme_id_nvmset *nvmset, const char *devname)
 {
 	struct json_object *root;
 	struct json_array *entries;
-	__u32 nent = le32_to_cpu(nvmset->nid);
+	__u32 nent = nvmset->nid;
 	int i;
 
 	root = json_create_object();
@@ -1163,7 +1163,7 @@ void json_nvme_id_nvmset(struct nvme_id_nvmset *nvmset, const char *devname)
 void show_nvme_list_secondary_ctrl(const struct nvme_secondary_controllers_list *sc_list, __u32 count)
 {
 	int i;
-	__u16 num = le16_to_cpu(sc_list->num);
+	__u16 num = sc_list->num;
 	__u32 entries = min(num, count);
 
 	static const char * const state_desc[] = { "Offline", "Online" };
@@ -1180,8 +1180,8 @@ void show_nvme_list_secondary_ctrl(const struct nvme_secondary_controllers_list
 		printf("     PCID      : Primary Controller Identifier   : 0x%.04x\n",
 				le16_to_cpu(sc_entry[i].pcid));
 		printf("     SCS       : Secondary Controller State      : 0x%.04x (%s)\n",
-				le16_to_cpu(sc_entry[i].scs),
-				state_desc[le16_to_cpu(sc_entry[i].scs) & 0x1]);
+				sc_entry[i].scs,
+				state_desc[sc_entry[i].scs & 0x1]);
 		printf("     VFN       : Virtual Function Number         : 0x%.04x\n",
 				le16_to_cpu(sc_entry[i].vfn));
 		printf("     NVQ       : Num VQ Flex Resources Assigned  : 0x%.04x\n",
@@ -1196,7 +1196,7 @@ void json_nvme_list_secondary_ctrl(const struct nvme_secondary_controllers_list
 	int i;
 	struct json_object *root;
 	struct json_array *entries;
-	__u32 nent = min(le16_to_cpu(sc_list->num), count);
+	__u32 nent = min(sc_list->num, count);
 	const struct nvme_secondary_controller_entry *sc_entry = &sc_list->sc_entry[0];
 
 	root = json_create_object();
@@ -1209,7 +1209,8 @@ void json_nvme_list_secondary_ctrl(const struct nvme_secondary_controllers_list
 
 		json_object_add_value_int(entry, "secondary-controller-identifier", le16_to_cpu(sc_entry[i].scid));
 		json_object_add_value_int(entry, "primary-controller-identifier", le16_to_cpu(sc_entry[i].pcid));
-		json_object_add_value_int(entry, "secondary-controller-state",  le16_to_cpu(sc_entry[i].scs));
+		json_object_add_value_int(entry, "secondary-controller-state",
+					  sc_entry[i].scs);
 		json_object_add_value_int(entry, "virtual-function-number",  le16_to_cpu(sc_entry[i].vfn));
 		json_object_add_value_int(entry, "num-virtual-queues",  le16_to_cpu(sc_entry[i].nvq));
 		json_object_add_value_int(entry, "num-virtual-interrupts",  le16_to_cpu(sc_entry[i].nvi));
@@ -1237,12 +1238,13 @@ void show_error_log(struct nvme_error_log_page *err_log, int entries, const char
 		printf("sqid         : %d\n", err_log[i].sqid);
 		printf("cmdid        : %#x\n", err_log[i].cmdid);
 		printf("status_field : %#x(%s)\n", err_log[i].status_field,
-			nvme_status_to_string(err_log[i].status_field >> 1));
+			nvme_status_to_string(le16_to_cpu(err_log[i].status_field) >> 1));
 		printf("parm_err_loc : %#x\n", err_log[i].parm_error_location);
 		printf("lba          : %#"PRIx64"\n",le64_to_cpu(err_log[i].lba));
 		printf("nsid         : %#x\n", err_log[i].nsid);
 		printf("vs           : %d\n", err_log[i].vs);
-		printf("cs           : %#"PRIx64"\n", (uint64_t) err_log[i].cs);
+		printf("cs           : %#"PRIx64"\n",
+		       le64_to_cpu(err_log[i].cs));
 		printf(".................\n");
 	}
 }
@@ -1691,9 +1693,10 @@ void show_sanitize_log(struct nvme_sanitize_log_page *sanitize, unsigned int mod
 	int human = mode & HUMAN;
 	__u16 status = le16_to_cpu(sanitize->status) & NVME_SANITIZE_LOG_STATUS_MASK;
 
-	printf("Sanitize Progress                     (SPROG) :  %u", le32_to_cpu(sanitize->progress));
+	printf("Sanitize Progress                     (SPROG) :  %u",
+	       le16_to_cpu(sanitize->progress));
 	if (human && status == NVME_SANITIZE_LOG_IN_PROGESS)
-		show_sanitize_log_sprog(le32_to_cpu(sanitize->progress));
+		show_sanitize_log_sprog(le16_to_cpu(sanitize->progress));
 	else
 		printf("\n");
 
@@ -2328,8 +2331,8 @@ void json_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 		struct json_object *lbaf = json_create_object();
 
 		json_object_add_value_int(lbaf, "ms", le16_to_cpu(ns->lbaf[i].ms));
-		json_object_add_value_int(lbaf, "ds", le16_to_cpu(ns->lbaf[i].ds));
-		json_object_add_value_int(lbaf, "rp", le16_to_cpu(ns->lbaf[i].rp));
+		json_object_add_value_int(lbaf, "ds", ns->lbaf[i].ds);
+		json_object_add_value_int(lbaf, "rp", ns->lbaf[i].rp);
 
 		json_array_add_value_object(lbafs, lbaf);
 	}
@@ -2482,15 +2485,23 @@ void json_error_log(struct nvme_error_log_page *err_log, int entries, const char
 	for (i = 0; i < entries; i++) {
 		struct json_object *error = json_create_object();
 
-		json_object_add_value_uint(error, "error_count", err_log[i].error_count);
-		json_object_add_value_int(error, "sqid", err_log[i].sqid);
-		json_object_add_value_int(error, "cmdid", err_log[i].cmdid);
-		json_object_add_value_int(error, "status_field", err_log[i].status_field);
-		json_object_add_value_int(error, "parm_error_location", err_log[i].parm_error_location);
-		json_object_add_value_uint(error, "lba", err_log[i].lba);
-		json_object_add_value_uint(error, "nsid", err_log[i].nsid);
+		json_object_add_value_uint(error, "error_count",
+					   le64_to_cpu(err_log[i].error_count));
+		json_object_add_value_int(error, "sqid",
+					  le16_to_cpu(err_log[i].sqid));
+		json_object_add_value_int(error, "cmdid",
+					  le16_to_cpu(err_log[i].cmdid));
+		json_object_add_value_int(error, "status_field",
+					  le16_to_cpu(err_log[i].status_field));
+		json_object_add_value_int(error, "parm_error_location",
+					  le16_to_cpu(err_log[i].parm_error_location));
+		json_object_add_value_uint(error, "lba",
+					   le64_to_cpu(err_log[i].lba));
+		json_object_add_value_uint(error, "nsid",
+					   le32_to_cpu(err_log[i].nsid));
 		json_object_add_value_int(error, "vs", err_log[i].vs);
-		json_object_add_value_uint(error, "cs", err_log[i].cs);
+		json_object_add_value_uint(error, "cs",
+					   le64_to_cpu(err_log[i].cs));
 
 		json_array_add_value_object(errors, error);
 	}
diff --git a/nvme.c b/nvme.c
index 9a00b263e426..6fe99ebf2967 100644
--- a/nvme.c
+++ b/nvme.c
@@ -986,7 +986,7 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
 	const char *namespace_id = "first nsid returned list should start from";
 	const char *all = "show all namespaces in the subsystem, whether attached or inactive";
 	int err, i, fd;
-	__u32 ns_list[1024];
+	__le32 ns_list[1024];
 
 	struct config {
 		__u32 namespace_id;
diff --git a/nvme.h b/nvme.h
index f059db864128..3409515cb9fb 100644
--- a/nvme.h
+++ b/nvme.h
@@ -40,16 +40,16 @@ struct nvme_effects_log_page {
 };
 
 struct nvme_error_log_page {
-	__u64	error_count;
-	__u16	sqid;
-	__u16	cmdid;
-	__u16	status_field;
-	__u16	parm_error_location;
-	__u64	lba;
-	__u32	nsid;
+	__le64	error_count;
+	__le16	sqid;
+	__le16	cmdid;
+	__le16	status_field;
+	__le16	parm_error_location;
+	__le64	lba;
+	__le32	nsid;
 	__u8	vs;
 	__u8	resv[3];
-	__u64	cs;
+	__le64	cs;
 	__u8	resv2[24];
 };
 
diff --git a/plugins/intel/intel-nvme.c b/plugins/intel/intel-nvme.c
index 37f2c705c90f..71e9985fc479 100644
--- a/plugins/intel/intel-nvme.c
+++ b/plugins/intel/intel-nvme.c
@@ -307,15 +307,15 @@ static int get_market_log(int argc, char **argv, struct command *cmd, struct plu
 
 
 struct intel_temp_stats {
-	__u64	curr;
-	__u64	last_overtemp;
-	__u64	life_overtemp;
-	__u64	highest_temp;
-	__u64	lowest_temp;
+	__le64	curr;
+	__le64	last_overtemp;
+	__le64	life_overtemp;
+	__le64	highest_temp;
+	__le64	lowest_temp;
 	__u8	rsvd[40];
-	__u64	max_operating_temp;
-	__u64	min_operating_temp;
-	__u64	est_offset;
+	__le64	max_operating_temp;
+	__le64	min_operating_temp;
+	__le64	est_offset;
 };
 
 static void show_temp_stats(struct intel_temp_stats *stats)
diff --git a/plugins/virtium/virtium-nvme.c b/plugins/virtium/virtium-nvme.c
index 5b295e2a47eb..812313fe2dca 100644
--- a/plugins/virtium/virtium-nvme.c
+++ b/plugins/virtium/virtium-nvme.c
@@ -727,7 +727,7 @@ static void vt_parse_detail_identify(const struct nvme_id_ctrl *ctrl)
     vt_convert_data_buffer_to_hex_string(&buf[326], 2, true, s);
     printf("    \"Maximum Thermal Management Temperature\":\"%sh\",\n", s);
 
-    temp = le16_to_cpu(ctrl->sanicap);
+    temp = le32_to_cpu(ctrl->sanicap);
     printf("    \"Sanitize Capabilities\":{\n");
     vt_convert_data_buffer_to_hex_string(&buf[328], 2, true, s);
     printf("        \"Value\":\"%sh\",\n", s);
diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index ba90fc09e0fe..a6e8069aea70 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -199,17 +199,17 @@
 #define WDC_C2_USER_EOL_STATE_ID			0x1C
 #define WDC_C2_SYSTEM_EOL_STATE_ID			0x1D
 #define WDC_C2_FORMAT_CORRUPT_REASON_ID			0x1E
-#define WDC_EOL_STATUS_NORMAL				0x00000000
-#define WDC_EOL_STATUS_END_OF_LIFE			0x00000001
-#define WDC_EOL_STATUS_READ_ONLY			0x00000002
-#define WDC_ASSERT_DUMP_NOT_PRESENT			0x00000000
-#define WDC_ASSERT_DUMP_PRESENT				0x00000001
-#define WDC_THERMAL_THROTTLING_OFF			0x00000000
-#define WDC_THERMAL_THROTTLING_ON			0x00000001
-#define WDC_THERMAL_THROTTLING_UNAVAILABLE		0x00000002
-#define WDC_FORMAT_NOT_CORRUPT				0x00000000
-#define WDC_FORMAT_CORRUPT_FW_ASSERT			0x00000001
-#define WDC_FORMAT_CORRUPT_UNKNOWN			0x000000FF
+#define WDC_EOL_STATUS_NORMAL				cpu_to_le32(0x00000000)
+#define WDC_EOL_STATUS_END_OF_LIFE			cpu_to_le32(0x00000001)
+#define WDC_EOL_STATUS_READ_ONLY			cpu_to_le32(0x00000002)
+#define WDC_ASSERT_DUMP_NOT_PRESENT			cpu_to_le32(0x00000000)
+#define WDC_ASSERT_DUMP_PRESENT				cpu_to_le32(0x00000001)
+#define WDC_THERMAL_THROTTLING_OFF			cpu_to_le32(0x00000000)
+#define WDC_THERMAL_THROTTLING_ON			cpu_to_le32(0x00000001)
+#define WDC_THERMAL_THROTTLING_UNAVAILABLE		cpu_to_le32(0x00000002)
+#define WDC_FORMAT_NOT_CORRUPT				cpu_to_le32(0x00000000)
+#define WDC_FORMAT_CORRUPT_FW_ASSERT			cpu_to_le32(0x00000001)
+#define WDC_FORMAT_CORRUPT_UNKNOWN			cpu_to_le32(0x000000FF)
 
 /* CA Log Page */
 #define WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE		0xCA
@@ -611,7 +611,7 @@ static long double int128_to_double(__u8 *data)
 	return result;
 }
 
-static int wdc_get_pci_ids(int *device_id, int *vendor_id)
+static int wdc_get_pci_ids(uint32_t *device_id, uint32_t *vendor_id)
 {
 	int fd, ret = -1;
 	char *block, path[512], *id;
@@ -675,7 +675,7 @@ static int wdc_get_pci_ids(int *device_id, int *vendor_id)
 			id[strlen(id) - 1] = '\0';
 
 		/* convert the device id string to an int  */
-		*device_id = (int)strtol(&id[2], NULL, 16);
+		*device_id = strtol(&id[2], NULL, 16);
 		ret = 0;
 	}
 
@@ -690,31 +690,31 @@ static bool wdc_check_device(int fd)
 {
 	int ret;
 	bool supported;
-	int read_device_id, read_vendor_id;
+	uint32_t read_device_id, read_vendor_id;
 
-	ret = wdc_get_pci_ids((int *)&read_device_id, (int *)&read_vendor_id);
+	ret = wdc_get_pci_ids(&read_device_id, &read_vendor_id);
 	if (ret < 0)
 		return false;
 
 	supported = false;
 
-	if ((le32_to_cpu(read_vendor_id) == WDC_NVME_VID) ||
-			(le32_to_cpu(read_vendor_id) == WDC_NVME_VID_2) ||
-			(le32_to_cpu(read_vendor_id) == WDC_NVME_SNDK_VID))
+	if (read_vendor_id == WDC_NVME_VID ||
+	    read_vendor_id == WDC_NVME_VID_2 ||
+	    read_vendor_id == WDC_NVME_SNDK_VID)
 		supported = true;
 	else
 		fprintf(stderr, "ERROR : WDC: unsupported WDC device, Vendor ID = 0x%x, Device ID = 0x%x\n",
-				le32_to_cpu(read_vendor_id), le32_to_cpu(read_device_id));
+				read_vendor_id, read_device_id);
 
 	return supported;
 }
 
 static __u64 wdc_get_drive_capabilities(int fd) {
 	int ret;
-	int read_device_id, read_vendor_id;
+	uint32_t read_device_id, read_vendor_id;
 	__u64 capabilities = 0;
 
-	ret = wdc_get_pci_ids((int *)&read_device_id, (int *)&read_vendor_id);
+	ret = wdc_get_pci_ids(&read_device_id, &read_vendor_id);
 	if (ret < 0)
 		return capabilities;
 
@@ -979,7 +979,7 @@ static bool wdc_nvme_check_supported_log_page(int fd, __u8 log_id)
 	return found;
 }
 
-static bool wdc_nvme_get_dev_status_log_data(int fd, __u32 *ret_data,
+static bool wdc_nvme_get_dev_status_log_data(int fd, __le32 *ret_data,
 		__u8 log_id)
 {
 	__u32 *cbs_data = NULL;
@@ -1292,7 +1292,7 @@ static int wdc_do_cap_dui(int fd, char *file, __u32 xfer_size, int data_area)
 		if (data_area != WDC_NVME_DUI_MAX_DATA_AREA) {
 			for(int i = 0; i < WDC_NVME_DUI_MAX_SECTION; i++) {
 				__u16 data_area_id = le16_to_cpu(log_hdr->log_section[i].data_area_id);
-				__u16 section_size = le16_to_cpu(log_hdr->log_section[i].section_size);
+				__u16 section_size = le32_to_cpu(log_hdr->log_section[i].section_size);
 
 				if (data_area_id <= data_area &&
 				    data_area_id != 0)
@@ -2610,7 +2610,7 @@ static int wdc_get_c1_log_page(int fd, char *format, uint8_t interval)
 					break;
 				}
 			}
-			skip_cnt = le32_to_cpu(sph->subpage_length) + 4;
+			skip_cnt = le16_to_cpu(sph->subpage_length) + 4;
 		}
 		if (ret) {
 			fprintf(stderr, "ERROR : WDC : Unable to read data from buffer\n");
@@ -2769,11 +2769,12 @@ static int wdc_drive_status(int argc, char **argv, struct command *command,
 	char *desc = "Get Drive Status.";
 	int fd;
 	int ret = -1;
-	uint32_t system_eol_state;
-	uint32_t user_eol_state;
-	uint32_t format_corrupt_reason = 0xFFFFFFFF;
-	int32_t eol_status;
-	__u32 assert_status = 0xFFFFFFFF, thermal_status = 0xFFFFFFFF;
+	__le32 system_eol_state;
+	__le32 user_eol_state;
+	__le32 format_corrupt_reason = cpu_to_le32(0xFFFFFFFF);
+	__le32 eol_status;
+	__le32 assert_status = cpu_to_le32(0xFFFFFFFF);
+	__le32 thermal_status = cpu_to_le32(0xFFFFFFFF);
 	__u64 capabilities = 0;
 
 	const struct argconfig_commandline_options command_line_options[] = {
@@ -2799,39 +2800,39 @@ static int wdc_drive_status(int argc, char **argv, struct command *command,
 	}
 
 	/* Get the assert dump present status */
-	if (!wdc_nvme_get_dev_status_log_data(fd, (__u32 *)&assert_status,
+	if (!wdc_nvme_get_dev_status_log_data(fd, &assert_status,
 			WDC_C2_ASSERT_DUMP_PRESENT_ID))
 		fprintf(stderr, "ERROR : WDC : Get Assert Status Failed\n");
 
 	/* Get the thermal throttling status */
-	if (!wdc_nvme_get_dev_status_log_data(fd, (__u32 *)&thermal_status,
+	if (!wdc_nvme_get_dev_status_log_data(fd, &thermal_status,
 			WDC_C2_THERMAL_THROTTLE_STATUS_ID))
 		fprintf(stderr, "ERROR : WDC : Get Thermal Throttling Status Failed\n");
 
 	/* Get EOL status */
-	if (!wdc_nvme_get_dev_status_log_data(fd, (__u32 *)&eol_status,
+	if (!wdc_nvme_get_dev_status_log_data(fd, &eol_status,
 			WDC_C2_USER_EOL_STATUS_ID)) {
 		fprintf(stderr, "ERROR : WDC : Get User EOL Status Failed\n");
-		eol_status = -1;
+		eol_status = cpu_to_le32(-1);
 	}
 
 	/* Get Customer EOL state */
-	if (!wdc_nvme_get_dev_status_log_data(fd, (__u32 *)&user_eol_state,
+	if (!wdc_nvme_get_dev_status_log_data(fd, &user_eol_state,
 			WDC_C2_USER_EOL_STATE_ID))
 		fprintf(stderr, "ERROR : WDC : Get User EOL State Failed\n");
 
 	/* Get System EOL state*/
-	if (!wdc_nvme_get_dev_status_log_data(fd, (__u32 *)&system_eol_state,
+	if (!wdc_nvme_get_dev_status_log_data(fd, &system_eol_state,
 			WDC_C2_SYSTEM_EOL_STATE_ID))
 		fprintf(stderr, "ERROR : WDC : Get System EOL State Failed\n");
 
 	/* Get format corrupt reason*/
-	if (!wdc_nvme_get_dev_status_log_data(fd, (__u32 *)&format_corrupt_reason,
+	if (!wdc_nvme_get_dev_status_log_data(fd, &format_corrupt_reason,
 			WDC_C2_FORMAT_CORRUPT_REASON_ID))
 		fprintf(stderr, "ERROR : WDC : Get Format Corrupt Reason Failed\n");
 
 	printf("  Drive Status :- \n");
-	if (eol_status >= 0) {
+	if (le32_to_cpu(eol_status) >= 0) {
 		printf("  Percent Used:				%"PRIu32"%%\n",
 				le32_to_cpu(eol_status));
 	}
@@ -2882,7 +2883,7 @@ static int wdc_clear_assert_dump(int argc, char **argv, struct command *command,
 	char *desc = "Clear Assert Dump Present Status.";
 	int fd;
 	int ret = -1;
-	__u32 assert_status = 0xFFFFFFFF;
+	__le32 assert_status = cpu_to_le32(0xFFFFFFFF);
 	struct nvme_passthru_cmd admin_cmd;
 	const struct argconfig_commandline_options command_line_options[] = {
 		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc },
@@ -2899,7 +2900,7 @@ static int wdc_clear_assert_dump(int argc, char **argv, struct command *command,
 		ret = -1;
 		goto out;
 	}
-	if (!wdc_nvme_get_dev_status_log_data(fd, (__u32 *)&assert_status,
+	if (!wdc_nvme_get_dev_status_log_data(fd, &assert_status,
 			WDC_C2_ASSERT_DUMP_PRESENT_ID)) {
 		fprintf(stderr, "ERROR : WDC : Get Assert Status Failed\n");
 		ret = -1;
-- 
2.22.0.410.gd8fdbe21b5-goog
