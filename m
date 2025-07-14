Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D12C83F1A
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BH/BFS4DBD/MyEOZSB2vsiZjeO/geaFzg1v7t3pZn2g=; b=AQCETIJ2PSjFwXKWM3hoAQ4tKj
	ncqkxcJjl459lUk4yNZDETHqQeqbid+E/jVprSuhqW61F1kS3gKU4eV68DLm5feP6UR0dfcNveZvx
	dKPVKHTJ8gAOcDlt2DtfCNpFsiabPH5WC6oaBIExHl4u1QfOZ6G3ak9om4YE6HRBwgNSN44PFSIgW
	VEqkVYNGZ/HXazPI+e5RMIdI1kUuATLfowJSm65y7PoUi6W++X4oD9yL7CeQFnV34frYSQbgiO/Rv
	ePfNrqYTrNy03jsEpt8spg4zI4T3Zv7wCxLLh2hSJNRZ8GVVmWy67JqF20OSmnISQp8ej1r2rL+qV
	SyAHMP5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJfN-00000002NrZ-08AN;
	Mon, 14 Jul 2025 13:56:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJbg-00000002N6M-2ayc
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 13:52:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E6D9B227A88; Mon, 14 Jul 2025 15:52:32 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:52:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	houtao1@huawei.com, zhengqixing@huawei.com
Subject: Re: [PATCH] nvme: fix inconsistent RCU list manipulation in
 nvme_ns_add_to_ctrl_list()
Message-ID: <20250714135232.GB11944@lst.de>
References: <20250701071717.2619384-1-zhengqixing@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701071717.2619384-1-zhengqixing@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_065236_798558_EB6CBE02 
X-CRM114-Status: UNSURE (   8.32  )
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

Thanks, applied to nvme-6.16.


