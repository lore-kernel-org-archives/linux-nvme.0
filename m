Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B95DC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 13:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8tDHpG8yAQz0j2TuQpSElbQIKRU+cc8M9A0+VrUEHr4=; b=bdXQFJVYdVlsXLfTBFcGjCfofa
	9anyaHlBERfvFEAVlKg4XFSDXLXWMqpQb+ZdpmwnbYaNdop1AWVQyECN+XE92VIUr10k+0aFINOTq
	X/TWyiaMskh8sUsz93VYJLpIXiTS8og6BMM+BiIVBcEGhIiZAQfd141AyjbWIOW2qk/pGYAy9kEVB
	DIbMmxb7ufs442pAS8dkeW6R6bvwNoUPoO/Xf79kjakyWp3M4sV2aIPupKPCJ0Plfw46lUD1cnq3h
	Wi9ptbiFPqEihOA6NwNnrA7XH41B01rR01eNBZBfXWehVRaZJAwB+ha9k4dZ+JEko1CWaKAAmhjuz
	tsLUXgMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQP8-00CDnY-2L; Mon, 17 Oct 2022 13:43:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQP5-00CDmj-Ki
	for linux-nvme@lists.infradead.org; Mon, 17 Oct 2022 13:43:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 28E0E68BFE; Mon, 17 Oct 2022 15:43:36 +0200 (CEST)
Date: Mon, 17 Oct 2022 15:43:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
	ming.lei@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221017134335.GA24959@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com> <99dac305-206c-4e1b-a1ec-50e107258b6b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99dac305-206c-4e1b-a1ec-50e107258b6b@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_064339_840431_80C8C669 
X-CRM114-Status: GOOD (  11.76  )
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

On Thu, Oct 13, 2022 at 01:28:37PM +0300, Sagi Grimberg wrote:
>> Because some queues never need to be quiesced(e.g. nvme connect_q).
>> So introduce QUEUE_FLAG_NOQUIESCED to tagset quiesce interface to
>> skip the queue.
>
> I wouldn't say it never nor will ever quiesce, we just don't happen to
> quiesce it today...

Yes.  It really is a QUEUE_FLAG_SKIP_TAGSET_QUIESCE.


