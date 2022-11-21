Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4722C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 23:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D9Qumb5vkQhj4kn1oIkSiexnUiIAkN0jA1d+NfHZYdU=; b=Ty0zRScy/pXgrKzeeJsOXpgxc4
	TuGRA1hsVE3gxBd1Et29MiuHNxGQVGndnUpeD6JHCU+QkIuiY5hHGemE1qNOI5dUf2bY9vieSxcc2
	GCTKU8kcbIPpk1J6OSx8ke4nf/pDmN9h5aA8/knxxmBMOsX0p08C+UvXZ8RODuLXV5qwNmCzVRFad
	X/oM+gTvVvIZRiluiL8BlcPsbp3wbKqwS7x66JGQ8COezYmWr34F4P9gR+/uxfGBrp8qL/AK1kUZa
	x7y9Wo2DgOO07JSaDBXAd8Lke6HgSRpUiupFrAQYMJAO8TFkWxB9lip4jsJ36RjnybmyOFhC3uwrz
	dIggz2ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxFqW-0017Lc-No; Mon, 21 Nov 2022 23:05:00 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxFqT-0017J7-Ha
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 23:04:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 50694B8169E;
	Mon, 21 Nov 2022 23:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664DDC433C1;
	Mon, 21 Nov 2022 23:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669071891;
	bh=9G6Gabmxkd9zjTROmGV/ZqWq0G1Ria+xFxePpTMyFj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=My8xk8Coeyc/SidD1iB3d24XNr4MLmCOB57f4LKw58jPks9nhB/9YU0gXPRhYi6sT
	 vPzIa/6fsrGX4Gusu8hwbK3bjNXl7LthNpOaRkDvKfFEUjtmFbhr05vwsKU+bfMwJH
	 vDS82Zu0zpHTX/FxLzC5b58x/8RrkZIHGnn9Lu3Vla3xm6HrRKHoI7qCTiVGzdLLJI
	 /aqXr29ny8I8LT/U/xW1XcODDu921IwUS5taaWIvBz0C408/eWl1yozDCkaEpNkfjO
	 5s/3FiPVS3Ba4FjJcJNvxuEsDPvNeM1NsgfvEnfatOLCV2D1hbmQhUNNXghhERuV7x
	 pBflXwlMCU+lA==
Date: Mon, 21 Nov 2022 16:04:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	its@irrelevant.dk
Subject: Re: [PATCH v2] tests/nvme: Add admin-passthru+reset race test
Message-ID: <Y3wED5m5JHOFMMg2@kbusch-mbp>
References: <20221117212210.934-1-jonathan.derrick@linux.dev>
 <Y3vlsF7KcRrY7vCW@kbusch-mbp>
 <e99fef7c-1b48-61e2-b503-a2363968d5fc@linux.dev>
 <7dcb9e3c-aa3e-b7b9-fc30-59281d581fd0@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dcb9e3c-aa3e-b7b9-fc30-59281d581fd0@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_150457_752468_F63158A0 
X-CRM114-Status: GOOD (  20.42  )
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

[cc'ing Klaus]

On Mon, Nov 21, 2022 at 03:49:45PM -0700, Jonathan Derrick wrote:
> On 11/21/2022 3:34 PM, Jonathan Derrick wrote:
> > On 11/21/2022 1:55 PM, Keith Busch wrote:
> >> On Thu, Nov 17, 2022 at 02:22:10PM -0700, Jonathan Derrick wrote:
> >>> I seem to have isolated the error mechanism for older kernels, but 6.2.0-rc2
> >>> reliably segfaults my QEMU instance (something else to look into) and I don't
> >>> have any 'real' hardware to test this on at the moment. It looks like several
> >>> passthru commands are able to enqueue prior/during/after resetting/connecting.
> >>
> >> I'm not seeing any problem with the latest nvme-qemu after several dozen
> >> iterations of this test case. In that environment, the formats and
> >> resets complete practically synchronously with the call, so everything
> >> proceeds quickly. Is there anything special I need to change?
> >>  
> > I can still repro this with nvme-fixes tag, so I'll have to dig into it myself
> Here's a backtrace:
> 
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7ffff7554400 (LWP 531154)]
> 0x000055555597a9d5 in nvme_ctrl (req=0x7fffec892780) at ../hw/nvme/nvme.h:539
> 540         return sq->ctrl;
> (gdb) backtrace
> #0  0x000055555597a9d5 in nvme_ctrl (req=0x7fffec892780) at ../hw/nvme/nvme.h:539
> #1  0x0000555555994360 in nvme_format_bh (opaque=0x5555579dd000) at ../hw/nvme/ctrl.c:5852

Thanks, looks like a race between the admin queue format's bottom half,
and the controller reset tearing down that queue. I'll work with Klaus
on that qemu side (looks like a well placed qemu_bh_cancel() should do
it).

