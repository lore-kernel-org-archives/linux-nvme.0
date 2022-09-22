Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E860AC6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=FLsWHcAvO39bYutIPLKOG/o/Ai
	SNcu4TO9PwIIJ9wzjqaCTRGblgJaq5YpAVcgQrjyEpg7rMxtffDjQYL1TP7InHJzXb8eyQza2iwGq
	8Q5x4QtQF2JDPpNPeyVUoMnC2sTg54JNr68osKmuHWXO7r1xoqK4ps2oWALCnFFHPq8sPKAdJKrha
	y6oLYd+2kXGPjJ085AHcQiuqIb3xLRo5wrLOLUYc89mcuPOd0dj32rmRPu/DbH6d0fYv9dH2vWnF7
	ZXIXBygnre2Nq1jO4iRL6xrn1DV5is6bsKXJ110x7tH8La3L4BgbgqvOvgtbFyBsGIPTAf2h311fy
	dRe4SXYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obN8y-00Fzxg-9U; Thu, 22 Sep 2022 14:25:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obN8v-00Fzvb-I6
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 14:25:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5A02868AFE; Thu, 22 Sep 2022 16:25:29 +0200 (CEST)
Date: Thu, 22 Sep 2022 16:25:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: remove nvmet_tcp_finish_cmd
Message-ID: <20220922142528.GA28397@lst.de>
References: <20220922070616.41918-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922070616.41918-1-pizhenwei@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_072533_763204_87D20E44 
X-CRM114-Status: UNSURE (   8.28  )
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

applied to nvme-6.1.

