Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D9ED0BB5E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 05:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GjoPpbqFDLUA7JjEzJnRfvb7cmnBiRZLA9IBHn4k+9M=; b=DO6K/KRQ0LJsCqOvtm3YyIMC77
	+sNbxk5UZpV4unolOTJ4SHn0UmY7iseOXTRptyCyeSPALwpI+YSLWXbAkGlnDqBVuIcvmHEN/rFb6
	EJtM2W+Nlbv3DfuHqnv7vWoNtCm9duW2ShBaIuSsns/jNwNbFF/o6uNzHjk6W33VVawatvMnjpQYu
	tUafsT9rC2Cz6VF91mV8XwGJdr5JXn5pz7M7/Vnv8JBg6kleHZbnRIZ1lsBkZWOCrkBarhrXUUAQ/
	mLJSrcrfJ76WL1terpQedJeCGqVXY2YncXWBJmuPDEUllyFTZ0meagjkVdrC0B0F2DkZwoRML3snr
	TAbMQzXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3pzj-0000000Gl6Y-0Eox;
	Thu, 24 Oct 2024 05:02:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3pzg-0000000Gl69-0egM
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 05:02:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EEA6E227A87; Thu, 24 Oct 2024 07:02:39 +0200 (CEST)
Date: Thu, 24 Oct 2024 07:02:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, martin.petersen@oracle.com,
	joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH] nvme: module parameter to disable pi checks
Message-ID: <20241024050239.GA30705@lst.de>
References: <20241023155048.634988-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023155048.634988-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_220244_356138_248558E3 
X-CRM114-Status: GOOD (  14.25  )
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

On Wed, Oct 23, 2024 at 08:50:48AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A recent commit enables integrity checks for formats the previous kernel
> versions registered with the "nop" integrity profile. This means
> namespaces using that format become unreadable when upgrading the kernel
> past that commit.
> 
> Introduce a module parameter to restore the "nop" integrity profile so
> that storage can be readable once again. This could be a boot device, so
> the setting needs to happen at module load time.

Not exactly a fan of module option, especially with such broad scope.
This will actually disable PI entirely as far as I can tell and not just
for the PI at the end of metadata formats.

Can we at least restrict it to those formats?  And maybe add a few
comments in the code why we have all this.


