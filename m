Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38645CAC598
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Sep 2025 10:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5E9/S7qoG8T5tftMOCDuagTwyxXbc7UL6OlEQkZhyWA=; b=bSbTuRt4LQqad4ntVMzfuCdKeI
	MATfTft5I/yjZQK3Bdfc4dMG2J/WZEb2zybFP1MWdyyNKzSJ46+ikxQomC/QS64/lmBlwIzh0Hr7Y
	2WwN21GGu5kMwCfrwIoS6ix55gRJ5WO4Z5zC4/yfg03C0TJdjT0RjVh4jXkvH1ENM4yb4Qv0YWw6Y
	ldIqSfL88n4rLCCZwcal47Jq25Xc5Nyy36o89Ef3UNcSTDQ/+zbbgdJo6Vy5ukqJsmKijXt9xUoRV
	CVoCXg1uPbF03aTYoHzPvcYyLaiPk2eNhulcRIu0STLGnnXOmetKtUOADPfiruTZN9V7n45ig6Nwb
	mZ7CC/xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyp9R-0000000Ava0-11Dn;
	Wed, 17 Sep 2025 10:12:37 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyp9P-0000000AvZW-0K7y
	for linux-nvme@lists.infradead.org;
	Wed, 17 Sep 2025 10:12:36 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3590D1F79A;
	Wed, 17 Sep 2025 10:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758103953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E9/S7qoG8T5tftMOCDuagTwyxXbc7UL6OlEQkZhyWA=;
	b=x/WjXV+Zb4dAahPF7MRFFPXIyt2+sPQRn9izyvT9TdzG8VnQzNXqBDf5wCF2qFkUo1XhPR
	Pr89ohH3MZnPfV9sfx584yzuBY7pMt1zP+egj49R2CytGsywgsuOomHDPYOqYMxMuGKf+k
	SwiQ092qzgSRrgUpEIDuTlROglhrZwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758103953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E9/S7qoG8T5tftMOCDuagTwyxXbc7UL6OlEQkZhyWA=;
	b=LRMRUKwGtiWrvLEIswJYKOY0uqpd274iUtmhNlx2QyrlRgwC9L8lngiYiV9gQq/hiKL9k7
	AEBq5o6/bMp9rECw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758103953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E9/S7qoG8T5tftMOCDuagTwyxXbc7UL6OlEQkZhyWA=;
	b=x/WjXV+Zb4dAahPF7MRFFPXIyt2+sPQRn9izyvT9TdzG8VnQzNXqBDf5wCF2qFkUo1XhPR
	Pr89ohH3MZnPfV9sfx584yzuBY7pMt1zP+egj49R2CytGsywgsuOomHDPYOqYMxMuGKf+k
	SwiQ092qzgSRrgUpEIDuTlROglhrZwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758103953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E9/S7qoG8T5tftMOCDuagTwyxXbc7UL6OlEQkZhyWA=;
	b=LRMRUKwGtiWrvLEIswJYKOY0uqpd274iUtmhNlx2QyrlRgwC9L8lngiYiV9gQq/hiKL9k7
	AEBq5o6/bMp9rECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5A6D137C3;
	Wed, 17 Sep 2025 10:12:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ZhVN5CJymjjLwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 17 Sep 2025 10:12:32 +0000
Message-ID: <e168255c-82a0-4b9a-b155-cb90e6162870@suse.de>
Date: Wed, 17 Sep 2025 12:12:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] nvme-tcp: Support KeyUpdate
To: Alistair Francis <alistair23@gmail.com>
Cc: chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-7-alistair.francis@wdc.com>
 <f1a7b0b5-65e3-4cd0-9c62-50bbb554e589@suse.de>
 <CAKmqyKM6_Fp9rc5Fz0qCsNq7yCGGb-o66XhycJez2nzcEs5GmA@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKM6_Fp9rc5Fz0qCsNq7yCGGb-o66XhycJez2nzcEs5GmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_031235_272638_4AB3AE40 
X-CRM114-Status: GOOD (  21.30  )
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

On 9/17/25 05:14, Alistair Francis wrote:
> On Tue, Sep 16, 2025 at 11:04 PM Hannes Reinecke <hare@suse.de> wrote:
>>
[ .. ]
>> Oh bugger. Seems like gnutls is generating the KeyUpdate message
>> itself, and we have to wait for that.
> 
> Yes, we have gnutls generate the message.
> 
>> So much for KeyUpdate being transparent without having to stop I/O...
>>
>> Can't we fix gnutls to make sending the KeyUpdate message and changing
>> the IV parameters an atomic operation? That would be a far better
> 
> I'm not sure I follow.
> 
> ktls-utils will first restore the gnutls session. Then have gnutls
> trigger a KeyUpdate.gnutls will send a KeyUpdate and then tell the
> kernel the new keys. The kernel cannot send or encrypt any data after
> the KeyUpdate has been sent until the keys are updated.
> 
> I don't see how we could make it an atomic operation. We have to stop
> the traffic between sending a KeyUpdate and updating the keys.
> Otherwise we will send invalid data.
> 
Fully agree with that.
But thing is, the KeyUpdate message is a unidirectional thing.
Host A initiating a KeyUpdate must only change the _sender_ side
keys after sending a KeyUpdate message to host B; the receiver
side keys on host A can only be update once it received the 
corresponding KeyUpdate from host B. If both keys on host A
are modified at the same time we cannot receive the KeyUpdate
message from host B as that will be encoded with the old
keys ...

I wonder how that can be modeled in gnutls; I only see
gnutls_session_key_update() which apparently will update both
keys at once.
Which would fit perfectly for host B receiving the initial KeyUpdate,
(and is probably the reason why you did that side first :-)
but what to do for host A?

Looking at the code gnutls seem to expect to read the handshake
message from the socket, but that message is already processed by
the in-kernel TLS socket.
So either we need to patch gnutls or push a fake handshake
message onto the socket for gnutls to read. Bah.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

