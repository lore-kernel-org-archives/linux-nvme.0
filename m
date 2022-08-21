Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505FFC00140
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Aug 2022 06:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8oGZokvBAgAmGa/AGNYft6cu4JzaUDWu8P4wWm4ppeE=; b=zEmXKUQ+WI6VrdmVqjKbuWXIDk
	xLogJ2zAFcTUgX9/jVnmF6OoZkYNNr6vGGSXiJKL2yvlCXRYp8uwYp+JOGe2E9M/UKZt427k4XFS4
	eVdHBlDZ/Mlr/oXzDqjRRyXqz+ds8lbIdlZBrtLMo/9JjeZ4OiDYAL7QMRAI9fjv9JXLRyMNviMZk
	yiZmq/rNA/ETGszl5TXuAiE+rJ8HkrflRhw6K/jSNYpLnWS2X44hX/UA88zhUj4ibqszGZRcPtISD
	XlmzywGPZI/GwLWMVEN6cMADRdjmW2Q5nqMK9ibgqxu/sIk0l8H2759Tm24oLTJ6MBhL53HTg1c/e
	j/qfAdzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPeJt-006heM-Dk; Sun, 21 Aug 2022 06:20:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPeJp-006hcK-SA
	for linux-nvme@lists.infradead.org; Sun, 21 Aug 2022 06:20:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65E4168C7B; Sun, 21 Aug 2022 08:20:17 +0200 (CEST)
Date: Sun, 21 Aug 2022 08:20:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kbusch@kernel.org
Subject: Re: [PATCH] nvme-rdma: set ack timeout of RoCE to 262ms
Message-ID: <20220821062016.GA26553@lst.de>
References: <20220819075825.21231-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819075825.21231-1-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220820_232022_115838_CD6A4783 
X-CRM114-Status: GOOD (  12.89  )
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

On Fri, Aug 19, 2022 at 03:58:25PM +0800, Chao Leng wrote:
> Now the ack timeout of RoCE is 2 second(2^(18+1)*4us=2 second). In the
> case of low concurrency, if some packets lost due to network abnormal
> such as network rerouting, Optical fiber signal interference, etc,
> it will wait 2 second to try retransmitting the lost packets.
> As a result, the I/O latency is greater than 2 seconds.
> The I/O latency is so long for real-time transaction service. Indeed we
> do not have to wait so long time to make sure that packets are lost.
> Setting the ack timeout to 262ms(2^(15+1)*4us=262ms) is sufficient.

I'll leave people more familar with RoCE to judge the merits of this
change, but I really want a comment explaining the choice in the
source code.

