Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539C0C83F25
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 11:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ffqk758yfMgakus/g7hrUBY9GZejedFuupaOflqN184=; b=vCp5VR1g7sDJ6XJKwDJ3vxTnTg
	UQnMxpPY5UXOGAm2S/OZH6tt4mOVoMG75qpHOETAnKfYYXB+tbccakkuSjqsXvsi93UVX/t4lvbRO
	vGkTUzYOTRhYms2SaEMn4+ZYnATqZw6cnxFp/ZVphVzlHMU3CKoBQ73UAea2LESAKp158XXZQTqj0
	Kh7ENgjF8tYA3swRHS7edbKm9upbb0X9Sxc2UkwPcTUPvqAFhRmJndFUM1b9UkZYaFZHDx7pvK5Dc
	WWQQxBDGPR8IDO+1uIgZ9Hq78e4HgviU+A/8GKljf/6PxXVAYwLr3+mqdrCrmokuAhVeHBtUJHj0C
	Q2hRJvIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udos0-0000000H82J-1gy4;
	Mon, 21 Jul 2025 11:39:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udnmN-0000000GxmU-28iB
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 10:29:57 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L0oA49014671;
	Mon, 21 Jul 2025 10:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Ffqk758yfMgakus/g7hrUBY9GZejedFuupaOflqN1
	84=; b=mXlVMXN7pKzdkDAkgm4aEMRgdmjeTonp0I4dexMH/HhjQ4RgO0xWWvcCj
	g2MiaV4/yHl9r4nsGP4wl5E0OGCd6M4KTKBqCFxFC+sdOUnsdbudWnRhXVbl0Q+6
	OL6vfOVXHRPr01w9JBwisfbbfSqgXPjSd58K4+oHuFiHo+sDVN9qOD+31vxNbsNr
	Z7thI0+uU8Fb4Ew7EuvKVls/gIBxRG75t8755fj8O8IKQpfOPj6RT3BbMQdS4jxb
	F8fW4N8mTN3AGz9DCiRXwsWG59KALrzzSMhV3v52Um1+MVkig0far0iD0lG/YWhT
	2ncwhQujoQL1ZgJIBzisoybfj47pg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v82k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 10:29:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56L8BFFx012401;
	Mon, 21 Jul 2025 10:29:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480p2ywrc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 10:29:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56LAToS152494696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 10:29:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF41720043;
	Mon, 21 Jul 2025 10:29:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2EC120040;
	Mon, 21 Jul 2025 10:29:48 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.127.174])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Jul 2025 10:29:48 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, msmurthy@imap.linux.ibm.com, gjoyce@ibm.com
Subject: [PATCH] nvme-list: fix verbose JSON output for 'nvme list' command
Date: Mon, 21 Jul 2025 15:59:11 +0530
Message-ID: <20250721102946.1003295-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uT2xvBZBWe3wC98bG56A2W475IGqcL2N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA4OSBTYWx0ZWRfXyxb8U8E/AfGV
 7fpByp+ZbvdRDmJ+C+aEAvLeX6B0Y8hinc2dJp9+bl9B8EkmuwN6ojkAZ8Ev8lamIrtYNDQHmAx
 yrSR4byNPRUAApDFS3OUUeK3wR8oXLzLjc8KthvnQEFdpqsr4pbsDRm95yXyySB0SMzSSuLpf2a
 3C3HyppJYjq47uJbV6HldCMLxri/9+VrqmX9z3h8tGL0+Y0as3T/u8eRhcVZfmIdI6EseHZfku4
 F1vR+VGR+kIGbb0JevKWzT/3+T06izONOC7L+eTOwpQxEws8upGOv7TO/+OrJp6PuHaeMHQHBmB
 Ju8/aM+Ziho7/u8PowJceUnaS6TkxYTPDjodVV1f9R6kxt9+RtfC3itJJtPJT6kXJUjQLWChJZI
 dYnTHu6/4LUNofDUpeapYtVhyGTuJz9kL6V0R0Q283fLTZucoZuttpNZ+ZBM6yZ0GYlLzk4v
X-Proofpoint-ORIG-GUID: uT2xvBZBWe3wC98bG56A2W475IGqcL2N
X-Authority-Analysis: v=2.4 cv=JJQ7s9Kb c=1 sm=1 tr=0 ts=687e16a2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=2GHvWUsK5_g8hds5z6kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 mlxscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_032955_905844_79669101 
X-CRM114-Status: GOOD (  21.10  )
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

The verbose JSON output of the nvme list command is currently incorrect in
both multipath and non-multipath configurations. Specifically, it prints
empty Namespaces[] and Paths[] arrays in the wrong places, leading to
confusion and invalid output. For example, on a system with single NVMe
disk, signle controller and one namepsace created, 'nvme list --verbose
--output json' prints the following output:

