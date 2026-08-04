Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E9BC55172
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 07:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=shKaookRfRu+nQIQQzmOQrlMnbvNyLPqYee+G1JJaXw=; b=AdOxLVsU+r8xjme1yMoT7Wgyp3
	7yrJD7VtYF4JWGF14YKL9KncmCuAwM/8NeVkSoJ7wUW7DhiXgxdi2w3oSkCWyAQg8g3fnfjywyKE4
	5dfwiJktrwk0oxv5n+xaVbkJYalFZQP6D+R1PuUwSkNn9uWyT6oaDSWa8PH55DWFrcFuTGsSgDyql
	7ow6bdkZi1CzeYG/5F+ZYT7PEPO+cHVT7C/wa8OpzItbdH3Htt7SuDde1nAyTsA4r4DBy4ZaDhZhY
	xhdRIvoDcvR/yVCqTfOjdARUjr8KJAPt+fnas84LZdwGwz0oSCGatFe2B46WT9d2VBp/8Cu9JQPsn
	QeQ1A29Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr9dp-00000001FAw-1oR5;
	Tue, 04 Aug 2026 07:32:49 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr9dn-00000001FAW-0iva
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 07:32:49 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 276A37F5FF;
	Tue,  4 Aug 2026 07:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785828761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shKaookRfRu+nQIQQzmOQrlMnbvNyLPqYee+G1JJaXw=;
	b=0ObQ1lGwkb6bttJ5yJXYI0nVDqp4oNa4PeJVb9DVDLlzz5a5nVInBCaoERGDnALfqaPcCl
	+KXyeR21CUX/M7iuGO5Aho5S04Ab7ajJE667EPaTwdxm1g+YPSTfS3sW2Wn/GXDB/ujDbb
	s9WLMQFT4+wJHw7DQb9okmS3QFuacLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785828761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shKaookRfRu+nQIQQzmOQrlMnbvNyLPqYee+G1JJaXw=;
	b=HD12m3IYjvJXW6ah279xBlXbX1N9bF4SKjc+GFBDMwEW5HVB5S1JaBGES6503hXmqGpaHZ
	1z4xv609nRR9gjCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uLUqpDMh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KXuFWjcy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785828757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shKaookRfRu+nQIQQzmOQrlMnbvNyLPqYee+G1JJaXw=;
	b=uLUqpDMh9vK/MQpP3kT7Zv0ylO2AlofbYQ928F7r9l8rKSx9UF0wVv56EAAQd+DMdvlrBT
	NyjQ8R+YxjsON4NpSETrzYD+Ki/R4y/H8KN/kT0r2yejOJ37W5bgakAqCdUCu6XVsXpn4O
	7+p/o/HmTzdkK89AGJPa0VLnqhiG4VU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785828757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shKaookRfRu+nQIQQzmOQrlMnbvNyLPqYee+G1JJaXw=;
	b=KXuFWjcysbNCx2lZzwOe5h9B1uBkFOx+aQcOjSM6NS2mjfNOnDjcAaSxhEqq82Y2wMX6uD
	/WoK87GXBtqh/1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08924779BB;
	Tue,  4 Aug 2026 07:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8myYAZWVcWrcIwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Aug 2026 07:32:37 +0000
Message-ID: <f3d9c846-99ba-44f5-a18a-aed555fbfbdb@suse.de>
Date: Tue, 4 Aug 2026 09:32:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme/070: add a test for Identify CNS 07h NULL pointer
 dereference
To: Guixin Liu <kanie@linux.alibaba.com>, shinichiro.kawasaki@wdc.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 nilay@linux.ibm.com, Chaitanya Kulkarni <kch@nvidia.com>,
 Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-nvme@lists.infradead.org
References: <20260804024644.3830277-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260804024644.3830277-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[alibaba.com:email,suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 276A37F5FF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_003247_534593_B4D06B39 
X-CRM114-Status: GOOD (  15.48  )
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

On 8/4/26 4:46 AM, Guixin Liu wrote:
> nvmet_execute_identify_nslist() handles both the Active Namespace ID list
> (CNS 02h) and the per-command-set variant (CNS 07h). For CNS 07h it
> filtered the list on req->ns->csi, but this handler never resolves
> req->ns, so it is always NULL. As soon as an enabled namespace with an
> NSID above the requested value exists, the target dereferenced a NULL
> pointer and oopsed.
> 
> This test connects a target with a single namespace and issues an
> Identify with CNS 07h starting from NSID 0, which is exactly the
> condition that triggered the crash. Without the kernel fix [0] the target
> oopses; with it the command completes normally.
> 
> [0] https://lore.kernel.org/linux-nvme/20260730043105.3071328-2-kanie@linux.alibaba.com/
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> v1 -> v2:
>    - Use "nvme list-ns --csi=0" instead of a raw admin-passthru to issue
>      Identify CNS 07h, as suggested by Nilay and Shinichiro; it drives the
>      same target code path via the existing nvme-cli subcommand.
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

