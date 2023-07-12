Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020A0EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 13:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=P5r2lOx1MQo/IsCRqMmdRtdmnJ
	Mlz5UqfuQqh7w6pj2parBeKWQrkedrSQZzglagF4cV7HgRBxRKUg2GGmsS0hiswBTVMq4Y8bcAxp9
	ne1fIBGLGIpUjV0xaWJFxfTCRz0zwO3CDkaAuDCJsrj9ZmsI56bNfpGWGFibt36jfT6yy+LbgDaYj
	5kCxreBsEaCY4s8nrwlxmAaxVGIvemr/cMfE4SF0lzsTotKyIZTFIDORCD4cxN8FzLokUUOvEZAwX
	OPDdESwJ4G5NAspAyBECxVvj+yyxExzkJ1NMX6OmGwbvBaGGVO5OvqNoI7lIZDSEFk0yyduRznorJ
	/KZEUWIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZTl-00010H-17;
	Wed, 12 Jul 2023 13:02:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZTi-0000z7-3A
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 13:02:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47C1067373; Wed, 12 Jul 2023 15:01:56 +0200 (CEST)
Date: Wed, 12 Jul 2023 15:01:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Minjie Du <duminjie@vivo.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drivers: host: fix parameter check in
 nvme_fault_inject_init()
Message-ID: <20230712130155.GA12959@lst.de>
References: <20230712111838.11923-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712111838.11923-1-duminjie@vivo.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_060159_168653_84F9390D 
X-CRM114-Status: GOOD (  10.50  )
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

