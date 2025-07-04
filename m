Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7AFC83F03
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=46sPtIpQNa6qMl4WxST8GLbvaP56ktZh9MaOle9KvmU=; b=xW6D4lMlYL2nux6N7lJzvPhFn6
	6w05v5QURAASVjhefoo0yxy7sX137xwJXt13bIZTPkKDvNYcQtQtqtCEvp8TRfjpwOA1ebTuFqoLs
	0pBDuNIKKC4Gf7GURZSOwpiafB8azZn/r5AZKaPa80c1GjU+6mwspw8C+3UL9OV1kcfMR5UjCOPaj
	IZmVNvQi5YJXXxqg948HO7kga1VuFmUnOKFLSkIb9vZyr6Yid14XbJGADUIGamfFTJtmdYYemluGF
	nzP9nh3mvAfJj5Z6R0q2hVj4pMj5iQQS1XzBmBrc1/2/n3dsIYQcZ9egn7j7a7lYiwiff4r7JXGaw
	5BA22TbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXhAp-0000000EdPl-1Knh;
	Fri, 04 Jul 2025 14:13:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXgon-0000000EZzL-23FK
	for linux-nvme@bombadil.infradead.org;
	Fri, 04 Jul 2025 13:51:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=46sPtIpQNa6qMl4WxST8GLbvaP56ktZh9MaOle9KvmU=; b=L0Ut92Aq/CaIOBnvGIKdL3OnA2
	oqN4/s3CXK8Y5rMkOE/eycSr/DDeCGC6EtAOuiGYmBbvm4X95MJBD+iGkliFIJHFQ4nY3jpBmv83a
	dA19Sh1GJs2NE5sh+7N5F3JVxNYxDJoP03yqPyMvnMJeOBSb3xDk2j9MzYWzDz2MF5nYwKydyXng7
	0CUnps0Qu1oEVwxZgD23lovmg/J/fJYQkPON37kFLdP85hjU30LQWn657c4YB6EOKJRUNX39O9xRp
	OKlHrI8Q5JOOSoIEdfKUv1qy3AIn0aWfLRswRcpspUCxXg/M0HS3fm42AbujS/RMTqF/g7HQUK7xh
	Z5WB5Z9Q==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXgoi-00000007zwI-1d95
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 13:51:08 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564A9HgW026097;
	Fri, 4 Jul 2025 13:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=46sPtIpQNa6qMl4Wx
	ST8GLbvaP56ktZh9MaOle9KvmU=; b=Eplol0GA3VdlVc+u1+dY4iS7cu/WA0y7k
	j5zVEWnjL7Quc3fjj9nvPFWCNQuEyI8W7phmrwO3lt+zqSkZn/r9VAFhJ7d86abv
	bCF6LpukIzHO9qMSVrWg9v/hAdevSzGm5iBRX/TcNBnDhhtkB624vBfl4s7Dd/tu
	H7uEDen4h/zQgP85+AIwbNLG1zXQ8gyFSmUckw75ptaxgeZdqyv48zCpfJIjB/7c
	jPbzg7LBCez8T7C0dReH7rtwEa5PCZTHR3nszYzvNhqQ0ICZ6r9RfPf3zjlxWZrO
	0RE3KUR47xM1Ysx0rf7mQjgyMyCtEklcroxR/bcR21F3nIqfH17nQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j82g9e8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 13:50:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 564CdF5R021361;
	Fri, 4 Jul 2025 13:50:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jwe3stsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 13:50:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 564DoUW329753642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Jul 2025 13:50:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73E4720043;
	Fri,  4 Jul 2025 13:50:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D7D920040;
	Fri,  4 Jul 2025 13:50:27 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.81.118])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Jul 2025 13:50:26 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCH 2/2] nvme: extend show-topology command to add support for multipath
Date: Fri,  4 Jul 2025 19:19:54 +0530
Message-ID: <20250704135001.292763-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704135001.292763-1-nilay@linux.ibm.com>
References: <20250704135001.292763-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zN-usB4R7Xdy6CB2c8CQAbBvDLcFTwmD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNSBTYWx0ZWRfXzdZqQbEnwZWw tBdXVD1+Q71DqMS7wlLUf+ISODbyo80/IanaAnltqJ2oKvVAlHi10r6jbSiseCyYLryiFhHvrC0 nseAUFWS4JR73AS7qw3WbgkDGuAItvYfolYrAE6v5+rp9pwAH0NUr9NzZW8gAEhCOlwLYSjCuN2
 bck2JDGRyuZx4cJoFBJINQO0me1ouO/Jkj6yk/hjhTSBiJtB7++8K3yllqg6SPVjBVrKbc+6MIe Ykkxub+pwwJBXA5UmapZqDa9NDaUM13u3JZiR4OP8HFaBJ3IonBwz7amonPR6brG8XTXIO2ZVPk Q8EdrvWjmzLqpWtev+VOBcKpnVjWzZlDLr59npk5gH7QnjCcQQTqq9pEeFvn/OsFSL4CHDe9ped
 FDNlEyC7A69Rv2vHbGnWus4VKP06FRKqirHTFdSVatWifyLp7q9QwPcd32FuX93hN2kRgVWH
