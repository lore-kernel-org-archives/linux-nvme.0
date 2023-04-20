Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDF0C77B76
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 12:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M1wx1VFOjSSC47jnUS7HWKvP2Skg+waiLnuPs60z6UE=; b=xQU2O2HBqyeUEfxtcxI4XNTIOT
	teJbUOqxxy1ptukKx6QsNXIhTFRR3Q4hRVPhkk+paGOlGG4b9R1MX0ZRrWdHnv/FBG/ZT74tmeEsN
	OwkgEIf5gUKWsPgy4FZxEx/3pvuxJixGpWj1wMQg+WRE2BMhzEixTlfyr2GXa4p/gwcwHJRELwYhn
	9RVoIb3jcG+joZJh4UmaIhwiY8FJmya1VxkwcMBg2vWOTg6+EGePOMDGSHl7XEBIfka/tJA7LSNZH
	uXEFKnRU1uQeHIaF/sarV0QhUuW2AbeWgjwJh2duWpcg8tzliVlWqSsD6Z2TGmdxYDCgldRvUjXQF
	zwD1H6CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppTg5-0087Lz-2m;
	Thu, 20 Apr 2023 12:46:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppTg3-0087LY-19
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 12:46:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B599B68AFE; Thu, 20 Apr 2023 14:46:15 +0200 (CEST)
Date: Thu, 20 Apr 2023 14:46:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Breno Leitao <leitao@debian.org>
Cc: Christoph Hellwig <hch@lst.de>, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, asml.silence@gmail.com,
	axboe@kernel.dk, leit@fb.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, kbusch@kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH 1/2] io_uring: Pass whole sqe to commands
Message-ID: <20230420124615.GA733@lst.de>
References: <20230419102930.2979231-1-leitao@debian.org> <20230419102930.2979231-2-leitao@debian.org> <20230420045712.GA4239@lst.de> <ZEEwHk32Y8IcT20n@gmail.com> <20230420123139.GA32030@lst.de> <ZEEyKolzQgfkEOwv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEEyKolzQgfkEOwv@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_054619_537540_E9FDD8E8 
X-CRM114-Status: GOOD (  12.78  )
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

On Thu, Apr 20, 2023 at 05:38:02AM -0700, Breno Leitao wrote:
> Since we are not coping the payload anymore, this is not necessary. Now
> we are copying 64 bytes for the single SQE or 128 bytes for double SQE.
> 
> Do you prefer I create a helper that returns the SQE size, instead of
> doing the left shift?

I think a helper would be nice.  And adding another sizeof(sqe) seems
more self documenting then the shift, but if you really prefer the
shift at least write a good comment explaining it.

