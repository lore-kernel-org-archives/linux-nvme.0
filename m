Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C50CCD1AB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 07:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tlxJGX9jmOI/wD5Rfy1iJYXebHEOfbhjGU0gFhwqz/4=; b=sbMTipfmcVACHsNj7F+2GOHnwQ
	EKokQRX4Oe+b8wQLKlrhhAjfI2FcHcefhsxLHnsycoxk+ajnJiTRJxNe+wM0CRHkPvTRgOLVC4TBk
	e+xOPSJMPXqFg3Ib+3tKtb+z9O2maxcZC7BSwzvutxgzIoHAnEgJq3TQXOcblqzPdom300qStDNf6
	aQjnOFCnB1v9X/Wq5BHfVdWCsYzdhq42/vzw7iIpD4a8EudL/hvvz1YhW4tYlbe/OqnQjUjZJup+9
	I7hAXKGUlO4wMOMFDqpH/XOgmk2axENPpQA27wwNjeuAEXCJP5Vza+clxV0CTajG/QeyUzR027H3S
	dJc7QC3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSsW-00000001mhv-0MAF;
	Wed, 22 Oct 2025 07:03:24 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSsT-00000001mh5-24Fw
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 07:03:22 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 805E31F391;
	Wed, 22 Oct 2025 07:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761116595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlxJGX9jmOI/wD5Rfy1iJYXebHEOfbhjGU0gFhwqz/4=;
	b=Yqt7Im04iuAbx4JPcGFjXhCh26p8TrP2xHtxdlJVXzLFiu/lnu2T6bzQSwPl3lB7DivkMR
	s0i1WOmkB+AJFcBuINdBFxFjNvvsEfQXhPwQ7MUF/keyxeqL5uObBq3q9n0/eg11AATvDt
	QnGoOAUEbL/OSLQAvy1/SzleVWitnvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761116595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlxJGX9jmOI/wD5Rfy1iJYXebHEOfbhjGU0gFhwqz/4=;
	b=EpOyLeANziBPyk4Wmxj/9bm1z/YYBdb0CrHUaofCK4ZS7toeY/r52azhxrIQ3Yo1Yc60Bk
	6MhTDHZhRxRpC2CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Vc6/2KJn";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nKEBI8Zr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761116591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlxJGX9jmOI/wD5Rfy1iJYXebHEOfbhjGU0gFhwqz/4=;
	b=Vc6/2KJnrJVn5tUpUCliUNHUfjO6I+Kb0WJa/PFhCVYTD3UDqHf6Qb76uSUg+i77R6n9ef
	Do1/XR325WhiFd5f+sYEeIJ/ae1NtgWvGV8lA7zGQj8zRYxtE9xlx6qxee8tRzLRHd0t5m
	IafmiwSH2rAcY6CopUE2AEXl93VXuQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761116591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlxJGX9jmOI/wD5Rfy1iJYXebHEOfbhjGU0gFhwqz/4=;
	b=nKEBI8ZrYU5sgkq5y6xHHHJWxfvkIKD0LvDbUqA1VeFHbeGeF3yHPRQJC9WRfeyZO3D/k3
	NUOgHMIniLvnpgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E1D113A29;
	Wed, 22 Oct 2025 07:03:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pFegI66B+GjcegAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 22 Oct 2025 07:03:10 +0000
Message-ID: <7afb2fc0-0da5-4539-a1a4-87360186cf65@suse.de>
Date: Wed, 22 Oct 2025 09:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] net/handshake: Support KeyUpdate message types
To: Alistair Francis <alistair23@gmail.com>
Cc: chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-5-alistair.francis@wdc.com>
 <e7d46c17-5ffd-4816-acd2-2125ca259d20@suse.de>
 <CAKmqyKMsYUPLz9hVmM_rjXKSo52cMEtn8qVwbSs=UknxRWaQUw@mail.gmail.com>
 <CAKmqyKNSV1GdipOrOs3csyoTMKX1+mxTgxnOq9xnb3vmRN0RgA@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKNSV1GdipOrOs3csyoTMKX1+mxTgxnOq9xnb3vmRN0RgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 805E31F391
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_000321_679929_9983C3CA 
X-CRM114-Status: GOOD (  15.19  )
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

On 10/22/25 06:40, Alistair Francis wrote:
> On Tue, Oct 21, 2025 at 1:19 PM Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Mon, Oct 20, 2025 at 4:09 PM Hannes Reinecke <hare@suse.de> wrote:
>>>
>>> On 10/17/25 06:23, alistair23@gmail.com wrote:
>>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>>
[ .. ]>>>> @@ -372,6 +384,44 @@ int tls_client_hello_psk(const struct 
tls_handshake_args *args, gfp_t flags)
>>>>    }
>>>>    EXPORT_SYMBOL(tls_client_hello_psk);
>>>>
>>>> +/**
>>>> + * tls_client_keyupdate_psk - request a PSK-based TLS handshake on a socket
>>>> + * @args: socket and handshake parameters for this request
>>>> + * @flags: memory allocation control flags
>>>> + * @keyupdate: specifies the type of KeyUpdate operation
>>>> + *
>>>> + * Return values:
>>>> + *   %0: Handshake request enqueue; ->done will be called when complete
>>>> + *   %-EINVAL: Wrong number of local peer IDs
>>>> + *   %-ESRCH: No user agent is available
>>>> + *   %-ENOMEM: Memory allocation failed
>>>> + */
>>>> +int tls_client_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
>>>> +                          handshake_key_update_type keyupdate)
>>>> +{
>>>> +     struct tls_handshake_req *treq;
>>>> +     struct handshake_req *req;
>>>> +     unsigned int i;
>>>> +
>>>> +     if (!args->ta_num_peerids ||
>>>> +         args->ta_num_peerids > ARRAY_SIZE(treq->th_peerid))
>>>> +             return -EINVAL;
>>>> +
>>>> +     req = handshake_req_alloc(&tls_handshake_proto, flags);
>>>> +     if (!req)
>>>> +             return -ENOMEM;
>>>> +     treq = tls_handshake_req_init(req, args);
>>>> +     treq->th_type = HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE;
>>>> +     treq->th_key_update_request = keyupdate;
>>>> +     treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
>>>> +     treq->th_num_peerids = args->ta_num_peerids;
>>>> +     for (i = 0; i < args->ta_num_peerids; i++)
>>>> +             treq->th_peerid[i] = args->ta_my_peerids[i];
>>> Hmm?
>>> Do we use the 'peerids'?
>>
>> We don't, this is just copied from the
>> tls_client_hello_psk()/tls_server_hello_psk() to provide the same
>> information to keep things more consistent.
>>
>> I can remove setting these
> 
> Actually, ktls-utils (tlshd) expects these to be set, so I think we
> should leave them as is
> 

Can't we rather fix up tlshd?
It feels really pointless, erroring out on values which are completely
irrelevant for the operation...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

