Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E783DECAAD2
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 18:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nIumPYK2nOGMmht+wQBlkDNALaAWR1N0uaeEe8VebeE=; b=muSQ4VWgeBA07x+krZsJjvN8Lr
	yxdrL+xNdxoBKlAfDuogRz1lq34vWfhhM93R7RQm01SO2zI3yYgWGzPB/bApt+39/mcba9MTMNJrS
	/gtbZGqRyN1Wwu/0DMo//A/S0MAhr1GDNcbDkkAJp0MxKKyv2W0VDRcUi2/F+fZm7ljWMHomMU2YJ
	++Lx75lN/rk45bXVQPRdiZDR5oO2CmrD/7nzwXXcutrUiiao0lji8Rpun3BO5yzhgW+DstPiE2Q4r
	ysa4epAyQvFoIZoT3S3pnkB6WPeGOgoPu7mou7tkkoZ785XMHXbFYZfbP11zjZoMGMe60mybVAfFp
	ndxpLaCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSjwb-00CNSR-QE; Mon, 29 Aug 2022 18:57:09 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSjwZ-00CNPt-ND
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 18:57:08 +0000
Received: by mail-qk1-x730.google.com with SMTP id g16so6757009qkl.11
        for <linux-nvme@lists.infradead.org>; Mon, 29 Aug 2022 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nIumPYK2nOGMmht+wQBlkDNALaAWR1N0uaeEe8VebeE=;
        b=LvT23czEhunfBHcTR63+IzeSvTgCm+YefUst7ghuUNik7We2vZf1RlBeyWvk23KrRW
         jKhJ5F6fCr4hZKMkuE6zttZyKhcJ588DOyPYjiacETRTMdzTvlmOImTnkDUtF4XMFzqX
         i5jlXEyZ8UG6D3Hx7PNWY8+8r57UjuHHfyYYvpwWKVFW+RDtQmySJztg8QS5Ef7tD7hZ
         WvlLCwq7QNYa+s2vj4d7csehIGE5/BGUOvJntaYY+NGjfS/g5fKh6ZB4g9R433/wttms
         8dC9tCYeT8Ft7NJVLtpeMYiRJ987D4LUF2pr4M9F6VIQbnjXediOlFHKmJHLVrQPuxYN
         zMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nIumPYK2nOGMmht+wQBlkDNALaAWR1N0uaeEe8VebeE=;
        b=mrbZ46xlwyz8ehtasBMWv+LBBOX/PkM5zg2gmEVFWroj48i6RkW8jTkjGEMEGjOSIb
         L54UX4og1Je1OjpdeTtdXGT2TndTJr8+a9KxqXAnwr3IvRxxqjih9kSjAEtDsv42MCZX
         d1mm8KVOXGIaMCsylsG4xM4T8VkY9aCFKA4BDnp2vGT7s8fILI5oB8vtNoLep653gS6I
         VkCLgA4yfynYPBHvH6ZeTxuqXH8Rx0O+M68IB9QczCuGgG7Bg2a23sgkPFN2nd6Kh2t5
         ZxOugjXXeCtfXikSux65+dxUVL+6icSIiiiQNKN3+aSULxGz/nXaX8HMx4RrrLbkcBq7
         oT5w==
X-Gm-Message-State: ACgBeo3UJbT/+QVsa2zctmyzhr0UGxGoMXzzPQ98obNGcpr3EzAh1aJI
	/YlG45wpTp8yK7sTgeGwfwo=
X-Google-Smtp-Source: AA6agR7nDX0pDSf4ACuCz8qY0LOZ5WBoPIsRC7+Mwm+LFlF13czK4o9QoPqIryV61faA/2hstXPcIA==
X-Received: by 2002:a05:620a:3704:b0:6b8:f15d:f119 with SMTP id de4-20020a05620a370400b006b8f15df119mr9179157qkb.138.1661799418056;
        Mon, 29 Aug 2022 11:56:58 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id y6-20020ae9f406000000b006baef6daa45sm6370128qkl.119.2022.08.29.11.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 11:56:57 -0700 (PDT)
Message-ID: <c5af9904-48f2-93b8-404a-4dc23c63b7c7@gmail.com>
Date: Mon, 29 Aug 2022 11:56:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 0/3] Handle number of queue changes
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>
References: <20220829083856.1850-1-dwagner@suse.de>
 <f8ee0fd3-45c2-7848-aa5a-6627c7672349@suse.de>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <f8ee0fd3-45c2-7848-aa5a-6627c7672349@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_115707_809522_6CEEEDD7 
X-CRM114-Status: GOOD (  12.32  )
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

On 8/29/2022 2:07 AM, Hannes Reinecke wrote:
> On 8/29/22 10:38, Daniel Wagner wrote:
>> Updated this series to a proper patch series with Hannes and Sagi's
>> feedback addressed.
>>
>> I tested this with nvme-tcp but due to lack of hardware the nvme-rdma
>> is only compile tested.
>>
> 
> One does wonder: what about FC?
> Does it suffer from the same problems?
> 
> Cheers,
> 
> Hannes


Yep, wondering too. I don't think so... FC does do this differently.

We don't realloc io queues nor tag_sets.  We reuse the allocations and 
tag_set originally created in the 1st successful association for the 
controller.

On reconnect, we set the queue count, then call 
blk_mq_update_nr_hw_queues() if it changed before we get into the loops 
to change queue states.

So FC's call to update nr_hw_queues() is much earlier than rdma/tcp today.

-- james


