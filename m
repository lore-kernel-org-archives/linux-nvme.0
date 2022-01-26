Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEDBC2BA4C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ir9jfaZn9LTRp+fRomEeuPRMmtw6Xz6xKx9XEJdoYMs=; b=GgJsSS9FqR/PaeoanIlHhLVPnx
	Sbx4TTUHr/4uCi7AHneAd6zEvqRXT3BpSdTiRP/Zd4ODp1WRaNUsPZRRBjWgle21nD/JSqGMO4C+I
	JlB5xA8TTUzpQncAfkZ6Ybe9UwArTTr+2s8rLEsWN8z2U3VDhkalhbIIaJDUxmAlwZULazbwsRK62
	cPMTSCQulZ0E3cwbzmolb93igVjOM3nYrQpigF/ZOH7+GILVCaBbjD2R7UMu4CqFTOIvrdSSI6oJ6
	KSAg3KDNMqZIAmf1L6gZ+E1ItawLky1JP0vshG3K4aUHPk7rlqmxmBGN11JGMjMuql44KKEAy/6Ss
	NvCMI/Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nClpw-00CuOt-0n; Wed, 26 Jan 2022 17:12:00 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nCkwC-00CYzy-K2; Wed, 26 Jan 2022 16:14:24 +0000
Date: Wed, 26 Jan 2022 08:14:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zheng Wu <wu.zheng@intel.com>
Cc: linux-nvme@lists.infradead.org, Ye Jinhe <jinhe.ye@intel.com>
Subject: Re: [PATCH] nvme: fix possible initialization failure for
 P4500/P4600 SSDs
Message-ID: <YfFzYDaZr5bs6kf+@infradead.org>
References: <1624316821-21154-1-git-send-email-wu.zheng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624316821-21154-1-git-send-email-wu.zheng@intel.com>
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

Thanks,

applied to nvme-5.17 after fixing up the commit message.

