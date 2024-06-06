Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE90C27C52
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 06:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Wl4UotmSNPGrfEBwWQN8ldoZrOXqmvjb5gDzyBJQvE4=; b=fS8DuebV1GlBpwaz9hGx3Nz4Gh
	7X6XdQdG/FWHnGuX2KlJVS3aOKKKX4mejX3RdhEuQUGVcghwGdRALqL3M6tmauX8Oy+8BMdWqNhmM
	gIQP+95CfMy+oL/WWv68w6ybjcAR6HaznEY29A+3lYZ0J1PcIr2e8AXbty9gTsmWqrdBtwiPAAmbu
	oMgXmAS5PHfrZeoGXOzFyGpXPbzddxy33/AtdpfzC0QU6Azc9MwtZAVjd+pDK0tKJqADwYgbdha4e
	Uzc0PphgSC5LCtm4j0Oescj7UkzFnI0vrzr7dhDFfFnhgdpbzrsIow+mRwdF474wBUzB4YGXiJP/H
	8L+J9zSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF6OU-00000008URt-2dMq;
	Thu, 06 Jun 2024 06:14:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF66h-00000008S3x-3gh2
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 05:56:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6AACE68CFE; Thu,  6 Jun 2024 07:56:11 +0200 (CEST)
Date: Thu, 6 Jun 2024 07:56:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 03/12] block: add copy offload support
Message-ID: <20240606055611.GA9404@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_225616_634596_D2C7F0A8 
X-CRM114-Status: GOOD (  15.59  )
X-Mailman-Approved-At: Wed, 05 Jun 2024 23:14:37 -0700
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

On Tue, Jun 04, 2024 at 10:50:26AM +0000, Nitesh Shetty wrote:
>>> +	if (!cio)
>>> +		return -ENOMEM;
>>> +	atomic_set(&cio->refcount, 1);
>>> +	cio->waiter = current;
>>> +	cio->endio = endio;
>>> +	cio->private = private;
>>
>> For the main use this could be allocated on-stack.  Is there any good
>> reason to not let callers that really want an async version to implement
>> the async behavior themselves using suitable helpers?
>>
> We cannot do on-stack allocation of cio as we use it in endio handler.
> cio will be used to track partial IO completion as well.
> Callers requiring async implementation would need to manage all this
> bookkeeping themselves, leading to duplication of code. We felt it is
> better to do it here onetime.
> Do you see it any differently ?

We don't really to these async variants for other in-kernel I/O,
so unless we have a really good reason I'd not do here.  The usual
approach is to just have a submission helper for async in-kernel
special bios types, and the let the caller handle the rest.


