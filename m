Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BBAC369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 18:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VjR1YGzXGBKHWT9A1aMsOLPxZabpQEMmKou0gE/Loz0=; b=3UdIsanq6rVK39pBx9B99K1ZN3
	PxPqgZusAKDB1NFJsdQnQVIWNLYKGOVFFnsUk6NObrot6mDBC4Ktr2q8uc571DkaPo/+f5rr0+bg6
	f+GKVJL09ekn4qMMVNNOz2kzfK6r00U/ld+JhfpPS6E4lUXjbIFFHsGcXLvQ0gwnbKfL7CF+xTA2N
	Avs08RcNSLQHWOj5ppb+iJcbLsjaKF5cN+RxDfraaV9kxCvdZVWPhbDtLH0SBH+TydXL/jVcoVvkU
	zlrWHeqMBjGdv3Uqb8Yuz6rBUrXjwYUPPCX6wVYtpWuQLwg8aDbOfWO40a2j8kyQf4owbU6uju5vs
	pfigiSuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8OE8-00000000ZrD-0BqA;
	Fri, 25 Apr 2025 18:56:44 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8OE3-00000000ZpA-2OrS
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 18:56:42 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAexni023255;
	Fri, 25 Apr 2025 18:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VjR1YGzXGBKHWT9A1
	aMsOLPxZabpQEMmKou0gE/Loz0=; b=baRveNmv311ZzJTtN91UUe06INnrsTNKW
	wtQ8PXdBdTEYY4Db/ctuHoVh5oZMh89VI/3nos++jUTxpGbjdE67S3AOzEwHh6Yf
	5vgLxGWFeCEh4O4hSamrYddIkz8MQcPlJ81YrxQaZ0AyfoLQKsl+ESwM9AWyj79l
	2H3nPcvzfsu0FXyDObE/QHTiCWmWQdejMNRGbDuA5VTlkjHiMuaEJpuPMSgELsIE
	kFIHSJJaqxlffK/BsP7Ob8t7ahyD+83xlaOkTTCILVijtgp7gg08WUNb4H+u8Hqj
	wngK3m4Dn/P7OKk2Cs17YDommPvXvSCvy4hDyBFUItbMFeM0NSNpQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4688usj9hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 18:56:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGYR7v001287;
	Fri, 25 Apr 2025 18:56:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfy6pre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 18:56:32 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PIuU4e57344470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 18:56:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8545720049;
	Fri, 25 Apr 2025 18:56:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B6E520040;
	Fri, 25 Apr 2025 18:56:28 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.102.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 18:56:28 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, dwagner@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv3 4/4] test: extend sysfs tree dump test
Date: Sat, 26 Apr 2025 00:26:09 +0530
Message-ID: <20250425185617.1242994-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425185617.1242994-1-nilay@linux.ibm.com>
References: <20250425185617.1242994-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=680bdae1 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=a1vP90hrAAAA:8 a=YwT4yjY9AAAA:8 a=8tcD0Gco8PB7GEA_TiIA:9 a=yN0aEeKadhAFZTPl5c5m:22
 a=e64QTKfuJ4O-NP4Vnnd6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEzMiBTYWx0ZWRfX+xlXHnYaIBDA jZvlVbFfbnyKMnr4iDEetrNIJkbQR0bY5paqh3vaLI6ImHxQnFgfab6hokBZvPAX9+QZeOeLoz+ dh/undyt619bBSyfKwlhKJSom8eehLJgueA8r/ZJt+r3ZydrjrljMV6Rg74ca1wUy+OL6cXXhMQ
 aKaCiqWvcMbsWvbRGm0V/OFfVol8Y16nXqrPJpo4yANojrl3C0GUdCZU/ta83IA5GDm1TpKWz0+ Y0SR67SjPi0dlcOC2L8swy63zgeG+lBB/vWxYJtW/hQss3L6ulKUUDV6KNZ0cb78LdPZypqeXXg 4fvMA9YXHuwGyWCthp+QEphNHoQOvjDkN/Mi00Sr+CvrfH0icRl2cj7Srzva+G3sbmMfxLc/Xem
 nSxm9RZmLu6SrEsfYkaT1S6ACBoIOjJZ59V58mO0VgMRPLbf4rulcOWIDLn/eJb3DDcfBCOo
X-Proofpoint-ORIG-GUID: r-aTmxCl3uJRuNBDJW3zaDGzlI6wa10v
X-Proofpoint-GUID: r-aTmxCl3uJRuNBDJW3zaDGzlI6wa10v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=952 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250132
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_115639_806875_E265FEBE 
X-CRM114-Status: GOOD (  17.44  )
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

In order to validate multipath link support extend the existing sysfs
tree dump test.

The updated tree-pcie.tar.xz archive includes a sysfs dump with two
NVMe subsystems. The nvme-subsys0 simulates a single-port NVMe disk
with a private namespace that does not support multipath. And another
nvme-subsys1 simulates a dual-port NVMe disk with a shared namespace
attached to multiple controllers.

The json tree dump is also updated to include NVMe namespace path
information. Since the archive content has changed, the expected
output file tree-pcie.out is also updated to reflect the new structure.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 src/nvme/json.c                  |  90 +++++++++++++++++++++++++++----
 test/sysfs/data/tree-pcie.out    |  53 ++++++++++++++----
 test/sysfs/data/tree-pcie.tar.xz | Bin 19712 -> 12656 bytes
 3 files changed, 124 insertions(+), 19 deletions(-)

diff --git a/src/nvme/json.c b/src/nvme/json.c
index af28bd48..a2fe8173 100644
--- a/src/nvme/json.c
+++ b/src/nvme/json.c
@@ -533,25 +533,97 @@ static void json_dump_ctrl(struct json_object *ctrl_array, nvme_ctrl_t c)
 	json_object_array_add(ctrl_array, ctrl_obj);
 }
 
+static unsigned int json_dump_subsys_multipath(nvme_subsystem_t s,
+				struct json_object *ns_array)
+{
+	nvme_ns_t n;
+	nvme_path_t p;
+	unsigned int i = 0;
+
+	nvme_subsystem_for_each_ns(s, n) {
+		struct json_object *ns_obj;
+		struct json_object *path_array;
+
+		ns_obj = json_object_new_object();
+		json_object_object_add(ns_obj, "nsid",
+				json_object_new_int(nvme_ns_get_nsid(n)));
+		json_object_object_add(ns_obj, "name",
+				json_object_new_string(nvme_ns_get_name(n)));
+
+		path_array = json_object_new_array();
+		nvme_namespace_for_each_path(n, p) {
+			struct json_object *path_obj;
+			struct json_object *ctrl_array;
+			nvme_ctrl_t c;
+
+			path_obj = json_object_new_object();
+			json_object_object_add(path_obj, "path",
+				json_object_new_string(nvme_path_get_name(p)));
+			json_object_object_add(path_obj, "ANAState",
+				json_object_new_string(nvme_path_get_ana_state(p)));
+			json_object_object_add(path_obj, "NUMANodes",
+				json_object_new_string(nvme_path_get_numa_nodes(p)));
+			json_object_object_add(path_obj, "qdepth",
+				json_object_new_int(nvme_path_get_queue_depth(p)));
+
+			c = nvme_path_get_ctrl(p);
+			ctrl_array = json_object_new_array();
+			json_dump_ctrl(ctrl_array, c);
+			json_object_object_add(path_obj, "controller", ctrl_array);
+			json_object_array_add(path_array, path_obj);
+		}
+		json_object_object_add(ns_obj, "paths", path_array);
+		json_object_array_add(ns_array, ns_obj);
+		i++;
+	}
+	return i;
+}
+
+static void json_dump_subsys_non_multipath(nvme_subsystem_t s,
+		struct json_object *ns_array)
+{
+	nvme_ctrl_t c;
+	nvme_ns_t n;
+
+	nvme_subsystem_for_each_ctrl(s, c) {
+		nvme_ctrl_for_each_ns(c, n) {
+			struct json_object *ctrl_array;
+			struct json_object *ns_obj;
+
+			ns_obj = json_object_new_object();
+			json_object_object_add(ns_obj, "nsid",
+				json_object_new_int(nvme_ns_get_nsid(n)));
+			json_object_object_add(ns_obj, "name",
+				json_object_new_string(nvme_ns_get_name(n)));
+
+			ctrl_array = json_object_new_array();
+			json_dump_ctrl(ctrl_array, c);
+			json_object_object_add(ns_obj, "controller", ctrl_array);
+
+			json_object_array_add(ns_array, ns_obj);
+		}
+	}
+}
+
 static void json_dump_subsys(struct json_object *subsys_array,
 			       nvme_subsystem_t s)
 {
-	nvme_ctrl_t c;
 	struct json_object *subsys_obj = json_object_new_object();
-	struct json_object *ctrl_array;
+	struct json_object *ns_array;
 
 	json_object_object_add(subsys_obj, "name",
 			       json_object_new_string(nvme_subsystem_get_name(s)));
 	json_object_object_add(subsys_obj, "nqn",
 			       json_object_new_string(nvme_subsystem_get_nqn(s)));
-	ctrl_array = json_object_new_array();
-	nvme_subsystem_for_each_ctrl(s, c) {
-		json_dump_ctrl(ctrl_array, c);
-	}
-	if (json_object_array_length(ctrl_array))
-		json_object_object_add(subsys_obj, "controllers", ctrl_array);
+
+	ns_array = json_object_new_array();
+	if (!json_dump_subsys_multipath(s, ns_array))
+		json_dump_subsys_non_multipath(s, ns_array);
+
+	if (json_object_array_length(ns_array))
+		json_object_object_add(subsys_obj, "namespaces", ns_array);
 	else
-		json_object_put(ctrl_array);
+		json_object_put(ns_array);
 	json_object_array_add(subsys_array, subsys_obj);
 }
 
