Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C72C0218F
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 17:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kSJPnMwRJQ+10LQClf6h6DOG59t5HRLG2PXXI98TJw4=; b=vAiwPfzEKYN2rhlbXLx/QVBYrm
	OaHRa3O8lKcikhh5m4ldQomZiwrr/BMLND/Ue1OuX1ZFbdB1+//8H01jVpyhPP6t9ClumAWAfy2Xh
	uD7Uo34JiQlWcxQQF+7PPqicMcfJXa6kq1nBgUyUFYJ3Cwu95xQSlMJS7dvLUz7Ub75OOFi8yClSx
	4DmBn3QVtey9+axF8oRwD94wWxZ/POCJbCOEJkUBz5xmT5M6ZJ2UXnt2FLTL3v3ARCHhLbqdYJoTO
	DTBKbmbmXkT/bzmce+QbiNojPITT9gFT2bd3HrjeuIjOAZXx8dpAlwZZO/zS9Q0N2ndVVQVL+7+MQ
	D6v6PhYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdvEE-0000000B9xU-0Wmo;
	Fri, 31 Jan 2025 17:54:54 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdvEB-0000000B9x7-1aMR
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 17:54:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 79E76A420D3;
	Fri, 31 Jan 2025 17:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568FBC4CED1;
	Fri, 31 Jan 2025 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738346089;
	bh=jmnWEBQVsS0Q+41Et9gwBFHQd65WLB37LKlu5Iqquxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKwy3ExoXdD/9ExPf7mZWhrMIyC7mGfVPVbk1szF9t3dytoLHK/z3hclGTnWxhjlE
	 XIjclp9cl3GJS4sremQDFUb1yAsuHPEuVbplDycxGt6PBqjP5ZuReyg2VNIsE8gjsF
	 F2n2UZz5s7XczIzhiqukEQW1Y7R6SKImFP9POELuIKrpimSEzUTswwJzst0G0lwOhM
	 AQgjY4L0ZXWZRavkThpxWq2EO9LjaRsd30zUymipDO+z4UnoEaiEP+95jjhWSP8b0d
	 K2rVUoez0qELNvmn3RoyukPCiBQNSLSJj1G8pgXDVV+BLOz5+uGs/IU1dRf46VCSK4
	 kYOe1jRF9WgSQ==
Date: Fri, 31 Jan 2025 10:54:46 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, pmenzel@molgen.mpg.de
Subject: Re: [RFC PATCH] nvme: replace lazy sgl warn with informational
 message
Message-ID: <Z50OZsVUvKQHvorh@kbusch-mbp>
References: <20250130175131.3613423-1-kbusch@meta.com>
 <20250131074828.GA16628@lst.de>
 <676bf767-44fc-4930-905c-292360d9c8b5@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <676bf767-44fc-4930-905c-292360d9c8b5@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_095451_479849_264DF5DC 
X-CRM114-Status: GOOD (  23.27  )
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

On Fri, Jan 31, 2025 at 10:06:24AM +0200, Sagi Grimberg wrote:
> On 31/01/2025 9:48, Christoph Hellwig wrote:
> > On Thu, Jan 30, 2025 at 09:51:31AM -0800, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > Instead of warning about the device's SGL capabilities the first time we
> > > consider using them with a passthrough command, print out what the
> > > device is capable of during initialization. While we're at it, print
> > > other interesting capabilities that may be useful to know when you just
> > > have a dmesg. The ouput format was inspired by other existing subsystems
> > > like pci.
> > > 
> > > And example of the new message when used with a default qemu nvme
> > > emulated device:
> > > 
> > >    nvme nvme0: sgl+ meta-sgl+ sed- vwc+ apst- dsm+ wz+
> > Printing out the capabilities sounds really useful.  But I don't see
> > how this is useful for replacing the warning about the unchecked
> > passthrough?

I thought this patch could remove the message because it tells you
upfront what you'll get if you use the passthrough interface. The
existing message tells you what you're getting once you actually try to
use it, so they felt a bit redundant.

> I agree, I'd keep the warn_once messages.

Okay. The problem with the message is that it's a new warn, but nothing
has really changed as far as what the driver supports, so having it at
the "warn" level caused some alarm. Any concern if it's an info_once
instead? I just want to avoid repeat explanations on its implications;
I've experienced several offlist discussions about it already.

