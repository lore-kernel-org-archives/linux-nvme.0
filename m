Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F19CFC503
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 08:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h7IGRtJfycGT9P6xXljK3Dfql1ayiZ3cDjceMrZeXh4=; b=sUbJ1W3Ne05T02hioB7VYGp+up
	8rMMrSTAljxD+UQEEtp6ZNomJ2tojdi/8h0vxClOnRDyAQL1bD3TZlpiIoXKskiTMiuXYD90luye0
	6UQ5sKYtqjsRExd3BDe0fA9eyMm7HwgD0ZX8TLr3amEH8xYRGYdn5RSYVV+rL6p43J/wZHE2RXFDI
	78E4rhOxjtQEfY5R1ODcE3TApShiSSgwukzQQ6ylkuxywq0eoUneBWf8mEVolVbgkrBjdgf8b4Wer
	PpbS3gQBViT4k3RZIF4ZwO2FYHhZprTedGl1DoWPKiy3H+1vjfZ3uOhQ3NhPQ417VzaW/WzD7Ja13
	e1jWYAHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Gpw-00000004N3V-0jqi;
	Mon, 14 Oct 2024 08:53:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0GfN-00000004KIT-1qqI
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 08:43:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C1A6E227AAC; Mon, 14 Oct 2024 10:42:58 +0200 (CEST)
Date: Mon, 14 Oct 2024 10:42:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 3/5] nvmef: Introduce the NVME_OPT_HIDDEN_NS option
Message-ID: <20241014084258.GB23780@lst.de>
References: <20241011121951.90019-1-dlemoal@kernel.org> <20241011121951.90019-4-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011121951.90019-4-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_014301_648234_34E4A68D 
X-CRM114-Status: GOOD (  14.45  )
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

On Fri, Oct 11, 2024 at 09:19:49PM +0900, Damien Le Moal wrote:
> Introduce the NVME fabrics option NVME_OPT_HIDDEN_NS to allow a host
> controller to be created without any user visible or internally usable
> namespace devices. That is, if set, this option will result in the
> controller having no character device and no block device for any of its
> namespaces.
> 
> This option should be used only when the nvme controller will be
> managed using passthrough commands using the controller character
> device, either by the user or by another device driver.

That doesn't make any sense whatsover.  Why would you create a
passthrough controller to support PCIe?


