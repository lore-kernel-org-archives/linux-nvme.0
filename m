Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4220C432BE
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:23:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF2160BD3
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5EF2160BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xRzNiIR9qZ0T1YnnyzvGIK1MBG+QETqvjqdXp7misY0=; b=t6cTOQD1fUHQ4u
	d+jCmos7NggL/fEhB8duIxkDr3YvRB2f1d/nmyKiyKrKG5jAVlE/gX3qC2nO0hBWxNPJFsz9//QJd
	q9MHLoRPgRA7rkvsmIkpj1cLwuQN8zGl2NXr65lNlIW9W5IWX8cKD9k7roC94FFrQYWHEs9aWJqj4
	OvJ+2+hxT+McW2QZEWN7q61tezWyjJJh2GF0crKWyZVbv7PJ9rY8zf+Esir10VioDts9maHzY2Vsm
	qLg+o9Q/JetT9hSN26xrK9zovqj4wGkYejK8FqJNxWUymIvCgxg2Dn7A8j9rkdWJBWDbhGqSs7hoK
	s69Zt0l/iYVeb3sDDnYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLPGa-005uut-JX; Wed, 01 Sep 2021 12:22:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLPGT-005utl-J4
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 12:22:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9E7476736F; Wed,  1 Sep 2021 14:22:47 +0200 (CEST)
Date: Wed, 1 Sep 2021 14:22:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: fixup buffer overrun in nvmet_subsys_attr_serial()
Message-ID: <20210901122247.GA10562@lst.de>
References: <20210827092926.9525-1-hare@suse.de>
 <20210827162636.GA24829@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210827162636.GA24829@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_052249_821344_B787F01B 
X-CRM114-Status: GOOD (  20.56  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 27, 2021 at 06:26:36PM +0200, Christoph Hellwig wrote:
> On Fri, Aug 27, 2021 at 11:29:26AM +0200, Hannes Reinecke wrote:
> > The serial number is copied into the buffer via memcpy_and_pad()
> > with the length NVMET_SN_MAX_SIZE. So when printing out we also
> > need to take just that length as anything beyond that will be
> > uninitialized.
> > 
> > Signed-off-by: Hannes Reinecke <hare@suse.de>
> 
> The normal way to print a potentially unterminated fixed length string
> would be something like:

Does this version still look ok to you?

> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index f74485c705ff2..d784f3c200b4c 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1067,7 +1067,8 @@ static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
>  {
>  	struct nvmet_subsys *subsys = to_subsys(item);
>  
> -	return snprintf(page, PAGE_SIZE, "%s\n", subsys->serial);
> +	return snprintf(page, PAGE_SIZE, "%*s\n",
> +			NVMET_SN_MAX_SIZE, subsys->serial);
>  }
>  
>  static ssize_t
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
