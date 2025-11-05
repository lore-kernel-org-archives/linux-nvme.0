Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB35CCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 07:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IJ1kJ8/X67BqbRNEuACky2u8dNYeauIx2mfaDk8cEDw=; b=gyqXFEgFGwdSgpIBxwkIrFuHVa
	HjUepqIWD4S+6rLP2KR822jDImnhIEIsf0ir/JsZ2oT5js0KcsfCso5mZtOtpDjkdA2QtURBGnziC
	0vKm6sGncKZsFZU2c6wa49A5ALBj4xECEEY0YBLOUHbJ1HfSuxtoQcyZe6asE7bL50P6WqZWQ7Saj
	M5+XxAeOWxQGd2WLd+OfHBXObrX6EepHYg23NeU6sQQTPyV64rOr2TRzQq1EHQ4oqMHDAuldhNIwt
	yyT+GgZ2EK3tXI36b7+0gXbxWBya/kODvp9xl7801eO8JO76k/sF8JrjHrJ9nxHjfzccWEO57oRRJ
	Db9njjBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGY0J-0000000DCb7-40n7;
	Wed, 05 Nov 2025 07:32:27 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGY0G-0000000DCaj-3tzr
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 07:32:26 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0935E21196;
	Wed,  5 Nov 2025 07:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762327943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJ1kJ8/X67BqbRNEuACky2u8dNYeauIx2mfaDk8cEDw=;
	b=QwERnR/9R/Ea4QAemTDAEotKkfaRaNGNh6rzOWdwuycm/Hisyb7oBu8d2N1HZeP6dgWUbg
	M7ecNTZBfzjQRaYQG2vhv9/oOUOVN1cPvL6LkxokDuirk+ovYmFSxwktmDfiEIkOdtGSWf
	6+zqiX4uciOQ1U3TiPf3/AVGGgmpdKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762327943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJ1kJ8/X67BqbRNEuACky2u8dNYeauIx2mfaDk8cEDw=;
	b=kM9VpkTHm3JzAwJQYjcFoBsqHUwP6qpPwJQMq/RROoruvy3QtCJ4UMM6gjH7YvXai/5vSZ
	tQNBsGQFWXokNxBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="QwERnR/9";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kM9VpkTH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762327943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJ1kJ8/X67BqbRNEuACky2u8dNYeauIx2mfaDk8cEDw=;
	b=QwERnR/9R/Ea4QAemTDAEotKkfaRaNGNh6rzOWdwuycm/Hisyb7oBu8d2N1HZeP6dgWUbg
	M7ecNTZBfzjQRaYQG2vhv9/oOUOVN1cPvL6LkxokDuirk+ovYmFSxwktmDfiEIkOdtGSWf
	6+zqiX4uciOQ1U3TiPf3/AVGGgmpdKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762327943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJ1kJ8/X67BqbRNEuACky2u8dNYeauIx2mfaDk8cEDw=;
	b=kM9VpkTHm3JzAwJQYjcFoBsqHUwP6qpPwJQMq/RROoruvy3QtCJ4UMM6gjH7YvXai/5vSZ
	tQNBsGQFWXokNxBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEBAB132DD;
	Wed,  5 Nov 2025 07:32:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DS7RK4b9CmkjKQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:32:22 +0000
Message-ID: <3cd818bb-1820-4a22-ac2a-99c38c519583@suse.de>
Date: Wed, 5 Nov 2025 08:32:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix lockdep WARN due to partition scan
 work
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
 Yi Zhang <yi.zhang@redhat.com>
References: <20251023001937.218014-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251023001937.218014-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0935E21196
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_233225_138918_66ACA798 
X-CRM114-Status: GOOD (  15.13  )
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

On 10/23/25 02:19, Shin'ichiro Kawasaki wrote:
> Blktests test cases nvme/014, 057 and 058 fail occasionally due to a
> lockdep WARN. As reported in the Closes tag URL, the WARN indicates that
> a deadlock can happen due to the dependency among disk->open_mutex,
> kblockd workqueue completion and partition_scan_work completion.
> 
> To avoid the lockdep WARN and the potential deadlock, cut the dependency
> by running the partition_scan_work not by kblockd workqueue but by
> nvme_wq.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/linux-block/CAHj4cs8mJ+R_GmQm9R8ebResKAWUE8kF5+_WVg0v8zndmqd6BQ@mail.gmail.com/
> Link: https://lore.kernel.org/linux-block/oeyzci6ffshpukpfqgztsdeke5ost5hzsuz4rrsjfmvpqcevax@5nhnwbkzbrpa/
> Fixes: 1f021341eef4 ("nvme-multipath: defer partition scanning")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   drivers/nvme/host/multipath.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 543e17aead12..e35eccacee8c 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -793,7 +793,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>   			return;
>   		}
>   		nvme_add_ns_head_cdev(head);
> -		kblockd_schedule_work(&head->partition_scan_work);
> +		queue_work(nvme_wq, &head->partition_scan_work);
>   	}
>   
>   	nvme_mpath_add_sysfs_link(ns->head);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

