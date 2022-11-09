Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF2AC43217
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 19:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MfF7QODFNkKjPhpM4hkjRLL0uKW/7KEu9TFlWTm6ybI=; b=NTdhEk/+kAs+OPQs5KrWQpzzoA
	LH1U8887TRPvHWRoSNepW89LrBk1bmItn1zfsM4sJte+PBahv+2CeRAYzZnsjpDsEnQbxLuBw0FVW
	ICrxvy+TwQtnaSDWmUnNUf8LIHoTSYsQwbk/mTqGe0UtuB63KuKRvusgSGUtscjXQ6iOHtFPyU2f7
	knNiYzTTmhtVjtdkYoiaOF4BDuJcFlKsVtkxKENvyZr7OokgfjknHQPkl3+vSRUflp2PPRKzI/T/i
	UEKEc3UmFRHknOr9Tqf0HE3MrGqllZg6xz2KfN2o9dtWpSOc773kWkMY0KCpJajFqFfwMb5OQqddo
	Zy6XV2Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osqP4-00GSGw-Ug; Wed, 09 Nov 2022 19:06:27 +0000
Received: from mail-qv1-f42.google.com ([209.85.219.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osqP2-00GSFg-AD
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 19:06:25 +0000
Received: by mail-qv1-f42.google.com with SMTP id i12so12955560qvs.2
        for <linux-nvme@lists.infradead.org>; Wed, 09 Nov 2022 11:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfF7QODFNkKjPhpM4hkjRLL0uKW/7KEu9TFlWTm6ybI=;
        b=2D13opGNo0Ou+dPQQ+oMZ625o4D9fU/0CUAf09TfX1/bDiLPVOBNEyxpprpr49kdhQ
         s1hwLD3/y/Tp6DEpk0Ag+/uTjW39OTnP1Wg8fkHSuW7RbC9HXmYy3IhI+mMQSleo1AfH
         9Y1gjE2s81Eb7UAktgnAdYy1WtSFOb9tkMaCkeT7w1gpezIcW3KhC2DGcV1+EwTWQlGC
         XqZPgqK0i5Xf59fO66HZXTbgwX4Ugj0Fr2Z+Nba0H+vfZdz4r9BZUVKKX6iQt82iriXw
         aGBJSbec8TrTXWt0eSCeo3CrvTeASgKHa2Mx5afZ6ykesDg0xC1bcz2oMC/Mvpu2HeOB
         S9Tw==
X-Gm-Message-State: ACrzQf3rDSRGpgidMnq26B8kDOb+lgKneaIdncWzIABDF+euEz8Aqt2R
	UhSHTetgrP5kXWgpHtMDPNg=
X-Google-Smtp-Source: AMsMyM6WqswE5lACLN6aHed/lP0otu3PxuqEE26MvlVrBn6dlXLNakrJhzflDmCJ+Y3sfnBJ3Pxl9Q==
X-Received: by 2002:a05:6214:5181:b0:473:1a26:99f6 with SMTP id kl1-20020a056214518100b004731a2699f6mr56109860qvb.47.1668020782789;
        Wed, 09 Nov 2022 11:06:22 -0800 (PST)
Received: from [192.168.82.40] ([108.95.161.27])
        by smtp.gmail.com with ESMTPSA id ga23-20020a05622a591700b00399ad646794sm10220627qtb.41.2022.11.09.11.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 11:06:22 -0800 (PST)
Message-ID: <d86b4e19-39dd-7c29-9d7e-345d331a2080@grimberg.me>
Date: Wed, 9 Nov 2022 21:06:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 12/16] nvme-auth: convert dhchap_auth_list to an array
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-13-sagi@grimberg.me> <20221109064855.GC10893@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221109064855.GC10893@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_110624_378232_42C126B1 
X-CRM114-Status: GOOD (  25.22  )
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


>> Make dhchap_auth_mutex protect only the ctrl host_key and ctrl_key
>> in a fine-graned lock such that there is no long lasting acuisition
>> of the lock.
> 
> Can you split that part into a separate patch?  Right now the patch
> is a bit confusing because it does multiple things.

I couldn't find a way to split it in a way that won't have holes in
it. I'll try to look into this again.

>> +#define nvme_auth_chap_from_qid(ctrl, qid) \
>> +	&((struct nvme_dhchap_queue_context*)(ctrl)->dhchap_ctxs)[qid]
> 
> Please properly type dhchap_ctxs instead of the ugly cast here.  That
> also removed the need for the macro.
> functions instead of macros.

If I type it, nvme_dhchap_queue_context definition needs to move to
nvme.h, is that fine with everyone?

>> +#define ctrl_max_dhchaps(ctrl) \
>> +	(ctrl)->opts->nr_io_queues + (ctrl)->opts->nr_write_queues + \
>> +			(ctrl)->opts->nr_poll_queues + 1
> 
> This overallocates in case the controller supports less queues than
> requested, but I guess that's not a big problem in practice.

It isn't, we do the same with queues.

> Also please make this an inline function to add type safety and to make
> it more readable.

OK.

> 
>> +#define nvme_foreach_dhchap(i, chap, ctrl) \
>> +	for (i = 0, chap = (ctrl)->dhchap_ctxs; \
>> +	     i < ctrl_max_dhchaps(ctrl) && chap != NULL; i++, chap++)
> 
> I find this macro a bit obsfucating.  There's only three callers anyway,
> and they only use chap 1, 2 or three times respectively.
> 
> So I'd just loop:
> 
> 	for (i = 0, i < ctrl_max_dhchaps(ctrl); i++)
> 
> and then do the dereference of >dhchap_ctxs in the loop.

I take it that you don't like the foreach iterator...

>>   			    void *data, size_t data_len, bool auth_send)
>> @@ -330,7 +338,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
>>   	struct nvmf_auth_dhchap_success1_data *data = chap->buf;
>>   	size_t size = sizeof(*data);
>>   
>> -	if (ctrl->ctrl_key)
>> +	if (chap->ctrl_key)
> 
> How is this related to the rest of the patch?

Here the code is dereferencing ctrl->ctrl_key which needs to synchronize
with sysfs driven modifications, but it has a queue chap context as 
well, which does not need a lock. Hence I changed the condition.

>> +		INIT_WORK(&chap->auth_work, __nvme_auth_work);
> 
> Btw, this really should lose the __ prefix in another prep patch.

Yes.

