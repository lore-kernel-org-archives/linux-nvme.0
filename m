Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A44EED613
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o4u1ad0XaOz6dku3BHvync+SagiBct8oraEeiniHSdg=; b=pgFHB6TjRQarjyADBO0zQVxVnL
	X4K065iyJetr5XlusC8r4jQh/1EB4oTt3CNzEPMUqveD9Xk/B6ud3NTrX10H8SANvAvamOEEDW2sk
	fL8aGtPJ+Vr//Y8u5fdnFxyebyR1kjPn9OgRcKshiaTlMVWPM6g4SqumgtJ761VBYliU3lw/VV+PB
	dohuz2jfWmO8tSspHOf4ONOhyThtFV5VbcNU2krN8DacYS8FAOBo+4duMenQYv133S4wvzLP/Hx4y
	cAZBBc0CcD66/GBUgFfD2lCDLwyVk5NGoesnH6g0/4CC2WnvOvbjpfYkM6Fe0E4pr4xjeo8vx+DWB
	TCiG+9Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1solT4-0000000DUWm-0jB1;
	Thu, 12 Sep 2024 15:10:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1solT1-0000000DUVR-2qSy
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 15:10:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A577D227AAF; Thu, 12 Sep 2024 17:10:38 +0200 (CEST)
Date: Thu, 12 Sep 2024 17:10:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, song@kernel.org,
	yukuai3@huawei.com, kbusch@kernel.org, sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] md/raid0: Atomic write support
Message-ID: <20240912151038.GA5858@lst.de>
References: <20240903150748.2179966-1-john.g.garry@oracle.com> <20240903150748.2179966-5-john.g.garry@oracle.com> <20240912131803.GD29641@lst.de> <340e4306-4442-4276-b420-6fee8ed97a7e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <340e4306-4442-4276-b420-6fee8ed97a7e@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_081043_881179_CC0BD55F 
X-CRM114-Status: GOOD (  13.95  )
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

On Thu, Sep 12, 2024 at 03:48:09PM +0100, John Garry wrote:
>
> I actually now think that I should change bio_split() to return NULL for 
> splitting a REQ_ATOMIC, like what do for ZONE_APPEND - calling bio_split() 
> like this is a common pattern in md RAID personalities. However, none of 
> the md RAID code check for a NULL split, which they really should, so I can 
> make that change also.

bio_split is a bit of a mess - even NULL isn't very good at returning
what caused it to fail.  Maybe a switch to ERR_PTR and an audit of
all callers might be a good idea.


