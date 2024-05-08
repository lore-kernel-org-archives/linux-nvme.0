Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA86C19F4F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 11:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XLX7xUN0STtbaswLUVy039LSW+Xs+KrNDznhT2Gm/LE=; b=o/WpyhqwL9+tE410JhVzur1gZP
	JPhkx8/XRqZoKISToOAIM8G8RTCXbc9nsLLwpSHHa+XYE2xAR6g58+OPWLVE2n+K054P+KW9kXxhf
	Sr5vcR1NLx1liT912bxoGlCf2vUTZbxEN6JGUO2cAQDSkdCy2xQfjEqfm2hZeTt9SNZ/6rNzhUeYu
	sgesMzzQgDWQ4Ki1gwddpSq81HPp89wrkpP+9Yn/HMi36PdS4VdWyQSlRnMZhzdnOy+1qJXkX0YwR
	pZvNeUdiwSkZfvWdgyv1mHPPzTYDLm8YRMAlu/2LtB85lCsHOYO0Ny6lWNxZEwjxWKKIAxkaRbIXY
	iCu9epDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4fZH-0000000FFax-0MR0;
	Wed, 08 May 2024 11:34:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4fZE-0000000FFZe-20ta
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 11:34:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B4EF168AFE; Wed,  8 May 2024 13:34:33 +0200 (CEST)
Date: Wed, 8 May 2024 13:34:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v2] nvmet-rdma: fix possible bad dereference when
 freeing rsps
Message-ID: <20240508113433.GC31529@lst.de>
References: <20240508075306.1835106-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508075306.1835106-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_043436_739777_BDF20161 
X-CRM114-Status: UNSURE (   9.61  )
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

Still looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

