Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E27D13570
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 09:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r9gVJxpktJDVmfQQVRiSb1j0oVgQIbFAw9qNOB6Qfz8=; b=xWttyZ1NuIpMetse3pZDhPtRUX
	P1X7qOyQdmJvcuZo4YGnJc+D/63cepU8VQZ3tjIDv/2W8Yp53Woh+LSEaiNitb7GFhcgdtq95AQsI
	bXov1cl07luAN+8DCabUcMFj6f/sTPf1aihmjb5R/xm1PPMXiX4mQ/oFmkO6xKv666C+HJS2bQ2sw
	YZ5IpnhTBHzq8GIFlx0PzyPo9arScfM03rJLW55Wrt2XCeEFTL/MPg5XYGR7eLU3wZamYFKSylsc0
	lYdTgaBrLomuyfeLWjLSpavgGYkI7FohxnsG2J+1YGbQQuDn0AspCdnBsjQlYrX85uLilp1STJ+VD
	MVG2X4GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Luf-0000000AD41-1FTD;
	Mon, 28 Oct 2024 09:19:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Luc-0000000AD2y-2dvU
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 09:19:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 039F268BFE; Mon, 28 Oct 2024 10:19:41 +0100 (CET)
Date: Mon, 28 Oct 2024 10:19:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Christoph Hellwig <hch@lst.de>, Konrad Dybcio <konradybcio@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
Message-ID: <20241028091941.GA29461@lst.de>
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com> <20241025113520.GA19521@lst.de> <0fac5de3-3f35-4fc2-bbdc-411dc1018a85@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fac5de3-3f35-4fc2-bbdc-411dc1018a85@oss.qualcomm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_021946_829246_3C7B2405 
X-CRM114-Status: GOOD (  14.19  )
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

On Fri, Oct 25, 2024 at 05:30:05PM +0200, Konrad Dybcio wrote:
> (Un?)fortunately, said platforms use FDT, so we can't fix that in ACPI.

Then generalize the acpi helper to a generic one checking ACPI and
DT and specify a proper DT binding.

If th requirement to put all devices into D3 is a plaform propery
a specific driver is always the wrong place for it.

> b) Adding such a property to the PCIe host node sounds a bit
>    saner, but the NVMe code isn't aware of the RC. We could add
>    something like:

Again, this all belongs into core code.  The nvme driver is just
a consumer of this information, just like for example the AHCI
driver.


