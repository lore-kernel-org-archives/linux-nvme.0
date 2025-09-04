Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8388CA1016
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Sep 2025 20:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9keJAy0jflOh5NoMbLjFbsGWAVmzeYmwmlRX+Kbz3Tw=; b=oD3PGmnOuCsM4skPTAEA6XwtUw
	ejP8/y/w+heF0zQFJ6Jp6CDIx+ukn2yT2CaT2nVKBrP35c5YjiHVIxCj5hRBerScaKggKJUkLjpwH
	tYq6K5TAQyF4r3jMVwiteFdembMqxGlE3WKEBqjAIRqKZ7PeS5yU/SeUuHt5g58fQofk4FTntd5dN
	AuPeT3BCgswAZ8Sp/pxHMSEnXykANMtznJg3+hj9ay2whT8fMNT4Sj7LhirAoBCBQVp8dJM6FpBlw
	jrRgvR8xwid+4uoVx2yzy/vk//IhS3gtxvIAr0aaDnDZSV2SqIYuKcdvjxYgxsArVlrE8HZ1fJF+N
	tOE7DBPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuGc0-0000000EGaO-06gd;
	Thu, 04 Sep 2025 20:31:16 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuECp-0000000DPTk-1BPt
	for linux-nvme@lists.infradead.org;
	Thu, 04 Sep 2025 17:57:08 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584DVNuq027567;
	Thu, 4 Sep 2025 17:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9keJAy0jflOh5NoMb
	LjFbsGWAVmzeYmwmlRX+Kbz3Tw=; b=nZRXuny2PvogAIKN8gL9jQQZkNRZq/wfT
	/ZOZjVUwYB09IOtQ74ghcrFYc/8FQUpYAo9xgdyKvqlondT0DUjyWE+kS+Ir1AsL
	mlFFJQh6j4x4Mh9Z5N1EjIo1hLlzLF6aBPCrcNWg+XTxjmdxuvjFTrPv25Gm32W5
	lLVsz1HaMwSd0wXB/qByiggaec3gcC8zRzrMvsmb/HU8SYbkKyRxPgmTugnc4XD8
	tT5b/lnQcx3zjufyHXtR5lGgo+VT91ZU64rnnEJ2hTDc1MMpfh6V0PXZy8P6o/N+
	XG9RHAqic7wm6WA9BViW6/lRfNhHtLEXOQM356TK696YURRIcwHaA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvg3dmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 17:57:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584FHFub021170;
	Thu, 4 Sep 2025 17:57:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vcmpws8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 17:57:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584Hv2iT50594084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 17:57:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 384D320040;
	Thu,  4 Sep 2025 17:57:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1571B2004B;
	Thu,  4 Sep 2025 17:57:00 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.24.25])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 17:56:59 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv3 2/4] nvme: extend show-topology command to add support for multipath
Date: Thu,  4 Sep 2025 23:26:49 +0530
Message-ID: <20250904175654.1183750-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904175654.1183750-1-nilay@linux.ibm.com>
References: <20250904175654.1183750-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=behrUPPB c=1 sm=1 tr=0 ts=68b9d2f0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=2J7IuT7wAAAA:8 a=VnNF1IyMAAAA:8 a=KI7dNPih_yhj09QP5qIA:9
 a=RtgRkGnnZwJf8nmJIBi8:22
X-Proofpoint-ORIG-GUID: _14c9iLHd-CvGyFsZYbyXb3qaYJcR77j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX1SQVuQtR40+T
 VAjWhhBMwklC8+n8ZjI4T/WY+JsQILx/Mh+6q4g/wqAiEhFw6T7HrhYTs6oWAir8wSIe/cFwDc1
 9phFTUZ73FNS78X7g4IxyY5m3KPGhu/ERwVfuEIuM6gSCvFHtrLbqTeeVFfdBLKLTMUz/5ggzCX
 /vHVRmH0UPgzkJbUSzws2ek3uMYQjqxOq55xjx6NUrGRqisTDqg+M3uweK0VJl4Z9cqoWv+S3Rv
 tt0BCbeToSHt3oR8HzUTqkFVpUvpq/QEGyCTuFq7OAEuzYz+PJP8q/b0wfgyJjd4QBm+cZa2XxC
 yL19UgIkFWNy6gVQP3ie+XriyRRQibOqPegOV/5/PkqkYT+VUZ+YRcNw9TBwjl5Dm2XBzsvQlUl
 ENX64Lna
