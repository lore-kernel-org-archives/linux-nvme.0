Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47959C2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 19:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1aRkp+HniClqKNt7nVqN/hP5GeUc6of7aGZ3LquWfSc=; b=W96O2wn3eApJO/Tke4h8TkTRcx
	++jI7ZJ6tbYjW+rhrXwDKKt4YtZ0MOlz/AgH1Vr+bvvjsosu01rrLdCWqnc8ONfe4N6xuyqUo/wRo
	Mwll4JmfYhRfvwnIPCHZRGOqTtAhQv6tAEwN0ruNJw8AalEgDuObik4hGUH7FrAWgune5hvIS3I2b
	vMI5d1KgPN8GK0OdcMtrvEfu8E9iO6pVS3cx7bksb13wmvP3gmXsPJG3cVb05HRSCUOLeqePeiWp5
	1eY53QbafRcJ9lrOQPcd1bkMI5r+Io/TpRLzsxRdF9GZOOb5K6FISYcavNokV0fqRBgdaG6oxZN//
	yEkXEzxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP5rM-0000000BINl-3SNY;
	Wed, 03 Jul 2024 19:41:44 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP5rJ-0000000BINK-42AQ
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 19:41:43 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3678c388f92so141320f8f.2
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jul 2024 12:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720035700; x=1720640500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aRkp+HniClqKNt7nVqN/hP5GeUc6of7aGZ3LquWfSc=;
        b=l1kOAgWXa4+jWsA/lWAq9kSp9DNi9ZZ9EQYxNngQhrqHIdZYtkvaE//tHvj0a3km7w
         9KlYSIE4FgtkoP90EWFtiaNz5j89IIngBV3N2zr+GFGSd0tAax8suPuGY5Uj1qLAJeZ9
         8tC9DL2OP2UeiXz9YgJrChz+gNdevPD2xgzYAWFcpTkO1MQQIfHVUvl75MSYY0KyL3oE
         VLjUO28/yoXXDcl+lR/VHpqXOksUnTdskwzRUmG0PtDtcwA6cu+e28s0Wxx1lNRNrStd
         +u5hkA4FPgOknl9rVQqkOGtEIIjuVJmQQrWza0YzvbOPIfedySrxKmWBw3pzAGdG/zd8
         XHRg==
X-Forwarded-Encrypted: i=1; AJvYcCUXYJ243FT5DEJnh4nGQ8zzdQjhRyihhSHPWgeA75pKWEZSFBZBWDIuJwFt1jIOV1Sg3jVhS5wRaLkKXFkjFwn4rH4ouVU1wTET7qFPLTo=
X-Gm-Message-State: AOJu0Ywy6lcml0YGTnncs5dmg1n0+QEnJoeYRpx0BkmZB8ehDpZAoYwe
	mCoLwNGsQhIn54zXyXsih6uX2oQH1IkSy1mrwOX7uAIYwwNWfaRP
X-Google-Smtp-Source: AGHT+IEL2Y4ccoVi6VzZeW1tSrGGZHfbxXmC9hLL1qx3B0NbS8PaerBQhACcbpFdJMQNf3c9SBbWtw==
X-Received: by 2002:a5d:64e6:0:b0:362:4aac:8697 with SMTP id ffacd0b85a97d-3677562074emr8465567f8f.0.1720035700195;
        Wed, 03 Jul 2024 12:41:40 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cdc5csm16607718f8f.18.2024.07.03.12.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 12:41:39 -0700 (PDT)
Message-ID: <e78e0939-e58b-42e8-b13d-602e1f880cfd@grimberg.me>
Date: Wed, 3 Jul 2024 22:41:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvme-tcp: per-controller I/O workqueues
To: Tejun Heo <tj@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-2-hare@kernel.org>
 <7e4444d0-f156-439e-9363-4beb86bb6248@grimberg.me>
 <c9f73300-9860-4965-88af-9a7b4d7b0e1b@suse.de>
 <ad15b94b-9414-4ec1-9acf-465a8b190fe5@grimberg.me>
 <ZoWFOnvgWEiKipW6@slm.duckdns.org>
 <aaa404b1-72ac-4b15-8c30-a62ef2216004@grimberg.me>
 <ZoWjxtyjHTC2r285@slm.duckdns.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZoWjxtyjHTC2r285@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_124142_034884_6F6F02C4 
X-CRM114-Status: GOOD (  13.33  )
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



On 03/07/2024 22:17, Tejun Heo wrote:
> Hello,
>
> On Wed, Jul 03, 2024 at 10:14:14PM +0300, Sagi Grimberg wrote:
> ...
>> None of these reasons are the claimed reason to use separate workqueues in
>> this patch. The claim is that it is more efficient, i.e. has less overhead.
>>
>> The commit msg is the following:
>> "Implement per-controller I/O workqueues to reduce workqueue contention
>> during I/O."
> Hmm... it's not impossible for the concurrency accounting in pool_workqueues
> to show up if the issue rate is *really* high but I'd be surprised if that
> actually matters given that the backend pool is shared. Maybe I'm missing
> something but I don't see a reason why multiple workqueues would be more
> efficient than a shared one.

That was my assumption as well, that there is no real point in using 
multiple workqueues.
And hence my surprise.

Hannes, can you please provide a quantitive improvement that you saw simply
by separating to different workqueues?

