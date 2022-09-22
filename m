Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04506C6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 05:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=88HdWfYi0pk9DK3qLW7bfAS25J4v7BNdlYWXhWHKWdg=; b=AHn8TBul0m/N9tCwLoauctn0Ai
	E78a8olGvwgOdxwieaV/JddFfMf5UJctPK6D272LuHyXpt9EdXw57JtPZqpPv5IdUSlFD50BF7XT4
	w5CtJAAssd3zTYIJmiGGJirTx7bBpPN8GzsM7vhh8Ib7yK2Bzvs1bVyP53yQn28Yyya3CTST+IFr9
	a3E9jg6E0ArHXksSUhOeWE3xZphYksv9CkhFWHe3FSCo0jVMO7zwraFmMaI/0lh8GpjdWk6ewmMWT
	0lsjeMeGA752pdksPZGNZAUkfGhqRjdupLnxXMn4qRBhJGK/VVb8+b2JgTTXnLx1L5TIiBKqGJSsb
	oSooAfow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obF4m-00DSGL-Lq; Thu, 22 Sep 2022 05:48:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obF4k-00DSFR-7x
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 05:48:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D384968AFE; Thu, 22 Sep 2022 07:48:37 +0200 (CEST)
Date: Thu, 22 Sep 2022 07:48:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 01/13] nvme: add common helpers to allocate and free
 tagsets
Message-ID: <20220922054837.GC27338@lst.de>
References: <20220920171611.1289361-1-hch@lst.de> <20220920171611.1289361-2-hch@lst.de> <cc827eb3-96d2-ff65-7204-05213bc018e8@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc827eb3-96d2-ff65-7204-05213bc018e8@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_224842_440377_AD2883A0 
X-CRM114-Status: GOOD (  16.62  )
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

On Wed, Sep 21, 2022 at 11:25:11AM +0300, Sagi Grimberg wrote:
>> +	if (ops->map_queues)
>> +		set->nr_maps = ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
>> +	ret = blk_mq_alloc_tag_set(set);
>> +	if (ret)
>> +		return ret;
>> +
>
> if (ctrl->ops->flags & NVME_F_FABRICS) {

Incremental fixup:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f8d9f32adc87c..91c2cb59c4eb6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4877,10 +4877,12 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ret)
 		return ret;
 
-	ctrl->connect_q = blk_mq_init_queue(set);
-        if (IS_ERR(ctrl->connect_q)) {
-		ret = PTR_ERR(ctrl->connect_q);
-		goto out_free_tag_set;
+	if (ctrl->ops->flags & NVME_F_FABRICS) {
+		ctrl->connect_q = blk_mq_init_queue(set);
+        	if (IS_ERR(ctrl->connect_q)) {
+			ret = PTR_ERR(ctrl->connect_q);
+			goto out_free_tag_set;
+		}
 	}
 
 	ctrl->tagset = set;

