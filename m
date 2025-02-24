Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA57C021B8
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 22:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tR/8QDy4eX6c6aTcnWlffQlhHpBfASZZt0gyxxIR2tg=; b=kYG7v8M5wndKWKun/S6G4uFLLL
	gAwGOQSiiUpySRtY+v8sDbh8WVjqF34WcqswCWpcbJm6pic7reQrBZUe22L69gncgushqW2/bHfVW
	A3MRD28NzmJmFdMLfApqLRVcnwdmVDTIKPBvb6w3YbrNIFWYlXfvpjpF5cs6hzmDe23zrzpUWNC41
	X6fMOVgZU6XuDooPYJbQ2BFZcTYU2cuw5re0dNeQinrMJBVUYytLEMqfDn7OnZpq3GZY3VyLUwMAw
	A9xjfO6mOhEf+OCzf61S7QIvzZjemvQz8oGV7H3K6XLVMoZuwl27nV45zzss+9XCi0pcuOrapE4Vz
	sDVihB9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmh1d-0000000FODO-27M1;
	Mon, 24 Feb 2025 22:34:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmh1b-0000000FOD1-3q9D
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 22:34:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E590268C4E; Mon, 24 Feb 2025 23:34:03 +0100 (CET)
Date: Mon, 24 Feb 2025 23:34:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/6] nvme-ioctl: fold 'vec' into flags
Message-ID: <20250224223403.GB15518@lst.de>
References: <20250224182128.2042061-1-kbusch@meta.com> <20250224182128.2042061-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224182128.2042061-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_143408_097383_8E98FECA 
X-CRM114-Status: GOOD (  11.26  )
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

On Mon, Feb 24, 2025 at 10:21:25AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The vec indicator is already a flag and used as such, so use that type
> instead of implicitly relying on a bool to happen to align to the enum
> value.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


