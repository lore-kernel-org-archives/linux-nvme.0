Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFF5C54E67
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 06:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+194agYoW5xBFhHV/fv5yL0cwebSRCKACCgRfZK60oI=; b=w4/Bbus5jZK6gKWaQKvkJyFRZl
	97s/7wXkTMR9JUMvuibYWOw1BYDUVv3b7enXrnASDUn9PbwJD4EiWruIWtw3/bGcUA7DMwyXr6SW7
	Qr3L4qPCap2aHeH6/d/CFDzs0aiLYEDdcZxZhdPM00bfMgIMbM31lRjvHFYT6B69AlNc1RYDzaiLw
	iNFdnoifahq0CmlNdmzMNZwHWsuU6g77W3T0pkuV8GpZ1tW5wSlQJen95Jxp7k6bXKA5CRqK5/EBw
	BC1yMstOxjNuRS4Xa37C+MffJHOv+6Kwwvo3NmYmjCzTnZMHvSIo22gHYS4URNNo3eSZ8xHmnZH5k
	PMP7vecA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp0lB-00000003M1b-2dcu;
	Tue, 26 Mar 2024 06:58:13 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp0l7-00000003LzD-2SFC
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 06:58:11 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q5rwCg025834;
	Tue, 26 Mar 2024 06:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+194agYoW5xBFhHV/fv5yL0cwebSRCKACCgRfZK60oI=;
 b=hksVgCCTQEeOzuprY9gDec79Vr+cH0fNVbC42c2Op+oyIWZLzvbMb9sYKEuVUgKUVUjT
 EFYH165lhy65OWo1RzEt73w6BFzatKx1uqof/+W/hF+UO2AW8EOQ/M0Ypmjgb3sBH4rH
 QdpJPvecNDgd3Zc8jYTfOK7gn1JLJOoFI7fOlheVVCNmqO5c9mFeUy0dzuApOfxP4btG
 5Q8r4PU7h5bBkXDiXJxQMDLEP+OGKocX29W3A6DYEb+PTC/H+hbvdUDGlGciGWh7oALV
 6P3STfzYec/fxypz3BkfASeXqX9i0e+HoRIu71OEHbFgwiz/oEQZGIs/LetPpZUdq+SG Nw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3r0nr8f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 06:58:03 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q6Ghe7028675;
	Tue, 26 Mar 2024 06:58:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adp651m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 06:58:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42Q6vww239387446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 06:58:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5487C20043;
	Tue, 26 Mar 2024 06:57:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFC772004D;
	Tue, 26 Mar 2024 06:57:56 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.202])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Mar 2024 06:57:56 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, dwagner@suse.de, gjoyce@ibm.com, nilay@linux.ibm.com
Subject: [PATCH] tree: Add NVM subsystem controller identifier
Date: Tue, 26 Mar 2024 12:27:23 +0530
Message-ID: <20240326065752.164286-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qlCOgrTz0dvgO6fHwUsGq-n-7xume_pV
X-Proofpoint-GUID: qlCOgrTz0dvgO6fHwUsGq-n-7xume_pV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_03,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403260046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240325_235809_973497_D98C6492 
X-CRM114-Status: GOOD (  21.37  )
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

This commit introduces a field "cntlid" for controller,
that contains the NVM subsystem unique identifier assigned
to each controller device in an NVM subsystem.

While attaching a namespace, typically user needs to specify the
controller identifier (cntlid). The cntlid could be referenced from
sysfs (/sys/class/nvme/nvmeX/cntlid) but it would be nice to have
a direct option.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Hi all,

While attaching an NVMe namespace using nvme-cli command 
"nvme attach-ns", we need to specifiy controller identifier 
(cntlid) against which the namespace is being attached. 

Not specifying cntlid while attaching namespace would result in 
no actual change in namespace attachment. For instance,

# nvme create-ns /dev/nvme0 --nsze=0x156d56 --ncap=0x156d56  --block-size=4096 
create-ns: Success, created nsid:1

