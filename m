Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3843E77188
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 07:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z9lAtYQq3A9Cj5itl6GpOZkPFgHbN6tQezuB+WO8P8g=; b=AO3FeN2P0hpOwTOgfcbtaTg2Ip
	YHWnx08SLGz2MBHgaV/rSeG3LLfm64+/pCWvnvYs72eHuPnDXkgH79+ii4b2NiGOtQwiw0rqGewbl
	zw7JsQKYp8UBpX5oXteUiU5XBLOesvjINIVJvHMt02OQ2hVG1/BTBUMPbwRiswrnXUEryruwhP7u0
	9JCeCpDbeZd+CmHlPe8BXmKmjcynXIar3p+hEGA6bIXAnZnRTlaj0PbNSt/U8rvMa/9zzOX8oapvb
	Aws86YEoqcUZFUqpsm6Yn8Y/BATBc0wOsuLASoDWwsfVo2N/TX8WCpU3kUZ/qUFCDtujAGx69JJIM
	YW9kAV4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTc6O-0000000CKrq-0k4r;
	Fri, 03 Jan 2025 07:28:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTc6M-0000000CKqt-0TE2
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jan 2025 07:28:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 981C868BEB; Fri,  3 Jan 2025 08:28:05 +0100 (CET)
Date: Fri, 3 Jan 2025 08:28:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20250103072805.GB28920@lst.de>
References: <20241209143821.m4dahsaqeydluyf3@thinkpad> <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net> <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com> <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com> <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <20241216162303.GA26434@lst.de> <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com> <dd557897-f2e0-4347-ae67-27cd45920159@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd557897-f2e0-4347-ae67-27cd45920159@oss.qualcomm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_232810_308293_84D17D16 
X-CRM114-Status: GOOD (  20.50  )
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

On Fri, Dec 20, 2024 at 04:15:21PM +0100, Konrad Dybcio wrote:
> The Qualcomm platform (or class of platforms) we're looking at with this
> specific issue requires PCIe (implying NVMe) shutdown for S2RAM.
> 
> The S2RAM entry mechanism is unfortunately misrepresented as an S2Idle
> state by Linux as of today, and I'm trying really hard to convince some
> folks to let me describe it correctly, with little success so far..

Well, not advertizing the right mechanism isn't going to cause havoc
to any scheme.

> That is the real underlying issue and once/if it's solved, this patch
> will not be necessary.

Well, maybe this thread gave good enough fodder to finally fix it?

> 
> > In theory, ACPI S3 or hibernation may request that, but I've never
> > seen it happen in practice.
> > 
> > Suspend-to-idle on x86 may want devices to end up in specific power
> > states in order to be able to switch the entire platform into a deep
> > energy-saving mode, but that's never been D3cold so far.
> 
> In our case the plug is only pulled in S2RAM, otherwise the best we can
> do is just turn off the devices individually to decrease the overall
> power draw

FYI, going to D3 for S2RAM seems perfectly reasonable from the NVMe POV.


