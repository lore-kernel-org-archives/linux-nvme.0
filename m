Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5800AC55822
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 16:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=1DouM6LhLPclbyafjQFPoq/g4a
	x6OIC0a571dbeg1+YKuGVCNLZhZEZquBGI4s7/UZLmowH5b4hUdqEzG8ZABCOR5T6Tyw/GfcVLwU1
	V7vMLjSK9Z0mcKeqxWEyH/BJ3KTvyjRBZ/JCoKuZ8y0jYGhGZ/voQrWfgH38LD6AiYxRIo5+5msEC
	L+tS6CjHt6gzzUQu5uzuKMcmetehTrKWZgOjVaLxBCvzyos0CeK0jLqiGAfavVupa1ON2hHiqAmDb
	s4p3zVKeFzxH1LGRWa6aWv29GifhGwfj2oIig3Qg0FMzrMsi19V4oAV5feEq5kHVJzSvGX2yYVZM5
	MOX+uiKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrHqI-00000002IBy-0J9n;
	Tue, 04 Aug 2026 16:18:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrHqG-00000002IBP-1V4b
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 16:18:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8B2576732A; Tue,  4 Aug 2026 18:18:08 +0200 (CEST)
Date: Tue, 4 Aug 2026 18:18:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: fix NULL pointer dereference in
 nvmet_execute_identify_ns_zns()
Message-ID: <20260804161808.GB11977@lst.de>
References: <20260804033605.3973127-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804033605.3973127-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_091812_535572_EE4485FC 
X-CRM114-Status: UNSURE (   9.87  )
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


