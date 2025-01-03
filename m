Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C26BE77188
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 07:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FfUgLg4MKgKPz3LBP2tMYjj4Vybzdjf2gR22EUCoGfI=; b=sWG/btQwll0yWakJr9AXKy2ceb
	i4FXewHJOdpqDQcccNgaI0S7UaHuTVRs+Gtgn5IvpCarBqkbndrnpb6beCBNfCcS4NBDaEpJ8jH4+
	zdJ0o44UgE/hvgS7dIrxLwFpc9QCAjUEdKtE/3WRQw6n0OGhVk9DmdrLeJayDqb9ykazX7Q5cMxJn
	jdLF9YnSj9TccMH02inY8zIBmOtYxqsBGjsPHMYHXIqN//1QsG0matyyiCXY28qIvEKw49j5qgjAK
	3PBDFzZj0Q4fYBcZcGPrOHAVwlMWkpnNGEsVDA/iroHOjmbXSMPV6ojaJohgGj9heWxRadpThZyFY
	YMnANK+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTc4h-0000000CKag-27KJ;
	Fri, 03 Jan 2025 07:26:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTc4e-0000000CKZS-3dGk
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jan 2025 07:26:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70DA268BEB; Fri,  3 Jan 2025 08:26:18 +0100 (CET)
Date: Fri, 3 Jan 2025 08:26:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Christoph Hellwig <hch@lst.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20250103072618.GA28920@lst.de>
References: <20241216171108.6ssulem3276rkycb@thinkpad> <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com> <20241216175210.mnc5kp6646sq7vzm@thinkpad> <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com> <20241217052632.lbncjto5xibdkc4c@thinkpad> <CAJZ5v0gjrBUgejwBz1vv6P83oZiYu8AuDMs47ZAFJoNhMaMdpQ@mail.gmail.com> <20241219080217.fr2ukr7sk4a7hfmo@thinkpad> <CAJZ5v0hByaAAaYGhAvstwtfa-JP6JRQCbWCZrTsRGWEHHyRKdA@mail.gmail.com> <CAPDyKFqc+YuAyV-120Vvg7HOkhgnJ=wM53LAHTkJ6Gg5=rJumA@mail.gmail.com> <CAJZ5v0gVCjhqLhNz-e7J4nZ05gJO9yYbRaNVuFdQRtO6JbTGfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gVCjhqLhNz-e7J4nZ05gJO9yYbRaNVuFdQRtO6JbTGfA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_232625_042151_DBAD7D75 
X-CRM114-Status: GOOD (  20.25  )
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

On Thu, Dec 19, 2024 at 07:28:53PM +0100, Rafael J. Wysocki wrote:
> In the particular case of NVMe, though, the question of how to
> actually power it down is still open.

Powering down nvme controller is down by shutting the controller
down (nvme_disable_ctrl with shutdown=true).  

> Until there is a clear answer
> to it, the possibility of powering NVMe devices down and up too often
> is not really a practical concern.

Why do you think it isn't a practial concern?

> Generally, the problem of choosing suitable power states during system
> suspend is not limited to storage (for instance, if the sleep time is
> going to be short enough and it is known in advance, it may not be
> useful to change power states of many devices because that is just
> going to take too much time) and the attempts to address it have been
> very limited so far.  There are many factors that come into play, like
> how much energy is to be saved, how much time are suspend and resume
> transitions allowed or expected to take, which devices are expected to
> wake up the system from sleep, etc, and the possible device wearout is
> one of them.

It is true that this applies to all kinds of devices.  But for (flash)
storage devices it is more important because of the effect on device
wear, the shutdown (and unclean restart) times that are much longer than
most devices.


