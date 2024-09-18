Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F24CCD1A3
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2024 12:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y8l77HC5aQNeagB99jXcOQk0S0DSiw3leOEq+3hMW+M=; b=JzCYCKrRkRiZ70TzBmzfcyz+Ha
	rohLoRlZNCGWF6/HXeFgwyKQ3ro1IhiXIzdZF73CDRoJaH5LdGyhtsaB135zCxQ05pF2+B61TXV1I
	si1StomZgtLdOARuEtQ7qgXLEAr1v9vVJHinYpvhYiHw1x0nulrFwz3zRGVxQiCw9bDUcDy36ITa8
	JDTMekBHJA6zqPvlvoWvL9uqyrUoPhxO0OKgBvAdFRSuIu+U9mdBlMh6vSPlLG/nKZcLGhCjWMrsH
	ZqqjtyuGf+qrv1oZ9m+YrJm830cQa1dgvEVkZC10W6IaiCFzRdlYeLGMa6tkQAjj5kj5tIbDKCxvc
	AEoyJaMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqtWe-00000008DJI-1a9T;
	Wed, 18 Sep 2024 12:11:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqtWM-00000008DHB-3tAX
	for linux-nvme@lists.infradead.org;
	Wed, 18 Sep 2024 12:11:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6A098227AAD; Wed, 18 Sep 2024 14:10:54 +0200 (CEST)
Date: Wed, 18 Sep 2024 14:10:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, kbusch@kernel.org, axboe@fb.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH] nvmet-passthru: allow nvme ns-id descriptor list to
 clear EUID/NGUID/UUID
Message-ID: <20240918121054.GA21062@lst.de>
References: <20240917085112.155173-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917085112.155173-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_051059_165447_857F68C2 
X-CRM114-Status: UNSURE (   8.29  )
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

Instead of saying allow I'd just clear 'clear ..'

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


