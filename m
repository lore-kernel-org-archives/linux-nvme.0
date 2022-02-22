Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B3CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 17:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e1GAHP6Odwv8v78Chr08BryhtJI1Mt/yrrIvfGL0fRQ=; b=bWf3HZ5Mtk2Qx7vNq5GzsxxC9B
	SPyhsHb1U2lakI33TEGmX8HMS9OjbH4xW3ZAyKzysTUJa0Qgb0npXQoackaLdBytIQWHkPJ781Cyd
	L9L3Dc3birtwh34gwNxUlUh8vDSljuvjvKisOCEcixzpPTqGUUyplCT+pkJWGAgGfZpipzpSh5KC2
	EeHkd65gNPCDqtKhVdnwGwCKH2MG1eBj8TSG6j1bDD+DKyuaySbzAbGMUqSxE0L1jWKM0PoouH4+R
	pb6DBqN5RE3Kp5b5NAk7SnP+YL6L2yumePALZQMBWHhbDzWZ8ZjSwFGDYtzDZ68udWKeICJ09xKZW
	SAgpl0Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMYhf-00At9i-Tw; Tue, 22 Feb 2022 17:11:55 +0000
Received: from relay4.hostedemail.com ([64.99.140.36])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMYVA-00AoOW-Uz
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 16:59:02 +0000
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay12.hostedemail.com (Postfix) with ESMTP id B256D120966;
 Tue, 22 Feb 2022 16:58:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf09.hostedemail.com (Postfix) with ESMTPA id DCE9720028; 
 Tue, 22 Feb 2022 16:58:56 +0000 (UTC)
Message-ID: <38d356c2ea0cd9c8cec1e6377793b5c465eca889.camel@perches.com>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
From: Joe Perches <joe@perches.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, x86@kernel.org, 
 linux-kernel@vger.kernel.org, axboe@kernel.dk, martin.petersen@oracle.com, 
 colyli@suse.de, Bart Van Assche <bvanassche@acm.org>
Date: Tue, 22 Feb 2022 08:58:56 -0800
In-Reply-To: <20220222165045.GA14168@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-5-kbusch@kernel.org>
 <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
 <20220222165045.GA14168@lst.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: DCE9720028
X-Stat-Signature: bk4jafjtuowkr7tuxqe1os9d7x7ekmx4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX187kE9xU/fonTPBMMbSmL7JTFcT++IlEDc=
X-HE-Tag: 1645549136-753137
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_085901_113356_EF112251 
X-CRM114-Status: GOOD (  16.68  )
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

On Tue, 2022-02-22 at 17:50 +0100, Christoph Hellwig wrote:
> On Tue, Feb 22, 2022 at 08:45:53AM -0800, Joe Perches wrote:
> > On Tue, 2022-02-22 at 08:31 -0800, Keith Busch wrote:
> > > Recent data integrity field enhancements allow 48-bit reference tags.
> > > Introduce a helper macro since this will be a repeated operation.
> > []
> > > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > []
> > > @@ -63,6 +63,12 @@
> > >  }					\
> > >  )
> > >  
> > > +/**
> > > + * lower_48_bits - return bits 0-47 of a number
> > > + * @n: the number we're accessing
> > > + */
> > > +#define lower_48_bits(n) ((u64)((n) & 0xffffffffffffull))
> > 
> > why not make this a static inline function?
> 
> Agreed.
> 
> > And visually, it's difficult to quickly count a repeated character to 12.
> > 
> > Perhaps:
> > 
> > static inline u64 lower_48_bits(u64 val)
> > {
> > 	return val & GENMASK_ULL(47, 0);
> > }
> 
> For anyone who has a minimum knowledge of C and hardware your version
> is an obsfucated clusterfuck, while the version Keith wrote is
> trivial to read.

Don't think so.  I've dealt with hardware and have more than once
seen defects introduced by firmware developers that can't count.

be quick, which one is it:

	0xfffffffffffULL
or
	0xffffffffffffULL
or
	0xfffffffffffffULL
or
	0xffffffffffffffULL




