Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F791C5472F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 19:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b7iOhk/SFf+wk8StzTf5Y//H6GfRKSciVv063WZnyrI=; b=IvmqtNXaOCK++0MSl8aOCVlBiQ
	ALjn1h/IRIA9rtOB/qTYLqUcCZc1zS8WW594kon2h4hysazmtflE6uOwWChLiWAM3nHL8dLFIS4We
	6G7TTuf+QYMjZH8LOzEXr893boL07T/zUo8lBVkmS7AYUNk5cWQUck1nstKTEI9o2DlIjWSN6/qm1
	CTeZDoiQij9EfaASa0IGtsdayYA+w+QUepWom+FLtMD4CDiSi4XcJJeMGfognbeJpifNAWJb5kjgr
	Dn8csVnCynVS+ZAiZ/THJ0eIDnbfoiwMJE5rdACJ7eCY7HG2zE0TCEx2MhgUFMcYK4Ihl1g499Td5
	lRBcU85A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sj1cd-0000000Cbs1-1yFH;
	Tue, 27 Aug 2024 19:12:56 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sj1cB-0000000CbmB-0AEt
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 19:12:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 55B2CA42821;
	Tue, 27 Aug 2024 19:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29462C4AF1C;
	Tue, 27 Aug 2024 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724785596;
	bh=GjwL/TztTTTJZS7egkf+4b2C1QhowBjdFFPiIAq5wEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E77juzqsKJVRDrgt8clNMouCxiWITMIfP+9wjFM3yT/dqEQGqcKgPIP/gqaGSHZuQ
	 RLZW2R1EQZ3tRZ0VQRWsbo4fzwIkVCyZY8H3YlY5sAXTMfoIBf8FiUHcg0+sIbzuCi
	 EGcg+pGlAo1Ai9QwoLoJdutsQ68GXJ4TG+Z7B1VFnjXcg5515EsTe9nstEQ2NIE7qa
	 G5g6cPJzGd5IMhohQ/lDj0oYhaK74EV1eMHxcKtC3FOTjIF11LkLGBZk0N/ibsEMN1
	 YBSP8H5vNy3sce6RnOvYjAHxEgBwqiPJQcpKm6eLzCmz5SDgiyzGthunILJLIbhGAc
	 6NoawmWwD2K/A==
Date: Tue, 27 Aug 2024 13:06:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Georg Gottleuber <ggo@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-pci: Add sleep quirk for Samsung 990 Evo
Message-ID: <Zs4juYi-kkO9_NAy@kbusch-mbp.dhcp.thefacebook.com>
References: <20240827104134.11697-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827104134.11697-1-wse@tuxedocomputers.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_121227_201601_CC3641B2 
X-CRM114-Status: GOOD (  10.44  )
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

On Tue, Aug 27, 2024 at 12:41:33PM +0200, Werner Sembach wrote:
> From: Georg Gottleuber <ggo@tuxedocomputers.com>
> 
> On some TUXEDO platforms, a Samsung 990 Evo NVMe leads to a high
> power consumption in s2idle sleep (2-3 watts).
> 
> This patch applies 'Force No Simple Suspend' quirk to achieve a
> sleep with a lower power consumption, typically around 0.5 watts.

Thanks, queued up for nvme-6.11.

