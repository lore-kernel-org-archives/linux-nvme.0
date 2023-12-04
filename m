Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AC8C10DC1
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 11:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n+ZKdDmogaLjHjr0DBmaLF4+607jBnKtWiPd/dqO7tA=; b=0K9iTLIP99DjzVmYwaIWjUfTax
	NoS6lBlAjLsIT5Yd50FHrt3+fplPSVccgDQpha+xdVTnljDPDiytYoWIGQtVsV6Zngk0tg9sHEm9n
	ZkxLam0kCi2t3n+n9yfmFoxQR2zlKc/fquvu64XIe2msa2ktrsK4n1uulxgNQ0bSpjwPUqVsqGeSy
	nHJBh2Yi79FvW6XkZEceXoiNkT6ZwRFvq1HQG9q1k/Xo/AhoHleCCgtXfe4pRTBHOFlxRFWyZltxs
	HtQusXKcCYYGFjpoWBQ+M06uavIahmyDdfLb64BJTmtwsV8k+cV2e1vr54Xe8tJM7h3+G7OlXAF9l
	MO7mScbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA7a3-003kDq-1f;
	Mon, 04 Dec 2023 11:57:43 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA7Zz-003kAr-2X
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 11:57:42 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a1bc6cae689so1011966b.1
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 03:57:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691055; x=1702295855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+ZKdDmogaLjHjr0DBmaLF4+607jBnKtWiPd/dqO7tA=;
        b=ptw20wlJPNbTUfsPtANZhPxhSSFnEVHJyzusGtVjhjOtB97YSeZup0YEwTcT0up6Kr
         mfor5oQRiwLQXEnX72KDYyxx6fQJRHmQK9Bz+3zSrGbIUB69v6xT/pjTzMAhFgDHnae/
         3uD/tHwrkBgAQb3u9UYJNKOZWLlPnPnJkDeHPKInIA9eWLaIJgKx/tdS/isvkkSsdmrA
         lhegpOQ92/KL5obxkrJjJIINYxWOxl3dN3ZqUHhNn6fs7iIL3Pr+pLye0jRI42caIE/+
         9c89FzoBjxydxzidmXfmnHmfjN5vuAsJ3XF6acFYB0P5M0ognLZjnC+LR83i+6ukKpzM
         jggg==
X-Gm-Message-State: AOJu0Ywf73p2w0JfDwFg/b0rxiMqMWHg7BIMn4A3jxfjnf031NzPlIhW
	l+Myujo3sgxDV3lZcUC9dRrgf5dFQ5U=
X-Google-Smtp-Source: AGHT+IElMLB0jJ4HGVO1v96GEQfrEHJ0oCIp92Hso5SEyOqOP5xXYPxchUg/19Xq9Vp8L8UktXzM8A==
X-Received: by 2002:a17:906:9b10:b0:a1b:6d14:20c with SMTP id eo16-20020a1709069b1000b00a1b6d14020cmr1705858ejc.6.1701691055342;
        Mon, 04 Dec 2023 03:57:35 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906198500b009c5c5c2c5a4sm5215662ejd.219.2023.12.04.03.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 03:57:35 -0800 (PST)
Message-ID: <9ca33803-e2ca-4550-8d6e-1e64219fb3d9@grimberg.me>
Date: Mon, 4 Dec 2023 13:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20231102141903.66515-1-hare@suse.de>
 <20231102141903.66515-2-hare@suse.de> <20231103082305.GA17096@lst.de>
 <69b6f873-f8a1-482b-a739-b47da6e98cec@suse.de>
 <20231103091952.GA18200@lst.de>
 <e09869f2-193b-4f03-a12f-2a7f6c24d537@suse.de> <20231103140514.GA2395@lst.de>
 <d5ef550d-91da-4135-959d-e10f153514a0@grimberg.me>
 <52bd0ef3-b91e-492e-8117-41a290b6cfe6@grimberg.me>
 <c261fe62-e8e6-4470-b9e2-3047fd4c3d99@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c261fe62-e8e6-4470-b9e2-3047fd4c3d99@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_035739_829925_EC9EC3EB 
X-CRM114-Status: GOOD (  26.83  )
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



On 12/4/23 13:49, Hannes Reinecke wrote:
> On 12/4/23 11:19, Sagi Grimberg wrote:
>>
>>
>> On 11/20/23 15:48, Sagi Grimberg wrote:
>>>
>>>>> According to 777dc82395de ("nvmet-rdma: occasionally flush ongoing
>>>>> controller teardown") this is just for reducing the memory footprint.
>>>>> Wonder if we need to bother, and whether it won't be better to remove
>>>>> the whole thing entirely.
>>>>
>>>> Well, Sagi added it, so I'll let him chime in on the usefulness.
>>>
>>> While I don't like having nvmet arbitrarily replying busy and instead
>>> have lockdep simply just accept that its not a deadlock here, but we can
>>> simply just sidetrack it as proposed I guess.
>>>
>>> But Hannes, this is on the other extreme.. Now every connect that nvmet
>>> gets, if there is even a single queue that is disconnecting (global
>>> scope), then the host is denied. Lets give it a sane backlog.
>>> We use rdma_listen backlog of 128, so maybe stick with this magic
>>> number... This way we are busy only if more than 128 queues are tearing
>>> down to prevent the memory footprint from exploding, and hopefully it is
>>> rare enough that the normal host does not see an arbitrary busy
>>> rejection.
>>>
>>> Same comment for nvmet-tcp.
>>
>> Hey Hannes, anything happened with this one?
>>
>> Overall I think that the approach is fine, but I do think
>> that we need a backlog for it.
> 
> Hmm. The main issue here is the call to 'flush_workqueue()', which 
> triggers the circular lock warning. So a ratelimit would only help
> us so much; the real issue is to get rid of the flush_workqueue()
> thingie.
> 
> What I can to is to add this:
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 4cc27856aa8f..72bcc54701a0 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -2119,8 +2119,20 @@ static u16 nvmet_tcp_install_queue(struct 
> nvmet_sq *sq)
>                  container_of(sq, struct nvmet_tcp_queue, nvme_sq);
> 
>          if (sq->qid == 0) {
> +               struct nvmet_tcp_queue *q;
> +               int pending = 0;
> +
>                  /* Let inflight controller teardown complete */
> -               flush_workqueue(nvmet_wq);
> +               mutex_lock(&nvmet_tcp_queue_mutex);
> +               list_for_each_entry(q, &nvmet_tcp_queue_list, queue_list) {
> +                       if (q->nvme_sq.ctrl == sq->ctrl &&
> +                           q->state == NVMET_TCP_Q_DISCONNECTING)
> +                               pending++;
> +               }
> +               mutex_unlock(&nvmet_tcp_queue_mutex);
> +               /* Retry for pending controller teardown */
> +               if (pending)
> +                       return NVME_SC_CONNECT_CTRL_BUSY;
>          }
> 
> which then would only affect the controller we're connecting to.
> Hmm?

Still I think we should give a reasonable backlog, no reason to limit
this as we may hit this more often than we'd like and the sole purpose
here is to avoid memory overrun.

