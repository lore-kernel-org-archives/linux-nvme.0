Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2ACC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 09:10:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63B360FBF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 09:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C63B360FBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8cKd2+VvtfRfYysO8L8UZ3xrVpEoeW3nKj4lah/PEqE=; b=q2ubzxSGHTGpKrq/a9jQSv0/FC
	YttXJdWcn6TGn8Dwlw3c67Sy1LW9Y7awUEdSDks2nRp4yXUa0X1S4eL8rOy6YUIBuCyH0cOxqHW2o
	2vuLB/ZfKrdY15KVby35NQBWWEcNUfX3Xi6eI4l2tEzB6nL9hwEbTeKoRJ9VORjMBotzhjgtdZj+Q
	ZDYtrIdTQ0FFCMR+O/K9WqU/WguxpIOOcB3uz1nxIDCNxXKbB0U3PRJ71qpQRGv23A0FW5rUQb6Qi
	O2r7y+2GRZxVGJ8NoK0GnX4zwSiKo0tdmW8gmWxToF2zL3w7Ngzda5Dtsbt5X5Umy11UtIMlu0Vio
	af6U68fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mndR5-007J3q-Nr; Thu, 18 Nov 2021 09:10:27 +0000
Received: from mail-ed1-f48.google.com ([209.85.208.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mndR2-007J3O-Om
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 09:10:26 +0000
Received: by mail-ed1-f48.google.com with SMTP id y13so23739875edd.13
 for <linux-nvme@lists.infradead.org>; Thu, 18 Nov 2021 01:10:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8cKd2+VvtfRfYysO8L8UZ3xrVpEoeW3nKj4lah/PEqE=;
 b=jBpLSG5EQhIcp/+OoZPPu7tYMWEvAMA5/HaCd1uAjGnhfrmAJdvs6JcvIcYieWTadu
 8kLjgm40CwYGKtrI+833k9GI6dLJMD1jNpUaQFZU9JBX3/5ishi9nv8U0lp12DTHkMEA
 hvyyj5KLxnTCyVfA147Hmj1S5gLtCXhR1wOOIm+BqtmtNEjkudD1tUQJo06/bLrfejx7
 seqLV4Yx2omiZ317shZFts/tXJhwqWr449zkWI1U7O6YybyQDmBhBFiHpC8oaElrUQN0
 jVHW/gIomnLKfzJGH4JJGrMUMtSS1/Ukqz5HRXx4KswiicVwkfYaBmemV4Qupk6ZQZEh
 vWNA==
X-Gm-Message-State: AOAM532eX+KYcYppNIlddXxN72xYLeLw5QnQb2gTdHd6YM4iWAEh3H9/
 yYyCnJNKXFyjZ+ZlMsDNa72Hv7IgEd4=
X-Google-Smtp-Source: ABdhPJxVq8w6IuBPU6SvFu8MmVseRg5UdK3SWH+CgdY7GPuVY8V5FAP83QeflmjCM1OOb/nuCG+FUg==
X-Received: by 2002:a17:906:5d15:: with SMTP id
 g21mr33305542ejt.162.1637226621748; 
 Thu, 18 Nov 2021 01:10:21 -0800 (PST)
Received: from [10.100.102.14] (85-250-228-224.bb.netvision.net.il.
 [85.250.228.224])
 by smtp.gmail.com with ESMTPSA id p13sm1270927eds.38.2021.11.18.01.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Nov 2021 01:10:21 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
To: Varun Prakash <varun@chelsio.com>
Cc: hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org
References: <1635337439-4311-1-git-send-email-varun@chelsio.com>
 <57fe4578-d8be-8c05-4f52-ece4b3f4cabb@grimberg.me>
 <20211118082849.GA1697@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <72571116-0f1b-94dc-8888-6e7de402a474@grimberg.me>
Date: Thu, 18 Nov 2021 11:10:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211118082849.GA1697@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_011024_845267_3D203788 
X-CRM114-Status: GOOD (  15.36  )
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


>>> @@ -1022,14 +1056,26 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
>>>   	struct nvme_tcp_data_pdu *pdu = req->pdu;
>>>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>>>   	int len = sizeof(*pdu) - req->offset + hdgst;
>>> +	int flags = MSG_DONTWAIT | MSG_MORE;
>>>   	int ret;
>>>   	if (queue->hdr_digest && !req->offset)
>>>   		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>>> -	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
>>> -			offset_in_page(pdu) + req->offset, len,
>>> -			MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
>>> +	if (req->rem_r2t_len) {
>>> +		struct msghdr msg = { .msg_flags = flags };
>>> +		struct kvec iov = {
>>> +			.iov_base = (u8 *)pdu + req->offset,
>>> +			.iov_len = len
>>> +		};
>>> +
>>> +		ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
>>> +	} else {
>>> +		ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
>>> +				      offset_in_page(pdu) + req->offset, len,
>>> +				      flags | MSG_SENDPAGE_NOTLAST);
>>> +	}
>>
>> Why is this needed? Seems out-of-place to me...
> 
> As per my understanding kernel_sendpage() does zero copy TX, return
> from kernel_sendpage() does not guarantee that buffer is transmitted
> or DMA read by NIC. Is this not correct?
> 
> If driver reuses same buffer for next H2CData PDU header it can
> corrupt previous H2CData PDU header.

Yes, please use sock_no_sendpage instead of kernel_sendmsg.

