Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2C4C54791
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 20:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fwqwC6lQpTY+StUOg9Xuxy29TyQp8jUi2kzw1bcufrY=; b=JK14GiTXJbxFp5APssuKmF0tEb
	IXpErhQ9OTYeHTvkKN1reD8P1mMSkCUvCWEndD7+TgDhNcm+YEM6t7sVrUdZ8fLoPdxAG8PTYrbz+
	Egl8xpkubxIAG9sXa+vKEDOXPubK0/ECe1fKy0TkEyDty2cWj8Uvr5WQbYC89cZIKwpwrV19R0zmz
	9liqcqK+7wREux0g5BwYSmxpNieWnxdDsaN8fbkbcSTdwqMDxBFUWd2H0sV1rK6lTGHymMvjTJkeR
	8PoZAKR/E8QlgNeBB3zpdAUQj+I4KCht+YgaOehmLJBMSlgMwuJjVDl2CxVup8oXXzZi0pOO+On9e
	TqfC3eFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkUrz-0000000Bkq5-37S1;
	Wed, 13 Mar 2024 20:06:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkUrw-0000000Bknz-1y7P
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 20:06:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 69DE568C7B; Wed, 13 Mar 2024 21:06:22 +0100 (CET)
Date: Wed, 13 Mar 2024 21:06:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] block: move discard checks into the ioctl handler
Message-ID: <20240313200621.GA5756@lst.de>
References: <20240312144532.1044427-1-hch@lst.de> <20240312144532.1044427-2-hch@lst.de> <ZfHI5Vr7BOU6__rv@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfHI5Vr7BOU6__rv@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_130632_671196_5D736B88 
X-CRM114-Status: GOOD (  12.62  )
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

On Wed, Mar 13, 2024 at 09:40:21AM -0600, Keith Busch wrote:
> The incremental change I think you want atop this patch to keep the
> previous behavior:

Ah, yes, thanks.  Can you submit your reproducer to blktests or at
least throw a license on it that allows me to wire it up?

Also I'm going to wait for more comments on the approach in this
series before resending it, but we really should get a fix in in
the next days for this regression.


