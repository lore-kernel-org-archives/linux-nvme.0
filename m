Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A066C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 02:42:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15CA564EC9
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 02:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CA564EC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vFme9hJRLjFDeSk2QjaulpxZHRrkiR+jJbv1IXqEtok=; b=SU6rUB6i6LiKr0zBrYQasQs8V
	Fcenp/95tTxNvrgVfg/OmuwMeY+EZqLBEVagY0hv/vXqJ8Y+bdJa2e8DcY44+haK/mJcjaQt13TQt
	ll+8UuZ9Xtfdt6vcUJ4UuBC8YoSw3Gts9eow4A5z+i0LAcfuir/96L9frS1igf7jz2cFUj2VzwaEs
	dib2+yXFSdNRbcHNXwM3pWGhoCRc/vnvndcDpco2P7ju8JMabWyIj5WLwva7SXFqu+45yi9yVwrCk
	NgcTd2jodcU8qVVy94OiMGPZ8gX/1fRYvneXFL2xd2+uvX7DWZj7f05yIIbH7J2etvtoxad+2zC/W
	QZJTuLHrA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lI0PW-00BmBk-NP; Fri, 05 Mar 2021 02:41:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lI0PQ-00Bm9i-KU
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 02:41:46 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 989E164E60;
 Fri,  5 Mar 2021 02:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614912100;
 bh=/QEGuxfeeJwVQ4+wJNG01FIJ8rIgGUTLLqLGkiNk8oI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oysxvrKXDM+SuUP8U5j5MGhDDXc8I2AXtXURaBzC6rv1F6PAYe6+P2h40Xy0GEZ51
 VfcvQW8IV3OuqCyykXR69i4EqInAdtkir8Sz9bk6fv4h9U+PPKi3I30/hrZRzt8e7r
 yHyUGdSIwnwASjK/6vRws/9lzPTItDirb+bZ4BqcRPH6iTiHBNJYZlJT/Hfh0Q/6FG
 JJLCf+bPeHWLnbAVQ3MeD9UQvxoq8zSnKWBn2E/LfskASxtdooKPAnGMdCE40MPH4W
 37pZBXxSEKqLrwpKk8XNSTEigCbqSkv5EZ9UdbrUY9h6dvt23DrwuzH/GsB28d2bbj
 NmoYBv3xTBmZg==
Date: Fri, 5 Mar 2021 11:41:33 +0900
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Subject: Re: [RFC 3/3] nvme: wire up support for async passthrough
Message-ID: <20210305024133.GD32558@redsun51.ssa.fujisawa.hgst.com>
References: <20210302160734.99610-1-joshi.k@samsung.com>
 <CGME20210302161010epcas5p4da13d3f866ff4ed45c04fb82929d1c83@epcas5p4.samsung.com>
 <20210302160734.99610-4-joshi.k@samsung.com>
 <BYAPR04MB496501DAED24CC28347A283086989@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CA+1E3rLvrC4s2o3qDgHfRWN0JhnB5ZacHK572kjP+-5NmOPBhw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+1E3rLvrC4s2o3qDgHfRWN0JhnB5ZacHK572kjP+-5NmOPBhw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_024144_952939_0D6A5788 
X-CRM114-Status: GOOD (  13.47  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 04, 2021 at 04:31:11PM +0530, Kanchan Joshi wrote:
> On Thu, Mar 4, 2021 at 3:14 AM Chaitanya Kulkarni
> <Chaitanya.Kulkarni@wdc.com> wrote:
> >
> > On 3/2/21 23:22, Kanchan Joshi wrote:
> > > +     if (!ioucmd)
> > > +             cptr = &c;
> > > +     else {
> > > +             /*for async - allocate cmd dynamically */
> > > +             cptr = kmalloc(sizeof(struct nvme_command), GFP_KERNEL);
> > > +             if (!cptr)
> > > +                     return -ENOMEM;
> > > +     }
> > > +
> > > +     memset(cptr, 0, sizeof(c));
> > Why not kzalloc and remove memset() ?
> 
> Yes sure. Ideally I want to get rid of the allocation cost. Perhaps
> employing kmem_cache/mempool can help. Do you think there is a better
> way?

I'll need to think on this to consider if the memory cost is worth it
(8b to 64b), but you could replace nvme_request's 'struct nvme_command'
pointer with the struct itself and not have to allocate anything per IO.
An added bonus is that sync and async handling become more the same.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
