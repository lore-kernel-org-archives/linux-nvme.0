Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F197C3ABC5
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JsCPSMGds5SjnqmFW4633Rzm2hBuTiek1kY1irD4AFw=; b=q7/3X70Uf59n7fSqMn5wjscGJP
	cYp+FaqMXrYC2QIp8LmTTr2YSrgM658TYnBaYzTuDMONQFDjYj2LvXUgKUy3ZFu4boml4zh29NinA
	j9Nptoa+UQ0O8dTxQlcMeEe9gK2G9YrM0dBzMWwepHeIY1Q2v01ebD6rOPSUHxfAe3EoijtQS77cO
	2tN4LWiKwl8FSsy+5WgFIxnBzxNLLcubeRKdW6jfxgoJxPfmud1YXlFjWTPgsvWOCTcCild4DQWmR
	ToTOhyLf0kio7R0mPVpw6JzZVatV8zzaEVZBgxYcCjQYhI2PjeyRHyMjk1QKNUbNBEQXKb8iwGTfv
	k+HXXKvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZwu-0000000Egpf-0end;
	Wed, 07 May 2025 08:16:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZ0o-0000000EU2L-0Zwc
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:16:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BFD9768B05; Wed,  7 May 2025 09:16:10 +0200 (CEST)
Date: Wed, 7 May 2025 09:16:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] nvme/pci: factor out nvme_init_hctx() helper
Message-ID: <20250507071610.GB1413@lst.de>
References: <20250426020636.34355-1-csander@purestorage.com> <20250426020636.34355-3-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426020636.34355-3-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_001614_314213_6823DEEE 
X-CRM114-Status: GOOD (  10.00  )
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

> -	.init_hctx	= nvme_init_hctx,
> +	.init_hctx	= nvme_io_init_hctx,

Without an overall rename of the methods I'd rather avoid the _io
here and pick a _common name for the common helper.

I can fix that up when applying, no need to resend.


