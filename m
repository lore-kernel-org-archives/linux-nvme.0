Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC980C001B0
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+qlbXvzMOU/yvbLN/DAD9OH/7HAWkGFGujjv/Qyq3bI=; b=TRbe2UUR8FpXd5mgVahJ9JBPCF
	CjhCXnJ0Q0Y49IM586a9fi714XcmdGExQ8AxefQ7fK6t+X+ZjxKPy9B9sb9y64gv1IAwb1ECu8SyZ
	+1+gVAsFeUaRF0Dl5vdyBmXbNb57cjpJEeShI+bqFHwYtNhuVj4LOwsYiisRDb3GgH3/PaU+PItnP
	PhpWjF4HGZ/WJeUvQaxkF4n+nW2yRS9uiCMWRH1WH6SXVyz2X4eemrZQc6ZD+AK8VD8eU6o3Usksg
	4pn4nUX0bziL2gddV9cOx65Emxt19mnW13+Fh3+1R7zYZuG00Is+ByZOdj8F0iKgZMHIMlrKMjyaQ
	fPBfsnVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvVH-00GQwl-2C;
	Mon, 07 Aug 2023 08:22:15 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvVE-00GQuu-0K
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 08:22:13 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fe4f3b5f25so5405595e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 01:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691396528; x=1692001328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qlbXvzMOU/yvbLN/DAD9OH/7HAWkGFGujjv/Qyq3bI=;
        b=hk8EW7aVBnMA/2qBNp6hn5aUNAYnQg/eoRWUzpRKUQdbOL5UpabnwpiK8lGApLayaJ
         d/kAirhw3ZqHrTouhszyPWv21SMkaB0AMRBMh+b8rqEazUXIQVjHgZj7HPsHqi6asVFv
         AAOYU5Xoi9Q9eyiZzXPp1bk0MPBLLnxyLWBT/0YEA/lCdr5/yYwWbND8mFG8s532+DqL
         pyrK48PTW/7hgAwHl++GzxmhW3MIpnmag1EUZK+wKom8mecW05hRAAwhGrqIHNRsuk09
         Kv3aXGLpkMP+V6dHewItaaVtS5pcHzMHqJ354EYcH3hcjkCHXfT84wPtL3qGtgMfwhnI
         NEtQ==
X-Gm-Message-State: ABy/qLZzaWaWQcfL7OnX6NJrjasnTpaKSHGTwR5sN5wBjxDpay+H78nW
	SpgG9d714iWii0alBL+x6q8=
X-Google-Smtp-Source: APBJJlGPYV1A5UhintF2aK1uFuVMZn880o0Dl2Zrd6eIGctK7zYEHDXnjxn6trbZ5fr2/Cka956iIg==
X-Received: by 2002:a05:600c:458e:b0:3f9:bf0e:a312 with SMTP id r14-20020a05600c458e00b003f9bf0ea312mr23516521wmo.1.1691396528425;
        Mon, 07 Aug 2023 01:22:08 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b003fbfef555d2sm14281084wmj.23.2023.08.07.01.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 01:22:07 -0700 (PDT)
Message-ID: <5c12f391-c5cb-2d1a-40b3-b93f45292c6c@grimberg.me>
Date: Mon, 7 Aug 2023 11:22:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/14] nvme-tcp: control message handling for recvmsg()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-10-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230803105102.30949-10-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_012212_137766_66DCF128 
X-CRM114-Status: GOOD (  19.93  )
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



On 8/3/23 13:50, Hannes Reinecke wrote:
> kTLS is sending TLS ALERT messages as control messages for recvmsg().
> As we can't do anything sensible with it just abort the connection
> and let the userspace agent to a re-negotiation.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/tcp.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 98400ad5f969..4d0e3de39c26 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -14,6 +14,7 @@
>   #include <net/sock.h>
>   #include <net/tcp.h>
>   #include <net/tls.h>
> +#include <net/tls_prot.h>
>   #include <net/handshake.h>
>   #include <linux/blk-mq.h>
>   #include <crypto/hash.h>
> @@ -1369,6 +1370,10 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>   {
>   	struct nvme_tcp_icreq_pdu *icreq;
>   	struct nvme_tcp_icresp_pdu *icresp;
> +#ifdef CONFIG_NVME_TCP_TLS
> +	char cbuf[CMSG_LEN(sizeof(char))] = {};
> +	u8 ctype;
> +#endif
>   	struct msghdr msg = {};
>   	struct kvec iov;
>   	bool ctrl_hdgst, ctrl_ddgst;
> @@ -1406,11 +1411,22 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>   	memset(&msg, 0, sizeof(msg));
>   	iov.iov_base = icresp;
>   	iov.iov_len = sizeof(*icresp);
> +#ifdef CONFIG_NVME_TCP_TLS
> +	msg.msg_control = cbuf;
> +	msg.msg_controllen = sizeof(cbuf);
> +#endif
>   	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>   			iov.iov_len, msg.msg_flags);
>   	if (ret < 0)
>   		goto free_icresp;

Is the cmsg passed unconditionally? meaning this does not
impact non-tls?

If so, why is the ifdef needed?

> -
> +#ifdef CONFIG_NVME_TCP_TLS
> +	ctype = tls_get_record_type(queue->sock->sk, (struct cmsghdr *)cbuf);
> +	if (ctype != TLS_RECORD_TYPE_DATA) {
> +		pr_err("queue %d: unhandled TLS record %d\n",
> +		       nvme_tcp_queue_id(queue), ctype);
> +		return -ENOTCONN;
> +	}
> +#endif



>   	ret = -EINVAL;
>   	if (icresp->hdr.type != nvme_tcp_icresp) {
>   		pr_err("queue %d: bad type returned %d\n",

