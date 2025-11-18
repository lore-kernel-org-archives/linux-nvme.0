Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D1ECED624
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 11:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kky5g7SnoQqMnkbVrnMLHFmE8QTxWSaXOF6eW7JKOOY=; b=kzCEnXsp2hnFL2sJEhgh+LLu0B
	cVrBhQs8a3KWZgjy8l3rZpe+1HqIGBjxO5fJYeGB9hf4DUnRt9dYmd9rXcuUA8Geyx+hsi4XAUN8V
	5HnYsyuSIz2TsJQFVAwuHYFbXj8HTjnX+WP3TNdQsZ5n+qdmvqqjFlquPhiu2PX4D/xWerZcSF6JI
	K1iUznR9hI75TDDfeplZoxK6ANnTfuXO55X0LJ8fIore6FeS66oYXWN5ExRbDCSDkb/0MjVsNq1GW
	q5A1TvBcNr+FXOcKE19vYpOQACnhmcm9g91SWOnbY3VaPzHnr8meOwnITzm1A8g/Si03IdGVS5u+A
	r4K6MtaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLKEX-00000000MXI-2H6v;
	Tue, 18 Nov 2025 11:50:53 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLKET-00000000MWn-18ID
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 11:50:50 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0BA31211B5;
	Tue, 18 Nov 2025 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763466647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kky5g7SnoQqMnkbVrnMLHFmE8QTxWSaXOF6eW7JKOOY=;
	b=oNh7cHc+gSsCmRkoPDdVBdTY0XiIORSF19AojTmXXJyPWpqmT5jdHBzvBKK+2PVoaUnTk3
	4kqlN4vEsKRl41R+0PVoes9pzj/8ZPPBq9o1YfBnkLSnFopbrlj7Yw6qSi9j/qLHmZay1W
	h4bZcYnR+Wq+VErpyXpNY/QW3Y1T1Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763466647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kky5g7SnoQqMnkbVrnMLHFmE8QTxWSaXOF6eW7JKOOY=;
	b=4TIxwJFNoRSWSHHk9QdKip2DuQS5MI/VzPk/3sc0Tb/4oJLQ2C7nL252Adequ74FCFZjoH
	yl9HNJkG+JSt1PAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oNh7cHc+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4TIxwJFN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763466647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kky5g7SnoQqMnkbVrnMLHFmE8QTxWSaXOF6eW7JKOOY=;
	b=oNh7cHc+gSsCmRkoPDdVBdTY0XiIORSF19AojTmXXJyPWpqmT5jdHBzvBKK+2PVoaUnTk3
	4kqlN4vEsKRl41R+0PVoes9pzj/8ZPPBq9o1YfBnkLSnFopbrlj7Yw6qSi9j/qLHmZay1W
	h4bZcYnR+Wq+VErpyXpNY/QW3Y1T1Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763466647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kky5g7SnoQqMnkbVrnMLHFmE8QTxWSaXOF6eW7JKOOY=;
	b=4TIxwJFNoRSWSHHk9QdKip2DuQS5MI/VzPk/3sc0Tb/4oJLQ2C7nL252Adequ74FCFZjoH
	yl9HNJkG+JSt1PAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1F263EA61;
	Tue, 18 Nov 2025 11:50:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TMPPMpZdHGl3ZQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Nov 2025 11:50:46 +0000
Message-ID: <fd9c30d3-2a9f-4ddc-9d71-436034637acb@suse.de>
Date: Tue, 18 Nov 2025 12:50:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] nvme: Allow reauth from sysfs
To: Alistair Francis <alistair23@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251114045850.1898865-1-alistair.francis@wdc.com>
 <20251114045850.1898865-5-alistair.francis@wdc.com>
 <e15b39ad-bfdf-4177-86b7-99c84975825e@suse.de>
 <CAKmqyKNViQjZHyftdj7anoF1Wsf9qeRZQiZ9yfM_FsJAcmx7jg@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKNViQjZHyftdj7anoF1Wsf9qeRZQiZ9yfM_FsJAcmx7jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0BA31211B5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,infradead.org:email]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_035049_477771_F5835032 
X-CRM114-Status: GOOD (  25.88  )
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

