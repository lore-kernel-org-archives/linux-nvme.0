Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEF1C77B6C
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 07:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C5SXgci0NIPzcA+EStRsOpIQDFLWOuteDeIzGNio/z8=; b=WQS2SpFeRyGKtmCQ7X03Q/+rvo
	xrLLFYcmD/qT7+QvDYH5oO4s3lR8aOkexUAzRs97D1zbX4rXo4eciEeeu8B9a3giE2SajmD8BrS5T
	I9R+Hu2gUUiIt1r8hO+VPmcc5Hdz0eVQsiAre/eULDTJJGDqaJZsHHpb0eJ/HAYglWrSs6PfsSQ2g
	f5uSnYT0/qxoKlBv8T885E5XUTBiFTuEgYUdD2dtXqtMRaitHLIaPgfVHgfhcY5Fnp0Nbzx/ZniLf
	Nyqqfs70nhHP5uEdkLFOu2BIrT1KJ2U4GtksAMcdMQmpN6LRGSov2KPk4KFEdKdYJgD7M4ChSf194
	5Nypsn1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmqzf-005DFB-2p;
	Thu, 13 Apr 2023 07:03:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmqzc-005DDa-33
	for linux-nvme@lists.infradead.org;
	Thu, 13 Apr 2023 07:03:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8B4EC67373; Thu, 13 Apr 2023 09:03:28 +0200 (CEST)
Date: Thu, 13 Apr 2023 09:03:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, James Smart <jsmart2021@gmail.com>,
	Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH] nvme-fcloop: fix "inconsistent {IN-HARDIRQ-W} ->
 {HARDIRQ-ON-W} usage"
Message-ID: <20230413070328.GA16557@lst.de>
References: <20230412084904.162324-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412084904.162324-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_000341_146197_088DFCB3 
X-CRM114-Status: UNSURE (   9.33  )
X-CRM114-Notice: Please train this message.
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

Thanks,

applied to nvme-6.4.

