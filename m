Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F211C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 18:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g3uJ3F6D1uEliBXShz8kbBpJR7TibOY8nGY9hg8In1g=; b=1RlPekaTpY5vmP3EvJFhfBihsc
	uXB9LS8qlLPn7kLqzrNccN+BoXhXmIHSPzYQKvIexACIeC9u3CyTwCJtFW2sjASu/YlYzBkv3yOBA
	J1C27PJFrpA9sAWfM3/n6F5Izebg8ODAJQ/XUOK10GsJryGWA1LOeSWoSPsFUyxfJ0734DO9skOQM
	IbueoVODo7G6WlZ3m4qeqiBnyqNR9YFAUQi+CzuH1MEdPVRGwWcHy/emqnXAaL4JlAtNDHUFQHQ0g
	/IT7U+V0WYwsu9aVmYVAuZcoaWSbb/Y6ZQiT3n8jl3f6dToTVzAm1ujBAfiUEAmgWB8pgqG/ESSOf
	EBi7CvTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osq1s-00GFZC-Bv; Wed, 09 Nov 2022 18:42:28 +0000
Received: from mail-qv1-f43.google.com ([209.85.219.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osq1q-00GFUE-01
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 18:42:27 +0000
Received: by mail-qv1-f43.google.com with SMTP id n18so12882759qvt.11
        for <linux-nvme@lists.infradead.org>; Wed, 09 Nov 2022 10:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3uJ3F6D1uEliBXShz8kbBpJR7TibOY8nGY9hg8In1g=;
        b=BNNf1UPqvPUg49cLuWWFW5o1m+XE3X2MucfY1CoGYTRGazEvHSjMxl3W/TBjA9cVJ8
         giBBv7PFEzL6/S1lhwc6K43n2OqWWzDG5PvaU7oyBp4BpwrRMo3E9uySaMwVMfCYHREy
         gO4OGi7l89qI9fBoBBYcmPxBZgclNTUJAwHtepqtUpnlF8GfBnQDkYSgNQ6IKvp6Nq83
         ayd2X1aPl5aNg/nhXCvO7pBjyyZolYyWDy0z8UbD0/6gi5+TLu3n6i6Ac4Gaui9SaWzs
         EAmqZLlY8xgRjnvPaayvoYOGB8peKtUVVn1T4dtVMGaOuh27Lr335dZYBb2FQBKbepPA
         mD6g==
X-Gm-Message-State: ACrzQf3MEMa8alVG9tFxbIMbmgrEbUxV+5qxvpF5HQfXJ8XOZvb7Ihif
	iaUWmUFLu9CNYkYVa6uQitg=
X-Google-Smtp-Source: AMsMyM44MtZfYxJgribwXKEVjXBk+6jFF4xUaSKq92BYeEg22QnMIKXaNC3wl6Kc6cT572kwPX/jMg==
X-Received: by 2002:a05:6214:f2a:b0:4bb:5880:2bd1 with SMTP id iw10-20020a0562140f2a00b004bb58802bd1mr55242900qvb.104.1668019341698;
        Wed, 09 Nov 2022 10:42:21 -0800 (PST)
Received: from [192.168.82.40] ([108.95.161.27])
        by smtp.gmail.com with ESMTPSA id j11-20020a05620a410b00b006fa2cc1b0fbsm11823016qko.11.2022.11.09.10.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 10:42:21 -0800 (PST)
Message-ID: <113d0db5-258c-121a-8be6-78857849feb2@grimberg.me>
Date: Wed, 9 Nov 2022 20:42:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 07/16] nvme-auth: remove redundant if statement
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-8-sagi@grimberg.me> <20221109063757.GA10893@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221109063757.GA10893@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_104226_066349_5B076747 
X-CRM114-Status: UNSURE (   9.08  )
X-CRM114-Notice: Please train this message.
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


>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index a6312a8846f8..07d497f49e4b 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -874,7 +874,7 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
>>   		mutex_unlock(&ctrl->dhchap_auth_mutex);
>>   		return -ENOMEM;
>>   	}
>> -	chap->qid = (qid == NVME_QID_ANY) ? 0 : qid;
>> +	chap->qid = qid;
> 
> Btw, the same "transformation" can also be removed in nvme_auth_submit.

There if qid = 0 we want to pass NVME_QID_ANY because we don't want
__nvme_submit_sync_cmd to use blk_mq_alloc_request_hctx as we are
using the admin tagset.

