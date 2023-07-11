Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C34C001DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 12:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QhBZ9E68/KNhCgF/DMNKp5345TgIMQqbw5RUqHFiS+M=; b=u2q6nKaluEw8vunH9zzKKk2aTJ
	sUq2RzxGLpIwK/Ktr2meM4elbR6CJQ6ONX03VEW2FBUL3RR5yZv2oYfceT9Y0I+kQsia4mVXN81g3
	SU5/75qdRjeDUEnHksxW5k46lIiAWLzS5ABtVIDPjwk2WiAYm8okSH64R/P9KjdGHoAIBA+FxdQdy
	hCRQIwDCNFsPZp57NyO4VWHMmwwzwvqPTySHJWhCtNwWEqu3NIPfK+55kqN0au8IEFHK+Hp1LbKEw
	Lzy5sGDKScGbxjcT1fOi4XTwoy1+VJE/TjB9S26q20Lpat0RAXlv95qJpMEiad4YsjO3x3rAyFLDY
	KvBMk1Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJC7L-00EpDk-1b;
	Tue, 11 Jul 2023 12:05:19 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJC7I-00EpBA-2W
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 12:05:18 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fa86b08efcso10916725e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 05:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077106; x=1691669106;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhBZ9E68/KNhCgF/DMNKp5345TgIMQqbw5RUqHFiS+M=;
        b=X8WvKtbfsy/eZPhc65gqoPZ4M6dYXNbSB4+6D17FbKdHL8JnuJSACOMhN2KBIeLI+Q
         bQnSA+pBYAk/A/0j/DgQYfl7bqeGN+z/R7gwFsGdJoQgeADDuCo/XMpCW0T9vQYDyr4Q
         eD4ko8SwfNxv0/2c2HW0zlVVWxDq1t5Q+BGDCzjgCp0bFja0NBTmwjhT/EQs3VLdHtHe
         pNO4JJKnLJR3c40tdMpi/2Wa1mTxYCPU+wz0jqYQXCT44uy+Va38NCPWVgBWZM82+wVY
         0bWcumIAslgK1DunjBbipXXkdmgD7qQs8e5LAjn2kPMZrWWnpITJI1Lp3RkLWRPhp7mT
         cPAw==
X-Gm-Message-State: ABy/qLaOfIbN7AGn39ZPmotDPpn39n0ZiNvaacAHL6sX3XUgTu4tKSbq
	+TU/UnisLZ9vuxErHBeZgPRgQy7gsJk=
X-Google-Smtp-Source: APBJJlHlvKt9tP+fJJ6RXtFhuUYmbsXoX7ZtxH7wl+r6gz2f3/30ameUHMPWlHano3IYGDsP8gh9gw==
X-Received: by 2002:a05:600c:1c0a:b0:3fa:97b1:b12d with SMTP id j10-20020a05600c1c0a00b003fa97b1b12dmr18848105wms.2.1689077105614;
        Tue, 11 Jul 2023 05:05:05 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y23-20020a1c4b17000000b003fbd0c50ba2sm12806367wma.32.2023.07.11.05.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 05:05:05 -0700 (PDT)
Message-ID: <6a9e0fbf-ca1a-aadd-e79a-c70ecd14bc28@grimberg.me>
Date: Tue, 11 Jul 2023 15:05:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: nvme-tls and TCP window full
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <f10a9e4a-b545-429d-803e-c1d63a084afe@suse.de>
 <49422387-5ea3-af84-3f94-076c94748fff@grimberg.me>
 <ed5b22c6-d862-8706-fc2e-5306ed1eaad2@grimberg.me>
 <a50ee71b-8ee9-7636-917d-694eb2a482b4@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <a50ee71b-8ee9-7636-917d-694eb2a482b4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_050516_817704_D587BA1D 
X-CRM114-Status: GOOD (  21.88  )
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


>> Hey Hannes,
>>
>> Any progress on this one?
>>
> Oh well; slow going.
> After some length debugging I found that the read_sock() implementation 
> wasn't exactly up to scratch (it would read each byte individually, 
> instead of each skb individually ... D'oh).
> But even with that fixed I'm still seeing I/O stalls due to window full:

What does your current read_sock look like?

One thing that looks incorrect is that you should be calling
tls_rx_rec_wait() in a loop as long as it returns 1 no? This way
you will continue to consume as long as you have something in the
sk ready for process...

