Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFD4C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 20:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8naiUaZZutUDfmakXMm/GAA/vNaoBzWUqhbNO9EDMiY=; b=VEy8Oh7XRzz8wIQCiOf/6OINK+
	gYB9oG2/ajl/Ps4GjW7aETb/SOTrmqffxyQR9ZwwJffhJoDWjcxy5sUgLhMFYTv3TALV3S+N6M6ko
	7fJe5Ug2EvMVDK220l7G1/YVFPvz9oQ8yx14lqIQONSqcXZ5mZPlUjptFyzSlq0Lrj+qCG/jWClHR
	fiA6ZJ4XjYLFXzXL3/yI6q1nEf+HWxZL4n91B/1OE4kw4E0lgdLtHg2emj1hmTUGIOhYJ5uX6u3/J
	T+q7A4Ce/p94rRy18GVJuj3GdpzKpc2dBT22QliUgU1K83Lw5F/dwF07zE2OFPs5Y/+G64pDbTCl6
	Qxs8nhlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMboz-00BXKd-3b; Tue, 22 Feb 2022 20:31:41 +0000
Received: from relay3.hostedemail.com ([64.99.140.34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMbov-00BXJ5-Sw
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 20:31:39 +0000
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay06.hostedemail.com (Postfix) with ESMTP id 3921423112;
 Tue, 22 Feb 2022 20:31:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf10.hostedemail.com (Postfix) with ESMTPA id 212BE3E; 
 Tue, 22 Feb 2022 20:31:31 +0000 (UTC)
Message-ID: <eef8db106e310e20faff4563580fa0eeb064d17b.camel@perches.com>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
From: Joe Perches <joe@perches.com>
To: David Laight <David.Laight@ACULAB.COM>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
 "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
 "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, 
 "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "colyli@suse.de" <colyli@suse.de>, Bart Van
 Assche <bvanassche@acm.org>
Date: Tue, 22 Feb 2022 12:31:30 -0800
In-Reply-To: <65fd7d9525b443fcbb15468176fca16a@AcuMS.aculab.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-5-kbusch@kernel.org>
 <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
 <20220222165045.GA14168@lst.de>
 <20220222165613.GB1497257@dhcp-10-100-145-180.wdc.com>
 <603f9243bb9e1c4c50aaec83a527266b48ab9e20.camel@perches.com>
 <65fd7d9525b443fcbb15468176fca16a@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: j6sb6dyjbjkt7oik85ducwufi81y7epk
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 212BE3E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19EtqwWf6kiHllY/BwsW7Y4xiMn/fz+NUI=
X-HE-Tag: 1645561891-809749
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_123138_024161_92362953 
X-CRM114-Status: GOOD (  27.47  )
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

On Tue, 2022-02-22 at 20:09 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 22 February 2022 18:43
> > 
> > On Tue, 2022-02-22 at 08:56 -0800, Keith Busch wrote:
> > > On Tue, Feb 22, 2022 at 05:50:45PM +0100, Christoph Hellwig wrote:
> > > > On Tue, Feb 22, 2022 at 08:45:53AM -0800, Joe Perches wrote:
> > > > > On Tue, 2022-02-22 at 08:31 -0800, Keith Busch wrote:
> > > > > > +/ *
> > > > > > + * lower_48_bits - return bits 0-47 of a number
> > > > > > + * @n: the number we're accessing
> > > > > > + */
> > > > > > +#define lower_48_bits(n) ((u64)((n) & 0xffffffffffffull))
> > > > > 
> > > > > why not make this a static inline function?
> > > > 
> > > > Agreed.
> > > 
> > > Sure, that sounds good to me. I only did it this way to match the
> > > existing local convention, but I personally prefer the inline function
> > > too.
> > 
> > The existing convention is used there to allow the compiler to
> > avoid warnings and unnecessary conversions of a u32 to a u64 when
> > shifting by 32 or more bits.
> > 
> > If it's possible to be used with an architecture dependent typedef
> > like dma_addr_t, then perhaps it's reasonable to do something like:
> > 
> > #define lower_48_bits(val)					\
> > ({								\
> > 	typeof(val) high = lower_16_bits(upper_32_bits(val));	\
> > 	typeof(val) low = lower_32_bits(val);			\
> > 								\
> > 	(high << 16 << 16) | low;				\
> > })
> > 
> > and have the compiler have the return value be an appropriate type.
> 
> The compiler could make a real pigs breakfast of that.

Both gcc and clang optimize it just fine.

btw: to return the same type the last line should be:

	(typeof(val))((high << 16 << 16) | low);

otherwise the return is sizeof(int) if typeof(val) is not u64

> Oh, did you look for GENMASK([^,]*,[ 0]*) ?

No, why?  I did look for 47, 0 though.

But it's pretty common really.

$ git grep -P 'GENMASK(?:_ULL)?\s*\(\s*\d+\s*,\s*0\s*\)' | wc -l
6233

> I'd only use something GENMASK() for bit ranges.
> Even then it is often easier to just write the value in hex.

Mostly it's the count of the repeated f that's difficult to
quickly verify visually.

> I think the only time I've written anything like that recently
> (last 30 years) was for some hardware registers when the documentation
> user 'bit 1' for the most significant bit.

Luckily the hardware I've had to deal with never did that.
Not even the least significant bit too.



