Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4101606A31C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oKGURCp2;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mSUIgo8M;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UtzO0A3S;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oOwNCcGt;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6S9h/1yG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VEdUNR8UjEwRDkCy98TOoPExuCvETfLC6ZCVC0yV6hU=; b=oKGURCp21VFUfB
	dKkuWHvWiHSeSMcnCcKdYrgutnVQ2JZkbt/N+h68f4dvWviD3AfBFa2/EAC81tcgUKTcSTPxd3dow
	zKioOcZlqHhgkf5ghtJl7U6ux4dN7uCCgUKQWg1EChS8KZNoJD2AeuURSUuxLlaqciCPitFGURUPq
	RzAZRnXsicnhX3rP/EhS/oUpEXXbVku48YBHeNa0sYC3theAh51ej7CPczaXfhKtDYauORS7igcu3
	bvDo98UHYWGtyB8b3sIJGe2wIfGpawLDZ/LyOQwd30UlmkgiHj/rPWjr3TAXmWJEaJXm3nksjr96p
	dEiuGMAr84QNnwjrKRPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWqRL-0000000F7Iv-48nK;
	Fri, 27 Nov 2026 07:32:15 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWqRI-0000000F7IU-48kr
	for linux-nvme@lists.infradead.org;
	Fri, 27 Nov 2026 07:32:14 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DEF0C22850;
	Fri, 27 Nov 2026 07:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795764730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEdUNR8UjEwRDkCy98TOoPExuCvETfLC6ZCVC0yV6hU=;
	b=mSUIgo8MsPEM4aMBu4aDSWcVjtWnwnz7nymYLbLzuFVy+vaL87V+ZhkwdKY7nu+G3G0Tog
	JbjzaeAiY6QjpTWj5lwWMw9+NWulxAjXKV6f8kcTjtEBaNz79gkvDRR0A+3bwv4KxT4f8Y
	kt84565pyJ/Vagsah1+tQMvO3oEVpOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795764730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEdUNR8UjEwRDkCy98TOoPExuCvETfLC6ZCVC0yV6hU=;
	b=UtzO0A3S/Cxhmzvqws3d0nIn66nT6UBE0Y9FLqt14M2LA6iQ25S1Ai6yNe+BpIHzusGQXH
	e6FPYHKtau19KcAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oOwNCcGt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="6S9h/1yG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795764729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEdUNR8UjEwRDkCy98TOoPExuCvETfLC6ZCVC0yV6hU=;
	b=oOwNCcGtFQyIAbCGfZLa8KtdeBkumlvr/8dQkYjsXXxATylacnz/bQo2l06xWrW7C1StyJ
	Djd5mahIitQzqRtYlXUljMjaRdpXkBM9i9v/12h+VcmKW22/ss/yST2IBKLiohC6NhgmzB
	QU0BTqlaPY42jdTptaAWRi8thAnewy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795764729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEdUNR8UjEwRDkCy98TOoPExuCvETfLC6ZCVC0yV6hU=;
	b=6S9h/1yGrVN1KCUuuJsH6kJbXnPEwD9BIgVTjVETMoukf8Tku0CFc3fLlxWiJc+9yt8iyv
	CBFVCTBCBPp7dbBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 481B513432;
	Fri, 27 Nov 2026 07:32:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8AYuBvkxCWsvJQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Nov 2026 07:32:09 +0000
Message-ID: <898747c1-a11e-4f81-be71-34454816eecc@suse.de>
Date: Fri, 27 Nov 2026 08:32:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/14] nvme: parse dhchap keys during option parsing
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Eric Biggers <ebiggers@kernel.org>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-7-ee438ffea527@kernel.org>
 <sashiko-outbox-235706@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-235706@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DEF0C22850
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
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
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
X-CRM114-CacheID: sfid-20261126_233213_176965_1BB3A5B4 
X-CRM114-Status: GOOD (  18.54  )
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 3:29 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] nvme-auth: ERR_PTR dereference on key_lookup() in
>    nvme_auth_init_ctrl()
> --
> 
> commit 0df67db2f376340a8318c48ba959e7e18c9db8b6
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme: parse dhchap keys during option parsing
> 
> This commit creates DH-HMAC-CHAP keys during fabrics option parsing,
> stores their key serials in struct nvmf_ctrl_options, and adds
> dhchap_key and dhchap_ctrl_key sysfs attributes.
> 
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index d6abdb4f1e21c..285aa1c71f102 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
> [ ... ]
>> @@ -1028,38 +1023,100 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
> [ ... ]
>>   int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>>   {
>>   	struct nvme_dhchap_queue_context *chap;
>> +	struct key *host_key, *ctrl_key = NULL;
>>   	int i, ret;
>>   
>>   	mutex_init(&ctrl->dhchap_auth_mutex);
>>   	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
>>   	if (!ctrl->opts)
>>   		return 0;
>> -	ctrl->host_key = nvme_auth_extract_key(ctrl->opts->dhchap_secret,
>> -				strlen(ctrl->opts->dhchap_secret));
>> -	if (IS_ERR(ctrl->host_key)) {
>> -		ret = PTR_ERR(ctrl->host_key);
>> -		ctrl->host_key = NULL;
>> -		return ret;
>> +	if (!ctrl->opts->dhchap_key) {
>> +		nvme_auth_clear_host_key(ctrl);
>> +		nvme_auth_clear_ctrl_key(ctrl);
>> +		return 0;
>>   	}
>>   
>> -	ctrl->ctrl_key = nvme_auth_extract_key(ctrl->opts->dhchap_ctrl_secret,
>> -				strlen(ctrl->opts->dhchap_ctrl_secret));
>> -	if (IS_ERR(ctrl->ctrl_key)) {
>> -		ret = PTR_ERR(ctrl->ctrl_key);
>> -		ctrl->ctrl_key = NULL;
>> -		goto err_free_dhchap_secret;
>> +	host_key = key_lookup(ctrl->opts->dhchap_key);
>> +	if (!host_key) {
>> +		pr_warn("dhchap host key %08x not present\n",
>> +			ctrl->opts->dhchap_key);
>> +		return -ENOKEY;
>> +	}
>> +	down_read(&host_key->sem);
>> +	ret = key_validate(host_key);
>> +	up_read(&host_key->sem);
>> +	if (ret) {
>> +		pr_warn("dhchap host key %08x invalidated\n",
>> +			key_serial(host_key));
>> +		key_put(host_key);
>> +		return -ENOKEY;
>>   	}
>>   
>> -	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
>> -		return 0;
>> +	if (ctrl->opts->dhchap_ctrl_key) {
>> +		ctrl_key = key_lookup(ctrl->opts->dhchap_ctrl_key);
>> +		if (!ctrl_key) {
>> +			pr_warn("dhchap ctrl key %08x not present\n",
>> +				ctrl->opts->dhchap_ctrl_key);
>> +			key_put(host_key);
>> +			return -ENOKEY;
>> +		}
>> +		down_read(&ctrl_key->sem);
> 
> [Severity: High]
> Should host_key and ctrl_key be checked with IS_ERR() rather than for
> NULL after key_lookup()?  key_lookup() returns ERR_PTR(-ENOKEY) when a
> key serial is not found, so if either key is removed before
> nvme_auth_init_ctrl() runs, down_read() will dereference an error
> pointer.
> 

Fixed with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

