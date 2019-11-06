Return-Path: <SRS0=IwtP=Y6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15F5C5DF63
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 21:34:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28D4217D7
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 21:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M3VeFzKP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEzptdIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28D4217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CjFSCgybCBdjLzhLB0xdaGK4jpJqvqK21Fb20PbChO4=; b=M3VeFzKPL0LSPg
	oN0lfweTukrih3cV9a+6Qho+xkcyUv6bZBfNOI43CRrxTC/hNYU/K1rn3GVMc9ZSW3HRQwM/Fqd8H
	f4F1ylRhkzhbyDlVIrMrVlkK6Pz6Uau+h1uFaxW2I/XwdTFqw4S4XPmAFHj9URWhcY3PxtMjleZCC
	X+2cX1PSKV3q19Zphn6b8ovv3642KkJuPw1fCN77qXBsm+356PQO4qOBkv30mCEZlRAKzOSBrABL8
	Iuousq1aKYKtu4XEoeqZHk62fX/MKFw/KVHYDiNu+Qs3iWzJKxgayw/drQ3GVUeW8rEHRawa2ytQq
	XfTwIwftUliXLQZpuNEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSSwQ-000079-Bd; Wed, 06 Nov 2019 21:34:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSSwN-00006e-FX
 for linux-nvme@lists.infradead.org; Wed, 06 Nov 2019 21:34:12 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 895012166E;
 Wed,  6 Nov 2019 21:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573076051;
 bh=SuV2UHwfH5+kWTYJPQHFsjavAYbiTOZxmHFjr4BmYbU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TEzptdIS/p4V2y7jFpj7BpoPbvy9qV6xz5NFSqk4ubIYojB59dstphSvEe1HLFhFL
 Ff+stGmFZJsyON+290/2nvCu+W6wbHOKRZ3kr2HUorOAKpdepcS1wJKMdm5xQYzbJT
 HV2GrxN94BtQnUDSZmz5XNf6PiwfXo/D6NpJZ0kI=
Date: Thu, 7 Nov 2019 06:34:03 +0900
From: Keith Busch <kbusch@kernel.org>
To: Eduard Hasenleithner <eduard@hasenleithner.at>
Subject: Re: [RFC PATCH] Workaround for discard on non-conformant nvme devices
Message-ID: <20191106213403.GA308@redsun51.ssa.fujisawa.hgst.com>
References: <f220c69a-793d-9160-4f20-921c52748009@hasenleithner.at>
 <d96335fb-8907-6b5b-14e9-08eb1a796b0d@grimberg.me>
 <20191106182339.GE29853@redsun51.ssa.fujisawa.hgst.com>
 <f9e32847-00b1-59f5-8b15-860a94598e79@hasenleithner.at>
 <20191106204329.GB32215@redsun51.ssa.fujisawa.hgst.com>
 <ea1ddc8d-9612-1fa1-09bc-ce803b0a38ef@hasenleithner.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ea1ddc8d-9612-1fa1-09bc-ce803b0a38ef@hasenleithner.at>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191106_133411_539820_4D497249 
X-CRM114-Status: GOOD (  12.25  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 06, 2019 at 10:10:58PM +0100, Eduard Hasenleithner wrote:
> On 06.11.19 21:43, Keith Busch wrote:
> > On Wed, Nov 06, 2019 at 09:22:00PM +0100, Eduard Hasenleithner wrote:
> > > Couldn't we just simply use the discard_page for all discards?
> > 
> > That's normally just a fallback to ensure forward progress under memory
> > pressure. It's not particularly performant, though.
> 
> So we are accepting a considerable performance impact for the "broken"
> devices?

I'd wager the devices that got this wrong are operating on DSMs beyond
QD1 anyway, the impact to them is probably much less than "considerable".
 
> > > Are there even nvme devices out there which have conformant behavior in this
> > > respect?
> > 
> > I believe most of them do conform, but I don't have a large sample size
> > to confirm.
> 
> Do you have an IO-MMU active on your setup?

Sometimes, but that's not why I know at least some devices are
compliant. I've wasted too many hours analyzing protocol traces.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
