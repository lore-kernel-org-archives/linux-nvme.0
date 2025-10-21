Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F60BCCD19F
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Oct 2025 06:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AP37Hl7dZsrUQCdo+Wy/Ujr92FdnjRQ8OmnuPgn1zdc=; b=dLlCijzDcr0GrYDoz+vczpBIf4
	+sAomxaze25inmzlf/FsFGJD68azTdhsvqkAK7/oda8FBYY+fFi4M8rGpdeCzToEi2AjhtAaOZRV+
	WDGH+gx8MY0BHWutsqzc0UWlEWz92TcbXKKCnIQvOp4XXprEuvGKlypar8bUW+qdW1E6or7BiGZoB
	C/2Jy89EiQlR7bCsWTfYd5rETDdyYx6mKKukes+csYgHGF3bluXY9TyeLyG0YyxV8PMZ2mR85XiIw
	9E4eGy0/p3X1VPI+tKiZALbLb5jnG/WPPfFzq0m95zFiaLWtqoQmiTDFR/PvJy8mKm7Dm3sM0MGvM
	Lz3k8BTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB62l-0000000FwU9-34up;
	Tue, 21 Oct 2025 06:40:28 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB62j-0000000FwSj-2vko
	for linux-nvme@lists.infradead.org;
	Tue, 21 Oct 2025 06:40:26 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E0E6A1F38E;
	Tue, 21 Oct 2025 06:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761028818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AP37Hl7dZsrUQCdo+Wy/Ujr92FdnjRQ8OmnuPgn1zdc=;
	b=CMTIph/GAzMOCdEHm0P4Cw7YR/1co+dCMqkANZjNCKckEHYg3PQE0JeYB4MOusIm9DEpcB
	6uBk9aNiN05EMHxDXS6yFAqNloWDbXetkatKy6oTwhkYTUvM28sgJDZ7WqHVNQvM30aX4p
	tAqbQhdiviRnQ9NYhcwTqxv2YS2hTEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761028818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AP37Hl7dZsrUQCdo+Wy/Ujr92FdnjRQ8OmnuPgn1zdc=;
	b=CIv2sfn8/Dm79W/Pz6mAjMTJ0dFtqsDhPRuSHc8MG7C0xzlB4MMcJojOhV89H0ETkn9lC+
	PP40BgQodw7XEpBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761028813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AP37Hl7dZsrUQCdo+Wy/Ujr92FdnjRQ8OmnuPgn1zdc=;
	b=XbgvKi4LGXTo/hXoDJ0p7shBMgXtuKo3oTBqOWzxHZM4yS8DWHhs/cW8BPx9vuxIeBEHec
	uXRJ+Uzc/dzkc8qJTO4ShOM/uGCEgW+872gMvnifsmE8iubh8NOutkY5qi0hDnkE2T9AlB
	C5Hq8pfaWdp4XYFtWcespOxSERbJN0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761028813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AP37Hl7dZsrUQCdo+Wy/Ujr92FdnjRQ8OmnuPgn1zdc=;
	b=EVODCKCPUVXPU5aL7wKcV3mOyNR3SjmFmGUYhXJZk7NG5/XAAb96buUNZ8A0/0ED/gklZn
	bJhMf2e37m9qq3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 100D4139D2;
	Tue, 21 Oct 2025 06:40:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SdgBAc0q92gOJQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 21 Oct 2025 06:40:13 +0000
Message-ID: <ddadb1f6-d7e9-427d-baf7-814d2288a407@suse.de>
Date: Tue, 21 Oct 2025 08:40:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] nvme-tcp: Support receiving KeyUpdate requests
To: Alistair Francis <alistair23@gmail.com>
Cc: chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <fe16288e-e3f2-4de3-838e-181bbb0ce3ee@suse.de>
 <CAKmqyKP0eB_WTZtMqtaNELPE4Bs9Ln-0U+_Oqk8fuJXTay_DPg@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKP0eB_WTZtMqtaNELPE4Bs9Ln-0U+_Oqk8fuJXTay_DPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_234025_888887_D057BC5F 
X-CRM114-Status: GOOD (  17.61  )
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

On 10/21/25 03:01, Alistair Francis wrote:
> On Tue, Oct 21, 2025 at 3:46 AM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 10/17/25 06:23, alistair23@gmail.com wrote:
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> The TLS 1.3 specification allows the TLS client or server to send a
>>> KeyUpdate. This is generally used when the sequence is about to
>>> overflow or after a certain amount of bytes have been encrypted.
>>>
>>> The TLS spec doesn't mandate the conditions though, so a KeyUpdate
>>> can be sent by the TLS client or server at any time. This includes
>>> when running NVMe-OF over a TLS 1.3 connection.
>>>
>>> As such Linux should be able to handle a KeyUpdate event, as the
>>> other NVMe side could initiate a KeyUpdate.
>>>
>>> Upcoming WD NVMe-TCP hardware controllers implement TLS support
>>> and send KeyUpdate requests.
>>>
>>> This series builds on top of the existing TLS EKEYEXPIRED work,
>>> which already detects a KeyUpdate request. We can now pass that
>>> information up to the NVMe layer (target and host) and then pass
>>> it up to userspace.
>>>
>>> Userspace (ktls-utils) will need to save the connection state
>>> in the keyring during the initial handshake. The kernel then
>>> provides the key serial back to userspace when handling a
>>> KeyUpdate. Userspace can use this to restore the connection
>>> information and then update the keys, this final process
>>> is similar to the initial handshake.
>>>
>>
>> I am rather sceptical at the current tlshd implementation.
>> At which place do you update the sending keys?
> 
> The sending keys are updated as part of gnutls_session_key_update().
> 
> gnutls_session_key_update() calls update_sending_key() which updates
> the sending keys.
> 
> The idea is that when the sequence number is about to overflow the
> kernel will request userspace to update the sending keys via the
> HANDSHAKE_KEY_UPDATE_TYPE_SEND key_update_type. Userspace updates the
> keys and initiates a KeyUpdate.
> 
That's also what the spec says.
But in order to do that we would need to get hold of the sequence
number, which currently is internal to gnutls.
Can we extract it from the session information?
And can we display it in sysfs, to give users information
whether a KeyUpdate had happened?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

