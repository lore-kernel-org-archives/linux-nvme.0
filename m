Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D92FCD5BAC
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 14:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qjko/TRE1WRRvwHvv6Gj+2tx1e0ugD9TDIucu1hV9mU=; b=aKU1ifiRJ9BBtyTkNPMH2m+++m
	y0glcFDcvN80/gSpXIarSMcRes5GG0Efi/23nwX1TaKCj6f//0Fh7uCMjzg+lTFpWkNqu5HTjLqnJ
	HuMGWB5j+pODrKLPfwPZjTu8wTgmpOu1SW8aMv9raghFOWNvD2JCTPc2JVg4zUIq9nT99wZZTk0I8
	euv5FyJX94nDYCKAmnMzKhywnM5YnrgKntXbTH7Y+zy/etHMZYfFGrzW6Fe6TlLo8BttxeEuwqpO0
	wil6sBsnpUsagCV2GOSrk9nhIn2W3Ee1nhOxE2QDo+CqeUJAvTnh305ywy1j0ihdC7VW8s0/uvJKd
	DXf1uMCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4Xj-000000086Ly-22EI;
	Thu, 21 May 2026 14:38:35 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4Xg-000000086Kc-21Iv
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 14:38:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 03F7241693;
	Thu, 21 May 2026 14:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630F31F000E9;
	Thu, 21 May 2026 14:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374311;
	bh=qjko/TRE1WRRvwHvv6Gj+2tx1e0ugD9TDIucu1hV9mU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aFbDbYurlY+sRAsCbGhWOWAdEXn6UJe3RrikivAxm1NP3H8mp2SWl2EYgH+FaJq24
	 p9Q8JMrH1jQT5SmVwrwfzIMukuX62353ZFoVqURCZnNS4/iy/DE/k/wXtifK6/tJVm
	 xhdK6hWqoNBRpKvpQ6YUCk+pFEykjo0gCYU7uSqeIk1XR9enl1pGWs3B8HY+LO59Fn
	 67GRjcl4vGBs04mgMdAAejUm4Cp2zPdAjaGOOGx7DBlLsH+vjdNht7nmZIrQMs5Hl5
	 fbYTns7ClILh0c6E+I/BwDvtnvaKa1EV2Embiaq4Waq/a987hwbjPvvfgQXCjSjdwB
	 9S6J6Yu9O498w==
Date: Thu, 21 May 2026 08:38:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chao Shi <coshi036@gmail.com>, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v2] nvme: reserve a keep-alive admin tag for all
 transports
Message-ID: <ag8Y5c3sjYFZzan5@kbusch-mbp>
References: <20260515071248.2689513-1-coshi036@gmail.com>
 <ag4Y5R1X0gkZbU-g@kbusch-mbp>
 <20260521082549.GA11208@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521082549.GA11208@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_073832_544558_5FB951E3 
X-CRM114-Status: GOOD (  18.54  )
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

On Thu, May 21, 2026 at 10:25:49AM +0200, Christoph Hellwig wrote:
> On Wed, May 20, 2026 at 02:26:13PM -0600, Keith Busch wrote:
> > I am skeptical anyone would produce a PCIe device that supports it, but
> > let's say someone does: what is the use case motivating enabling this
> > optional feature in this driver? If it's just because the option is
> > there, then I think we can just reject the user command submitting the
> > feature for PCIe transports, like I earlier suggested. Requiring an
> > active command will just harm idle power states.
> 
> I don't think that's quite the point.  We'd have to add special
> filtering to fix the reproducer.  Compared to that just reserving
> a tag and officially supporting the feature is much easier and a much
> better story.

This command is already special since we filter for it on the completion
side. We may want to selectively filter other Set Feature commands too.
For example, we don't want user space turning on Host Dispersed
Namespace Support, because this driver is not going to correctly react
to that one either.