Something like (the completely untested):
do {
	if (!skb) {
		if (!skb_queue_empty(&ctx->rx_list)) {
			skb = __skb_dequeue(&ctx->rx_list);
		} else {
			struct tls_decrypt_arg darg;

			err = tls_rx_rec_wait(sk, NULL, true, true);
			if (err <= 0) {
				tls_rx_reader_release(sk, ctx);
				return err;
			}

			memset(&darg.inargs, 0, sizeof(darg.inargs));

			err = tls_rx_one_record(sk, NULL, &darg);
			if (err < 0) {
				tls_err_abort(sk, -EBADMSG);
				tls_rx_reader_release(sk, ctx);
				return err;
			}

			tls_rx_rec_done(ctx);
			skb = darg.skb;
	}

	rxm = strp_msg(skb);
	tlm = tls_msg(skb);

	/* read_sock does not support reading control messages /
	if (tlm->control != TLS_RECORD_TYPE_DATA) {
		err = -EINVAL;
		goto read_sock_requeue;
	}

	used = read_actor(desc, skb, rxm->offset, rxm->full_len);
	if (used <= 0) {
		err = used;
		goto read_sock_end;
	}

	copied += used;
	if (used < rxm->full_len) {
		rxm->offset += used;
		rxm->full_len -= used;
		if (!desc->count)
			goto read_sock_requeue;
	} else {
		consume_skb(skb);
		if (desc->count && skb_queue_empty(&ctx->rx_list))
			skb = __skb_dequeue(&ctx->rx_list);
		else
			skb = NULL;
	}
} while (skb);

> 
> [85639.669120] nvme nvme0: queue 2: C2H data cid 0x4d offset 0 len 4096
> [85639.669885] nvme nvme0: queue 2: PDU Data cid 0x4d offset 29 len 4120 
> rem 4096

what is rem? remaining? what is this derived from? the PDU or skb?

> [85639.670809] nvme nvme0: queue 2: RSP cid 0x4d status 0
> [85639.671449] nvme nvme0: queue 2: pdu 24 data 0 consumed 4144 result 0
> [85639.674928] nvme nvme0: queue 2: skb 00000000bee9b76d len 8262 offset 
> 5 len 8240

What is offset? skb offset?

> [85639.676474] nvme nvme0: queue 2: C2H data cid 0x4e offset 0 len 8192
> [85639.678013] nvme nvme0: queue 2: PDU Data cid 0x4e offset 29 len 8216 
> rem 8192

offset is 29? is that pdu offset? should be 24? does it somehow combine
the offset 5 from above?

It is not very clear what the prints are...

> [85639.679810] nvme nvme0: queue 2: RSP cid 0x4e status 0
> [85639.681247] nvme nvme0: queue 2: pdu 24 data 0 consumed 8240 result 0
> [85639.690985] nvme nvme0: queue 2: skb 00000000bee9b76d len 16406 
> offset 5 len 16384
> [85639.692321] nvme nvme0: queue 2: C2H data cid 0x4f offset 0 len 126976
> [85639.694012] nvme nvme0: queue 2: PDU Data cid 0x4f offset 29 len 
> 16360 rem 126976
> [85639.695882] nvme nvme0: queue 2: pdu 0 data 110616 consumed 16384 
> result 0
> [85639.697667] nvme nvme0: queue 2: skb 00000000bee9b76d len 16406 
> offset 5 len 16384
> [85639.699339] nvme nvme0: queue 2: PDU Data cid 0x4f offset 5 len 16384 
> rem 110616
> [85639.701122] nvme nvme0: queue 2: pdu 0 data 94232 consumed 16384 
> result 0
> [85639.702831] nvme nvme0: queue 2: skb 00000000bee9b76d len 16406 
> offset 5 len 16384
> [85639.704918] nvme nvme0: queue 2: PDU Data cid 0x4f offset 5 len 16384 
> rem 94232
> [85639.706759] nvme nvme0: queue 2: pdu 0 data 77848 consumed 16384 
> result 0
> [85639.708367] nvme nvme0: queue 2: skb 00000000bee9b76d len 16406 
> offset 5 len 16384
> [85639.711219] nvme nvme0: queue 2: PDU Data cid 0x4f offset 5 len 16384 
> rem 77848
> [85639.712108] nvme nvme0: queue 2: pdu 0 data 61464 consumed 16384 
> result 0
> [85639.714182] nvme nvme0: queue 2: skb 00000000bee9b76d len 16406 
> offset 5 len 16384
> [85639.715107] nvme nvme0: queue 2: PDU Data cid 0x4f offset 5 len 16384 
> rem 61464
> [85639.715989] nvme nvme0: queue 2: pdu 0 data 45080 consumed 16384 
> result 0
> [85671.510572] nvme nvme0: queue 2: timeout cid 0x4f type 4 opcode 0x2 
> (Read)
> 
> (These are just client-side logs).
> Which looks to me as if we're waiting for the server to continue sending
> PDU data frames, only these never arrive.

I think it is more likely that you are losing sync on the stream...
Maybe the server is done sending data, but if you have a bug processing
it the client think that more is coming...

What is the workload you are testing? Is this workload dependent? small bs?

> So really I wonder whether it's not rather an issue on the server side.

The variable you added here is the read_sock, so I would suspect that
this would be your offender.

> Maybe the server doesn't retire skbs (or not all of them), causing the 
> TCP window to shrink.
> That, of course, is wild guessing, as I have no idea if and how calls to 
> 'consume_skb' reflect back to the TCP window size.

skbs are unrelated to the TCP window. They relate to the socket send
buffer. skbs left dangling would cause server side to run out of memory,
not for the TCP window to close. The two are completely unrelated.

