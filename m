Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A59C47DDF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 06:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=KfdxvWNft0etFlSNlM0vuadv+1
	4LIzhmEbi7x9IcYMGNyo6bOT38xQ3hIZh+3B1JMtFyowqJAsf/4RIUGCfxBWeJQSqbn17Q8h4P+rh
	5qjYASEy2QGNk1MrTPXjvPeOURJ++Amva4CEzCx6QYJTwiTZIjVl62car4fnsE48mU9kJtxcZ+h90
	dCAgPYc3boBo/SfjuT67bYuEt8ln1Hr1lJlQSj4554QjJkIvx4+oippo7jBCmuO3yJp8R2IgPA9kj
	G3ZydFu4mqSvsGtJVXh8hZQwba+j+Cb3cLJwmkfpI8Bynx5Y3tovqQWsTHdUzK36yCbxUyskRNIGP
	7/ZziRuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUKhB-0000000BOo8-2bNG;
	Mon, 29 Jan 2024 06:00:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUKh8-0000000BOnK-1y8i
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 06:00:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB9C168B05; Mon, 29 Jan 2024 07:00:31 +0100 (CET)
Date: Mon, 29 Jan 2024 07:00:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	chaitanyak@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3] nvme: use ctrl state accessor
Message-ID: <20240129060031.GA19237@lst.de>
References: <20240126171608.2136149-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126171608.2136149-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_220034_699762_44402FA3 
X-CRM114-Status: UNSURE (   8.94  )
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

