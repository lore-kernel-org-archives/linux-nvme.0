Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80076606A31C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FdkF1jm4;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ECgggU4n;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lojZlJUN;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ECgggU4n;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lojZlJUN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Seaj0QlYAAGKFYCPwjvkTKuTijkUp2U+E5U19NldKYg=; b=FdkF1jm4NV7mZP
	6amSr/SWJ14ZXY52ggYIlObuIHCSdKcPlkE6HIdEiPB+SVD1HXCxKO0wT3P6nAROEgehDqZPgCfhc
	jBZKBzBknfHJhhGKJjH4AK6QJULAbpVUKwmXA9YAaGKPC0J4Ge3g7i6G9KYqD+DIaUtNE6D+UGtjm
	j48d8WBqgQMJUzHbw3GB8X98A0FSjnjSuxggVu1s99YymA4vo5SBkrFWMaBT/K+goLKQdn/HNwVJH
	PQXQoxJCh7by4Swn5TiIBc/62SDfh6g57/Ufy0yYrFqBJp271MqLBlikLTAV6WUu7bjea20KRHeTX
	BCn7Qe9Qe2JngmdQ8i/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWqZ5-0000000F9TJ-0tH0;
	Fri, 27 Nov 2026 07:40:15 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWqZ2-0000000F9Ss-0SJq
	for linux-nvme@lists.infradead.org;
	Fri, 27 Nov 2026 07:40:13 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0112422730;
	Fri, 27 Nov 2026 07:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795765210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Seaj0QlYAAGKFYCPwjvkTKuTijkUp2U+E5U19NldKYg=;
	b=ECgggU4nl9i3bvBsUBxSL/BP/CP9EiDhq4CHetH50PmsSNTt/Ijf6doVLrtOXtbQoKUjqO
	yxKRwFgT4yX777PxlYOSAtJY94pAevPde2c13Ox07vGs5QoE9njNDwvN3Tjh8b4QzhDMtJ
	HIf38hm5/uMlzkaspqLAB10J4w/swN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795765210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Seaj0QlYAAGKFYCPwjvkTKuTijkUp2U+E5U19NldKYg=;
	b=lojZlJUNUug0DXDEtJ1/TXChzeN7otMLnlvWmQ5djZ05I4b34NawMERk2AzmxIJ6fKMmtf
	T+vW+vhkfje6s+AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ECgggU4n;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lojZlJUN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795765210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Seaj0QlYAAGKFYCPwjvkTKuTijkUp2U+E5U19NldKYg=;
	b=ECgggU4nl9i3bvBsUBxSL/BP/CP9EiDhq4CHetH50PmsSNTt/Ijf6doVLrtOXtbQoKUjqO
	yxKRwFgT4yX777PxlYOSAtJY94pAevPde2c13Ox07vGs5QoE9njNDwvN3Tjh8b4QzhDMtJ
	HIf38hm5/uMlzkaspqLAB10J4w/swN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795765210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Seaj0QlYAAGKFYCPwjvkTKuTijkUp2U+E5U19NldKYg=;
	b=lojZlJUNUug0DXDEtJ1/TXChzeN7otMLnlvWmQ5djZ05I4b34NawMERk2AzmxIJ6fKMmtf
	T+vW+vhkfje6s+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6539C13432;
	Fri, 27 Nov 2026 07:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SXQCEdkzCWtZLQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Nov 2026 07:40:09 +0000
Message-ID: <1485af79-af07-4b6f-82dc-f2f442cd9686@suse.de>
Date: Fri, 27 Nov 2026 08:40:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/14] nvme: allow to pass in key description as dhchap
 secret
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
 <20261126-dhchap-keyring-v4-v7-9-ee438ffea527@kernel.org>
 <sashiko-outbox-235701@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-235701@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0112422730
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_234012_301262_7EBEAB29 
X-CRM114-Status: GOOD (  26.98  )
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

