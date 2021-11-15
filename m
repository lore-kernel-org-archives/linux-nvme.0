Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B056C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 10:09:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCD261040
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 10:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BCD261040
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lrqx87o7hTxnozZLWMMC6eRwLneq7wBFoGT2u98LNEI=; b=LB3fFvelT0oc7iPMMuUUXETi4U
	JYNq4T527NAyEQjRVlmVL+qEN7nTEGL0GWKPX06w31AmcV12nTrExZeP2qOr5GYmqWHhxZDGoJyPa
	60CE1V/pz4EcWjqebMOJP+dWTpbL+m/VbYkVzAqLaof3HjnCmIj6EF0Ft1tw7TekPrcogabnYiPF2
	frIeixNqfLEaRaz4sPTy7gyba3YASU6SzyzJYq3mNrX9sD4o0obmfz+04a9NEUViVllYZJrbsWjCx
	bU92WP4LtwHY32r0vYWFNUJfOtIW9iIx2BjMT882gfMyM/bAAW4q91dkppvYLVnHGmyVkwtkDwWsE
	dmCTGPnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmYvP-00F6II-1N; Mon, 15 Nov 2021 10:09:19 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmYbS-00F0D1-Ha
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 09:48:43 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 p3-20020a05600c1d8300b003334fab53afso12347138wms.3
 for <linux-nvme@lists.infradead.org>; Mon, 15 Nov 2021 01:48:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Lrqx87o7hTxnozZLWMMC6eRwLneq7wBFoGT2u98LNEI=;
 b=lN77ZpVXATfXrhHhS5hFnww9PNh6/seSomKPsiVb4uHIKTKFuKXAwCzZbVXAsYW+Bs
 97v1ZUQsOsQWzM6BQtXDwEHm4HOi3SCzjDDwNInVJVzV4vAaA5skWnjUMyFYn4A85SFr
 POEInT1S/kSp2Pq9UTGWnoc+B/SpiMo17H/bE/tjsEhdVlMBpdWGswm/3RRrE9AxS7yw
 ikq2ShDcZyE8A19dZIVmPKp8o7rHhY/+4YY30m2uIybwg4xNGXwnIoqRD3F2vvwa3J6z
 sTV1tUjzASZgiUQ11lUGdKuv1BpVhMewHrgkQvE6jJ+NGoDvrE7uUs8FWHrexys7cqjh
 CzKA==
X-Gm-Message-State: AOAM533MxjyPS2CBtaizGtodIa1wiAQfjifaamDTcoo2n4/Dluuq6wmZ
 w0OLWQu02mEh6YliF8E4xqw=
X-Google-Smtp-Source: ABdhPJxcFfjhKaAJP4x1A9gg0P7VD44k8cRfTxpD+9eIZ2u3XvXPYhT7Wd6zqy/UzkJyBS7atIBtww==
X-Received: by 2002:a05:600c:4793:: with SMTP id
 k19mr60051730wmo.72.1636969720590; 
 Mon, 15 Nov 2021 01:48:40 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o10sm16938511wri.15.2021.11.15.01.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Nov 2021 01:48:40 -0800 (PST)
Subject: Re: [PATCH 2/2] nvmet: fix a race condition between release_queue and
 io_work
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
 chaitanya.kulkarni@wdc.com, jmeneghi@redhat.com
References: <20211021084155.16109-1-mlombard@redhat.com>
 <20211021084155.16109-3-mlombard@redhat.com>
 <54e0464e-0d05-4611-10d9-7b706900af28@grimberg.me>
 <20211028075531.GA4904@raketa>
 <68b69eee-c08c-a449-7e18-96e67a3c0c9d@grimberg.me>
 <20211103113125.GA106365@raketa>
 <24a4036b-4f11-91f4-ee0e-80a43f689b09@grimberg.me>
 <20211112105430.GA192791@raketa>
 <ee5a0405-a8a5-0d8a-d3be-11fe1011c073@grimberg.me>
 <20211115074720.GA21836@raketa>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <60f43502-c641-6177-4b1e-95f6179ddc42@grimberg.me>
Date: Mon, 15 Nov 2021 11:48:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115074720.GA21836@raketa>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_014842_620795_CB220B75 
X-CRM114-Status: GOOD (  16.86  )
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


>> How about something like this:
>> --
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 6eb0b3153477..6425375faf5b 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -1436,7 +1436,9 @@ static void nvmet_tcp_release_queue_work(struct
>> work_struct *w)
>>          mutex_unlock(&nvmet_tcp_queue_mutex);
>>
>>          nvmet_tcp_restore_socket_callbacks(queue);
>> -       flush_work(&queue->io_work);
>> +       /* stop accepting incoming data */
>> +       kernel_sock_shutdown(queue->sock, SHUT_RD);
>> +       cancel_work_sync(&queue->io_work);
>>
>>          nvmet_tcp_uninit_data_in_cmds(queue);
>>          nvmet_sq_destroy(&queue->nvme_sq);
>> --
>>
> 
> This one doesn't work, remember that nvmet_sq_destroy() will start io_work
> again and, as I wrote in my previous email, recvmsg() might still return some
> data after the socket has been shut down.

I see, the reason why we hit this is because we uninit_data_in_cmds as
we need to clear the the sq references so nvmet_sq_destroy() can
complete, and then when nvmet_sq_destroy schedules io_work we hit this.

I think what we need is to make sure we don't recv from the socket.
How about this patch:
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 6eb0b3153477..65210dec3f1a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1436,6 +1436,8 @@ static void nvmet_tcp_release_queue_work(struct 
work_struct *w)
         mutex_unlock(&nvmet_tcp_queue_mutex);

         nvmet_tcp_restore_socket_callbacks(queue);
+       /* stop accepting incoming data */
+       queue->rcv_state = NVMET_TCP_RECV_ERR;
         flush_work(&queue->io_work);

         nvmet_tcp_uninit_data_in_cmds(queue);
--

