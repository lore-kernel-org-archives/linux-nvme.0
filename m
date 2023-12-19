Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33B5C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 05:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9PRzMeoGrTZrbQuCQTyxlw1WG85Fb3NgYkP4w9dbGu0=; b=om6dEC7gi7mCqM4rAEbtfhWEiA
	Zbhj+lidfOpG+zR2CUIFVzX0QSa8JyyFlI3iiEr45MzCpXWkZPqXMazuN/ba5x2xEDLlUYh0XumGe
	8ps6nJL3sGYROOUt4yY0lomK97I++cwBP0hM3lIhEGHSro6ebNGkUFrbFehRICXYf+pm4UJlUWkTn
	sj3ZBJhfK/uHd5OVkzgtApOkBDn2yDRpOigWXxapyjVGwiviatsoMM6o5Sy0xo+nj9YYwItfOaptB
	bqH6NnieEK1TShY5XVyftRLQYqBBKdX6iN5giAt5Ct//XuiM3N8S0+9pXBAlhd+mJKPvvX/nEb2Dw
	R3HWcd+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFSTO-00Cs0C-36;
	Tue, 19 Dec 2023 05:16:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFSTM-00Crze-2A
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 05:16:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 812FD68AFE; Tue, 19 Dec 2023 06:16:48 +0100 (CET)
Date: Tue, 19 Dec 2023 06:16:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 08/16] nvmet-fc: untangle cross refcounting objects
Message-ID: <20231219051648.GA32634@lst.de>
References: <20231218153105.12717-1-dwagner@suse.de> <20231218153105.12717-9-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-9-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_211652_848370_9E1111D4 
X-CRM114-Status: GOOD (  15.46  )
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

On Mon, Dec 18, 2023 at 04:30:56PM +0100, Daniel Wagner wrote:
> The live time of the queues are strictly bound to the lifetime of an

> +	struct nvmet_fc_tgt_queue	*_queues[NVMET_NR_QUEUES + 1];
>  	struct nvmet_fc_tgt_queue __rcu	*queues[NVMET_NR_QUEUES + 1];

For magic prefixes we use __, not _ in Linux.  But having two arrays
of queues right next to each other, once with rcu annotation and one
not rings a bit far warning bell to me.  Why do we have both?  When
are we supposed to use either?  Why is FC different from rest?

I really don't have any good answers as I don't know the code in the
FC transport very well, but I think this needs more work.


