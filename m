Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD343C982DA
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 14:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BleJq0FkWjt2JcfDoXl8F0KBGAYihvq69cFS6QlVA0g=; b=mWD6gwfHFyKzfjbWLYe/6ZPpGt
	WaCKTiXTzkLTebsUJ8qHe2MDhDH+mD9K7ule7b8HD7c3Vy//K71VlKjCOGx1JoZAKwqK5NKBLTpbD
	hhyvTnh/k0j4c++zUrC2NVAndlkdez5j5xa6ieGeOwbqj+yyJMDALUyFYv3/MmZ88kkU5xHJ330EX
	z5RQAkCnVvqiYFfE6IsyVSLu+YsIw9YpmPNmgPOQHq/UddwuPTT6EbeY3oYFjNJv0D3aoNH3WKl5I
	SzxqsCJyJuJBwxvGH/BiOaopA2Ux6frea7EOhNRE0SLYUZCI/I+hxng2Zyi9o9menhdTnTpH5J9Og
	sYisf6YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Zyr-0000000EnUD-31vB;
	Fri, 18 Sep 2026 14:54:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Zyr-0000000EnTs-0NrB
	for linux-nvme@bombadil.infradead.org;
	Fri, 18 Sep 2026 14:54:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=BleJq0FkWjt2JcfDoXl8F0KBGAYihvq69cFS6QlVA0g=; b=KRsjEQvqwsElsLnVg1maeYPNID
	Bm5uL+BUgkn0bsg78WgmhzZT3Kq22Wkf5HS6tUv0VpusuJde83j+ndwFdu73a9q7TtqX+Uugj6H/X
	ojGwCqfEvpt4Q+rXYy5emdbNPLaNEkN6x8Jt9LsCqEeA4JLtjfllH2CRmgNZjV9AFphMrN8zhC0/b
	1T25ILjD819fRb5PR+8pUMvjL//5Fr9EH7D10+5Dvp1Yllv5Rh1uDB2SZK/3jXJghCQTGNus3mEDR
	jPTFE3P9PWrUWxvdkvI+KR5aA/E/IRlA9qJyzXq0H8q2DMuEvUlEjQ7NiTVEAsCBFfKFfrRvq+0md
	zjo9egJQ==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7Zyn-0000000AEWp-4Bk9
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 14:54:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4639C21E1C;
	Fri, 18 Sep 2026 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789743256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BleJq0FkWjt2JcfDoXl8F0KBGAYihvq69cFS6QlVA0g=;
	b=vY25j489fPSLyrJqMRToMfUZOpND1h6i1OXsS7bxD0/TzGajrAVXKMwox4UnKbUp/7hV0D
	k353Vwg+rKYPsZZ0HyeGIZVLp3Tlf/rTaRg9eqfjzvaykIGWfl+ibNMMpaQkCvI5VsocM9
	5igOZsGGHgm5bT9l8caBTXV7ehixu1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789743256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BleJq0FkWjt2JcfDoXl8F0KBGAYihvq69cFS6QlVA0g=;
	b=RDc2qh02bdgiUSSM/VQX+fhGb+ol3C0OnzDbRONBgoonOufCTAJJwAkAfnjBnl2P7qlTrE
	ycwfvhsE/1p8pACQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eDduRdzO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SMcpi8Tv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789743252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BleJq0FkWjt2JcfDoXl8F0KBGAYihvq69cFS6QlVA0g=;
	b=eDduRdzOMzqNZRFR1tX4qdOoPN6tJon1pNHWqEHnkDzho6MoYSZphZ/eY3A1/tjEvgwIQH
	LgUTZSQuQqiXtT5yu71rUS68DagprmHPhnrgeU6bXYz1uObQcCZjuyDGI/BLpNrYX00ssy
	01sZHS0qMoG4BWg53LGhgjnXYTbzsYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789743252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BleJq0FkWjt2JcfDoXl8F0KBGAYihvq69cFS6QlVA0g=;
	b=SMcpi8Tv/FjiHe/pzYn3zmFfCYcJb7I34P3Zv/DyFNgYGq/8iGuR6V63ZcGF+29S+4bgwV
	BsSYRmxxVwDNqFCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E157F13927;
	Fri, 18 Sep 2026 14:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9V/DLZNQrWrnGAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 18 Sep 2026 14:54:11 +0000
Message-ID: <b6f243bc-68a8-4db8-973c-df0c0f5171d9@suse.de>
Date: Fri, 18 Sep 2026 16:54:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: copy the hostid into the ctrl before creating PR
 pc_refs
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>, John Garry <john.g.garry@oracle.com>
Cc: linux-nvme@lists.infradead.org
References: <20260916114254.335277-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260916114254.335277-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4639C21E1C
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_155422_330209_5F3DAEFF 
X-CRM114-Status: GOOD (  20.44  )
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

On 9/16/26 1:42 PM, Guixin Liu wrote:
> Commit 6202783184bf ("nvmet: Improve nvmet_alloc_ctrl() interface and
> implementation") added a second uuid_copy() of args->hostid near the end
> of nvmet_alloc_ctrl(), and commit 7b658153f1b8 ("nvmet: Remove duplicate
> uuid_copy") removed the original copy that sat before
> nvmet_ctrl_init_pr() instead of the new one.
> 
> Since then nvmet_ctrl_init_pr() snapshots ctrl->hostid into the
> per-controller per-namespace reservation refs while the uuid_copy()
> from the connect data runs later, after the controller is published.
> The ctrl is allocated with kzalloc(), so every pc_ref created on this
> path stores the nil UUID.
> 
> pc_ref->hostid has a single consumer: nvmet_pr_set_ctrl_to_abort()
> matches it against the preempted registrant's hostid to kill and drain
> the victim's in-flight I/O for Preempt and Abort.  The match can never
> hit with the nil UUID, so whenever a namespace with reservations
> enabled exists before a host connects, which includes every reconnect,
> Preempt and Abort silently degrades into a plain Preempt: the
> preempting host sees success while the victim's in-flight I/O is still
> in the air.
> 
> Copy the hostid where the rest of the connect data is consumed, before
> the controller is published and before nvmet_ctrl_init_pr() takes its
> snapshot.
> 
> Fixes: 7b658153f1b8 ("nvmet: Remove duplicate uuid_copy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/target/core.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 43871a8f56ca..8c8c8627871f 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1648,6 +1648,8 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>   	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
>   
>   	memcpy(ctrl->hostnqn, args->hostnqn, NVMF_NQN_SIZE);
> +	if (args->hostid)
> +		uuid_copy(&ctrl->hostid, args->hostid);
>   
>   	kref_init(&ctrl->ref);
>   	ctrl->subsys = subsys;
> @@ -1706,9 +1708,6 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>   
>   	nvmet_start_keep_alive_timer(ctrl);
>   
> -	if (args->hostid)
> -		uuid_copy(&ctrl->hostid, args->hostid);
> -
>   	dhchap_status = nvmet_setup_auth(ctrl, args->sq, false);
>   	if (dhchap_status) {
>   		pr_err("Failed to setup authentication, dhchap status %u\n",
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

