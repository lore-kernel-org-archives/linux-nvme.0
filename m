Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1163DC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 12:25:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F33E613C8
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 12:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F33E613C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bId/Yjdv7H7Jj5yHPw+3SIwKnOgWt4A7bEWqNg7ECuY=; b=nnNdbRpl6tV8jfl1VUnaeVc+W
	zPxiIk8/Yn7VYdkKTTLF+EIx28P6kGlw5XE776Pq/hCCM0YcFNLYvDToUg5ole5BxlVZipPqC+vk2
	Qmsehmnxix7F+URdkdwBaRuxma1NUfQt0nbcSGoXB/2Vs+Q5qbCMSiVZoDp31ImH0f4T5fw3IowgH
	nbl5Kdfks4BnKB7WrZ0Fevo2YfVDf1pTBFa/Ur6dwJuxQ0LMbQ4gWhXJhDXm+1i9pmVROicCLm59Q
	oFaRJsbvpw7is7wVhu0J9csn5R8gUX9zzB1Gn1nh4hP/yGELKoDbkKFjYQdqOUbzzRODV97HrBpvf
	p2rfD/E5A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lc5im-005cNm-R8; Thu, 29 Apr 2021 12:24:44 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lc5il-005cNd-9w
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 12:24:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=RYv4cfgiPQIM67KjMPxV358Dl9E/myKX0cG/guylX3Q=; b=ZADcjgmaKpq1SMm9PbKV0JUDem
 xQ4VFe4WwBQq8RYvJSiFX+ITGEcavNvXC5+1V2ftzOgfMHh4UTO00o+g63qSL0YSor9xdhQex141u
 XqyFOGSWuDi1BF7PdNtse6PbeWe6K4qOUiFd9L8lJSND4EN+nrxAakygJsHAz76aeM1WY/nhixOFc
 g4+ZcdP8/7AJ29irfoarAkk3s6oLXqSahyxTA0iuOjp0Tj0ZoJWaPPWwOzbdByUjhj3l5JpnKegS5
 MvRCGb2uDgxdyDjjBr2SmnQl7rasPbBTEnvYzIBuSUePb7xvaoKSvaTsLAJoZecGCCT+nkWppx6Qf
 NeaNNx5g==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lc5ih-000cPq-PK
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 12:24:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4A8E767373; Thu, 29 Apr 2021 14:24:34 +0200 (CEST)
Date: Thu, 29 Apr 2021 14:24:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: mwilck@suse.com
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] nvme: rdma/tcp: fix list corruption with anatt timer
Message-ID: <20210429122433.GA27567@lst.de>
References: <20210427093110.16461-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210427093110.16461-1-mwilck@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_052439_993056_FC4EC43A 
X-CRM114-Status: GOOD (  13.38  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Martin,

can you give this patch a spin and check if this solves your issue?

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0d0de3433f37..68f4d9d0ce58 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -780,6 +780,8 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 
 int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
+	size_t max_transfer_size = ctrl->max_hw_sectors << SECTOR_SHIFT;
+	size_t ana_log_size;
 	int error;
 
 	/* check if multipath is enabled and we have the capability */
@@ -787,47 +789,45 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
 		return 0;
 
+	if (!ctrl->identified) {
+		mutex_init(&ctrl->ana_lock);
+		timer_setup(&ctrl->anatt_timer, nvme_anatt_timeout, 0);
+		INIT_WORK(&ctrl->ana_work, nvme_ana_work);
+	}
+
 	ctrl->anacap = id->anacap;
 	ctrl->anatt = id->anatt;
 	ctrl->nanagrpid = le32_to_cpu(id->nanagrpid);
 	ctrl->anagrpmax = le32_to_cpu(id->anagrpmax);
 
-	mutex_init(&ctrl->ana_lock);
-	timer_setup(&ctrl->anatt_timer, nvme_anatt_timeout, 0);
-	ctrl->ana_log_size = sizeof(struct nvme_ana_rsp_hdr) +
-		ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc);
-	ctrl->ana_log_size += ctrl->max_namespaces * sizeof(__le32);
-
-	if (ctrl->ana_log_size > ctrl->max_hw_sectors << SECTOR_SHIFT) {
+	ana_log_size = sizeof(struct nvme_ana_rsp_hdr) +
+		ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc) +
+		ctrl->max_namespaces * sizeof(__le32);
+	if (ana_log_size > max_transfer_size) {
 		dev_err(ctrl->device,
-			"ANA log page size (%zd) larger than MDTS (%d).\n",
-			ctrl->ana_log_size,
-			ctrl->max_hw_sectors << SECTOR_SHIFT);
+			"ANA log page size (%zd) larger than MDTS (%zd).\n",
+			ana_log_size, max_transfer_size);
 		dev_err(ctrl->device, "disabling ANA support.\n");
 		return 0;
 	}
 
-	INIT_WORK(&ctrl->ana_work, nvme_ana_work);
-	kfree(ctrl->ana_log_buf);
-	ctrl->ana_log_buf = kmalloc(ctrl->ana_log_size, GFP_KERNEL);
-	if (!ctrl->ana_log_buf) {
-		error = -ENOMEM;
-		goto out;
+	if (ana_log_size > ctrl->ana_log_size) {
+		nvme_mpath_uninit(ctrl);
+		ctrl->ana_log_buf = kmalloc(ctrl->ana_log_size, GFP_KERNEL);
+		if (!ctrl->ana_log_buf)
+			return -ENOMEM;
+		ctrl->ana_log_size = ana_log_size;
 	}
 
 	error = nvme_read_ana_log(ctrl);
 	if (error)
-		goto out_free_ana_log_buf;
-	return 0;
-out_free_ana_log_buf:
-	kfree(ctrl->ana_log_buf);
-	ctrl->ana_log_buf = NULL;
-out:
+		nvme_mpath_uninit(ctrl);
 	return error;
 }
 
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
+	nvme_mpath_stop(ctrl);
 	kfree(ctrl->ana_log_buf);
 	ctrl->ana_log_buf = NULL;
 }

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
