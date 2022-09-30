Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC1DC4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 06:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KfadNsIYNHGtfp3YXUna8+Y0zB6fgdoqC9SFLBitscg=; b=uGl7RAIySEoqDv/PHlEXbeCHnf
	INU76HYNT+JbxhcYk2MBHUVunCIr8bebkLDcQ9VFX2PmQ7nXDBnmruXbZCtMPq5kBiVjOxt8nPsBa
	7yH1FMl1V/fuptp3i1t8dCXijBihzW9XfF4f3qKLp5/L/9sVy8ScyKj8/EUDPOKwo3tcw1dkmvj/o
	sr+vliszwJOVsGSNcVy7rFfJIUhsS9zqXrefVNAXzM5rYRhCs/MXljoN4KKM28JVHcDEV1eBH/R1r
	NyYv6KgSmPx6Mnq7jsseYh2P/EyYtClZPZCUsW0htWqYn4XH46zjyk8e8EiyCOHRmzrRcq2PyObBV
	pLsaTDug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe9XA-007WV5-H4; Fri, 30 Sep 2022 06:30:04 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe9X8-007WSy-91
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 06:30:04 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C788A218FD;
	Fri, 30 Sep 2022 06:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664519394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfadNsIYNHGtfp3YXUna8+Y0zB6fgdoqC9SFLBitscg=;
	b=0v53fvkVEtx9UKjzJzlBdr4MH+1GE9sOb1vtcWMw/BJ1ygcKugFlJTm7itPLvZE8draDd2
	Ld3tNQnDFh7a+mucKfGlYHLqJB8WdO9eCCaKcqLfrSUmSYHqJS4U8c56tLR8apip2nJ1lD
	UaarJB3UWXsHH/u2WV+DZqNSbUyX2II=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664519394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfadNsIYNHGtfp3YXUna8+Y0zB6fgdoqC9SFLBitscg=;
	b=VzlbNqHi+zjEuZXIwQDFS2yfcI9zxexns0EPrcBAhmchjFCivffbkIqMoJEvulNlDXjd7j
	zU3GRW5vJDKLCfDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FAF013776;
	Fri, 30 Sep 2022 06:29:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xBw4JuKMNmN3EwAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 30 Sep 2022 06:29:54 +0000
Message-ID: <04bf1cdd-3093-99c8-3aff-32ed3278c805@suse.de>
Date: Fri, 30 Sep 2022 08:29:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme-multipath: fix possible hang in live ns resize with
 ANA access
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Yogev Cohen <yogev@lightbitslabs.com>
References: <20220928135816.132213-1-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220928135816.132213-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_233002_557648_190B98A2 
X-CRM114-Status: GOOD (  31.04  )
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

On 9/28/22 15:58, Sagi Grimberg wrote:
> When we revalidate paths as part of ns size change (as of commit e7d65803e2bb),
> it is possible that during the path revalidation, the only paths that is IO
> capable (i.e. optimized/non-optimized) are the ones that ns resize was not yet
> informed to the host, which will cause inflight requests to be requeued (as we
> have available paths but none are IO capable). These requests on the requeue
> list are waiting for someone to resubmit them at some point.
> 
> The IO capable paths will eventually notify the ns resize change to the
> host, but there is nothing that will kick the requeue list to resubmit the
> queued requests.
> 
> Fix this by always kicking the requeue list, and if no IO capable path exists,
> these requests will be queued again.
> 
> A typical log that indicates that IOs are requeued:
> --
> nvme nvme1: creating 4 I/O queues.
> nvme nvme1: new ctrl: "testnqn1"
> nvme nvme2: creating 4 I/O queues.
> nvme nvme2: mapped 4/0/0 default/read/poll queues.
> nvme nvme2: new ctrl: NQN "testnqn1", addr 127.0.0.1:8009
> nvme nvme1: rescanning namespaces.
> nvme1n1: detected capacity change from 2097152 to 4194304
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> nvme nvme2: rescanning namespaces.
> --
> 
> Reported-by: Yogev Cohen <yogev@lightbitslabs.com>
> Fixes: e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> I was easily capable to reproduce this regression with a small debug patch to nvmet
> to have a 1 second delay between controller AENs:
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
>   #include "trace.h"
>   
>   #include "nvmet.h"
> +#include <linux/delay.h>
>   
>   struct workqueue_struct *buffered_io_wq;
>   struct workqueue_struct *zbd_wq;
> @@ -248,6 +249,7 @@ void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid)
>                  nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
>                                  NVME_AER_NOTICE_NS_CHANGED,
>                                  NVME_LOG_CHANGED_NS);
> +               msleep(1000);
>          }
>   }
> 
> And expose a subsystem via two ports, one ANA 'optimized', and one ANA 'inaccessible'.
> 
> Then test file-backed ns resize duing I/O:
> truncate --size=2G /tmp/f && echo 1 > /sys/kernel/config/nvmet/subsystems/testnqn1/namespaces/1/revalidate_size
> 
>   drivers/nvme/host/multipath.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 6ef497c75a16..d532a78f24a2 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -172,16 +172,18 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
>   void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
>   {
>   	struct nvme_ns_head *head = ns->head;
> +	struct nvme_ns *n;
>   	sector_t capacity = get_capacity(head->disk);
>   	int node;
>   
> -	list_for_each_entry_rcu(ns, &head->list, siblings) {
> -		if (capacity != get_capacity(ns->disk))
> -			clear_bit(NVME_NS_READY, &ns->flags);
> +	list_for_each_entry_rcu(n, &head->list, siblings) {
> +		if (capacity != get_capacity(n->disk))
> +			clear_bit(NVME_NS_READY, &n->flags);
>   	}
>   
>   	for_each_node(node)
>   		rcu_assign_pointer(head->current_path[node], NULL);
> +	nvme_kick_requeue_lists(ns->ctrl);
>   }
>   
>   static bool nvme_path_is_disabled(struct nvme_ns *ns)

Hmm. I guess the real issue is that we use 'ns' as both function 
argument _and_ iterator, so that after 'list_for_each_rcu()' 'ns' is 
pointing to a _different_ namespace, such that we end up kicking that 
namespace and not the one used as argument.
But in either case, patch is fine.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


