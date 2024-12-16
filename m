Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA516E7717F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 19:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mNc63da4ROaH7Czw3CeDTv8BcyUid2mZrEReY5WEpoQ=; b=Ylg6GK2/XE9UYBVOMmV5N5ApMo
	5zPBd62vhyHYiihWuqf+E/x0ClMfDzD3tBVSIQc7aKAhFqRh23mOgYDUx1MY13xr1kGABeCUGXok8
	w0m1mFmAGStoo63RsAxJ1iFlJP5VzqXi0Hpi/zCzk69Bhl9T5eGJmVkcnS0EosUYb9S1OfT0H5Tsl
	Wdcqv29snJWM4JfVjdsdMuScCHEM6RzU0xomdIWP9GHyQwNMeLz0trXFiP4mMjQmpl0blHY0DBU+H
	Vrf9uQUyU/9rR8BPHrqUJE/ZaIuZmPZUq3frjQNfB6yGxDjq4Cbj6ZQO/l5le/UGtzHTdmF6oFWM5
	HJnLBu9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNGx4-0000000B8vH-27Mx;
	Mon, 16 Dec 2024 19:40:22 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNGx2-0000000B8ug-136i
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 19:40:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 11DC35C648C;
	Mon, 16 Dec 2024 19:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6C9C4CED0;
	Mon, 16 Dec 2024 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734378018;
	bh=bHMzhAy1IqA4eeks9HYZpJvfcxQcCI7poEaASeIwuY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXoc+dKSlpo3UTAWWRouX61jRVj0PxLXUWnRoam7ozlVZ5R17Y1JQ4rR4AfeBYoo6
	 1oiGyjwg6kC1BL9TmFhVKwpL0OiNBkmeBunG8rTlaweDefMggbG8D+uKPXxkRNDWNA
	 iBsYpNWqAI0ks8LYZlimG4q504bafww0teNXPy221twj0JiszBtY8WGL6wCHELATjv
	 CgNQY2wogY9hZUt32p5ajTkQmjRnl+5U87OtQk3YxTypBodCBZNEmuTF5Zr7Xxpn5K
	 lW8ayJwK5iPE9nf/1W+J5hh7NnSRO6dIVl36HRlrIrPYQdsGFR3SHXHqSone3hU3uc
	 Gap5u1/nIbQUg==
Date: Mon, 16 Dec 2024 12:40:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Christoph Hellwig <hch@lst.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <Z2CCH5HAbx8ECDin@kbusch-mbp.dhcp.thefacebook.com>
References: <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad>
 <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad>
 <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_114020_337966_3BEF64F5 
X-CRM114-Status: UNSURE (   9.50  )
X-CRM114-Notice: Please train this message.
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

On Mon, Dec 16, 2024 at 08:34:24PM +0100, Rafael J. Wysocki wrote:
> However, there is an additional concern that putting an NVMe device
> into D3cold every time during system suspend on Android might cause it
> to wear out more quickly.
> 
> Is there anything else?

I recall a previous reason for this behavior was because the resume
latency was significantly faster if we don't prepare the device for D3,
and the nvme protocol specific power states for some platforms was
sufficiently low enough. Apparently this choice hasn't been universally
optimal.