X-Proofpoint-GUID: _14c9iLHd-CvGyFsZYbyXb3qaYJcR77j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_105707_446569_3A3879C6 
X-CRM114-Status: GOOD (  22.94  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This commit enhances the show-topology command by adding support for
NVMe multipath. With this change, users can now list all paths to a
namespace from its corresponding head node device. Each NVMe path
entry then also includes additional details such as ANA state, NUMA
node, and queue depth, improving visibility into multipath configs.
This information can be particularly helpful for debugging and
analyzing NVMe multipath setups.

To support this functionality, the "--ranking" option of the nvme
show-topology command has been extended with a new sub-option:
"multipath".

Since this enhancement is specific to NVMe multipath, the iopolicy
configured under each subsystem is now always displayed. Previously,
iopolicy was shown only with nvme show-topology verbose output, but
it is now included by default to improve usability and provide better
context when reviewing multipath configurations via show-topology.

With this update, users can view the multipath topology of a multi
controller/port NVMe disk.

Examples:

$ nvme show-topology -r multipath

nvme-subsys2 - NQN=nvmet_subsystem
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
               iopolicy=numa

          _ _ _<head-node>
         /              _ _ _ <ana-state>
        /              /      _ _ _ <numa-node-list>
       /              /      /
      |              /      /
 +- nvme2n1 (ns 1)  /      /
 \                 |      |
  +- nvme2c2n1 optimized 1,2 nvme2 tcp traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live
  +- nvme2c3n1 optimized 3,4 nvme3 tcp traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live

For iopolicy=numa, only NUMA node list is shown (queue depth is hidden).

$ nvme show-topology -r multipath

nvme-subsys2 - NQN=nvmet_subsystem
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
               iopolicy=queue-depth

          _ _ _<head-node>
         /              _ _ _ <ana-state>
        /              /
       /              /     _ _ _<queue-depth>
      |              /     /
 +- nvme2n1 (ns 1)  /     /
 \                 |     |
  +- nvme2c2n1 optimized 0 nvme2 tcp traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live
  +- nvme2c3n1 optimized 0 nvme3 tcp traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live

For iopolicy=queue-depth, queue depth is shown (NUMA node list is hidden).

$ nvme show-topology -r multipath

nvme-subsys2 - NQN=nvmet_subsystem
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
               iopolicy=round-robin

          _ _ _<head-node>
         /              _ _ _ <ana-state>
        /              /
       /              /
      |              /
 +- nvme2n1 (ns 1)  /
 \                 |
  +- nvme2c2n1 optimized nvme2 tcp traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live
  +- nvme2c3n1 optimized nvme3 tcp traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live

For iopolicy=round-robin, both NUMA node list and queue depth are hidden.

Note:
The annotations above (e.g., <numa-node-list>, <ana-state>, <head-node>,
<queue-depth>) are for illustration only and are not part of the actual
command output. A more human-friendly tabular format will be introduced
in a follow-up patches.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 nvme-print-binary.c |  1 +
 nvme-print-json.c   | 36 +++++++++++++++----
 nvme-print-stdout.c | 85 ++++++++++++++++++++++++++++++++++++++++++---
 nvme-print.c        |  4 ++-
 nvme-print.h        |  1 +
 nvme.c              |  4 ++-
 nvme.h              |  1 +
 7 files changed, 120 insertions(+), 12 deletions(-)

diff --git a/nvme-print-binary.c b/nvme-print-binary.c
index 351513b9..17def142 100644
--- a/nvme-print-binary.c
+++ b/nvme-print-binary.c
@@ -428,6 +428,7 @@ static struct print_ops binary_print_ops = {
 	.print_nvme_subsystem_list	= NULL,
 	.topology_ctrl			= NULL,
 	.topology_namespace		= NULL,
+	.topology_multipath		= NULL,
 
 	/* status and error messages */
 	.connect_msg			= NULL,
diff --git a/nvme-print-json.c b/nvme-print-json.c
index 829ba718..cac9e25a 100644
--- a/nvme-print-json.c
+++ b/nvme-print-json.c
@@ -4743,6 +4743,7 @@ static unsigned int json_subsystem_topology_multipath(nvme_subsystem_t s,
 	nvme_ns_t n;
 	nvme_path_t p;
 	unsigned int i = 0;
+	const char *iopolicy = nvme_subsystem_get_iopolicy(s);
 
 	nvme_subsystem_for_each_ns(s, n) {
 		struct json_object *ns_attrs;
@@ -4750,19 +4751,40 @@ static unsigned int json_subsystem_topology_multipath(nvme_subsystem_t s,
 
 		ns_attrs = json_create_object();
 		obj_add_int(ns_attrs, "NSID", nvme_ns_get_nsid(n));
+		obj_add_str(ns_attrs, "Name", nvme_ns_get_name(n));
 
 		paths = json_create_array();
 		nvme_namespace_for_each_path(n, p) {
 			struct json_object *path_attrs;
-
-			nvme_ctrl_t c = nvme_path_get_ctrl(p);
+			struct json_object *ctrls, *ctrl_attrs;
+			nvme_ctrl_t c;
 
 			path_attrs = json_create_object();
-			obj_add_str(path_attrs, "Name", nvme_ctrl_get_name(c));
-			obj_add_str(path_attrs, "Transport", nvme_ctrl_get_transport(c));
-			obj_add_str(path_attrs, "Address", nvme_ctrl_get_address(c));
-			obj_add_str(path_attrs, "State", nvme_ctrl_get_state(c));
+			obj_add_str(path_attrs, "Path", nvme_path_get_name(p));
 			obj_add_str(path_attrs, "ANAState", nvme_path_get_ana_state(p));
+
+			/*
+			 * For iopolicy numa exclude "Qdepth", for iopolicy
+			 * queue-depth exclude "NUMANodes" and for iopolicy
+			 * round-robin exclude both "Qdepth" and "NUMANodes".
+			 */
+			if (!strcmp(iopolicy, "numa"))
+				obj_add_str(path_attrs, "NUMANodes",
+						nvme_path_get_numa_nodes(p));
+			else if (!strcmp(iopolicy, "queue-depth"))
+				obj_add_int(path_attrs, "Qdepth",
+						nvme_path_get_queue_depth(p));
+
+			c = nvme_path_get_ctrl(p);
+			ctrls = json_create_array();
+			ctrl_attrs = json_create_object();
+			obj_add_str(ctrl_attrs, "Name", nvme_ctrl_get_name(c));
+			obj_add_str(ctrl_attrs, "Transport", nvme_ctrl_get_transport(c));
+			obj_add_str(ctrl_attrs, "Address", nvme_ctrl_get_address(c));
+			obj_add_str(ctrl_attrs, "State", nvme_ctrl_get_state(c));
+			array_add_obj(ctrls, ctrl_attrs);
+			obj_add_array(path_attrs, "Controller", ctrls);
+
 			array_add_obj(paths, path_attrs);
 		}
 		obj_add_array(ns_attrs, "Paths", paths);
@@ -4787,6 +4809,7 @@ static void json_print_nvme_subsystem_topology(nvme_subsystem_t s,
 
 			ns_attrs = json_create_object();
 			obj_add_int(ns_attrs, "NSID", nvme_ns_get_nsid(n));
+			obj_add_str(ns_attrs, "Name", nvme_ns_get_name(n));
 
 			ctrl = json_create_array();
 			ctrl_attrs = json_create_object();
@@ -5546,6 +5569,7 @@ static struct print_ops json_print_ops = {
 	.print_nvme_subsystem_list	= json_print_nvme_subsystem_list,
 	.topology_ctrl			= json_simple_topology,
 	.topology_namespace		= json_simple_topology,
+	.topology_multipath		= json_simple_topology,
 
 	/* status and error messages */
 	.connect_msg			= json_connect_msg,
diff --git a/nvme-print-stdout.c b/nvme-print-stdout.c
index eb56349a..204c8d9d 100644
--- a/nvme-print-stdout.c
+++ b/nvme-print-stdout.c
@@ -1126,6 +1126,8 @@ static void stdout_subsys_config(nvme_subsystem_t s)
 	       nvme_subsystem_get_nqn(s));
 	printf("%*s   hostnqn=%s\n", len, " ",
 	       nvme_host_get_hostnqn(nvme_subsystem_get_host(s)));
+	printf("%*s   iopolicy=%s\n", len, " ",
+		nvme_subsystem_get_iopolicy(s));
 
 	if (stdout_print_ops.flags & VERBOSE) {
 		printf("%*s   model=%s\n", len, " ",
@@ -1134,8 +1136,6 @@ static void stdout_subsys_config(nvme_subsystem_t s)
 			nvme_subsystem_get_serial(s));
 		printf("%*s   firmware=%s\n", len, " ",
 			nvme_subsystem_get_fw_rev(s));
-		printf("%*s   iopolicy=%s\n", len, " ",
-			nvme_subsystem_get_iopolicy(s));
 		printf("%*s   type=%s\n", len, " ",
 			nvme_subsystem_get_type(s));
 	}
@@ -5595,6 +5595,7 @@ static void stdout_subsystem_topology_multipath(nvme_subsystem_t s,
 	nvme_ns_t n;
 	nvme_path_t p;
 	nvme_ctrl_t c;
+	const char *iopolicy = nvme_subsystem_get_iopolicy(s);
 
 	if (ranking == NVME_CLI_TOPO_NAMESPACE) {
 		nvme_subsystem_for_each_ns(s, n) {
@@ -5615,7 +5616,7 @@ static void stdout_subsystem_topology_multipath(nvme_subsystem_t s,
 				       nvme_path_get_ana_state(p));
 			}
 		}
-	} else {
+	} else if (ranking == NVME_CLI_TOPO_CTRL) {
 		/* NVME_CLI_TOPO_CTRL */
 		nvme_subsystem_for_each_ctrl(s, c) {
 			printf(" +- %s %s %s\n",
@@ -5636,6 +5637,59 @@ static void stdout_subsystem_topology_multipath(nvme_subsystem_t s,
 				}
 			}
 		}
+	} else {
+		/* NVME_CLI_TOPO_MULTIPATH */
+		nvme_subsystem_for_each_ns(s, n) {
+			printf(" +- %s (ns %d)\n",
+					nvme_ns_get_name(n),
+					nvme_ns_get_nsid(n));
+			printf(" \\\n");
+			nvme_namespace_for_each_path(n, p) {
+				c = nvme_path_get_ctrl(p);
+
+				if (!strcmp(iopolicy, "numa")) {
+					/*
+					 * For iopolicy numa, exclude printing
+					 * qdepth.
+					 */
+					printf("  +- %s %s %s %s %s %s %s\n",
+						nvme_path_get_name(p),
+						nvme_path_get_ana_state(p),
+						nvme_path_get_numa_nodes(p),
+						nvme_ctrl_get_name(c),
+						nvme_ctrl_get_transport(c),
+						nvme_ctrl_get_address(c),
+						nvme_ctrl_get_state(c));
+
+				} else if (!strcmp(iopolicy, "queue-depth")) {
+					/*
+					 * For iopolicy queue-depth, exclude
+					 * printing numa nodes.
+					 */
+					printf("  +- %s %s %d %s %s %s %s\n",
+						nvme_path_get_name(p),
+						nvme_path_get_ana_state(p),
+						nvme_path_get_queue_depth(p),
+						nvme_ctrl_get_name(c),
+						nvme_ctrl_get_transport(c),
+						nvme_ctrl_get_address(c),
+						nvme_ctrl_get_state(c));
+
+				} else { /* round-robin */
+					/*
+					 * For iopolicy round-robin, exclude
+					 * printing numa nodes and qdepth.
+					 */
+					printf("  +- %s %s %s %s %s %s\n",
+						nvme_path_get_name(p),
+						nvme_path_get_ana_state(p),
+						nvme_ctrl_get_name(c),
+						nvme_ctrl_get_transport(c),
+						nvme_ctrl_get_address(c),
+						nvme_ctrl_get_state(c));
+				}
+			}
+		}
 	}
 }
 
@@ -5657,7 +5711,7 @@ static void stdout_subsystem_topology(nvme_subsystem_t s,
 				       nvme_ctrl_get_state(c));
 			}
 		}
-	} else {
+	} else if (ranking == NVME_CLI_TOPO_CTRL) {
 		/* NVME_CLI_TOPO_CTRL */
 		nvme_subsystem_for_each_ctrl(s, c) {
 			printf(" +- %s %s %s\n",
@@ -5671,6 +5725,23 @@ static void stdout_subsystem_topology(nvme_subsystem_t s,
 				       nvme_ctrl_get_state(c));
 			}
 		}
+	} else {
+		/* NVME_CLI_TOPO_MULTIPATH */
+		nvme_subsystem_for_each_ctrl(s, c) {
+			nvme_ctrl_for_each_ns(c, n) {
+				c = nvme_ns_get_ctrl(n);
+
+				printf(" +- %s (ns %d)\n",
+						nvme_ns_get_name(n),
+						nvme_ns_get_nsid(n));
+				printf(" \\\n");
+				printf("  +- %s %s %s %s\n",
+						nvme_ctrl_get_name(c),
+						nvme_ctrl_get_transport(c),
+						nvme_ctrl_get_address(c),
+						nvme_ctrl_get_state(c));
+			}
+		}
 	}
 }
 
@@ -5717,6 +5788,11 @@ static void stdout_topology_ctrl(nvme_root_t r)
 	stdout_simple_topology(r, NVME_CLI_TOPO_CTRL);
 }
 
