Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A622C369BD
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Apr 2025 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bB/ExXw5iMg6WYOEtmSHjkeGKxxaETAwbiI9Epa5lsc=; b=YiAbXQ+hQyzwP3KlazCYs/YbuM
	8plB+K2HV+Q1oYQgA6sFm2lZNOWypTU6UL8gec4mYrB7NWjFLFE0v6a0CQpMIPpezewuxtmKGmzIg
	k8lCgB0Co57q8J6v2b74ecfGcLAaGiAAFyPMFHFGjNmJS5LYl43X74mCMJ5Ww+vZfNS2WhScZWNSz
	bSaDx9CwjQoOMe+fX6N2QdGsNgCRR0lJPq1sG62KHB+w1fQLjlmAPQChASMCUWk/PY6MD8vR2loMc
	6xwP4NQujrSdIzz452Dq2amcwt9AIxTcx5GWkwDU2wTtghfYe8z6Vsqb94Z4uwlw8RbJZaFxoGiNk
	ssS3pPCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6Am9-00000001VuZ-11I0;
	Sat, 19 Apr 2025 16:10:41 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6Am6-00000001Vtz-2rpl
	for linux-nvme@lists.infradead.org;
	Sat, 19 Apr 2025 16:10:39 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so19655755e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 19 Apr 2025 09:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745079036; x=1745683836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bB/ExXw5iMg6WYOEtmSHjkeGKxxaETAwbiI9Epa5lsc=;
        b=vWuNspyqvQ3D8NHZrac/N6Tu4cQeXVsjqcbtMsoLCNjmErtY8OgWn+gX9dPwwtqtwy
         UbXPuviIyYBCq9dW/QKGaFOVhaPoNjaJZQpRgDSjz5LT5g/Kpi7zCv6Vbd/DKm6jKSIq
         oKLl+lNeef9pmrjL9GGZ5CnamzQ0EEfE35pQX3F2m3TEhcqVr+l41xLM8Rl2HvdpOXCu
         DsekTnc4ah1bSEqNxWfISUjmMfWdIKHKleS9xjtXslPO7ptKsVZl3HL9GzCLSk8AI2lJ
         pALXRRwqrnUMKaJVYZK9zjWSG2MucrqJPDVYVP9b9Y8IBfRytPMynxcjv0J391/aKLR5
         83xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPpPrFe1a3EF7ZYVTD5i7KEgg1LIHrDIzsu1uwcfqfIJpT8GcmZLshr3ClWf8nibFd3a4Ado07PbM0@lists.infradead.org
X-Gm-Message-State: AOJu0YydMOJ9btQ8/sY5Q/XxKx1nz8grBDBrLI+48kFHlRwfPGVsK7yq
	wzvHCDIH4ItetaPu/RKJxjEqkovh4QLvkae7mCoE4nG7LnqFevGp
X-Gm-Gg: ASbGncuumgA3MsQNWBQ9i8CZiOTYdWZm7JtNkvPfHfbP1kb1JRNNvy+njrS4qFgq1eh
	R3mJ1y/KBypuzMYufXFYC+oduuxHrqweByhdbMzlI9s9uZBvDdfgDOgxyFjgM68qtzqPVDc7bgP
	KKzY7Ud5gLDu+MdgzYNNk8PNhE8zvPj50sJzYzBJmIeHSypbbWWe8LlI+uN9CrudyqzwGt05ime
	5i0bqqmrPDjJvkHqWIXAS2VHsjggVqzNrTKjtWU4ZdY+/fsvOqJqpxBiG/Aa+3fvlfR2H54lbOW
	fJEPp4Pz3WaxFBGV+DY41OkRaihtCIV7vvWCC/36
X-Google-Smtp-Source: AGHT+IE//zYrCbWCs5FQllWd383P9LUuIA9OoR90m4B4TDBjQqEVvz2IfL5CogUrcjQ3EOLZX/iPgA==
X-Received: by 2002:a05:600c:138e:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-4406ac1ff50mr49374345e9.29.1745079035995;
        Sat, 19 Apr 2025 09:10:35 -0700 (PDT)
Received: from [10.100.102.67] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5a9e50sm67026505e9.6.2025.04.19.09.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Apr 2025 09:10:35 -0700 (PDT)
Message-ID: <cb444a0b-ecaa-4f46-8323-e5c39a8c71e7@grimberg.me>
Date: Sat, 19 Apr 2025 19:10:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>, Hannes Reinecke <hare@suse.de>,
 Hannes Reinecke <hare@kernel.org>, hch <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <BY5PR04MB684996C1DB38F3BC4386B55EBCBC2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <ee011198-9a15-44e5-a18e-02d3844ee48b@grimberg.me>
 <BY5PR04MB6849262F5822EC7132BE7414BCBF2@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BY5PR04MB6849262F5822EC7132BE7414BCBF2@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250419_091038_732365_66B26BD9 
X-CRM114-Status: GOOD (  29.15  )
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



On 4/18/25 21:55, Kamaljit Singh wrote:
> Sagi,
> 
> From: Sagi Grimberg <sagi@grimberg.me>
> Date: Friday, April 18, 2025 at 03:51
>>> Sagi,
>>> I tried both of these patches but looks like #1 causes an infinite loop. dmesg was full of panics.
>>> I had tried just #1 and later with #1+#2. Both failed the same way.
> 
>> That's no good :)
> 
>> Can you share the panics? This version should be identical to what
>> Hannes introduced in:
> Sorry, I'm posting ~200 lines at the bottom, starting from the beginning of the panic until the next "---cut here---". I can send the whole dmesg as attachment as well. Please let me know.

