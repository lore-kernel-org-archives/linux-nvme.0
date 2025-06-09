Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1718BC61CE8
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jun 2025 19:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hw4kZWHGoUU/PCWt3viCLVzQngG5gXABm1CubflZKOg=; b=ivYBiFnK9UHUgVF/LxapXJX4LH
	pmmdkfhGapHXY4kf3nJiqOON78V9eA0wFmu4gkdm36Xp9Ieb+IbiRueS+EyN1+DguHXUqqAUPGXC8
	1tQaz7anTHlzjU0Q8ieq9CvadY5GwE+TL5jTPqLniznUZYvXOnG5d+7OoxCaCcGCOH77PEu1n0Mzg
	mlJqPYpvlveZm4ChlBuuJpW26Zj++MnCVf7iW2N+adygflaHOAMYBYNq+85uz5I4+Qt2wq3bbEIW5
	p+3us7saamvoG5TGjQ1zp4nDUpuKkJo+D/EryoGDTUbkFjhagzfpKmVrST29O/v/iLpV4i2INHzwv
	uzV8q7qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOiOA-000000053gw-0Qqp;
	Mon, 09 Jun 2025 19:42:34 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOhYs-00000004wdy-00r4
	for linux-nvme@lists.infradead.org;
	Mon, 09 Jun 2025 18:49:35 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559IidjG015233
	for <linux-nvme@lists.infradead.org>; Mon, 9 Jun 2025 11:49:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=hw4kZWHGoUU/PCWt3v
	iCLVzQngG5gXABm1CubflZKOg=; b=ibmM97kI4EkmC1jmsJnK130ej6WbS32LdM
	cPBD2frzfqSEl62y8L4V/L55+nZSYFSH50Wx3ICAqn+po8SpRWahL8yIxiVg9sSb
	mYPDMFHGOoVqKva/5jXPy5MtdXCxLKHgKkARGjts0X5VKsyfERh4a85j4dGU4NJ2
	RKFOSe3jjRUV2MAP14mM+qSaQndsBNQwWYgF3Jfi4p6ORMaHwLsz6ojCnAHGkvAi
	CJdwyOReETj1FxVdlUaAfzzeFymJsEHvz9zo74GHlmBRGICj12XBQrpXKZfPrgKL
	//9wDyBwXV7tkX+lomGzmAS9GQWnehdYm0gfxt5qEwMcctoyHS+g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47654082wy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 09 Jun 2025 11:49:33 -0700 (PDT)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Mon, 9 Jun 2025 18:48:58 +0000
Received: by devbig209.atn5.facebook.com (Postfix, from userid 544533)
	id 54C657CC5C0; Mon,  9 Jun 2025 11:48:48 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <nilay@linux.ibm.com>, <sagi@grimberg.me>, <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: reset delayed remve_work after reconnect
Date: Mon, 9 Jun 2025 11:48:44 -0700
Message-ID: <20250609184844.3158382-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: gjl53EsZKDO6vmDCyw_QCtwm-jQFXf1V
X-Proofpoint-ORIG-GUID: gjl53EsZKDO6vmDCyw_QCtwm-jQFXf1V
X-Authority-Analysis: v=2.4 cv=XfiJzJ55 c=1 sm=1 tr=0 ts=68472cbd cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=pmRgwwnzrKEKzS_dmGkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDE0MyBTYWx0ZWRfX9a32paStzn8l YWR5yQBFE2O8pZZXXbrwpuL7OW9Gjwx6NKQc8mg4/nn17ikVmDV3D+6i+fH5jXKP79udPtk9oQZ qvNeXwcq7Po99dVMJ/V8+BOIiq7US7X1iCLPDH5PXmVhgZeiHVLHkQMdF4+6H9iltQF6k1ytERB
 ZgmH1Qy+sEhLweVgiBPRaaVMyOiDNdpuvtS+NbYawA7deJk/+Ia9AHrdPMt1csnJLa+jxqVQEW/ iAk22ruaIuzXR3UpTprlpZvBOPPRaj54Z56g6v2sehpVsGgqFyF+zg/6s6VlgDmNlZiEq1cAA8f 2kI7K37PNQZIi+6a7KtaJtFpjTggOj2rtF/BIQtb0Bg5KB95TztGWC175kEESgOAdVQgYpUUw1+
 ujU5slMoA8pFlV4JlQP/UhhN3/dYWzPUYI2Oyrnuo5tNz64BebkoX5DPq9x97RPLZBET7rEU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_07,2025-06-09_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_114934_047175_B44026BA 
X-CRM114-Status: GOOD (  13.79  )
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

From: Keith Busch <kbusch@kernel.org>


The remove_work will proceed with permanently disconnecting on the
initial final path failure if the head shows no paths after the delay.
If a new path connects while the remove_work is pending, and if that new
path happens to disconnect before that remove_work executes, the delayed
removal should reset based on the most recent path disconnect time, but
queue_delayed_work() won't do anything if the work is already pending.
Attempt to cancel the delayed work when a new path connects, and use
mod_delayed_work() in case the remove_work remains pending anyway.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c      | 4 ++++
 drivers/nvme/host/multipath.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 92697f98c601d..724f5732786c0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4036,6 +4036,10 @@ static int nvme_init_ns_head(struct nvme_ns *ns, s=
truct nvme_ns_info *info)
 	list_add_tail_rcu(&ns->siblings, &head->list);
 	ns->head =3D head;
 	mutex_unlock(&ctrl->subsys->lock);
+
+#ifdef CONFIG_NVME_MULTIPATH
+	cancel_delayed_work(&head->remove_work);
+#endif
 	return 0;
=20
 out_put_ns_head:
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index 140079ff86e6b..1062467595f33 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1311,7 +1311,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *he=
ad)
 		 */
 		if (!try_module_get(THIS_MODULE))
 			goto out;
-		queue_delayed_work(nvme_wq, &head->remove_work,
+		mod_delayed_work(nvme_wq, &head->remove_work,
 				head->delayed_removal_secs * HZ);
 	} else {
 		list_del_init(&head->entry);
--=20
2.47.1