+static void stdout_topology_multipath(nvme_root_t r)
+{
+	stdout_simple_topology(r, NVME_CLI_TOPO_MULTIPATH);
+}
+
 static void stdout_message(bool error, const char *msg, va_list ap)
 {
 	vfprintf(error ? stderr : stdout, msg, ap);
@@ -6286,6 +6362,7 @@ static struct print_ops stdout_print_ops = {
 	.print_nvme_subsystem_list	= stdout_subsystem_list,
 	.topology_ctrl			= stdout_topology_ctrl,
 	.topology_namespace		= stdout_topology_namespace,
+	.topology_multipath		= stdout_topology_multipath,
 
 	/* status and error messages */
 	.connect_msg			= stdout_connect_msg,
diff --git a/nvme-print.c b/nvme-print.c
index 3a71dffc..473a6814 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1551,8 +1551,10 @@ void nvme_show_topology(nvme_root_t r,
 {
 	if (ranking == NVME_CLI_TOPO_NAMESPACE)
 		nvme_print(topology_namespace, flags, r);
-	else
+	else if (ranking == NVME_CLI_TOPO_CTRL)
 		nvme_print(topology_ctrl, flags, r);
+	else
+		nvme_print(topology_multipath, flags, r);
 }
 
 void nvme_show_message(bool error, const char *msg, ...)
diff --git a/nvme-print.h b/nvme-print.h
index 4ccf5e63..0f23b711 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -106,6 +106,7 @@ struct print_ops {
 	void (*print_nvme_subsystem_list)(nvme_root_t r, bool show_ana);
 	void (*topology_ctrl)(nvme_root_t r);
 	void (*topology_namespace)(nvme_root_t r);
+	void (*topology_multipath)(nvme_root_t r);
 
 	/* status and error messages */
 	void (*connect_msg)(nvme_ctrl_t c);
diff --git a/nvme.c b/nvme.c
index f17a8091..41d98a78 100644
--- a/nvme.c
+++ b/nvme.c
@@ -10179,7 +10179,7 @@ static int tls_key(int argc, char **argv, struct command *command, struct plugin
 static int show_topology_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
 	const char *desc = "Show the topology\n";
-	const char *ranking = "Ranking order: namespace|ctrl";
+	const char *ranking = "Ranking order: namespace|ctrl|multipath";
 	nvme_print_flags_t flags;
 	_cleanup_nvme_root_ nvme_root_t r = NULL;
 	char *devname = NULL;
@@ -10215,6 +10215,8 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
 		rank = NVME_CLI_TOPO_NAMESPACE;
 	} else if (!strcmp(cfg.ranking, "ctrl")) {
 		rank = NVME_CLI_TOPO_CTRL;
+	} else if (!strcmp(cfg.ranking, "multipath")) {
+		rank = NVME_CLI_TOPO_MULTIPATH;
 	} else {
 		nvme_show_error("Invalid ranking argument: %s", cfg.ranking);
 		return -EINVAL;
diff --git a/nvme.h b/nvme.h
index 248c5c7c..f02f39ca 100644
--- a/nvme.h
+++ b/nvme.h
@@ -46,6 +46,7 @@ typedef uint32_t nvme_print_flags_t;
 enum nvme_cli_topo_ranking {
 	NVME_CLI_TOPO_NAMESPACE,
 	NVME_CLI_TOPO_CTRL,
+	NVME_CLI_TOPO_MULTIPATH,
 };
 
 #define SYS_NVME "/sys/class/nvme"
-- 
2.51.0


