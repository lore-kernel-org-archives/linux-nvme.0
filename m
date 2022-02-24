Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B2DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 19:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VDs/ubAyB01Bk9H5AnuMOTc54FSGl71vk6BJ6hTW0pU=; b=pS4tPYs/gwsyiDidtEPrhiOoFh
	AinuLR4fNelgekS2OHWaD/7PoXp7MoKzBcqyDaj3C+zRhwGb4iyrKge/RMFeoiDkyjMTuDZbKYnDz
	BHgCpSd2jUUIjMYorsLO9J4T01Bynafn+9o3jrVM6Ldq42JBEB9HXOTBzijzJlRojzllNPJjoSdkS
	xc0b3ReE8yQHEKMFN4FQUUIEkdIpuGMznZd96rBwp0w7jGHlTz4iYhwyTilcV05A7mYyAw51qRa3U
	iBoOcdEKy2djT8QAjWomN/bjB3p9znCrtM0C1wWHifHBMjHf6KHveAXil8Qnx6hPSiDgE7ycsZ7eH
	1B/v3S4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNJwM-002AeT-9n; Thu, 24 Feb 2022 19:38:14 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNJwJ-002Ae7-6N
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 19:38:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DC5D5B828F9;
 Thu, 24 Feb 2022 19:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A380C340E9;
 Thu, 24 Feb 2022 19:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645731488;
 bh=VDs/ubAyB01Bk9H5AnuMOTc54FSGl71vk6BJ6hTW0pU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NXI5wZ3YhVFeWZ6yYVHg3xAR97W/WMliXAuLgw8LAo/M1GdDhGlDmCyUOrto6Y+eX
 N/ISVLwfKSKKDgRMO0XHvdunTECpM5ufIm7xQG7mMp3i97CeXgLtPv/4M/mGUB5ZyR
 A8fhwlAm8WenREcKkcZj/OKEaurqOPrErrNZH+ubplK96HlrXuEuaoprO3LHVM9aVa
 +TpGZrtlBrVTg3yYN87r7ELcfGYav3ZXiAFqtX/sTkgRWWz3jm0l357bLMBkA7HW4t
 TEWSfoc7R4Kh56NYAdJi4iezKclCExYCoGEIeBG3fzPmhRBBCWdQNe6MYv41ylJX24
 TzcpL+WSxiRDw==
Date: Thu, 24 Feb 2022 11:38:06 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: properly validate the nvme uniqueue identifiers are unique v2
Message-ID: <20220224193806.GB3257446@dhcp-10-100-145-180.wdc.com>
References: <20220224192845.1097602-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224192845.1097602-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_113811_403594_DF6AC9A6 
X-CRM114-Status: UNSURE (   7.03  )
X-CRM114-Notice: Please train this message.
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

Series looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

