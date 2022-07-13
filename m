Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D792CCA479
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 11:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BQFjRCP4XpEbOTcglLLkFTPrk0HE6KhnJX9S++iKpw0=; b=25DpdQDfQ0Rm94IX4lgapPwks6
	Zr61Y54HmRrpd4CDHi0z17PUhxhUoKox9tOnBSRlNxXsFmMvEm0ohiquahWjHyj/iW/p8WP5U0VLW
	ICNagNabrCXM22HHKg+uaFDK/Rn0syeSd5oYCjiyj+Jwa4+TAm36eiPFE14bgzTN/ZtxAtg1FWeVD
	sr055igVAKM81o6xkBd6BGT8gyNUFiVOV5l3OE2MbmWON0hX/pFQdpsb54E+S7uMcRG6c5p1PimNl
	+Fc8MgRU4BwHFyRePj6dcV0XIHjmf9foC4mvUBN83qDFppN3jBiW3nhys40+Cf7tkbilsOIf231MJ
	L3O31dvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBaY2-0038XF-4T; Wed, 13 Jul 2022 11:28:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBaXx-0038TV-FL
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 11:28:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B61267373; Wed, 13 Jul 2022 13:28:46 +0200 (CEST)
Date: Wed, 13 Jul 2022 13:28:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	kbusch@kernel.org, axboe@kernel.dk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	asml.silence@gmail.com, joshiiitr@gmail.com, anuj20.g@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Message-ID: <20220713112845.GA780@lst.de>
References: <20220711110155.649153-1-joshi.k@samsung.com> <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com> <20220711110155.649153-5-joshi.k@samsung.com> <20220712065250.GA6574@lst.de> <436c8875-5a99-4328-80ac-6a5aef7f16f4@grimberg.me> <20220713053633.GA13135@lst.de> <24f0a3e6-aa53-8c69-71b7-d66289a63eae@grimberg.me> <20220713101235.GA27815@lst.de> <772b461a-bc43-c229-906d-0e280091e17f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <772b461a-bc43-c229-906d-0e280091e17f@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_042849_692674_DC6427AB 
X-CRM114-Status: GOOD (  17.73  )
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

On Wed, Jul 13, 2022 at 02:00:56PM +0300, Sagi Grimberg wrote:
> I view uring passthru somewhat as a different thing than sending SG_IO
> ioctls to dm-mpath. But it can be argued otherwise.
>
> BTW, the only consumer of it that I'm aware of commented that he
> expects dm-mpath to retry SG_IO when dm-mpath retry for SG_IO submission
> was attempted (https://www.spinics.net/lists/dm-devel/msg46924.html).

Yeah.  But the point is that if we have a path failure, the kernel
will pick a new path next time anyway, both in dm-mpath and nvme-mpath.

> I still think that there is a problem with the existing semantics for
> passthru requests over mpath device nodes.
>
> Again, I think it will actually be cleaner not to expose passthru
> devices for mpath at all if we are not going to support retry/failover.

I think they are very useful here.  Users of passthrough interface
need to be able to retry anyway, even on non-multipath setups.  And
a dumb retry will do the right thing.

