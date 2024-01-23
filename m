Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB25C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 09:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=841amre14GlZpdMkM4XOSwcDHkkrj0XnVPCr254zIMw=; b=Vthx97uRFOcHl6yYtrFF2xJJOz
	1plPRf2sSr+/3PMIAN2bRiGBogKiSnSl4M3hVfb+y45BXtAGdYvugAI5FVfnrlhE+5pLuAqiNp9uR
	pOT1tGfaWCAXhecShCEzF5h5HPE7n3uFJQZ+icSoNwxKWFpBzxPwI2SZkBPv+kHhcUA6yDk5QlEZO
	0JZ9lHGz3M1NOiZm+qX2uWWsDiwtesSx3El8RGdN0LWJG6JifnRKYe6td0f1VnpvyO5TH3HNqGpMF
	aokKss/b/S3UFzS3BrRhC/kSypyZa45YbNm9WpieRiAzSk+PEW84BwXVDrLhAvyh3FEbtdO9x/mWJ
	M5Sc+0wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCgP-00FgSu-0l;
	Tue, 23 Jan 2024 09:03:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCgM-00FgRl-08
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 09:02:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6F0C268BEB; Tue, 23 Jan 2024 10:02:55 +0100 (CET)
Date: Tue, 23 Jan 2024 10:02:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, oren@nvidia.com, israelr@nvidia.com,
	dwagner@suse.de, oevron@nvidia.com
Subject: Re: [PATCH 6/8] nvme-rdma: Fix transfer length when
 write_generate/read_verify are 0
Message-ID: <20240123090255.GE30773@lst.de>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com> <20240122145659.5574-7-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122145659.5574-7-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_010258_228752_DDD4F2E9 
X-CRM114-Status: UNSURE (   7.87  )
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

Please send this separately for Linux 6.8-rc.

