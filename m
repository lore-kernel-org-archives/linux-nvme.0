Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D8CC10DC3
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 07:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CeX7pmIQi39nmgyPP/8r+ftr2w2xEYA7NtS9twyibkc=; b=WiUz7JzNXOZDbYpFSuaYxdNgpe
	FkFtMPuDW3ZiWuXTPey8NwvLHq+sngPTAj0a7n91iTND+2rsC5czN44Ox/x/FrEeH2eaym0DDbFwK
	j6bvSOMO7u3CY7UHN2a/9fziU+x3JUHEiihrNzilvUiSDJWFP7mz9ZR9IeYv4NSnv5ahFuWhZZZ+b
	nF49dS1A7IJnBetGpzhBgzmwnISs3rNLrby41fAy+dbQdUc1Ai5Bcu8hVkelZbga08JMoaEbHq0XW
	l53dKB/2jIDu08N/AyBc7JKyK6qB8YLaLsvlQpNeUOR39epuOrJDQNIwQlWvoQ/jibClVvxF6J7Pf
	Gk1wlGFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA3jz-003Bn1-03;
	Mon, 04 Dec 2023 07:51:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA3jv-003BmD-2R
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 07:51:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EC0DA227A8E; Mon,  4 Dec 2023 08:51:34 +0100 (CET)
Date: Mon, 4 Dec 2023 08:51:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v2 2/3] nvme: move ns id info to struct nvme_ns_head
Message-ID: <20231204075134.GB29377@lst.de>
References: <20231201092735.28592-1-dwagner@suse.de> <20231201092735.28592-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201092735.28592-3-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231203_235139_950591_11C0799D 
X-CRM114-Status: GOOD (  18.20  )
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

> +	if (head) {
>  		pr_err_ratelimited("%s: %s(0x%x) @ LBA %llu, %llu blocks, %s (sct 0x%x / sc 0x%x) %s%s\n",
> -		       ns->disk ? ns->disk->disk_name : "?",
> +		       head->disk ? head->disk->disk_name : "?",
>  		       nvme_get_opcode_str(nr->cmd->common.opcode),
>  		       nr->cmd->common.opcode,
> -		       (unsigned long long)nvme_sect_to_lba(ns, blk_rq_pos(req)),
> -		       (unsigned long long)blk_rq_bytes(req) >> ns->lba_shift,
> +		       (unsigned long long)nvme_sect_to_lba(head, blk_rq_pos(req)),

Please avoid the overly long line here.  Best done by removing the pointless
unsigned long long casts, as u64 is always an unsigned long long in the
kernel these days.

> -			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> -			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> +			u64 slba = nvme_sect_to_lba(head, bio->bi_iter.bi_sector);

Please avoid the overly long line here as well.

> +static void nvme_set_ref_tag(struct nvme_ns_head *head, struct nvme_command *cmnd,

.. and here.  I'm going to stop now, please also fix up all other
places.

>  void nvme_failover_req(struct request *req)
>  {
> -	struct nvme_ns *ns = req->q->queuedata;
> +	struct nvme_ns_head *head = req->q->queuedata;
> +	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
> +	struct nvme_ns *ns;
>  	u16 status = nvme_req(req)->status & 0x7ff;
>  	unsigned long flags;
>  	struct bio *bio;
>  
> -	nvme_mpath_clear_current_path(ns);
> +	nvme_mpath_clear_current_path(head);
>  
>  	/*
>  	 * If we got back an ANA error, we know the controller is alive but not
>  	 * ready to serve this namespace.  Kick of a re-read of the ANA
>  	 * information page, and just try any other available path for now.
>  	 */
> -	if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
> +	if (nvme_is_ana_error(status) && ctrl->ana_log_buf) {
> +		ns = nvme_find_get_ns(ctrl, head->ns_id);

This looks unrelated.

> -bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
> +bool nvme_mpath_clear_current_path(struct nvme_ns_head *head)
>  {
> -	struct nvme_ns_head *head = ns->head;
>  	bool changed = false;
>  	int node;
>  
> @@ -181,7 +183,7 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
>  		goto out;
>  
>  	for_each_node(node) {
> -		if (ns == rcu_access_pointer(head->current_path[node])) {
> +		if (head == rcu_access_pointer(head->current_path[node])->head) {

and this can't work.  We need to check the actual ns for the path
selection, as that's kindof the point.


