Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0361BC3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 23:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/4DQAhaj9YjUDPeP3ef6NA9TE6XMRR/1RJnN379JjFk=; b=BzpmEcqzFv1yopyPN6lfcC3qHb
	fk7P6K5KKNqasnioKWlBooCtOJdtSlIrdcGpAQ5i5iJLPQJ6IxGuJSbvuiReJbfrHUcHQb1/I4RlH
	zHAyk+UjQSg4+CGPIYMO+4CIRD4S3UeHgh2NqBNtIYSqf/QCAaOFz/F1shvG6aZslzPPoDFbz3nIg
	iredYNWISiuNIc0nUU+V58onpRpMaHraEmyfZw4U/CdQZ2QCxWb2GSkU6vYuKjxhMaDagViRTMByg
	RKJZNWwV/iYnz54TyZSH54ZalioYQWU3zS4qrLJACyx6+A1OzFbUqAqn0jbJrqoZHlcME71BgGQeo
	FOC3U2Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u46S0-00000000KPP-045d;
	Sun, 13 Apr 2025 23:09:20 +0000
Received: from mail-ed1-f53.google.com ([209.85.208.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u46Rw-00000000KP0-0lzi
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 23:09:17 +0000
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so7488694a12.2
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 16:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744585754; x=1745190554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/4DQAhaj9YjUDPeP3ef6NA9TE6XMRR/1RJnN379JjFk=;
        b=B2xJtxdURq5T65j7KOuZOOe1k7FYodN4orAzaZ0O+infZN452XyvnECSKg5jKSWQer
         bSVPwKKy7sbROFCXVsuJMyRljF4cnff9MAR01Anm9hYxXhxnM11hYK94sSbdsD4Lsmfh
         nUvcmpgwxp4CbHD6JSWNIfq3HynrKjEphdjQGYYyNseCaxAwZA8T3vX3gbqTKx4IsSCA
         41an2eCSq9fFLky25BHAhYPoRTjWdlLPEMJS1QLN20X7oezF5I4TXa6du4ap7mJIwEn5
         h2c/dr7Z8iajLs6ZY59+MgfvJ5NsI6V0Bt9upLHQy5O6gPjqjA6zJDwvNgEuoqoE9LnP
         bxZg==
X-Forwarded-Encrypted: i=1; AJvYcCX7N95dfufktpi02tttySvrYjPiWdwLvde3J8OUjYwxCWKKPclKZe9ce4d+t78CeOx8FsBEjtEqQrFU@lists.infradead.org
X-Gm-Message-State: AOJu0Yy//7RFufD7rRQJlGxM1r2bi0yiXybAnD8p3ebE1iBKHz6Iuf32
	rxE9WsFLQ4IEXLCoIRikhS42UxUnsR5k41Yw+2dLjkfXvcpQc39qxnLoLw==
X-Gm-Gg: ASbGnctn53GvxocoPWxlG0v6j1NXecZB5/OM7is1jglCGFajRMbKZ8b5VQYqeJhBtB/
	UYpo9SjoN+XWo96NygtM4NFk0Rff72D+ZRmF5lWP5ufDdxwHR2cMFz+ReTCRM7XOKZ9Fc2p0uin
	hGQaj9DutzUrR2ibLj2Pxo0VEoUUhd1Rd9ns5IripEVeq0KyE0pa0UfsK1i50IGN4wDPBpW8uEw
	nZY3HYNUiBO+2BVsEpAa5az4sy0/DFu3dJt4UKUjD+s3tg+AA27QXmsh0StanlvRk5pLEGmuF3K
	7tuPmkn50V5lBITCtokNvxN3piuROj/FGpza9luw7snGYVUNREnDuJtaH6g0MZEAj2bTyzNlY+L
	T1cncW2U=
X-Google-Smtp-Source: AGHT+IGn/Or7lOYgQ0cnwfsrb0tcQl7nDlYcCrau176gSzU3IpKvoMuj+14Q2soGNbHl1+Hp8CyCxQ==
X-Received: by 2002:a17:906:db05:b0:aca:c4a6:cd90 with SMTP id a640c23a62f3a-acad34395c7mr1001686366b.5.1744585754346;
        Sun, 13 Apr 2025 16:09:14 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be9145sm811070066b.50.2025.04.13.16.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 16:09:14 -0700 (PDT)
Message-ID: <ee4379d7-53f8-4399-ba94-be9113b11b48@grimberg.me>
Date: Mon, 14 Apr 2025 02:09:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250403065522.90807-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_160916_307316_9333915D 
X-CRM114-Status: GOOD (  19.81  )
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



On 03/04/2025 9:55, Hannes Reinecke wrote:
> When the socket is busy processing nvme_tcp_try_recv() might
> return -EAGAIN, but this doesn't automatically imply that
> the sending side is blocked, too.
> So check if there are pending requests once nvme_tcp_try_recv()
> returns -EAGAIN and continue with the sending loop to avoid
> I/O stalls.
>
> Acked-by: Chris Leech <cleech@redhat.com>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1a319cb86453..87f1d7a4ea06 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1389,9 +1389,12 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   		result = nvme_tcp_try_recv(queue);
>   		if (result > 0)
>   			pending = true;
> -		else if (unlikely(result < 0))
> +		else if (unlikely(result < 0) && result != -EAGAIN)
>   			return;

The way that the send path was done - is that EAGAIN returns 0 (success 
returns >0, failure returns <0)
Perhaps we can make recv do the same?

>   
> +		if (nvme_tcp_queue_has_pending(queue))
> +			pending = true;
> +

Something is not clear to me, this suggest that try_send was not able to 
send data on the socket,
shouldn't a .write_space() callback wake you when the socket send buffer 
gets some space? Why
do you immediately try more even if you're sendmsg is returning EAGAIN?

This is specific to TLS I assume here?

