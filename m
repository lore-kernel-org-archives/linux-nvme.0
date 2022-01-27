Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B44BC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 10:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Su49F4FZRddvdYzbI92xfJ4gFGmpQZBM+HqpPfauWT0=; b=1CCbgg42U+ThzxJ+0OPmxAv2HK
	sXuyMzQKCSFtJp7JOIWbbRuDPfSdHmpBg+OjqSciqCUPaqF4w43ZkxAlECmMfK5G/k4+D7Mx+fZ/h
	PqLKjkvU//okv5ol0GeLxjv7XhxgtBXAQmBRWLW0JjqlnjLN31upWaCI/a8iUVPOwH6dp6SniopW5
	W3eJvZkArE/MPU2LlZ3U+Gx+xcJD430sjIVuw+2pi/4/X7P+CFpIOQQsMpQEneOEM5wVkEKNGLduc
	AIEBUzeyub5oB0wTmvbx7XQ/WA4fz4NFepJYVEgMRSR2gNOSN/XBmGjNlW85UxizIYq5/7nzO0kjr
	GZmrXfaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD1ip-00F4gS-24; Thu, 27 Jan 2022 10:09:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD1gw-00F4Ae-Vt
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 10:07:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 45BC568AA6; Thu, 27 Jan 2022 11:07:44 +0100 (CET)
Date: Thu, 27 Jan 2022 11:07:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/3] nvmet: add buffered_io support for bdev-ns
Message-ID: <20220127100743.GB15004@lst.de>
References: <20220119072038.3942-1-chaitanyak@nvidia.com>
 <20220126162747.GB31431@lst.de>
 <47264e99-cb1a-8eef-b49b-140b4de51150@nvidia.com>
 <0facd607-8345-432c-4105-6fd84bb0dcd2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0facd607-8345-432c-4105-6fd84bb0dcd2@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_020747_214503_8FADE379 
X-CRM114-Status: GOOD (  10.56  )
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

On Thu, Jan 27, 2022 at 08:04:45AM +0000, Chaitanya Kulkarni wrote:
> Also, I believe we need to make sure ns->device_path is block device
> type with vfs_getattr(STATX_MODE).

I don't think we care about the type of filp_open works.

