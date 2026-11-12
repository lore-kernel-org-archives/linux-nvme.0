Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C30606A321
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gIfgx4wh;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XlWds+KB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nkTkVM1BqTIke4IbVhNaX7QuexqhYsgSxpWyCcqgwJo=; b=gIfgx4wh14pWy0
	6wQBHk0RPs2q+tyhSasbHB+B764/A0txMIpVA8QIuXVOaXgq5vuQmKp69CkNPqqoSKoYpFbp6PBdv
	q/1SGxvQbcGi6vp2GPjuWX/6gotEPfRy8TeSFcNZP50XSax/hJ4rkpogXb+FsGnyrweTCG4u+Di3d
	VxoPRFag2Cm9len9DQ0VcEmupbnvL0HDITN394iGjvAK1o66o1gclE/B+LAbzC/gpX82NSQAfJmAx
	6HRGP4Pmz7vscZ2OTO9X3f15N83tQu3fTr0g4W1CH7kzFfOUTwn/E4hmBXBHhiexseNqK0h8xnVL+
	LEXQazw/u9XSIHt8NXgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRdPt-0000000BBTQ-3X32;
	Thu, 12 Nov 2026 22:37:13 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRdPq-0000000BBSm-2e5I
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 22:37:12 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-492fcbfaa87so129731f8f.3
        for <linux-nvme@lists.infradead.org>; Thu, 12 Nov 2026 14:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794523029; x=1795127829; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nkTkVM1BqTIke4IbVhNaX7QuexqhYsgSxpWyCcqgwJo=;
        b=XlWds+KBUlKq2SZF/We4AHW7udj3Hjg0ndazeKuOdjLXHX2Dx5ft78T/ufyWiHAoO+
         0itHliNMusrEN3ZJajl/EZ7D3P9d/ltiejN2Tvj8ub2TTMQpBwQxJx8BmYcYez52dYsL
         rSOj7WQsbgwRw8KbPgaq3iJQvoxL2MkKdFUPs+cMDj838D2CfDOVaHrG7SzBJ8gRXDUw
         +gX1iJsXtgoIjGBKV12FsZNvQb2fYZwKhy66xEQ7Qr5MrEypYaUA4zTWVu7oP/qijwnL
         2Df3VW9C1y2SLNw4td4TtSFK603WNGICGrjXZLa08o73uIOa2kc+b57tfZvtNPi44mQS
         6xPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523029; x=1795127829;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nkTkVM1BqTIke4IbVhNaX7QuexqhYsgSxpWyCcqgwJo=;
        b=xR14bkPajxw9Zpn4QszB9At3+oFmSAmur9AGhMQ8Sx5FjnB//QtMKqm/PEt0vm9dII
         RjnWTVJHJGgfeQF5JaeFJrqCXr0TxjzBSrFrClo4V8G2UGPj2ko+hSpNWV6ZbBJIfJff
         oRj+YlsQRqMHYBUO3+h6ww9qB3ccNlGkekXgr8x5dSOqe4KC+H0BfnEvJCUFpyh0+caR
         nn+P5XxWnOuYu5RVKRrqjkl/WH83m7639JXRdV+MYtTR0lcwwChHe4j5n1bKGJ1gq8Kh
         NX2vVjaMCB2vp9wtuHH9D8pDtztDwYSX4hAjv2J/UTcbckhGvMRephHrsOck/GDx3x96
         htIw==
X-Forwarded-Encrypted: i=1; AL+hErFIj2xgc5/fLVLxhlKVcFEDChxwZHvlw861ejR4CEcXIAT/06Gn7+SU0wdnhn7cR5zUYXIellbJciRd@lists.infradead.org
X-Gm-Message-State: APuU4Z8OLqGIXbUe6ZpRHbniNhSaf3QJBWWr7p/KVqSiu8wxQCUsX4P7
	+4GBuAf5BGqPIlOcbSzAyL/ISvlvH8i0bUqtBoYlvk72pSZ0CGMlpnbX
X-Gm-Gg: AYBFou1h6b0/5/7kUAz/t53GAbIdV+68XqqqH+CkPCQSnDQcsg3C4qVhHpHWKzKPa4m
	bN2eBuiAMWehjphtibVerV75ZK0xWUWD4k0m4bbwezKD0UnHW2kbfZStZt9JMJtD45fkJWsq/qj
	ZsyUU0An0YHb7LY6EnUUYvJQNyN+LqyhsV9ukMjNuqMzns0ftt07gq/MWphFR//acR5rpD7Olls
	Tafr8SdFaD/Gosjk5QMxQtLmjHF34CL152ks5sqrlbDeBQR62SHqIHO7NasF016Ks9dkX5PRe7a
	rtwjZ8gvj8XzECj8gDHRmnOt4P7ae835Do4Cbj2vxNol9BLUB846GbHpop++GvAqKMtp6RoQ1gd
	GHSw7GOQIcrUu6lCDkEwrEOh0g/lVz3VyyLTVm6a4sCdCAeiSTQERHisKmqWivOoNRCtDvF+c46
	7UxOfSjxFEH1L2OVK/aUokICZb01GvW/tkZsF0WE1NMrbaj4Hw0ysSNgfNLkxnz2JuQt3QlMIMs
	gj26eTeH370xur/kBNREKnOh8SrWi0dC3wwgXRb9MkmK1sf22NJV07b8esKdm1hv+macJ+kO+zB
	R6nzqEzOk5Tp8g7EWe2uHTf68tdMhp7gGOdydINom5hztwAInclRmY5HvwRJaRFPoOS/LVSmDUf
	N8oRqDVcx+7o=
