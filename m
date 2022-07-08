Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A57C43334
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jul 2022 05:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0A4ennnc2F+IoJyjjEUp5ofCfIPhj/ZHG/krHpep8B4=; b=1Zj2rTDELFLAY0VIOgZBGCY0gJ
	b14+xt8v2tt52aKbJVPSTm4uYp1kskowH1JWll6DDkdiucbyLQM6JW9WgmKlb3NL9OcaH/T2ZUxYP
	mIw3Ogz9JhV36d5OdBfPYxtXtEMgbPNTwSl4rvz7D4A6M0P4K1mZMQPr9WfS8lN1PJt8m/rp5/+Vc
	uXcyS/hB+jBWe5/6FCZ8TV8ZXCxD0PjX4D09k1MZMEBEjFMMIF8hPgfC3SyXeA74hpKDcFekWGuD+
	aeC5CjAjSlAGbf+IyJHKGneRFIq2HJ0Nq8IPsg2CXy1mhlLITB8LB/uGVqP4plWRC/73TIlBkeONn
	hqd9JuPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9g6m-001lZQ-4z; Fri, 08 Jul 2022 05:00:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9g6j-001lW5-16
	for linux-nvme@lists.infradead.org; Fri, 08 Jul 2022 05:00:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7017167373; Fri,  8 Jul 2022 07:00:38 +0200 (CEST)
Date: Fri, 8 Jul 2022 07:00:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander <csander@purestorage.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme-tcp: use in-capsule data for I/O connect
Message-ID: <20220708050038.GA15655@lst.de>
References: <4cfe8116-bb6c-735d-0bb3-ce5e2612505b@grimberg.me> <20220707211245.3989107-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707211245.3989107-1-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_220049_267137_BD972CEB 
X-CRM114-Status: GOOD (  14.69  )
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

On Thu, Jul 07, 2022 at 03:12:45PM -0600, Caleb Sander wrote:
> >From the NVMe/TCP spec:
> > The maximum amount of in-capsule data for Fabrics and Admin Commands
> > is 8,192 bytes ... NVMe/TCP controllers must support in-capsule data
> > for Fabrics and Admin Command Capsules
> 
> Currently, command data is only sent in-capsule on the admin queue
> or I/O queues that indicate support for it.
> Send fabrics command data in-capsule for I/O queues too to avoid
> needing a separate H2CData PDU for the connect command.

While I'm fine with this change, can you please state here why this
is important?  Is there a use case where it really matters?  A controller
that is unhappy if this doesn't happen?

