Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6023C3DA59
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 04:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Upihx8gIQ6D1TCZImNPyh1OsJSi2ypwBCXDq4D1m+6I=; b=nkgJR11bkCQjLSRXNk8z3Wj2Eo
	ocCuSSmblhuupKDWL4A35aoZenOJn2eZSaOLeIPR2gKQSZxkWNWYsUhLQpdAurZR1eq4HTACCYKUR
	K8g1IgWqTHqS56Enla/TkfN7OYrbfwL8PnsJlXeOAjogQRBd+ThQFucOU9CdA4RgV62wL1HAmr25h
	DYCOeztELsQ547WYNwO4/Z+zmXPUv7nS0q8ZaT0CJ9GAL8MgkF+zy3SAsI6CMHu6iyRRge9f8toOw
	ynbGlFQZ6fZixjp5WybFYYuqoKyvsh8n/be/JReWjbHWT1zJiXsYsHTBg9pSPN9eGwVd0jB19ljnw
	kdCFxFXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTZpW-00000009Hr5-0i3l;
	Tue, 16 Jul 2024 04:30:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTZpT-00000009HqK-2n20
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 04:30:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 41B7F227A87; Tue, 16 Jul 2024 06:29:55 +0200 (CEST)
Date: Tue, 16 Jul 2024 06:29:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>, Lawrence Troup <ltroup@cisco.com>
Subject: Re: [PATCH V3] nvme-pci: allow unmanaged interrupts
Message-ID: <20240716042955.GA25427@lst.de>
References: <20240702104112.4123810-1-ming.lei@redhat.com> <ZpVINh3BA88U6KEc@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpVINh3BA88U6KEc@tpad>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240715_213019_866006_97B763C8 
X-CRM114-Status: GOOD (  13.88  )
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

On Mon, Jul 15, 2024 at 01:03:02PM -0300, Marcelo Tosatti wrote:
> What if you set "static bool managed_irqs" to false when isolcpus is being used?
> 
> For example:
> 
> if (housekeeping_enabled(HK_TYPE_MANAGED_IRQ))
> 	managed_irqs = false;
> 
> Then there is no additional parameter to tune (which addresses
> Christoph's concern).

No, it absolutely does not.  We need to still properly spread the irqs
using the proper managed irq setup, we just need to do it only on the
CPUs they should be spread on.

