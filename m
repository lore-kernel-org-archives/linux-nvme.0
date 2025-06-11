Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0ECC61CE7
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 05:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TqH1G3PsmNi65f3HfVhGlovcP7bG2455s3shtI/NSD4=; b=OTqrqO+8++nrYTT9iExJ0/BGBR
	FWZusiRyzqCMmL2/6IVtO3h5NHFlBXUw6AVYpDDO8Wi0am7yQUk2D/GsTWJK9j2xIOS33x/JMCMxa
	rzbD3TNYAXgyV5J8Kjc9u+8i386HUFAw4re7Tuo5sB88kWjQys6K7SMnqbxzrN2Ytlknvlfqyd+wh
	fFzWINpYE7ojW16zTgWRRlz8LZwh+wJJqvkhUmdWUq+y9xvukbygVB1hmw7LWeq9SYS7ex9z1PrHX
	PMxkqGhO4swSF/13aZV/fmnVWqZyDGAFzbUP4wQ3xVY81aZyyJ7aU+pZPjMaZGuYAQdVBFPO7NYiJ
	+z5u8QFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPES0-00000008ucz-0Xcv;
	Wed, 11 Jun 2025 05:56:40 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPERy-00000008ucs-41X1;
	Wed, 11 Jun 2025 05:56:38 +0000
Date: Tue, 10 Jun 2025 22:56:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anj Duvnjak <avian@extremenerds.net>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme-pci: Mark Seagate FireCuda 530 as
 IGNORE_DEV_SUBNQN
Message-ID: <aEkalhc7EjI6Y3oY@infradead.org>
References: <20250611040635.3615-1-avian@extremenerds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611040635.3615-1-avian@extremenerds.net>
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

On Wed, Jun 11, 2025 at 02:06:35PM +1000, Anj Duvnjak wrote:
> The Seagate FireCuda 530 (PCI ID 1bb1:5018) with firmware versions
> SU6SM003 and SU6SM005 reports an invalid SUBNQN field, causing kernel
> message:
> nvme nvme0: missing or invalid SUBNQN field.
> 
> Add the NVME_QUIRK_IGNORE_DEV_SUBNQN to work around this firmware issue.
> 
> Tested with both SU6SM003 and SU6SM005 firmware versions.

The quirk is only for devices with duplicate NQNs that are
actively dangerous, not to surpress a warning about a broken device.


