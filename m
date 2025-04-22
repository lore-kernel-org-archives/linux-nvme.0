Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094AFC369CB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 06:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jtTQsrLtsZ7OF/btKwG2Dj7cAGJGluRT/IJs+JKd368=; b=Q0DGz31dSfww+rEbcdlr75al4N
	son68XzdQJ/wJ3vucnS+e39wRBqMrKDdjjT+YpG1BVTySNJufCJxFrSCLSfWf3zDoQG9Qw6pzp/bK
	bmdNsvU0Y1H5h+iGK8W0cqgk8hYYyK3mhr4S6fgMWZaIaHdFZ4m6GDdP7EM0/8Ji/CyWuvM5X66hQ
	dvYz7rCc2iUMen77k3Nh5agpcJmwP7KNML/MrV1ZN16ASsH9bTWvyeh7H3SwfjAziQVg0v7Tixl9Y
	Uq/BBw94KPIGHe/FJ8VzxNw2ewf4lqJqFEZT1wf3kdMknzMnLsVDceoe+FLVaCE1S2QReKPUB++aK
	a5lNEJZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u77AM-00000005xwW-1TnI;
	Tue, 22 Apr 2025 06:31:34 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u775Q-00000005wzj-2oPT
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 06:26:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C77CC1F7C1;
	Tue, 22 Apr 2025 06:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745303187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtTQsrLtsZ7OF/btKwG2Dj7cAGJGluRT/IJs+JKd368=;
	b=iiEYSO57TaBWuFLOkI6VKkXuJZm0bOWXShK/cGB+qgk2/EoHYqJatm/2xaXvHk1mCD8MBS
	6y6Gzd/CILKkHBZFhinZ+105I8wgkTDTWRm02SzdU8GgfLd+fFP4NsTAw1rnn2gAFPEpK7
	UKYsnGskOQ9V10vt6pKlj9z+OvZTTKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745303187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtTQsrLtsZ7OF/btKwG2Dj7cAGJGluRT/IJs+JKd368=;
	b=6rf7Pf2NiRQ+cWXQ6GyWIHIIxR5J4NaO57oC07L5rsmRe5dCa6iwEIUqIcKDoHgSn02MQM
	MOoWECZBPN9s/oAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745303185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtTQsrLtsZ7OF/btKwG2Dj7cAGJGluRT/IJs+JKd368=;
	b=eeiZx1roVhZP7GgU+NJW8cDgZIP3kZfKkyeKHkrg8AP4CQ8ieaWSWIGED3j/oXwHP7kN3E
	zbxaxflhW1Ll3mtoPOlc7Ww3/14Q1rXp6So7jLnZEK4CLrKEb1IoEdg1NcvJ8DY47bXy+g
	xPSTrOkUk+sG7UOpdWqQ1HNN7kja3UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745303185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtTQsrLtsZ7OF/btKwG2Dj7cAGJGluRT/IJs+JKd368=;
	b=x7cYFdzDzebbOf50mAKkHUTSChUVwsm2MovayWfRygOdF/ofk2HSWBkXtSCCtAITd+20gs
	HCOvjLpshX2D2bBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7883C137CF;
	Tue, 22 Apr 2025 06:26:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rgtfG5E2B2gvKAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Apr 2025 06:26:25 +0000
Message-ID: <0e70314a-3c08-40ab-ac53-e9fb7e379f44@suse.de>
Date: Tue, 22 Apr 2025 08:26:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] tree: add queue-depth attribute for nvme path
 object
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
References: <20250417135951.239447-1-nilay@linux.ibm.com>
 <20250417135951.239447-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250417135951.239447-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,libnvme.map:url,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_232628_862070_39C796D7 
X-CRM114-Status: GOOD (  23.16  )
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

