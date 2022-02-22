Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B391AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 18:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B5YdwJJyLQiXmOegPA1mIy5KTlcwKP1Sjm1Rcx/DjE0=; b=qX13fjGvgZj87bLpX/C7xqmajy
	akoWPTNssoz3JIgZRVnTrX7IiUeUZ7blDRDxIYpA32S5qFALsuS1VvARZkIDOLDBPeQrZ/uL6bRXN
	x7tfiu4TRgLWjVfXJSOrIURlkH1cKmC1jaNpnh18wQA897VELI9JSPWnCX5g5bE+hs4Ft5/SUWpxj
	z1IMzBGfyhch+xvwIyL8K+Y1OHXRbPPoeZXG3yKF1C+w9tqRP+K/DwetvqYJ1B/vQrwLsgptHeDf9
	P+SvfwKssc+4y2Cj/MpAY8OVH/jyizQpeB91BvNaXi/JUU0/ed1NK4/JfyWA8PRvZDvsqU1tfw89C
	tH8Si2aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMa8I-00BF26-8X; Tue, 22 Feb 2022 18:43:30 +0000
Received: from relay3.hostedemail.com ([64.99.140.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMa8E-00BF14-TE
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 18:43:28 +0000
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay11.hostedemail.com (Postfix) with ESMTP id 7E08A802C9;
 Tue, 22 Feb 2022 18:43:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf17.hostedemail.com (Postfix) with ESMTPA id 5571217; 
 Tue, 22 Feb 2022 18:42:32 +0000 (UTC)
Message-ID: <603f9243bb9e1c4c50aaec83a527266b48ab9e20.camel@perches.com>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
From: Joe Perches <joe@perches.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 axboe@kernel.dk, martin.petersen@oracle.com, colyli@suse.de, Bart Van
 Assche <bvanassche@acm.org>
Date: Tue, 22 Feb 2022 10:43:21 -0800
In-Reply-To: <20220222165613.GB1497257@dhcp-10-100-145-180.wdc.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-5-kbusch@kernel.org>
 <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
 <20220222165045.GA14168@lst.de>
 <20220222165613.GB1497257@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nazzjjx87869o4w9oakhjiahqxjdbban
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 5571217
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18aL9+BR2B9Ovzx+56lKMnaVrCxDabIdXo=
X-HE-Tag: 1645555352-996125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_104327_030741_36C1D294 
X-CRM114-Status: GOOD (  15.07  )
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

On Tue, 2022-02-22 at 08:56 -0800, Keith Busch wrote:
> On Tue, Feb 22, 2022 at 05:50:45PM +0100, Christoph Hellwig wrote:
> > On Tue, Feb 22, 2022 at 08:45:53AM -0800, Joe Perches wrote:
> > > On Tue, 2022-02-22 at 08:31 -0800, Keith Busch wrote:
> > > > +/ *
> > > > + * lower_48_bits - return bits 0-47 of a number
> > > > + * @n: the number we're accessing
> > > > + */
> > > > +#define lower_48_bits(n) ((u64)((n) & 0xffffffffffffull))
> > > 
> > > why not make this a static inline function?
> > 
> > Agreed.
> 
> Sure, that sounds good to me. I only did it this way to match the
> existing local convention, but I personally prefer the inline function
> too. 

The existing convention is used there to allow the compiler to
avoid warnings and unnecessary conversions of a u32 to a u64 when
shifting by 32 or more bits.

If it's possible to be used with an architecture dependent typedef
like dma_addr_t, then perhaps it's reasonable to do something like:

#define lower_48_bits(val)					\
({								\
	typeof(val) high = lower_16_bits(upper_32_bits(val));	\
	typeof(val) low = lower_32_bits(val);			\
								\
	(high << 16 << 16) | low;				\
})

and have the compiler have the return value be an appropriate type.



