Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04C7D0E6C2
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 07:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7z9AQDH/axtlM5skrfxOefymtsdnDWAhql5dr5c5XEU=; b=gj1rX+RY9MxA849Ez54HmditY3
	rV1pGKlcmAI02E5kPZhWTgSXUKAObq1r3oKBeoQykWNO/ok1Q4WJrLC3WawOOJIYZ1tSWdjzkdH9x
	5OLuFSVlAX++b9Bt+GQBWErx36pm+J7QYMm1A/sFTwoMKAuOyO+862J0af8xKNUCO4BgK0nVvd/Qe
	TPcIB6pn7Q9OBr6YoJmVzESxdWCdM/I5/w505GuchYqvROpHQzKGOPxSIDBA0gL1TN/+zLBzIiZpr
	lTPrkbkVB2BwhM4leR94qg+ryPHsLB0tHc5omiA2SOSWSuqseVnC/+Pg3OsmOTtk5tg9XEFBKeCKx
	WoFL2FLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2n43-00000006Q53-2TIm;
	Mon, 21 Oct 2024 07:42:55 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2my9-00000006OUw-06GP
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 07:36:51 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d51055097so2914924f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 21 Oct 2024 00:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729496206; x=1730101006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7z9AQDH/axtlM5skrfxOefymtsdnDWAhql5dr5c5XEU=;
        b=tbFU+bwIksvj/LVM6CFZ2EWRGjyFSic/+zttu/7N4EeOTNpglj3wupIAVwMr1886Rc
         TVDSEgbGIwjC8LwHINai+Q35dFLIRNn5fgbG0h5BxH86ud+6qqipkZIVkVFbn4cggVtZ
         lEsQ0yJuZtWN6QSxJ2YAwBJ7xXeCFqiypLz/zzNwNsNrVMCvHJBnSjEYCLNKIiRLmiHc
         ArmxAuoGVxfmO3T0b5RnA8Zb/oRkFPXizrLnGSspZk94icSkRFfQIam5fFpOyt3MgP1q
         y1G6LGrsh8QcXRw700ifMdyJpCV443ZrF9Uf8gxxOQRokIxx3Joi+qCvf1IqKE+OGLWz
         xETg==
X-Forwarded-Encrypted: i=1; AJvYcCXkGqF8uiyZvSnkJUfGYBmvJrhK4vi8W+0ZRNYT9NDZCh1ftDe7zIcvZDOBJe6ROIGfojGOaLaRzHVk@lists.infradead.org
X-Gm-Message-State: AOJu0YxPerk9iZNZ+CFAdH3SZgKnEaQs5kwAeZB5tON0XV2Jr0vviTV/
	upRZddL6lUKEPYDwYXjSMOxeEUFQm5AQgOS89CtSwNl0Po0DwG5dA0wrPw==
X-Google-Smtp-Source: AGHT+IGwxAZXDoFxBiYjnprdyBVMuX/JrqMe5rYb/faMMdMtEbnnVW5u0SALMKOBlyrbACpvJAzdFw==
X-Received: by 2002:a05:6000:a86:b0:37d:3650:fae5 with SMTP id ffacd0b85a97d-37eab6ec44dmr6896650f8f.52.1729496206525;
        Mon, 21 Oct 2024 00:36:46 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4b26dsm3576472f8f.45.2024.10.21.00.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 00:36:46 -0700 (PDT)
Message-ID: <880bedd1-1487-49e1-9d56-0eabd5797baf@grimberg.me>
Date: Mon, 21 Oct 2024 10:36:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] nvmet-tcp: support secure channel concatenation
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
References: <20241018063343.39798-1-hare@kernel.org>
 <20241018063343.39798-9-hare@kernel.org>
 <4bb5aa23-6f59-462d-9f50-44e5edaec7e1@grimberg.me>
 <3d656683-b091-4a5a-b064-39afe4896c52@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3d656683-b091-4a5a-b064-39afe4896c52@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_003649_156780_0935A54B 
X-CRM114-Status: GOOD (  11.28  )
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

>>>
>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>> index 7c51c2a8c109..671600b5c64b 100644
>>> --- a/drivers/nvme/target/tcp.c
>>> +++ b/drivers/nvme/target/tcp.c
>>> @@ -1073,10 +1073,11 @@ static int nvmet_tcp_done_recv_pdu(struct 
>>> nvmet_tcp_queue *queue)
>>>       if (unlikely(!nvmet_req_init(req, &queue->nvme_cq,
>>>               &queue->nvme_sq, &nvmet_tcp_ops))) {
>>> -        pr_err("failed cmd %p id %d opcode %d, data_len: %d\n",
>>> +        pr_err("failed cmd %p id %d opcode %d, data_len: %d, 
>>> status: %04x\n",
>>>               req->cmd, req->cmd->common.command_id,
>>>               req->cmd->common.opcode,
>>> - le32_to_cpu(req->cmd->common.dptr.sgl.length));
>>> + le32_to_cpu(req->cmd->common.dptr.sgl.length),
>>> +               le16_to_cpu(req->cqe->status));
>>>           nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
>>>           return 0;
>>> @@ -1602,6 +1603,7 @@ static void 
>>> nvmet_tcp_release_queue_work(struct work_struct *w)
>>>       /* stop accepting incoming data */
>>>       queue->rcv_state = NVMET_TCP_RECV_ERR;
>>> +    nvmet_sq_put_tls_key(&queue->nvme_sq);
>>>       nvmet_tcp_uninit_data_in_cmds(queue);
>>>       nvmet_sq_destroy(&queue->nvme_sq);
>>>       cancel_work_sync(&queue->io_work);
>>> @@ -1807,6 +1809,23 @@ static void nvmet_tcp_tls_handshake_done(void 
>>> *data, int status,
>>>       spin_unlock_bh(&queue->state_lock);
>>> cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
>>> +
>>> +    if (!status) {
>>> +        struct key *tls_key = nvme_tls_key_lookup(peerid);
>>> +
>>> +        if (IS_ERR(tls_key)) {
>>
>> It is not clear to me how this can happen. Can you explain?
>>
> Passing key information between kernel and handshake daemon is
> done purely by key IDs (not the keys itself).
> So we will be getting a key ID back from the handshaked daemon,
> and we need to validate that; the user (or admin software) could
> have invalidated the key while the handshake was running, or before
> we had a chance to process the reply from the handshake daemon.

Got it. thanks.

