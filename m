Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992CCC43217
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 19:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g9DSJDifwWvfnsu+wxUAYqktVLjY4wGwNWbv4WTUaWg=; b=IcpJe6vWzBX/JqpqNxzcVZjHqx
	7lcDeu5txfiq3KtZxJUu3hTIflNx78aMS8MTivuMiIfFls9DzJcL/OETsbIavxz5InbZ5gUrAG9Wl
	PIdUbhGxea0poMkrmDOijEe2tUVg3OZPSldjAXMEwDna85f90ZuVdWXNRzIgvLQ72UQPvVpP2ye7o
	RSVgV0NuwDcdZKFLz7WoC9e7Q7qNc1x4/5vZk079GlV0+CbcimjgNLnudVDvg5zGyCQ9VaZ6dDa8e
	ajDPDptH6q9BfpAZ4rTqk4QzGu3ojhYGdja+sJgZ5InOLrnh8O5YkpmkKU6PyJnhNZQmEUTHULL9W
	bkZS+b0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osqOO-00GS0f-2z; Wed, 09 Nov 2022 19:05:44 +0000
Received: from mail-qv1-f47.google.com ([209.85.219.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osqOK-00GRzo-Om
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 19:05:42 +0000
Received: by mail-qv1-f47.google.com with SMTP id i12so12954105qvs.2
        for <linux-nvme@lists.infradead.org>; Wed, 09 Nov 2022 11:05:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9DSJDifwWvfnsu+wxUAYqktVLjY4wGwNWbv4WTUaWg=;
        b=Jo6YOtgUl2qfbtqBC0E341Ght8fwt4HFDYPpKw6wbbvdsB3a9EjUmwda4seXScUPvg
         HQsS9RDeFcMWFfetgzm9TGeHM16trVhbY+zVIafqTM6kXp0DtOdwuSph/A8yvUPZtZHE
         ANWyPXbyGtMm7pUe5sCHjtzzpDp5BQ1GiTnSmgHrduq8RjxbprcSarQoNNNvdHDKcaFP
         ErC2Ru+E7kmRAEp08S25I4Ns8NmHtAhucS9RPtVwCORHwLqq9hfKOB1pBAvZ6YDPIczw
         //I8T4pCfvhy1DuQ33DeSe5/xVUS8tLyyy8nUGdl/k0eW9e0tZBKfrQfk5Mpbc6XzrX3
         reow==
X-Gm-Message-State: ACrzQf2Ht8xtfGg4fAikKs1tCAeOU+YOX+1DFBkXel6wmb+gBHOyWsFY
	PgLfJCh/ZAsDMQI0H0ya634=
X-Google-Smtp-Source: AMsMyM4m2q9Jt8PguQZHCJn07b//eHfiDPtGgCx2RgjFShdJUtAL4KdHUv/RSVTIh5Q/yPqv+96d0A==
X-Received: by 2002:a05:6214:248c:b0:4b8:fbe7:35a0 with SMTP id gi12-20020a056214248c00b004b8fbe735a0mr56357270qvb.75.1668020739240;
        Wed, 09 Nov 2022 11:05:39 -0800 (PST)
Received: from [192.168.82.40] ([108.95.161.27])
        by smtp.gmail.com with ESMTPSA id k7-20020a05620a414700b006fa4cac54a5sm11953888qko.72.2022.11.09.11.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 11:05:38 -0800 (PST)
Message-ID: <630b74b7-d22d-8d6e-52ba-68cee3d610c9@grimberg.me>
Date: Wed, 9 Nov 2022 21:05:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 12/16] nvme-auth: convert dhchap_auth_list to an array
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-13-sagi@grimberg.me>
 <a0f2868a-26dc-3742-d1e8-8483b637d2dc@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <a0f2868a-26dc-3742-d1e8-8483b637d2dc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_110540_821115_2695CE6D 
X-CRM114-Status: GOOD (  18.75  )
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



On 11/9/22 19:40, Hannes Reinecke wrote:
> On 11/9/22 04:44, Sagi Grimberg wrote:
>> We know exactly how many dhchap contexts we will need, there is no need
>> to hold a list that we need to protect with a mutex. Convert to
>> a dynamically allocated array. And dhchap_context access state is
>> maintained by the chap itself.
>>
>> Make dhchap_auth_mutex protect only the ctrl host_key and ctrl_key
>> in a fine-graned lock such that there is no long lasting acuisition
>> of the lock.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/nvme/host/auth.c | 113 +++++++++++++++++++++------------------
>>   drivers/nvme/host/core.c |   4 ++
>>   drivers/nvme/host/nvme.h |   2 +-
>>   3 files changed, 65 insertions(+), 54 deletions(-)
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index 23d486284da9..b78e0df54f6c 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -46,6 +46,14 @@ struct nvme_dhchap_queue_context {
>>       (qid == 0) ? 0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED
>>   #define nvme_auth_queue_from_qid(ctrl, qid) \
>>       (qid == 0) ? (ctrl)->fabrics_q : (ctrl)->connect_q
>> +#define nvme_auth_chap_from_qid(ctrl, qid) \
>> +    &((struct nvme_dhchap_queue_context*)(ctrl)->dhchap_ctxs)[qid]
>> +#define ctrl_max_dhchaps(ctrl) \
>> +    (ctrl)->opts->nr_io_queues + (ctrl)->opts->nr_write_queues + \
>> +            (ctrl)->opts->nr_poll_queues + 1
>> +#define nvme_foreach_dhchap(i, chap, ctrl) \
>> +    for (i = 0, chap = (ctrl)->dhchap_ctxs; \
>> +         i < ctrl_max_dhchaps(ctrl) && chap != NULL; i++, chap++)
>>   static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
>>                   void *data, size_t data_len, bool auth_send)
> 
> Please use an xarray (cf my patch doing the same).
> That leads to far better readable code, and avoid having to do weird casts.
> 
> Also, the claim 'we know exactly how many queues' isn't quite true, as 
> we only know the _maximum_ number of queues. The controller can (and 
> will) decrease this number based on the target configuration.

I don't want a dynamically allocated array, this pattern of first time
allocates a context and the rest of the time reuses is less readable and
causes interlocking.

