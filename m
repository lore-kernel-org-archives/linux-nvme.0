Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDD3C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iXOOI8x1EG/3Zjo3Btl/sz3gMHsuMGZezmgWejTqMys=; b=vn3SHsgknpdA9sOi2PdKuoM9Zh
	Wb85R80E3go4U0OR+E4nnjVSzwoLqTms9o7V+kSoeCW1ffzx4dVQT+s0xBYnu/OKGXw14bUnB+fIy
	DAT06WQGbU8xGJ3oc+evTR71BiXwWdCb+irmxblLnxNqfT5ClCSxfosVoXPm0HszBoe0biGOuC0f+
	1hZIwoVoRztx1Op2GyrH3CQU6ks9AZbyeltt04La7Gal3cSwm1MK8FjOVn8d6mLIXEv/sVzJnNUlU
	lTp4Qtv8GiezM9jOv2y7DWIPALyLpvPjUQVw5k10AKZtXKyNCW/1o32E9sh3j8dsAKRXVctULwJtR
	aDH+n75g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMYQC-00AmSa-D2; Tue, 22 Feb 2022 16:53:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMYNG-00AlPY-Li
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 16:50:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A920368B05; Tue, 22 Feb 2022 17:50:45 +0100 (CET)
Date: Tue, 22 Feb 2022 17:50:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Joe Perches <joe@perches.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk,
 hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Message-ID: <20220222165045.GA14168@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-5-kbusch@kernel.org>
 <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_085050_946569_F643FE0C 
X-CRM114-Status: GOOD (  16.42  )
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

On Tue, Feb 22, 2022 at 08:45:53AM -0800, Joe Perches wrote:
> On Tue, 2022-02-22 at 08:31 -0800, Keith Busch wrote:
> > Recent data integrity field enhancements allow 48-bit reference tags.
> > Introduce a helper macro since this will be a repeated operation.
> []
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> []
> > @@ -63,6 +63,12 @@
> >  }					\
> >  )
> >  
> > +/**
> > + * lower_48_bits - return bits 0-47 of a number
> > + * @n: the number we're accessing
> > + */
> > +#define lower_48_bits(n) ((u64)((n) & 0xffffffffffffull))
> 
> why not make this a static inline function?

Agreed.

> And visually, it's difficult to quickly count a repeated character to 12.
> 
> Perhaps:
> 
> static inline u64 lower_48_bits(u64 val)
> {
> 	return val & GENMASK_ULL(47, 0);
> }

For anyone who has a minimum knowledge of C and hardware your version
is an obsfucated clusterfuck, while the version Keith wrote is trivial
to read.

