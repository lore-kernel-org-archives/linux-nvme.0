Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE36C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9g8WnlNJK4bbjsUS0dRJlx+RUu0vmNl6QqPosUTuClE=; b=K8d7YZSeYDIA5IDwtoLgxAwybC
	IcvODnaj+w8DVRKODKsXCmmRYZVbB2CHhlQyeOJIPcEgE79dR8R03tGvHfFSEMCZ0VPoosYe4EQey
	ja9yqJQwqLhD+kj/14Zb5ZxkLlHKl911C7m+XtLBSEbYbqHlSQfLyMwFce7CPAJN7bNHws64t2HOK
	vyKSAXPGJZGMuTf3Vup5gCSLwXpR4JdJusH6tMw5QMcSps4qSD95EpJQCUOXdIj9pZBeotoLnt85Y
	Cby47lMkxJHqz+GkLak9VIvB3Q4hpHc3Eb2p6tzqRZnb5xEKpRxzU9FDOFyMqDT8petwQ8ZfKPPPL
	uwy42Pig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osp49-00FeYZ-Vj; Wed, 09 Nov 2022 17:40:45 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osp47-00FeVl-14
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 17:40:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE21422C50;
	Wed,  9 Nov 2022 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1668015641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9g8WnlNJK4bbjsUS0dRJlx+RUu0vmNl6QqPosUTuClE=;
	b=tcufd8tuhn0Toyvri7dv3iveZzvM66BuMlSKXBai67+GVQUfcaD8yvbJ0cdcLZ280MSTpG
	6WJh0zioMpxSX2aOb2QTJoWZi3rOU619j70oX8HwoWcX8KSZp/hLIytWoCK0FhPBju8xTA
	7G6FYwS90/ZXWx+JYvucQqCNcpMbuFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1668015641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9g8WnlNJK4bbjsUS0dRJlx+RUu0vmNl6QqPosUTuClE=;
	b=lKto4Flz8ouMbNhOXFnyH9feR1xYGfkoXlW1Gv1hCixxyuelDXS/JGoiNL7Z6iYvgz/pLG
	Y7LqmInD8rfiX1DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E7AA139F1;
	Wed,  9 Nov 2022 17:40:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WSm2JRnma2OCGQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Nov 2022 17:40:41 +0000
Message-ID: <a0f2868a-26dc-3742-d1e8-8483b637d2dc@suse.de>
Date: Wed, 9 Nov 2022 18:40:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 12/16] nvme-auth: convert dhchap_auth_list to an array
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-13-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221109034420.1000086-13-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_094043_235882_BE6CA71D 
X-CRM114-Status: GOOD (  20.95  )
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

On 11/9/22 04:44, Sagi Grimberg wrote:
> We know exactly how many dhchap contexts we will need, there is no need
> to hold a list that we need to protect with a mutex. Convert to
> a dynamically allocated array. And dhchap_context access state is
> maintained by the chap itself.
> 
> Make dhchap_auth_mutex protect only the ctrl host_key and ctrl_key
> in a fine-graned lock such that there is no long lasting acuisition
> of the lock.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 113 +++++++++++++++++++++------------------
>   drivers/nvme/host/core.c |   4 ++
>   drivers/nvme/host/nvme.h |   2 +-
>   3 files changed, 65 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 23d486284da9..b78e0df54f6c 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -46,6 +46,14 @@ struct nvme_dhchap_queue_context {
>   	(qid == 0) ? 0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED
>   #define nvme_auth_queue_from_qid(ctrl, qid) \
>   	(qid == 0) ? (ctrl)->fabrics_q : (ctrl)->connect_q
> +#define nvme_auth_chap_from_qid(ctrl, qid) \
> +	&((struct nvme_dhchap_queue_context*)(ctrl)->dhchap_ctxs)[qid]
> +#define ctrl_max_dhchaps(ctrl) \
> +	(ctrl)->opts->nr_io_queues + (ctrl)->opts->nr_write_queues + \
> +			(ctrl)->opts->nr_poll_queues + 1
> +#define nvme_foreach_dhchap(i, chap, ctrl) \
> +	for (i = 0, chap = (ctrl)->dhchap_ctxs; \
> +	     i < ctrl_max_dhchaps(ctrl) && chap != NULL; i++, chap++)
>   
>   static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
>   			    void *data, size_t data_len, bool auth_send)

Please use an xarray (cf my patch doing the same).
That leads to far better readable code, and avoid having to do weird casts.

Also, the claim 'we know exactly how many queues' isn't quite true, as 
we only know the _maximum_ number of queues. The controller can (and 
will) decrease this number based on the target configuration.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


