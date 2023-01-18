Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7CCC004D4
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 07:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8g3Szrg1L4vmjcFPx7Txy+9BP9RpagD94A0A6Kp0xKo=; b=hYwQ0TethedJhDbvKGpWKr8l4M
	X1X59txmKniNvOPAkxtwIu2lAPIpzTQhTCoN8nsiBsjhJo4FC8UMCH9yhsQGVScg+Gtn/SyeZqt+R
	Fqn0AoGwsNBiRQ7MCg1B21BC5+MqRze70C9JXqc4cAttZNsg2FsZXBZbMlPdq+xhEG4hC8fZhzM2z
	gO30oUYOJCCQYCznmZ5BwTS1sthnc6cnaaM3EG27enB1404mmIutN2Kfnyby7bSONlbzUKY6CGBx/
	8ulf0M5WtfbOOs7aSsQcSaN8sIFy93+QI+wx6IQGF8jBb6niY3Jr+uFygTn0oEOO7vBFTsk7Yvd8N
	lG4yAucg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI340-00HI0m-1V; Wed, 18 Jan 2023 07:40:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI30F-00HGOC-3g
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 07:37:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE78267373; Wed, 18 Jan 2023 08:36:54 +0100 (CET)
Date: Wed, 18 Jan 2023 08:36:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Bryan Tan <bryantan@vmware.com>,
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
	Israel Rukshin <israelr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@fb.com>,
	Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vishnu Dasa <vdasa@vmware.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 00/13] Add RDMA inline crypto support
Message-ID: <20230118073654.GC27048@lst.de>
References: <cover.1673873422.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673873422.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_233659_362015_51FB2674 
X-CRM114-Status: GOOD (  15.00  )
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

On Mon, Jan 16, 2023 at 03:05:47PM +0200, Leon Romanovsky wrote:
> >From Israel,
> 
> The purpose of this patchset is to add support for inline
> encryption/decryption of the data at storage protocols like nvmf over
> RDMA (at a similar way like integrity is used via unique mkey).
> 
> This patchset adds support for plaintext keys. The patches were tested
> on BF-3 HW with fscrypt tool to test this feature, which showed reduce
> in CPU utilization when comparing at 64k or more IO size. The CPU utilization
> was improved by more than 50% comparing to the SW only solution at this case.

One thing that needs to be solved before we can look into this is the
interaction with protection information (or integrity data in Linux
terms).  Currently inline encryption and protection information are
mutally incompatible.

