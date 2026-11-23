Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDDE606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=azP3nsQp;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DRQ+2A+P;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DZ3stIjQ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jG0AtINi;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=C2wP3l5W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PEHXVcmcU6hmwceAFktupwvsJxs81dsiFnGpIkMt2Lk=; b=azP3nsQpWedcSI
	U2kZQ+45b0XiH9Xy2HvaAk+1URwQoOoaj4Jo0JUekfjx+/0gHjxRnRiXH0C7AhtqIoRFJPXca/9PM
	fy0np6r3oT6a3OYfr9yM7uPBdKpCWqJUqhOyp5+xxQBtFvPdxp8beCuG2P/3WWfZybH9WPecargC1
	2WukUXLv/aTECedudXt6cIJWoFiT/aaXcByvOpNPLT0kMetn4KExiOQPNg7RqKrNvbEx8squUYFDY
	IlJITAr+nck8eHH92ckNji/qMm7UspUHsH0N6rneSTLO63VUxyJFW4AnVdHLZFWe1xTxbM42jlxyi
	6nZkFcIcjeZHgC7fSdxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVPBc-00000002Xvk-1ITf;
	Mon, 23 Nov 2026 08:14:04 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVPBR-00000002XuS-24RF
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 08:13:57 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B5912206F;
	Mon, 23 Nov 2026 08:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795421631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEHXVcmcU6hmwceAFktupwvsJxs81dsiFnGpIkMt2Lk=;
	b=DRQ+2A+PbDAVfgq70SWsHdXnPbLMKNuI+/QQa/bDI5WZWIH2/oeWrAnoIPLxU2eYaBpLtx
	eWoRAne8OTvt9j/JDTtl5TsDCSZiCZKhUyY5tUTHZkqvbYn88X511mz2+gQ8XgNPTMJjWd
	8mDz00SG8OYJASXlntscJtk3BDNu3Ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795421631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEHXVcmcU6hmwceAFktupwvsJxs81dsiFnGpIkMt2Lk=;
	b=DZ3stIjQUKzgSKkec+GnL9BqM981/RgnzxfBidsMI0p4XsBPDMtFgpnWxW+BRdiDbF3nKp
	9j8zSJaPJSqCA0CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795421630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEHXVcmcU6hmwceAFktupwvsJxs81dsiFnGpIkMt2Lk=;
	b=jG0AtINidGI3PoFqMVn5/Dj+b8UWsD6PNi/GVmBentHD5yXMv32Okx/6zyKU5W9t4TdLDq
	p2gMLzl7VcyAMmFRP+WrYp+3/UPe3lEUYIUNhL6SzE+sgQ8ceYtsFIkJeTO5swz5Oo2e6L
	tfPx3YDN6taZLT8ibEIWLc6XxJz5/7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795421630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEHXVcmcU6hmwceAFktupwvsJxs81dsiFnGpIkMt2Lk=;
	b=C2wP3l5WzOg0JgOIkS8QwvhhBQSo/tjiKLBE6VG47HlUZAP/Isy+Hwn/lMyW1pD0lfZw8E
	xzuEYQEI2FlMZ+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3765E13510;
	Mon, 23 Nov 2026 08:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T6JkAb71A2tnVQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Nov 2026 08:13:50 +0000
Message-ID: <ed2dce75-957f-42fe-9618-ea5e2230033a@suse.de>
Date: Mon, 23 Nov 2026 09:13:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: lock DH-HMAC-CHAP key clearing
To: Yao Sang <sangyao@kylinos.cn>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>
References: <20261113094214.1918982-1-sangyao@kylinos.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261113094214.1918982-1-sangyao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,kylinos.cn:email]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_001354_499436_85B70E4D 
X-CRM114-Status: GOOD (  18.78  )
X-Spam-Score: -2.1 (--)
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

On 11/13/26 10:42 AM, Yao Sang wrote:
> Clearing a key without nvmet_config_sem can race with configfs reads
> or authentication and cause a use-after-free.
> 
> Use the same locked path to set and clear keys.
> 
> Fixes: bb2df18958b4 ("nvmet-auth: allow to clear DH-HMAC-CHAP keys")
> Signed-off-by: Yao Sang <sangyao@kylinos.cn>
> ---
>   drivers/nvme/target/auth.c | 43 ++++++++++++++++----------------------
>   1 file changed, 18 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index ccba84b1344e..3cbe90a432ef 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -22,39 +22,32 @@
>   int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
>   		       bool set_ctrl)
>   {
> -	unsigned char key_hash;
> -	char *dhchap_secret;
> -
> -	if (!strlen(secret)) {
> -		if (set_ctrl) {
> -			kfree(host->dhchap_ctrl_secret);
> -			host->dhchap_ctrl_secret = NULL;
> -			host->dhchap_ctrl_key_hash = 0;
> -		} else {
> -			kfree(host->dhchap_secret);
> -			host->dhchap_secret = NULL;
> -			host->dhchap_key_hash = 0;
> +	unsigned char key_hash = 0;
> +	char *dhchap_secret = NULL;
> +
> +	if (*secret) {
> +		if (sscanf(secret, "DHHC-1:%hhd:%*s", &key_hash) != 1)
> +			return -EINVAL;
> +		if (key_hash > 3) {
> +			pr_warn("Invalid DH-HMAC-CHAP hash id %d\n",
> +				key_hash);
> +			return -EINVAL;
>   		}
> -		return 0;
> -	}
> -	if (sscanf(secret, "DHHC-1:%hhd:%*s", &key_hash) != 1)
> -		return -EINVAL;
> -	if (key_hash > 3) {
> -		pr_warn("Invalid DH-HMAC-CHAP hash id %d\n",
> -			 key_hash);
> -		return -EINVAL;
> +
> +		dhchap_secret = kstrdup(secret, GFP_KERNEL);
> +		if (!dhchap_secret)
> +			return -ENOMEM;
> +		dhchap_secret = strim(dhchap_secret);
>   	}
> -	dhchap_secret = kstrdup(secret, GFP_KERNEL);
> -	if (!dhchap_secret)
> -		return -ENOMEM;
> +
>   	down_write(&nvmet_config_sem);
>   	if (set_ctrl) {
>   		kfree(host->dhchap_ctrl_secret);
> -		host->dhchap_ctrl_secret = strim(dhchap_secret);
> +		host->dhchap_ctrl_secret = dhchap_secret;
>   		host->dhchap_ctrl_key_hash = key_hash;
>   	} else {
>   		kfree(host->dhchap_secret);
> -		host->dhchap_secret = strim(dhchap_secret);
> +		host->dhchap_secret = dhchap_secret;
>   		host->dhchap_key_hash = key_hash;
>   	}
>   	up_write(&nvmet_config_sem);

This will be modified by my patchset to move DH-CHAP to the linux
keystore, but until then:

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

