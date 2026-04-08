Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19DC10F9951
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 15:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CKz9ql1CuufnhSBLMjDpQRkRbaUAZqr1/g/ZA3DBTWw=; b=1XQpzhIK7N08XryPQYWQnl0kks
	EjMpayMkiL15IQ1IfVISgWOhJmQmpkneqWD6nE6OJ+6uIbH5Dpta1FF9oVZjhq6P0osb0GPq3keKh
	brwwqjS0zhi+R3q2y8B3M6EJu//J7YBds0yXY0aaV0ylKtlg84JVZocfNNh6TQ1OJCjuJ8pDfVO1w
	s52aU+TmRp2g+J39ofz/muYfn5ys0wt8xI3wK91hpA+sUUw/2aKmv8D0OpgZwX1/+gblUHQUL/RKa
	Tz2MvpLliC9hnjkUxiWy882w85SBNjzdLaZjd9tetqEZdtAOXPUGOjYJoK91oZ2blh+dtbSfWVHuJ
	9D5BVpXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAV2V-000000094SZ-478g;
	Wed, 08 Apr 2026 15:41:59 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAV2T-000000094RW-22JK
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 15:41:58 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7FD735BCC1;
	Wed,  8 Apr 2026 15:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775662914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKz9ql1CuufnhSBLMjDpQRkRbaUAZqr1/g/ZA3DBTWw=;
	b=k2eayePsHN24KrTjLlCi/sepoKdrvZMmCAWNSV5B/EVM1NaGqcVr9U+Fx7uuc/MyriKh3J
	oA+f7SrTfq8cpi97GLJ5d306ERvI53w/zYdLyoA4NyXVKEpCnCPd2aLpmDuljC61lMxXwW
	JORaa+6wSIhaEPpb8rhfhEj1fEC7bnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775662914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKz9ql1CuufnhSBLMjDpQRkRbaUAZqr1/g/ZA3DBTWw=;
	b=8sYiXysct9640fyxm/Z720qfo//fRhVg378J9Ss51JZWv8qBL+/nILYpgw3tt9CtxHxkKj
	yusr4T/EBb2djSDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=evDDdQQU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9JxmCYKv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775662913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKz9ql1CuufnhSBLMjDpQRkRbaUAZqr1/g/ZA3DBTWw=;
	b=evDDdQQUr9qwYu/74zTru1hTH+ZokQBQeyOc6WIphRZghh5G4oZQDxW7Y39HHBt9emzcmM
	VMifsQyBFe34i7ul6SzTbF4ersDGQGaix0Yt3+rhJDJyasBYrMAHi+mfp5O8UU0yXUYXbN
	6hQGb5q5Q7zZsosgh0JDHp6Yy8HZgLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775662913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKz9ql1CuufnhSBLMjDpQRkRbaUAZqr1/g/ZA3DBTWw=;
	b=9JxmCYKvCChP9i0KLYQTHAEJA3G21j/Vq1vltfHDI7QisB/a0Yr/5k87FWwVH/3e7TUVIf
	XAUE3eNQASo7EsDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EDDA4A0B3;
	Wed,  8 Apr 2026 15:41:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dKW5ET131mm2MQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 08 Apr 2026 15:41:49 +0000
Message-ID: <6d7a4076-a4ad-4185-8e82-8e27d704d20e@suse.de>
Date: Wed, 8 Apr 2026 17:41:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] libmultipath: Add delayed removal support
To: John Garry <john.g.garry@oracle.com>, Nilay Shroff <nilay@linux.ibm.com>,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
 martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
 hare@suse.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, michael.christie@oracle.com, snitzer@kernel.org,
 bmarzins@redhat.com, dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260225153225.1031169-1-john.g.garry@oracle.com>
 <20260225153225.1031169-8-john.g.garry@oracle.com>
 <bc006d17-22b6-49d5-9e04-02eab7dab729@linux.ibm.com>
 <74eb1f9b-265e-4264-9575-177de6c924a0@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <74eb1f9b-265e-4264-9575-177de6c924a0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7FD735BCC1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_084157_669379_72425A8E 
X-CRM114-Status: GOOD (  11.34  )
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

On 4/8/26 13:28, John Garry wrote:
> On 02/03/2026 12:41, Nilay Shroff wrote:
>>> +
>>>   void mpath_add_sysfs_link(struct mpath_disk *mpath_disk)
>>>   {
>>>       struct mpath_head *mpath_head = mpath_disk->mpath_head;
>>> @@ -793,6 +868,8 @@ struct mpath_head *mpath_alloc_head(void)
>>>       mutex_init(&mpath_head->lock);
>>>       kref_init(&mpath_head->ref);
>>> +    mpath_head->delayed_removal_secs = 0;
>>> +
>>>       INIT_WORK(&mpath_head->requeue_work, mpath_requeue_work);
>>>       spin_lock_init(&mpath_head->requeue_lock);
>>>       bio_list_init(&mpath_head->requeue_list);
>>
>> I think we also need to initialize ->drv_module here.
> 
> Hi Nilay,
> 
> I am just coming back to this now. About NVMe multipath delayed disk 
> removal, did you consider a blktests testcase to cover it? I might look 
> at it if I have a chance (and it makes sense to do so).
> 

That look patently like the 'queue_if_no_path' feature from 
dm-multipath. Any chance of reconciling these two?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

