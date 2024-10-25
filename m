Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29558D149CD
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 16:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j9+tlMzMKxpXla7vcJj0nYrmoYeTrNtFSlBJbOgMJbI=; b=jdN+4aI19ZPVlOxxx3KWJE4E0S
	vq9a1SuqW/0nEDGnrbeXx5pkZlgVdOEjxNm+qrFwif+78pLTUhoBdIV7+lzemhUWN1XY2X9gLkjUz
	m9amZVDzoNZrvFpWb6ZE80VSG5xX0Mv71PqdRd38MlZxmQql5WrQJBZ4/H1yvXD45TSVVqVtrXd/C
	d0BhPqdOD/x7VeKXFoJv64rzASP/3cV0+DxydtjO0oQ25NA3lA4Q1Zpm28geWcFFoH9mZdUfgEJy1
	jnDIeRWS/e3yh/ijAZs16THyz3QfePH5/wMLPLywBF9mn+Mpyd30awp5THwj3jqVuI7FcZ0gKD5cZ
	STUtPX6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4NdT-00000004VQ1-2oj4;
	Fri, 25 Oct 2024 16:58:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4NdM-00000004VNc-1yhp
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 16:57:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0BA315C5F08;
	Fri, 25 Oct 2024 16:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E63C4CEC3;
	Fri, 25 Oct 2024 16:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729875474;
	bh=HUpNZpAn4AV5+8BT8IJZiEa8fpELq7F5u2lA8eycX5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HwbPG9m6BnIkB4Hsb+TIrzuTZHbe1pSWOWluEva/NKSyQSEgKHhgIo9Lzg06kJKn6
	 I8EuKlMLd5CRympe7hKqLvBHGmO5UmV+bHqrk7ddtBe7Wv2XJYzhYonFGgUS5vbIrg
	 deOMSEv3tKRoGEEgD9U6/snpqwBek5UBWzTdL6zjTgb1S9SJZT5xU2ueX6Mi/WkHMX
	 Y/qA07AoySXKW85emWuv4BR8quUnOwselnRHo9k5lcoMslS0hUblfeNOQmfhPMMJ7Q
	 LMLvsZGVNSW7yYCZNcT0J385NZBjo+L5YfAXOSK3ufwWjwOl6zjC+5BVSUOsjxwzVA
	 CIMNnvK8vuFWA==
Date: Fri, 25 Oct 2024 10:57:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
Message-ID: <ZxvOEOXzLIsbEbve@kbusch-mbp.dhcp.thefacebook.com>
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
 <ZxvDZVKtM9qGYBP_@kbusch-mbp.dhcp.thefacebook.com>
 <867d7b15-6861-4300-83aa-55a6cdf87f58@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867d7b15-6861-4300-83aa-55a6cdf87f58@oss.qualcomm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_095756_578355_6F6D940F 
X-CRM114-Status: GOOD (  18.46  )
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

On Fri, Oct 25, 2024 at 06:40:23PM +0200, Konrad Dybcio wrote:
> On 25.10.2024 6:12 PM, Keith Busch wrote:
> > On Thu, Oct 24, 2024 at 07:33:07PM +0200, Konrad Dybcio wrote:
> >> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>
> >> The Qualcomm SC8280XP SoC requires that all PCIe hosts are powered down
> >> before the platform can reach S3-like sleep states. This is very much
> >> similar in nature to the issue described in [1].
> > 
> > The "SIMPLE" quirk is only supposed to affect kernel managed runtime
> > suspend states, s2idle or s0ix. Shouldn't s3 already be using the simple
> > suspend?
> 
> So on these platforms, all system sleep states (incl. S3) are entered
> through what Linux sees as s2idle, with a separate MCU doing a lot
> behind the scenes. s2idle of course also covers the runtime cpuidle
> cases.
> 
> All but the deepest state (which Linux doesn't differentiate as of
> today) are effectively somewhat like s0ix.
> It's a bit hard to draw accurate lines between Intel terminology and
> what we have here, as there's way more things onboard than just the CPU
> cluster that may be operating independently..

Gotcha.

Is there any sleep state on this where using the nvme managed power is
advantageous, or is the simple suspend preferred in every scenario for
this platform?

