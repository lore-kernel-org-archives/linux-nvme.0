Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA057C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yTqn+FQc94UqRkLSVubEtUVfaHcm4lXfPasCJVUGVKo=; b=s30FIbYKqjmnd/sPa62nHJhMad
	iUO2b7Vc534+E//+3jJx4iHRSGWcEUxrKHciJu7BCYWGlexVVQUxoXwShlqBAWW7uwWluBLqdXUfq
	V5kp5aAbcgYiigyWEJhMbg6R2/AUf0joav/mSYy4y3Z6usxiEUPkOpPU4gfHdx5M9IVwPK5JTcZyK
	+yZ6BS+eycfrfHPDYPZH7/bXjHaeli/V2BPRyyZEYyNpZnI01AjV27Et65wpVc++SCw0Al8CNmlDa
	c7mcNMJYkoUuc2IldP3YyV9kSe3XxHQ3NnIS+eZIaa5UU/JKehxVknj91+4uZI6UDjBM+NtEGBpfd
	uzoqJa9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whqLu-00000002sEU-2utR;
	Thu, 09 Jul 2026 15:07:50 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whqLs-00000002sE8-2ldK
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 15:07:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1394C433BD;
	Thu,  9 Jul 2026 15:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26821F000E9;
	Thu,  9 Jul 2026 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783609668;
	bh=yTqn+FQc94UqRkLSVubEtUVfaHcm4lXfPasCJVUGVKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ML2RwY0eLHZcTWolvsKHLe8E0onmSPnz/9IHRLzQtzwU9nkUEYP2MzeP+XaiC/YZt
	 +tbEZvnsyV37SCA2pVfEXqWAQQxbnTGmKmjyrrxubcBPoQhzXgs5Td73fM/MAPWiml
	 Qr/C8k8TgKP26A6t3gDdSVMeCl0U4X08m1q/J3GlFtn041/I5leQa3ebgG1TK45Dmg
	 1dTCNPcMQrzhinxNo6IUoGCOYaxQcLW3Il9lpPI8KrwKgJ1ZB5vdUEAOiwJK2KkgZA
	 CfG1SN2mCSuikK9AQ+foDqhoeNgEudQewmapmhfUsYSYzD46Sei2JXR/HfEjX/JlqS
	 0aEV4mfWLIWrg==
Date: Thu, 9 Jul 2026 09:07:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: guzebing <guzebing1612@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: Re: [PATCH] nvme: make firmware activation poll interval configurable
Message-ID: <ak-5QnI_lc-EwcNU@kbusch-mbp>
References: <20260627010610.47768-1-guzebing1612@gmail.com>
 <20260709064233.GA18381@lst.de>
 <7ae65361-f601-4fd9-8eac-5dfb9f6bb7ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ae65361-f601-4fd9-8eac-5dfb9f6bb7ea@gmail.com>
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

On Thu, Jul 09, 2026 at 05:06:11PM +0800, guzebing wrote:
> The Samsung PM9D3a Gen5 SSD reports MTFA = 10, i.e. 1000 ms.
> 
> I also checked another device, an Intel/Solidigm P5520 Gen4 drive.  It
> reports MTFA = 100, i.e. 10000 ms, while the observed online activation
> time is about 800 ms.
> 
> I agree that deriving the polling interval from MTFA would be better
> than adding a module parameter.  Given that MTFA is a conservative upper
> bound rather than a good estimate of the common activation time, would
> using a small fraction of it, for example MTFA / 100 clamped to 10..100
> ms, be a reasonable policy for v2?
> 
> That would give 10 ms for the PM9D3a device above, while keeping the
> current 100 ms interval for the P5520 case and for large-MTFA devices.

nvme_wait_ready() has a similar polling loop on the csts register, but
it does a udelay_range for 1-2 msecs no matter what the ready timeout
is. Maybe just do the same for consistency?

