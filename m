Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7949DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=35qYBJJFXI1O82VtneL65u9pQiUrJIpEEZQj2Qmuhl8=; b=KEufNAmeEdAyn6JzAaVPMdAPNC
	SwwtlY3jOJ2RSy56x2pN663Xi40pjDLhHpi/Dp9jU6Z61j5u6HhB7SuVWqfyhulEmkTly5+b/JSvI
	9qOL8eaYsAYGihSJzXBEagj4fD7/zd4oESIJX4sEH9HsgVeyRJ4mPDI2Cctf/SUUmpgeP5nlUWwEq
	0NZdCeV0iKCrLwzRkIWmsO0PM6oETx1ycI7cjzDbyXcA92cJjjoRpa2F47EwD0rk4L/hFsF24Wiou
	DkoSgSAZw5s/ytkwu5q8IJaope9hAE8LHXgbY7qZhkQuuzLHjNZrMq6/7ZzyezEtyp3nPAr2+UBaG
	fSPJWIXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU1Vv-0085Ja-Op; Tue, 15 Mar 2022 07:22:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU1Vt-0085Id-BA
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 07:22:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A15DB68AFE; Tue, 15 Mar 2022 08:22:33 +0100 (CET)
Date: Tue, 15 Mar 2022 08:22:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 Patrick Huang <patrick.huang@amd.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Disable LTR for simple suspend
Message-ID: <20220315072233.GA2288@lst.de>
References: <20220314135537.1565-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314135537.1565-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_002237_561239_DDAB8345 
X-CRM114-Status: GOOD (  21.61  )
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

On Mon, Mar 14, 2022 at 08:55:37AM -0500, Mario Limonciello wrote:
> Some drives from SSSTC are showing stability problems after s0i3
> entry when the Linux kernel is in s2idle loop if LTR has been
> enabled. This leads to failures to resume.
> 
> This appears to be a firmware issue specific to SSSTC SSDs, but to
> avoid this class of problem, disable LTR when going into s2idle and
> simple suspend has been set.

This seems like a giant hammer to do this for all NVMe devices,
why not quirk the specific ones?

> +static void nvme_suspend_ltr(struct device *dev, bool disable)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct nvme_dev *ndev = pci_get_drvdata(pdev);
> +
> +	if (disable) {
> +		u16 word;
> +
> +		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &word);
> +		ndev->restore_ltr = word & PCI_EXP_DEVCTL2_LTR_EN;
> +		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
> +					   PCI_EXP_DEVCTL2_LTR_EN);
> +	} else if (ndev->restore_ltr) {
> +		pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
> +					 PCI_EXP_DEVCTL2_LTR_EN);
> +	}
> +}

The calling conventions of this function are rather strange by
mixing up two very different things.

I think two PCI-level helpers to disable LTR and return the status
it ways in and to enable LTR would be really nice to have here.

>  	if (ndev->last_ps == U32_MAX ||
>  	    nvme_set_power_state(ctrl, ndev->last_ps) != 0)
>  		goto reset;
> @@ -3239,6 +3259,11 @@ static int nvme_suspend(struct device *dev)
>  
>  	ndev->last_ps = U32_MAX;
>  
> +	/* If using s2idle with simple suspend, disable LTR to avoid problems. */

Overly long line here.

