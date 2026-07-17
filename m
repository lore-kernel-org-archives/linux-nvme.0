Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75B4C44512
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2026 01:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WgfjmeENtlavPS1Zuk5wOjnC1HjWapgUDVUzEMqlYMY=; b=RsmPeXy6ma+vOkNgqmb06LW4+D
	6qQRp8cR3Hw6mKBbxJ1axcpNZIOR6owjQZJOWgE5hXsGQT+9jIZRa72SoFbWe51Svo9jC+sYMTJAV
	clzirkvNXZ2sTHb47fDVjQ7PH8Q4MnYmB5giuBbd1qWDefVSeSSS7d1qH5qMxgfRNMKXj4MXHBp5w
	RDr2on6KzNLjidM/606sJw20vQdR6fAGpxFXOOQcnsTFYEeLbcad0fQ9svcdrnVmQX6yCzTEFSCQS
	OH/kJ9Hhdm7mc/YJot/4SkjtmKFbpEw1Bekwec2a1/FSBGgBQLNrL5Ex7HeBGf/iQg51m/y0p/i5h
	NdbdR2HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkXWQ-00000000uYW-22Zm;
	Fri, 17 Jul 2026 01:37:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkXWO-00000000uYI-2SVl
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jul 2026 01:37:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0A93640333;
	Fri, 17 Jul 2026 01:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9A51F000E9;
	Fri, 17 Jul 2026 01:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252267;
	bh=WgfjmeENtlavPS1Zuk5wOjnC1HjWapgUDVUzEMqlYMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bPd9HxeEawPKZsbr+E1Q3QIAcAqZd3Gl9vZG4z0wUX1vJZW3EoQQwawRqZsgFEaEQ
	 SPhTf1zFE9xQtLaQgu064E9dFuK2xdP0IJmQUk7UIKkX+bnn59PebnRTlWS7alzp/1
	 YpEI+wpanJH10DblU8rss0jZty0GaJEYuZzxiJOOeuqVsKvChItzoCv2rHLUbOo3nM
	 ihWizIc5op5EVnJTVf9ZKIoHlYG9vWSYr24W7CpsQ2estEtnowS3hRKx6YbVMJJu55
	 +ncHx2SMXB6UvCufvDIN75b+ux97a55hNouViH7UbFJJDExheHkhtcMBGhhw9QmhjU
	 Ar0Lei+4iEDuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	roger.pau@citrix.com,
	phil@raspberrypi.com,
	linux-nvme@lists.infradead.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH 6.18.y] nvme-pci: DMA unmap the correct regions in nvme_free_sgls
Date: Thu, 16 Jul 2026 21:37:28 -0400
Message-ID: <20260716232340.0001-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714201342.1347823-1-nb@tipi-net.de>
References: <20260714201342.1347823-1-nb@tipi-net.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Tue, Jul 14, 2026 at 10:13:42PM +0200, Nicolai Buchwitz wrote:
> The call to nvme_free_sgls() in nvme_unmap_data() has the sg_list and sge
> parameters swapped.  This wasn't noticed by the compiler because both share
> the same type.  On a Xen PV hardware domain, and possibly any other
> architectures that takes that path, this leads to corruption of the NVMe
> contents.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