X-Received: by 2002:a05:6000:25e3:b0:492:b1c5:6db5 with SMTP id ffacd0b85a97d-49c73bf096bmr1548196f8f.32.1794523028610;
        Thu, 12 Nov 2026 14:37:08 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60ca70a7sm1494474f8f.51.2026.11.12.14.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:37:08 -0800 (PST)
Date: Thu, 12 Nov 2026 22:37:07 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Martin Belanger via B4 Relay
 <devnull+martin.nvme.dev.gmail.com@kernel.org>
Cc: martin.nvme.dev@gmail.com, Keith Busch <kbusch@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Martin
 Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nvme-tcp: use an aligned buffer for the TLS
 record type
Message-ID: <20261112223707.3bf1e1a6@pumpkin>
In-Reply-To: <20261111-nvme-tcp-live-ctrlrec-v2-1-6295202b84de@gmail.com>
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
	<20261111-nvme-tcp-live-ctrlrec-v2-1-6295202b84de@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_143710_701589_6728A365 
X-CRM114-Status: GOOD (  25.54  )
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 15:42:39 -0500
Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org> wrote:

> From: Martin Belanger <martin.belanger@dell.com>
> 
> The buffers that receive the TLS record type are char arrays.
> put_cmsg() and tls_get_record_type() access them as struct cmsghdr,
> which needs a stricter alignment than a char array has.
> 
> Use a union with struct cmsghdr, sized with CMSG_SPACE(), as
> svc_tcp_recv_cmsg() and xs_tls_read_record() in sunrpc do.
> 
> Fixes: 2837966ab2a8 ("nvme-tcp: control message handling for recvmsg()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>  drivers/nvme/host/tcp.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7ecc6c007f8d..749d77b4e172 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -77,6 +77,12 @@ MODULE_PARM_DESC(tls_handshake_timeout,
>  /* TLS records read while waiting for the ICResp, the ICResp included */
>  #define NVME_TCP_ICRESP_MAX_RECORDS 8
>  
> +/* control message buffer for the TLS record type */
> +union nvme_tcp_tls_cmsg {
> +	struct cmsghdr	cmsg;
> +	u8		buf[CMSG_SPACE(sizeof(u8))];
> +};
> +
>  static int nvme_tcp_cpu_queues[NR_CPUS];
>  static DEFINE_SPINLOCK(nvme_tcp_cpu_queues_lock);
>  
> @@ -1653,11 +1659,11 @@ static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
>  			.iov_base = buf,
>  			.iov_len = sizeof(buf),
>  		};
> -		char cbuf[CMSG_LEN(sizeof(char))] = {};
> +		union nvme_tcp_tls_cmsg u = {};

Is that right?
You are changing something that was CMSG_LEN(1) to one of CMSG_SPACE(1).

I've a feeling it would be right if it was a struct, not a union.

Did you test it?
Or even compile it and compare the two object files.

David

>  		/* kTLS fails a control record read without a cmsg buffer */
>  		struct msghdr drain = {
> -			.msg_control = cbuf,
> -			.msg_controllen = sizeof(cbuf),
> +			.msg_control = &u,
> +			.msg_controllen = sizeof(u),
>  		};
>  
>  		ret = kernel_recvmsg(queue->sock, &drain, &iov, 1, sizeof(buf),
> @@ -1682,7 +1688,7 @@ static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
>  static int nvme_tcp_recv_icresp(struct nvme_tcp_queue *queue,
>  				struct nvme_tcp_icresp_pdu *icresp)
>  {
> -	char cbuf[CMSG_LEN(sizeof(char))];
> +	union nvme_tcp_tls_cmsg u;
>  	struct msghdr msg;
>  	struct kvec iov;
>  	u8 ctype;
> @@ -1690,12 +1696,12 @@ static int nvme_tcp_recv_icresp(struct nvme_tcp_queue *queue,
>  
>  	for (i = 0; i < NVME_TCP_ICRESP_MAX_RECORDS; i++) {
>  		memset(&msg, 0, sizeof(msg));
> -		memset(cbuf, 0, sizeof(cbuf));
> +		memset(&u, 0, sizeof(u));
>  		iov.iov_base = icresp;
>  		iov.iov_len = sizeof(*icresp);
>  		if (nvme_tcp_queue_tls(queue)) {
> -			msg.msg_control = cbuf;
> -			msg.msg_controllen = sizeof(cbuf);
> +			msg.msg_control = &u;
> +			msg.msg_controllen = sizeof(u);
>  		}
>  		msg.msg_flags = MSG_WAITALL;
>  		ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
> @@ -1703,8 +1709,7 @@ static int nvme_tcp_recv_icresp(struct nvme_tcp_queue *queue,
>  		if (ret <= 0 || !nvme_tcp_queue_tls(queue))
>  			return ret;
>  
> -		ctype = tls_get_record_type(queue->sock->sk,
> -					    (struct cmsghdr *)cbuf);
> +		ctype = tls_get_record_type(queue->sock->sk, &u.cmsg);
>  		if (ctype == TLS_RECORD_TYPE_DATA)
>  			return ret;
>  
> 