X-Authority-Analysis: v=2.4 cv=LpeSymdc c=1 sm=1 tr=0 ts=6867dc29 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=Wb1JkmetP80A:10 a=2J7IuT7wAAAA:8 a=VnNF1IyMAAAA:8 a=gRtPFpPTdgpovcS1-QwA:9 a=RtgRkGnnZwJf8nmJIBi8:22
X-Proofpoint-GUID: zN-usB4R7Xdy6CB2c8CQAbBvDLcFTwmD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507040105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_145104_889213_93CEC823 
X-CRM114-Status: GOOD (  25.91  )
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
controller/port NVMe disk using:

$ nvme show-topology -r multipath

nvme-subsys2 - NQN=nvmet_subsystem
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
               iopolicy=numa

          _ _ _<head-node>
         /              _ _ _ <ana-state>
        /              /      _ _ _ <numa-node-list>
       /              /      /  _ _ _<queue-depth>
      |              /      /  /
 +- nvme2n1 (ns 1)  /      /  /
 \                 |      |  |
  +- nvme2c2n1 optimized 1,2 0 nvme2 tcp traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live
  +- nvme2c3n1 optimized 3,4 0 nvme3 tcp traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live

Please note that the headers shown above (e.g., <numa-node-list>,
<ana-state>, <hed-node>, and <queue-depth>) are included for clarity
only and are not part of the actual output.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 nvme-print-binary.c |  1 +
 nvme-print-json.c   | 25 ++++++++++++++++------
 nvme-print-stdout.c | 52 +++++++++++++++++++++++++++++++++++++++++----
 nvme-print.c        |  4 +++-
 nvme-print.h        |  1 +
 nvme.c              |  4 +++-
 nvme.h              |  1 +
 7 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/nvme-print-binary.c b/nvme-print-binary.c
index ec86e386..3ecdda01 100644
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
index bbb948f5..8967aefa 100644
--- a/nvme-print-json.c
+++ b/nvme-print-json.c
@@ -4538,19 +4538,30 @@ static unsigned int json_subsystem_topology_multipath(nvme_subsystem_t s,
 
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
+			obj_add_str(path_attrs, "NUMANodes", nvme_path_get_numa_nodes(p));
+			obj_add_int(path_attrs, "Qdepth", nvme_path_get_queue_depth(p));
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
@@ -4575,6 +4586,7 @@ static void json_print_nvme_subsystem_topology(nvme_subsystem_t s,
 
 			ns_attrs = json_create_object();
 			obj_add_int(ns_attrs, "NSID", nvme_ns_get_nsid(n));
+			obj_add_str(ns_attrs, "Name", nvme_ns_get_name(n));
 
 			ctrl = json_create_array();
 			ctrl_attrs = json_create_object();
@@ -5334,6 +5346,7 @@ static struct print_ops json_print_ops = {
 	.print_nvme_subsystem_list	= json_print_nvme_subsystem_list,
 	.topology_ctrl			= json_simple_topology,
 	.topology_namespace		= json_simple_topology,
+	.topology_multipath		= json_simple_topology,
 
 	/* status and error messages */
 	.connect_msg			= json_connect_msg,
diff --git a/nvme-print-stdout.c b/nvme-print-stdout.c
index 2c97abd7..f163eb29 100644
--- a/nvme-print-stdout.c
+++ b/nvme-print-stdout.c
@@ -1110,6 +1110,8 @@ static void stdout_subsys_config(nvme_subsystem_t s)
 	       nvme_subsystem_get_nqn(s));
 	printf("%*s   hostnqn=%s\n", len, " ",
 	       nvme_host_get_hostnqn(nvme_subsystem_get_host(s)));
+	printf("%*s   iopolicy=%s\n", len, " ",
+		nvme_subsystem_get_iopolicy(s));
 
 	if (stdout_print_ops.flags & VERBOSE) {
 		printf("%*s   model=%s\n", len, " ",
@@ -1118,8 +1120,6 @@ static void stdout_subsys_config(nvme_subsystem_t s)
 			nvme_subsystem_get_serial(s));
 		printf("%*s   firmware=%s\n", len, " ",
 			nvme_subsystem_get_fw_rev(s));
-		printf("%*s   iopolicy=%s\n", len, " ",
-			nvme_subsystem_get_iopolicy(s));
 		printf("%*s   type=%s\n", len, " ",
 			nvme_subsystem_get_type(s));
 	}
@@ -5611,7 +5611,7 @@ static void stdout_subsystem_topology_multipath(nvme_subsystem_t s,
 				       nvme_path_get_ana_state(p));
 			}
 		}
