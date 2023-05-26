Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240D3C77B7A
	for <linux-nvme@archiver.kernel.org>; Fri, 26 May 2023 09:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Sr/gOOVCPXuR/T9hrp+akC2xS9
	0y3kr4sIjUPci3L9ZeGLmxpgJY5BfMV4e/nvVudSQsWM3R3YRqbeuYIFNElRccQITeBIz+xF5nikC
	WURyK2icD/zsl7lzLrcwEkCTy1aa6YJCsrklXU4Ew9UqMxsAvg91QdXgydPcKPf/nVo4sUu2ivjsZ
	74PQ9DfQceRqcDzAfPLIbHypbm7+OBrWMjbl/gnTqGl7eEIntphl6caTc40ynZkNliZLvT4FOYooP
	xjwaazCKSmxB7FYFFYOBWQsZO28Iys/Jw7YR8FHGR/jQfi270c0Tt26Y2JUTq9XbJ33tgCG6WTyrC
	4iRgV1Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Tea-001mCr-1G;
	Fri, 26 May 2023 09:22:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2TeY-001mAp-0j
	for linux-nvme@lists.infradead.org;
	Fri, 26 May 2023 09:22:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EF00068D09; Fri, 26 May 2023 11:22:16 +0200 (CEST)
Date: Fri, 26 May 2023 11:22:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: "min15.li" <min15.li@samsung.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: fix miss command type check
Message-ID: <20230526092216.GA22450@lst.de>
References: <CGME20230526090834epcas5p197a90228102b26759f9b957c50d3bb6b@epcas5p1.samsung.com> <20230526170656.55303-1-min15.li@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526170656.55303-1-min15.li@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230526_022230_429258_A6F78AC7 
X-CRM114-Status: UNSURE (   8.71  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

