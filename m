Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3892C47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 11:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gBe73lYC1ZmyJmWwjlkdl75ubt3hSy2Md4nDVWdnJzc=; b=2/F9wzgqVpaslOPcV5E+6IeTp1
	f2Um4q1q/m97lF8yMoHEZwrrrL39cLgI3NYRpcmG3oqVXwaQo+e/iK1dKMIP+ulpKWqds3KJ4kWfE
	rHuj9/fXtX93DvViceutYv6jkdw8TT3Awwn/GHYY+qPEFTx/1rJXmmXfe9R26kTPHtf0YVBuhj4BY
	7mBF9L/f4ziQQnYZFLd1s1uit0uOWHon+BralhCHL35XYTzJi7fUY1YmcJ1Ckk4Z9uYiwn8M1EOmd
	ujIdJhRrK8RQtd+jjxszUc9BqlvWL57D9DsypipuxIvDGAlRmNEvlneRgujbaItGKGbvk7TKveY5a
	dDzzvYiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSF2S-00GD8S-2k;
	Tue, 23 Jan 2024 11:33:56 +0000
Received: from mail-ej1-f52.google.com ([209.85.218.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSF2N-00GCzh-1P
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 11:33:54 +0000
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3081516dd7so45387766b.1
        for <linux-nvme@lists.infradead.org>; Tue, 23 Jan 2024 03:33:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706009628; x=1706614428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBe73lYC1ZmyJmWwjlkdl75ubt3hSy2Md4nDVWdnJzc=;
        b=MR0tKQyq9iBjwOSwD4brCqYrZj+xU0QR3emIkFJQNJ5IN3k25b7a6cWxBMCXQd7RxT
         EPkY/xISJ5wr+Nv5WFab1nZE1xun60sh4gEec6o+E8trHRkWxG/VkCqioVPxI8SP1jfu
         V2DU5tI66ejeB24TuydJlg8JxZOMb0ad6z038b4f20gJIPd9WOTMgcpPT/4843Mjr1q0
         R8+djehun3vsAllb0R+ujHieE3TtwBJloFnbC+14oA1IAR2cG+ySWhwzJv2TiH5Scp49
         TUHmHqP3qVI1bXGByTk1ZsOWHp6KpMe1HMr1BlhkWHqe21PyYy8hLsSBesliGBER3BE5
         Fs1A==
X-Gm-Message-State: AOJu0YwHBTS9MVK1mlTYtC7473rttme95ev8Dmmvv7UGSQtYBceQwOB1
	Ivmrr1ckg5k/cLMm/LwEfmZcA1mommaHG7zO2PfJkxvWmqETpEEZvlpA4nPT
X-Google-Smtp-Source: AGHT+IGjix+K50Dw+tvcHJPfG6tVfULEUQH9cJcfrZqd9vqqB7Kls4TyHL0yWpTCxooSosCCYgx3QQ==
X-Received: by 2002:a17:906:abcd:b0:a30:d454:58a0 with SMTP id kq13-20020a170906abcd00b00a30d45458a0mr722816ejb.5.1706009627601;
        Tue, 23 Jan 2024 03:33:47 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x25-20020a1709064bd900b00a28f54aacf1sm14370232ejv.185.2024.01.23.03.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 03:33:47 -0800 (PST)
Message-ID: <e79e6423-3fb0-4c81-b68e-7a5ea0807027@grimberg.me>
Date: Tue, 23 Jan 2024 13:33:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>
References: <20240111000855.1800481-1-alan.adamson@oracle.com>
 <20240111000855.1800481-2-alan.adamson@oracle.com>
 <20240111070441.GA7889@lst.de>
 <c44ad0e2-8f08-4b46-8be2-29b69a8d88b6@nvidia.com>
 <07b397bb-574e-4f7b-b754-085b348e1510@grimberg.me>
 <c377ad47-f908-44bf-999e-9a828a2891be@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c377ad47-f908-44bf-999e-9a828a2891be@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_033351_486825_90881A49 
X-CRM114-Status: GOOD (  18.07  )
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



On 1/18/24 05:31, Chaitanya Kulkarni wrote:
> Sagi,
> 
>>> nvme_mpath_add_disk(ns, info->anagrpid);
>>>            nvme_fault_inject_init(&ns->fault_inject,
>>> ns->disk->disk_name);
>>> +
>>> +       /*
>>> +        * Set ns->disk->device->driver_data to ns so we can access
>>> +        * ns->logging_enabled in
>>> nvme_passthru_err_log_enabled_store() and
>>> +        * nvme_passthru_err_log_enabled_show().
>>> +        */
>>> +       dev_set_drvdata(disk_to_dev(ns->disk), ns);
>>
>> Is this needed?
> 
> Yes see explanation below ..
> 
> [...]
> 
>>
>>>
>>>     static ssize_t nvme_passthru_err_log_enabled_store(struct device
>>> *dev,
>>>                    struct device_attribute *attr, const char *buf, size_t
>>> count)
>>>     {
>>> -       int err;
>>>            bool passthru_err_log_enabled;
>>> +       int err;
>>>
>>>            err = kstrtobool(buf, &passthru_err_log_enabled);
>>>            if (err)
>>>                    return -EINVAL;
>>>
>>> -       dev->logging_enabled = passthru_err_log_enabled;
>>> +       if (is_nvme_class(dev->class)) {
>>> +               struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>> +
>>> +               ctrl->logging_enabled = passthru_err_log_enabled;
>>> +       } else {
>>> +               struct nvme_ns *ns = dev_get_drvdata(dev);
>>> +
>>> +               ns->logging_enabled = passthru_err_log_enabled;
>>> +       }
>>
>> Why mix ctrl with ns sysfs handlers?
> 
> sorry I didn't understand your question clearly ...
> 
> In the original implementation we get two different struct device objects
> for following commands in sysfs, that sets struct device:logging_enabled
> flag,
> which is also used to determine the logging in nvme_init_request() :-
> 
> echo 1 > /sys/class/nvme/nvme0/passthru_err_log_enabled
> echo 1 > /sys/class/nvme/nvme0/nvme0n1/passthru_err_log_enabled
> 
> nvme_init_ctrl() already sets dev_set_drvdata(ctrl->device, ctrl). In this
> proposal above change in nvme_alloc_ns() sets the
> dev_set_drvdata(disk_to_dev(ns->disk), ns).
> 
> This allows us to get the ctrl or ns object associated with the struct
> device
> we get in the sysfs, then based on the device class we update
> logging_enabled
> flags for either ctrl or ns respectively. In nvme_init_request() I use
> ctrl->logging_enabled and ns->logging_enabled based on admin or io cmd.

I was asking why should we have a show/store that operate on both ns and
ctrl?

Why not have a show/store in nvme_dev_attrs and a separate one in
nvme_ns_id_attrs ? Then you don't need the awkward is_nvme_class() ?
the ns attrs can access the ns in a normal way like the rest? Or am
I missing something?

