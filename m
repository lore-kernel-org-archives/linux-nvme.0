Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFE5C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 08:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PNSPXcTakOdSzuG/rC/0dZ+ripYQwjnSDbim+Y9deqQ=; b=QX9JmziOpDyUFghXY+BfUpznzB
	rrbdbeDdXz0HYQZ2MVNnVPoBXLJxD9/60NastM9qDuPvV5NgmQ6N1UFMiW3DocEOlA4j0unIA8KmY
	0lO3BCTMfAZ9Y3MT61zS/v+ei72flF6sni9j/W/dqEKwLZJxLXakEZdBQ0sLXMsNX3Ei42cvn11rC
	1P7zRzD10OdqBjbFXH8KsJo36Ico8nMW9cZ3HWAFiI/ajYOS4D+c2XWRWc+OaSx8HdDReHe6xorUy
	5siAGfT9mBuAT+3YN112pcdgAdFxfdK8NRzkkd1rU+nO4QCtGmTZv+5OBwnIGQpLvzi7dbxKDNL/i
	7PU8NJ1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrFHt-000eL3-PZ; Wed, 18 May 2022 08:44:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrFHr-000eJW-4Y
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 08:44:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F149768AFE; Wed, 18 May 2022 10:43:56 +0200 (CEST)
Date: Wed, 18 May 2022 10:43:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 hch@lst.de, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
 bjorn.andersson@linaro.org, axboe@fb.com, quic_vbadigan@quicinc.com,
 quic_krichai@quicinc.com, quic_nitirawa@quicinc.com,
 vidyas@nvidia.com, sagi@grimberg.me
Subject: Re: [PATCH 2/3] PCI: dwc: qcom: Set suspend_poweroff flag for SC7280
Message-ID: <20220518084356.GA6933@lst.de>
References: <20220513110027.31015-3-manivannan.sadhasivam@linaro.org>
 <20220516201950.GA1047412@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516201950.GA1047412@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_014407_358644_121E2D4B 
X-CRM114-Status: GOOD (  13.51  )
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

On Mon, May 16, 2022 at 03:19:50PM -0500, Bjorn Helgaas wrote:
> No doubt "power ... will be taken off during system suspend" is true,
> but this isn't very informative.  Is this a property of SC7280?  A
> choice made by the SC7280 driver?  Why is this not applicable to other
> systems?

This is really braindamage inflicted by microsoft with the StorageD3
property on ACPI systems.  It is in general a really, really bad idea
as it saves a little power but massively wears out the flash.  It seems
like Chromebooks and DT just want to keep up with the Jones.

Which is a reminder that we should probably integrate the StorageD3
handling into this framework.

