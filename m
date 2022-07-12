Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CDBCCA47C
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jul 2022 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jkeP3VVfmVM3Ybia+TpE1HCbpybnK7cP5ZMMuBW9m0A=; b=SMKCbtgjd+gC0Xd0RdLpoqTaVK
	bSuh2ZC7BFydV5kYJmxga/y8iivJnhDW49YkpMChli2uZeB0J0pxkXizr+czKUwLPlGjqGb6Wuwb9
	wjlCjAQVNkqA7NtAbKZxMPtoBnIiIynCiMa+mkfHorMnRVGgK1jKDS+aaB5RIynW5FkjTK9AsKaPa
	8EjSSRhsoDlGVPRwKpDdc5geqQrAuTE1d5KjnhlwCQABbE42ZgcQBmRuWurxcSM7FmoU3mKVDeviZ
	QAs0yjqNeXs0f9mGfkyR8AYy79PWOZCzd0r8BjSdx5cbjexjKP7cJTO6zJvdGhME4Qd0sL63pcHZc
	A2mk5PWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBHvW-00CBhZ-Bf; Tue, 12 Jul 2022 15:35:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBHvT-00CBfd-Bc
	for linux-nvme@lists.infradead.org; Tue, 12 Jul 2022 15:35:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 80C8368AA6; Tue, 12 Jul 2022 17:35:47 +0200 (CEST)
Date: Tue, 12 Jul 2022 17:35:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander <csander@purestorage.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme-tcp: use in-capsule data for I/O connect
Message-ID: <20220712153547.GB27958@lst.de>
References: <4cfe8116-bb6c-735d-0bb3-ce5e2612505b@grimberg.me> <20220707211245.3989107-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707211245.3989107-1-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220712_083551_559151_A9F03641 
X-CRM114-Status: UNSURE (   9.05  )
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

applied to nvme-5.20 with an updated commit log based on the reply
in this thread.

