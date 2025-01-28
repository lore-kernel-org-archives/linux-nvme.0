Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B535C0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q4ZRarVTyCPwNhzqmBIPdVk868QSBUU7B1w2lf8j31o=; b=YsFK7RrbxbPSPxUs08yUgjSTmE
	wVZ5/KL0LoyqPBOm1m8sA5c66W5VMXyibBeHPeOZiAqmND3zpQUcRv3tRp9UYUympn3ydop4ta2BJ
	kVUvfm6tV0vCZ/TSDFeNlOqhmibTMT1RcKTgFZKEgB3t9NdpsyVL4sN2NdQOmihSLjIJLO+w944+c
	ppMJEfFC4lCKUnYwxUfucEtDxhZKhLnxVBURofh9HGQfXJuNMwBJBStwun+dYNfEFep8zzZxKU9nI
	wLtNNHh6k/cZfojyHOdBHENT33ZVDb4ZLMyMlljPlDR5UKnen0hH7uAOYXrYFscxzgEXmXmCXsKGM
	rb4dzYFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tchh4-00000004URa-2vhi;
	Tue, 28 Jan 2025 09:15:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tchh2-00000004UQB-0iYI
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 09:15:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1141A68C4E; Tue, 28 Jan 2025 10:15:32 +0100 (CET)
Date: Tue, 28 Jan 2025 10:15:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 09/10] nvmet-tcp: support secure channel concatenation
Message-ID: <20250128091531.GG25760@lst.de>
References: <20250122165829.11603-1-hare@kernel.org> <20250122165829.11603-10-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122165829.11603-10-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_011536_357597_C9D28FE1 
X-CRM114-Status: GOOD (  18.19  )
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

On Wed, Jan 22, 2025 at 05:58:28PM +0100, Hannes Reinecke wrote:
> Evaluate the SC_C flag during DH-CHAP-HMAC negotiation and insert
> the generated PSK once negotiation has finished.

Same as for the host side, please write a much more detailed commit log.

> +	if (ctrl->dh_gid == NVME_AUTH_DHGROUP_NULL &&
> +	    ctrl->concat) {

This conditional easily fits onto a single line.

> @@ -247,6 +263,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
>  	struct nvmet_ctrl *ctrl = NULL;
>  	struct nvmet_alloc_ctrl_args args = {
>  		.port = req->port,
> +		.sq = req->sq,

So this now needs to pass a sq in alloc_ctrl_args?  That needs proper
explanation and really should be in a prep patch.  Also please Cc
Damien to make sure this doesn't break the nvme PCIe endpoint code.

>  	cancel_work_sync(&queue->io_work);
> @@ -1806,6 +1808,23 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
>  	spin_unlock_bh(&queue->state_lock);
>  
>  	cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
> +
> +	if (!status) {
> +		struct key *tls_key = nvme_tls_key_lookup(peerid);
> +
> +		if (IS_ERR(tls_key)) {
> +			pr_warn("%s: queue %d failed to lookup key %x\n",
> +				__func__, queue->idx, peerid);
> +			spin_lock_bh(&queue->state_lock);
> +			queue->state = NVMET_TCP_Q_FAILED;
> +			spin_unlock_bh(&queue->state_lock);
> +			status = PTR_ERR(tls_key);
> +		} else {
> +			pr_debug("%s: queue %d using TLS PSK %x\n",
> +				 __func__, queue->idx, peerid);
> +			queue->nvme_sq.tls_key = tls_key;
> +		}

This is almost begging for a separate helper..


