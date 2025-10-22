Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF140CCD1BF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 06:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rx8DJYuxgTbtWD3EG43xudBz/lgkdwbOWUShBy3f9Jc=; b=EZkZhnRQmKcU1v632pcfNo39AI
	eP+9x3sSAPUakwt9lMiXUF81v55w/JJxY7p+0GBh4cQqpMefjdGyHygrLsr85mQOt3Xbqyr89Y04D
	7aLuEGJhsLOUWXwwTn2ETMSNrJKZ0KIZTm41kPKcn+dC27IiuqXhs+FuBLwUpTqAjWwEpI6yWAwCT
	jGV/henxqrNn+PelIT1VUFicILVt/McOBIHlNCXrVuCDOhAeE63w3ZyI0kATWyxBQLLI7rHIzsLOO
	jjihqQFj1yH8N5P2cZiv9lOHAlkI8BeilLKc9WkBwZoNCtwITxUgghk8Tr8mWdyW/WjOM5mnZqdVr
	NpMrowJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSmO-00000001kcA-1VBA;
	Wed, 22 Oct 2025 06:57:04 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSmM-00000001kb9-0NGc
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 06:57:03 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5ED11F38D;
	Wed, 22 Oct 2025 06:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761116214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx8DJYuxgTbtWD3EG43xudBz/lgkdwbOWUShBy3f9Jc=;
	b=Hm85UpzWcum4e7txV0UEEFJ29U/jlHgtQ4qH6RuCV7kLNTJYIA+EGW0j2JsnMPMwERZ+Wl
	puRK81INf5XX0jKtSeIDrXAD8UlMpTGi8Fy3TtoZ2RPkOx5IPEhRV5C3f2rax9FUL+dZzu
	+wIVEOo1E5wg7ZI+YU0Layjh0aD4LmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761116214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx8DJYuxgTbtWD3EG43xudBz/lgkdwbOWUShBy3f9Jc=;
	b=2TBdz6NviOX+2CBmad8Y4BSxo+23Z259FmCmu4SjFfLwbqJZvE0S2FtSQ6Z8TY9hZpz7l5
	wWBef15x0fh/rOAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MlixlT1K;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="4Jp/cJAb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761116210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx8DJYuxgTbtWD3EG43xudBz/lgkdwbOWUShBy3f9Jc=;
	b=MlixlT1K5vWDod5mnzmjrqH+zeoRq9vUCRLedWmAH0n67PWykXMi7akbK6/mg5piPZeDHt
	ss425rLTZoaCh65HOpLS2yTME3Q3xa/P814heROGqUll+WdZSfnDRY3CgPhN4W7wBq5LIV
	izCqyDjhPyPES/qmxuIYZRPS7w/Q7Ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761116210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx8DJYuxgTbtWD3EG43xudBz/lgkdwbOWUShBy3f9Jc=;
	b=4Jp/cJAbhag3/g8ao1mWaHUrIxz65ak2h7nqE/i/yKW47JTRuHLyCw2JKrgS4w0/BwpodA
	sfLPLNMexXtGn+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B020713A29;
	Wed, 22 Oct 2025 06:56:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wfoeKDGA+GhVdQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 22 Oct 2025 06:56:49 +0000
Message-ID: <4b2e5998-a646-4f99-8c87-95975ff8fe66@suse.de>
Date: Wed, 22 Oct 2025 08:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] nvme-tcp: Support KeyUpdate
To: Alistair Francis <alistair23@gmail.com>
Cc: chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-6-alistair.francis@wdc.com>
 <dc19d073-0266-4143-9c74-08e30a90b875@suse.de>
 <CAKmqyKNBN7QmpC8Lb=0xKJ7u9Vru2mfTktwKgtyQURGmq4gUtg@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKNBN7QmpC8Lb=0xKJ7u9Vru2mfTktwKgtyQURGmq4gUtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A5ED11F38D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[wdc.com:email,suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[15];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_235702_272998_969E2FDB 
X-CRM114-Status: GOOD (  12.44  )
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

On 10/22/25 06:35, Alistair Francis wrote:
> On Mon, Oct 20, 2025 at 4:22 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 10/17/25 06:23, alistair23@gmail.com wrote:
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
[ .. ]>>> @@ -1723,6 +1763,7 @@ static void nvme_tcp_tls_done(void 
*data, int status, key_serial_t pskid,
>>>                        ctrl->ctrl.tls_pskid = key_serial(tls_key);
>>>                key_put(tls_key);
>>>                queue->tls_err = 0;
>>> +             queue->user_session_id = user_session_id;
>>
>> Hmm. I wonder, do we need to store the generation number somewhere?
>> Currently the sysfs interface is completely oblivious that a key update
>> has happened. I really would like to have _some_ indicator there telling
>> us that a key update had happened, and the generation number would be
>> ideal here.
> 
> I don't follow.
> 
> The TLS layer will report the number of KeyUpdates that have been
> received. Userspace also knows that a KeyUpdate happened as we call to
> userspace to handle updating the keys.
> 
Oh, the tlshd will know that (somehow). But everyone else will not; the
'tls_pskid' contents will stay the the same.
Can we have a sysfs attribute reporting the sequence number of the most
recent KeyUpdate?
Cheers,
Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

