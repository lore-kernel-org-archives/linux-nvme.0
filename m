Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DD7606A32C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qeXL9VUD;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=R5I6nR6s;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KBOhI7bB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=R5I6nR6s;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KBOhI7bB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qSfkCnPPapXakwD0+Tcfs4W2tuo8CRxA3SpOZRdybsQ=; b=qeXL9VUDMQV1RA
	SByRtpJJEY0fxIEzQB9+hlxTfBDhx15u7G1IBCioc+E+9ppTMaOvzINWjR8+vADKkADXmT/D4egl1
	tRfh6UB/AUDXS7O2vCtRsB//dBv2kEb0MNULFuOv7yH3ym1Yhzb72RlwOv6U0wSAcDomWqH0/Y7da
	3Dddjv+g/+c7sZGF20RiwKuOC60A69/QqLAlWw1l1hbqmdZnRecbjshfqP5Tvrk01aHfq4austwIT
	ndZxe5u6FB5P8XLcuZ6QA9NMQjTw/WG6YLB9PSitnEZq9KO65k1tS6GoqwZ2h3MNkKMMqNM5ZnCiP
	qACEqspAmiYuEk4Icohg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUPyo-0000000FJUE-1Kgi;
	Fri, 20 Nov 2026 14:52:46 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUPyl-0000000FJTg-3EXI
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 14:52:45 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0BBD2224B;
	Fri, 20 Nov 2026 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795186361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSfkCnPPapXakwD0+Tcfs4W2tuo8CRxA3SpOZRdybsQ=;
	b=R5I6nR6s3/ThEIakh6eEF2RNOI0AlrVxLvyAyDhQ+C3Iqj7RxQzlx4zhuewim49wW+UOr0
	+jW6mS7xdWlbluLJpGipoH36NehFo0gS6d+VkjObUObmestI3W4OQmTggzQaJFDqeAyjYA
	G+firGjEPtkNhVkqharGYba8SwbgKsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795186361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSfkCnPPapXakwD0+Tcfs4W2tuo8CRxA3SpOZRdybsQ=;
	b=KBOhI7bBuip1q855/nDYN6EUAqbTJljtGRW7NpiFG3JzDFR26yRZluah/yxfOOMXQNa1B7
	FC/o5V+rP39lPcCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=R5I6nR6s;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KBOhI7bB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795186361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSfkCnPPapXakwD0+Tcfs4W2tuo8CRxA3SpOZRdybsQ=;
	b=R5I6nR6s3/ThEIakh6eEF2RNOI0AlrVxLvyAyDhQ+C3Iqj7RxQzlx4zhuewim49wW+UOr0
	+jW6mS7xdWlbluLJpGipoH36NehFo0gS6d+VkjObUObmestI3W4OQmTggzQaJFDqeAyjYA
	G+firGjEPtkNhVkqharGYba8SwbgKsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795186361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSfkCnPPapXakwD0+Tcfs4W2tuo8CRxA3SpOZRdybsQ=;
	b=KBOhI7bBuip1q855/nDYN6EUAqbTJljtGRW7NpiFG3JzDFR26yRZluah/yxfOOMXQNa1B7
	FC/o5V+rP39lPcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97EE31342D;
	Fri, 20 Nov 2026 14:52:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E7fLHLleAGs7RQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Nov 2026 14:52:41 +0000
Message-ID: <039b2f6b-c24f-4e3d-8aae-33d592d26563@suse.de>
Date: Fri, 20 Nov 2026 15:52:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] nvme-auth: wait for authentication to finish when
 changing keys
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
 <20261120-dhchap-keyring-v4-v4-7-5f8c7d9926ee@kernel.org>
 <sashiko-outbox-225036@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-225036@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: C0BBD2224B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_065244_045693_06EE8FC8 
X-CRM114-Status: GOOD (  16.76  )
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

On 11/20/26 12:26 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] nvme-auth: asymmetric and undocumented removal of
>    synchronize_rcu() in sysfs
> --
> 
> commit 5f508c67e7480252b016c544aeba6f80edc88b85
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme-auth: wait for authentication to finish when changing keys
> 
> This commit flushes ctrl->dhchap_auth_work after queuing re-authentication in
> dhchap_secret_store() and dhchap_ctrl_secret_store(), and removes two
> synchronize_rcu() calls after key_revoke().
> 
>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index 47caed2ce3978..ce327a018b0d0 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -875,7 +875,6 @@ static ssize_t dhchap_secret_store(struct device *dev,
>>   		if (generated) {
>>   			dev_dbg(ctrl->dev, "revoke host key %08x\n", key_serial(key));
>>   			key_revoke(key);
>> -			synchronize_rcu();
>>   		}
>>   		key_put(key);
>>   		kfree_sensitive(dhchap_secret);
> 
> [ ... ]
> 
>> @@ -973,7 +972,6 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
>>   		dev_dbg(ctrl->dev, "revoke ctrl key %08x\n",
>>   			key_serial(old_key));
>>   		key_revoke(old_key);
>> -		synchronize_rcu();
>>   	}
>>   	ctrl->ctrl_key = key;
>>   	ctrl->ctrl_key_generated = generated;
> 
> [Severity: Low]
> Why are synchronize_rcu() calls removed from mismatched paths in
> dhchap_secret_store() and dhchap_ctrl_secret_store(), and without mention in
> the commit message?
> 
> In dhchap_secret_store(), synchronize_rcu() is removed from the
> key_validate() error path, but kept when revoking old_key under
> ctrl->dhchap_auth_mutex:
> 
Oversight. Will be fixed up with the next version.

> drivers/nvme/host/sysfs.c:dhchap_secret_store() {
>      ...
> 	if (ctrl->host_key_generated) {
> 		dev_dbg(ctrl->dev, "revoke host key %08x\n",
> 			key_serial(old_key));
> 		key_revoke(old_key);
> 		synchronize_rcu();
> 	}
>      ...
> }
> 
> In dhchap_ctrl_secret_store(), it is removed when revoking old_key, but kept
> in the key_validate() error path:
> 
> drivers/nvme/host/sysfs.c:dhchap_ctrl_secret_store() {
>      ...
> 		if (generated) {
> 			dev_dbg(ctrl->dev, "revoke ctrl key %08x\n", key_serial(key));
> 			key_revoke(key);
> 			synchronize_rcu();
> 		}
>      ...
> }
> 
> Both functions handle keys of type nvme_dhchap_psk_key_type (whose
> user_revoke() callback frees the payload via call_rcu()), so the two store
> callbacks should handle key_revoke() symmetrically.
> 
Similarly. Will be fixed with the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

