Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E76C35FF3
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 11:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/WpjUHUtGdaDqbnmCpkWrWmAJhxJemIw0zzHySCAVxk=; b=xdRyRGFPd7qWlTmFdd9iESc8jv
	DU8T3p0FJFo5fE68Gr90OkPpo6L83z1qa5I/cR6biIs+fDCgNvzQsAe9LPmz+ALlu3f0nd/At6bxp
	OORRCILSUPmku/XP8RqKklfVREDP1eJVJdMDcmq6/XYFZPWcHRP/xo7RFs0EzYxGBp+/JjqJVEfvw
	4X4kqcEoJOZmgtel+8yhLERfO+6aUISszxqEBcV87ZL3p0bj1jY1bb7xAiLv0/NX7ilns+/OxfyzL
	8IME1R26suFkJyzqRTRWg5mwGPw7zK6NkDax3+iOXTjOSC23TLS9Dc/E3dHEQUNtPbn7yTgImRZnM
	YXSNAl9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUuj-00000005fpc-2aMg;
	Tue, 18 Mar 2025 11:15:17 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUnV-00000005eGT-2FZQ
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 11:07:50 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E188E1F770;
	Tue, 18 Mar 2025 11:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/WpjUHUtGdaDqbnmCpkWrWmAJhxJemIw0zzHySCAVxk=;
	b=m40XapsnikFlOpmcZd1nDvPnTaNVcn6Or81ILt5UvXWQOh+kOVsziu1tPE7owvkVfskAYS
	3216+OHXlcWIpcuJf18QViCAXzJkWmCVoQGanqPOUQV8PkRaalT+3cFD3m5OXfn5m2sHmf
	oGqlHmKMXrn3bCi1UsK6PEP4J6AwD24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/WpjUHUtGdaDqbnmCpkWrWmAJhxJemIw0zzHySCAVxk=;
	b=68Du1+8ECHI9kHYmAQHBci5PBIRwxFPoq5W8rm1iZmq9WRW2kOKXvbdsUz+7V6z3ANntg1
	O4MvBR1BApWpyeBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ifrQOdj2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RB8Ytt3e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/WpjUHUtGdaDqbnmCpkWrWmAJhxJemIw0zzHySCAVxk=;
	b=ifrQOdj2bz6QW+/4WJ9l0MjEXf5LRAcBx5/vMR11F0aN6vjb6+EsTOfsuagi1ZskZARWlW
	cildu01vpICOu3AZGf/rJ5kxO7769bjEAABLdtI74f/t0+gB21u5csxmjE5WIko2gipKR4
	n15oBsj+kRI9cnLIOzzUWD1+jVKryQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/WpjUHUtGdaDqbnmCpkWrWmAJhxJemIw0zzHySCAVxk=;
	b=RB8Ytt3eHePj/YQTrU1QXK0FENQF+GGzdiZ/eQf4VxYdmK40VREH9OQ7qs0HPBUwlucaBA
	RgOklbMXqxQFuGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8E5C139D2;
	Tue, 18 Mar 2025 11:07:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mReKMANU2WdeRAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 11:07:47 +0000
Message-ID: <f1083a89-44af-4bce-ab09-4260f727a551@suse.de>
Date: Tue, 18 Mar 2025 12:07:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/18] nvmet-fcloop: sync targetport removal
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-6-05fec0fc02f6@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250318-nvmet-fcloop-v3-6-05fec0fc02f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E188E1F770
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_040749_727718_BC7AF3B4 
X-CRM114-Status: GOOD (  19.83  )
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

On 3/18/25 11:40, Daniel Wagner wrote:
> The nvmet-fc uses references on the targetport to ensure no UAFs
> happens. The consequence is that when the targetport is unregistered,
> not all resources are freed immediately. Ensure that all activities from
> the unregister call have been submitted (deassocication) before
> continuing with the shutdown sequence.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 69121a5f0f280936d1b720e9e994d6e5eb9186ff..cddaa424bb3ff62156cef14c787fdcb33c15d76e 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -239,6 +239,7 @@ struct fcloop_nport {
>   	struct fcloop_rport *rport;
>   	struct fcloop_tport *tport;
>   	struct fcloop_lport *lport;
> +	struct completion tport_unreg_done;
>   	struct list_head nport_list;
>   	refcount_t ref;
>   	u64 node_name;
> @@ -1078,6 +1079,8 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
>   	tport->nport->tport = NULL;
>   	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
> +	complete(&tport->nport->tport_unreg_done);
> +
>   	/* nport ref put: tport */
>   	fcloop_nport_put(tport->nport);
>   }
> @@ -1507,7 +1510,17 @@ __unlink_target_port(struct fcloop_nport *nport)
>   static int
>   __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
>   {
> -	return nvmet_fc_unregister_targetport(tport->targetport);
> +	int ret;
> +
> +	init_completion(&nport->tport_unreg_done);
> +
> +	ret = nvmet_fc_unregister_targetport(tport->targetport);
> +	if (ret)
> +		return ret;
> +
> +	wait_for_completion(&nport->tport_unreg_done);
> +
> +	return 0;
>   }
>   
>   static ssize_t
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

