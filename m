Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BC1C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 17:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z6ZkAKcGAc8HyB5DxrQiZvs7DK8Ja5ViwJAo9ydHrpY=; b=TDpT1dBlscB0G/f0TtTRTByB1W
	qZtSEEl9S5ltv6JAsiwEAd58YDqlEE++hb56h/5jqf8Bv33rtADpwtria2jKcERjQvflJ3zgxOYpY
	6aKNWtx8/KVzEKa0WnzaMP+M04md6CWIUoIXox6Lac4eduHeogTk+LtBGBDfdIvt/fEysMVr2hPkz
	fPJcXhgcZGpjOOAP6V53mULtnG3Uatw1ajVmumPEAowi8Yepkc0AoTsK3o9ABAFL7IoQyPCMyr5ry
	+hBE5Uerl8WJ8exVQTM3QyQR7ZY34wxZvGkT80IPIQcnhhNQc/QUX5Cw0Nofly/38pdVfjahHocKD
	AX2sWemA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKNrN-007ryW-JX; Wed, 16 Feb 2022 17:12:57 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nKNrG-007rwX-6k; Wed, 16 Feb 2022 17:12:50 +0000
Date: Wed, 16 Feb 2022 09:12:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>
Cc: Christoph Hellwig <hch@infradead.org>, Vidya Sagar <vidyas@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Message-ID: <Yg0wklcJ3ed76Jbk@infradead.org>
References: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
 <YgYAs7R/1G2Y2kpz@infradead.org>
 <9b291987cf914f119788c42b32a08a12@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b291987cf914f119788c42b32a08a12@quicinc.com>
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

On Wed, Feb 16, 2022 at 04:07:05PM +0000, Nitin Rawat (QUIC) wrote:
> Hi Christoph/Keith/Rafael
> 
> Since we are giving control to PCIe (NVMe power rails control), it can vary from platform to platform.
> More over, PCIe driver doesn't control these power rails directly from PCIe driver, they tie nvme supply with one of the pcie supply and control them together. 
> So i think it would be better to either have quirk based on platform or always setting simple suspend and platform which needs full suspend can update it through some means. 
> 
> Based on below link, Looks like this can be across platform ...vidya also mention similar concern for tegra platform.  

Here is the thing:  nothing here is really NVMe specific.  We do have
a bunch of drivers including nvme that would love to not do a full
firmware shutdown on a suspend.  For storage devices this is especially
important as each shutdown reduces media life time.  Until very recently
this has been perfectly fine, but now various platforms show up that
want to completely disable power to PCIe slots on a system suspend.

The drivers need information from the PCI / PM core when a ->suspend
call requires the device to got into D3 and when not, and we can't just
do that with quirks in the various drivers.

