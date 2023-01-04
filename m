Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF5DC4708D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jan 2023 02:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G3yBJ8NNyzAL/9ZjVF6/P2d0vmUWd9EzTXF/i2cRGQg=; b=hvl2lYFhMzh3Q1ziIyZKo2vEnR
	99AOSibYxrvOhLmY+zWI7NDgiBxF57IYdCAkVHTcz/NwEApQSPo+xArNVKcKgPrwd9iKw/O7kspdj
	AEPKerNeeojMNTA3R9raFR3G/hx6MDMdrmvJbLHsrMJ2W7PLFLtkAxGY5iC7BZILx9HYQwMOxtgs+
	D1kTxsTeh2cEOkLVOr3wVCR9piOYMg1LbV8sKH032D2RmhdtfvSq3LorO0cqzaMxpEZXulik/Lx+D
	YwWDFZw5g0KhJcq9AIEcBhY6NQL7WoLZmvXwKQxm+RjVW6f7tz3UWuRjv/YXKH6ZxrFRzs1oVdZiJ
	ryGbQcRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCtk4-006QV4-7k; Wed, 04 Jan 2023 02:43:00 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCtjQ-006Q9g-S8
	for linux-nvme@lists.infradead.org; Wed, 04 Jan 2023 02:42:24 +0000
Received: by mail-pj1-x1034.google.com with SMTP id a11-20020a17090a740b00b00223f7eba2c4so5257350pjg.5
        for <linux-nvme@lists.infradead.org>; Tue, 03 Jan 2023 18:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3yBJ8NNyzAL/9ZjVF6/P2d0vmUWd9EzTXF/i2cRGQg=;
        b=LBh00D0BvN1KMeVWrbeyjlD4rIY54yovfBUC4cM+ixXiB2U4gnOivGn5JT8kAqnWrw
         Z5tsllJp32mBS6a1xjnk+1Fr6Yt+W9MMVZiSjigsiBy1mRzC9AFtJOOWI6ZnxYOvSdSL
         cmMGL3CAtmQSvyJ2y84qzG2RQ/0cSqWsUrSSZnTOzCI5vczLiYXHa/AHLV59YWo8kzvj
         M2+aSO6HAHqPFNdqq76zaEWG0kjzndLmjZ9zcdH/Mqr0uglSEUm0KtcCpXOgVD1fYyrE
         w/bt9XARcsdVaPEK6KcLNr3VcSeshdYrujJ+YIVo02bEEwbV2J+soRoki0Uqiib3j3XJ
         J1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3yBJ8NNyzAL/9ZjVF6/P2d0vmUWd9EzTXF/i2cRGQg=;
        b=Rf3RqhFEcasIWRBTL7UCiMbrETCEPDoX22t6ZekU1UG+INx85ljVwgdldMLATCUfRH
         1uA2KpWxy8Q3A7v1zJeIoMf5FW+s2h0skYfTV0DaQSHF+57jtGgYEAckLMIRV565AqPh
         jGmLQYX3OjGa5/mioG+U3OUN8ADzyRwVnnJZUWXytcfhau0+9+iS05O+bs9aoS3Iek0n
         pylKuR5PcYeLWSG/DCfZEfOlAEdF25fqVHjfpHIXy+IgRWkhNNYDG10ScJH3LRynhsxV
         vumqeva/6+5lRIdn3EwbX8WOazCsIdSYJzRtCLL0BtGCQ+BuJXx2Kb2P/ipfW2/ADXfO
         mKfw==
X-Gm-Message-State: AFqh2kpG5yZE/I72bcBgLX5iMTRusccch2bYYbFXOfYdPzHLZQIbvdy1
	NApbYKzVwP0ERO65OwTjt2I=
X-Google-Smtp-Source: AMrXdXsy+eGW29R8oUyDK/MrJcEfpD1sho/u7jrk+0wzShOP+n1VAqM10GcQksDWFjlL00MpYcbdcw==
X-Received: by 2002:a17:902:7fc7:b0:192:6503:1a9a with SMTP id t7-20020a1709027fc700b0019265031a9amr38114771plb.18.1672800138800;
        Tue, 03 Jan 2023 18:42:18 -0800 (PST)
Received: from [192.168.0.4] ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902c60a00b001811a197797sm23066643plr.194.2023.01.03.18.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 18:42:18 -0800 (PST)
Message-ID: <dfd110c6-dc89-3704-7e86-358358178623@gmail.com>
Date: Wed, 4 Jan 2023 11:42:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/4] nvme: fix delete uninitialized controller
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "larrystevenwise@gmail.com" <larrystevenwise@gmail.com>,
 "anthony.j.knapp@intel.com" <anthony.j.knapp@intel.com>,
 "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
 Sagi Grimberg <sagi@grimberg.me>, "axboe@fb.com" <axboe@fb.com>
