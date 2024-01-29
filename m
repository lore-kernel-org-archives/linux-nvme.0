Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE54C47DA9
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 10:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8c/8JZbUlYrYQO1RYYJowlVvVvCqaaLt4OTpFzBzVo4=; b=WVFlBzzXr1aUwwZxXia54GU59P
	l1IUpv1WOVtrpK5df/ByiN+l5fNIBgzpPOat8So7Yoebfvqj3d7hyN4uEbBFINEf8wDjJLsE3ZhWx
	LXdZ6WiVq91nsfQO13QNqOJN6xyHc6D3hJOVZ7zNwoYyI4d9UNyKzipMarDz9pxlB5KpnDUXhgtVn
	CFsa5NWvvXtVP0jnWaxXOTWrGCOzKVQldXf1EWxWbCoQJXQs9kE4dYROjvt6Kqgeig9kIx9VeGpGO
	Ex0aqLoFXF1BpRlcrUmEq11kHD99Ow82a4qDPPw8RCLQFO9TGaCE3aGTTpxhp00pJJVWQIaEV5Q1q
	F6tZyQtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUOoe-0000000CCw0-0FyB;
	Mon, 29 Jan 2024 10:24:36 +0000
Received: from mail-lf1-f52.google.com ([209.85.167.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUOob-0000000CCuE-1fgn
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 10:24:34 +0000
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5110c2ac511so303740e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 02:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706523871; x=1707128671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8c/8JZbUlYrYQO1RYYJowlVvVvCqaaLt4OTpFzBzVo4=;
        b=KU60Zr3BiJvARTkr0oFkeLZS+auD2MgIXQiPxg3YaoghjTTRpAZn0VqmGQJtWgHtiq
         K42Z8LLido2EmiYS5wgCFLyn8TkRkUlNiWonxOURVNLZ0DANDAtJ2R15CE3EITnxJEu9
         PhvzJhUfSsosXKHH7VD/5cgThuyhkpCCwxf3MrbaK3ukCYRcsmg6VUFYXxBIAcR8kaAW
         T0q9OEnOHSdKadfA0kJ2lgGe3SCErJREj5+0cl9peugD8rgjGNQ4exHw42vUXTiKubBa
         UhjOnnkj/YybjRLFZVmLko7YznrmxpSAn4FoY3vuq5uH4Uxulh5O9eMjTo67/Nay3u4Q
         hsbQ==
X-Gm-Message-State: AOJu0YyIwOFfrp1sL4XWf236WbWNmE7eUQ1OSYWzcsd4VswoKeJ0gYH9
	4GDRt4UfcJ+Y691SpiPqsUDvQi4WIV77zV7Zk+0uEgMK09/glunpRQUs7XNx
X-Google-Smtp-Source: AGHT+IEY2nWU4jZC68fbXS2PfjqRvImov6xTgrqaPD7tFVEnd+GrtWUZmJo4/Bi0B7xgtDmt+qm/vg==
X-Received: by 2002:a19:4f57:0:b0:510:16ae:52e with SMTP id a23-20020a194f57000000b0051016ae052emr3806919lfk.2.1706523870766;
        Mon, 29 Jan 2024 02:24:30 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j34-20020a05600c1c2200b0040efa63b10dsm1241824wms.30.2024.01.29.02.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 02:24:30 -0800 (PST)
Message-ID: <e93a0663-a304-4ecd-85c7-d7e245d371ab@grimberg.me>
Date: Mon, 29 Jan 2024 12:24:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Content-Language: en-US
To: alan.adamson@oracle.com, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240111000855.1800481-1-alan.adamson@oracle.com>
 <20240111000855.1800481-2-alan.adamson@oracle.com>
 <20240111070441.GA7889@lst.de>
 <c44ad0e2-8f08-4b46-8be2-29b69a8d88b6@nvidia.com>
 <07b397bb-574e-4f7b-b754-085b348e1510@grimberg.me>
 <c377ad47-f908-44bf-999e-9a828a2891be@nvidia.com>
 <e79e6423-3fb0-4c81-b68e-7a5ea0807027@grimberg.me>
 <12d06642-562c-43d5-983f-b8ff164b8fd1@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <12d06642-562c-43d5-983f-b8ff164b8fd1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_022433_479277_5E01B017 
X-CRM114-Status: GOOD (  15.61  )
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


>>> sorry I didn't understand your question clearly ...
>>>
>>> In the original implementation we get two different struct device 
>>> objects
>>> for following commands in sysfs, that sets struct device:logging_enabled
>>> flag,
>>> which is also used to determine the logging in nvme_init_request() :-
>>>
>>> echo 1 > /sys/class/nvme/nvme0/passthru_err_log_enabled
>>> echo 1 > /sys/class/nvme/nvme0/nvme0n1/passthru_err_log_enabled
>>>
>>> nvme_init_ctrl() already sets dev_set_drvdata(ctrl->device, ctrl). In 
>>> this
>>> proposal above change in nvme_alloc_ns() sets the
>>> dev_set_drvdata(disk_to_dev(ns->disk), ns).
>>>
>>> This allows us to get the ctrl or ns object associated with the struct
>>> device
>>> we get in the sysfs, then based on the device class we update
>>> logging_enabled
>>> flags for either ctrl or ns respectively. In nvme_init_request() I use
>>> ctrl->logging_enabled and ns->logging_enabled based on admin or io cmd.
>>
>> I was asking why should we have a show/store that operate on both ns and
>> ctrl?
>>
>> Why not have a show/store in nvme_dev_attrs and a separate one in
>> nvme_ns_id_attrs ? Then you don't need the awkward is_nvme_class() ?
>> the ns attrs can access the ns in a normal way like the rest? Or am
>> I missing something?
> 
> If we create separate show/stores for the ctrl (nvme_dev_attrs) and ns 
> (nvme_ns_attrs), using the exiting macro: DEVICE_ATTR(), the attribute 
> name (passthru_err_log_enabled) can not be used for both nvme_dev_attrs 
> and nvme_ns_attrs.
> 
> /sys/class/nvme/nvme0/adm_passthru_err_log_enabled
> 
> /sys/class/nvme/nvme0/nvme0n1/io_passthru_err_log_enabled
> 
> 
> If I setup the attributes like:
> 
> static struct device_attribute dev_attr_adm_passthru_err_log_enabled = \
>          __ATTR(passthru_err_log_enabled, S_IRUGO | S_IWUSR, \
>          nvme_adm_passthru_err_log_enabled_show, 
> nvme_adm_passthru_err_log_enabled_store);
> 
> static struct device_attribute dev_attr_io_passthru_err_log_enabled = \
>          __ATTR(passthru_err_log_enabled, S_IRUGO | S_IWUSR, \
>          nvme_io_passthru_err_log_enabled_show, 
> nvme_io_passthru_err_log_enabled_store);
> 
> 
> Then both attributes can be the same.
> 
> /sys/class/nvme/nvme0/passthru_err_log_enabled
> 
> /sys/class/nvme/nvme0/nvme0n1/passthru_err_log_enabled
> 
> What do we prefer?

The second one looks fine to me.

