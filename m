Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51944C2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 23:18:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27022065D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 23:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SdoSHkZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27022065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YVLlScy7MHzFCd+quDaXFMQgv6/lC0LFYDuO9wAZ3uU=; b=SdoSHkZp8IAIG7ohmGca4jQBg
	l43NkrANQnt9qdk7MQ9DadBDXjVuOoU4FOYKGHr1TS+8nFMQC4YP1dqjf7fU+txTcOA5Cr6iFu4H9
	DVXMhpOlx92tTK9APRp8lIWkCgNuZd+en7pRSlU6qJtHa2nzB05KuAJljPdTfk0lz+GNcJZKn4Q9h
	AwM4wht7Qk9K0xo1Ztiri16/qz0ss8ljM+QZMXpf6AbpgpUpNFnj/UlSpcZanfOM98N24pMACf7YH
	4dxub+b0/K+fFDx0KKSpaYzkd9mOhFrr0T0ujUdPBD86QJiDKmZyDlKbZMi7elKBOEW+zaT3WOTb/
	JuwoNIwTA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcGQt-0005Ju-Ug; Mon, 09 Nov 2020 23:18:43 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcGQr-0005Iw-2o
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 23:18:42 +0000
Received: by mail-wr1-f68.google.com with SMTP id d12so9137346wrr.13
 for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2020 15:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0YUh8L7igoV3Pzcq684BHezCnL4xDkpIMR3kxjUfhDw=;
 b=WwGlci5ThBULPaM/rBUmaokasikYcWm2KCeXdJ8tKcv5nqxQFZT1+Hg6aSocKIGcAj
 JLqOMzYonn8coosH3TAyv7pXwSzmH37GJmNq0qpPsGjsiJ5A2k3yxftoM/XJrNJBBlNJ
 Ah+LxKjqexsakK7o5R+WCAtinluNA2lQd5tUn2ei8QXQ7+2c3gTqeErWC1TYiDktvUPA
 aZMFI8kHL6dcvm+vloae52lguDiVEFOXnozFyS00hH5ga+MFm6IUP4G8QCa2mgdy9uE0
 9Hp6ZfFH+OPncyH0CaNMNNWHH7Dgd5f+tCUqHFSHo8ISRsTumaZOgj03KHsPPsr6PpKS
 KM+g==
X-Gm-Message-State: AOAM533NtpQgfKqWbrNmYohWcbzdc7tfS4BeoObevxhflJqPi7hYWDSH
 Y3wvcaHrLZRB5PALtV5UxZA=
X-Google-Smtp-Source: ABdhPJwTJP+kcO34FQBhF84j4wYWYrX3gHu1JcY3IRtqd+adZxWOzZByr1bdZbEPgH8eCmoqU+QEZg==
X-Received: by 2002:adf:e3c2:: with SMTP id k2mr18037603wrm.82.1604963913736; 
 Mon, 09 Nov 2020 15:18:33 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:f26a:270b:f54c:37eb?
 ([2601:647:4802:9070:f26a:270b:f54c:37eb])
 by smtp.gmail.com with ESMTPSA id t5sm957612wmg.19.2020.11.09.15.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 15:18:32 -0800 (PST)
Subject: Re: [PATCH net-next RFC v1 06/10] nvme-tcp: Add DDP data-path
To: Boris Pismenny <borispismenny@gmail.com>,
 Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org, davem@davemloft.net,
 saeedm@nvidia.com, hch@lst.de, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-7-borisp@mellanox.com>
 <5a23d221-fd3e-5802-ce68-7edec55068bb@grimberg.me>
 <12692704-126a-4242-f0a9-f00db6071e40@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <37baeb0e-b6c5-7661-b871-6a51c1a2e804@grimberg.me>
Date: Mon, 9 Nov 2020 15:18:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <12692704-126a-4242-f0a9-f00db6071e40@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_181841_184756_B20CBE89 
X-CRM114-Status: GOOD (  13.36  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Yoray Zack <yorayz@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>    static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>>> @@ -1115,6 +1222,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>>>    	bool inline_data = nvme_tcp_has_inline_data(req);
>>>    	u8 hdgst = nvme_tcp_hdgst_len(queue);
>>>    	int len = sizeof(*pdu) + hdgst - req->offset;
>>> +	struct request *rq = blk_mq_rq_from_pdu(req);
>>>    	int flags = MSG_DONTWAIT;
>>>    	int ret;
>>>    
>>> @@ -1123,6 +1231,10 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>>>    	else
>>>    		flags |= MSG_EOR;
>>>    
>>> +	if (test_bit(NVME_TCP_Q_OFFLOADS, &queue->flags) &&
>>> +	    blk_rq_nr_phys_segments(rq) && rq_data_dir(rq) == READ)
>>> +		nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id, rq);
>> I'd assume that this is something we want to setup in
>> nvme_tcp_setup_cmd_pdu. Why do it here?
> Our goal in placing it here is to keep both setup and teardown in the same thread.
> This enables drivers to avoid locking for per-queue operations.

I also think that it is cleaner when setting up the PDU. Do note that if
queues match 1x1 with cpu cores then any synchronization is pretty
lightweight, and if not, we have other synchronizations anyways...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
