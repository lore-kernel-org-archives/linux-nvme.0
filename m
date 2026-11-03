Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10994606A32D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SbqiSw/1;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zSxcL1io;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UTQ9roF2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zSxcL1io;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UTQ9roF2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=uVfbMmvBz7pvBTdrjpzcHYT3zLJmw9EbDDH1lVuVOEg=; b=SbqiSw/1X2A2pw
	8UogfLZ85V/DfrY88gSYScvHBzu8CkE6CNCcbrI/9E/KrVv9uHy1bcxXHNLKAvYznD3VSLidxy62q
	+ifOXCYRExvKNPvfusY1AwvkDHOL7k+RKNHhHOOTZrjY3ij6YuzpIzCzaftdCSw1Yzetb7+Mk7F69
	zQZbvGbFk4Ba+YTDr3vxG/oVNCntetbkknmB+V4kK+cv+Jb/gzjIDIrYZqutwoGTCVZDiK9VGSIm1
	TKFyO36vUWppcUMRZKjH5cPGhUHLlB/uug5T74WhCQLmJKvafaRmtChhaUoTylNCKVcFalDMOtqyS
	5jks7z91219pflyBDCjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO93N-00000001Ktl-2zQt;
	Tue, 03 Nov 2026 07:35:33 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO93J-00000001Kt7-04K8
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 07:35:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01CDF21FC7;
	Tue,  3 Nov 2026 07:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793691327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVfbMmvBz7pvBTdrjpzcHYT3zLJmw9EbDDH1lVuVOEg=;
	b=zSxcL1iojpUe5ZdrCvindIxiwo/ggMbXdgrcbF+2k/LAwGM8B5guAJFzxbgFBvVUsK9OkT
	pqg5MtjCwVB2LJpACi+phHN7vbCBpJII8HZ87xlUXeS6UIs+G1hhbNMBy4QQLfNPDO72sg
	PSk5glhRTYob+yO+BGrG/6m+BdERxtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793691327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVfbMmvBz7pvBTdrjpzcHYT3zLJmw9EbDDH1lVuVOEg=;
	b=UTQ9roF2y2PxQUzcLRcfNIJ46shaQXncRJkXD6xBaEMB9mKI0Md0WAB9ZlSEf5e02WQfMP
	Daj8jnVUlpAkDKCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zSxcL1io;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UTQ9roF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793691327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVfbMmvBz7pvBTdrjpzcHYT3zLJmw9EbDDH1lVuVOEg=;
	b=zSxcL1iojpUe5ZdrCvindIxiwo/ggMbXdgrcbF+2k/LAwGM8B5guAJFzxbgFBvVUsK9OkT
	pqg5MtjCwVB2LJpACi+phHN7vbCBpJII8HZ87xlUXeS6UIs+G1hhbNMBy4QQLfNPDO72sg
	PSk5glhRTYob+yO+BGrG/6m+BdERxtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793691327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVfbMmvBz7pvBTdrjpzcHYT3zLJmw9EbDDH1lVuVOEg=;
	b=UTQ9roF2y2PxQUzcLRcfNIJ46shaQXncRJkXD6xBaEMB9mKI0Md0WAB9ZlSEf5e02WQfMP
	Daj8jnVUlpAkDKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AA3D134B8;
	Tue,  3 Nov 2026 07:35:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2WcBHr6O6WoaUQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Nov 2026 07:35:26 +0000
Message-ID: <311b1a91-24b0-4864-91c1-6801ca558e2b@suse.de>
Date: Tue, 3 Nov 2026 08:35:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet-auth: reject incomplete DHCHAP messages
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261102132419.2306396-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261102132419.2306396-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01CDF21FC7
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_233529_204137_AD7ACA21 
X-CRM114-Status: GOOD (  17.70  )
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

On 11/2/26 2:24 PM, Jérémy Jean wrote:
> Commit c9359401036e ("nvmet-auth: reject undersized AUTH_SEND
> payloads") only ensures that AUTH_SEND has auth_type and auth_id
> before nvmet_execute_auth_send() starts parsing the payload, but the
> DHCHAP path reads t_id before it verifies message lengths. A two-byte
> DHCHAP NEGOTIATE payload can therefore still trigger an OOB read that
> KASAN reports as:
> 
>    BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_send
>    Read of size 2 at addr ffff8880030d8364
> 
> Require the payload to cover the minimum DHCHAP message length
> before parsing it.
> 
> Fixes: c9359401036e ("nvmet-auth: reject undersized AUTH_SEND payloads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
> 
> Changes in v2:
> - Check the minimum DHCHAP message length.
> 
> v1 (2026-08-11 18:03:35 +0000): https://lore.kernel.org/all/20260811180335.4161138-2-Jeremy.Jean@oss.cyber.gouv.fr/
> 
>   drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index 70136f6c22e8..a15f21fc41e4 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -301,7 +301,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>   		nvmet_check_transfer_len(req, tl);
>   		return;
>   	}
> -	if (tl < offsetof(struct nvmf_auth_dhchap_success2_data, rsvd1)) {
> +	if (tl < sizeof(struct nvmf_auth_dhchap_failure_data)) {
>   		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>   		req->error_loc =
>   			offsetof(struct nvmf_auth_send_command, tl);
> 

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

