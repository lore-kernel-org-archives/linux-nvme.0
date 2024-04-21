Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BF1C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Apr 2024 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xYPRODSv259Ynjb5Jr0YHmTC4J37NA8VyK5Sx3wzaUs=; b=Kqv+/8jC2AFkQGKqeXsMYbNOt8
	tQTCjA8xrmF7G0A4K3qTo3oPjOGHJDjb6WwX2KNUOIz50CeboukEmT1jqIiCNE7rEsz8FLYWRutfJ
	B9qwgwWmv1FZc2+CO8gbK7+ojGjYC9jOX8uBH9YLc+BM7prMqPn3hYDPPGiTnkbQWYwQlXzT0DudW
	5O4XlqOKl1OLmDEvtrfkA7LZ/gJWSPGpVshQuZvu5rtqLJf9w8oUhbVTbimjgPTDgHsghLpR4U7jw
	K1pp0MTYw83OpG7Vatqnoe/aRYB6zduTxAN+gjTx5wgRQhKLnza9KskV/UfkihpeykKe6Ik6czjDi
	Zd2TZpTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryYJj-0000000Afn3-0DjM;
	Sun, 21 Apr 2024 14:37:19 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryYJd-0000000Afjj-1Cix
	for linux-nvme@lists.infradead.org;
	Sun, 21 Apr 2024 14:37:16 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3858B20F52;
	Sun, 21 Apr 2024 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713710225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYPRODSv259Ynjb5Jr0YHmTC4J37NA8VyK5Sx3wzaUs=;
	b=CSNMDls8WUISYn5XBGUR3/wjmxKEBALEDJjwzo6dpgdbJOJDcDhCAMi3vhIrVs7CO8mssl
	+6gIvpaW4A4gkoxLULZ2qeUjndgpf9vz/WGjZDb8FBH/QfR1JJ5JrlB6Nhh4HFqrswZS4e
	mmc/vv+f6UsvJ3dysU2tWvJQm4YBGl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713710225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYPRODSv259Ynjb5Jr0YHmTC4J37NA8VyK5Sx3wzaUs=;
	b=XeJjJtTc05C/MpSHBIXy2UVElVtIBTHXow3i//IxL7g8uozTgpBrk1SJmgLlUGx8Ek2tq6
	InnPvz4J00oxmwBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CSNMDls8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XeJjJtTc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713710225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYPRODSv259Ynjb5Jr0YHmTC4J37NA8VyK5Sx3wzaUs=;
	b=CSNMDls8WUISYn5XBGUR3/wjmxKEBALEDJjwzo6dpgdbJOJDcDhCAMi3vhIrVs7CO8mssl
	+6gIvpaW4A4gkoxLULZ2qeUjndgpf9vz/WGjZDb8FBH/QfR1JJ5JrlB6Nhh4HFqrswZS4e
	mmc/vv+f6UsvJ3dysU2tWvJQm4YBGl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713710225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYPRODSv259Ynjb5Jr0YHmTC4J37NA8VyK5Sx3wzaUs=;
	b=XeJjJtTc05C/MpSHBIXy2UVElVtIBTHXow3i//IxL7g8uozTgpBrk1SJmgLlUGx8Ek2tq6
	InnPvz4J00oxmwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0097213687;
	Sun, 21 Apr 2024 14:37:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E3SOOZAkJWb6ZAAAD6G6ig
	(envelope-from <hare@suse.de>); Sun, 21 Apr 2024 14:37:04 +0000
Message-ID: <f412e09a-6086-4d07-bb3a-6213ea5089e9@suse.de>
Date: Sun, 21 Apr 2024 16:37:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] nvme-tcp: reset after recovery for secure
 concatenation
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-14-hare@kernel.org>
 <ddee2fd2-584c-42be-af5f-7e002b2d5441@grimberg.me>
 <d055615b-2c41-45cd-8b15-c787eac0dc49@suse.de>
 <4438fdf3-2970-456b-acc6-fe26c355bfac@grimberg.me>
 <44ae1549-9d39-42d5-a6eb-a6700d4ab873@suse.de>
 <0b2a2e0a-8003-4217-bdc5-af4d91ed9af2@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <0b2a2e0a-8003-4217-bdc5-af4d91ed9af2@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3858B20F52
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_073713_611063_D451F56A 
X-CRM114-Status: GOOD (  20.74  )
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

