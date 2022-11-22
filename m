Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0782C43217
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 12:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lvvoEDBCYfVEVzHpj1y0YDfDIe3bIbSmpPO1ByDq8sc=; b=b3p2Emg/irk5RbiQqZZ9XWm15y
	22X0r+b2+7Hma/14yNxB5GJHJp4WQVUk2I1865+n/Mp3fn4QCUsttAKUKdaTEwcI33+GC4TIiZZ6k
	KFPF0hOYVJ2gGDF8H0SlsRZbHqCXyih9u+SU32yCaz/RebhTQ+eBcYo41NLq1IiQRY3hwDQod0ORC
	SJ8RsaQnGkd8nlM0rA1HdFji9aRGAhooFN5FPKkqi7WUH7tFa7UBfeHAyDQkgQ1/7giV7Pky5M9N0
	6yPLYiK9oKztpgGQsrkvmD6ilhtxVRdc4d18je5zFn0p3ji6PpfgPQ8dTW31C2EKWYpJHIyDJipp3
	QQDShpqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxSRY-0098jl-53; Tue, 22 Nov 2022 12:32:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxSRU-0098gG-Tc
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 12:32:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F27EE68D05; Tue, 22 Nov 2022 13:31:54 +0100 (CET)
Date: Tue, 22 Nov 2022 13:31:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, lengchao@huawei.com,
	linux-nvme@lists.infradead.org, Gerd Bayer <gbayer@linux.ibm.com>
Subject: Re: [PATCH] nvme: don't call blk_mq_{,un}quiesce_tagset when
 ctrl->tagset is NULL
Message-ID: <20221122123154.GA5610@lst.de>
References: <20221116072711.1903536-1-hch@lst.de> <e5de54b2-4906-9902-c150-732718a77571@grimberg.me> <20221116132225.GA8071@lst.de> <1ee364d8-4aef-acf6-1cf9-38787ddac288@grimberg.me> <20221116132805.GA8496@lst.de> <2b6bae87-b008-6f8d-3c70-2334b5bd48b7@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b6bae87-b008-6f8d-3c70-2334b5bd48b7@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_043201_124276_7F67F1DC 
X-CRM114-Status: GOOD (  15.18  )
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

On Sun, Nov 20, 2022 at 01:38:28PM +0200, Sagi Grimberg wrote:
>
>>> All the other drivers check that they have IO queues before
>>> quiescing/unquiescing them.
>>
>> The core firmware activation code does not.
>
> Well, ideally it should, but maybe it would be more readable
> if we condition on ctrl->queue_count > 1.

This would be the queue_count version.  I have to say I much prefer
the tagset check, as it is self-documenting and matches what
nvme_queue_scan, nvme_cancel_tagset and nvme_cancel_admin_tagset
do.

