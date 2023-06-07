Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FD4C7EE23
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 05:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eytx+HtwV1PiLPiMnboAkHoiwnVzB8WYJUKfR9fAB/I=; b=THSn8AiG86K1gi2ub95b5DJEHR
	PLjIPX3/xECA62qo03zWvhQaWpggnGB1tnX7c1DZY5hxBArJ2uLBy9rTYYgi+FlH91opGUj9RFAg0
	sceNZZu4Bx1ouB8oJ/7aCa1XhNR/4T9ngPWjyCVYKCDsgNqaCATbrlqTyIuHYYegOSroVyVo02UA8
	tQr0FdBQ1EXqeujPabzIi/n6VJlEUOffcA4Axg6pWYdMTbQmHJ5PwhoORqKgCAHr+xS7CvW6vbCE5
	GM8XLk0a8SMveRHRzB5td/u3Po35m+8IStMe8Nhwoa960o69xk+BiCHItZw7iGgqyOwZOZxN11+2Z
	QXaf5x1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6lKo-004NKj-1S;
	Wed, 07 Jun 2023 05:03:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6lKl-004NK7-0v
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 05:03:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D740268AA6; Wed,  7 Jun 2023 07:03:43 +0200 (CEST)
Date: Wed, 7 Jun 2023 07:03:43 +0200
From: "hch@lst.de" <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"hare@suse.de" <hare@suse.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 1/2] nvme: add generic helper to store secret
Message-ID: <20230607050343.GB19879@lst.de>
References: <20230605065125.47563-1-kch@nvidia.com> <20230605065125.47563-2-kch@nvidia.com> <ef1a8621-ae27-1b06-fbc2-b3cb1e137b1e@grimberg.me> <478ca846-cf68-c8db-d4e5-f862775d16c2@nvidia.com> <2ce728ac-54b7-f59d-a0c0-b585767a9428@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce728ac-54b7-f59d-a0c0-b585767a9428@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_220347_493811_72E4F51F 
X-CRM114-Status: GOOD (  12.53  )
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

On Tue, Jun 06, 2023 at 09:43:16AM +0300, Sagi Grimberg wrote:
> I understand, but at a point where the commonality becomes confusing
> it can get counter productive.

Agreed.  As-is I don't think the code has very sane structure after
the patch.  If we want to consolidate the code, I'd make the sectet and
key fields a two-element array, with an enum for the indices.  With
that might be possible to share the code without needing extra branches
for which case we're handling.

