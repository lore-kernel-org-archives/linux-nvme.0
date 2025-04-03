Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46030C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 04:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZoZb2AnVAG+2kZGr+5zQe6gwfOp8921DXSU6zhe69Fo=; b=cp0mPokLJTZ4c8rv0c6vwUDMgT
	O5gYZgTXnB+pxjNDoJ2GWzOnMaB8y8+/PT4Gn8Qr0TRJBNZUpn7a7LREHUVhM2GUHOODdgP6fkY1i
	RNt23yYK3ac34aoflcDGXTyxUPc1VxWbbg4RA6qOrTxxkTfNK2dWNICYBjzCvgFU5ZKS0IqO5off4
	gOQLe+dbjf0RJbStJYJ8ey3nQgzVxUhRry02iUrEeF5gQZR68opmFb3JvgbAHTOEHuGZ6dExsU4EG
	aUkEPDM9Hgqt7qlWHbF1dg3ONrFa3d1fMjneYcFTg5UwzP+oZ1bYa5uLuBgE9+y6fDJdPWoFEsJYT
	84rJ0dNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CLm-00000007lBl-3AHn;
	Thu, 03 Apr 2025 04:38:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CLk-00000007lBH-01kz
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 04:38:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 96B0368CFE; Thu,  3 Apr 2025 06:38:40 +0200 (CEST)
Date: Thu, 3 Apr 2025 06:38:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, wagi@kernel.org, hch@lst.de,
	dwagner@suse.de, Keith Busch <kbusch@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH] nvme-cli: attach ns to local controller if none
 specified
Message-ID: <20250403043840.GA22777@lst.de>
References: <20250331190843.2431830-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331190843.2431830-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_213844_184153_27CA1B83 
X-CRM114-Status: GOOD (  11.74  )
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

On Mon, Mar 31, 2025 at 12:08:43PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Assume the user meant to attach the namespace to the controller the
> command was sent to if the user didn't provide a controller id list.

This looks good, but I think it also needs a documentation update.