With multipath disabled:

{
  "Devices":[
    {
      ...
      "Subsystems":[
        {
          ...
          "Controllers":[
            {
              "Controller":"nvme0",
	      ...
              "Namespaces":[
                {
                  "NameSpace":"nvme0n1",
		  ...
                }
              ],
              "Paths":[] <---- Incorrct: Path should not be present
            }
          ],
          "Namespaces":[] <-----Incorrect: Namespaces should not be here
        }
      ]
    }
  ]
}

With multipath enabled, the output changes, but still has misplaced or
empty fields:

{
  "Devices":[
    {
      ...
      "Subsystems":[
        {
          ...
          "Controllers":[
            {
              "Controller":"nvme0",
	      ...
              "Namespaces":[] <-----Incorrect: Namespaces should not be here
              "Paths":[
                {
                  "Path":"nvme0c0n1",
                  "ANAState":"optimized"
                }
              ]
            }
          ],
          "Namespaces":[
            {
              "NameSpace":"nvme0n1",
	      ...
            }
          ]
        }
      ]
    }
  ]
}

So as we could see above in both multipath and non-multipath scenarios,
the JSON formatted output is incorrect.

The existing JSON formatting logic doesn't differentiate between multipath
and non-multipath configurations. As a result:
- "Paths" is printed even when multipath is disabled.
- "Namespaces" appear at incorrect levels in the output tree.

This patch updates the logic for verbose JSON output in nvme list to
properly reflect the system configuration:
- When multipath is enabled, each namespace entry includes its associated
  paths and controller attributes.
- When multipath is disabled, namespaces are shown directly under the
  controller, and the "Paths" array is omitted.

After this fix, JSON formatted output looks as below:

Scenario1:  multipath is enabled
{
  Devices: [
    {
      ...
      Subsystems: [
        {
          ...
          Namespaces: [
	    {
	      "NameSpace":"nvme0n1",
	      ...
	      Paths: [
                {
                  "Path":"nvme0c0n1",
		  "ANAState":"optimized",
		  "Controller":"nvme0",
                  ...
		}
	      ]
            }
	  ]
        }
      ]
    }
  ]
}

Scenario2: multipath is disabled
{
  Devices: [
    {
      ...
      Subsystems: [
        {
          ...
	  Controllers: [
	    {
              "Controller":"nvme0",
	      ...
              "Namespaces":[
	        {
                  "NameSpace":"nvme0n1",
		  ...
		}
	      ]
	    }
	  ]
        }
      ]
    }
  ]
}
This fix ensures the JSON output is semantically accurate and easier to
consume by tools that parse nvme list --verbose --output json.

Reported-by: Maram Srimannarayana Murthy <msmurthy@imap.linux.ibm.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 nvme-print-json.c   | 170 ++++++++++++++++++++++++++------------------
 nvme-print-stdout.c |  12 ----
 nvme.h              |  12 ++++
 3 files changed, 113 insertions(+), 81 deletions(-)

diff --git a/nvme-print-json.c b/nvme-print-json.c
index a4b8df9f..3d656baa 100644
--- a/nvme-print-json.c
+++ b/nvme-print-json.c
@@ -4423,6 +4423,103 @@ static void json_support_log(struct nvme_supported_log_pages *support_log,
 	json_print(r);
 }
 
