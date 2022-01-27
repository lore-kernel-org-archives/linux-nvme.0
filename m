Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F64C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 10:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LnzC3ijcgnsH9zvcL2Wl2TsecFh0rWLo//F38Cmxcyc=; b=cg/KKM5hI6Wgi+Sth3gbbN0erT
	0pd1+xJpuf1kig8WXZUamGAWl8wcK/INZLU9lxJdPpC3xsdQCzBt7NcvL/bTAxEGG24XJ6GWQasIt
	HWEMPI8kgBG9Iz5RnmavYUD8eK19EzHjArsh5hdveRAcq05jNW4Lg8wwPZYEAvvm4sMq3UWeYiB8+
	P9PEQsaCbSJqVyZxTDvaGlx+uqa2n4pNAiO0J3fXHzsrv9yTKD/RbVY1CGut6Ed+snEq6ZqBH8UiF
	5N4LcSxsvzWvHDiEMyaOqZ2y70o22n5tIgSn5spk82t2S/NiMmWIi0fKxeZEmlWOExmR9S9DuLY66
	VX6foc2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD1hP-00F4Hk-PF; Thu, 27 Jan 2022 10:08:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD1gt-00F49L-87
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 10:07:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 940E668AA6; Thu, 27 Jan 2022 11:07:39 +0100 (CET)
Date: Thu, 27 Jan 2022 11:07:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/3] nvmet: add buffered_io support for bdev-ns
Message-ID: <20220127100739.GA15004@lst.de>
References: <20220119072038.3942-1-chaitanyak@nvidia.com>
 <20220126162747.GB31431@lst.de>
 <47264e99-cb1a-8eef-b49b-140b4de51150@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47264e99-cb1a-8eef-b49b-140b4de51150@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_020743_481962_10EDE1FE 
X-CRM114-Status: GOOD (  15.48  )
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

On Thu, Jan 27, 2022 at 07:46:22AM +0000, Chaitanya Kulkarni wrote:
> This is exactly how I stared this patch-series, but above doesn't
> work since it errors out in the nvme_identify_ns() due to ncap value
> set to 0 (set from ns->size in id-ns admin on target side) see [1],
> since ns->size value we get is 0, that is set using call to
> vfs_getattr(STATX_SIZE) in the nvmet_file_ns_revalidate()
> for file backend.

Something like this should solve that issue:

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 6be6e59d273bb..fb7f4dd72daf6 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -16,14 +16,8 @@
 
 int nvmet_file_ns_revalidate(struct nvmet_ns *ns)
 {
-	struct kstat stat;
-	int ret;
-
-	ret = vfs_getattr(&ns->file->f_path, &stat, STATX_SIZE,
-			  AT_STATX_FORCE_SYNC);
-	if (!ret)
-		ns->size = stat.size;
-	return ret;
+	ns->size = i_size_read(ns->file->f_mapping->host);
+	return 0;
 }
 
 void nvmet_file_ns_disable(struct nvmet_ns *ns)

