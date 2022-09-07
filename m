Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C1AC54EE9
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 06:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bc9/3RFQ3/BYv5GKcvhxJWM/+fz93rvd/+K14B4oPhk=; b=MPHKAg3Ti9iru0rpbpWHHFGenw
	IkpL5SRzvi+Er4ieewlsLIMbu0NbdOrGW/vu8UTHTnyAlgSZUiFDaPzXDbsif518dYo+bUW73Y8Oy
	OSdTBt3NlR189Kux6rMp+zqQq08CqQ+xCXtsumjqv2WGInWh5zuBywyu04ILlOBIVAzzmp8Zd7Hgy
	YKWrW4RY5fPnBTl8hP7ayUahVU73TKv7LDjIJeSz14WllzNzJ9YJMLcF97W8nrcg4ZpT3Lgk7BjfO
	Oz8Su9ng7qemxq3+htroU6OUDmlxGkHG+J7GRyhyc+4AkoD1TPpE0aCz8s2KdXjtJ8TiwSVjKb5Hk
	5iNdHeUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVotC-003Mkk-B0; Wed, 07 Sep 2022 06:50:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVoib-003IG9-OQ
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 06:39:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 847CF68AFE; Wed,  7 Sep 2022 08:39:22 +0200 (CEST)
Date: Wed, 7 Sep 2022 08:39:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: requeue aen after firmware activation
Message-ID: <20220907063922.GB21581@lst.de>
References: <20220901153039.4162460-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901153039.4162460-1-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_233925_962148_D1634506 
X-CRM114-Status: UNSURE (   7.82  )
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

applied to nvme-6.0.

