Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBBFC5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 14:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=0u/jVoOUSROTe5halROk4cD48e
	LY4vnH54zxe3sULMdNEckooEXrXR7UXYPI4WLaX3ZDPtFQrbcnVj1DZUGR2jejMdLfNiuv9urHO+z
	kk1VrQtaCfLayOAciCR25dRTRG6Lb79l5EF6Em0qckrR4f+Px2z5cd7JA6v5hV+9hX1z2ytETJ8Qa
	R786ooyXgWfUTivogPqJBeCHGKGNt3gjEzj6v9We4jcPPRgbq/P0cbT9/L10fm45jlYNS1fHoc6/6
	3lMGsgPmfFyd79MJfw33QNiuKjId0kymMetqNO+dJ/S6WFUXTksuRkGCKXz7ZtajqRAIgnep79VOG
	lQXiXvww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ribQo-00000009d6k-2cz2;
	Fri, 08 Mar 2024 14:42:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ribQm-00000009d5d-0oxj
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 14:42:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A3C6668BEB; Fri,  8 Mar 2024 15:42:36 +0100 (CET)
Date: Fri, 8 Mar 2024 15:42:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvmet-tcp: do not continue for invalid icreq
Message-ID: <20240308144236.GB9194@lst.de>
References: <20240308071105.6175-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308071105.6175-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_064240_404433_DD867B7C 
X-CRM114-Status: GOOD (  10.25  )
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