+static void json_print_detail_list_multipath(nvme_subsystem_t s,
+		struct json_object *jss)
+{
+	nvme_ns_t n;
+	nvme_path_t p;
+	struct json_object *jnss = json_create_array();
+
+	nvme_subsystem_for_each_ns(s, n) {
+		struct json_object *jns = json_create_object();
+		struct json_object *jpaths = json_create_array();
+
+		int lba = nvme_ns_get_lba_size(n);
+		uint64_t nsze = nvme_ns_get_lba_count(n) * lba;
+		uint64_t nuse = nvme_ns_get_lba_util(n) * lba;
+
+		obj_add_str(jns, "NameSpace", nvme_ns_get_name(n));
+		obj_add_str(jns, "Generic", nvme_ns_get_generic_name(n));
+		obj_add_int(jns, "NSID", nvme_ns_get_nsid(n));
+		obj_add_uint64(jns, "UsedBytes", nuse);
+		obj_add_uint64(jns, "MaximumLBA", nvme_ns_get_lba_count(n));
+		obj_add_uint64(jns, "PhysicalSize", nsze);
+		obj_add_int(jns, "SectorSize", lba);
+
+		nvme_namespace_for_each_path(n, p) {
+			nvme_ctrl_t c;
+			struct json_object *jpath = json_create_object();
+
+			obj_add_str(jpath, "Path", nvme_path_get_name(p));
+			obj_add_str(jpath, "ANAState", nvme_path_get_ana_state(p));
+
+			/*
+			 * For multipath, each path maps to one controller.
+			 * So get the controller from the path and then add
+			 * controller  attributes.
+			 */
+			c = nvme_path_get_ctrl(p);
+			obj_add_str(jpath, "Controller", nvme_ctrl_get_name(c));
+			obj_add_str(jpath, "Cntlid", nvme_ctrl_get_cntlid(c));
+			obj_add_str(jpath, "SerialNumber", nvme_ctrl_get_serial(c));
+			obj_add_str(jpath, "ModelNumber", nvme_ctrl_get_model(c));
+			obj_add_str(jpath, "Firmware", nvme_ctrl_get_firmware(c));
+			obj_add_str(jpath, "Transport", nvme_ctrl_get_transport(c));
+			obj_add_str(jpath, "Address", nvme_ctrl_get_address(c));
+			obj_add_str(jpath, "Slot", nvme_ctrl_get_phy_slot(c));
+
+			array_add_obj(jpaths, jpath);
+		}
+
+		obj_add_obj(jns, "Paths", jpaths);
+		array_add_obj(jnss, jns);
+	}
+	obj_add_obj(jss, "Namespaces", jnss);
+}
+
+static void json_print_detail_list(nvme_subsystem_t s, struct json_object *jss)
+{
+	nvme_ctrl_t c;
+	nvme_ns_t n;
+	struct json_object *jctrls = json_create_array();
+
+	nvme_subsystem_for_each_ctrl(s, c) {
+		struct json_object *jctrl = json_create_object();
+		struct json_object *jnss = json_create_array();
+
+		obj_add_str(jctrl, "Controller", nvme_ctrl_get_name(c));
+		obj_add_str(jctrl, "Cntlid", nvme_ctrl_get_cntlid(c));
+		obj_add_str(jctrl, "SerialNumber", nvme_ctrl_get_serial(c));
+		obj_add_str(jctrl, "ModelNumber", nvme_ctrl_get_model(c));
+		obj_add_str(jctrl, "Firmware", nvme_ctrl_get_firmware(c));
+		obj_add_str(jctrl, "Transport", nvme_ctrl_get_transport(c));
+		obj_add_str(jctrl, "Address", nvme_ctrl_get_address(c));
+		obj_add_str(jctrl, "Slot", nvme_ctrl_get_phy_slot(c));
+
+		nvme_ctrl_for_each_ns(c, n) {
+			struct json_object *jns = json_create_object();
+			int lba = nvme_ns_get_lba_size(n);
+			uint64_t nsze = nvme_ns_get_lba_count(n) * lba;
+			uint64_t nuse = nvme_ns_get_lba_util(n) * lba;
+
+			obj_add_str(jns, "NameSpace", nvme_ns_get_name(n));
+			obj_add_str(jns, "Generic", nvme_ns_get_generic_name(n));
+			obj_add_int(jns, "NSID", nvme_ns_get_nsid(n));
+			obj_add_uint64(jns, "UsedBytes", nuse);
+			obj_add_uint64(jns, "MaximumLBA", nvme_ns_get_lba_count(n));
+			obj_add_uint64(jns, "PhysicalSize", nsze);
+			obj_add_int(jns, "SectorSize", lba);
+
+			array_add_obj(jnss, jns);
+		}
+
+		obj_add_obj(jctrl, "Namespaces", jnss);
+		array_add_obj(jctrls, jctrl);
+	}
+
+	obj_add_obj(jss, "Controllers", jctrls);
+}
+
 static void json_detail_list(nvme_root_t t)
 {
 	struct json_object *r = json_create_object();
@@ -4430,9 +4527,6 @@ static void json_detail_list(nvme_root_t t)
 
 	nvme_host_t h;
 	nvme_subsystem_t s;
-	nvme_ctrl_t c;
-	nvme_path_t p;
-	nvme_ns_t n;
 
 	nvme_for_each_host(t, h) {
 		struct json_object *hss = json_create_object();
@@ -4446,76 +4540,14 @@ static void json_detail_list(nvme_root_t t)
 
 		nvme_for_each_subsystem(h, s) {
 			struct json_object *jss = json_create_object();
-			struct json_object *jctrls = json_create_array();
-			struct json_object *jnss = json_create_array();
 
 			obj_add_str(jss, "Subsystem", nvme_subsystem_get_name(s));
 			obj_add_str(jss, "SubsystemNQN", nvme_subsystem_get_nqn(s));
 
-			nvme_subsystem_for_each_ctrl(s, c) {
-				struct json_object *jctrl = json_create_object();
-				struct json_object *jnss = json_create_array();
-				struct json_object *jpaths = json_create_array();
-
-				obj_add_str(jctrl, "Controller", nvme_ctrl_get_name(c));
-				obj_add_str(jctrl, "Cntlid", nvme_ctrl_get_cntlid(c));
-				obj_add_str(jctrl, "SerialNumber", nvme_ctrl_get_serial(c));
-				obj_add_str(jctrl, "ModelNumber", nvme_ctrl_get_model(c));
-				obj_add_str(jctrl, "Firmware", nvme_ctrl_get_firmware(c));
-				obj_add_str(jctrl, "Transport", nvme_ctrl_get_transport(c));
-				obj_add_str(jctrl, "Address", nvme_ctrl_get_address(c));
-				obj_add_str(jctrl, "Slot", nvme_ctrl_get_phy_slot(c));
-
-				nvme_ctrl_for_each_ns(c, n) {
-					struct json_object *jns = json_create_object();
-					int lba = nvme_ns_get_lba_size(n);
-					uint64_t nsze = nvme_ns_get_lba_count(n) * lba;
-					uint64_t nuse = nvme_ns_get_lba_util(n) * lba;
-
-					obj_add_str(jns, "NameSpace", nvme_ns_get_name(n));
-					obj_add_str(jns, "Generic", nvme_ns_get_generic_name(n));
-					obj_add_int(jns, "NSID", nvme_ns_get_nsid(n));
-					obj_add_uint64(jns, "UsedBytes", nuse);
-					obj_add_uint64(jns, "MaximumLBA", nvme_ns_get_lba_count(n));
-					obj_add_uint64(jns, "PhysicalSize", nsze);
-					obj_add_int(jns, "SectorSize", lba);
-
-					array_add_obj(jnss, jns);
-				}
-				obj_add_obj(jctrl, "Namespaces", jnss);
-
-				nvme_ctrl_for_each_path(c, p) {
-					struct json_object *jpath = json_create_object();
-
-					obj_add_str(jpath, "Path", nvme_path_get_name(p));
-					obj_add_str(jpath, "ANAState", nvme_path_get_ana_state(p));
-
-					array_add_obj(jpaths, jpath);
-				}
-				obj_add_obj(jctrl, "Paths", jpaths);
-
-				array_add_obj(jctrls, jctrl);
-			}
-			obj_add_obj(jss, "Controllers", jctrls);
-
-			nvme_subsystem_for_each_ns(s, n) {
-				struct json_object *jns = json_create_object();
-
-				int lba = nvme_ns_get_lba_size(n);
-				uint64_t nsze = nvme_ns_get_lba_count(n) * lba;
-				uint64_t nuse = nvme_ns_get_lba_util(n) * lba;
-
-				obj_add_str(jns, "NameSpace", nvme_ns_get_name(n));
-				obj_add_str(jns, "Generic", nvme_ns_get_generic_name(n));
-				obj_add_int(jns, "NSID", nvme_ns_get_nsid(n));
-				obj_add_uint64(jns, "UsedBytes", nuse);
-				obj_add_uint64(jns, "MaximumLBA", nvme_ns_get_lba_count(n));
-				obj_add_uint64(jns, "PhysicalSize", nsze);
-				obj_add_int(jns, "SectorSize", lba);
-
-				array_add_obj(jnss, jns);
-			}
-			obj_add_obj(jss, "Namespaces", jnss);
+			if (nvme_is_multipath(s))
+				json_print_detail_list_multipath(s, jss);
+			else
+				json_print_detail_list(s, jss);
 
 			array_add_obj(jsslist, jss);
 		}
diff --git a/nvme-print-stdout.c b/nvme-print-stdout.c
index 7943b91c..52d8d2b1 100644
--- a/nvme-print-stdout.c
+++ b/nvme-print-stdout.c
@@ -5589,18 +5589,6 @@ static void stdout_list_items(nvme_root_t r)
 		stdout_simple_list(r);
 }
 
-static bool nvme_is_multipath(nvme_subsystem_t s)
-{
-	nvme_ns_t n;
-	nvme_path_t p;
-
-	nvme_subsystem_for_each_ns(s, n)
-		nvme_namespace_for_each_path(n, p)
-			return true;
-
-	return false;
-}
-
 static void stdout_subsystem_topology_multipath(nvme_subsystem_t s,
 						     enum nvme_cli_topo_ranking ranking)
 {
diff --git a/nvme.h b/nvme.h
index 1a15fc18..248c5c7c 100644
--- a/nvme.h
+++ b/nvme.h
@@ -122,6 +122,18 @@ static inline nvme_mi_ep_t dev_mi_ep(struct nvme_dev *dev)
 	return dev->mi.ep;
 }
 
+static inline bool nvme_is_multipath(nvme_subsystem_t s)
+{
+	nvme_ns_t n;
+	nvme_path_t p;
+
+	nvme_subsystem_for_each_ns(s, n)
+		nvme_namespace_for_each_path(n, p)
+			return true;
+
+	return false;
+}
+
 void register_extension(struct plugin *plugin);
 
 /*
-- 
2.50.1