On 4/21/24 13:22, Sagi Grimberg wrote:
> 
> 
> On 09/04/2024 1:10, Hannes Reinecke wrote:
>> On 4/8/24 23:23, Sagi Grimberg wrote:
>>>
>>>
>>> On 08/04/2024 9:25, Hannes Reinecke wrote:
>>>> On 4/7/24 23:49, Sagi Grimberg wrote:
>>>>>
>>>>>
>>>>> On 18/03/2024 17:03, Hannes Reinecke wrote:
>>>>>> From: Hannes Reinecke <hare@suse.de>
>>>>>>
>>>>>> With TP8018 a new key will be generated from the DH-HMAC-CHAP
>>>>>> protocol after reset or recovery, but we need to start over
>>>>>> to establish a new TLS connection with the new keys.
>>>>>>
>>>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>>>> ---
>>>>>>   drivers/nvme/host/tcp.c | 20 ++++++++++++++++++++
>>>>>>   1 file changed, 20 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>>>> index 94152ded123a..3811ee9cd040 100644
>>>>>> --- a/drivers/nvme/host/tcp.c
>>>>>> +++ b/drivers/nvme/host/tcp.c
>>>>>> @@ -2219,6 +2219,22 @@ static void 
>>>>>> nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>>>>>>       }
>>>>>>   }
>>>>>> +static bool nvme_tcp_reset_for_secure_concat(struct nvme_ctrl *ctrl)
>>>>>> +{
>>>>>> +    if (!ctrl->opts->concat)
>>>>>> +        return false;
>>>>>> +    /*
>>>>>> +     * If a key has been generated and TLS has not been enabled
>>>>>> +     * reset the queue to start TLS handshake.
>>>>>> +     */
>>>>>> +    if (ctrl->opts->tls_key && !ctrl->tls_key) {
>>>>>> +        dev_info(ctrl->device, "Reset to enable TLS with 
>>>>>> generated PSK\n");
>>>>>> +        nvme_reset_ctrl(ctrl);
>>>>>> +        return true;
>>>>>> +    }
>>>>>> +    return false;
>>>>>> +}
>>>>>> +
>>>>>>   static void nvme_tcp_revoke_generated_tls_key(struct nvme_ctrl 
>>>>>> *ctrl)
>>>>>>   {
>>>>>>       if (!ctrl->opts->concat)
>>>>>> @@ -2321,6 +2337,9 @@ static void 
>>>>>> nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>>>>>>       if (nvme_tcp_setup_ctrl(ctrl, false))
>>>>>>           goto requeue;
>>>>>> +    if (nvme_tcp_reset_for_secure_concat(ctrl))
>>>>>> +        return;
>>>>>> +
>>>>>>       dev_info(ctrl->device, "Successfully reconnected (%d 
>>>>>> attempt)\n",
>>>>>>               ctrl->nr_reconnects);
>>>>>> @@ -2396,6 +2415,7 @@ static void nvme_reset_ctrl_work(struct 
>>>>>> work_struct *work)
>>>>>>       if (nvme_tcp_setup_ctrl(ctrl, false))
>>>>>>           goto out_fail;
>>>>>> +    nvme_tcp_reset_for_secure_concat(ctrl);
>>>>>
>>>>> This is really strange. I'd imagine that this would be needed only 
>>>>> if the derived psk expired no?
>>>>
>>>> You are absolutely correct. But once you reset the connection the 
>>>> derived PSK of the previous connection _is_ expired as DH-HMAC-CHAP
>>>> generated a new one.
>>>>
>>>> Remember: for secure concatenation we _always_ have a two-step 
>>>> connection setup. The initial connection runs for DH-HMAC-CHAP
>>>> to generate the PSK, and then a connection reset to start over
>>>> with TLS and the generated PSK.
>>>> So upon reset we have to invalidate the generated PSK, reset the
>>>> connection to run DH-HMAC-CHAP, and reset _again_ to start over
>>>> with the new PSK.
>>>
>>> So what is the point of setting the derived psk with a timeout?
>>>
>>> Seems rather silly doing that _every_ reset/reconnect... But ok...
>>
>> Mandated by TP8018. Generated TLS PSK should be renewed after a
>> certain time. Makes sense in general, but still a pain.
> 
> I understand that psk can expire, I don't understand why we need to 
> reset every
> single time. What if I'm doing the loop: while true; do nvme reset 
> /dev/nvme0; done?
> 
> Will it do 2 resets every time?

For secure concatenation: yes.

Secure concatenation consists on running DH-HMAC-CHAP, generate a TLS 
PSK from the generated credentials, and then start TLS with the 
generated TLS PSK. This is run for every connection attempt, so each
connection attempt gets a new TLS PSK; after the connection is reset
the old PSK _cannot_ be reused, and we need to clear them up via
some sort of garbage collection. By adding an expiration time to the
key we achieve exactly this.
And that is why we need to reset twice; we need to run the DH-HMAC-CHAP
protocol _after_ recovery, and use the generated keys to establish a
TLS connection. And as the TLS connection is established before the
initial connect is sent we need to reset the connection after the
DH-HMAC-CHAP protocol is run (as this is run _after_ the connect command).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