References: <20230103100357.875854-1-ap420073@gmail.com>
 <20230103100357.875854-2-ap420073@gmail.com>
 <b6b16a5a-d592-eb12-ea30-1535b80d60dc@grimberg.me>
 <af53be64-4ed3-96ea-7700-ac8f0cc8de6b@nvidia.com>
Content-Language: en-US
From: Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <af53be64-4ed3-96ea-7700-ac8f0cc8de6b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_184222_041389_C99B5F2A 
X-CRM114-Status: GOOD (  21.07  )
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

Hi Sagi and Chaitanya.
Thank you so much for the reviews!

On 1/4/23 09:24, Chaitanya Kulkarni wrote:
 > On 1/3/23 02:30, Sagi Grimberg wrote:
 >>> nvme-fabric controllers can be deleted by
 >>> /sys/class/nvme/nvme<NS>/delete_controller
 >>> echo 1 > /sys/class/nvme/nvme<NS>/delete_controller
 >>> The above command will call nvme_delete_ctrl_sync().
 >>> This function internally tries to change ctrl->state to
 >>> NVME_CTRL_DELETING.
 >>> NVME_CTRL_LIVE, NVME_CTRL_RESETTING, and NVME_CTRL_CONNECTING 
states can
 >>> be changed to NVME_CTRL_DELETING.
 >>> If the state is successfully changed, nvme_do_delete_ctrl() is called,
 >>> which is the actual delete logic of controller.
 >>>
 >>> controller initialization logic changes ctrl->state.
 >>> NEW -> CONNECTING -> LIVE.
 >>> NVME_CTRL_CONNECTING state doesn't ensure that initialization is done.
 >>>
 >>> So, delete logic can be called before the finish of controller
 >>> initialization.
 >>> So kernel panic would occur because nvme_do_delete_ctrl() dereferences
 >>> uninitialized values.
 >
 > thanks for discovering this, do you perhaps have sequence of commands to
 > reproduce this ?
 >

Yes, the below reproducer would be helpful.

#TARGET
sudo modprobe nvme_tcp
sudo modprobe nvmet
sudo modprobe nvmet-tcp
sudo mkdir /sys/kernel/config/nvmet/subsystems/nvmet-test-2
cd /sys/kernel/config/nvmet/subsystems/nvmet-test-2
echo 1 |sudo tee -a attr_allow_any_host > /dev/null
sudo mkdir namespaces/2
cd namespaces/2/
echo -n /dev/<NVME DEVICE> device_path
echo 1 > enable
sudo mkdir /sys/kernel/config/nvmet/ports/2
cd /sys/kernel/config/nvmet/ports/2
echo <TARGET IP> |sudo tee -a addr_traddr > /dev/null
echo tcp|sudo tee -a addr_trtype > /dev/null
echo 4002 |sudo tee -a addr_trsvcid > /dev/null
echo ipv4|sudo tee -a addr_adrfam > /dev/null
sudo ln -s /sys/kernel/config/nvmet/subsystems/nvmet-test-2/ 
/sys/kernel/config/nvmet/ports/2/subsystems/nvmet-t

#HOST SHELL1
while :
do
    nvme discover -t tcp -a <TARGET ADDRESS> -s 4002
    nvme connect -t tcp -n nvmet-test-2 -a <TARGET ADDRESS> -s 4002
done

#HOST SHELL2
while :
do
    echo 1 > /sys/class/nvme/nvme0/delete_controller
done

#HOST SHELL3
#This additional test script is to reproduce the second patch issue.
while :
do
    echo 1 > /sys/class/nvme/nvme0/reset_controller
done

 > [...]
 >
 >>> +++ b/drivers/nvme/host/core.c
 >>> @@ -243,7 +243,8 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl
 >>> *ctrl)
 >>>         * since ->delete_ctrl can free the controller.
 >>>         */
 >>>        nvme_get_ctrl(ctrl);
 >>> -    if (nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
 >>> +    if (test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
 >>> +        nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
 >>>            nvme_do_delete_ctrl(ctrl);
 >>
 >> So what is the outcome now? if the controller kept on dangling? what
 >> triggers the controller deletion?
 >>
 >>>        nvme_put_ctrl(ctrl);
 >>>    }
 >>
 >> I don't think this is the correct approach.
 >> the delete should fully fence the initialization and then delete
 >> the controller.
 >>
 >> In this case, the transport driver should not quiesce a non-existent
 >> queue.
 >>
 >> If further synchronization is needed, then it should be added so that
 >> delete will fully fence the initialization.
 >
 > as stated here I'd add complete fencing for the initialization and
 > delete transition ..

I thought that delete/reset logic should not be allowed before the 
finish of initialization and I didn't consider that delete/reset logic 
fence initialization logic.
That was my approach, but after review, I think this approach is not fit 
for the nvme subsystem.
I think this case will be fixed by Chaitanya correctly.
I hope the above reproducer is helpful.

So, I will drop 1, and 2 patches in the v2 patchset.

 >
 > -ck
 >

Thanks a lot!
Taehee Yoo

