Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A85C021A8
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 05:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KqCKF09f1O+Lwz/LAvkuVd7GMlr4gW9NholM3AdBkhI=; b=AoTNGyN5rFdcRQ9jkINducw85J
	06Q59KRwmUjc/3QBoqk+NQdwcdcmakBRgifvjCm5+OPIFWHL2sAKEjp3q8TvjX0bA0QqVo/2Vvu59
	ZVoXq2DCeKMIJpHibM5BrzInwnVEv10RdLQWdlkI4vDF4qCSB9XRs0SNpuBhskv/nC+1cKFhVQ3Kh
	BGy+BHczZEvU5g4ZtENgAyyIDZPtnnqo6Sq7/psKZkWu79JP43PkvpvCgDkSoI6jaWEIIo+XBZjzJ
	GUmB9wyOVx7mx748pS6BuxAn/N6JzUCHQrOGm0ftIB84HrWlR7jwfncM3JtUi8V4LkLcHWiLgWJAs
	62O3Ttjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSB2-00000009qdh-2SDH;
	Thu, 13 Feb 2025 05:54:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSAz-00000009qZU-31S6
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 05:54:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66BCD67373; Thu, 13 Feb 2025 06:54:06 +0100 (CET)
Date: Thu, 13 Feb 2025 06:54:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme/ioctl: add missing space in err message
Message-ID: <20250213055405.GA19370@lst.de>
References: <20250213010917.3816029-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213010917.3816029-1-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_215417_926689_5D0AF670 
X-CRM114-Status: GOOD (  13.01  )
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

On Wed, Feb 12, 2025 at 06:09:16PM -0700, Caleb Sander Mateos wrote:
> nvme_validate_passthru_nsid() logs an err message whose format string is
> split over 2 lines. There is a missing space between the two pieces,
> resulting in log lines like "... does not match nsid (1)of namespace".
> Add the missing space between ")" and "of".

You might as well consolidaste the string to a single line while you're
at it.  Otherwise this looks good.


