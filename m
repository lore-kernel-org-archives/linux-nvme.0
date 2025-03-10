Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96BBC282DE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Mar 2025 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UYWkAGjqTxbwulqIXIHxkVa3gnw2Zc1n+/8Rj5If9qE=; b=SX7i+QJaHvDJwPf9wlMDNqqzOO
	nWUYAzUJTDXObgAiZvV7jaZwlr3QrnVHyKl51DlxfOJ/4p2w3NjKFISrlvcTsSBrfd0K/RwXjYySt
	PDmJ4sz1P4jDQAWw+f2HkAC3qWCbTc4s7vAIlVULLheKsCPrroim5aKAZWIXeLYBu2pS93uvl4sdF
	nP7hAHwBD70Jd8b2puVQiib11AMYNTZ9Fo484srwD8zm27SVC/6P4jaSyGwl1rCCQgK4WTth57Zh6
	AEZzGXPDtZrVP1AzSQQ+0re2FUwUGlNwbfUpgogAKODQ9TyLKrrqFW1S48iyQZ14zyjWAwc+Z/WNA
	1ZqiFGdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1treZp-000000033cu-1hB9;
	Mon, 10 Mar 2025 14:57:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trdCJ-00000002nas-1xpA
	for linux-nvme@lists.infradead.org;
	Mon, 10 Mar 2025 13:29:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 088C167373; Mon, 10 Mar 2025 14:29:32 +0100 (CET)
Date: Mon, 10 Mar 2025 14:29:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <20250310132931.GB8956@lst.de>
References: <Z8jk-D3EjEdyBIU5@kbusch-mbp> <20250306000348.GA1233@lst.de> <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de> <20250306141837.GA21353@lst.de> <Z8m4vzE36UHWjwep@kbusch-mbp> <20250306151654.GA22810@lst.de> <Z8pB9jQALxMN6WaA@kbusch-mbp> <b2c9df64-0afc-46cd-9e8d-6a3f41a4f1c7@linux.ibm.com> <Z8sUB2bbbMsurZmu@kbusch-mbp> <69cdaf9d-2fb4-4ee0-9c32-cc946405a23a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69cdaf9d-2fb4-4ee0-9c32-cc946405a23a@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_062935_644066_D4D0E14B 
X-CRM114-Status: GOOD (  13.29  )
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

On Sun, Mar 09, 2025 at 10:53:19PM +0530, Nilay Shroff wrote:
> Yes agreed however it seems advantages of using an indirect call outweighs 
> using the short cut to blk_mq_submit_bio. Moreover it seems the cost of 
> indirect call is trivial because we already cache the nexthop. 

Indirect calls are never cheap unfortunately.

> If you and Christoph are busy with other work then in that case I'll be 
> glad to pursue this further if you agree.

I'm not working in this area at the moment, so from my POV feel free
to go ahead.


