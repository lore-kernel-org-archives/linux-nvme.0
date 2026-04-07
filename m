Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEAAFB519B
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 06:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PKFdL8GLjBuEDX/kPLkFJcu64wuO9qwMTlRSsZssFms=; b=Wz9g2I1gXV4wny365uY2mI6MTj
	LGylCQdO2Z8VPocueWcqJT14uPoiAvBEPcNOLjYNORWqwZRWRJz/u+9NkKDcVo2hCbJHDsPYGPK3C
	/ho8ptScKe5A5/KYUZ/O6mbicy46c8ZjRLwLd/R5KHWtov/tstHbRuUbVvQmQIougDuzlxBmyYH55
	h3oLy3BSngGVMUWCImMNa0Kdf4CRCqz7TIheKEpLudc/18TMex2JsBTnZnhYsB9a3VupUWLvip5Yx
	ItkVkYoR58qVTFCltyr4gBVfW3TLFk6lLWyWjGoujlkUu1DMrJN0jqvooWvEfECOIb/+fhKYZbg5o
	qYPmCCbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zwt-00000005zKk-3tlH;
	Tue, 07 Apr 2026 06:30:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zwq-00000005zKA-2MeA
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 06:30:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FE0668C4E; Tue,  7 Apr 2026 08:30:00 +0200 (CEST)
Date: Tue, 7 Apr 2026 08:30:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Maurizio Lombardi <mlombard@arkamax.eu>,
	gregkh@linuxfoundation.org, security@kernel.org, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: bound sgl->length check in
 nvmet_tcp_map_data()
Message-ID: <20260407063000.GA6992@lst.de>
References: <2026031805-stretch-skid-ae5b@gregkh> <20260319012630.1802025-1-kumar.shivam43666@gmail.com> <DH6LLP692EBM.4N82LTNB60WV@arkamax.eu> <CA+ysrSLau_52n+4JMvQ=EtqY-cyWhhZ_pLOyeNL=mwkjkNvoUw@mail.gmail.com> <20260320074825.GB14485@lst.de> <CA+ysrS+9bWdF1LvxoZaZW_JLZ97H-RXM548Cm8ZW5KQAD+NCLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ysrS+9bWdF1LvxoZaZW_JLZ97H-RXM548Cm8ZW5KQAD+NCLw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_233004_802914_6ED2E815 
X-CRM114-Status: GOOD (  14.33  )
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

On Sun, Apr 05, 2026 at 03:46:12PM -0400, Shivam Kumar wrote:
> Hi Christoph, Maurizio
> 
> Just following up on this thread.
> Would you like me to send a v2 patch that sets a sane default MDTS for
> the TCP transport?

Yes, that would be great!

> If so, is there a preferred value I should use, or
> should I follow what the other transports do?

I'm honestly not sure.  Maurizio/Sagi: any good idea what a TCP default
max MDTS might be?


