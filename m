Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD4EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jan 2022 16:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mz5SigQC73AGMm5Nikx5Un4/iSv5OMohA3ouBAWFmL4=; b=4AojZqAAe2KpkmpEGRHIHfbX7i
	Jz6CFTvs+YhQ4YLA1z+oxucFghPgf0v8PYPyejr+EnYF8JEcC7SfWGcOGRGkqvH9ZGJz64KGHQStZ
	lgR+5KIwxN9wSNWDXsbSmbM4HY9dwbqmDomOz0mSv8Q40sBCDnuOmlvJwTv3EoPwzJFgeewy06A/p
	jXu/nqzDqUpOf58XwpMUPdr/RFI3RgNUMRMzbt4CHWbeqgHjT9ef9r47sPkBhyx7dJr4iUjjo5w+f
	la6vSzMeArP5TquNPNSDfIiI+fzwe3iq7iDVdhM3wEcNo+AvkbAr5Lpame/1Dy5sjIejvF5y+dPz9
	O0X2FneQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n82iN-006W2G-KW; Thu, 13 Jan 2022 16:12:39 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n82ht-006Vjk-VO
 for linux-nvme@lists.infradead.org; Thu, 13 Jan 2022 16:12:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0633BB821B7;
 Thu, 13 Jan 2022 16:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21243C36AE9;
 Thu, 13 Jan 2022 16:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642090326;
 bh=SQFiun4HMi3NoKxRPK5MZUTzjs+vR/1xr6gxlZEfcKA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bFzsTSTeZHzrmob/gtWHRtKQ8UUKLFK3QhJzrCCCo87Zz0D9RAFCpxOaMUkGkOZP1
 WKqCVxKQZx+/RjUUn55+061YOfSKuWYxc0EUdULTKGevPvbUfFT3EbUGZtCufTWW1e
 bm3XiEs0/j3wdaM1Fe75dlP4Uxyzgesa9GdLf3lGFcso+PRS2PocXg0F6m6h9H2/+v
 GZdL1DH4jFXxrUEUCsSHcoFzvqLFOCOVpEuq4XCy2ZMt0nkoDZOw09657wEw5SkJTS
 9ebD/uWEWQ35wKVPjQQehN9gO6LgntQESc1yS/XY6PoN01heFwPT1hQFH0CHt2QwH/
 ywwbaVNJqIixA==
Date: Thu, 13 Jan 2022 08:12:04 -0800
From: Keith Busch <kbusch@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com, sagi@grimberg.me,
 Rajat Jain <rajatja@google.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Mark external NVMe devices as removable
Message-ID: <20220113161204.GA3230285@dhcp-10-100-145-180.wdc.com>
References: <20220112013154.1210480-1-kai.heng.feng@canonical.com>
 <20220112071659.GA4502@lst.de>
 <CAAd53p4+WjhPM6VKZOZKQ4WcgNWjR7Eh_7Kjs1HZ_wiKov6Ctw@mail.gmail.com>
 <20220112140304.GA27446@lst.de>
 <CAAd53p5Qo3+-sXMLLPxe3ckY4ySxRvaLZkv=0zgKc=EVun9uYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p5Qo3+-sXMLLPxe3ckY4ySxRvaLZkv=0zgKc=EVun9uYg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220113_081210_221866_289B058E 
X-CRM114-Status: GOOD (  13.80  )
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

On Thu, Jan 13, 2022 at 02:39:02PM +0800, Kai-Heng Feng wrote:
> On Wed, Jan 12, 2022 at 10:03 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Jan 12, 2022 at 08:50:33PM +0800, Kai-Heng Feng wrote:
> > > USB thumb drives also use this flag, so I am not sure why it's not
> > > applicable to NVMe?
> >
> > They shouldn't report this flag and might need fixing.
> 
> So what should we do? Introduce a different flag but with identical
> usage for external USB and NVMe storages?

What's the user visible result with this flag set? Does some rule
automatically mount a 'removable' block device's filesystem partitions
to something like /media/?

