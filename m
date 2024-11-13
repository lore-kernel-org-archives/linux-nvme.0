Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D858ED41C00
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 04:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zHwuiE9hlIVPwXtLVSsTiWYSY792mOHFj61UxWQEacs=; b=cpOG6DnzWPmz2w+4tbqIwmG6vX
	Gz+oCVO5glWE1xECMl3GzdguFZfBHz4bIl1SU8RiLPf541RbTVXCf1Kho33slKtHueqw0uqMYKzHu
	Lg1SNowh6QF2aK/G9xQX2vTcYjv4N2vhq3gTuI2/ugWUZ2MIbseYhzXjxQeT8mku+sgtppq6H7GLV
	VQRgls+rKXrGtN94Y24BOWiX4lfj3z9sgxIFB9P23tYBfphYoeW1IZer37f2Y9RDS0vX9BpfThag5
	5wVlklxnlWFKr+mfXJulnqRL6X8nPnqUaq4fVm1Z7X8jhvXd19RFpVRr6cUeMF+ONDTdE5m5J5DLN
	qoDUR8wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tB5T7-00000005li8-0lfI;
	Wed, 13 Nov 2024 04:59:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tB5T4-00000005lhd-3MNq
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 04:59:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7858B68AFE; Wed, 13 Nov 2024 05:58:59 +0100 (CET)
Date: Wed, 13 Nov 2024 05:58:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] nvme-pci: use sgls for all user requests if
 possible
Message-ID: <20241113045859.GC20379@lst.de>
References: <20241112210620.2650523-1-kbusch@meta.com> <20241112210620.2650523-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112210620.2650523-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_205903_053819_26E0A8B3 
X-CRM114-Status: GOOD (  13.00  )
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

On Tue, Nov 12, 2024 at 01:06:20PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> If the device supports SGLs, use these for all user requests. This
> format encodes the expected transfer length so it can catch short buffer
> errors in a user command, whether it occurred accidently or maliciously.
> 
> For controllers that support SGL data mode, this is a viable mitigation
> to CVE-2023-6238.

The patch itself looks fine, but instead of the handwaivy mitigation,
maybe just disable passthrough without SGL support by default to actually
fix and not just mitigate the CVE?


