Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460E606A325
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dceXMSc3;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HhLm2d6W;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4bH/HafF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HhLm2d6W;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4bH/HafF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=x5lhyeWppTmeVCGlG4TUa8XBfP0xo9dqljDJjmh0tBg=; b=dceXMSc31+viK4
	5MQK7FkvhiULg71a2PRdIfYVIEXdZNj193JM5plvAJdWSREhp/EeTgEkTCzeAFUx62TmSJ0/cADa5
	C/5TmpfAlGB8WvAQ2Mr476GCq76wLRbREZS422dQHKnqrQ/1TrUf2BVdHWLfDo9RZ8s5ogn1DyBMp
	xB9rmLuZlsuiisVZcFnqNQUW9LP26WZXxiheQVD5VaTRLp62qFTAVj81YHSvW19s0UuSribCeJgLL
	qYhCwrXIUoSqPZADZqFHmwTbCAn945jGiJxACabKccLQdM+KVJudkqi7/9FBcBTODhlT/zoI6ydzl
	+lLhwtKix77wE5pCyxRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQkkY-00000003mZB-0n0x;
	Tue, 10 Nov 2026 12:14:54 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQkkS-00000003mYl-11kf
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 12:14:49 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63C4521EFE;
	Tue, 10 Nov 2026 12:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794312886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x5lhyeWppTmeVCGlG4TUa8XBfP0xo9dqljDJjmh0tBg=;
	b=HhLm2d6WOaEowFf+lsUkANYhFaK1ZQe0ijH5djJ8h6/9gKbCquDO5wmMDiHAPfJnpzgWmb
	Y/8siuCSGcEx+umUqFehsSFlqJLEIsQS3B8x80TlFuDUPVRA7TRyt2z3Xc89O+OCM2+AmO
	e0Vvq4039GbsKuu6Shx9GnMPQPseLo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794312886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x5lhyeWppTmeVCGlG4TUa8XBfP0xo9dqljDJjmh0tBg=;
	b=4bH/HafFA617tLEn+gF04fUTbZCJU2rOnbzLv2Fw89+q1C+ZNf0fBN+1QpI4Te26b3Q1uM
	FFfbnw0phxiLaKBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794312886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x5lhyeWppTmeVCGlG4TUa8XBfP0xo9dqljDJjmh0tBg=;
	b=HhLm2d6WOaEowFf+lsUkANYhFaK1ZQe0ijH5djJ8h6/9gKbCquDO5wmMDiHAPfJnpzgWmb
	Y/8siuCSGcEx+umUqFehsSFlqJLEIsQS3B8x80TlFuDUPVRA7TRyt2z3Xc89O+OCM2+AmO
	e0Vvq4039GbsKuu6Shx9GnMPQPseLo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794312886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x5lhyeWppTmeVCGlG4TUa8XBfP0xo9dqljDJjmh0tBg=;
	b=4bH/HafFA617tLEn+gF04fUTbZCJU2rOnbzLv2Fw89+q1C+ZNf0fBN+1QpI4Te26b3Q1uM
	FFfbnw0phxiLaKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B76113479;
	Tue, 10 Nov 2026 12:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HuGhAbYK82onGQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 10 Nov 2026 12:14:46 +0000
Message-ID: <4ff74c54-7478-4ea5-9e26-32101acd4556@suse.de>
Date: Tue, 10 Nov 2026 13:14:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: synchronize DH-CHAP secret removal
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>, hare@kernel.org,
 hch@lst.de, kbusch@kernel.org, kch@nvidia.com, sagi@grimberg.me
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20261110075733.2578-1-sreekuttan2156239@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261110075733.2578-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lst.de,nvidia.com,grimberg.me];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_041448_430106_0670B96B 
X-CRM114-Status: GOOD (  14.81  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 8:57 AM, Sreeraj S Kurup wrote:
> The empty-secret path in nvmet_auth_set_key() modifies and frees
> host authentication secrets without holding nvmet_config_sem.
> 
> nvmet_setup_auth() accesses these fields under the read lock,
> allowing concurrent secret removal to cause a use-after-free.
> 
> Acquire nvmet_config_sem for writing while clearing the secrets
> to synchronize with authentication setup.
> 
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
> ---
>   drivers/nvme/target/auth.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index ccba84b1344e..8fe521690ccd 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -26,6 +26,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
>   	char *dhchap_secret;
>   
>   	if (!strlen(secret)) {
> +		down_write(&nvmet_config_sem);
>   		if (set_ctrl) {
>   			kfree(host->dhchap_ctrl_secret);
>   			host->dhchap_ctrl_secret = NULL;
> @@ -35,6 +36,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
>   			host->dhchap_secret = NULL;
>   			host->dhchap_key_hash = 0;
>   		}
> +		up_write(&nvmet_config_sem);
>   		return 0;
>   	}
>   	if (sscanf(secret, "DHHC-1:%hhd:%*s", &key_hash) != 1)

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

