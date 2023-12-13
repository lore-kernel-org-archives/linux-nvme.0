Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A299C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 08:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HP/du6hzd6Fxp4fY2+/ytM7qva
	P7OW7mf2SevsjGtmvMbX6jux8d5+qB2Zr6/HaDN7ygrLo5DEIeSUlPutcuPUFpfa/5Y8lwRP28N3+
	+PF6JMbBttVg2GZiVQhrNZIr/ZZ6oKa4sgjpexJQ3bhbeiRLXjzF+1IOFBamE54iyg/AgHBmFkqI2
	aGA+XuEvDXAU/yhn0/wLVXz+jDzSLXQH9ZuRfwqyvFLkeXjHNUFPlFi91QJZactQZd9BxFotUnz4z
	7eCWOlc4dQAz65hc8CBnARqM5i03sXOiSwh8ThPx5JH1mJ28J/5lnVdUFj/H6AriYRs3CvODpLEBw
	Bk+Ai5Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDKqC-00E46K-1l;
	Wed, 13 Dec 2023 08:43:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDKqA-00E44n-05
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 08:43:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6967C68C4E; Wed, 13 Dec 2023 09:43:35 +0100 (CET)
Date: Wed, 13 Dec 2023 09:43:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] nvmet: allow identical cntlid_min and cntlid_max
 settings
Message-ID: <20231213084335.GC6184@lst.de>
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com> <1702449172-8920-3-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702449172-8920-3-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_004338_211245_B110B127 
X-CRM114-Status: UNSURE (   8.14  )
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

