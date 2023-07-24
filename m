Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53A8C0015E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QP/WVjCIONboJunkMSgHtybWCZ4waVswj2O82yhFIeM=; b=B2UJ4GE0R/0xoRCvCrWEyfPgna
	IS4oimThby/goRAgcqWVrD8wtUAn5huZe8yZq9UjwXn038Yrw2Nh+A9DGs74AHYX5vnadU6p55GbX
	fP7B3JDRbCWemO/JWZWZksd58ryXZ6urYh6ZbejWLnGB5Vf9OSzfTg6VBt+cTaw3f4X9/cx05I1kh
	4mYP6Z1Zs414wnp2TWIsPfOvDcvn7AVIVWReEhYWT8bso75DOdyJMCvSWxsOMonT8E2O4ULS3lEOu
	kY+Vcly4yv3sIZZyDdFJkJz2Hv5HygoRFJq8htzrhaIG4RMfY67bor8sPVOT6civj+zq8SDX6CiXg
	ns5zIc/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNvuU-004Vph-1h;
	Mon, 24 Jul 2023 13:47:38 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNvuR-004Vlp-06
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 13:47:36 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F7B01FD71;
	Mon, 24 Jul 2023 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690206442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QP/WVjCIONboJunkMSgHtybWCZ4waVswj2O82yhFIeM=;
	b=zQ90BDSJ177kl/6Gc7knyVvOAkOiru771Pm0Kkg0p/G/2bQ+h3Qu4Fzl+NthL6Zvk4cAdE
	t82RxmV2lfidkPPwkfdx8Xn/RiE7aKHDrSTAuoN79L+zl6gpjjObe3B6FgCegIuqb50tmA
	21eDQAx7KCEym5T+0SGfnM1OxUtU3sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690206442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QP/WVjCIONboJunkMSgHtybWCZ4waVswj2O82yhFIeM=;
	b=rvu4r5tAE+zz0pTIFald55LFnNE7m1pk09VmPNJpl2pGaBQBt0kGTYo6qlyKMTvzyB4BEq
	Rd6woS2ul0sVRPCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B93013476;
	Mon, 24 Jul 2023 13:47:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EA4EEeqAvmRCRgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 24 Jul 2023 13:47:22 +0000
Message-ID: <002b18c9-f2cc-046d-def8-f99bd9e0125d@suse.de>
Date: Mon, 24 Jul 2023 15:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/6] net/tls: implement ->read_sock()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230721143523.56906-1-hare@suse.de>
 <20230721143523.56906-7-hare@suse.de>
 <5196edbd-45dc-8542-975b-1a49e4061668@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5196edbd-45dc-8542-975b-1a49e4061668@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_064735_210892_3F617A0A 
X-CRM114-Status: GOOD (  22.05  )
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

