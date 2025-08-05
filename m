Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790B2C87FCB
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Aug 2025 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GbJHeHv9ImA8ntWSJfJStN4Uup1txyUrgvzPj5isLsY=; b=wPlonY33w+vxinsQp89wnQw/Ya
	agnfkMX0D2hjuqdz4Ti2GCgB6CVbJn8VpznN87WCi/+UZlDFoV3BYZyDeGfa78tt/n3nzWcuVkB5y
	pCJEtA3Gnm8yvZC9T93NvjYkT9f9Ejlx+Gw9zjf6t8J1BXrSYr6VLVEHfQqhIgrkVvkdXECGHsW8M
	LpJQHwigXg3BaqLDPUIOOZzhO6+uYyRldqHotQVDie5YGiFDLHGJr9LOZPkK5vgQ/PACpWWWIlAe0
	AvF011DBOb2no/+MvR+vhltN1eIDLlmsX/fvbyrEIE/LYk/OVrDnLnlcQvfWR+kNDYwUlaFjwqmzq
	jaKr2ZOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujF3z-0000000CVZn-3MU4;
	Tue, 05 Aug 2025 10:38:35 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujEn0-0000000CTM7-27dl
	for linux-nvme@lists.infradead.org;
	Tue, 05 Aug 2025 10:21:03 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575AACdf023015;
	Tue, 5 Aug 2025 10:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GbJHeHv9ImA8ntWSJfJStN4Uup1txyUrgvzPj5isL
	sY=; b=RU31h2r99StYGi5OhA0ovAr2TJ5QLqFoGYjwSk3safbBFKR2L8CKhLzxj
	Vjk+3z9OXWgYebI6H8oVUZQGOu5Iq0VslBy3BOWHgkwRZ4j11idC2ZTLf0b7inK6
	dDkABQs93EauXdNBZIBraRVkYzabqXBHCwEL/6/Qp3yOmHF+y4k8J3zkzmIbnDWH
	MBCRK9VgLJy+Mr7Zb7GnyXP2TvqhTOLw/aPhDRoQuGrSDqUOR8h8EXXjCTAPD5n7
	W5t6ZJBKqVNpuAK7EB4Fd3XhZQ3fPy8ISpBz+rpCeU8yzwTRXQ5jhiK6hCjfdQG6
	Vtu2uKJZEr85QMDZZ3quiVbq1Xfgw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ac0ws8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 10:21:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5758USRx009767;
	Tue, 5 Aug 2025 10:21:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 489w0tj3y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 10:21:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575AKwGq42992028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 10:20:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C10A72004B;
	Tue,  5 Aug 2025 10:20:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02EE220040;
	Tue,  5 Aug 2025 10:20:57 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.82.116])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 10:20:56 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, msmurthy@imap.linux.ibm.com, gjoyce@ibm.com,
        tbzatek@redhat.com
Subject: [PATCH] nvme-list: make verbose JSON output backward compatible
Date: Tue,  5 Aug 2025 15:50:50 +0530
Message-ID: <20250805102055.3375272-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l2h1jp0zSBSZfW21oNYTHkDCwlc-9CkQ
X-Proofpoint-ORIG-GUID: l2h1jp0zSBSZfW21oNYTHkDCwlc-9CkQ
X-Authority-Analysis: v=2.4 cv=GNoIEvNK c=1 sm=1 tr=0 ts=6891db0d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=3QMLT-GTeQI6B25mFQcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA3MSBTYWx0ZWRfX1JPnp+RepAq/
 XhQAJRJrTe9a+04TcF934TZdsgmkR+yQNXrCNerdoGbqj0NgmLz0qtn+E7xg9G+ZZbiM1qCe90C
 xJefKHrLbxPzWmPr63cEIUNR7msbK2K2i36M7tpSERCefq8Kth8b8G9L5vPlc1UmR+626OprH0D
 4kgA4p4Wz8+6lNxZGhr8VuJUBavtk2jfwJr4CHNK3YXp9P7D6wOL7GpZrQ4SqDNS6Sy6zQOwnLG
 ra842P0Z0m6WE+yTZUneKe9xHUHkVt+F8jzG6Owo+v8O/nVPvG5FF3rvRyIQc58Miud/H9KEVn3
 wPrL7c5ydjbdVTzevVWjefPY89FLX9FoyMfpE3uyRL0Zv0TsPfjLRaVwUAFtX3XTJw16eA/scaL
 mqrCRdfy2fuaHO/y7sL+ymrLrIsHcRBWqZZAMXa1Dst7tkdGTtwzdqiiwYSM3E/LHVRNCzeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_032102_551795_99928DB8 
