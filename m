Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623B2C77B7C
	for <linux-nvme@archiver.kernel.org>; Fri, 12 May 2023 21:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IkTIfnCuUdfzkCQIu83TZMurI22TqEIsThsv/B2BQHU=; b=NazD/Vvg/6vtwWvKklEo3vieu9
	G6Mj1lHJC2AZI+3Px3UxgCLM0irFaQfdTK2emXbs33kt/0Hs2XkK1IXk1BLuHENwKp/MxTuSWHAW+
	ZfvQRYd61YnpgWxH/DxhdnqhLt0qbJZUEBGjJW91UmLf5PzjsBbnxzZoE3RmCtDMjf+3oDvHz5JZI
	3VPHNxoUkMcVJl0YB9OzOxkdt4wy9BXE8kXE6tPTGszzpKljAd2LE6aLFWLEO2D4k7ozatlDddIlg
	rG2W6VrDu2AIcvHH4Mhv+q2S1/iVruMD8rjjd5W2v7jqAiZJ0V4zHqfGgNMG2AqZy81DV4ROH/dRf
	WLcI42/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxaMG-00D5WK-14;
	Fri, 12 May 2023 21:31:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxZOK-00Ct9S-2F
	for linux-nvme@lists.infradead.org;
	Fri, 12 May 2023 20:29:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD9DB68AFE; Fri, 12 May 2023 22:29:24 +0200 (CEST)
Date: Fri, 12 May 2023 22:29:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH V2 0/4] nvme: init ctrl memleak and debugfs fix
Message-ID: <20230512202924.GA21662@lst.de>
References: <20230428073115.22987-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428073115.22987-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_132928_876743_7BE1EE0B 
X-CRM114-Status: UNSURE (   7.45  )
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

The whole series looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

