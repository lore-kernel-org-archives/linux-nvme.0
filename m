Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81425C77B76
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YKGu76ykgM+BAOABZpdUDyx+z03h5RqQ0VuKA485N7Y=; b=mlHRYHRsIeK+q8cmBV+Sll3WsY
	9sf/p2H8uZSPgMHmTDonk9Ao2ohHB05egJWkWeBnZypri7Flk0Lo1SsWVCGE5PPlFIAOCkmS3KlZb
	t3EGgXwyqyMG45RnOzTiY/S+1GZIBb1xuJNourEGWr32ELwePwZ3bKBcXEa2/LHTuIGUd0tcnXFBq
	nC8Xyi8fP/PX9FY46BEPWz7nkukHpcZRWDBY0jHm79+ZJRxoRr8+KgIS1Xem5nKDF4G0Bpu0o89ud
	Y1uvFAPXXcYqXievX3boXtoecb0CzEo+dlHYWkznKnL2Wq1v99fkDdnAcw1TaVRQp0ZeVG/Ppr3CC
	Cg1AaIxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poQdT-00Gp2N-0s;
	Mon, 17 Apr 2023 15:19:19 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poQdQ-00Gp09-2y
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 15:19:18 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f167e8a880so3975035e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 08:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681744754; x=1684336754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKGu76ykgM+BAOABZpdUDyx+z03h5RqQ0VuKA485N7Y=;
        b=Rb53t8YbtyhgnINH9ZG/9R7uljSw+dHS5ayyE8FbQ7yXKqzU67CNyIOXk8+so5tU4r
         WI4mQ2hXSE/JNhq2BlF+3YF9l65Naa+vs6bQnnOHluXsELcRcQdTSzJ7+ZMKybbmt1G7
         BTJfSperuNw5XyZ0Ij01g5F/U67NZv4R/gtmgyAqCDk7T0gpl2i4fW/yjKO9dVLtHfU1
         eYArI8j+vVmp7tQLdXt70qhk4bIgXpBbJxOBlgu37VldW1GLrkiuHlmjS5yUZukdCPFT
         a69IolI2AlU9P/4UusjIr9l9XBy9UoX/inU6MkhQrwE+w90aptDB+65FdE7u3ALDVDHc
         UJrA==
X-Gm-Message-State: AAQBX9eXzx70x0G9PzqG/D7yS6G77Zl69yjD7yXVf4rPi4C0+snjLBon
	2vxtWLnyUY3zrKDQRoANjA4=
X-Google-Smtp-Source: AKy350bzomnJTVuJbG6co0H9dpHl/zlZsd+NREV8e9neW1McPxidVstuQvEHyMiWBkTY+DXj28BLIA==
X-Received: by 2002:a05:600c:6025:b0:3f1:75a5:a369 with SMTP id az37-20020a05600c602500b003f175a5a369mr1519230wmb.3.1681744753943;
        Mon, 17 Apr 2023 08:19:13 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t1-20020a1c7701000000b003ede06f3178sm12164328wmi.31.2023.04.17.08.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 08:19:13 -0700 (PDT)
Message-ID: <20af9713-8d64-77de-dfbe-e9e732776d3c@grimberg.me>
Date: Mon, 17 Apr 2023 18:19:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 07/18] net/tls: sanitize MSG_EOR handling
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-8-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230417130302.86274-8-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_081916_957452_F8F017A8 
X-CRM114-Status: GOOD (  22.88  )
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


> The TLS stack is using MSG_EOR internally, so the flag cannot be
> set for sendmsg()/sendpage(). But to avoid having the caller to
> check whether TLS is active modify the code to clear the MSG_EOR
> flag. And blank out MSG_MORE / MSG_SENDPAGE_NOTLAST, too, as they
> conflict with MSG_EOR anyway.

This looks like a temporary workaround to me.

The networking folks really need to be CC'd on this (same for patch 6).

CC'ing Jakub for starters.

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   net/tls/tls_device.c | 10 ++++++++++
>   net/tls/tls_sw.c     | 21 +++++++++++++++++++++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index a7cc4f9faac2..38e44e216865 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -576,6 +576,10 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>   	mutex_lock(&tls_ctx->tx_lock);
>   	lock_sock(sk);
>   
> +	/* MSG_EOR conflicts with MSG_MORE, so clear both */
> +	if (msg->msg_flags & MSG_EOR)
> +		msg->msg_flags &= ~(MSG_EOR | MSG_MORE);
> +
>   	if (unlikely(msg->msg_controllen)) {
>   		rc = tls_process_cmsg(sk, msg, &record_type);
>   		if (rc)
> @@ -604,6 +608,12 @@ int tls_device_sendpage(struct sock *sk, struct page *page,
>   	if (flags & MSG_SENDPAGE_NOTLAST)
>   		flags |= MSG_MORE;
>   
> +	/*
> +	 * MSG_EOR conflicts with MSG_MORE/MSG_SENDPAGE_NOTLAST,
> +	 * so clear all of them */
> +	if (flags & MSG_EOR)
> +		flags &= ~(MSG_EOR | MSG_SENDPAGE_NOTLAST | MSG_MORE);
> +
>   	mutex_lock(&tls_ctx->tx_lock);
>   	lock_sock(sk);
>   
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 827292e29f99..d0e6b7a04176 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -952,6 +952,11 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>   	int ret = 0;
>   	int pending;
>   
> +	if (msg->msg_flags & MSG_EOR) {
> +		eor = true;
> +		/* MSG_EOR conflicts with MSG_MORE, so clear both */
> +		msg->msg_flags &= ~(MSG_EOR | MSG_MORE);
> +	}
>   	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
>   			       MSG_CMSG_COMPAT))
>   		return -EOPNOTSUPP;
> @@ -1274,6 +1279,14 @@ static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
>   int tls_sw_sendpage_locked(struct sock *sk, struct page *page,
>   			   int offset, size_t size, int flags)
>   {
> +	/*
> +	 * MSG_EOR is invalid for TLS, and conflicts
> +	 * with MSG_MORE / MSG_SENDPAGE_NOTLAST.
> +	 * So clear all of them.
> +	 */
> +	if (flags & MSG_EOR)
> +		flags &= ~(MSG_MORE | MSG_SENDPAGE_NOTLAST | MSG_EOR);
> +
>   	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
>   		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY |
>   		      MSG_NO_SHARED_FRAGS))
> @@ -1288,6 +1301,14 @@ int tls_sw_sendpage(struct sock *sk, struct page *page,
>   	struct tls_context *tls_ctx = tls_get_ctx(sk);
>   	int ret;
>   
> +	/*
> +	 * MSG_EOR is invalid for TLS, and conflicts
> +	 * with MSG_MORE / MSG_SENDPAGE_NOTLAST.
> +	 * So clear all of them.
> +	 */
> +	if (flags & MSG_EOR)
> +		flags &= ~(MSG_MORE | MSG_SENDPAGE_NOTLAST | MSG_EOR);
> +
>   	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
>   		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY))
>   		return -EOPNOTSUPP;

