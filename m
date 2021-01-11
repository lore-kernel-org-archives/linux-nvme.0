Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C24BC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 17:50:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526EA223E0
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 17:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526EA223E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1SiSfBZcynB6SHVD2hx8qoUZcn9kL05b0IOBqp5tuvg=; b=q7i8uUFB6vKBeZa6JeUqHnbQS
	E7FTAaJlMiiH9PJEwQV4tX0TVEk0B0Ul9xVY+/WHLxD2vZ1ZyB1yCUu0EYXOR8WjGUHpkRROWaEPe
	sMf198CcFrAAGCdeWZCfulmJBSHBF5FlqwRaJXPq4Sf9q6eKRo0hLHqXDUJluep3yWnMKECfBVMNl
	22JNJJFVxZmF37CWpTIMruCUcsl7mEdsoyVE5rcUjJ3mJ10Se0H59JVprEL6nX5urksYAEF+6amWi
	ouPB0nWxnJOxwkpCG1WrmEduvKrUVF6QOkYT0S9aoowxNhwuO56GvsjubGY2gVkNPZJJAJNuVP+pD
	Ig9eYWczQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kz1Ki-0006IU-LE; Mon, 11 Jan 2021 17:50:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kz1Kf-0006Gn-Me
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 17:50:22 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 562EA20738;
 Mon, 11 Jan 2021 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610387420;
 bh=p4w/3BSm2/B9w8K89RhlikUaqD2KKgo6ZkhWWrd/U3k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eS6324DAI9zbkUl0iZ0qawqkfGK+9VB4mjdK/Ojx7y2S2EF7jUGairYPy4hWmdGKi
 Fd8H284UigzY5bzwgAPAfRqN2RKaKRGNBKeRpMfGVlcspZD74I0qAGKBU6WCziXVoR
 tED3CJi0AZNMQVbIxNKeMlp/T0/JAfUYfkxdgITmIXgy7WCs19BCgEep/VDCRyFAdF
 7DBdYBsEVTEa6AXG6nemYFRnAGUfVzuvVMnq+GLEyKoT1irkxBnlf5IXKZlOekM+Aq
 TIx1fWUbTelHaeSGjlB2OKqMxAs9eoFU63eVCV9XwnBnNaLJXSZ1cnbVMjy0lW1bMR
 UdV191h+CkQfg==
Date: Mon, 11 Jan 2021 09:50:18 -0800
From: Keith Busch <kbusch@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] nvme: trace: parse format nvm command in detail
Message-ID: <20210111175018.GD1458209@dhcp-10-100-145-180.wdc.com>
References: <20210104155343.GA26034@michal-desk>
 <20210104160220.GB1024941@dhcp-10-100-145-180.wdc.com>
 <20210106090053.GA32643@lst.de>
 <20210108223431.GA1451691@dhcp-10-100-145-180.wdc.com>
 <CAPcyv4jLWOKDTyGzwar4C0H5euggvD_Ak6NESLd9=1THGC=ASg@mail.gmail.com>
 <20210111170110.GC1458209@dhcp-10-100-145-180.wdc.com>
 <CAPcyv4g3LKRmUOj1QHmkQ5rZ4BfH6TQaK6jKhXfb2DoBW-MoUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4g3LKRmUOj1QHmkQ5rZ4BfH6TQaK6jKhXfb2DoBW-MoUQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_125021_837070_15EB2BA1 
X-CRM114-Status: GOOD (  23.40  )
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
Cc: Michal Krakowiak <michal.krakowiak@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Michal Krakowiak <michal.krakowiak@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 11, 2021 at 09:10:34AM -0800, Dan Williams wrote:
> On Mon, Jan 11, 2021 at 9:01 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Fri, Jan 08, 2021 at 04:12:31PM -0800, Dan Williams wrote:
> > > Is there a more centralized place to land such a helper? trace-cmd,
> > > perf? The nice thing about kernel parsing is I don't need to have a
> > > separate pile of disparate tools across subsystems.
> >
> > Yes, I just placed it in a temporary location to see if the other nvme
> > stakeholders are okay with the idea. If so, I can make a real patch
> > series to remove the in-kernel decoding, and add the parsing script
> > somewhere in tools/.
> 
> "Somewhere in tools/" is still not quite what I'm asking for, I want
> something nearly as automatic and seamless as the kernel ftrace pipe.
> If I need nvme tools for nvme events and mce tools for mce events etc,
> I'd rather just have decode in the kernel. Perhaps this is a use case
> for a usermode helper that accompanies a new kernel tracing file?. If
> the helper exists the events supported events are decoded if the
> helper is missing the interface is equivalent to the raw formatted
> events. Decoded events "just work".

My only concern is that decoding omits fields, so you have to ugprade
your kernel in order to see the missing ones when the current kernel's
decoding doesn't "just work". If that's how people want to maintain
them, then I won't object any longer.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