No need.

However the log prints are WARN messages that does not exist in any of
the patches.

> 
> The patches I applied are these:
> 1: nvme-tcp: partial write tcp-q-wake-sender untested by Sagi
> 2: nvme-tcp: recv-side EAGAIN untested fix by Sagi
> 3: nvme-tcp: fix I/O stalls on congested sockets

The patch I suggested was a replacement for patch (3). Didn't you
get conflicts?

> 4: nvme-tcp: sanitize request list handling
> 5: nvme-tcp: avoid inline sending when handling R2T PDUs
> 6: tls: use independent record sz for data sends  <--- this is my internal/temp fix for a TLS send issue we found
> You can probably ignore #6.

Ignoring.


> [4]         nvme-tcp: sanitize request list handling
> 
>      Validate the request in nvme_tcp_handle_r2t() to ensure it's not
>      part of any list, otherwise a malicious R2T PDU might inject a
>      loop in request list processing.
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 40dce5dc3ff5..4647d5d547f8 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -455,6 +455,7 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
>          }
> 
>          list_del(&req->entry);
> +       init_llist_node(&req->lentry);
>          return req;
>   }
> 
> @@ -562,6 +563,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
>          req->queue = queue;
>          nvme_req(rq)->ctrl = &ctrl->ctrl;
>          nvme_req(rq)->cmd = &pdu->cmd;
> +       init_llist_node(&req->lentry);
> +       INIT_LIST_HEAD(&req->entry);
> 
>          return 0;
>   }
> @@ -773,8 +776,12 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
> 
>          nvme_tcp_setup_h2c_data_pdu(req);
> 
> +       WARN_ON(queue->request == req);
> +       WARN_ON(llist_on_list(&req->lentry));
> +       WARN_ON(!list_empty(&req->entry));

These are not included in Hannes patch afaict.
I'm assuming that these are the stack traces that are firing...

Can you please share the output of gdb:
l *nvme_tcp_recv_skb+0x115e

My assumption is that in your case, queue->request is still referenced
with the current request when the r2t for it arrives, which is very much
possible...

So this means that the patch "nvme-tcp: sanitize request list handling"
is wrong, queue->request may still be referenced when its r2t arrives.

I think this patch needs the following:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f2c829f1aff6..c2d4893ecb94 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -767,8 +767,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue 
*queue,
                 return -EPROTO;
         }

-       if (queue->request == req ||
-           llist_on_list(&req->lentry) ||
+       if (llist_on_list(&req->lentry) ||
             !list_empty(&req->entry)) {
                 dev_err(queue->ctrl->ctrl.device,
                         "req %d unexpected r2t while processing request\n",
--

Or in your case - remove the above:
--
	WARN_ON(queue->request == req);
--



> ================================
> Snapshot of panic messages:
> 
> ...
> [2025-04-16 22:55:32.992] [Wed Apr 16 22:55:34 2025] nvme nvme0: QID 0x0: traddr=10.10.10.223,trsvcid=4420,sport=0x8ac6,dport=0x1144
> [2025-04-16 22:55:33.445] [Wed Apr 16 22:55:34 2025] nvme nvme0: D3 entry latency set to 16 seconds
> [2025-04-16 22:55:33.898] [Wed Apr 16 22:55:35 2025] nvme nvme0: queue_size 128 > ctrl sqsize 17, clamping down
> [2025-04-16 22:55:33.929] [Wed Apr 16 22:55:35 2025] nvme nvme0: creating 3 I/O queues.
> [2025-04-16 22:55:35.398] [Wed Apr 16 22:55:36 2025] nvme nvme0: mapped 3/0/0 default/read/poll queues.
> [2025-04-16 22:55:35.445] [Wed Apr 16 22:55:36 2025] nvme nvme0: QID 0x1: traddr=10.10.10.223,trsvcid=4420,sport=0x8ac8,dport=0x1144
> [2025-04-16 22:55:35.508] [Wed Apr 16 22:55:36 2025] nvme nvme0: QID 0x2: traddr=10.10.10.223,trsvcid=4420,sport=0x8ad4,dport=0x1144
> [2025-04-16 22:55:35.554] [Wed Apr 16 22:55:36 2025] nvme nvme0: QID 0x3: traddr=10.10.10.223,trsvcid=4420,sport=0x8ad8,dport=0x1144
> [2025-04-16 22:55:35.632] [Wed Apr 16 22:55:37 2025] nvme nvme0: new ctrl: NQN "nqn.2015-09.com.wdc:nvme.1", addr 10.10.10.223:4420, hostnqn: nqn.2014-08.org.nvmexpress:host.0
> [2025-04-16 22:55:36.195] [Wed Apr 16 22:55:37 2025] nvme nvme0: Failed to get ANA log: 16386
> [2025-04-16 22:55:43.023]
> [2025-04-16 22:55:43.492]
> [2025-04-16 22:56:24.758] [Wed Apr 16 22:56:26 2025] ------------[ cut here ]------------
> [2025-04-16 22:56:24.758] [Wed Apr 16 22:56:26 2025] WARNING: CPU: 22 PID: 134878 at tcp.c:782 nvme_tcp_recv_skb+0x115e/0x11c0 [nvme_tcp]

My assumption is that this is a result of
WARN_ON(queue->request == req);

