Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6E4FA3740
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 20:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=97GpEQ2+6Ykh6KgprSH5be6D6WMxByu7zMpaNrCZEeY=; b=3uoC9OdyPz30dU2sDCLMajXmEm
	HY95ueD/eKHA9eIHaKAPNZqrd76ImKo9/i7Zl7tL29ER2CVFQ9/JUzkCtLYCkcB/ASKBF1K4y7UBq
	Mb5ZaUrjCuKomnN4Fjkyc42xB3JOf4J3jnA5a6kifuTf9IA1iKfTZcVsYA+M/zEi0iP6eTkEUGj3n
	pQj66zxXobign8BIwRf9OqcuAunJChJiWFqytqRZQlOz/sS6ULLmQWnYQuc5GpE2tsUj6pHnx/eZr
	48dBZUdfZsG3fSuY2nm1PRGq2jzQdK4kPH6IzN5Bo85FuYQ70xPWM50HK+qhieqC/cBgRzrrxJqdY
	a5E3edLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onQMK-0074Bx-Lk; Tue, 25 Oct 2022 20:17:12 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onQMI-0074BU-2g
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 20:17:11 +0000
Received: by mail-wr1-f43.google.com with SMTP id l14so15768934wrw.2
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 13:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97GpEQ2+6Ykh6KgprSH5be6D6WMxByu7zMpaNrCZEeY=;
        b=vJY/EP7KOcgAal+jSz4j4fe+WaRyVFAaWnG5Igjb75cWjkvPh5rtb0O4bow4oVXwM2
         QbmwKaGTZjTg+M4VxqGazKXltP0aUb3570pS0f7Z2z0/nj6TUoym4aaypv3iuqlSj9M/
         3eQwPFz7E+U4lFgQje8Ik+w26SLveTklPNEEAPh5RPwov9MIZHBSuwDDBjIGceOPKm9/
         5+HqNQx3WcHrEPQY5P0TuMdwumVhhX9CueYSI3aUEhJ36vJpU1ZLR6WPK8vNRHcNgBR/
         UBb/mhqLGpJUROghxDn6DMqKb116U6ap+VZXIi1KjZnWw2WAME8OsnJkR6mz7VO9g7WY
         k0jA==
X-Gm-Message-State: ACrzQf0HqY0per/NXf8Z7ffSk/CRV4GwoPXE/jLYpT5Q7pqFpwIMeLGD
	eAKg3AR5IpPku8s4iR5tKCM=
X-Google-Smtp-Source: AMsMyM5a1FeYsBbMRzCZtprCw+A2mLQrmVG/96WZ5BZLQiiu3e1XHmmXMkoH0J4o6OVBti4WBHAG2Q==
X-Received: by 2002:a5d:51c2:0:b0:236:7000:8e82 with SMTP id n2-20020a5d51c2000000b0023670008e82mr8650982wrv.191.1666729027231;
        Tue, 25 Oct 2022 13:17:07 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003c6f27d275dsm12763840wmq.33.2022.10.25.13.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 13:17:06 -0700 (PDT)
Message-ID: <63c062dd-babb-e815-131a-bc0e513bb33e@grimberg.me>
Date: Tue, 25 Oct 2022 23:17:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 04/17] nvme: don't call nvme_kill_queues from
 nvme_remove_namespaces
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chao Leng <lengchao@huawei.com>,
 Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-5-hch@lst.de>
 <Y1ggN68V/mbAw1q2@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y1ggN68V/mbAw1q2@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_131710_151862_46828308 
X-CRM114-Status: GOOD (  21.81  )
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



On 10/25/22 20:43, Keith Busch wrote:
> On Tue, Oct 25, 2022 at 07:40:07AM -0700, Christoph Hellwig wrote:
>> @@ -4560,15 +4560,6 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>>   	/* prevent racing with ns scanning */
>>   	flush_work(&ctrl->scan_work);
>>   
>> -	/*
>> -	 * The dead states indicates the controller was not gracefully
>> -	 * disconnected. In that case, we won't be able to flush any data while
>> -	 * removing the namespaces' disks; fail all the queues now to avoid
>> -	 * potentially having to clean up the failed sync later.
>> -	 */
>> -	if (ctrl->state == NVME_CTRL_DEAD)
>> -		nvme_kill_queues(ctrl);
>> -
>>   	/* this is a no-op when called from the controller reset handler */
>>   	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
>>   
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index ec034d4dd9eff..f971e96ffd3f6 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -3249,6 +3249,16 @@ static void nvme_remove(struct pci_dev *pdev)
>>   
>>   	flush_work(&dev->ctrl.reset_work);
>>   	nvme_stop_ctrl(&dev->ctrl);
>> +
>> +	/*
>> +	 * The dead states indicates the controller was not gracefully
>> +	 * disconnected. In that case, we won't be able to flush any data while
>> +	 * removing the namespaces' disks; fail all the queues now to avoid
>> +	 * potentially having to clean up the failed sync later.
>> +	 */
>> +	if (dev->ctrl.state == NVME_CTRL_DEAD)
>> +		nvme_kill_queues(&dev->ctrl);
>> +
>>   	nvme_remove_namespaces(&dev->ctrl);
>>   	nvme_dev_disable(dev, true);
>>   	nvme_remove_attrs(dev);
>> -- 
>> 2.30.2
>>
> 
> We still need the flush_work(scan_work) prior to killing the queues. It
> looks like it could safely be moved to nvme_stop_ctrl(), which might
> make it easier on everyone if it were there.

If we do end up moving it to nvme_stop_ctrl, can we make a sub-version
of nvme_stop_ctrl that cannot block on I/O (i.e. without ana/scan/auth)?
for multipathing where we want to teardown the controller quickly so we
can failover I/O asap.

IIRC this is why scan_work is not in nvme_stop_ctrl to begin with, but
it is also possible that there was some other deadlock caused by that.

