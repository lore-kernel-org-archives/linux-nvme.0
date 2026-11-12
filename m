Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A8F606A32A
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kXl25c+k;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eLHZvicL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BsJlBCPotEOl3Ms/1GKReU1OR7zbrzwg9fRjbrgC3ks=; b=kXl25c+kdNMPfe
	zWE5VXYKEqiaX5oPvQ4Jq3NkSc1MKGP/F0o69rI3bXchzUbynnLW1t2Ht65RBjdA6e4tAVm+LecEn
	xSyMOigl0vBaaXff4zQ5N49ywjYsk+XDzXEC2WQwCFRy41Wvu1CbDwQmXItEYKtmh8355flYYzL3+
	uRVvbxXbloju+2Mv/kdyF0KeQxUev2CoVX6ttFHkIYXgDMeJmBhrDEUjUfxSFdKwxf0PQiAreLgH/
	vQL9B3k4Q3Mq8izk7m5YT8JJgSkokL1UOlHL8E8BCDFuTy+s3d60yQD5tLBIK+Q+qznc7bjYQkPDh
	ouLU8gcvyhXrboicD1zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRWpy-0000000ATaJ-37bd;
	Thu, 12 Nov 2026 15:35:42 +0000
Received: from mail-yx2-x05.google.com ([2607:f8b0:4864:41::5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRWpi-0000000ATSs-02RG
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 15:35:33 +0000
Received: by mail-yx2-x05.google.com with SMTP id 956f58d0204a3-67a1a96329cso2052921d50.1
        for <linux-nvme@lists.infradead.org>; Thu, 12 Nov 2026 07:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794497724; x=1795102524; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BsJlBCPotEOl3Ms/1GKReU1OR7zbrzwg9fRjbrgC3ks=;
        b=eLHZvicLfdlWMLva6O6DAZfk3plUX9YndbHV/OGCxxJ6vMAwgp+BGnTGxIBjazywV6
         AE7IsRQD/rANQV5M0dBHsqbSXj1AwbjK8paCJzcT86+WE2ojNdfvLxbBI4PU4Z06RbTb
         r71W0sZ1Q+fviojhrjYhhc/nVaVAho/hg7fWMIGJgLGdo4v4E1Mw3DyHd2RYsur1Lh/+
         yVTTBZYnJk9fRZNopXBSr+dk9bKmwQA/DIsAbgaAox1I6qobSCf4iOnOiMyVk+8vCUJV
         n/DIXfkW5tWZkL/MmJAqJykmeRVkSu6IBTET6MLwp1X2sAyhJ57uHVugVeQvt5Wv7p4G
         FGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794497724; x=1795102524;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BsJlBCPotEOl3Ms/1GKReU1OR7zbrzwg9fRjbrgC3ks=;
        b=glQFqmwiw3z9UAtWEGOS8jHL1swOvxs3TeDeDpC5cKVGzEqoWochLtEdLEIP1jQflG
         OJTmz27yoooCC6Ml10DqiMtv3Jix49L0Z37+ne7AvfvsUVc/8u8uJmcXxJEvfiw7Ff0T
         VD6bnHTXiwyk2cn1eDBxMJcYe4mJtdTa7RPkVXSvLStgWWdePPN6cZVrJ75NrmJZPCFw
         zGP0oHsdvZsAP5cyioPd+hxPex7YY5g/fwThxXzVaNkvhlBe/XQ5tB5wdfoXx+QouyfF
         okwbrvtfwO72VyCqEg0Rz4SeA0/fGGF9UWt0wos0CZobx03Qx9QnfEmY5F1kat1nQyHb
         jAfg==
X-Gm-Message-State: APuU4Z95gNzR4O9XvdiJvpJvG/zCZeFfvi/Z5nJwpUDnV7U3TRMP9pZ8
	gtNjMwtkn6LwhahasSyqBHBAqA+DarHveIw79glABpYMl7Nfw2vIxB5l
X-Gm-Gg: AYBFou2CceUDxQaiZ/npA/IkDUvTOxNhInLrnzwueR4imlEbn1i9bUbcUuLz7anRoOT
	lHcgKH/ZqsBYZykXjbgYFFXyrSTUMCxhDf03H2yJf24d1vbo6LiOsITp7HtORdj6HhUjRHC32F4
	8l5xHuIkSZlU0QDS5Y1sVcZ7L6ovh2CUOPZtgBT5PraNesHyTRFutXsf+VCQKF9QiB+gt325f7J
	ti8qPr1WCoGiBpdGQhBJX4noz1HAp4I6PLWjjy7W9DC794X2y2QeHtxr7UD1R7gIHG7EBD3GXu6
	GmZLEIeZBnFBQkeyo8wqHsFm7xnrZvyrmlV3XSJ9yCanaXDWD6rQxLAiD0i6hchw6oTNn27jVKf
	xPpMRu+UGDh0NMv4rVW57UwW1X2Al/03ee6dmZH3Ua0COnHBNrWdXz37w/8ThYdAW4Be4kZ5hUB
	OwnxNCTIkXQXulKhxg09nbFs2SJ1zCIkXrAHiDuaRYIoulI2uLFg+0YHvVGqgRfeORYHMW5vA6y
	4PlXZL1VcZqJRYzyhugAMM4oFm6ZHn27nsqfmBapdb9Vd3o9AgoMvhQwPurJj2CjvRPtNe39KBU
	FUdkYZ11q22Le7gyeQHv6JLeZXvQNgsPmNY=
X-Received: by 2002:a05:690e:4386:b0:67c:58f1:80b0 with SMTP id 956f58d0204a3-67c67fe095amr2023215d50.80.1794497724340;
        Thu, 12 Nov 2026 07:35:24 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589c4e9bsm7462376d50.10.2026.11.12.07.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 07:35:23 -0800 (PST)
Message-ID: <225d164f-f95a-4c55-afe5-81237c6d5a22@gmail.com>
Date: Thu, 12 Nov 2026 10:35:23 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nvme-tcp: consume TLS records without application
 data
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
 <20261111-nvme-tcp-live-ctrlrec-v2-3-6295202b84de@gmail.com>
 <8f7656ef-2730-484b-98cd-701616ef1a8f@suse.de>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <8f7656ef-2730-484b-98cd-701616ef1a8f@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_073526_600892_0E7B0D37 
X-CRM114-Status: GOOD (  15.60  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/12/26 07:32, Hannes Reinecke wrote:
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
[...]
> +             if (buf[0] == TLS_HANDSHAKE_KEYUPDATE) {
> +                     dev_err(queue->ctrl->ctrl.device,
> +                             "queue %d: peer sent a TLS KeyUpdate,
which is not supported\n",
>
> A bit awkward; maybe 'TLS KeyUpdate is not supported'?

Yes. v3 will use "queue %d: TLS KeyUpdate is not supported".

[...]
> +     ret = nvme_tcp_drain_tls_record(queue, &msg, MSG_DONTWAIT);
>
> Hmm. Doesn't this assume that the KeyUpdate is always the first record?

It assumes that the KeyUpdate is the first handshake message in its
record. RFC 8446 also allows a KeyUpdate after another handshake message
in the same record. kTLS has the same gap: tls_check_pending_rekey()
reads only the first byte of the record. v7 of the kTLS KeyUpdate series
will check every handshake message in the record, so kTLS will detect
this case.

nvme-tcp needs no change for it, because it cannot answer a KeyUpdate in
any case. If kTLS misses the KeyUpdate, the peer's next record uses the
new key, decryption fails, and the queue goes into error recovery. The
queue fails in both cases. Only the log message differs.

> And we do have similar logic in nvme_tcp_skip_tls_record(); can't we
> merge both (ie just call nvme_tcp_drain_tls_record(), and drop
> this switch statement?

v3 will merge them. nvme_tcp_skip_tls_record() goes away, and the ICResp
path and the live path call one helper.

I would like to keep the switch, for the log messages. Draining alone
works: kTLS sets key_update_pending when it decrypts the KeyUpdate, so
the next read_sock() returns -EKEYEXPIRED. After a fatal alert, the peer
closes the connection. But then the log only shows "receive failed". The
switch logs the KeyUpdate and the alert description. The alert is often
the only hint why a target dropped the connection.

One change for the ICResp path: a warning alert ahead of the ICResp no
longer fails the connection. If the peer closes the connection after the
alert, the next read fails.

Thanks,
Martin

