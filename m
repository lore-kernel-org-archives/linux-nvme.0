Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9F5C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Feb 2022 16:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L6Xyvk0hSnoW+ckBOVFjY7PYJFJtbMmfF7WOcWE1lMM=; b=riQIrn+kEkWy0U3Cxz5sguvscK
	pxhnGP6uB7Zw9zljVRBh2a6uLLWVlf1Txfa6NlYZEjGiU4wp9vUwSG4enojyZDCrdRZiYwSJUfJj5
	Umk+9GntYxvsqc40l5sylOiv3BNMH1ykMFzbcl8iicw8ZsLaB8tUEnNvWzboe8XdRc10BRMzoh9r+
	C1qO0IxfVHRvA+syh4BMnLUnfJ/qhXIg2F/ES16voMXSkijR/pJwQlBg4LcB5jdsEjqsSBbf3B3nw
	g99fhabez2GEdVHlkgay6mBh5IFd8u3PCscblUKJr47yX6loc1Zz1biXrztB8+sfVN1BmKJ4Oo+e4
	iVJuYjzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNdBx-005q4W-1E; Fri, 25 Feb 2022 16:11:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNdBt-005q2q-OV
 for linux-nvme@lists.infradead.org; Fri, 25 Feb 2022 16:11:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8BC9968AA6; Fri, 25 Feb 2022 17:11:30 +0100 (CET)
Date: Fri, 25 Feb 2022 17:11:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk,
 hch@lst.de, martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 06/10] crypto: add rocksoft 64b crc framework
Message-ID: <20220225161130.GA13845@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-7-kbusch@kernel.org>
 <YhU+kuMhueXVQvxe@sol.localdomain>
 <20220222200907.GA1782741@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222200907.GA1782741@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220225_081133_972968_FE4B941B 
X-CRM114-Status: GOOD (  19.45  )
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

On Tue, Feb 22, 2022 at 12:09:07PM -0800, Keith Busch wrote:
> On Tue, Feb 22, 2022 at 11:50:42AM -0800, Eric Biggers wrote:
> > On Tue, Feb 22, 2022 at 08:31:40AM -0800, Keith Busch wrote:
> > > +config CRYPTO_CRC64_ROCKSOFT
> > > +	tristate "Rocksoft Model CRC64 algorithm"
> > > +	depends on CRC64
> > > +	select CRYPTO_HASH
> > > +	help
> > > +	  Rocksoft Model CRC64 computation is being cast as a crypto
> > > +	  transform. This allows for faster crc64 transforms to be used
> > > +	  if they are available.
> > 
> > The first sentence of this help text doesn't make sense.
> 
> Much of the this patch is a copy from the equivalent T10DIF option,
> which says the same as above. I meant to revist these help texts because
> they don't make sense to me either. I'll be sure to do that for the next
> version.

It might make sense to make CRC_T10DIF an invisible option as well
and drop the help text entirely.