X-CRM114-Status: GOOD (  18.04  )
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

The commit 64bed0a87a23 ("nvme-list: fix verbose JSON output for 'nvme
list' command") changed the JSON output format of the nvme list --verbose
command. While the new format is more structured, it introduced a
regression by breaking compatibility with tools and scripts relying on
the previous JSON schema.

So to restore backward compatibility, we now leverage the existing
--output-format-version option. With this patch,
1. The default --output-format-version=1 retains the original (legacy) JSON
format for nvme list --verbose.
2. If the user explicitly sets --output-format-version=2 then the newer
JSON structure introduced by commit 64bed0a87a23 ("nvme-list: fix verbose
JSON output for 'nvme list' command") is used.

This ensures that existing users and automation relying on the older format
do not break, while still supporting the newer schema for forward-looking
users.

Fixes: 64bed0a87a23 ("nvme-list: fix verbose JSON output for 'nvme list' command")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 nvme-print-json.c | 117 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 4 deletions(-)

diff --git a/nvme-print-json.c b/nvme-print-json.c
index 11b66616..829ba718 100644
--- a/nvme-print-json.c
+++ b/nvme-print-json.c
@@ -4519,7 +4519,7 @@ static void json_print_detail_list(nvme_subsystem_t s, struct json_object *jss)
 	obj_add_obj(jss, "Controllers", jctrls);
 }
 
-static void json_detail_list(nvme_root_t t)
+static void json_detail_list_v2(nvme_root_t t)
 {
 	struct json_object *r = json_create_object();
 	struct json_object *jdev = json_create_array();
@@ -4560,6 +4560,112 @@ static void json_detail_list(nvme_root_t t)
 	json_print(r);
 }
 
+static void json_detail_list(nvme_root_t t)
+{
+	struct json_object *r = json_create_object();
+	struct json_object *jdev = json_create_array();
+
+	nvme_host_t h;
+	nvme_subsystem_t s;
+	nvme_ctrl_t c;
+	nvme_path_t p;
+	nvme_ns_t n;
+
+	nvme_for_each_host(t, h) {
+		struct json_object *hss = json_create_object();
+		struct json_object *jsslist = json_create_array();
+		const char *hostid;
+
+		obj_add_str(hss, "HostNQN", nvme_host_get_hostnqn(h));
+		hostid = nvme_host_get_hostid(h);
+		if (hostid)
+			obj_add_str(hss, "HostID", hostid);
+
+		nvme_for_each_subsystem(h, s) {
+			struct json_object *jss = json_create_object();
+			struct json_object *jctrls = json_create_array();
+			struct json_object *jnss = json_create_array();
+
+			obj_add_str(jss, "Subsystem", nvme_subsystem_get_name(s));
+			obj_add_str(jss, "SubsystemNQN", nvme_subsystem_get_nqn(s));
+
+			nvme_subsystem_for_each_ctrl(s, c) {
+				struct json_object *jctrl = json_create_object();
+				struct json_object *jnss = json_create_array();
+				struct json_object *jpaths = json_create_array();
+
+				obj_add_str(jctrl, "Controller", nvme_ctrl_get_name(c));
+				obj_add_str(jctrl, "Cntlid", nvme_ctrl_get_cntlid(c));
+				obj_add_str(jctrl, "SerialNumber", nvme_ctrl_get_serial(c));
+				obj_add_str(jctrl, "ModelNumber", nvme_ctrl_get_model(c));
+				obj_add_str(jctrl, "Firmware", nvme_ctrl_get_firmware(c));
+				obj_add_str(jctrl, "Transport", nvme_ctrl_get_transport(c));
+				obj_add_str(jctrl, "Address", nvme_ctrl_get_address(c));
+				obj_add_str(jctrl, "Slot", nvme_ctrl_get_phy_slot(c));
+
+				nvme_ctrl_for_each_ns(c, n) {
+					struct json_object *jns = json_create_object();
+					int lba = nvme_ns_get_lba_size(n);
+					uint64_t nsze = nvme_ns_get_lba_count(n) * lba;
+					uint64_t nuse = nvme_ns_get_lba_util(n) * lba;
+
+					obj_add_str(jns, "NameSpace", nvme_ns_get_name(n));
+					obj_add_str(jns, "Generic", nvme_ns_get_generic_name(n));
+					obj_add_int(jns, "NSID", nvme_ns_get_nsid(n));
+					obj_add_uint64(jns, "UsedBytes", nuse);
+					obj_add_uint64(jns, "MaximumLBA", nvme_ns_get_lba_count(n));
+					obj_add_uint64(jns, "PhysicalSize", nsze);
+					obj_add_int(jns, "SectorSize", lba);
+
+					array_add_obj(jnss, jns);
+				}
+				obj_add_obj(jctrl, "Namespaces", jnss);
+
+				nvme_ctrl_for_each_path(c, p) {
+					struct json_object *jpath = json_create_object();
+
+					obj_add_str(jpath, "Path", nvme_path_get_name(p));
+					obj_add_str(jpath, "ANAState", nvme_path_get_ana_state(p));
+
+					array_add_obj(jpaths, jpath);
+				}
+				obj_add_obj(jctrl, "Paths", jpaths);
+
+				array_add_obj(jctrls, jctrl);
+			}
+			obj_add_obj(jss, "Controllers", jctrls);
+
+			nvme_subsystem_for_each_ns(s, n) {
+				struct json_object *jns = json_create_object();
+
+				int lba = nvme_ns_get_lba_size(n);
+				uint64_t nsze = nvme_ns_get_lba_count(n) * lba;
+				uint64_t nuse = nvme_ns_get_lba_util(n) * lba;
+
+				obj_add_str(jns, "NameSpace", nvme_ns_get_name(n));
+				obj_add_str(jns, "Generic", nvme_ns_get_generic_name(n));
+				obj_add_int(jns, "NSID", nvme_ns_get_nsid(n));
+				obj_add_uint64(jns, "UsedBytes", nuse);
+				obj_add_uint64(jns, "MaximumLBA", nvme_ns_get_lba_count(n));
+				obj_add_uint64(jns, "PhysicalSize", nsze);
+				obj_add_int(jns, "SectorSize", lba);
+
+				array_add_obj(jnss, jns);
+			}
+			obj_add_obj(jss, "Namespaces", jnss);
+
+			array_add_obj(jsslist, jss);
+		}
+
+		obj_add_obj(hss, "Subsystems", jsslist);
+		array_add_obj(jdev, hss);
+	}
+
+	obj_add_array(r, "Devices", jdev);
+
+	json_print(r);
+}
+
 static struct json_object *json_list_item_obj(nvme_ns_t n)
 {
 	struct json_object *r = json_create_object();
@@ -4622,9 +4728,12 @@ static void json_list_item(nvme_ns_t n)
 
 static void json_print_list_items(nvme_root_t t)
 {
-	if (verbose_mode())
-		json_detail_list(t);
-	else
+	if (json_print_ops.flags & VERBOSE) {
+		if (nvme_cfg.output_format_ver == 2)
+			json_detail_list_v2(t);
+		else
+			json_detail_list(t);
+	} else
 		json_simple_list(t);
 }
 
-- 
2.50.1

