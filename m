Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F294CC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Dec 2022 08:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lsy9K5NFAda7MQAC4/uMyCagRtBadcZcXPFHN+mvW3U=; b=HCoPmoqMIxYSkEi4vmKpQg6YiU
	oezZJ5+eNCaBJldsYrtpUgEAyn7KCee44sl9LrvYjiSFXX5JRU7WFXyYBRDl8fobDUfT4dO0LG6PL
	uE4GMBuWz16UupzoTu5wx4PUbMEODCV/n4Y++g1Ux1n85TzUuOCdBxfcx2bcER+1e11brzIjAsld7
	gScUnEkBggxzO9Siot+SrVVhNm1/qbHmMLv0h7vcgoxJfCsA3hPU1bFZukjJGwWoRMiHE3y9+yUbZ
	TySj3XO+6pfFKg/Lm8sFNGu7r7MQ/iRdLmro26SReqnriZTduofDlOBDV0Y4pCMyC7m3cYX5gmSHM
	gHZUarXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7u7x-00Bx1c-HA; Wed, 21 Dec 2022 08:07:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7u5o-00BvXV-Vt
	for linux-nvme@lists.infradead.org; Wed, 21 Dec 2022 08:04:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F9DC67373; Wed, 21 Dec 2022 09:04:45 +0100 (CET)
Date: Wed, 21 Dec 2022 09:04:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nvme-pci: Fix mempool alloc size
Message-ID: <20221221080444.GA23327@lst.de>
References: <20221219185906.3595984-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219185906.3595984-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_000449_219098_6B10EA34 
X-CRM114-Status: UNSURE (   7.71  )
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

Thanks,

applied to nvme-6.2.

