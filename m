Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821C8E7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 15:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/33kSsBT+a95Jvcg5fdQm00jGHtkq6JLY6ZjFz+7MSA=; b=GXTMhVglGHLkIOdnudLLVfdKiK
	TLmq0hf07zcFqLnEhzH6N4WVAQ7Nwv6KnzOmrsoTjH9cbHxF+IlG13RTHQbV1RhLqOlk1wPS8oEwC
	g6jXINj1n/nqDi9l+YFfW86Ch1913gHWXdIQBzUEaSIVFCywcuv4WYLaGwAZNklhb49BhKYaSmXLm
	mNtX76o80kWRcuZwJeECia2/ZiCbDbG2/3ps9dJZ59NqP0mEAFtcNrJOQruHgZohVXV+xaOJxyJA4
	1F1h0WCzZtSmV6Ismwr+VpmUt0z/lEj3W+ETgrUuSCMqR2oKYaiYY3cDUv72nkLu78o31658/i4Kp
	ZIYP5kYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLktg-00000000ihV-3Ein;
	Thu, 12 Dec 2024 15:14:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLkt5-00000000ias-3vHs
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 15:14:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3BF9668D32; Thu, 12 Dec 2024 16:13:54 +0100 (CET)
Date: Thu, 12 Dec 2024 16:13:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241212151354.GA7708@lst.de>
References: <20241205232900.GA3072557@bhelgaas> <20241209143821.m4dahsaqeydluyf3@thinkpad> <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net> <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_071400_112350_0D6FD26D 
X-CRM114-Status: GOOD (  20.28  )
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

On Thu, Dec 12, 2024 at 01:49:15PM +0100, Ulf Hansson wrote:
> Right. This seems to somewhat work for ACPI types of systems, because
> ACPI is controlling the low power state for all the devices. Based on
> the requested system wide low power state, ACPI can then decide to
> call pm_set_suspend_via_firmware() or not.
> 
> Still there is a problem with this for ACPI too.
> 
> How does ACPI know whether it's actually a good idea to keep the NVMe
> storage powered in s2idle (ACPI calls pm_set_suspend_via_firmware()
> only for S2R and S2disk!?)? Especially when my laptop only supports
> s2idle and that's what I will use when I close the lid. In this way,
> the NMVe storage will certainly contribute to draining the battery,
> especially when I won't be using my laptop for a couple of days.
> 
> In my opinion, we need a better approach that is both flexible and
> that dynamically adjusts based upon the use case.

Agreed.  I'd be happy to work with the PM maintainers to do this,
but I don't really know enough about the PM core to drive it
(as the reply from Rafael to my mail makes pretty clear :))


