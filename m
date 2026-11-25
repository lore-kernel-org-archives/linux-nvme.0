Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F447606A323
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FIGKaLTG;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uudtdZfs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cgcBhKrO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1b97GWFb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tFaghQob
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/eASl6gCLJkn1rYUkIDR4/lRGaeksf2LLzNOhGxvgjc=; b=FIGKaLTGLVTYg8
	XIZTPYKzdtkkCZxCOSajFdzr4gFI7JdV4g02g7cybekmy5I6ys7NK/apYEM8JlqZhmpYT7qE3OThx
	I3Oy/FddYixHlEG1Bw1qwJn8v0ZNBxahukcx4KdkgXkR975C36iAcQpWFgoQDSBuNiR7+fLBfUrw+
	6CWzgBjs2BJ6gxEfiSUu7E7madKA5fzmYYW+7ZTKycU5rQxHlx4ltiY4HGDZPZpbYzIvHARroA5l5
	gbr1jRUg2lgkBCyDwJhzH5lNyHEuhNa09a2LrfIpm0FPKP3mErESj0a4P9yExEdnTAnQLHUqwVDB0
	CWr0v8Uv8L4brOJkqjpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW8C5-0000000920u-15K7;
	Wed, 25 Nov 2026 08:17:33 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW8Bq-000000091xP-3Hap
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 08:17:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8915521BA1;
	Wed, 25 Nov 2026 08:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795594636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/eASl6gCLJkn1rYUkIDR4/lRGaeksf2LLzNOhGxvgjc=;
	b=uudtdZfs4P9ZSd3qSYRhF1Asec1/9bnIJhk56Yuh20qlQ0i6IO/xI2Nlm9NqxtguG3HmK0
	3EqOdKDJCg3Y+h76DZsZIZcXIwBWfNC3tx4B7ivok9wdhQ8ZC0v+Fk0LI1JM8KYLxtJsoH
	7dUW3FcyU0HX/0cLRfoZAkYqrVUharI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795594636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/eASl6gCLJkn1rYUkIDR4/lRGaeksf2LLzNOhGxvgjc=;
	b=cgcBhKrOpOkduQzA0L3klEgKpFOAwb+hLgwVUxP/YMwpOB4DHzyomaOCGTnhXxFDD/6eL9
	wk4FIlQGELqtS+AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1b97GWFb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tFaghQob
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795594635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/eASl6gCLJkn1rYUkIDR4/lRGaeksf2LLzNOhGxvgjc=;
	b=1b97GWFbHyVXlmv8CMLo+8Ue8NxdPsfXOAcJmub5twZx+v/Tyi/Gb4ZoJJc3ybcClUefa3
	cPFmrdvuAquGgDKpl0KVS51O72NgljoYiHTiJ3hDpe7JTP7LqJGCfVr394vAUaZNmNx80i
	aEDJhHiJKNODlNqubupSMhVRb2HaL9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795594635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/eASl6gCLJkn1rYUkIDR4/lRGaeksf2LLzNOhGxvgjc=;
	b=tFaghQobbFzEpa+sCeRKM95uvZzC3gur9ni5WkMZ9b/sqIqDD0fL+hTuuhIj1xF5gYapsk
	YhdAxzznG01Rb/AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E572134CA;
	Wed, 25 Nov 2026 08:17:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ze8EAouZBmvVXQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 25 Nov 2026 08:17:15 +0000
Message-ID: <8a460411-2849-4c1a-b20e-a5465840e6aa@suse.de>
Date: Wed, 25 Nov 2026 09:17:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme-auth: fix data race on ctrl->transaction
To: Keith Busch <kbusch@kernel.org>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org
References: <20261116081211.1757155-1-kanie@linux.alibaba.com>
 <20261116081211.1757155-3-kanie@linux.alibaba.com>
 <6dc083eb-7286-418b-92fe-f7245f653ba0@suse.de> <avsjKMMlQPPit6IY@kbusch-mbp>
 <0366b9fc-50b4-4739-9564-53c8783bdb0c@suse.de> <av5jzr_dZROU4lH3@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <av5jzr_dZROU4lH3@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8915521BA1
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_001718_971548_74742A55 
X-CRM114-Status: GOOD (  17.98  )
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 3:49 AM, Keith Busch wrote:
> On Tue, Nov 17, 2026 at 08:23:38AM +0100, Hannes Reinecke wrote:
>> On 11/16/26 4:37 PM, Keith Busch wrote:
>>
>> It's somewhat ambiguous.
>> Spec says 'carrying the same transaction identifier value for the entire
>> authentication transaction' (for AUTH_negotiate), and later on 'carrying
>> the same transaction identifier' (for any other AUTH message).
>> So actually we just have to make sure they are identical.
>> (The random number is '4' ...)
>>
>> But the overall idea here is to distinguish transactions, so the implication
>> is that each transaction should carry different identifiers.
>> And my issue here is precisely 'each transaction'. Surely within each
>> queue, but I'd really would want to distinguish _across_ queues, too.
>> (And possibly with a random starting value to boot).
>> Just to avoid any fuzzers trying to be clever with guessing the
>> authentication ID (or bugs setting the transaction ID to 0 for every
>> queue ... same reason why we introduced the 'genctr' for the command
>> ID).
>>
>> But if you don't feel that's an issue, fine, I'll be shutting up.
> 
> I'd normally defer to you on this feature since you've more hands-on
> experience here. I just think the qid:t_id pair already distinguishes
> transactions on the wire; each queue is its own connection after all.
> 
> Regarding genctr, I thought that was because some intermediary switch
> was replaying packets, but the commit message doesn't appear to support
> that recollection. Regardless, the value is per-request, so it's on an
> even more finer granularity than per-queue.

Indeed, that's true. So let's go with this approach; one global counter
less is always a good idea.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

