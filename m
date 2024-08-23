Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABE7C52D7C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 06:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w83ngNZHWBS33ZM48flovSqy+kqPXkPAmtd9pWv5dCM=; b=WGvQXjn9GJPM2dycQROWXtQN8I
	JVaA0ybX/LsWrPIOirydSBuiRcxgqe44j6y/0vUiOqL719IgBmZXd7UaejXJm1HWkt0XB5pGqSU+z
	UXrhTtLWzdMI+cPOC8bWP5w8y0YNDV+MxTgYOiK1QVI1jFpabhMUVRVaqV2ABNw7ZcDomiaDlBWvp
	gv731g9riIYcUYp3yCDsB9okcQ1cdaH+dt4v1Uy7f5n6aD5U+JsdcxdKpZ1phpSPO717jC59qqoN4
	NkpN+xN5lLSe+n5q22SX1R7l9qfDyB0HiZhiLAEYMgql4C8BPqR4qPeyLbWBJJc8J9Npe+mHRrLRh
	ilpmzqvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shNm1-0000000FSFu-49SV;
	Fri, 23 Aug 2024 06:27:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shNlz-0000000FSDF-0F7M
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 06:27:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 77176227A88; Fri, 23 Aug 2024 08:27:44 +0200 (CEST)
Date: Fri, 23 Aug 2024 08:27:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: use better description for async reset reason
Message-ID: <20240823062744.GA31687@lst.de>
References: <20240822152259.3896264-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822152259.3896264-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_232747_260844_E64B6723 
X-CRM114-Status: GOOD (  11.99  )
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

On Thu, Aug 22, 2024 at 08:22:59AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The NVMe AER notification of a persistent internal error triggers a
> reset. The existing warning message just says "due to AER", which can be
> confused with the unlreated PCIe AER condition. Just say what the event
> was instead of the generic overloaded acronym.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


