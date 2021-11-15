Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF91C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 10:19:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2902C61B39
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 10:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2902C61B39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4sfVNl8vuBD49gaqQ8z5NKlvyrrhdpQhLUOKagbbM6A=; b=qukVC8/A+vMmJTkZfYcEsCk92I
	CKZVLlo9XVIoO2LWTNSPvCGga3ZtkJP868eVbgxnkI9f5l7JI7sOddRzMxgP3WqP5f+VaeyjFyOSg
	jLMmBT3WrvAJZTKWiXXsZE0a0aVeu5SPclNGh30Blg3Fhpc98/tvqZhUJujOTWSD2OFRv1cVxGYM7
	SGAPnWygSsKctI8uDBZLd83IEZg4q+h1zc9oMponteNg9lIs5HChwtjZHQOUrV67y0RSTOwRW0WjL
	4+88YAIBV5ht4CBQamNFGWlkXoiVNP8kI/nU78B1gYpQ4NKF4eo/dftJ7zBVjeNHfhbbNF+zdczcJ
	oc+i/pFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmZ4n-00F9KM-Gy; Mon, 15 Nov 2021 10:19:01 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmYzC-00F7as-T7
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 10:13:16 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 az33-20020a05600c602100b00333472fef04so14572317wmb.5
 for <linux-nvme@lists.infradead.org>; Mon, 15 Nov 2021 02:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4sfVNl8vuBD49gaqQ8z5NKlvyrrhdpQhLUOKagbbM6A=;
 b=i4rnJ67F87Kt2x/LWXjh1jI8fL1HcgGGEr1GVxkGWlgabGXXCU8C8vfE601YOiIwYE
 zU4BSbxKes1PJCtHjMkHLxi9TyYyCoBQFl2Ay2lkcIdnyGFamae4WnfIUXj3xsjLGLvz
 PW005pfYr6Rp604+4VwBTvkx6bcyPwM0SLyhLmBgQ8uZgNBpFjeYL/c4nPWX+aBIJfDb
 Rpo+hmjq6531pdp05kZINFx5v1JwvE2LrotYF4v8CJhrKJzuvTlCM6Xgn+U46S7jwTZu
 p6abBCXKzVE3hIaRjTK3OIltsLbVFgOftdwlXCXwJM9BxpXH53lT60E478doPfaGOotC
 dPaw==
X-Gm-Message-State: AOAM532T17+yfUGoPFZRs3TUqFOdDSoAlHivwX6aEQTL5IouxbfFj6ry
 Eb2jbNgqzqm0mDiULGWAb/8=
X-Google-Smtp-Source: ABdhPJzwHt+txbv067Cq4rg2VgOMipNJ+5s3pb3kkv+uBOUqFsp35Id6HNn54w/ujYrr/UWj9SwBeA==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr40074554wmc.39.1636971189791; 
 Mon, 15 Nov 2021 02:13:09 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id p12sm16653755wrr.10.2021.11.15.02.13.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Nov 2021 02:13:09 -0800 (PST)
Subject: Re: [PATCH 2/2] nvmet: fix a race condition between release_queue and
 io_work
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
 chaitanya.kulkarni@wdc.com, jmeneghi@redhat.com
References: <20211021084155.16109-3-mlombard@redhat.com>
 <54e0464e-0d05-4611-10d9-7b706900af28@grimberg.me>
 <20211028075531.GA4904@raketa>
 <68b69eee-c08c-a449-7e18-96e67a3c0c9d@grimberg.me>
 <20211103113125.GA106365@raketa>
 <24a4036b-4f11-91f4-ee0e-80a43f689b09@grimberg.me>
 <20211112105430.GA192791@raketa>
 <ee5a0405-a8a5-0d8a-d3be-11fe1011c073@grimberg.me>
 <20211115074720.GA21836@raketa>
 <60f43502-c641-6177-4b1e-95f6179ddc42@grimberg.me>
 <20211115100004.GC21836@raketa>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <65fa8d9a-d21a-4d4e-4bba-ca8bd88fa02d@grimberg.me>
Date: Mon, 15 Nov 2021 12:13:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115100004.GC21836@raketa>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_021314_999237_44E8363C 
X-CRM114-Status: GOOD (  17.74  )
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


>> --
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 6eb0b3153477..65210dec3f1a 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -1436,6 +1436,8 @@ static void nvmet_tcp_release_queue_work(struct
>> work_struct *w)
>>          mutex_unlock(&nvmet_tcp_queue_mutex);
>>
>>          nvmet_tcp_restore_socket_callbacks(queue);
>> +       /* stop accepting incoming data */
>> +       queue->rcv_state = NVMET_TCP_RECV_ERR;
>>          flush_work(&queue->io_work);
>>
>>          nvmet_tcp_uninit_data_in_cmds(queue);
>> --
>>
> 
> Ok I can repeat the test, but you probably want to do this instead:
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index fb72e2d67fd5..d21b525fd4cb 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1450,7 +1450,9 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>          mutex_unlock(&nvmet_tcp_queue_mutex);
>   
>          nvmet_tcp_restore_socket_callbacks(queue);
> -       flush_work(&queue->io_work);
> +       cancel_work_sync(&queue->io_work);
> +       /* stop accepting incoming data */
> +       queue->rcv_state = NVMET_TCP_RECV_ERR;
>   
>          nvmet_tcp_uninit_data_in_cmds(queue);
>          nvmet_sq_destroy(&queue->nvme_sq);
> 
> If you don't perform a cancel_work_sync() you may race against a running
> io_work thread that may overwrite rcv_state with some other value.

Yes, that makes sense.