On 7/24/23 14:59, Sagi Grimberg wrote:
> 
> 
> On 7/21/23 17:35, Hannes Reinecke wrote:
>> Implement ->read_sock() function for use with nvme-tcp.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> Cc: Boris Pismenny <boris.pismenny@gmail.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: netdev@vger.kernel.org
>> ---
>>   net/tls/tls.h      |  2 ++
>>   net/tls/tls_main.c |  2 ++
>>   net/tls/tls_sw.c   | 89 ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 93 insertions(+)
>>
>> diff --git a/net/tls/tls.h b/net/tls/tls.h
>> index 86cef1c68e03..7e4d45537deb 100644
>> --- a/net/tls/tls.h
>> +++ b/net/tls/tls.h
>> @@ -110,6 +110,8 @@ bool tls_sw_sock_is_readable(struct sock *sk);
>>   ssize_t tls_sw_splice_read(struct socket *sock, loff_t *ppos,
>>                  struct pipe_inode_info *pipe,
>>                  size_t len, unsigned int flags);
>> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>> +             sk_read_actor_t read_actor);
>>   int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t 
>> size);
>>   void tls_device_splice_eof(struct socket *sock);
>> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
>> index b6896126bb92..7dbb8cd8f809 100644
>> --- a/net/tls/tls_main.c
>> +++ b/net/tls/tls_main.c
>> @@ -962,10 +962,12 @@ static void build_proto_ops(struct proto_ops 
>> ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
>>       ops[TLS_BASE][TLS_SW  ] = ops[TLS_BASE][TLS_BASE];
>>       ops[TLS_BASE][TLS_SW  ].splice_read    = tls_sw_splice_read;
>>       ops[TLS_BASE][TLS_SW  ].poll        = tls_sk_poll;
>> +    ops[TLS_BASE][TLS_SW  ].read_sock    = tls_sw_read_sock;
>>       ops[TLS_SW  ][TLS_SW  ] = ops[TLS_SW  ][TLS_BASE];
>>       ops[TLS_SW  ][TLS_SW  ].splice_read    = tls_sw_splice_read;
>>       ops[TLS_SW  ][TLS_SW  ].poll        = tls_sk_poll;
>> +    ops[TLS_SW  ][TLS_SW  ].read_sock    = tls_sw_read_sock;
>>   #ifdef CONFIG_TLS_DEVICE
>>       ops[TLS_HW  ][TLS_BASE] = ops[TLS_BASE][TLS_BASE];
>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index d0636ea13009..f7ffbe7620cb 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>> @@ -2202,6 +2202,95 @@ ssize_t tls_sw_splice_read(struct socket 
>> *sock,  loff_t *ppos,
>>       goto splice_read_end;
>>   }
>> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>> +             sk_read_actor_t read_actor)
>> +{
>> +    struct tls_context *tls_ctx = tls_get_ctx(sk);
>> +    struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
>> +    struct strp_msg *rxm = NULL;
>> +    struct sk_buff *skb = NULL;
>> +    struct sk_psock *psock;
>> +    struct tls_msg *tlm;
>> +    ssize_t copied = 0;
>> +    int err, used;
>> +
>> +    psock = sk_psock_get(sk);
>> +    if (psock) {
>> +        sk_psock_put(sk, psock);
>> +        return -EINVAL;
>> +    }
>> +    err = tls_rx_reader_acquire(sk, ctx, true);
>> +    if (err < 0)
>> +        return err;
>> +
>> +    /* If crypto failed the connection is broken */
>> +    err = ctx->async_wait.err;
>> +    if (err)
>> +        goto read_sock_end;
>> +
>> +    do {
>> +        if (!skb_queue_empty(&ctx->rx_list)) {
>> +            skb = __skb_dequeue(&ctx->rx_list);
>> +            rxm = strp_msg(skb);
>> +            tlm = tls_msg(skb);
>> +        } else {
>> +            struct tls_decrypt_arg darg;
>> +
>> +            err = tls_rx_rec_wait(sk, NULL, true, true);
>> +            if (err <= 0)
>> +                goto read_sock_end;
>> +
>> +            memset(&darg.inargs, 0, sizeof(darg.inargs));
>> +
>> +            rxm = strp_msg(tls_strp_msg(ctx));
>> +            tlm = tls_msg(tls_strp_msg(ctx));
>> +
>> +            err = tls_rx_one_record(sk, NULL, &darg);
>> +            if (err < 0) {
>> +                tls_err_abort(sk, -EBADMSG);
>> +                goto read_sock_end;
>> +            }
>> +
>> +            sk_flush_backlog(sk);
> 
> Question,
> Based on Jakub's comment, the flush is better spaced out.
> Why not just do it once at the end? Or alternatively,
> call tls_read_flush_backlog() ? Or just count by hand
> every 4 records or 128K (and once in the end)?
> 
> I don't really know what would be the impact though, but
> you are effectively releasing and re-acquiring the socket
> flushing the backlog every record...

I really have no idea.
I'll see to modify it to use tls_read_flush_backlog().

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


