Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC303CD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TV4PoS6LSQiNo2JOY4I0z7M0AphWpWacgRUiT+ilz/8=; b=sdI6LQDsyvSk5E6RJZKd8nna5M
	n0//rHiNGEKX1uKGGdNgfIo12VIZcntmjd7SduarExXuyyiW7bVeAVoRNjbFFhc91EaIsG5mcv4Bn
	YTijq3giGtNtgIm7Dz5QFEER9M+6FCL8IaVy+ImwW/I5Pm18H9sAyX1doFwqD1Y/rU1nFx7Lbcbr2
	62BFIXnVLHiU0XgjETrgYvPWvDlJqRex6jKdqxPD08sLCvds15tOzcFiDw09lVRIDxSvvm8AD4pIx
	zBTZ+emFxf+otVY1DJGg5RmJMDyuryfNLoNx4Vce9RCLc6DReRgcaQpOtKALT0ZGDLyzGXSZZq9M5
	3TD3gObQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEAx-00000004B2C-1ooD;
	Wed, 27 May 2026 13:19:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEAu-00000004B1U-3A4v
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 13:19:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CFA0F68B05; Wed, 27 May 2026 15:19:51 +0200 (CEST)
Date: Wed, 27 May 2026 15:19:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: guzebing <guzebing1612@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: Re: [RFC PATCH 0/1] nvme-pci: detect I/O queue depth changes after
 reset
Message-ID: <20260527131951.GA11071@lst.de>
References: <20260527075320.3178600-1-guzebing1612@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527075320.3178600-1-guzebing1612@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_061956_933593_4C97CCD5 
X-CRM114-Status: GOOD (  11.57  )
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

On Wed, May 27, 2026 at 03:53:19PM +0800, guzebing wrote:
> This RFC instead takes the smaller approach of detecting the reset-time
> CAP.MQES change and making it visible.  If the live I/O queue depth
> shrinks, reset recovery is failed before recreating I/O queues.  If it
> grows, the driver warns and continues with the existing queue resources.

Unlike the other version this at least sounds doable without creating
a complete mess.  So if we can live with this version that'd make me
much happier.