On 4/17/25 15:59, Nilay Shroff wrote:
> Add a new attribute named "queue_depth" under the NVMe path object. This
> attribute is used by the iopolicy "queue-depth", which was introduced in
> kernel v6.11. However, the corresponding sysfs attribute for queue depth
> was only added in kernel v6.14.
> 
> The queue_depth value can be useful for observing which paths are selected
> for I/O forwarding, based on the depth of each path. To support this,
> export the attribute in libnvme.map so it can be accessed via nvme-cli.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   src/libnvme.map    |  1 +
>   src/nvme/private.h |  1 +
>   src/nvme/tree.c    | 12 +++++++++++-
>   src/nvme/tree.h    |  8 ++++++++
>   4 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/src/libnvme.map b/src/libnvme.map
> index 4314705f..e53fad6b 100644
> --- a/src/libnvme.map
> +++ b/src/libnvme.map
> @@ -317,6 +317,7 @@ LIBNVME_1_0 {
>   		nvme_path_get_ctrl;
>   		nvme_path_get_name;
>   		nvme_path_get_ns;
> +		nvme_path_get_queue_depth;
>   		nvme_path_get_sysfs_dir;
>   		nvme_paths_filter;
>   		nvme_read_config;
> diff --git a/src/nvme/private.h b/src/nvme/private.h
> index f45c5823..f94276e2 100644
> --- a/src/nvme/private.h
> +++ b/src/nvme/private.h
> @@ -34,6 +34,7 @@ struct nvme_path {
>   	char *sysfs_dir;
>   	char *ana_state;
>   	int grpid;
> +	int queue_depth;
>   };
>   
>   struct nvme_ns_head {
> diff --git a/src/nvme/tree.c b/src/nvme/tree.c
> index bd7fb53e..b7a38a07 100644
> --- a/src/nvme/tree.c
> +++ b/src/nvme/tree.c
> @@ -903,6 +903,11 @@ const char *nvme_path_get_name(nvme_path_t p)
>   	return p->name;
>   }
>   
> +int nvme_path_get_queue_depth(nvme_path_t p)
> +{
> +	return p->queue_depth;
> +}
> +
>   const char *nvme_path_get_ana_state(nvme_path_t p)
>   {
>   	return p->ana_state;
> @@ -921,7 +926,7 @@ void nvme_free_path(struct nvme_path *p)
>   static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
>   {
>   	struct nvme_path *p;
> -	_cleanup_free_ char *path = NULL, *grpid = NULL;
> +	_cleanup_free_ char *path = NULL, *grpid = NULL, *queue_depth = NULL;
>   	int ret;
>   
>   	nvme_msg(r, LOG_DEBUG, "scan controller %s path %s\n",
> @@ -955,6 +960,11 @@ static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
>   		sscanf(grpid, "%d", &p->grpid);
>   	}
>   
> +	queue_depth = nvme_get_path_attr(p, "queue_depth");
> +	if (queue_depth) {
> +		sscanf(queue_depth, "%d", &p->queue_depth);
> +	}
> +
>   	list_node_init(&p->nentry);
>   	list_node_init(&p->entry);
>   	list_add_tail(&c->paths, &p->entry);
> diff --git a/src/nvme/tree.h b/src/nvme/tree.h
> index 9f382e9c..a9082f8e 100644
> --- a/src/nvme/tree.h
> +++ b/src/nvme/tree.h
> @@ -867,6 +867,14 @@ const char *nvme_path_get_sysfs_dir(nvme_path_t p);
>    */
>   const char *nvme_path_get_ana_state(nvme_path_t p);
>   
> +/**
> + * nvme_path_get_queue_depth() - Queue depth of an nvme_path_t object
> + * @p: &nvme_path_t object
> + *
> + * Return: Queue depth of @p
> + */
> +int nvme_path_get_queue_depth(nvme_path_t p);
> +
>   /**
>    * nvme_path_get_ctrl() - Parent controller of an nvme_path_t object
>    * @p:	&nvme_path_t object

As discussed: saving the 'queue_depth' attribute is a bad idea, as it
changes frequently.
I'd rather read the attribute value from sysfs whenever
'nvme_path_get_queue_depth' is called, and use the tree structure only
to hold the pathname.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

