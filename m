Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C13C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Apr 2022 05:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gLjiVH8iNH5jUt9ousb2g6gL91YM6+MV1JHdczVHJS0=; b=ET86eqME0gbxnFZ8i/xa8X55KM
	Bdb6HvhDlqnPwuy2mazpwCTx5q9VN8FvKaWdnH7AueUwgrrsunvxYRQShdRJ5SV0NY5cl8cv4Wefg
	+MsIUluTQ2IWPPpsFGrgG7eqbfXzAtyNazNxke72p09Zzyb59GbdgtL1b0VH0WfngY5eSj9U4OLBd
	ylqtx10mozk89s3V94/gUm4S/XlDtJni0lONi+OASUFhwU9ve7XlR7dLZZj+DUs7siX9d/8KdPjDq
	BlzRwsinqxGgPB1BFhRmJvY6rbOAIk+EsFe9KFsby2bNtVrB94jiYojfEzHGFOVm8hvyIdzgi9f1x
	CfiAvYSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ni8eP-003WSu-3f; Sat, 23 Apr 2022 05:49:45 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ni8eM-003WSS-NS
 for linux-nvme@lists.infradead.org; Sat, 23 Apr 2022 05:49:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5A9EE68AFE; Sat, 23 Apr 2022 07:49:38 +0200 (CEST)
Date: Sat, 23 Apr 2022 07:49:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 Rafael Wysocki <rafael.j.wysocki@intel.com>,
 Vidya Sagar <vidyas@nvidia.com>, kbusch@kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme/pci: default to simple suspend
Message-ID: <20220423054938.GA17945@lst.de>
References: <20220201165006.3074615-1-kbusch@kernel.org>
 <20220411135850.GA42637@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411135850.GA42637@thinkpad>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220422_224942_951514_A7CC512A 
X-CRM114-Status: GOOD (  16.57  )
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

On Mon, Apr 11, 2022 at 07:28:50PM +0530, Manivannan Sadhasivam wrote:
> PCI core only accepts the quirks for the host devices that could be passed onto
> the PCI device drivers like this one. In this case, this is not a quirk but
> actually an aggressive power saving feature (atleast on the Qcom platforms).
> Moreover, adding a flag to the PCI bus will make it applicable to all the
> child devices of the RC/bridge and that would be wrong.

As you correctly state it is not a device quirk.  It describes the
power management applied by the platform.  So we do need to communicate
it through the core PM and/or PCI code.  Please work with the relevant
maintainers.

> In our case, the same power saving feature is not applicable to all PCI devices
> like WLAN for an example.

This doesn't make sense.  Your plaform can't know what device is connected
to a given root port / slot.  So you might have different policies per
slot, but that has nothing to do with the Linux drivers for given devices.

