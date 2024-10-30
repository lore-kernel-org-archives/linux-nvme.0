Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AE7D74963
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 05:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kVS7ZpNFNcPye8A5s8Agi18qwoTV98nKghO8h+OZNas=; b=SlDYTSj1gAsP/w+E2Y0PE2h5TC
	BReXOYvanOBMXnPoKHr7JR4OBe391X1GHWa+Tb2xs+8xUrwzABplTwSFF1ZWS448dlFdNwEeBfMoq
	IPgsE/6NIzCve/AZwi+k6EZ7JPs2mO26q29jb8X/M6WD1noiPCv3WyDonQemhJQqhTX9GoNFznNZn
	d2vMcB7PM62kGugo8l4HhqRxaEzNLTJB95AuCS7NYNtPH2m7uWAY624jUNIfP4CQGNZIrJjAzBcWn
	eOQzUad14VFpzpxOG5YwZVXx/toV2HdghOhI7X+ZwGqX79XuH++TkDl3I9WemQ6bF2dGi7EsErgWr
	loBuSB+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t61eO-0000000GpFX-3uTC;
	Wed, 30 Oct 2024 05:53:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t61eM-0000000GpF8-0QR4
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 05:53:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DE0D227A8E; Wed, 30 Oct 2024 06:53:42 +0100 (CET)
Date: Wed, 30 Oct 2024 06:53:42 +0100
From: "hch@lst.de" <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: make nvmet_wq visible in sysfs
Message-ID: <20241030055342.GA841@lst.de>
References: <20241029014915.16646-1-kanie@linux.alibaba.com> <8b4591d7-f0bd-4e4c-b1b3-1b375f25bda0@nvidia.com> <0e90730a-74c0-401a-82bd-92fdbcd2cbe0@linux.alibaba.com> <1c6e0bfe-f476-4c07-a67c-b526b325b405@nvidia.com> <a6718c68-6b0e-4a5e-af3a-c8ee98911ce3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6718c68-6b0e-4a5e-af3a-c8ee98911ce3@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_225346_305746_CAB35AFF 
X-CRM114-Status: GOOD (  11.39  )
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

On Wed, Oct 30, 2024 at 09:44:25AM +0800, Guixin Liu wrote:
> I need serverve some cpu core to do other things, such as handle events
>
> and managements, so that the nvmet_wq can't running on all cpu cores,
>
> currently, I restrict it by setting the cpumask of nvmet_wq（that's why
>
> I expose nvmet_wq to sysfs）.

Can you resend the patch with an explanation of the use case in the
commit message?  Thanks!


