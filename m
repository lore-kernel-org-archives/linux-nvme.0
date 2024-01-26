Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C40C47422
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 13:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZmLK5jMevO5dPdPnQLUdWl4IdNcM2KmF0yYPojoCXG0=; b=vykVXRr+DlX1nMNBbJ4Pu/4TYz
	ItkJDRoiFJSqgIYjrBwCnuRN1ZK/aB+wIs8eSpXssL/nz8VDEe/+CXa0Y0srT95e3MvB/azDYt0vQ
	6e1km4nNto5fdjVxjdUuz0dw6liNeS4MSZdRMXAyq5decLNHEZsmApPwtf9yGHYdpC3bWr1dFQvji
	dvV7kybma43mtDqWFQjtpcsEpHCmTKMMjxn+oHo9vrPmhPvYpM4JoYC7PAEB74N3oJR3li8+/p6KZ
	4Kn9l8NQj2X3mbpb7XmLfr40UcDh10YwbxBHhaoAMyzmoplWGKQh9Ji/cS9Sc0tj0Y6Rm8HVKsRVp
	KNRcEIHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTMaW-00000004FVR-1gBA;
	Fri, 26 Jan 2024 13:49:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTMaT-00000004FUw-0rK7
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 13:49:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D2D968C4E; Fri, 26 Jan 2024 14:49:37 +0100 (CET)
Date: Fri, 26 Jan 2024 14:49:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>, Martin George <marting@netapp.com>
Subject: Re: [PATCHv2] nvme: enable retries for authentication commands
Message-ID: <20240126134937.GA3016@lst.de>
References: <20240126063709.123814-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126063709.123814-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_054941_411470_FC6D786B 
X-CRM114-Status: GOOD (  12.31  )
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

On Fri, Jan 26, 2024 at 07:37:09AM +0100, hare@kernel.org wrote:
>  #define nvme_auth_flags_from_qid(qid) \
> -	(qid == 0) ? 0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED
> +	(qid == 0) ? NVME_SUBMIT_RETRY : \
> +	NVME_SUBMIT_RETRY | NVME_SUBMIT_NOWAIT | NVME_SUBMIT_RESERVED
>  #define nvme_auth_queue_from_qid(ctrl, qid) \
>  	(qid == 0) ? (ctrl)->fabrics_q : (ctrl)->connect_q

Please just open code these two obfuscating macros with a single user
each to make the change easily reviewable.  That also means after that
you only nee to assign NVME_SUBMIT_RETRY once and not in both side of
a ternary operator.

>  	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
> -				     qid == 0 ? NVME_QID_ANY : qid,
> -				     0, flags);
> +				     qid == 0 ? NVME_QID_ANY : qid, flags);

And then split addition the calling convention change for the request
submission helpers from the actual behavior change into a well documented
prep patch as well.

> +enum {
> +	NVME_SUBMIT_AT_HEAD  = (__force nvme_submit_flags_t)(1 << 0),
> +	NVME_SUBMIT_NOWAIT = (__force nvme_submit_flags_t)(1 << 1),
> +	NVME_SUBMIT_RESERVED = (__force nvme_submit_flags_t)(1 << 2),
> +	NVME_SUBMIT_RETRY = (__force nvme_submit_flags_t)(1 << 3),

Maybe write some comments explaining the semantics while you're at it?


