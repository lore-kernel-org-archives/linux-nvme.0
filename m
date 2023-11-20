Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808C7C197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 19:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O1EyzZ49wfhmTUzceiPvYVQCZbMRczumPNy+GqusrMY=; b=y0G79qTfJXvoE/AQ9SbNP8S7y0
	Zl03FacOuvKkbNYUtiKoRc0YacNDtM+HgKfcJ6fhI3Os0bdU8c7oqpg25GicMqxIB/N5lyPhCgo54
	UdAfR6LTdS9C+nterAOII2quJ1V5unEUxm5Cixy7Fv75iTNL3QfwWmQefGIYvWHARKmJg4Xp0YEje
	a4yoQQ49kYJN6pxuerf9ncw3MhTWayTJBcHbHWjIlJFbArwPhQaV9Yt6YwdMU8MvaZPTFBGK3qw5Q
	3JvzsK0K9jTbap0gb5ZbXGxlrQ79CadcGndQj9RhED6xenWgRxWC2bgwcgvT+AqF1ut3UnP7/hiZ5
	6LLDKsKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r59aj-00EfJH-2i;
	Mon, 20 Nov 2023 19:05:53 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r59ag-00EfGG-23
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 19:05:52 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-332c087d302so166900f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 11:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700507146; x=1701111946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1EyzZ49wfhmTUzceiPvYVQCZbMRczumPNy+GqusrMY=;
        b=XNOdYtvqADpOzN/b18Mt709Gk3RMOYMnpEUTzx6YJ8vDLVCvLuYxvQfHMRvqffA7F/
         wVWsUv7rn1KxOXrtaW/p5z5CHk0FIcdHRDImDzxQyMejz+DAbRUWVIkONQW6Euf/LdsX
         +YrIpe6WE+gcQWgKnZQ3C69nIUHRhxTJm5s19QfOv/46ygHbh8IktdUhYgEUN0vv/MDd
         V6Z4M1RQcY+1UBSs9PSrwMM5RJOSHFwgyrmL26mRfyNgP742gWI2/oUxlVDkH7OGIFju
         WnSbcSSxxS3s7fkI1MblQyrvpVp98tadYccZhFh9ICCWzrq43dQCPfPk+mBm8cD32if9
         sWBw==
X-Gm-Message-State: AOJu0YyuPOhVWF/iSp1Se7H6isnyMp1Lu8Z5aqXQpYq2lOlfZP4qDPZr
	PoblDJVOTBuhyTC+L+r03d5+22BR+Vo=
X-Google-Smtp-Source: AGHT+IGtWIHTqYWxg4HEzsLtIxEBOC2hVlXhA8YByM5/l+VAZqUuxDXLsIR0PSzMX92Ba2sJ5YtJBw==
X-Received: by 2002:a5d:4f8f:0:b0:32f:7d22:6311 with SMTP id d15-20020a5d4f8f000000b0032f7d226311mr5739523wru.6.1700507146120;
        Mon, 20 Nov 2023 11:05:46 -0800 (PST)
Received: from [10.100.102.14] (46-117-95-192.bb.netvision.net.il. [46.117.95.192])
        by smtp.gmail.com with ESMTPSA id m17-20020adfe0d1000000b0033130644c87sm12027998wri.54.2023.11.20.11.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 11:05:45 -0800 (PST)
Message-ID: <7401e53a-59b8-41d5-8055-600725ecee06@grimberg.me>
Date: Mon, 20 Nov 2023 21:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: start keep-alive after admin queue setup
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20231024061337.35621-1-hare@suse.de>
 <20231024061337.35621-4-hare@suse.de>
 <a1ce2c2e-4f67-4271-ac67-5a1e8c5ebfb1@grimberg.me>
 <337014e5-f564-4f0e-8c3c-298156aa82f3@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <337014e5-f564-4f0e-8c3c-298156aa82f3@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_110550_753220_542AD803 
X-CRM114-Status: GOOD (  20.85  )
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



On 11/20/23 18:01, Hannes Reinecke wrote:
> On 11/20/23 14:39, Sagi Grimberg wrote:
>>
>>> Setting up I/O queues might take quite some time on larger and/or
>>> busy setups, so KATO might expire before all I/O queues could be
>>> set up.
>>> Fix this by start keep alive from the ->init_ctrl_finish() callback,
>>> and stopping it when calling nvme_cancel_admin_tagset().
>>
>> If this is a fix, the title should describe the issue it is fixing, and
>> the body should say how it is fixing it.
>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/host/core.c | 6 +++---
>>>   drivers/nvme/host/fc.c   | 6 ++++++
>>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 62612f87aafa..f48b4f735d2d 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -483,6 +483,7 @@ EXPORT_SYMBOL_GPL(nvme_cancel_tagset);
>>>   void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
>>>   {
>>> +    nvme_stop_keep_alive(ctrl);
>>>       if (ctrl->admin_tagset) {
>>>           blk_mq_tagset_busy_iter(ctrl->admin_tagset,
>>>                   nvme_cancel_request, ctrl);
>>
>> There is a cross dependency here, now nvme_cancel_admin_tagset needs to
>> have the keep-alive stopped first, which may be waiting on I/O, which
>> needs to be cancelled...
>>
>> Keep in mind that kato can be arbitrarily long, and now this function
>> may be blocked on this kato period.
>>
>> I also think that now the function is doing something that is more
>> than simply cancelling the inflight admin tagset, as it is named.
>>
> I am having a hard time following this reasoning.
> While I do accept that nvme_stop_keep_alive() might trigger I/O
> (ie if the work queue has just been started when calling 
> cancel_delayed_work), nvme_tcp_error_recovery_work() has this:
> 
>      nvme_stop_keep_alive(ctrl);
>      flush_work(&ctrl->async_event_work);
>      nvme_tcp_teardown_io_queues(ctrl, false);
>      /* unquiesce to fail fast pending requests */
>      nvme_unquiesce_io_queues(ctrl);
>      nvme_tcp_teardown_admin_queue(ctrl, false);
> 
> and nvme_tcp_teardown_admin_queue() calls nvme_cancel_admin_tagset().
> So by your above reasoning this code should be wrong, too.
> What am I missing?

Need to dig through the history, but it can most definitely move to
after the teardown. It could be from the earlier days where the
transport fencing was not as reliable particularly for admin requests.

