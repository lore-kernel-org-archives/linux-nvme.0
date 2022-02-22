Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C25C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 17:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y3ElQ5LawHq3j6UiNzt7Y/VBv/mJG69dAF+YZVNDJBQ=; b=iR7RYoVdPqd+1acklJI2QUhgwr
	VemNjjhk/abjtZnSHER5GeATS21ZTJhXej482Mg+R3q2Qadn4DVKMUn2CAUpexx7hFDxIXrFYCMU5
	2y0g9t+2d8kJC+5xVZw1xrr0Z4sMBgTvIJyxn+kqkyxdx1kqtdClIXwdAZz0p94Gb7yS/g2oBGBCP
	KLLRnHslsvwf8C0tFnlFIP/6Qfo9E0t+sskb/kSjociiG1AZL0h3eh1zajfPDueH+369tRH9lKiT7
	sFZ5TADVQM8o7DHbtKCrGUmXCOhAlo/4hIQObRwVNd6gbX/b9TOq4SrdsqluJ1mtBKNWdPdGe+hYE
	kMn/h4Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMYbf-00AqqV-PU; Tue, 22 Feb 2022 17:05:43 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMYSW-00AnPQ-V6
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 16:56:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 68B20610AB;
 Tue, 22 Feb 2022 16:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEC3C340F1;
 Tue, 22 Feb 2022 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645548975;
 bh=XMbNZ4Yp3pB5CJy39MFuU7DbDGAoq3fnEia6T+9MnuE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hHZa6HWm+aag/twDn8vXkbA3dW4OCEZh7yQ/XwHoIWj/Srx/UQcevPHhwAukvOxDJ
 mBlnC2442ILKmdamqHIfIUyU6/oW+K2HWJKOYtUQpUe7ZDiCtMODNt+o6LspCMxnbU
 Jm5N0YkFuFoVEu+u5A4IEETNv7F2AxIg4sXnkGuPpywcKZewYHf9r6mrGJLfhrKgzq
 UuE9+yCTjGM2RbRReFJLQ9mu9qyBC9c0N77xeb06xg4ezId+2Hk+CPehprGB678O31
 4/Lv+MkxKo9pEpgdGult5zkQj3XAQnXoGmSVaEdz9x2wzp0shXBRalF66xuy5qb7Wv
 kZlbQ8b5DsEYQ==
Date: Tue, 22 Feb 2022 08:56:13 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Joe Perches <joe@perches.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk,
 martin.petersen@oracle.com, colyli@suse.de,
 Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Message-ID: <20220222165613.GB1497257@dhcp-10-100-145-180.wdc.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-5-kbusch@kernel.org>
 <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
 <20220222165045.GA14168@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222165045.GA14168@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_085617_095684_AC59EE8D 
X-CRM114-Status: GOOD (  14.06  )
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

On Tue, Feb 22, 2022 at 05:50:45PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 22, 2022 at 08:45:53AM -0800, Joe Perches wrote:
> > On Tue, 2022-02-22 at 08:31 -0800, Keith Busch wrote:
> > > +/**
> > > + * lower_48_bits - return bits 0-47 of a number
> > > + * @n: the number we're accessing
> > > + */
> > > +#define lower_48_bits(n) ((u64)((n) & 0xffffffffffffull))
> > 
> > why not make this a static inline function?
> 
> Agreed.

Sure, that sounds good to me. I only did it this way to match the
existing local convention, but I personally prefer the inline function
too. 