-	} else {
+	} else if (ranking == NVME_CLI_TOPO_CTRL) {
 		/* NVME_CLI_TOPO_CTRL */
 		nvme_subsystem_for_each_ctrl(s, c) {
 			printf(" +- %s %s %s\n",
@@ -5632,6 +5632,27 @@ static void stdout_subsystem_topology_multipath(nvme_subsystem_t s,
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
+				printf("  +- %s %s %s %d %s %s %s %s\n",
+						nvme_path_get_name(p),
+						nvme_path_get_ana_state(p),
+						nvme_path_get_numa_nodes(p),
+						nvme_path_get_queue_depth(p),
+						nvme_ctrl_get_name(c),
+						nvme_ctrl_get_transport(c),
+						nvme_ctrl_get_address(c),
+						nvme_ctrl_get_state(c));
+			}
+		}
 	}
 }
 
@@ -5653,7 +5674,7 @@ static void stdout_subsystem_topology(nvme_subsystem_t s,
 				       nvme_ctrl_get_state(c));
 			}
 		}
-	} else {
+	} else if (ranking == NVME_CLI_TOPO_CTRL) {
 		/* NVME_CLI_TOPO_CTRL */
 		nvme_subsystem_for_each_ctrl(s, c) {
 			printf(" +- %s %s %s\n",
@@ -5667,6 +5688,23 @@ static void stdout_subsystem_topology(nvme_subsystem_t s,
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
 
@@ -5713,6 +5751,11 @@ static void stdout_topology_ctrl(nvme_root_t r)
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
@@ -6140,6 +6183,7 @@ static struct print_ops stdout_print_ops = {
 	.print_nvme_subsystem_list	= stdout_subsystem_list,
 	.topology_ctrl			= stdout_topology_ctrl,
 	.topology_namespace		= stdout_topology_namespace,
+	.topology_multipath		= stdout_topology_multipath,
 
 	/* status and error messages */
 	.connect_msg			= stdout_connect_msg,
diff --git a/nvme-print.c b/nvme-print.c
index 742999fd..f243dee9 100644
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
index 7329f0ae..4035c80a 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -105,6 +105,7 @@ struct print_ops {
 	void (*print_nvme_subsystem_list)(nvme_root_t r, bool show_ana);
 	void (*topology_ctrl)(nvme_root_t r);
 	void (*topology_namespace)(nvme_root_t r);
+	void (*topology_multipath)(nvme_root_t r);
 
 	/* status and error messages */
 	void (*connect_msg)(nvme_ctrl_t c);
diff --git a/nvme.c b/nvme.c
index 772ab000..53a29d22 100644
--- a/nvme.c
+++ b/nvme.c
@@ -10056,7 +10056,7 @@ static int tls_key(int argc, char **argv, struct command *command, struct plugin
 static int show_topology_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
 	const char *desc = "Show the topology\n";
-	const char *ranking = "Ranking order: namespace|ctrl";
+	const char *ranking = "Ranking order: namespace|ctrl|multipath";
 	nvme_print_flags_t flags;
 	_cleanup_nvme_root_ nvme_root_t r = NULL;
 	char *devname = NULL;
@@ -10092,6 +10092,8 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
 		rank = NVME_CLI_TOPO_NAMESPACE;
 	} else if (!strcmp(cfg.ranking, "ctrl")) {
 		rank = NVME_CLI_TOPO_CTRL;
+	} else if (!strcmp(cfg.ranking, "multipath")) {
+		rank = NVME_CLI_TOPO_MULTIPATH;
 	} else {
 		nvme_show_error("Invalid ranking argument: %s", cfg.ranking);
 		return -EINVAL;
diff --git a/nvme.h b/nvme.h
index 1a15fc18..c61aea6c 100644
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
2.50.0


