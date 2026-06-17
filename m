Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A3CCD98F2
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2026 18:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Qrc59+zIokh8fs0JKNG4MO+Rw0dpQBwmRZDN3GGNVk=; b=xuLDbzwEQR3CI8Lh9g0wfI3p5s
	mFsPTxzDOLFyhyVxcE9uvuvsTr/MthzMgPngS6DkCikySSShtfd8ibJkUg3SOUHtfWa3X7Cf1ewUc
	aiI2QQiyLQ/rS70PSoXHRebwVPZktIAh6urZgHGsKZGMEgzgo23toQkt0CVhkOy+6nGlCYcKJe161
	V50P8+3KkFbIYuikF0hZhfXMIIbT1XRokTXt343ZSUI2yisCx/Gu++/cEI8zRFwRYtw9ovGqCN7fO
	KkkGvcvT5dK79aZYlWCN9Njcbu8X8gMDIfgQtGSr7jVrW/P5j3uUv62d45puviNLWn4Astt9HLRs5
	5kr0wMJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvFg-00000000Bdu-3aTc;
	Wed, 17 Jun 2026 18:44:40 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvFf-00000000Bdo-3LSJ
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jun 2026 18:44:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F39336001D;
	Wed, 17 Jun 2026 18:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA711F000E9;
	Wed, 17 Jun 2026 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781721878;
	bh=4Qrc59+zIokh8fs0JKNG4MO+Rw0dpQBwmRZDN3GGNVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ByEkJuuE9nbyaIp/AQKOc7BgltZ37Y5pU5hWDI+iYV9uecqDARXLR8QnGxnoxHXpA
	 ECwi2Abi8sAtbXOMDmnQIPj7Ec8bAsFsz6UCVVIi23EiSkWjXv7Z3w7D4tHNQACcy9
	 LfLcaJ/EpDqnWTuIvIY8lfAzxfNtQAnn3sIphFQnhslUDfuKRi3coIZQE/kYSOce3G
	 R5f/fZyDbIojYvxRQJ/497rmdKN1tay/TDgvkzwSh1Mcu4TFI+dVU54Sh7ZYXedpPb
	 kYV2U7MGaIaXx2imIC6lWekOXUFrqUWVcj4N9frjZKXbSEJ0P1lDz0vmGLCiSuqGZo
	 zitDiw87+blag==
Date: Wed, 17 Jun 2026 12:44:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kangfenglong <kangfenglong@huawei.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Wangyu (Eric)" <seven.wangyu@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	duziming <duziming2@huawei.com>
Subject: Re: [BUG] nvme/pci: nvme_map_cmb triggers WARN_ON in __add_pages
 when CMBSZ.SZ is zero
Message-ID: <ajLrFQnair8i978C@kbusch-mbp>
References: <ee28ccf4e3a6479e8851b7b196219244@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee28ccf4e3a6479e8851b7b196219244@huawei.com>
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

On Wed, Jun 17, 2026 at 07:01:32AM +0000, Kangfenglong wrote:
> Proposed fix:
> In nvme_map_cmb(), add an early return after the existing dev->cmbsz check:
> if (!dev->cmbsz)
>     return;
> + if (!nvme_cmb_size(dev))
> +    return;

Looks fine to me. Do you want to send a proper patch for it?

