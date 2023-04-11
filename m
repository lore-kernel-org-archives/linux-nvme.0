Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D0AC7619A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 06:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C5SXgci0NIPzcA+EStRsOpIQDFLWOuteDeIzGNio/z8=; b=1AVvRbjjaWq+3IvRGvRvMI5cpb
	wRwzjggE0DIU91yQcWtYTSFnvN8rgPmE4jk2KTCpoxOUKUA2oSAE3jz5fWHf0VyQ0exu/nxAnPLhu
	0sDlptSv7W5wjv72B9K3ZwlFIdFmsBpmMc6vTmM0xlxBuRzbrZA57ZyhICvbxHlkJH8l8jadGtiH3
	7Jp6dAxr3RC0xWoD7ghAmVpnhIpg+LIfJHzV5uNtYD5YDwebB+xVnWJKzaZmqugw514NhsyLY4JPM
	ZQ8nVqqEwfAmC5CLs/apSgwXkrMlkxKpRISKK/r5n7wSc7r8dxnXtEQ3V2SsR1TDOlgR5UavwwZQa
	V5EJTBbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm7BR-00GXjy-1E;
	Tue, 11 Apr 2023 06:08:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm7BO-00GXiz-39
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 06:08:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4BA6D68C7B; Tue, 11 Apr 2023 08:08:44 +0200 (CEST)
Date: Tue, 11 Apr 2023 08:08:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	Yamin Friedman <yaminf@mellanox.com>
Subject: Re: [PATCH] nvme-rdma: minor cleanup in nvme_rdma_create_cq()
Message-ID: <20230411060843.GC18527@lst.de>
References: <20230407091557.258669-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407091557.258669-1-pizhenwei@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_230847_158959_4A0FDBE7 
X-CRM114-Status: UNSURE (   7.38  )
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

applied to nvme-6.4.

