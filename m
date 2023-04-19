Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D05AC77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 09:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hC/fMFkjFWo9Uftolex3Z/mDYGpb53zn3bFdpwwKt5Q=; b=CP376erjcJZ8DhB/rIY+ZScc2H
	Do0gH6E8u/P+wk7aHtlWAeltKJ/JJwT8UAdaolvqDuDC4JTpK7bU9SpSkc5ZdJScfP7821WwV+qoO
	+ep3FsS/HIbHc9EIPt+TZNscIvQ993PcUjXcqap0kr8zUq6kN241pYv/0dY7ZWXLIlyt6feh3AU6v
	hengyoImARfwHhar1Xl9daXbEkJIqwGZHmV0FcGKTYNFzhdpu+Jg3bfPYmHpnVjiCfHr3gKGrx75H
	LqisLQRCFf0r9A6gwGhG3F2mhOLiNMckr+zhaLVrs/DRguaefz4hbGXezTDNnP/T/h38IK158MOFl
	kpEDV8cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp3o2-004hQ8-2D;
	Wed, 19 Apr 2023 09:08:50 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp3o0-004hPM-0b
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 09:08:49 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f18176ea3aso610785e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Apr 2023 02:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681895322; x=1684487322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hC/fMFkjFWo9Uftolex3Z/mDYGpb53zn3bFdpwwKt5Q=;
        b=XFnyoELNth1pLPL/nX3aB6oUsYffZiC77XezNysM4TlxmfqFWH40qZkvNvp3FFa7dZ
         yayueWABDN44jMeZZClEp+Aze85I+woETTLmK4zVHmgcGSg5qVuH2jiCRC3nBgTN6vcK
         kaDC52Aotm6egc8QGJcG8LGiFmPzqsfYsHvqIfCtuFkUbWetJ0lJ40Jo0evCjkT2Fla0
         T9sFRsDVQRoy6E8vArrR/kXLVWy3+LA9cBRZlVSjzEzNFF7Nxof0rzn7pCPJAvrAvX0g
         +VbB3YCdOc9Lw6uDzeF8dy0LE8s7rHF9QAVcDms2Ud1WuoeW1Me627ehWVt6GacWoDEf
         OaJg==
X-Gm-Message-State: AAQBX9c6+U56eHGDZnIbdYWy0G7eHa3uSR22QKV1MREYDjbyKJFX60X5
	WyLZ05SOQ3TLvJSGEuNxRds=
X-Google-Smtp-Source: AKy350aJxJjrRDFU1eRcW9k9thdvwBCGRgb4WPnoF16n2yZ/TL30tzZvsK4tf7QG50K6UfqH8+KJVw==
X-Received: by 2002:a05:600c:3ca0:b0:3f0:a845:f215 with SMTP id bg32-20020a05600c3ca000b003f0a845f215mr13509576wmb.3.1681895322510;
        Wed, 19 Apr 2023 02:08:42 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b003f092f0e0a0sm2581157wmo.3.2023.04.19.02.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:08:42 -0700 (PDT)
Message-ID: <15fb377e-125f-df25-f752-2e093b628327@grimberg.me>
Date: Wed, 19 Apr 2023 12:08:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 08/17] nvme-tcp: fixup MSG_SENDPAGE_NOTLAST
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-9-hare@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230419065714.52076-9-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_020848_244387_1F9DD44B 
X-CRM114-Status: GOOD (  28.77  )
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

Please CC Jakub and Vadim in the next iterations.
I'd also CC netdev to let the networking folks this is going on...

> We can only set MSG_SENDPAGE_NOTLAST when sending the command PDU if the
> actual data is transferred via sendpage(), too.
> If we use sendmsg() to transfer the data we end up with a TX stall on TLS
> as it implements different code paths for sendmsg() and sendpage().
> So check in nvme_tcp_try_send_pdu() if inline data is present and revert
> to sendmsg if the inline data cannot be sent via sendpage().

ifaiu, the TX stalls are not related to sendpage and sendmsg being
separate code paths. The stalls are just a bug in an untested scenario
of sendpage(NOTLAST)+sendmsg..

It needs to be documented in the change log:
"Due to a bug in the tls code, we do xxx to workaround it"

In a separate patch.

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 273c1f2760a4..9ecd7db2cd98 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -995,9 +995,11 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>   		if (last && !queue->data_digest && !nvme_tcp_queue_more(queue))
>   			flags |= MSG_EOR;
>   		else
> -			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
> +			flags |= MSG_MORE;
>   
>   		if (sendpage_ok(page)) {
> +			if (flags & MSG_MORE)
> +				flags |= MSG_SENDPAGE_NOTLAST;
>   			ret = kernel_sendpage(queue->sock, page, offset, len,
>   					flags);
>   		} else {

This is fine, lets move this to its own patch.

> @@ -1049,15 +1051,23 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   	int ret;
>   
>   	if (inline_data || nvme_tcp_queue_more(queue))
> -		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
> +		flags |= MSG_MORE;
>   	else
>   		flags |= MSG_EOR;
>   
>   	if (queue->hdr_digest && !req->offset)
>   		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>   
> -	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
> -			offset_in_page(pdu) + req->offset, len,  flags);
> +	if (!inline_data || sendpage_ok(nvme_tcp_req_cur_page(req))) {

This needs a big fat comment to why we are doing this bizzare and
untrivial condition:

Something like:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7723a4989524..cd8610836de9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1046,15 +1046,32 @@ static int nvme_tcp_try_send_cmd_pdu(struct 
nvme_tcp_request *req)
         int ret;

         if (inline_data || nvme_tcp_queue_more(queue))
-               flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+               flags |= MSG_MORE;
         else
                 flags |= MSG_EOR;

         if (queue->hdr_digest && !req->offset)
                 nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));

-       ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-                       offset_in_page(pdu) + req->offset, len,  flags);
+       /**
+        * FIXME: Due to a bug in the tls code, issuing sendpage with msg
+        * flag MSG_SENDPAGE_NOTLAST and then issuing sendmsg, we can hit
+        * some TX stalls. Our connect data (which is the request 
inline_data)
+        * is a slab allocated page and hence we must not use sendpage to
+        * send it, and this hits exactly the tls issue. workaround it by
+        * sending sendmsg on the command itself as if we are running with
+        * a tls socket and the inline data cannot be sendpage'd.
+        * When the tls code is resolve, this workaround needs to be 
removed.
+        */
+       if (nvme_tcp_tls_enabled(queue) && inline_data &&
+           sendpage_ok(nvme_tcp_req_cur_page(req))) {
+               ret = sock_no_sendpage(queue->sock, virt_to_page(pdu),
+                               offset_in_page(pdu) + req->offset, len, 
flags);
+       } else {
+               flags |= MSG_SENDPAGE_NOTLAST;
+               ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
+                               offset_in_page(pdu) + req->offset, len, 
flags);
+       }
         if (unlikely(ret <= 0))
                 return ret;
--

> +		if (flags & MSG_MORE)
> +			flags |= MSG_SENDPAGE_NOTLAST;
> +		ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
> +				offset_in_page(pdu) + req->offset, len,  flags);
> +	} else {
> +		ret = sock_no_sendpage(queue->sock, virt_to_page(pdu),
> +				offset_in_page(pdu) + req->offset,
> +				len, flags);
> +	}
>   	if (unlikely(ret <= 0))
>   		return ret;
>   

