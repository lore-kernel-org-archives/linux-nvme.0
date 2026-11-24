Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B5606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Wn8ZVYw7;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Bmy5EudU;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SYv7VJJR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Bmy5EudU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SYv7VJJR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ylG3MbG7GnLFGRWEWi1SyH1cSeYiha97TTv92nQwSMY=; b=Wn8ZVYw7W9kxk5
	fHDPR000L8TdApih0zhFxFmaL/0nYTxidplquRJSHkEBpGR2ehvzCpLNte9CODQ4D0hKDUU1WXDQz
	Zxim1KtOlQ1wwJ+9lEJGLr+/B/gZKcDzJvNUtg6L8azKGxBLBuNq/PnWnKB0YSsOYUZ9CkHq/inQL
	5L134ZP38wjTxBIaQDTKj73Gvtl4v9T5WRLKYW8wrm8VfwjJCF2nE3KLR+iz5Hhn+VxQ+ZJ9wfY85
	rqn7uKrsHPKaG7BZcSJv8pIJMmLy4ORh9v5qjEgIM6Tq91KetCGvrb9vVYcUdB+HSBtY1YGflgDVd
	suVo8h57kTmArl0mdivw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVlNG-00000005osj-3Vhv;
	Tue, 24 Nov 2026 07:55:34 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVlND-00000005os8-312z
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 07:55:33 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C276722263;
	Tue, 24 Nov 2026 07:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795506929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylG3MbG7GnLFGRWEWi1SyH1cSeYiha97TTv92nQwSMY=;
	b=Bmy5EudUa6q+RXSGXVShulWZWdGjxu9SKZLRxUVRa+w3mq31sBo5uBGXyY7BHQRpFZmaFq
	ypgEsQlNWOMAeMNlyAy/U+izta5mc3kEG5rg2LbcchdYja5eiN6b3uopSb3z/IEW8dByK/
	P6n+a2DF3l3wcNVJvN+YCFGuHAXgXGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795506929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylG3MbG7GnLFGRWEWi1SyH1cSeYiha97TTv92nQwSMY=;
	b=SYv7VJJR9JLtb4sB880cqf/5t1R/1FkI2PP5vZusuKRLrdo3HI4GzrDcy19+HgGLvTOX6g
	Y2cQi4EffArl2QCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795506929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylG3MbG7GnLFGRWEWi1SyH1cSeYiha97TTv92nQwSMY=;
	b=Bmy5EudUa6q+RXSGXVShulWZWdGjxu9SKZLRxUVRa+w3mq31sBo5uBGXyY7BHQRpFZmaFq
	ypgEsQlNWOMAeMNlyAy/U+izta5mc3kEG5rg2LbcchdYja5eiN6b3uopSb3z/IEW8dByK/
	P6n+a2DF3l3wcNVJvN+YCFGuHAXgXGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795506929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylG3MbG7GnLFGRWEWi1SyH1cSeYiha97TTv92nQwSMY=;
	b=SYv7VJJR9JLtb4sB880cqf/5t1R/1FkI2PP5vZusuKRLrdo3HI4GzrDcy19+HgGLvTOX6g
	Y2cQi4EffArl2QCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 843411339F;
	Tue, 24 Nov 2026 07:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dkL8FvFCBWt4aQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 24 Nov 2026 07:55:29 +0000
Message-ID: <c429a65b-d027-4612-85d6-3a42a37900b3@suse.de>
Date: Tue, 24 Nov 2026 08:55:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] nvmet-auth: parse dhchap key from configfs
 attribute
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123-dhchap-keyring-v4-v6-5-5082a49715ab@kernel.org>
 <sashiko-outbox-229749@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-229749@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.995];
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
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_235531_936547_10BF479D 
X-CRM114-Status: GOOD (  14.13  )
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 6:30 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] nvmet-auth: host_key reference leak in nvmet_setup_auth() on
>    ctrl_key error
> --
> 
> commit 0056af1c2f2c7d56f3cbd59406150e77070f9ffe
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvmet-auth: parse dhchap key from configfs attribute
> 
> This commit converts the nvmet configfs DH-HMAC-CHAP key handling to
> parse and store keys as struct key references on struct nvmet_host
> instead of raw secret strings.
> 
>> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
>> index 26457ce4acc2a..6348c810bd168 100644
>> --- a/drivers/nvme/target/auth.c
>> +++ b/drivers/nvme/target/auth.c
> 
> [ ... ]
> 
>> @@ -186,22 +195,43 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
>>   		goto out_unlock;
>>   	}
>>   
>> -	if (!host->dhchap_secret) {
>> +	if (!host->dhchap_key) {
>>   		pr_debug("No authentication provided\n");
>>   		goto out_unlock;
>>   	}
>>   
>> -	host_key = nvme_auth_extract_key(NULL, host->dhchap_secret,
>> -					 strlen(host->dhchap_secret));
>> -	if (IS_ERR(host_key)) {
>> +	host_key = key_get(host->dhchap_key);
>> +	if (!host_key) {
>> +		pr_warn("%s: host key %08x not found\n",
>> +			__func__, key_serial(host->dhchap_key));
>>   		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>>   		goto out_unlock;
>>   	}
>> -	if (host->dhchap_ctrl_secret) {
>> -		ctrl_key = nvme_auth_extract_key(NULL, host->dhchap_ctrl_secret,
>> -						 strlen(host->dhchap_ctrl_secret));
>> -		if (IS_ERR(ctrl_key)) {
>> -			key_put(host_key);
>> +	down_read(&host_key->sem);
>> +	ret = key_validate(host_key);
>> +	key_id = key_serial(host_key);
>> +	up_read(&host_key->sem);
>> +	if (ret) {
>> +		pr_warn("host key %08x invalidated\n", key_id);
>> +		key_put(host_key);
>> +		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>> +		goto out_unlock;
>> +	}
>> +	if (host->dhchap_ctrl_key) {
>> +		ctrl_key = key_get(host->dhchap_ctrl_key);
>> +		if (!ctrl_key) {
>> +			pr_warn("%s: ctrl key %08x not found\n",
>> +				__func__, key_serial(host->dhchap_ctrl_key));
>> +			ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>> +			goto out_unlock;
>> +		}
>> +		down_read(&ctrl_key->sem);
>> +		ret = key_validate(ctrl_key);
>> +		key_id = key_serial(ctrl_key);
>> +		up_read(&ctrl_key->sem);
>> +		if (ret) {
>> +			pr_warn("ctrl key %08x invalidated\n", key_id);
>> +			key_put(ctrl_key);
>>   			ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>>   			goto out_unlock;
>>   		}
> 
> [Severity: Medium]
> Do both error paths under if (host->dhchap_ctrl_key) leak host_key by
> jumping to out_unlock without calling key_put(host_key)?
> 
Fixed with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

