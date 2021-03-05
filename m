Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B950C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 13:23:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23A764FD3
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 13:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23A764FD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vSct0lANx00pNFr3JGQheZEKbMm2XckIeKLSQWxgckw=; b=OQg1BA/xo6T6LxZfoOqaA0okk
	yOHwh5AqM7TtqVT5Gg4tZJjAj16TcpD2MNLjZ3s0+EOWz5cqtCVrY/fTAQMJ6mBoOetd2OacvDOlI
	QIJiTzYgj/R5ctxbJoxo/Hvfwk6b5SQY86kcfz5SFdSxFJxR8kkjNtthOr14LpEb1HWOItVft3BWC
	K2iWasHDy8OeGq8jUV79ZuIh/N4+P+Pqwp4NM69JuAp1n/RXHdPRumhcevUvVVQBz5I06gOgHj5Na
	qu8BVFlpPRN8PQDsLXgXzTJs3kJ7kIs3XyKSEsNEaHw+5GLjQVA+/Sry8+584VcAqb5HuT9XbZo/U
	Lfhz6AoOg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIAPU-00F597-GJ; Fri, 05 Mar 2021 13:22:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIAPO-00F56V-RR
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 13:22:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E699D68B05; Fri,  5 Mar 2021 14:22:20 +0100 (CET)
Date: Fri, 5 Mar 2021 14:22:20 +0100
From: "hch@lst.de" <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Subject: Re: [RFC 3/3] nvme: wire up support for async passthrough
Message-ID: <20210305132220.GA10000@lst.de>
References: <20210302160734.99610-1-joshi.k@samsung.com>
 <CGME20210302161010epcas5p4da13d3f866ff4ed45c04fb82929d1c83@epcas5p4.samsung.com>
 <20210302160734.99610-4-joshi.k@samsung.com>
 <BYAPR04MB4965E07D8D106CE6565DFB7386989@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CA+1E3rJZWkOw+ZfDGduQhdhTh+=JVe5CcFEZtfQ1Jmq6mKhbSA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+1E3rJZWkOw+ZfDGduQhdhTh+=JVe5CcFEZtfQ1Jmq6mKhbSA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_132223_325898_FCD74B0A 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 04, 2021 at 04:25:41PM +0530, Kanchan Joshi wrote:
> On Thu, Mar 4, 2021 at 12:22 AM Chaitanya Kulkarni
> <Chaitanya.Kulkarni@wdc.com> wrote:
> >
> > On 3/2/21 23:22, Kanchan Joshi wrote:
> > > +     switch (bcmd->ioctl_cmd) {
> > > +     case NVME_IOCTL_IO_CMD:
> > > +             ret = nvme_user_cmd(ns->ctrl, ns, argp, ioucmd);
> > > +             break;
> > > +     default:
> > > +             ret = -ENOTTY;
> > > +     }
> > Switch for one case ? why not use if else ?
> 
> Indeed, I should have used that. I had started off with more than one,
> and retracted later.

I have to say I really do like the switch for ioctl handlers, as they
are designed as a multiplexer, and nothing screams multiplexer more
than a switch statement.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