On 11/18/25 01:52, Alistair Francis wrote:
> On Fri, Nov 14, 2025 at 5:15 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 11/14/25 05:58, alistair23@gmail.com wrote:
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
>>> This can be done by writing  a zero to the sysfs file.
>>>
>>> echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>> v3:
>>>    - Only trigger if a 0 is written to `tls_configured_key`
>>>    - Add documentation
>>> v2:
>>>    - Trigger on any value written to `tls_configured_key`
>>>
>>>    Documentation/ABI/testing/sysfs-nvme | 13 +++++++++++
>>>    drivers/nvme/host/sysfs.c            | 34 +++++++++++++++++++++++++++-
>>>    2 files changed, 46 insertions(+), 1 deletion(-)
>>>    create mode 100644 Documentation/ABI/testing/sysfs-nvme
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-nvme b/Documentation/ABI/testing/sysfs-nvme
>>> new file mode 100644
>>> index 000000000000..16aaf0dca9e2
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-nvme
>>> @@ -0,0 +1,13 @@
>>> +What:                /sys/devices/virtual/nvme-fabrics/ctl/.../tls_configured_key
>>> +Date:                November 2025
>>> +KernelVersion:       6.19
>>> +Contact:     Linux NVMe mailing list <linux-nvme@lists.infradead.org>
>>> +Description:
>>> +             The file is avaliable when using a secure concatanation
>>> +             connection to a NVMe taget. Reading the file will return
>>> +             the serial of the currently negotiated key.
>>> +
>>> +             Writing 0 to the file will trigger a PSK reauthentication
>>> +             (REPLACETLSPSK) with the target. After a reauthentication
>>> +             the value returned by tls_configured_key will be the new
>>> +             serial.
>>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>>> index 6d10e12136d0..7ff9a5053c3f 100644
>>> --- a/drivers/nvme/host/sysfs.c
>>> +++ b/drivers/nvme/host/sysfs.c
>>> @@ -806,7 +806,39 @@ static ssize_t tls_configured_key_show(struct device *dev,
>>>
>>>        return sysfs_emit(buf, "%08x\n", key_serial(key));
>>>    }
>>> -static DEVICE_ATTR_RO(tls_configured_key);
>>> +
>>> +static ssize_t tls_configured_key_store(struct device *dev,
>>> +                                     struct device_attribute *attr,
>>> +                                     const char *buf, size_t count)
>>> +{
>>> +     struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>> +     int error, qid;
>>> +
>>> +     error = kstrtoint(buf, 10, &qid);
>>> +     if (error)
>>> +             return error;
>>> +
>>> +     /*
>>> +      * We currently only allow userspace to write a `0` indicating
>>> +      * generate a new key.
>>> +      */
>>> +     if (!qid)
>>> +             return -EINVAL;
>>> +
>>> +     if (!ctrl->opts || !ctrl->opts->concat)
>>> +             return -EOPNOTSUPP;
>>> +
>>> +     error = nvme_auth_negotiate(ctrl, 0);
>>> +     if (error < 0)
>>> +             return error;
>>> +
>>> +     error = nvme_auth_wait(ctrl, 0);
>>> +     if (error < 0)
>>> +             return error;
>>> +
>>> +     return count;
>>> +}
>>> +static DEVICE_ATTR_RW(tls_configured_key);
>>>
>>>    static ssize_t tls_keyring_show(struct device *dev,
>>>                struct device_attribute *attr, char *buf)
>>
>> Hmm.
>> Now we are just running (re-) authentication, but that does
>> not affect the TLS connection (which continues to use the
>> original key). So you would need to reset the connection
>> here to re-establish a new TLS connection.
> 
> Is the connection supposed to be reset? I don't see any mention of
> that in the spec
> 
Yeah, that's a bit hard to read (as usual).
The base spec just claims (Fig. 733, Secure Channel Protocol Identifiers):

03h: This {PSK, PSK Identity} pair replaces the {PSK, PSK Identity}
   pair that was used to set up the TLS secure channel over which the
   authentication transaction is performed.

So from that your implementation is correct, as it just replaces the
PSK (without actually using them). However, the TCP spec clarifies
(section 3.6.1.4: PSK Use):

Once the TLS secure channel for the Admin Queue of an association
has been set up with a generated {PSK, PSK Identity} pair, that
generated {PSK, PSK Identity} pair should be replaced periodically
(e.g., every hour) or on demand by performing a reauthentication
with the SC_C field in the AUTH_Negotiate message set to REPLACETLSPSK
(refer to the AUTH_Negotiate Message section of the NVM Express
Base Specification) over the Admin Queue of that association. The most
recently generated PSK, if any, is the generated PSK associated with
that Admin Queue.

And the only way to associate a PSK with the admin queue is to use
it for the TLS encryption, ie re-run the TLS handshake.

Or indeed use the KeyUpdate mechanism.

But I'll ask the FMDS group for clarification.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

