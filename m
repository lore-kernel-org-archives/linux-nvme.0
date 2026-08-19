Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1B9C5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hAVzlGvkodkivaAyZV+QTOUdBJ/cRyb/RM7KmmYh+Uw=; b=FNSB7817KjEA6yexcKsWeIuvPx
	fAO2r5Of+Zl0xp5fbk/xZvVfENELPAs9GhNHze/HyOxqsrBAWjHuIPlBl1U3PxBraGemKbrZhUJXN
	9UfJEYlozncEytzxAc1lGpC0mEX4MRhAxyx0H2i3YQfqaTgXi6gWRfNcboo2WXQb+vSP5xJQOzANo
	Sb7HQ8vhQCODT4JPDBaUqfXo7WpMo7d5hkBnaCxcoHWDR44MU3aQgiTna6YNY0rJQaSpnMJ0LTXj6
	MB7ixaEKwOF6c/yFs03TPhlZWicF+voYUxtJspU2v9J5+DQDc7hXq9os8R+xVXmV14EsCfIqz5+X3
	KfO2b8qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwghx-00000009u6p-1lg4;
	Wed, 19 Aug 2026 13:51:57 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwghv-00000009u6N-1Ime
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 13:51:56 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CEA103EB2;
	Wed, 19 Aug 2026 13:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787147508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAVzlGvkodkivaAyZV+QTOUdBJ/cRyb/RM7KmmYh+Uw=;
	b=pfZdGrf6RPnitlTHZgTalIS3GgOZu5qxbxdXyK1y2B1sGM/o3yOiuDd6a5NzhRREN55onj
	2nJIYJkmRh0t2mD4zXr3KVcGYnylt4gE8wU67RjJoly0mG2GTyd5+aDoZF4Hov9cNPCHh/
	hRNaacxwFEFShv4JvW9ZxaI8myYgc98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787147508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAVzlGvkodkivaAyZV+QTOUdBJ/cRyb/RM7KmmYh+Uw=;
	b=8tZ9pK1DAOpXE1lAPC5S7pizZhzWZ8DlEMIo5+1RX5wpLkCh1MHjeb7E7uVovbL6V/ApMu
	3gtjIx0zjjvAXFAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eV2ZifAu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ownzba+B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787147503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAVzlGvkodkivaAyZV+QTOUdBJ/cRyb/RM7KmmYh+Uw=;
	b=eV2ZifAulaSE1zAhb40XK9Z9A1ikdLh4LasdBVR95HjSFgy+Q+JFpBPG3YR8+ebpQQp/zT
	HhubfjbxVAZolMTU0zDAL5fg+b1GWFoYbKhOLFXriycW06B3jVjv7j3splFXfjl9MaNqx7
	Zp4B2zBlLK8+f6h/Jr7s9mYu5DBJoPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787147503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAVzlGvkodkivaAyZV+QTOUdBJ/cRyb/RM7KmmYh+Uw=;
	b=ownzba+BsOoS5cnz4e+Up5ROhLzaN/Od9mV+vliUfWjzDaGzZlF1r4V28YDuuGA1JDWG4q
	3OQSfXGOcYq4HxBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A98F02F81;
	Wed, 19 Aug 2026 13:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 75KYKO+0hWr9YQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 19 Aug 2026 13:51:43 +0000
Message-ID: <59a3afbf-421a-40fd-a90d-521004f7de2e@suse.de>
Date: Wed, 19 Aug 2026 15:51:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/10] block: support nesting for blk-mq flag
 QUEUE_FLAG_SAME_FORCE
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, dwagner@suse.de,
 kanie@linux.alibaba.com, jmeneghi@redhat.com, randyj@purestorage.com,
 martin.petersen@oracle.com, john.g.garry@oracle.com, gjoyce@linux.ibm.com
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
 <20260815173502.1185929-4-nilay@linux.ibm.com>
 <d11d3377-a4b3-45dc-b812-9dd06c8a2a38@suse.de>
 <ebfdc6e5-36ef-43ee-bd19-53b40e4682a2@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ebfdc6e5-36ef-43ee-bd19-53b40e4682a2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CEA103EB2
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_065155_519874_B90AE872 
X-CRM114-Status: GOOD (  18.14  )
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

On 8/18/26 1:59 PM, Nilay Shroff wrote:
> On 8/18/26 3:28 PM, Hannes Reinecke wrote:
>> On 8/15/26 7:34 PM, Nilay Shroff wrote:
>>> QUEUE_FLAG_SAME_FORCE is currently used when setting rq_affinity
>>> through sysfs as well as by UFS mediatek driver while configuring scsi
>>> parameters. A subsequent patch adding a latency-based I/O policy
>>> for NVMe multipath will also use this flag.
>>>
>>> With multiple users able to set and clear QUEUE_FLAG_SAME_FORCE, the
>>> flag needs to support nesting so that one user clearing the flag does
>>> not inadvertently disable it for another user.
>>>
>>> Add a nesting counter, q->same_force_depth, for QUEUE_FLAG_SAME_FORCE.
>>> The flag is set when the first user acquires it and the nesting counter
>>> is incremented for each subsequent user. Similarly, each user releases
>>> its reference by decrementing the counter. The flag is cleared only
>>> when the last user releases it and the counter reaches zero.
>>>
>>> Preserve the existing sysfs rq_affinity semantics with a new
>>> q->same_force_sysfs flag. When userspace enables QUEUE_FLAG_SAME_FORCE
>>> by writing 2 to rq_affinity, mark q->same_force_sysfs as set and
>>> increment q->same_force_depth by one. Subsequent writes of 2 to
>>> rq_affinity while q->same_force_sysfs is already set are ignored, so
>>> repeated writes of 2 from userspace do not increase q->same_force_depth.
>>> Similarly, writing 0 or 1 decrements the q->same_force_depth and if
>>> nesting counter reached to 0 then clears the QUEUE_FLAG_SAME_FORCE.
>>> This ensures that multiple writes of 2 to rq_affinity do not require
>>> multiple writes of 0 or 1.
>>>
>>> This change ensures that sysfs interface retains its existing set/clear
>>> semantics while also allowing other kernel users to hold or release
>>> QUEUE_FLAG_SAME_FORCE.
>>>
>>> Added two new APIs blk_mq_same_force_set() and blk_mq_same_force_clear()
>>> to set and clear QUEUE_FLAG_SAME_FORCE respectively. Also, updated
>>> existing call paths using these new APIs which toggles
>>> QUEUE_FLAG_SAME_FORCE.
>>>
>> Yikes. Is this really necessary?
>> The flag can be set by different subsystems/drivers, sure, but from
>> what I've seen each user is mutually exclusive.
>> I'd rather disallow modifying this flag if the driver sets it, to
>> avoid upper layers or sysfs modifying it.
>>
> 
> If we want to disallow userspace from modifying QUEUE_FLAG_SAME_FORCE
> while a driver owns it, then a userspace write to rq_affinity would have
> to either fail (e.g. with -EINVAL) or be silently ignored. In either case,
> that changes the existing userspace/sysfs semantics and may break userspace
> that expects the write to succeed.
> 
But _allowing_ userspace to modify it for drivers which requires it to
be set will break the drivers.
Similar for the upcoming latency-based I/O scheduler; disabling
QUEUE_FLAG_SAME_FORCE there will cause misaccounting and the scheduler
will not work properly.

So I would argue to have a flag for making QUEUE_FLAG_SAME_FORCE driver 
owned, and reject any attempts to change it via sysfs with EINVAL.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

