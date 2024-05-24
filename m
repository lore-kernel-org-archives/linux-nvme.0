Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20288C25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 24 May 2024 07:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=4EbM6jmR/GihcU+wp7MnQQy6Qh
	w+nnmty/a6qcqd9lxtkj3RQMZvRf9Ifi/j33NoyedPiwDyNcn/Lu98G75PikD38QBIt3exZM3k78D
	fKQLKFHRfUa7lbb8hKyacXdKpVBAsi+aLYdRSHJiWAZ443gagZl3jEslu3rdgs5EdI+AlHZlT5MxJ
	R4KtyrntkcZRy+z/ZAi4DBfHqUYARe76uXQKHk02e2VYPiP4tBxiIJDLutYJ3Iv5dt3tNwBN9dcFC
	m78byTuasMmiKU9qZ08TgtJyM3QQN2kYxEVdAwDxWC0YlGSuDqzu5HR3iSACDZJS4JkPdZVjo7wvb
	1535+Sjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAPXs-00000008Hrw-2B4e;
	Fri, 24 May 2024 07:40:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAPXq-00000008HrR-09tT
	for linux-nvme@lists.infradead.org;
	Fri, 24 May 2024 07:40:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4FA0468BEB; Fri, 24 May 2024 09:40:49 +0200 (CEST)
Date: Fri, 24 May 2024 09:40:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	joshi.k@samsung.com, anuj20.g@samsung.com, nj.shetty@samsung.com,
	c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
Message-ID: <20240524074048.GA17251@lst.de>
References: <CGME20240523113915epcas5p32626cec7fb138355e74415534a3ece36@epcas5p3.samsung.com> <20240523113149.29174-1-kundan.kumar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523113149.29174-1-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_004054_323606_74031D0F 
X-CRM114-Status: UNSURE (   7.96  )
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


