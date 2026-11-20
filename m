Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7401606A33C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FniZbpIp;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=UbY/C7vg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ye8Rw36H;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JNxii64k;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1/bdNKvD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=V1Zb6/ZDKYSS5Ujt+fWXBSl6jv8FIJReeUHiPtoYBq4=; b=FniZbpIpdQbN/6
	UzwOVEkxm1xqvgCkkfmdIlVwg0VYSi7R2IDmDdIxWelAaEidoIinzr+3AQ9njGc0WbWVtNp68VBtd
	Aa2fzBpc5a24uFKh73DkAOLEbOznisvOzMYE/VjpBN75rVB3RlpwwBJR+zdwcNTFX774aLuohWmmv
	5PIo3Y5aC+dP56msP2y2uCxdE94QVCUc1b2r8dttcJgb/wMeTSXR20IGak9+YbgecXXaiHZbprQtv
	/zUzAL+28NuEV39S2dUlSBVBsrO5zxZuldm6TxPlG5rT8/LdpAKzngLELb3/J02sJmMQ3CbiNDR+7
	GO+LqGjQo0THwhc/YTsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQ8T-0000000FLEh-0dWD;
	Fri, 20 Nov 2026 15:02:45 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQ8Q-0000000FLEJ-3tNu
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 15:02:44 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A99E1F7BA;
	Fri, 20 Nov 2026 15:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795186961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1Zb6/ZDKYSS5Ujt+fWXBSl6jv8FIJReeUHiPtoYBq4=;
	b=UbY/C7vg9TjZRfurBaGng32LCOYFKWEqjhqoP3ojp6r32U98OMHGZWY0y71S49UgjBgsdy
	IABm7G5l+ktMdzm8x6Ndivre95gtuo978BvKDPw4LiVUEeMRNifptp3RhJq06zSLvGzCb7
	lf2nUh6YSMwXsP4AP56hVEWLEwPRjDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795186961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1Zb6/ZDKYSS5Ujt+fWXBSl6jv8FIJReeUHiPtoYBq4=;
	b=ye8Rw36HwlzUH+qRHcK8QUVFRORq6vgHc2Th4QsAdr5q/tY3zE/FFix0/KQagJyXZQJt/6
	KUkBXTRYx5LmEFBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JNxii64k;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="1/bdNKvD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795186959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1Zb6/ZDKYSS5Ujt+fWXBSl6jv8FIJReeUHiPtoYBq4=;
	b=JNxii64kCMpdaE4m8H2PMDiZOYeDS/zvqWdkT0O/SpYQaBb/MMWN11iCu5dQ73KBKM/Z7s
	Fecu7aYC7a35Zq33+PzWJmIES4FYvLCnkotx2cvLSJZ0nQZKoHsMKMSyVmhZNGfGwAUKrM
	el+kjIMO2d44nqor+XXOGx3C3ZMH6lQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795186959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1Zb6/ZDKYSS5Ujt+fWXBSl6jv8FIJReeUHiPtoYBq4=;
	b=1/bdNKvDdLimbgY4q+q6UVmFtAhgL48I0QLKFu7PijJ1XXpT+ENH9oIyJzU+bKYveuB99x
	1rCLrJ1/zrQWzrCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1E5D1342D;
	Fri, 20 Nov 2026 15:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mqjyLg5hAGtYTwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Nov 2026 15:02:38 +0000
Message-ID: <f9ef564b-08ca-4e6e-905c-8554d653b174@suse.de>
Date: Fri, 20 Nov 2026 16:02:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] nvme-fabrics: allow to pass in keyring by name
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
 <20261120-dhchap-keyring-v4-v4-8-5f8c7d9926ee@kernel.org>
 <sashiko-outbox-225080@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-225080@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A99E1F7BA
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_070243_260237_ABFCDEF5 
X-CRM114-Status: GOOD (  21.07  )
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

On 11/20/26 12:37 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] nvme-fabrics: opt_tokens keyring=%d pattern rejects keyring
>    names
> - [Medium] nvme-fabrics: build failure in nvmf_parse_options() when
>    !CONFIG_KEYS
> --
> 
> commit 0ba36c8d6abaed9ca222b0bbab73723c1ce8243d
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme-fabrics: allow to pass in keyring by name
> 
> This commit updates nvmf_parse_options() so the NVMF_OPT_KEYRING option
> falls back to looking up a keyring by description via request_key() when the
> argument is not a positive integer serial number.
> 
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index cd728768a68fc..71da67b543aa4 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
> 
> [ ... ]
> 
>> @@ -993,13 +994,23 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>>   			break;
>>   		case NVMF_OPT_KEYRING:
>>   			if (match_int(args, &key_id) || key_id <= 0) {
>> -				ret = -EINVAL;
>> -				goto out;
>> -			}
>> -			key = nvmf_parse_key(key_id);
>> -			if (IS_ERR(key)) {
>> -				ret = PTR_ERR(key);
>> -				goto out;
>> +				p = match_strdup(args);
> 
> [Severity: High]
> Can a keyring name ever reach this branch while opt_tokens still defines
> NVMF_OPT_KEYRING as "keyring=%d"?
> 
> drivers/nvme/host/fabrics.c:opt_tokens {
>      ...
> 	{ NVMF_OPT_KEYRING,		"keyring=%d"		},
>      ...
> }
> 
> Because match_token() requires "%d" arguments to be valid integers, any
> non-numeric name such as "keyring=.nvme" fails to match and makes
> nvmf_parse_options() reject the option with -EINVAL in the default switch
> case.  In addition, reading /dev/nvme-fabrics still advertises "keyring=%d"
> to userspace, while passing a non-positive integer serial number such as
> "keyring=0" or "keyring=-1" enters this fallback and looks up the number as
> a keyring description instead of returning -EINVAL.
> 
Fixed with the next round.

>> +				if (!p) {
>> +					ret = -ENOMEM;
>> +					goto out;
>> +				}
>> +				key = request_key(&key_type_keyring, p, NULL);
> 
> [Severity: Medium]
> Does this break the build when CONFIG_NVME_FABRICS is enabled and
> CONFIG_KEYS is disabled?
> 
> CONFIG_NVME_FABRICS only selects CONFIG_NVME_KEYRING (which selects
> CONFIG_KEYS) when CONFIG_NVME_TCP_TLS or CONFIG_NVME_HOST_AUTH is enabled.
> Both key_type_keyring in include/linux/key-type.h and request_key() in
> include/linux/key.h are declared under #ifdef CONFIG_KEYS with no stub for
> !CONFIG_KEYS builds.
> 
Fixed with the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

