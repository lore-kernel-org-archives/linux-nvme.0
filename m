Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4BDC433E6
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 16:57:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA4E64E46
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 16:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA4E64E46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hlm/UeWI7RI6qdSp5rD0s97UAOO+Dxse2HSHfn6cdQc=; b=exog8iETslgRyCTEuY+OrQptB
	SSgFVs4NX+g0BHHZOYNEJjQ15gvdduVraeimjg2CVv9a08RvQkUwXAc2UDSwxS5ZgAysGgAb4Vyip
	Hd7ZrX8eSSEBz/p/YWsQnP2HR+8HwwxNMC3LDTJ4BdDEgsgaDe59ZGE7O4WUUqxfC3CjVEqDfFkqf
	Q7J5IbVwFWRTacLR5+rjaRCnNsy++xmdQNF1LhNM0i9Z7M2EC9GIooYd6GWiaOOxYWIq0dLZ4+Sx7
	tFmzNvebLfL17ebvmfixaJg96MsMivQVSdCuE/xZdKak4lJaLSWlORTd3rSjqIF/fNO0v30I+97vK
	bAgB8sR0A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7LSn-0005kw-30; Wed, 03 Feb 2021 16:57:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7LSl-0005js-39
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 16:57:07 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F49964F7C;
 Wed,  3 Feb 2021 16:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612371424;
 bh=I+g8x9mYX7X8vykWccvemJU19qt28o5A6TRl10sMrI4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c2CCg+31Wd2u3fNfOUCiJBtfZzbZ9QK4fiA9EFMoBaxez5C5VE3VHiCrsVNjjUbi6
 sIlL5JxN8+kdyMibj+G3Xczs1auu6GYr7Fo/wn0Y18P5gxMiS8NgYBcrxteEhXhXxE
 nOUOmWqn0DE9gbMky+cAgaqxHk0aVLLP+terDeIOBbszItkyq8U7h0BSjjlcAEZbcP
 q0IadN+iLpXJ47mIfiVVMcU6gUlOWHE8os7heWnvloFj0aM8CCERjB6y1oAOs68kaz
 KUMLpzlV2ZsY7RCHWqklmYQmEKuju1RAaf1DhTimxTVuyCaynbl5lpsik/F+hddGsc
 ATdhvUH/Lo30Q==
Date: Wed, 3 Feb 2021 08:57:01 -0800
From: Keith Busch <kbusch@kernel.org>
To: Filippo Sironi <sironi@amazon.de>
Subject: Re: [PATCH] nvme: Add 48-bit DMA address quirk
Message-ID: <20210203165701.GB2182779@dhcp-10-100-145-180.wdc.com>
References: <20210203094338.19473-1-sironi@amazon.de>
 <20210203095148.GA8897@lst.de>
 <0c38f5eb-41ef-7934-940b-77b6e73c5239@amazon.de>
 <20210203111548.GA11075@lst.de>
 <396b45d5-3dd5-8159-34c2-5668510d1d68@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <396b45d5-3dd5-8159-34c2-5668510d1d68@amazon.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_115707_268689_F92DF9C3 
X-CRM114-Status: GOOD (  23.01  )
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
Cc: sagi@grimberg.me, serebrin@amazon.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, Christoph Hellwig <hch@lst.de>,
 dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 03, 2021 at 12:22:31PM +0100, Filippo Sironi wrote:
> 
> On 2/3/21 12:15 PM, Christoph Hellwig wrote:
> > 
> > On Wed, Feb 03, 2021 at 12:12:31PM +0100, Filippo Sironi wrote:
> > > I don't disagree on the first part of your sentence, this is a big
> > > oversight.
> > 
> > But it is not what your commit log suggests.
> 
> I can definitely rephrase the commit.
> 
> > > On the other hand, those controllers are out there and are in use by a lot
> > > of customers.  We can keep relying on luck, hoping that customers don't run
> > > into troubles or we can merge a few lines of code :)
> > 
> > Your patch does not just quirk a few controllers out there, but all
> > current and future controllers with an Amazon vendor ID.  We could
> > probably talk about quirking an existing vendor ID or two as long as
> > this doesn't happen for future hardware.
> 
> I know that the hardware team is working on this but I don't know the
> timelines and there are a few upcoming controllers - of which I don't know
> the device ids yet - that have the same issue.
> 
> To avoid issues, it is easier to apply the quirk to all Amazon NVMe
> controllers for now till the new lines of controllers with the fix comes
> out.  At that point, we'll be able to restrict the application to the known
> bad controllers.

Just set the quirk for the known device id's and append more as needed
(which should hopefully never happen). Sure, your future broken devices
may not work with the first kernel that introduced the quirk, but this
is how the quirks should be documented in the code.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