On 11/26/26 3:27 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] nvme-auth: ERR_PTR dereference after key_lookup() in show and
>    init helpers
> - [Medium] nvmet-auth: wrong generated flag updated in
>    nvmet_auth_update_key()
> --
> 
> commit 23f2a5a7beef9101cd52fed1a3096af44469d991
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme: allow to pass in key description as dhchap secret
> 
> This commit updates nvme_auth_extract_key() to look up pre-populated
> keys by description in addition to generating keys from raw secret data,
> and tracks whether keys were auto-generated so pre-populated keys are
> not revoked on teardown.
> 
>> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
>> index ff0e8569d7067..54e79c8a7cae6 100644
>> --- a/drivers/nvme/target/auth.c
>> +++ b/drivers/nvme/target/auth.c
>> @@ -20,31 +20,38 @@
>>   #include "nvmet.h"
>>   
>>   static void nvmet_auth_update_key(struct nvmet_host *host, bool set_ctrl,
>> -				  struct key *new_key)
>> +				  struct key *new_key, bool new_generated)
>>   {
>>   	key_serial_t old_key_id = 0, new_key_id = key_serial(new_key);
>>   	struct key *key = NULL;
>> +	bool generated = false;
>>   
>>   	if (set_ctrl) {
>>   		if (host->dhchap_ctrl_key) {
>>   			if (host->dhchap_ctrl_key == new_key_id) {
>> -				if (new_key)
>> +				if (new_key && new_generated)
>>   					key_revoke(new_key);
>>   				return;
>>   			}
>>   			old_key_id = host->dhchap_ctrl_key;
>> +			generated = host->dhchap_ctrl_key_generated;
>> +			host->dhchap_ctrl_key_generated = false;
>>   		}
>>   		host->dhchap_ctrl_key = new_key_id;
>> +		host->dhchap_key_generated = new_generated;
> 
> [Severity: Medium]
> Should the set_ctrl branch update host->dhchap_ctrl_key_generated instead
> of host->dhchap_key_generated?
> 
> As written, host->dhchap_ctrl_key_generated remains false, so
> nvmet_host_dhchap_ctrl_key_show() prints the internal UUID description
> instead of the secret for auto-generated controller keys and replacing or
> clearing the controller key never revokes it.  At the same time, setting
> or clearing the controller key overwrites host->dhchap_key_generated,
> which can cause a pre-populated host key to be revoked or an
> auto-generated host key to be leaked.
> 
Fixed with the next version.

> [ ... ]
> 
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index f6bfda757f076..3defa3f948497 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -2248,13 +2248,15 @@ static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
>>   		down_read(&key->sem);
>>   		if (key_validate(key))
>>   			ret = sprintf(page, "<invalidated>\n");
>> -		else {
>> +		else if (host->dhchap_key_generated) {
>>   			ret = key->type->read(key, page, PAGE_SIZE);
>>   			if (ret > 0) {
>>   				page[ret] = '\n';
>>   				ret++;
>>   			}
>> -		}
>> +		} else
>> +			ret = scnprintf(page, PAGE_SIZE,
>> +					"%s\n", key->description);
>>   		up_read(&key->sem);
>>   		key_put(key);
>>   	}
> 
> [Severity: High]
> Can nvmet_host_dhchap_key_show() and nvmet_host_dhchap_ctrl_key_show()
> dereference an error pointer when the key is unset or has been unlinked?
> 
> drivers/nvme/target/configfs.c:nvmet_host_dhchap_key_show() {
> 	down_read(&nvmet_config_sem);
> 	key = key_lookup(host->dhchap_key);
> 	if (!key) {
> 		page[0] = '\0';
> 		ret = 0;
> 	} else {
> 		down_read(&key->sem);
> ...
> }
> 
> key_lookup() returns ERR_PTR(-ENOKEY) rather than NULL when a key serial
> is not found (including when host->dhchap_key is 0), so the !key check
> falls through to the else branch and dereferences ERR_PTR(-ENOKEY) in
> down_read(&key->sem).  nvme_auth_init_ctrl() and nvmet_setup_auth() also
> check !host_key and !ctrl_key instead of IS_ERR() after key_lookup(),
> which can similarly oops if a pre-populated key was unlinked after option
> or configfs parsing dropped its reference.
> 
Already fixed with updates to the previous patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

