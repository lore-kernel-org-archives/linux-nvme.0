Return-Path: <SRS0=hrUZ=HW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A94C433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 16:08:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321D860C3E
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 16:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321D860C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vXmUYwnhm6uZQ0Ba67ny2Q3EI7i58KK60AwCfC3m0cU=; b=0SZ5/WY5nBst+ZQITtXxKcYl7
	JgWKa5468Ex1qC0sLF8OTt+Qn/iP28Qj0ccYapA5Z6AgDB+mBWx3Z59iix9O9gJ5VrMmym7Phd6Kg
	MD2MDIzR1h30RHMstrDFLuTmaHZ57u6gzqLXHpZw521zRT2na+wGFEvquypH9KEJz/6o7izxNBRSZ
	ot7sDDp4tQujOG4a7ud2NHPPWgaUnNKC8ay7Fh4F4O9MsydjZJb74bxEP3xU0PZpMq1uGKnjV30i5
	g+xBvPCdjbff4uPtbr9qC9BsxEe5ekMCBajInoWF5OXcrzucHVRCtQWSb8rvtVP4B4TTDkP/xDlHu
	DsTp5B9qQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDUnR-00010Z-2T; Sat, 20 Feb 2021 16:07:53 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDUnP-000108-6z
 for linux-nvme@lists.infradead.org; Sat, 20 Feb 2021 16:07:52 +0000
Received: by mail-pf1-x42e.google.com with SMTP id w18so3870554pfu.9
 for <linux-nvme@lists.infradead.org>; Sat, 20 Feb 2021 08:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=l61Gx0cd7dgC0bCQ7cuYmTIAmkuc+oBazgGtchl6J78=;
 b=LoWJ5Y+0SyPPqs6yt3ERDM0EF0otmQ5SdkD913s1RCsWxVQqtNOFX/T8AXN3iuAkCV
 gXXFQQ4Ar+Q+k2OSbl28MsvkT30FUpxySFp99lSlntDNH5+LgzernVsVIdxwg67gKCBc
 fXwgmG0X+W9wW2XgroCd8WDY9CdOcHi+wRYHjtDFKBCVfOC7vrvy8pg8QHaqFNkCGOKO
 TUHah3vS1qCKXUBRf5KIr6k9Aqc1ZWDLgncywB9bdFZ2N+UT7iyJ337Wx+iDFkvg+EIC
 y75raKD64hLzd8YAhCgRQ3m/Oanu1/tUHg8jf2JqBkZqtXkCqB78rWIEwS22pCVu7YOH
 gjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=l61Gx0cd7dgC0bCQ7cuYmTIAmkuc+oBazgGtchl6J78=;
 b=iFsTT1woT1CmtZe/UBPrDH/uEo0fDPxIk8WllQbqAAdCpXL31IFbU7h8ZIXoDy81mZ
 FE2C8QVdcaLdAc4jHfwQZrdS8FR20C0gT/fQMsI8aip8ZA0klhmKsry2UVd+g0qMyfPe
 UFL9XwHGboayqb002MWf5GCiDMfw2Ocn79sB0J4xOBDPO3Xm5rPf1/kecOdlLoUpQQAJ
 TuSkXOfaLmdd+9Y4lm925suOd3tbXioxusdQo61A5OG0eU7NjpVk/sil42Hch4UDvvvx
 Bzm7LCU8f4cd+uSTcM7jf3Sz4hErJtuqJxjr9x/BwczXfPDHCeVY0TiWqeVid6xG9rmP
 Kb4Q==
X-Gm-Message-State: AOAM5315gTeHgGVi+CUh2CmmzidvHO/+6dUZzutJRsGoVtC10JzaEk+b
 Pkb1kDZBIFEOueTpu/aWMuI=
X-Google-Smtp-Source: ABdhPJyVZ5hfU0yzHoZhJDczffXJNvKU/IXCNFqHeteqPaiEkGyh8atycZee4+dUUFTghSiWhkFUHQ==
X-Received: by 2002:a63:e442:: with SMTP id i2mr12682800pgk.12.1613837269026; 
 Sat, 20 Feb 2021 08:07:49 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id c18sm13454284pfi.167.2021.02.20.08.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Feb 2021 08:07:48 -0800 (PST)
Date: Sun, 21 Feb 2021 01:07:46 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: add support namespace management to sysfs
Message-ID: <20210220160746.GB237584@localhost.localdomain>
References: <20210220154004.242622-1-minwoo.im.dev@gmail.com>
 <20210220155027.GB4105@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210220155027.GB4105@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210220_110751_325130_749F182D 
X-CRM114-Status: GOOD (  22.02  )
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
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-02-21 00:50:27, Keith Busch wrote:
> On Sun, Feb 21, 2021 at 12:40:04AM +0900, Minwoo Im wrote:
> > Namespaces are generally managed by scan_work.  If admin needs to attach
> > namespace to controller, admin command like `nvme-cli` should be issued
> > with rescanning controller.
> > 
> > If admin issues a Namespace Attachment command with detach option to a
> > namespace through IOCTL, kernel is not aware of it.  In this case, block
> > device for the namespace becomes meaningless, but still shown in the
> > kernel space as maintained.  After the rescanning the controller
> > manually, namespace node will be removed from the driver and user-space
> > will not be able to I/O to the namespace.
> > 
> > Add support for namespace management (attach/detach) to sysfs of
> > controller instance to make it easy to attach/detach namespaces with
> > kernel-aware rather than non-kernel-aware passthru via IOCTL.  Also, it
> > provides closer relationship between the device and kernel for the
> > namespace perspective (tightly coupled).
> 
> Nak. The kernel should be aware of the altered namespace inventory via
> Command Effects Log or Namespace Notify AER. If the controller doesn't
> support either of these, then the user gets to do a manual rescan, which
> is not difficult task either.

Thanks Keith for your review.  I think I missed NVME_CMD_EFFECTS_NIC
part in passthru code.  Sorry for the noises.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