diff --git a/test/sysfs/data/tree-pcie.out b/test/sysfs/data/tree-pcie.out
index 4a755a77..8ea175a6 100644
--- a/test/sysfs/data/tree-pcie.out
+++ b/test/sysfs/data/tree-pcie.out
@@ -6,23 +6,56 @@
       "subsystems":[
         {
           "name":"nvme-subsys0",
-          "nqn":"nqn.2019-08.org.qemu:subsys1",
-          "controllers":[
+          "nqn":"nqn.1994-11.com.samsung:nvme:PM1743:2.5-inch:S7DFNG0W700063",
+          "namespaces":[
             {
-              "name":"nvme0",
-              "transport":"pcie",
-              "traddr":"0000:0f:00.0"
+              "nsid":1,
+              "name":"nvme0n1",
+              "controller":[
+                {
+                  "name":"nvme0",
+                  "transport":"pcie",
+                  "traddr":"0214:90:00.0"
+                }
+              ]
             }
           ]
         },
         {
           "name":"nvme-subsys1",
-          "nqn":"nqn.2019-08.org.qemu:nvme-0",
-          "controllers":[
+          "nqn":"nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057",
+          "namespaces":[
             {
-              "name":"nvme1",
-              "transport":"pcie",
-              "traddr":"0000:00:05.0"
+              "nsid":1,
+              "name":"nvme1n1",
+              "paths":[
+                {
+                  "path":"nvme1c1n1",
+                  "ANAState":"optimized",
+                  "NUMANodes":"0-1",
+                  "qdepth":0,
+                  "controller":[
+                    {
+                      "name":"nvme1",
+                      "transport":"pcie",
+                      "traddr":"052e:78:00.0"
+                    }
+                  ]
+                },
+                {
+                  "path":"nvme1c2n1",
+                  "ANAState":"optimized",
+                  "NUMANodes":"2-3",
+                  "qdepth":0,
+                  "controller":[
+                    {
+                      "name":"nvme2",
+                      "transport":"pcie",
+                      "traddr":"058e:78:00.0"
+                    }
+                  ]
+                }
+              ]
             }
           ]
         }
diff --git a/test/sysfs/data/tree-pcie.tar.xz b/test/sysfs/data/tree-pcie.tar.xz
index ee11fdeb0108589b954eb03543665e3a10df0e95..d99d2b943248cc2d7586c084ac639b613524cd2f 100644
GIT binary patch
literal 12656
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

literal 19712
zcmV+aKLEh}H+ooF000E$*0e?f03iVu0001VFXf~E|Hw4fT>v?rN~u*F0gLe8Q;sKy
zl~ZVt%~nUb&vqJ7+!IT4D6N?P(s$!zut}DBL>mH6y20K>oJlfd(>z26V*cm_=Cfps
z4>k7`e7-6Ccq$X}U6E5>T831dBu2v7Jq37BeA0npcaExU$4K%0p^RVIw2r2T<@a;R
z7y^uluB0LU{FzV`<eU86U43vDSc?0v&P&{r@l%N=2jo;D+aPjHn88YEcBlwifOI2)
z;-*Uwssn1yLk(~BsfdU{$}-vxOrh9~7j)#8L*8BqugUr4AjptI$jFK=@U3^uD*Khb
z!fW_S$_6gaZS|6Y{9o7HTQ50*Fn?Ij+(%cS*Y-ikcqXdvD4LJ=&)%%P`boL2sdo{q
zydTpvhS9l^(0Xsc>OuEWa}rwnFK^acSho2dYiPKpeZdfTVKhLJ&NdU0Mm}cWsKIJ_
z_$7H**g%B47pZO9#?ZYVMmS?TOpTo8)zu%$Q-J9&QcV}_xCTBnfU5BBw#6YEBI3=)
zOu%_)J98QwZ=rA`U3+jAO5ucj(a0N{cr9U8!K-^!dQBJ`ka+Ob4v--GRFU17C*Kg}
z!;TQ>C(dC{8RQIEgL=!xyRs(q=vKEPwgdfwbLMv(CiNV7;EX%%d*>-H+;T7!>@Qj%
zHnzKjr&UI=q>DC(hmPm3Zh6Z+W4zN~@OVsnUwCu2mj`>tkqon|w)1$|&re-IpB60t
z&+mjUNF%Q0&(89hD;>AQu=AIrP7%ILI8%t7hBp-EBx5A5GL#fo4V86H2=NeZCLx0#
zrFwW|#a8*f+`@8xd&MhWM1VLQNF7vMm;>mRe7F==G&A*xOna6jDEjR{bmzOY(*FYS
zzNEe-S!A9zFA{(z;)vjH?czmZT$T`+Oi&ynKo|7B$!;OR!HbDjMB4pg<Lfu%x<`(e
zj&Udko#@k5ozq0QtrW2p6`%GKjwVURh<y^4Qxqb+WVE^er*>OW-^2Vf?2!yr6ezv2
zk-nwZ8Mv*;h-B$|)tc)=S89-h4-+zV<8rLUebyWH$o|^Csrf}H<O$Avc#P$i#ZEyV
zMv2D57@{%yEKGM{hK{!50TUxWdn|wQf1%af()=7tD6Z{TeP&dE+UZvt5c?y-_Gp>N
z4+?m|BOwdo_7R5~KuyP|S0?bmKlf@ql)uO~R9IS`KT)%Ff^=nSM;Qgk&%9Xe8P#e}
zYp&fA+@EfVuJ|JPP6-q37PdZJZ3LkwzhiR`2hjkcNRs){OxHK*{IDgkNp^IK6AQgB
zb3vXj8iY2RFv-*uV(rk2q`t(pL8uxd3ydVdB!zn(WM$)8!<F?3V!LIe!Rb6%J4O5>
zRu!a$l3^@tDI&y;qxTIdrklZo4=Uf_%eySNbxC?(R4BLk(+cJ`D__f3o=JDuk>=R^
ztXE-dO%1$VwE|Nf%c|sCn+}OlI#(6*VStL{dV4ft*ed&&$gkZm!429dfIoJ9{OhO3
z1}D{Cdk0_r)M9i*KYB9dPwAo$AgG{W<2EBI5B(eSNM8g_8R>|U#15Orv5r8fn0Jha
z%2T`EcIK&X4~dQmo3brxORTCWrRh%$BxESDaxXS`2t|mBXee@bvX33DRS|d%jF4Q!
zMuY$iY%-*n!Tl<NKNC(3)B}v0tL04jXd2ODZvd^UOjy4+p|Jw<Z+#<=97JwnYNSOe
zgMOGTR!wkrVZ#b867Nl6C(BPx+KgjXB(V4QOlnrWjPIGl=;)(_h}yA4FKC1mdtoE7
zXmLCBLuY`IIW-cyLeq47f#gW!94cFZ_xJvlwX>~Q?Y`i2GbOE^XL~Q^Il}A&y@3mg
z%AN@$WFF5bHN)sYDt_*!KQFE7mU(mysm_JOB;5YQxJa~A<sJch$+3fHrcqJo3G++<
zp{O3G7jCxptl61EbcI^N<ZQbbJ$p8gj<|<H=f#2A4t9=!02m%TF`U$!<(4wpUpZ<A
z-2erae!GcpQw~}iR%X3OCb;2GNFWcV3WJO6$sZHdvU{i;&luS2zopsCS$;FI3ppvP
z2xz#!+$B3jB-Ij>xpA1ANBaz71$>7?t6@i_Z5+!z?=5kkYGz+Fr6_6h$lx|bsL>fn
zgf@y(okvw)H7T-3cCDgoLj^{3KA>Q^G)m2a@^d4^J|#QR8HMhkhRr#!BrELm@cid_
z{aX@Pzf(|GOc=CT(UVef)SM6bG$JI#Y?rkqrRx520#A42=(>212s+<pdpdK;05Hnx
zB@XH*?v}?VDUSz$zI!1_e-qLS7sr7eXbrx4udsVwC&joA&ctx-xKv~fM&`mmNwvK+
zCXIf$+~>!iDT;r)ukx$AVb1&Oe|LyW-r7YQF_$~;eely3fj3;9Px!b^(c`zzo`rxd
zkD0#_BU|31@Y;BeGPA2n7tyRl$&^4&0HaZ$m`k{x{m-YJ-HwCo3L+lztC_wOUG~(5
z6lJuV41ymt`t~}w!aB*~8u>2>SPKbBDp=<D-anO^-U_?E4Tk(&csi*k>*K-}ySHKx
zpBH)U8q}>b)x#TEV3XMZ6Do1)2esHxn7`tuJU5#m0jPf=%wL!Aw}eX*r#QUqG|W%6
z3Sc+O$VpvG{)e>aysIE#2geX-+Z)(>m@k(rCn{&=8W+bHe5^oGw+&b(_E)MJjF*`o
zor|(%vk?(T8nWZFFMf!6G0`;51x{L_Jq%FjkGCS<KBBcSE+r60d|B#9<-2@k-Ue;=
zU>uz@?NJ6bp(bs%ha0HDmQyz8@!MaA!{WHRM)RL6)$56tAi^vVr*;ORjxbCm^LCd=
zxNi<7H+U+|6t3G?ZRl^vb=tFR9Fzu}R-Aq{0fR7)Dz0848A{KE^ZX7Z(&ZzOD*3dh
z#XC8WZgS^Wqp#CAXlLl~40|wjNT$jDdB_!oal*H;lR~*b{8$tn!Znxbov9UQ9**Lz
zMq0Tda6P8Id!DUxPQBQXlImV?Osp?lGc}7PDmL%AzDyRS)?asqX8|t}w&o%`)3Lh*
zV(?8Lj&@kd5uf#Yaz0kGxkqjI&@j9qzDXPSawG(|fHE)?*r`Xk@?9%2XtY8LZJ6a|
zUH7AgS10fCpdVGY-}KXhZ4@4o5|h}#MOGsqQ6kT?>myb|TV^I#YEeSi07w4N<+s~j
zi3A7<ib@C8ej;7_$`$s-=>!A`(EK040Jx~&&p;%BYTTVWM-L(VW6gIGh~(tmIz&E@
z0~FQye^YqpOHbKAAL3lncu?i8d3%4A28+=M{>nHhHTKdjoWhfAmP`P87E>_eYZ~uh
zBpo?5SZ?tfP?A}^E}k<KAMqmgS2BoYdkt%LAisaVTu_`K;u{N@#@_!O66tb6>4k;Q
z@d#fiFctvRK~N*2BG1M$vCD{VAU)4*-uOdQGau&%j*Tx$4+&k>LzvV(+$Af&%@j38
z6bp3Ar9w#fTMC|q#W3^gd#>k%3bk~-3LOu@Gp3@?;V-&bM*;CEMMrFBpLl)n3OdR8
zGtYnqc{dA|TywF^xQNP@mU+U^GRF_;n!YijyYu6ISX40%t9yno%YQ%SNO~ZlBfZ8a
zy!7qb^8`zF{uutBX)6J=6&mVm_8e_7`v%>d1uq_+?_8DA4B*ZAX5uHe!Zq_w(S~So
z6cRJ(Q0O_WYu8HmEoG-#b07+XcA8R>?b=4m>jHl+L^J>U*Al|YdI=M<&<1`f#bW5N
zmNUn~K9Ar@p|;ncGTwrLaRZqRBr6;}+w_8j`8hII)gy=)V;KR14+s^fn!|yrT(Rx6
z^@JHPC~)`6w%4;vF60;@{?2OR6%~a3HCbL%uED<VOaa&gAIpa(J5@u&aNWBnl?wXE
zWZOtg?PU#W4+;re!OkKtts&O_0hBlT>WIUWHk~q8(c}CG|L%>#@CRTBQ+_{hTnoVt
zb^}sUqeHqrFe!f!jl`#2w6$O#h%Z9jwK#p%dBXQKBa-w2gXmG(@djHs`tH3ZtLjdF
z1Kuw$(BQLc5l>ZK$jsT;Kz4G-`^I8TGc0#8wddfcQ%YPXW=PkC52$c~Px-^&&p%ya
zPxjwDz;%IGCCH`ZCi6w9%X4WvwshI3p4*~~|MTB@fYGb%E@YNK<Qa|r1qkSId*RN@
z!&PDOuIa@MJ$qjnvQeCbJ$+;m#SD@&HL=p9R0)*QcRIEd%5WFy?#G6AJryRdjf<9u
z*h9AyW<~y(Xlnz4|0mu+Eib)E-M4y1714g{#l#S8dmN|Xy^SYne^}S|e_@2~VLAAS
zq5#w74J*29GuIk(*MyJ2+NCtCm0uI9Z}emWdTAeA?!njE0Z~6L!_<O#O>2#S=0Gr(
zWhzYt35aPNs-f_OaJV0jbCU{Pr=vKKoSJZs{y@kd8u&YcS?P^)u`^$Z=1$KVx{Lu%
zIQ687o#O!nD#hjFIG_E;mO4&Pda}h;h!A?be%UKqsgnv85iKO_w*NNoVqlcxa>?Ks
zQb+T7U9CB?j1)`WX0sxA8gg{MJLc&7jcl*6x)7yZE7a?dM-ap_i^SLmdp^u=sy!)i
z{SR8NGgULzM-adO!VSAuRa+=NR1<*f4lK>n^O|{}pjO-Ykx5=m<QqOm>Nv29`BTvC
zeTJf#`rTze2eAFfuF1JSAzwKAB~;6gLbB=cRdXU(%J4@>kicwvvC-t1w&g=(Xk+0}
zy~W>nlpIT<Md}3zHm?n36Jkz=RhW|3D5L=Zy^Jlk_lmS4wZJP*7LH9IpPJid&6deo
z?0$8Iq@8lgzXer$z7V&KrFf%FfUKczZ^uBq->5{)XkHM4Dn6cGqp;Q|ntDj9l-z~)
z-asNZOOBhc{^Jv6PKIj&J+T9HYiEM~M=x(kjQy`N{HK6P<(PYhlM;;t1Nkm@B{tIT
zV<{KPsl^`2=zp3CuU#D(7)vK)G^U|etx=V>uA&(gNO_-L7Je1r->|Jr3-?>8T7I}7
zRx%WeP?y5UW@}&^d?s|HT>gAOQX+kSuDPnns!|wHR+1tXxDt>!35m+Kt2)*<CimpM
zD)8@nI^*d557wLz6L(kClf!5B06#Ng8L5di2_nz4H;iI<8%B1cz?*tNQgKL@yMz)`
z3~WqMg1nx|iLL~QJrLZ>j=wzF8{MD^T#|7;t@wWB*aq{xKT-gO4X-d$(?~wSEx4X(
zf5#L8AM!n<iT|{yXW<?0)tnL<_xGsLIAIQGD*r{*{cp+o!~=;35cr8;&fOr#K4++t
z@o&E4^}-^y6wekd1tR8ztqVE`Md=B8Gt-1>leS&-r($W9I1$DzwqF49l?_NcJ9|lg
z+&|K<mObKP?b1O-`Xlmem8C2SS-`G?%{wOAbG1?Lu1-IY&zH{ul=_-Y0HHA{;BSCJ
zoOL)}$f&ggj4l-bS!1Eg5vgXFCyn!3$l)mYY5}{ZHL~deI0eFwM#Im*vV%m18=y~F
zbR<F*^PTdNnoo8kU`0Ax4-F$RTHU%81JgSfG3Dy*<_Ta<5|nYAdmP_v3Sw==jM)?M
zi+Y%BdaZ}&c)%oJ=sw^N<E4a>1{e|zt~LjMG~VGLNl16cFH_O`$@zi0$YtxIeqiIj
zE_fJAu`=c0{ok7R#A-_FAqSLM;mFQ|dvSKTqPa{^Ne(vZGERIiX_z%H6M;o}7DT08
zmSsjfe5Y#&7AWE`lBsxdv?>DJ9wj=oqd5QYexKmS-u1}BR!IOZ|6!gwW1PwXb77^m
zfWo3GR-D8;04z@PWX^<GOv-DL3{Nh$f+=+B3`;OE&yeVs#m*Dw<|`?&ih>wI%hk1f
z(9cp!?FyeH7#5?C_7uIRd%KB^plOj=3O8x?G1SBRaIgY@O{x!Ht(m!4>PhZQV9Kc}
z7uaJiZYr?cDT;?y#enPt=O>n%c}Yp6MkBfSl2HlJH!ll>j_+`bUmC=KbDa!L6~z4+
z@C|v*k2P??r#+xWGFUk+tZ7~d-x7}cyD$siwLd{1Q^&X*g>cMx8p2V0g`Na;BRorJ
z{!RYUZ~LKZf%l;6&<spa9sy;*eVwwVR-e?O^;F4lmRAWZ+Uymk6Rwx%&;k7b)yg*x
z=#J6OU~j{I{_bpP@~m_wgjm?Q)Elfa@>-^%yyLiKG#r&c&@>Z)GCjcCwHwbVWrVV#
z+Zp(L2Z!<2>mL$J;Q#|!P7HhtW}&(u!m)H(FvkM21rLS*xs05gc3HA#CZfLpnj07p
z(w+;?&EL|JjZ4}#jYObOCwMv#fXn>JsA~d!)B@3>v?;NTFWfRD&Ma-xh@dVz2w{dn
zeVYw^d6IaUJ`|fKrPb3u0=z(_f^}YMxq60Xfk_acg4!=BM)DJ#SFCn_+^7eaja;q3
zQQyUlqz`!nhE9m9LhRaZ<8{*`h<QX(iYy+t2smtjPchZUzZOUYmf$mvbk0v+k9P8C
zMsRNr)@s<dFHz+O8Yi!ch1LuIUpz7pJAGhhA(99qy+%$;qtvd0Ns?)->{N7IR(+G@
zYX-Ut^$E9!O{Xe!VCi>s_~2+KRs^N>Gx#43%18SoajCV}K4bt)Du&BG{ljtNtI)y5
z0e#cFG;JaO@6Q#yt8u73fvv2&n!lygA5p1uY0pa&G*q!-`PZA@X4L2&p*xbBP^kJ)
zaGSEB7UEwkH6tX#FDvy#2E{1SQO@qUR73LlncvH5;`qyPM<8FdTTs=)76-hfF<xn9
z2GP#w(`&H7!>#?(P);0`MpXS@qe7~Q&ELpr)A<p|Moeez-#k=S_SXPfiQ^WU!Z4h_
z4Iu>8+C?Y;js3G~{XMLZ>x-H9J%h&zg19|(u>scb8t;<r7*;}KHk329Ws!x}+7`|j
z`wPPa4?1X?sA&dw;4}pwGW|Vzb)DY9(bx^~1)|{HQn%;~yrSZF64HeiXYa2*VMk0Y
z+w27Os)Y_Y;Z-ff<XPaC^@^j2)~It)0Ka*igR^3eG-^Ijsh01>IJ22bv!$hD=PZfZ
z{AvXPwf`eT_5)RrF_xA~z6{WQAZ_NFS@>5dDB+F(o3>&a2zAttDfO%=xD1^~6@Psk
zojXTLV^sZ!%Mid{E{n5t>f_P;GEeJ*X^Zak@G0$R4sf}>Q|%M|`7;o}7e`{HfS#0)
zS0%FoPeJ(%3M4KPrTZES30UN<-Hv(<wJhvYhYH{t2m?UX-r0r{KM`tzJcN_Iz&Sfc
z%opF%v)NA_=vC<%x-EbKq^HAw@`R3?gs>ujQx0I?z4e=#qbZrZjb^uKE393_0EooA
z>Aoqh;NPAD%gvkB%Q{UXG?>j;%1jq7>UBYI;&d46bK!meqbAnmpuvgOnbDBEiM$L@
z9U_ZWmsP*~#<7H)=nMIxmA+!$Mba)kM#eJgm}~_vqV4V*_p<|wC~2(kV>Dg4fZbB@
zIeiPUuZ5~cDL*rFW{t_*UTaDr`vTP7?3n0(#IP#^ff`SM1ahw+@L$(Azb$zFGvnjH
zP{vK+6XYA)6qR*}a-klbXGP>aGARRt3uTS#T#v#0*y%Sk<Z2V5>P<!W5>ClyE2pPJ
zDxd+8Ckfc#87iYs5a*+YCcr{Y@r$R_aoh)a>f*(&em7kV#0bn@V$R`vuHYix>)J9Y
ziE51NL}ZsUC|>6*{1H909RM~q4WFeT7gX>X)CWG5ORmXwAG26(5u?jOQdmURWotvt
zJ{xyLijy|?H^G5Fh<*ac_+!my{&0eSai|ZR8pa}6AssV{4s>NcLa%ZCb?1<qYa!@z
zBQ*^>w)Prl1IZ>O8yrG7lY;{YZ>dM0MQS@h8)ybj^*x?xT>}DT$H6ixMHB+VcLQ=N
zPcPB1IWnJKk{wrEIw*m*M+jPk`8{EQxhQT-C1@RyC{`DUvp@#qhs5KU90523_w?-3
zs`~ZZ*V{uptGk-gP+qWw9s-njTV}KUAPYsGMn`C+^iKH)0EjfjhNen89KoRb!rF*c
zn?EZiIPv|-7e1*?>oF_~S6vn~BbIt3Ml+Pc;caV_2SA~8D_qTSUW$g&(VU+b%4jBz
z2w2fo`4<ewNJ?F~Kwms|pE-Y|F%@?|A}78wyu?o-Kr1DfoN(f1J8<~j8I`q^;Lvks
zt1uaNW2Nj7n9CnVMRp-ZT|ss2ce`{kO2+~ow{biZ#k?nS-btaNR{pCjUOM!Dz;4|u
z{8OJadlT^3p=7RSW|<np)I08_+WI#LKp7MC(Kz2#`kJRyA;?H~_K-i&jd47&7t6xt
zI)}6tL>OR(j;*L5^oNSHlva%ZcwjT+VbttALAt3G_3q*HYd5lEpfurOc_Ob%N8b(U
zOVQ6Y+FnXG%0Qq_Hbr)&0o504D>vlk)<wp;nAKi$w=N5DvzdJwzjrA3dQh#bH-F>-
zV1gJYvfD5;w3e2TIkU%PTghT)*gI%-tYRLEK?SK`3MCNW3>M1gV0>4OeqR1o(8;R)
z1tfwi;!v{)n5uooe9(=5kgYFtbeTCnde>%YUt-+qD$}Lyts}@2eR3*Q|2#P+<fzfG
zi)qyo=cTto^+47Akw9hE7fluS0od-dssEv{XAB9yRX^vUNvLG_Lf|i?5Z&Y5UyZ=^
z)%Y%tWzOJtG<Tq=RPQ+OWm~ky<5<m@0N-nXba&aY07Q9m4dI3JKLSWhPHgcs8T;Q?
za)G2Qj0`+fgrqwJ@d?eEc7A0lCyxyt|LBo>DkBp@n|*RfJ5YMil}7(4Nh_dywXnfz
z#irPVdMx&@JNW_|=h8u*jDwacjk~&H*8#8k)^z~8>>Ecmo9`^&IZ`J91GAoCg=?+-
z3Or3sMV>}#&KKAOt`^O$utl8nkC5w=L$2>+TR}9s<3X-l{>he2w%iq_;08C#p?>B%
z$Et(j%xNgtZ5|mB+3*hpwl&K#F2K&`?ffDGkw_VaSQyO=y<c47(MF@U%IROaxxgcS
zcmnA+_c7Hv&X|k7Q^Hb6o(GDj-60g48RhxP;ZvS&WdMu&fBuZ-vgYbb#Q8}^>Yvju
zCe*a%u2M=vlMTef?qE3M`-)2XMGn@a%hme}jfdwn|GR({{)ZmBEP&m<4>Pn7NHo2j
z#MY#D^;eQlZpJA+l)ij;p)S&>yxtJhA(r7nPIrrwBSrsz9cwb)>1Mv`$>%uc$nq2f
zUwPRJz^vFP=hLV5VXlRoLPt$+xrc_r?D_u7pyl<lV$|ZjI=1(eVA4<o_@1%qIa7Zc
zo>ZD)dfqmsHK=963FAY&3{^Ee+50usDJzCtImrPZHf(p)N~@x`{sEy{Eh9yVls+Wk
zUIg#4V9FG==X!{fTiA4Ni^j%2BCpm?RGvC&zoH5r4iPg%zSSve-3tz|yM&n5wt$vc
zOd4T)@-fYAix=niWtf34qH#CuIrq&U`)0PnzH#pVa+g@-^S!_ePT#TeMOyQWWin`t
zF=-H^0{v4<mZlt(a;7z*X-wM}I&~X>OD-dib{_CDFl+Nr{p7PHqy*LPP%Xw86S4U9
zWKO;j7a5!v7vRSx<8a07+8=0q#@CS&M$rFE23Do(D1Mt)(B@_?Mgg1OCOMw`P%hZ7
zJAjwA+KhB-dLPn_*<sl1<0za|8pF$CmdKI}>M-3;>rn=p0T``tvUL^O6vYikwG2%T
zY}yt>gDQ|CC+CQ*Bvp7h3Q44x!hZvrL-CSkkYx7=@DxfHHHzK8RH6Hh8RY+vO1682
zBttArkxBhMa#gd?ZNpZuX8zDPE6&IFc_R^X1(yf8PxlK(tV&k|vLnb#D0njZDjtr?
zZ6K>?6z+4S<|`wQJXlhr6L?6Rs~BEIoUeel=a+-;k|(wFGh7I8;3mC<Y2y0G^Xyd8
zxOZQOFJ4u3cU&C{WBJXZAp?h=>&GSIc%3Bz__~v~d6LA>P+2g(`04dMAs7Z!+_%Lc
z2*RjIErc2QpG3Lf3rzHE!NhW<S1+R~fP)h9A8n14f2j{kHLpfYIqlmNBgO7}a*tyJ
zctgU=8`jBkiT=vwaD+&Q!q{#1BHaEq4wu(9++dCqom3<e>U26~Lm?33sO%Q{M{tEk
zL%;x(`i}J=+8)SVZ)U{)WumXfwe{V;a$WV}+IDE;)2Uuq)88VX<@#m?_8BypZRZ_9
zk-1V3#WijgFlz}<Z0sG+X_m&+gLt}~Q=WAf6>GUvWI-@xs{Zo2bQeGr*XC8mqVyH_
zetsOE7Wqa45nRu{mP#FboL1YxHWP#5jh+{HkOX0d@ap1eS$+jwKz8X+jQ8fvd6)px
z-0q7P%4OaLjWOf|!t01Js{7m6g>dPCT^S*t$9$`k8CpGTqv<cOBLGC_mCn6Z7O3QM
zaJ$xfLQ#IQ72D<2Pt9N$>9>=3zJK@J`0dD!K#Ad&4IQx^b{MY&wuR`9gK8W0n~FyP
zHp6vXLh|eTRb#_*pGZ9nvOpioy2WkP*<%$6R`Qi-T-VUGP9YZ2nRj+c!}VE&;NDW6
zzA;nf?J!BqjPDSoeQL&*=s&~aEhWe8$9p?j9G=dAD&Ybda5HEv%?#3LQLwT76*{T@
zYP^$do|@JI)pjRi(jSsXMOq3+(*Z!Brlf3VHNf>6leC6P;o8ts#n$PolgKzA+}zut
z(Ww2I9(Orb<4efNsfl(8V%lDQhKL-+o7Dry9bF+72XUgKCaU`~#~Saz$nYtCaYLun
zKMG68R-o@B@qb}tJ`8P7HyGWbOS-RpeavT2q*q1v{739)dWHobhF7nn2pMUA)HQ!o
zzizWF^B|Eh6h5il0aR$oO~3(QK<leP=1%yqj(t_?>L?1_$6i}fPLH`ThaJU&k|v!H
z7Igs7*vMB<Gsx?XAbh_TUtV_4bJK9(fm_$aBF68q4iVlaW+Oe-*jg=CVciVrsV*Zh
zBpOAAgi(#LC*A5CY8qt}#ElW1h+xp`1N4~%bU7rLKHyiDU=~_fFgMlG<-_PjFi=X-
zmr4T_wP^x8T9GrJwV7%B+ImtZoHM4zG3iE}hzHNa2b$(gND&0y&tW)H>Bt?h4AT3_
zfoeR6p+e;d*Yu|WmnvgmwW!`I+FOLKR^=Cr=(HFF!>h0+3V)q@l)sXn`laODckx53
zjliWqk)A<8cEKoEcg}edf(8^C9DgZja!>ps%0_m&4)R{%^Trmi#q{urb8kMjFD}!h
z?2}3px~cWF=0E_N;Fnt|&CGc_9(;W``EFLwHjUQHRH29?;c+JThJF*|ch4MXM_|pY
z8GjhKMuqPB47Aw{qar`?BE8-ON!#pQK?A5!_>y+wG18-Rfe+cCK~5~k!@nD$3YWt*
z?+^*SbiL4l4;dW_FY$P4^5Y~VuC|3$(0o^nEbs)U5Wb9RQI-wDcG^`Aao7psO}gXr
zypAQE{m<PPdFiMttBWai0ncqnun8cK;_S_er^-RV8fin8@>W`5dn_(OhofjY%dIb@
z0QIiMjf5c|Y^m43BP=5}_c{(CDHD4&g~*UbV}A4GZ3&j9!zJ?SZZb)-Q5B=M5>th`
zrbug0fS7-lfPfmmXXXZN2zKa;He&R=<W+H(&RZ?<$~sd4jEi#9^F)n{Ft>fyo*Q}8
z22SOqPoALxwwyxzcKB4NtTe@%foZq1A_nms@S&*aO+nKS3u-4!ol%TC9IcMQC+iEE
z>Mg}+j27RX4^OHTq*Mw-NYUkdyx!mBQKnp>IAuaSy9mG6s3ki>GL=VdOSiA1Dw@@(
zWwLFAs<WPubgVL=UGfP=>^VP}H#UG~9sNl>HA>Z#)T5X7(V#H5gKF}*)zV)Pwv88G
zdy#)g6)le-D1q6`PEy)+)mR>-tzTRbLcJAyAKZ4^yfx`h47kOBwq<{9Bp>>$_3lf`
zVa>Z#ak4<RuldeVlm~b-MeZIZKDP@AaQ{iTg@TeDn(@MHUg4N+B&d2q-Mqzuzpr%a
z^;)n#XKlV*k!pcpHs+0n@2t)+5^q#hf_Zr>mmTxFjdKO!hf`XZa{%J&eY=K)*pKf@
zJe329WTJz>3W+cNOW7NNrpBa@hxNi90J6Y9E;5J>(y8JfhO_TWX5re$X5OtXUDvg|
zCe2&VHv=cRBHz$BDYelzjy|hWY!Ep@#(X%$`VcDl0!3Z0EUTB1H7;HHZ?xHFkgS_D
z50M$d8=dnOTWqz8`Y!vA<20!Wlu<386NUCfxoI{<8j~+^O*Aa{5-|f7qglT=!V_j^
z9;dXYUam)!%M;(7Tnc_ikC=zI;0%AcjaacHx?ZDsSSG@qrGb^?%T%Nt<h?<&LsSUS
zrlcuk)9bhieb&DoPttTT;-?#T-*d~QS5M(j4x><aCurfgugti!dc;)O`gD<&xW;O=
z4fO>hXB1tr;(GHzhnNLj(U9+MBk$@oj)fH9UAd}3?E_9ZQK=W)5xs6t;}4U}iNRgZ
zPwlU<8gE_Ww5%8gHD>S7c`CTu{_Bl6`bD4|2%x~#15ky#;8t?Pj_Apdm`v*25IZd%
zykMuez^6BnGY-zfvZslPaA^WxW2oBa@a;R*cmG03_1ae!2g~7V-$p3H;}vAC!tEG~
zqQXMD$(UiRsC?!G^<eSW9{_L<GEq07kQiX7wt3)5AHIsT5Lb^Jq0kWh?vdUMBCehK
zP{=7dT{ATZwC2#Ch$QgkWVW|~|4!=jZkMslY;3-0;&!{4i-41WG7#D7x?>w#r|jic
z^IPleB4t_8OJTx>C+m`S!e?}})dLE1;&48r_rmR!nLSXT6uo1ER@WpBVi&r>f6U6k
z;iAhAPL>rlua>TMge<QxF(TA8ij!8EhtlKw)T=y^{puyPP+?EFG`_`i5jpXNH;{zb
zFF5l%)+HQ-+Ht7I1>@wxyiSRKZuj_Y#Cm)##4oyFW0=5pux{{KdM+d!iW?5d<pf+u
zFO~j)eRyFRUC#a;)r31hZ78tk1cc*g!Q(mz1@O!m9Wlo_3es|V8Klu(?cH)LF<fo!
zKKyyCypjn_hwTO3zNo279L*9mnt7qhEDlyfGsFSsWO4iwvT)ii8|(erW4v4B$J%x#
zWpdGgz$>LiQ<l?6?*ZJ+aiC$Sg`C14Yp(F|1AF`XSjlYwyrH&lk71l66&l(^q(ERa
zM2K(QRQ2&a+ckl$5AVJVqiCt-t#XVFSp^NK{)0v<4Q#N4xXn57>DF5?#(0uKeE<I_
zlBG`R92}fP5k}ngX%LPCqbFfIAC?RZMC4CZXp)`+gU@C(Mmrxg*CI3bb<NbBb#Qj;
zCJ*Yfx8GB)UnX0b)f4e-GiT_S`>aj=D4Mv|9qTj`nRvkX-P>(+msGX1zw?2$pYL4K
zK0kTu9$9v?x%(>lXIzdxX!;2WA+}9bsf24!;c6?WQKr}md?Sw+1E;gPY3BS=;C`d<
zSwBcYtQj7Tn`@qH*rv}Xd1VsoOE^m*rJ5_ZWt^QpE_gGtmoFr~z|PwPC9T)K8uU78
zlv$|BwjXPnd=nUOcc|UrB1a#{L@|=PD@O<~n)65vw0<Hv%(fEK7xQ}KxnlNUy{uJ&
zgi8o&6TDCxvBuR}!{hi<)o+mofzj>3K&Z<=l<wE9Eu9{BxXpE2_}O#K<yzpeP_qq2
z;Pf(St5e;PN>bNxy{+pa^JKq$Pmk+Em=#(RgdVHKKo%Qn51<JkO2mS_5WsP-8s}Pu
z*r2}39f+iF8pgr`7>ijr9%9I=8LQWWti>NCa3WjsX^LoKNX)p>g=z7M@=cOcC5DjH
zOtqGO@E_(=s=eVr^)10d3lLRI&?^t%z$|n2lcUq`T?SoO>(hpfhvWQS-iJ23a23HZ
z#_JhFVL+GU5ZhG*FLcJa_qXnjOxT>VSXG49HercNG$zvXH|tS>*dNU)6r!nT)*_B{
zf^LZ3fx;P}-FKoJjqX0%QOP{tZEoSp!>i<?E1@aqX-YoPJY8Ad{>qZR+km=L=O+UH
z>l?tispon1#%*|o(xfjz6wC*>G@P1gIvk;;n&0=}A}E|czJ^J3X<DKvMf%v51Wz}T
zOhkSiCcr-agK|;0Hs6CIr<)G>v`i#&;LX>TiTw^up+on<e6$upUzQM(lL6;%n}7s!
z@)h)PiM_C3m2!&WoJ!-7lEEi=$!AG79dhNqkHj)$iJC|1ri>}RgwfswCz>-h@VXc>
z{n63WmYP#1BN^(qK5&G;G8zkMdlkA02x}(IA65$^&U;EWP-rx8>azbu4Cuqpr#kyV
z@7K5N4FGi1>`vLxICBdwv@fys)jAOMau7Oa%45;)&0eCk4*<Ekv)U*03^x4aTQZv!
zQ)NX~T9Y}(CY`?08}RYoH7~7<z_YhW0PbzVb;8aK7DZ%M@&9J<K;ai0dQBpaq}UVH
zme^-pC}3D`^YZ>|?l8*ENEgp0Ym6$$3Bd$tT;+P#M_=H6xqK$kO<TP2<jU_{kq=N3
zkj6F_Nv^H1D*`NX9AtSv{cK0ij21vW=h2J_TarY^^OIaqM5fGQ_Z$nVdtsGPjm|pV
zBtvOsXHUlIi&*Vzc=(UIEA_F@Q~rMo=dta2816V|+OwZ?wu`CF(ELBrxcNrEDPz&=
z7GV14XQ0${h2Way2Aat+nkRZGk$iJnVxu}k7xPFcU5chIUT*Z<3hTCHRNwv6o6U{n
zD`IHr@|n$_m}FIJyF-<IykItjxPDseT-Wh<IP(YwD#MtN0#nrGxi{W0_W3db&El-(
zV+1bCS*DcDXKOMj=2jB7nw=^f14<M;)=o%FemKU0Ofd7=_A8YTMUXQx9NMj)p~>Rl
z2!W1Nn0*ot#;a?~p#56jBQLbxH6Z>wQnF}5P4#nQH2UvT_o>xIQaF36g%I&vD=#G=
z;Cw&d+me1(`TNH3nyI2VBtkb^9YD_N+@f7)p*g!7+t)Lwt|#ogRBJE{rffIr=kJ?s
z#64jIZh)p=oRy<soZ&rV$uN%;A2|16@5i+=$JA+?E~9CLbNJ;=(0~ZL(|+b4K3nu}
z)&%sujF%&@5CsQ!wVpRiE15|-jcirBREH%<+M+~U)wN1hqB5`#Udi%HxSKX9`o7Ft
zyv@1VM8Jy9Et_~RK4B@IfQad?)@D4<>&Sz++iy#piX2+W5h{K(;T)pnZSho=cAtSi
zyuDp~BW0D;fpWtEkvG;sS>0aWf;`H?Pi4z3O=Qik*9%FQrW~L@lHQX^PmCgQf*_AZ
zr%wx6dPAp`lt`4~YbL&jBr7Nd^+;)mJNkf-sh~xcr`)zoqL>Bs7Ui$R*WYP--jmE}
z09S<I55|TmN;C+9v!P%cb&&RJ7!BH{?L9Z2*Cb~GaMUTlna0pC4WtquPxK+;w-!y0
zCIuWr=$-JZBEz|dN@hKw_l^w~<&%$(A6<zXgJWPx7c$Mj5sbqt@$;}B%yx5eus<Ni
zbpDyX(JY{`ckC41a*99NlgTID@g(AIXg92~Ab_i2(D#g>?#{7W2uqxnI%8Qy<LNAr
z$OrpEC#?!dmD9X#Rn_@(75<s$p1SI7HfV3qR;o4A^FuD%Z%&tRn_>M3we@h!;Ei)4
zUdPA#WHs|-m2TGskcMF%<PVSbmiRvy|ESr7*xOUq`@*4@Wnb=4fL5JO^bGJ*cZkdG
z2r)$HsJ$!YAD1TTL$&C_`*?xyo$SHC`zU<t_vQFCWbu+qmvW1M)i?1le>-EA0waV*
zbohQ~eT%+J5*|(j19C`KYsd`gd_?i?_o)+9QqEjv#BpcM0(G6HZeA{gImq^oZYiG^
zg0sW4?5RVe0)=`H1*(od**T;{<i8V>6tjS#MZKRJVbIrIZFPXkVd)nXS-b@Vk9(bL
zuL?a_1ba<J>W+|y@rECBkdt_Fbi#TBjU!HJKj{8jgkPRH{cP*9_adrvkr&CWUQ&j;
z$dl|n-g0pW&?L?4XZv&$LS6SpO`L3sJK>=+16F#jnin${Skl@ZJRAAOC#xo|l6H<1
z0bK`;S{Q^~$G_oIZkTM<oV@8_D#IAZ9%}9aXXQ~?;{XBCk`MUk#=*OFFXghfy2YT=
zm$xGRa)sV<(*CnK7|}Rp)5kuKO1jr+be!cSE-P~GtAb(i<mU6m^$i{W$2cAizwLO>
zcn*S+e~*!j<X@yh%vCYq(EqEbzmv96G?Yg3!0H8*)+jT$+-O^Ee#lLr7l*xHAvR>p
z+5=pF1XfoT6#hKEJl49V_Vka~FNJ}e()Xqau(t|lv!7E^m{5)ChHto*7Ctdqq3b*f
z#DCy(-4Sho^}SBJ5*4rjoT-k^IVjT*?z@~Eri@Cm-$-pM7=IAA`}<UD*pi`+=!aW?
zF_={ptH0uiGF`qhih}Poer@O`BIVZe^6zpC9qY^s0jG)CAno`)TlYb`xXsvUh;{As
zb|=`XyXm);Box-zFF%$1-?Z}=htcEpf{9F!M1e9qY%Fa7NyX8fV69=EB@qtgxH}cv
zlWR6&ei1hb$uYroE3j-|uQ2B~hyPCB!qitkpJT5y&kmn>Jm3b^qm#Dq^+jycO(()R
zb)F2kE`fW`Iwrl{SiDXfwbocjI7`TDAsz$I&;Fsn{pN=(=x!Vc0sA}r7EQ5bq#JY5
z$9|AUQtt^QbJLLDK#{6gxkLM^yY%6?^!j5=t%T(-g2(YrNV0iD&i;MJ!d%`ruaig%
zH+TpQi#But@r891L*A4(5G`*J0gjhkJ3PP(x9~!=Te{=g)dFQ`m+G<|=lYJ3i4m8o
zdxsYm<jpn)Vsd~4I!4*#A+b?Z(NtaxQa@kX@u$Wy0PP)mi4bGIDPk;wrB=Z>|7XwJ
zDB_wIluQl6t;BchSj%<RDCf7JYAJE+&}J$}YaLpKVoHsFLIfK}a7+^IakEa#4-->s
zdaXpT3hCb;To#pn4BH&r%M#>-7IDJOV-NW<jfPy8?*Rdv!L2Rn0kHCMLF1R^`KP%S
zyhu+TrzZMw95h1h)ZP@;Ec3(esTu`H>}SDAa-VZxmy-NAh`(I~1I6`4m6dQDM_naf
z1w5oO;*u_D8=H{ce(BjybH={ySu0Uw@mknK^gn3nv<Y_O(@^cPy*QWK<XD_%=mL{Q
z*3dLdH4zwT%zng_V?V2G@2K586U(_Xf9Gb^8EkqL4Wh@cc}hTtwReGK&~@QTR6-|I
zOw2OWaO};qf~^qlBw|)1lp$>}+S{L6`~d}N5frF@?K{1-%k5jbKjrbFRoc-wf`@+l
zPpYUbKezdzy5na_x&`FpT5Bet)u}tNAVmY@!<~LF<LBF{&F_1CTrNVNyDl8}$$-|>
zHcWrh)Q`4{g;y@ZhhYN7i&Yl4Xi(t)>_1qL(@d>^cd=L?Y>6QOht_T>V^fF2s{rbF
zef%77>b!CKnQRs^$eE&R{^SJybqlYlm<jBd>Z8wby&Nnivvez`7*b>r)k79>s<+U9
z$h}*ah#F(pfx5ly(<!#zENg!q+M>{VEnO&5SZ8FH`^QpP{m?<OU^N)+vkBtmto2~v
zu*&#=b@e32`3m993A&Woh%*Ch-qzzW3Vlu+L;grp3J6_wv8jF*wqv}(cmt=U^V0DY
zlncDqb&0_g3SIX%b_wUWq_8x`E1jvK(5&r^LZMbWt&K6wes<Cr8eBWeyy<wzHtDaL
z2RqNOc!<4<62M9aL9tV>vvmMv84G7Gg)@CEU0%o$1Q=DtncdUO-8P&k`^tEqi|bPN
z#B-GYdM{4|LVK=MH~PC^_NNS6GFH{KMI`iHoz0yJ%u4XnG=GO&pFhD7L!6Va?a<7A
z>`frG7)8e;OXul2|3<Tj9~QEp5?%v`0^<Pi9Z!6(hiKgc4KB=Q>Q153%|Hg>sO#Y)
zD)rX0X^xm*m6io8H23q{;Lq#8+3YE%g^Dw?+XSkwuap}WpVAz~DSfA#vNl>??RX^q
zdV5WmVd0~F!B^^8g8788oa*#Hk5ZhX<SIrVdSHfSBSkX%M-ZD<1TvG_5(!oA%Czmn
zTSU!(ncZU;+)V}kh30ZRzDNUB#_KdOxY9QClk^M&`(HdqLoNDi8c%0s?BfxfKW$FO
z4aR+P97!<kmL8B|&uhY>esBNYYeX(pstNSY6%=Rp>4PQCFE%!CuEm&!lejh)-T+lk
z*{r0tQt#z!Xp*;ey;BKU_m*(q)Vnk49J%IhI&(u2(pFAeGN7d;eC+ml$RCI&9BlVn
zr+By5%0}f2?h#VMyO6K0mDtBaKcML`E<}9A1qt?#x8g1WMGbe2Oc-|QgSK=RMVN1l
zUrIiYPE)jFRe(2xENRU%lss|YvXY!?|K-**z#G4@K#<R^o>mtcvJ>j@K=YmOF_;`h
zz^8rdL5?)@;5Y-l|MI+RSEtYR3>5Mq3@um+yn+@WWSi-`#&izAw$wCYAK>o8N#^JV
z9cutGjj9HWLQV_AIKtFZ-H3q?I;_#-vJACR`5_F>ig;bTDO{{05J+9R9T2`8xwq>+
zjx4UAL2>o<r^>F0HE5Q^5i!4B(`^$!ry8z=k-oH=b>~^AA<73yIRAseW;ydgHZMd?
z<%|NiD17@1#VoIHF1lDaV0JN`f-l;FMQ)vKzv@!t2Fr9&OIH3$o7jg1aZtj8N?~hI
z0-)I6*IJEu6C5>uu821yx((ce%-;YW9&{zS0igm4X1H>PLC+bB7PY3uty0y}uE;eN
z>XP7|8@1f&f0_i)unB%EK>h7^Zs|i{Ix4zaP{d9d9-)s9m5B*UdliXWkk8}nE(j8Y
zS&7e-zrM~7Uo(y$@nk&Io-}98v&>bl{`>>Sd3Rg{VC%0<5R?iv(qQdCESk9~2}FVe
zUXZ{}RQGIZagn-x#|SN9w&<gLGEldu=iXC{!p4Zq*Hm&2w$7PwXzw5N373Lbb}J(}
zX|5Cj7rNW*<onPARj-sqOfWJD8O8u7Q>@JY{6E+xNuBKw<<M-OVPgUD0kC1DG_pX>
zqVgu44e&`r5Uo!ue_-Vk@!4|>Kz0YP(irXM7u1S2q;N0^;fbDA3F>LUsDc&;KWK$X
zZvpo(6^o!}+1+j&Z^wXY*(Dz-)SQxx$m}Eho~bIpbnCMz{X%gCIPEYP@)JubOyHmG
zQCnGb7LP)N!G^c45-E#{I<(S?5bz#E2jnXi#IpAK-`iCHXCo!OJf5D*nRTA}Lv3GP
zG=wWY7fwxyXy5Mvf*0gPjVtr=hPL2FS|L-`FWNiOlX#bd%m6gMHOT2!X#0*nAYF*u
zq#uLg-4N{EbiFZ?3HI_z-+!ucVtL;HyKq6t4*Ivs^ac2H+MdRQtT#lYK;ec1Q2uvW
zx7dr}X$~7~1bRhce50MbEC?g5dv_pJ%pW#T=(#YA+hQ$*##!g5g~|ovvYohIL%dRX
zW6f*%4}LgKyLdC7pV$z4Qa6R0Y6KwO_yxJjQiXO57=Z!aojOHm$()#~Kc&4TjxsT*
zjmT5%(tZHOH*|_+SP(~x;E1w$dGSK>aJn|Ugpr)5m|Pt$7Xro?V2SfZX=v+?vB$rz
zfpjWdR0h<g(1`Kr`z-WUnd#-cb)ihrq5*2T_<cgxV_sFZt)ei%W?eF2;=n+O;My2o
z9|6eH8=>!ulX?KuW^M7-YCuWDy*?V}nzwIeQ1`p<<f~vmrB(+AvVp{Az47E)vlY%&
zsE^c2$<QY0G+B%5Z+<Bj_Q;`!f@}K%_L%TcJKQbO49IrY%~5yg`?~CM{s{Q-d|xQG
z`@ZeBEOENYF@miFj+g1yV=$snFo$)8gHrgB*5a9c_lbrJL$A!nOQg;2#bt=4W7Wmm
zr88ftuaH4pK#D*m;*j)3PgagDBi;2?{_rtpO=Kf);qE0@cLao}49EkNzZI?fC>zU~
z+Bh~G;y{|)KF2dZoUu-kq8$k^wfOR=Z*p0p_DbYzksecfEkiu2Juds>OOF$fp@}I`
zPvlB(@&FpVpoXMRC|~{xHeOIZt#4A)c2W_p(%E+FQxBq##@diE)@iD_H9Iq~$X=Ku
z7mjE;MsFP*5$Xop^%iva%Zm}w3i8KrlA8T>Hp8}O!Kx9G70+&V95&j{FE$Z5+b&$r
zzK#716uj&S8#Xa?bUuV$hJfVQo=jybkp21Qn;ccjcId}Iahg?qD`JfP4o%S_js0hF
zO=wjTL=Ypbl2l|If>$eTp}36(LM-P+f9IDDRNm?|8gn45Iyfr9q8=O|p88LV%Zy4<
zh*o@Ros6;;JJjfh=V0j*F)55JVdkc-m2QVfNwhvN#N+UfSYy7ds*OZnoEr>c{40==
zvFJPkubX1Jkt5P6rzajU_WEVeoGf2Wg>jf}W)ZbyEh_E_;r_?rOlLAh6_}A()Ld7g
zAV)`thWS!bji2c{Lha{dM3{C^-9Aw+JI!n;m~c+1pC5BQ!XbO6Z)355oF|+!`$!f+
z_hHOLblUid5=D)P>Nh%A&|M#Q$wRs-Y$|OT<f|w&RBJxeTI3-w(|5wo$wzobFjYP4
znPiY?1Mh`(3ZWP^b~k2t`9x33&0TM?qkr%kCV<hc_ME*sq&9Up1_LwGa^im(`)i|Y
z=Ye724Zl!{-&L{06kQT5`i!3Dr&KvoH)#G=J70+I!yYy%Q{*G|sS{NqjgtS2P3E;}
zs9z|u+2%L_%;NdtDdD|-!nh!OiLcq)t8I1bzr}NJEf~AiFOc@`y)E)}c#?=0bZFj_
zE@Esf`>+{#H0TI@|Cec<y|zJyd-TPa6WZur>{>a7dcArITx%H5<MB3gqJ}z657e7-
zX!GHlxz^_q>9)LHSa-o1d(DPeZ$_0jZOoWCZ61K$I|{DrJ~D<atZH5DuDwUb7d{QE
z05=1tle+}TR2uqd1Cf`P4Ptvs1Rc>FpS_TI>}EW&>;uoz6_7iIVvgJG&8wMF|2*#I
zqC4xZriHgW_OdO>Ze+uIW|B<jlT*nytu4?q>DybRI$66~&?=baG~Ls*DKuES@%2+{
zLly6*4zZSzYE(v954s}-$OQONuj=$Ew$!?r|9Wb5o5#wn720%OjojcCwOA9KQKB}Z
zKF?#B`%60mV!Y&b<*P^qWK85jk2sP_J~=oh$ZzB%qWx@2duXt@N0r&J`c^qW3^8X@
zy>XN0A$}2<?J#4gSuR+YI>zoq{oV&&od%R|GIUkslZGdHs)@4SW67og^m_n6zWa)8
zffz&PD$kR8r65U@?CQ{f!&<bj2CAytdyiXEOBmntI6T3Z?jZ4PgGMc?MM>l#gZus_
z$S+N@x^ouARps4uf`uEVa&NUj!4)s7OEe9x{(5^eGuIO&#;>93+L<Ps8C3WudB;8+
zt~lbdyA8k;6o}CPNQ@Df$<3nM$laBmGk5v>JrGYxe}3_E=TPIauap_S379Y6>C;_*
z#>Jx7LXlg_1KvpBUm(`w_2(Klv~1H)5vM*Uqw6}_x#`@Hx82+s2Fv8)IW1?TdBVhn
zRJMdLKn91S1xsBtDA>KfUuz00$Nd9kL0P$?kEA8)TE0^a&#JMmZFy=_3=w*`%3<oK
zI;**~rAoo_!G3&3wy)hRbHN)eA`NT6R>yO)$5z{B`xM5;BU5G@T48P#@iNRS&GgKq
zx$yFzzQrq{WW*OadT*4MB>y}$!>m$beJ!FS+Ha==)9-=b_&XV_6PcRU>n>A`czXE2
zu$+Y=yP-C3e~A}hDO-3yCcXNORL_pIxd<DtS<3>Fu7(>)qWE}^)qG39D~Q`J2BKfD
z?$VOIShzjaqCTd_4~jk{TiTesJS&C`XPCM++QYj>c=>_0LXSg6s;knM9Nb`Q!GJoG
z6_w+s$W@t9cYq!1bi5XSh&0sn_43<v86RzO`)_90iR1V6UyNR&YbhxESv)Eh0;Zz$
z1aG~0BgbVO21Nk@4gT`ifpXwktIgrgdFWV1xv_9LLmX($O_82|8G29u_dPmpuETnc
z4O}0_r88VZ+is_JBAXyHwOjF1=G{+t?w<JB#3_?D5yIRF5S_oom&<{cCv_{|`Wfuq
zE&nx#y_i)ic-buN=b$BqKLS3fPXe;aS+`~~yvnw$!^}i0NrR)Uqevy*Il?eQo&XSk
zu>K~y*W(BTC!c-^4y=8@CGZ-dlB!1StuI$yjnsfn6T)jVCJ%`})PJcTISF8+w<nAn
z4z^8-n#c}L4dgcGZ~?Ys&~Tp=bn9`N+Lb)&G=(E!d~rD-?f_q{@)L#^qw=~=5REHL
z;@Lm%SSSnTuJh7lMI(bsQs&{<q6d%0>?t)cBT9JHzUe>in1-&V=HRa*U=a0_nTEgf
z_q{TZr6jp3sPc0=rx+a;G02wuLB*abLXxj&cRQATReZW1SPtU{p40)<0dL0~uIGpO
zi%?%96myc*>A?uaD0|Zl+Iqoo;AejuS3Ple%NBA`<oesnmw#f7)eb3la$x$?7PGb;
zQ2pYyt;o13Yi!P2)Z`v02FWtFQ^Ehsj+@(~1Ex<Pv>rz#0bO>yx_)s)O%PtuPi<vv
zs?m;@k%(!3X!in8Y8Y_P?r|b_OQvt6E6l)Uu05lFtfUe^v>)}WVDj2W@r}IUef=Qo
z08%E3TN!zUSVVaJ4o*>`M0HYKq_|$xt2jpHm=DPG=wg~I>ds*#(pX58a!;tgBocTf
zm<9>as`GS>I~>V{H+S^tuhGaFTYqc}VRO#r$bX)BL1C-g8%>dV!wFBRMW_*IFwI1b
zX}F!}bto*s{(3U^n!Dq~raOgEJ;$u+Lvi}$*eZB3+z)#WgvX}H5z_)m;>Mjk^J;a2
zk?rVa#DK#hF|uVc-!yzU&S#;t=if~J=CNoz2P4|zK7<SvVM@=?MQt1^A7g+&rf6^u
z3P{}bv{gJ`nF$EOc77I*P9>{L?2?I(Uv`l5vVuFS0~EIZO*Yi&RoBGQ8o?SNDN;$r
zsBE9=84;uvYlRdjQtEiGk9Wy)o&*$r0Y06QY@da8MOD>@rbWb(jbo(OoqyPmc$mZn
zw|2`0D>$gt8=EHs@laCY`~|^@ER-R1hpOx1b{4bgEw0BMzHdxlqh{{wFCN@`K}$0&
z``W{@XfKzN`Zf(EnBqRh1M4hM+?^IQOp5fW>*`w&?(X>!2KGEaYP)6!IfI=+2qsWS
zRtPJhak{?os5z2Wy52Gy4oH}00@M~x3P`O698RK%;w5qs#i*h)6`S42=?9EIm!Vr9
zyhX!JjDI*|Hb;ioRA%D^Z0*61!^QLreE5hpCm|~vM@P=?23;=_D~?xxoUaDSqvB@X
z#P*9r(;7);zE#s?4?8k;uif70QmIcv_Hewl7<5r?IHEB>5(uKdIs~%g1*EAE?P^t!
z2b#rSM27BNpasn?Uxu1bMQilrX$y>B3R0-uAfn>7#BA#BnODx!3PD@ug)J~(qRsnT
zJh%%R16CN3@&WtmMp<SJ+P*YPh#b)T%I@Zgqnr>6|31n6+Cf&<uAJURU~~7cF2tAz
zrUsZit4aw2-f{SxNGI%m{IdeG_gB_^R-Fnm{&u9TGaIrZ^wp(z<|c*8T*W7%ePFQc
zjxQ&Xz+1TPV3Q~UeqIgWES*$aVuQJ81~YR1M_FY3TpW&!VcE}m2CA>3y7^=+_<U(R
zh5yhFSlf`&74;ygd~#7fgkH6y)BYGs|B<n9iCmq4ET_K4hY`1KGs_MdIM#sms20u5
zxKKhZ#~11>l_agEWJKtXsDZA?u@&Vb^2ZQ^A-t1_s3%!GJMu!Z_x2@M9g){`(#B~;
z%e}pl$T7AkT$JMJZ=&@Z)Nqm+5_sJSx=P;LStc@$WglmB?ibE(Ixz9AR&9FcCtF#D
zNA<qP(2DkYU<m`uZko-NQy^M{Wn$X9d<v`fPM7D-%PcR-^kqy$?r9ZfMI@nqX0p@A
zbsmzT-sq{OVmP*)puUbce4}_hQT9?5kuUVHp%x}BjnC--N}%_^<wf<1S$wNZ%gEUH
zNSz(4cg3+wL-*(N(43eP_{$D73O?owMTBeT>>!9OzjYOS9OOE~+70OjOpo+qS%-QT
z{k+Yz@K}9V(%4`n4W(2MoD0;Yp)UZlG|ne0T|1dSYw?`79FEZ>ttfxBPM6&_T$<#b
zPJ|eZs&vjM69u(ug-vCh4E929b)uukJ^0Dz9N+lJ-(jA&Rse|AT^`*>@}*StH(g;3
zr>7es!4hod1wD7Mn3(6|y=H;;>GUH!ko~4HCb*#yJaow3l{36f<>Ec0hP+gJ$x1WI
zIh06VK!9@7c}Y%Kq7+MByEMnR^MT32eH6>o^~yQev{^JJ7<Wr7HS$m$H`85%)v6-}
zUQV!{>)F$buYb+vvx?5`Cq3V7`)P8teP!H%Rb(zrHtN;!s<u}pDvACV=k8GiJ$s9*
zL=aGL^)E$n*$}yB1Sa^3l;HvOe@z$(=(Oeitx<N$L0d#{#^lNLu4`pUgZWtO%*_4G
zfABS-LGl`)tne&#)2Tz<S<vV#Ltze`M%U~J5UQ+UHLX8*OA)K3k>k&99tE7IunCzB
z$Ou&L(6&N2sS}kmt{6_1)^|1%{1-T7futf_rg_BfY9sgfOUti=97e4gL>gGOE>E@l
z03qP9K!l<te#eNKhhKqMHlVo3yTN%M1e&p3PaweqDLgbgME03`EFB~#S{JwmLT9f|
z0HKI2v_`&}-Fg8jyiV6o)X>6@_MG@d5ya5xx`c?GWk!n3#o*H`v<d8tLyua}Dyv<M
zBO#5CC^s^qP>$ckZHq8#$HmNrjgzziBsxdn&0$ZT%O=oKfUp?oHs9foJfcQ@ZgQ*d
zZ)<Y5><w3og;_klv9-PV(IS>{shtNqQfh`+ZcY4ff1gg&1S*YNUZ)zYr!^wTNpm?!
z5>W2_IQ-wKh$o>LVJS!0Rv2Re7@++7k8&GHQpkGdw6C5ike=8?GzbPP?S%62`~w&?
zq|{x0v5@~MDP%7-DyeYG^OQco=gLX2rL}J)SmdWI4i;xcbCJI}JXtqs8atp-dmDz*
zE<-^<t$|y-2InA|khw)o$5aXjydXN9#aWQ}lO4g<brW4Y{UJ|yK&@jDfjGH~Yg$8}
zN26Z`6O`MnTboA-K|1MSQIs7ls;5n!F7#sQ>e<JSKY@ZSgk5=Z%G{&O1FZ!Uz)WtS
za2fj;@6As0mL(AKJ)@rPnx_e342RTXO!mX)ULkCMk}<hC^iYbyv6FiaJXs)kA7Ud{
z3w$5Ovj?Qtk`sLf;GUz!C0LYwP@y1LAkpFpdDkxWKk&X_$Z;BATb?vc)^x@1Hc`Wl
z6rAeX2SJP4{0&eo(dgYawr2ajW9qHN%L2}(N?QI=C)2AYxV?WrC|f$a8I7xs$O#%&
zNpjBgJ9fnm>$%QUN*j5F>ymnMy2zVnaulCyLbZV&7%1XIip<(yCpM!#Pz8c(NyJy@
z-Nq6@FOF}zcIhs}&k9h_GG@qJ>R7C%4P4AB=&qUXc8dp9iP*$mAU*}cIUc;LaV#+M
zu-ZFa`4)3>ynUx$er6D$^=qj&W{*^&<s+{syMYb&5M^ciLi-W%geP#W&w#L?2lLF}
z;}>ZQhLxxXKN^4*$>nIBB5H{MlmL>sP{{3b-2_gHxi{?M=yro)RtFetW6B9yN0l1@
zVx(-grHWef8%nw|+SI5yGgr=kQ&G;t()~>ab5wD^Q3xoL3P0@eU8fIsw^k;s+k?2v
z@;zgA9#s+E1!kpJ#<H;4qreEC7`~;jEw100#cSDlHP#RL6<mspPl!a8kjYRNV_WI}
zt>~&oM&_3ku?*4p-aF^fUd^$lJu~__Cpy1z*2*4-au!P0)!-60)w`2R#0d)LScsEN
z<q*To=^imZ@W|AmXorfdN~OKZY@#d8)6{p^b*NcxsEs;QfiEhQwp8ULZH!VW>go}u
zW6#j{V(#@nmNzLSN@ppVrx6P!D$cVKJ9f14pBU}8!Z=Of-N$5}1)=rO;t%#>t=Cpl
z>wG+pzl?qtb9)h2UBA6sKy%(Ec5`p9551nayB{3%8z(v$lP|R>-KqmNBY%mCEtt(A
zt@l6Erf2i1zf{34>gmTjX)JC#@kw$Rjg${~H<Tm6<ZTp~NG<^puM3`>p7syN9DV(7
zGm6tBihrImVvd|NCK#|fAW*|7idJkv+<!E<>^=y`#VuS7;)ucXXJ3%eO{kv22o#s%
zzbVJf68Ir`LkD{_Yn)@j(P0o)!MPGmuE+ZmxU-@1AffOcP`lG-Vg-RNag+rOG0lQ>
zwSUJu=)n(N%R=NA(`TNEPrKX!jxX-|8U=NSq5uE@OTqV1mWZUo00GvS0f6w%0RR91
TZqU^+6c;-%0{{R300dcD09`$<

-- 
2.49.0


