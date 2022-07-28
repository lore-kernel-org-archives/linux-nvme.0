Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652ADC04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 16:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OKoPl6pkKwqfVXv0tkCsZkhTLVRcHEZ8byA5r6vMqzE=; b=WCtjUytaxntXrLKzkXN/blQ7Xl
	CwBy/FpQLYmeo30979P/mRNCYUjVIvEVkQe4vlLWQrXnSet0i07T8roBi+hycM62rofvgWTw4nmSo
	YO4i+3JgfjnIUKDOI10tpqsZC+ELrFyflMA5LhZ22Eb2+MYaUXjSwrTbgDcWWQP6qz8NYZaKWN7BL
	8XWg1rw4PU2miC4H8JZ0WVuD+8amhnMV7zZsfFhXT2qwgb9JDn3cLFeKCOAGttzGb7XC6TduZrx4d
	jxDWCFzUe5dXWNIw4bN9dcipWBcuMYensIqAx3NwkL05cW3spGb7HVcHLaxz8lpJOxAxmgiCfPng8
	AsijjNaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH62F-00An7V-9D; Thu, 28 Jul 2022 16:06:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH62A-00An1q-Ny
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 16:06:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9605667373; Thu, 28 Jul 2022 18:06:37 +0200 (CEST)
Date: Thu, 28 Jul 2022 18:06:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	"Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH] nvme-fc: restart admin queue if the caller needs to
 restart queue
Message-ID: <20220728160637.GA19898@lst.de>
References: <20220721003358.543509-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721003358.543509-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_090646_968836_014F77AF 
X-CRM114-Status: UNSURE (   9.75  )
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

applied to nvme-5.20.