# nvme attach-ns /dev/nvme0 -n 1
warning: empty controller-id list will result in no actual change in namespace attachment
attach-ns: Success, nsid:1

# nvme list -o json
{
  "Devices":[
  ]
}

Though it's possible to find the cntlid looking at the sysfs file, 
it'd be convenient to have it readily avaliable under nvme list 
verbose output. 

This patch adds support for retrieving the cntlid in libnvme, 
the subsequent nvme-cli patch shall use this information to 
print the cntlid field in nvme list verbose output.

Thanks,
--Nilay

---
 src/libnvme.map    | 1 +
 src/nvme/private.h | 1 +
 src/nvme/tree.c    | 7 +++++++
 src/nvme/tree.h    | 7 +++++++
 4 files changed, 16 insertions(+)

diff --git a/src/libnvme.map b/src/libnvme.map
index c03a99d1..8710c41f 100644
--- a/src/libnvme.map
+++ b/src/libnvme.map
@@ -9,6 +9,7 @@ LIBNVME_1.9 {
 		nvme_submit_passthru;
 		nvme_submit_passthru64;
 		nvme_update_key;
+		nvme_ctrl_get_cntlid;
 };
 
 LIBNVME_1_8 {
diff --git a/src/nvme/private.h b/src/nvme/private.h
index 11744c25..723740be 100644
--- a/src/nvme/private.h
+++ b/src/nvme/private.h
@@ -86,6 +86,7 @@ struct nvme_ctrl {
 	char *dhchap_key;
 	char *dhchap_ctrl_key;
 	char *cntrltype;
+	char *cntlid;
 	char *dctype;
 	char *phy_slot;
 	bool discovery_ctrl;
diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index 584e3f6a..6efdf992 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -1008,6 +1008,11 @@ const char *nvme_ctrl_get_dhchap_host_key(nvme_ctrl_t c)
 	return c->dhchap_key;
 }
 
+const char *nvme_ctrl_get_cntlid(nvme_ctrl_t c)
+{
+	return c->cntlid;
+}
+
 void nvme_ctrl_set_dhchap_host_key(nvme_ctrl_t c, const char *key)
 {
 	if (c->dhchap_key) {
@@ -1117,6 +1122,7 @@ void nvme_deconfigure_ctrl(nvme_ctrl_t c)
 	FREE_CTRL_ATTR(c->address);
 	FREE_CTRL_ATTR(c->dctype);
 	FREE_CTRL_ATTR(c->cntrltype);
+	FREE_CTRL_ATTR(c->cntlid);
 	FREE_CTRL_ATTR(c->phy_slot);
 }
 
@@ -1800,6 +1806,7 @@ static int nvme_configure_ctrl(nvme_root_t r, nvme_ctrl_t c, const char *path,
 		}
 	}
 	c->cntrltype = nvme_get_ctrl_attr(c, "cntrltype");
+	c->cntlid = nvme_get_ctrl_attr(c, "cntlid");
 	c->dctype = nvme_get_ctrl_attr(c, "dctype");
 	c->phy_slot = nvme_ctrl_lookup_phy_slot(r, c->address);
 
diff --git a/src/nvme/tree.h b/src/nvme/tree.h
index a30e8eb7..1d635baa 100644
--- a/src/nvme/tree.h
+++ b/src/nvme/tree.h
@@ -1025,6 +1025,13 @@ const char *nvme_ctrl_get_host_iface(nvme_ctrl_t c);
  */
 const char *nvme_ctrl_get_dhchap_host_key(nvme_ctrl_t c);
 
+/**
+ *  nvme_ctrl_get_cntlid() - Controller id
+ *  @c:	Controller to be checked
+ *
+ *  Return : Controller id of @c
+ */
+const char *nvme_ctrl_get_cntlid(nvme_ctrl_t c);
 /**
  * nvme_ctrl_set_dhchap_host_key() - Set host key
  * @c:		Host for which the key should be set
-- 
2.44.0


