Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4C5D374A2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CvJ6wXiG/bv952jNZBdFTkM5X/1oUUSM9AVj8U2/nu8=; b=lcHzc1RrsnLF0kn3S4A9F858gk
	ROLP33e204p8gtDPuNqrV66HcGq+09P+5HyWhn12E3D1427/mRY+X5U4i80aHhOfCXl5MfSYqKBye
	1RTTT2ak8NVRZHksTlOmZF3yGVJcbKpjJ59n8xWdrD6+Okjtm9gW8dCK8NSYjLjLKLjA/FWtu7aJ3
	x9eevpL++m5Jx6P2JLYvpO5e6aPG+8mVHk7JDaKl6GbgXQn5B6xyc/W0BOJwDfH0GPL0SPuTfNi+R
	Sf8TmvuTlBN9+Is6BEaIQYgRStKt/xUM5QjmIE25N/kVcJwTvo08qrA+g8FerWwzx/DIZ8el1ECht
	kgMSiiSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Rev-0000000F9FG-1cK2;
	Thu, 17 Oct 2024 14:39:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Res-0000000F9ER-0qZX
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 14:39:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C6B5227A8E; Thu, 17 Oct 2024 16:39:18 +0200 (CEST)
Date: Thu, 17 Oct 2024 16:39:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com
Subject: Re: [PATCH v4 11/11] scsi: add support for user-meta interface
Message-ID: <20241017143918.GC21905@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113757epcas5p42b95123c857e5d92d9cdec55e190ce4e@epcas5p4.samsung.com> <20241016112912.63542-12-anuj20.g@samsung.com> <20241017113923.GC1885@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017113923.GC1885@green245>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_073922_406923_95AA0196 
X-CRM114-Status: GOOD (  12.18  )
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

On Thu, Oct 17, 2024 at 05:09:23PM +0530, Anuj Gupta wrote:
> This snippet prevents a scenario where a apptag check is specified without
> a reftag check and vice-versa, which is not possible for scsi[1].
> But for
> block layer generated integrity apptag check (BIP_CHECK_APPTAG) is not
> specified. When scsi drive is formatted with type1/2 PI, block layer would
> specify refcheck but not appcheck. Hence, these I/O's would fail. Do you
> see how we can handle this?

Well, this is also related to difference in capability checking.

Just curious, do you have any user of the more fine grained checking
in NVMe?  If not we could support the SCSI semantics only and emulate
them using the fine grained NVMe semantics and have no portability
problems.


