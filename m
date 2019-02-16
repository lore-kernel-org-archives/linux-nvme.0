From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 15 Feb 2019 19:24:50 -0800
Subject: [PATCH] nvme-cli: add uniform printfs for I/O cmd errors
Message-ID: <1550287490-11374-1-git-send-email-chaitanya.kulkarni@wdc.com>

This patch adds uniform error messages in case of NVMe I/O commands
failure. This is helpful in debugging when NVMe-Cli used with the
different test suites like blktests.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Here is the sample output from one of the nvme test from the blktests :-
# ./check tests/nvme/015
nvme/015 (unit test for NVMe flush for file backed ns)       [failed]
runtime  11.531s  ...  11.414s
--- tests/nvme/015.out	2019-02-14 21:40:55.274947540 -0800
+++ /root/blktests/results/nodev/nvme/015.out.bad	2019-02-15 19:14:19.014546298 -0800
@@ -1,6 +1,6 @@
Running nvme/015
91fdba0d-f87b-4c25-b80f-db7be1418b9e
uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
-NVMe Flush: success
+NVME IO command error:INTERNAL: The command was not completed successfully due to an internal error(6006)
NQN:blktests-subsystem-1 disconnected 1 controller(s)
---
 nvme.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/nvme.c b/nvme.c
index 8aac2ef..5f00c71 100644
--- a/nvme.c
+++ b/nvme.c
@@ -3628,8 +3628,8 @@ static int write_uncor(int argc, char **argv, struct command *cmd, struct plugin
 	if (err < 0)
 		perror("write uncorrectable");
 	else if (err != 0)
-		fprintf(stderr, "NVME IO command error:%s(%x)\n",
-					nvme_status_to_string(err), err);
+		fprintf(stderr, "NVME IO command %s error:%s(%x)\n",
+				__func__, nvme_status_to_string(err), err);
 	else
 		printf("NVME Write Uncorrectable Success\n");
 
@@ -3721,8 +3721,8 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
 	if (err < 0)
 		perror("write-zeroes");
 	else if (err != 0)
-		fprintf(stderr, "NVME IO command error:%s(%x)\n",
-					nvme_status_to_string(err), err);
+		fprintf(stderr, "NVME IO command %s error:%s(%x)\n",
+				__func__, nvme_status_to_string(err), err);
 	else
 		printf("NVME Write Zeroes Success\n");
 
@@ -3822,8 +3822,8 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
 	if (err < 0)
 		perror("data-set management");
 	else if (err != 0)
-		fprintf(stderr, "NVME IO command error:%s(%x)\n",
-				nvme_status_to_string(err), err);
+		fprintf(stderr, "NVME IO command %s error:%s(%x)\n",
+				__func__, nvme_status_to_string(err), err);
 	else
 		printf("NVMe DSM: success\n");
 
@@ -3871,8 +3871,8 @@ static int flush(int argc, char **argv, struct command *cmd, struct plugin *plug
 	if (err < 0)
 		perror("flush");
 	else if (err != 0)
-		fprintf(stderr, "NVME IO command error:%s(%x)\n",
-				nvme_status_to_string(err), err);
+		fprintf(stderr, "NVME IO command %s error:%s(%x)\n",
+				__func__, nvme_status_to_string(err), err);
 	else
 		printf("NVMe Flush: success\n");
 close_fd:
@@ -3945,7 +3945,8 @@ static int resv_acquire(int argc, char **argv, struct command *cmd, struct plugi
 	if (err < 0)
 		perror("reservation acquire");
 	else if (err != 0)
-		fprintf(stderr, "NVME IO command error:%s(%x)\n", nvme_status_to_string(err), err);
+		fprintf(stderr, "NVME IO command %s error:%s(%x)\n",
+				__func__, nvme_status_to_string(err), err);
 	else
 		printf("NVME Reservation Acquire success\n");
 
@@ -4022,7 +4023,8 @@ static int resv_register(int argc, char **argv, struct command *cmd, struct plug
 	if (err < 0)
 		perror("reservation register");
 	else if (err != 0)
-		fprintf(stderr, "NVME IO command error:%s(%x)\n", nvme_status_to_string(err), err);
+		fprintf(stderr, "NVME IO command %s error:%s(%x)\n",
+				__func__, nvme_status_to_string(err), err);
 	else
 		printf("NVME Reservation  success\n");
 
@@ -4095,7 +4097,8 @@ static int resv_release(int argc, char **argv, struct command *cmd, struct plugi
 	if (err < 0)
 		perror("reservation release");
 	else if (err != 0)
-		fprintf(stderr, "NVME IO command error:%s(%x)\n", nvme_status_to_string(err), err);
+		fprintf(stderr, "NVME IO command %s error:%s(%x)\n",
+				__func__, nvme_status_to_string(err), err);
 	else
 		printf("NVME Reservation Release success\n");
 
@@ -4180,7 +4183,8 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 	if (err < 0)
 		perror("reservation report");
 	else if (err != 0)
-		fprintf(stderr, "NVME IO command error:%04x\n", err);
+		fprintf(stderr, "NVME IO command %s error:%s(%x)\n",
+				__func__, nvme_status_to_string(err), err);
 	else {
 		if (fmt == BINARY)
 			d_raw((unsigned char *)status, size);
-- 
1.8.3.1
