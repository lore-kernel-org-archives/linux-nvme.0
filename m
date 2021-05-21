Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92EBC47078
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 14:57:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C6561132
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 14:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C6561132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/R/AnGEGR05jX2lGcv16wCU2A4BlwqlcTRL0JL1ZNMg=; b=kORFcczOyG27wJdERdmUPJ4VkJ
	aWUtwgCMbfNwqPcm8KiM5Lz3v4l44oa3aPLHTwQez1KAioRaq2WDDW6zaCUN6A8C3Jn1aySaLe3GS
	AuETwP58jOMWqcukOXID7EYG+7SqttlldhIoXBgXPpHjbsjgVmCLdVI+aRzFRGhshCS050q+gRECn
	TL5NPajbB2QQvMODsY+CYgfkCKdeUj7aMCUYJX2vdbh85tOBcg+PvWXI/barlHsl4bWlgoFYMysA1
	KtvqrTUf16z6kQzSD238I7ivdgaq1ZrszR3Jgmjkphdpgrjc3tj34FD201NhYj7g9fvvc5TkpJ2Db
	FRH6j0hg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lk6aV-005s3P-ON; Fri, 21 May 2021 14:57:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk6aR-005s2q-71
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 14:57:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=W2IH+ugcE1gEHEkkwhXPr5opu/BazhYJKTr79j4pcpg=; b=loiosXfYMRuThILWDDt0XV0ep3
 Q+gDJUz1/B7FHqkfX7hat8N6Q5F9lQKhiWiZLgWomORFnD/5FC+X4v9hoJkY3n/noW+bEarfff/Te
 JVdjE0Pd2u/YqtSnV2A0P/ulMkJtQfdZBsTdi5OWuUjDRx2yZ7/rNq1lLE8GPBdjASRnEBI4p7x4H
 fTnhnaA8Ymn5pgGapE7oeq+lNhodu5qr+ufdPP7WLqPmRRM06+1BvZYxvZJL6tUq/jhhFPCM10WVf
 xPEKS2Z4Z+amf9mtzEzKgvUcbHw2TYxPK/cIapd0Zvvt03Xte6l+5JbHRbbeZ6fVDSb2tXNlsDgEB
 9H6KWuqA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk6aO-00HD9E-Ih
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 14:57:13 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D72E61132;
 Fri, 21 May 2021 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621609032;
 bh=MP1ZWuiaGoZ6dn6NU3Rv291MI0WIXC7H9aXQHHf6/j0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MMbiAUaYAMvpZvTIGYWnNNvtge5HeGr2VS1AIckz/r7vvrkPHJT/mIHkFfOKtLng3
 0tKYmv6xlIphR5s6X8FefMi5mZWW7k4n8qBcSIM0fZIFhglaXLlLsXR+kk2twcK70M
 //2PYihECgWvKpRvm4QsAtyWO+CZBX+GC1WL4oXWfUg6drQ7bKXg2S/nNZfhPU5mKm
 fPWYDAnQIzc2UT8BmWpGX56v04h4bdBka1edtXN3qu3l64vEWotOAtgUNdhAzLxywF
 PIAmb55bt0nZFqVz1FzggqLOykpojhKOH8/Z98iLJvTt5FCcQhVSqQPVHBTl+Tpt1Y
 6FA7Uet+LqBVw==
Date: Fri, 21 May 2021 23:57:05 +0900
From: Keith Busch <kbusch@kernel.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "Williams, Dan J" <dan.j.williams@intel.com>,
 "Schofield, Alison" <alison.schofield@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Weiny, Ira" <ira.weiny@intel.com>,
 "Widawsky, Ben" <ben.widawsky@intel.com>
Subject: Re: [BISECTED] nvme probe failure with v5.13-rc1
Message-ID: <20210521145705.GA29013@redsun51.ssa.fujisawa.hgst.com>
References: <40071b11108987556d0473f9d968fe7dcd3f304a.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <40071b11108987556d0473f9d968fe7dcd3f304a.camel@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_075712_658064_2BEBB4B8 
X-CRM114-Status: GOOD (  25.51  )
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

On Fri, May 21, 2021 at 05:00:29AM +0000, Verma, Vishal L wrote:
> Hi,
> 
> I ran into this failure to probe an nvme device in an emulator
> (simics). It looks like there is a ~60 second wait followed by a
> timeout and a failure to boot (the root device is an nvme disk) with
> these messages in the log:
> 
>    [   67.174010] nvme nvme0: I/O 5 QID 0 timeout, disable controller
>    [   67.175793] nvme nvme0: Removing after probe failure status: -4
> 
> I bisected this to:
>    5befc7c26e5a ("nvme: implement non-mdts command limits") 
> 
> It's not immediately obvious to me what's causing the problem.
> Reverting the above commit fixes it. It is easily reproducible - I'd be
> happy to provide more info about the emulated device or test out
> patches or theories.
> 
> It is of course possible that the emulated device is behaving in some
> non spec-compliant way, in which case I'd appreciate any help figuring
> out what that is.

Hi Vishal,

The patch you bisected to sends only a single Identify command, so it
sounds like that must be the command that times out. The controller is
not required to support this specific identify (CNS 0x6), but it is
required to produce a response. If the identify is unsupported, the
controller should respond with an appropriate error (Invalid Field In
Command), but it looks like the controller didn't respond at all.

So based on your observation, it sounds like the simics implementation
has an identify bug. The spec doesn't provide a way for the driver to
know ahead of time whether or not this identification is supported, so
the driver just has to try it and react to the status code. If the
implmenetation can't be fixed, then we'll need to quirk your device.

If you want to confirm for certain that the new identify is the source
of your timeout, you could try the following patch and the timeout
should go away:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a73eed61eee..b16d31d82606 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2711,7 +2711,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	else
 		ctrl->max_zeroes_sectors = 0;

-	if (nvme_ctrl_limited_cns(ctrl))
+	if (true || nvme_ctrl_limited_cns(ctrl))
 		return 0;

 	id = kzalloc(sizeof(*id), GFP_KERNEL);
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
