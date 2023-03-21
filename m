Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35F0C6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qeXImOJXwQZtfKxYWP9d4cBjYPKhnaEc8iXXM/vt6yk=; b=wopGizsVKME9ijFGeCN2RHnVk1
	req54Y/TenQR2wm37Y8Ulzy4OtZjdPhtgwfIPH7CQpWsC57HT/moqS/z6M7RQAYowpXNlZ9uBA1Cl
	3WJuccnQoqVWVX1zMPbnsSbdfbIwgnBov3iikkwbAxzUFngXy90yrTs96tKHtJK5tjYbxDb3lp1j8
	+x2+tROgfX142ejxIcrYkBxu2XVcb8mjDJVqWh4iRi1iqv3JUrj3j8s7pRDzmHawbnkbEZHjT8988
	h6yg6FQRIiLUImUU8rYEpdDrf+uKL+Vakcf+qy/IuXv3HgI71CUqsUBEbF6Q2JGv3MFmd5ZtERHEz
	tVTUqBzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pecHh-00Ca63-2C;
	Tue, 21 Mar 2023 13:44:17 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pecHf-00Ca5F-1A
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 13:44:16 +0000
Received: by mail-ed1-f47.google.com with SMTP id eg48so59747022edb.13
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 06:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679406252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qeXImOJXwQZtfKxYWP9d4cBjYPKhnaEc8iXXM/vt6yk=;
        b=tE+bWBR9wP8HC5GzQt33y37PfDlRtSjqrbrICRl1gq7/PMt6ZrGeEe8DLK//eSbykw
         aUbCxb/myY2GiTNH6FWV+Ad97XOXUmsJlN5gXYhy3238R5y49i/BpiiOqnIMf54r7eGE
         bul5y8hJPuvV9pdCEvckHcjvnm8avpsycpBt9ccn24C7B8lOZ7BujdWOwzzj21JwT6zn
         9/KAF2fTTnrFC+vspw2LQdatBz5BDLlKlGvN7CXVbyX45eZuo5810kjE1vrUEt36eN5o
         6likWTE6rRLLi6Roz1VUFAarUrgkixPSVdwv2qVf0ZI1fEJS9NHP6o5y5oM9vYvGnop0
         y14w==
X-Gm-Message-State: AO0yUKV9yAoyGGdKOiziSxLaAsftpvlzdosz0teWJ3KtuMYi0PijJS87
	uw382NHvb+udqoRCUy/LqNw=
X-Google-Smtp-Source: AK7set+QtgsTOztEKP7Zluhztb0JkFvWLMf3ZhOlj5nPnXp2CzgR+/VuMM+pgBXNRWKMkBK0P2BnaA==
X-Received: by 2002:a17:906:289:b0:92b:dd20:16f5 with SMTP id 9-20020a170906028900b0092bdd2016f5mr2795267ejf.7.1679406252407;
        Tue, 21 Mar 2023 06:44:12 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090608cb00b008d0dbf15b8bsm5888283eje.212.2023.03.21.06.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 06:44:12 -0700 (PDT)
Message-ID: <d868b752-1d8b-1236-3543-c9ef82e42f23@grimberg.me>
Date: Tue, 21 Mar 2023 15:44:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/18] nvme-tcp: call 'queue->data_ready()' in
 nvme_tcp_data_ready()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-7-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321124325.77385-7-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_064415_396377_8011ECB3 
X-CRM114-Status: GOOD (  19.44  )
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


> Call the original data_ready() callback in nvme_tcp_data_ready()
> to avoid a receive stall.

Can you please improve the description to include what is the stall?
For example, does the stall exist today? If it is, I would like to
separate such patches from this set and include them asap.

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 0e14b1b90855..0512eb289dcf 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -936,12 +936,14 @@ static void nvme_tcp_data_ready(struct sock *sk)
>   
>   	trace_sk_data_ready(sk);
>   
> -	read_lock_bh(&sk->sk_callback_lock);
> -	queue = sk->sk_user_data;
> +	rcu_read_lock_bh();

Now I understand your comment from a previous patch.
Can you explain why is this convention needed?

I would prefer to have it as a separate patch with an
explanation to why it is needed.

> +	queue = rcu_dereference_sk_user_data(sk);
> +	if (queue->data_ready)
> +		queue->data_ready(sk);

Is the tls data_ready call sync or async? just for general knowledge?


>   	if (likely(queue && queue->rd_enabled) &&
>   	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
>   		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> -	read_unlock_bh(&sk->sk_callback_lock);
> +	rcu_read_unlock_bh();
>   }
>   
>   static void nvme_tcp_write_space(struct sock *sk)

