Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3448CC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 10:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q/MkkdjXJWSKC5Rmk0bMMUh8KfXqf5PAK+ZeE9+76LA=; b=sOlI89CvZRyqYAm2hEtAvYz0+C
	DRWq1OegaZWjEyjorT/i9p6x0DauVVO/dj57rUiu7DkANIp+nyJKB2942fORZ7oX2gebYkBhkOpVS
	qAYRZbfrCfdkcLXuBgyzfa2FrihK0G97vAXXlmYIl+PZwEK9L77WSws3vifTUPklaCguk9fdyvKaK
	0R3cTPbIBXbbxsH4m0CkpVJGQZ8WSjxD7AC0YO++VOMEGOU/Jc+pfn3lRvzyAT69hAN/HvCpCPUME
	izhhBGvQDWsMXS4DwnlOK/hf4NfbsMAno2sUsBSdCoXgp/iXKFjvlubKxD0jozXIXh2gOqpmPApIs
	+cGuTyMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nURKv-00CXp6-LX; Wed, 16 Mar 2022 10:57:01 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nURKr-00CXnM-W2
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 10:56:59 +0000
Received: by mail-wr1-f46.google.com with SMTP id h23so1774613wrb.8
 for <linux-nvme@lists.infradead.org>; Wed, 16 Mar 2022 03:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Q/MkkdjXJWSKC5Rmk0bMMUh8KfXqf5PAK+ZeE9+76LA=;
 b=wzV3+8PtgER5TnAD4UOXmHdbphwhQxZjhfy5HlU8RKeJiSbXq3VSBylS4zcQ6Ttx9w
 Cx5xE9pCJxFNGa4XtidN4N7H1FaMj302DZPagDhsZazSzMNSrFD8caDBbP8RvAMEdp0z
 5bBcTEuhA8UKpjluf1uQ0FaLtDmCz98MdZ1gM7IgOu4Og10V0vOnlVNskhg3H/9riV1e
 Z3uGLGsEMC6JA7DrzOUlg4rdB6z+ryb3IiTsDnDiiaw/MDzvZ1DxsMkP+XayMvgCRzRy
 ghtEMgN8npVd11ClPHa2aoQS/aXLLqUb/d3m7jxI/PBAypRD68HF1eX4/cjriqT1xvVa
 As1w==
X-Gm-Message-State: AOAM533YWWUj/mhwSAxFR82aGi9BXbOpXLlYV41DKwE/Uk7cYUd9sEnt
 5RKi2WTMx3uYf4MZss9tjSU=
X-Google-Smtp-Source: ABdhPJz5JhnwaM3HpruKQYMhDVu991m3UztXZds21mGMAceECiK5QO/Y790DF91u+W0Ge9xBchwZmw==
X-Received: by 2002:a05:6000:154b:b0:203:7564:930 with SMTP id
 11-20020a056000154b00b0020375640930mr23897520wry.349.1647428215985; 
 Wed, 16 Mar 2022 03:56:55 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 n2-20020a056000170200b001f1e16f3c53sm1364822wrc.51.2022.03.16.03.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Mar 2022 03:56:55 -0700 (PDT)
Message-ID: <11f9e933-cfc8-2e3b-c815-c49a4b7db4ec@grimberg.me>
Date: Wed, 16 Mar 2022 12:56:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Kanchan Joshi <joshiiitr@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav
 <pankydev8@gmail.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@javigon.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com>
 <7a123895-1102-4b36-2d6e-1e00e978d03d@grimberg.me>
 <CA+1E3rK8wnABptQLQrEo8XRdsbua9t_88e3ZP-Ass3CnxHv+oA@mail.gmail.com>
 <8f45a761-5ecb-5911-1064-9625a285c93d@grimberg.me>
 <20220316092153.GA4885@test-zns>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220316092153.GA4885@test-zns>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_035658_055345_E907E2B2 
X-CRM114-Status: GOOD (  20.39  )
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



On 3/16/22 11:21, Kanchan Joshi wrote:
> On Tue, Mar 15, 2022 at 11:02:30AM +0200, Sagi Grimberg wrote:
>>
>>>>> +int nvme_ns_head_chr_async_cmd(struct io_uring_cmd *ioucmd)
>>>>> +{
>>>>> +     struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
>>>>> +     struct nvme_ns_head *head = container_of(cdev, struct 
>>>>> nvme_ns_head, cdev);
>>>>> +     int srcu_idx = srcu_read_lock(&head->srcu);
>>>>> +     struct nvme_ns *ns = nvme_find_path(head);
>>>>> +     int ret = -EWOULDBLOCK;
>>>>> +
>>>>> +     if (ns)
>>>>> +             ret = nvme_ns_async_ioctl(ns, ioucmd);
>>>>> +     srcu_read_unlock(&head->srcu, srcu_idx);
>>>>> +     return ret;
>>>>> +}
>>>>
>>>> No one cares that this has no multipathing capabilities what-so-ever?
>>>> despite being issued on the mpath device node?
>>>>
>>>> I know we are not doing multipathing for userspace today, but this
>>>> feels like an alternative I/O interface for nvme, seems a bit cripled
>>>> with zero multipathing capabilities...
>>>
>>> Multipathing is on the radar. Either in the first cut or in
>>> subsequent. Thanks for bringing this up.
>>
>> Good to know...
>>
>>> So the char-node (/dev/ngX) will be exposed to the host if we enable
>>> controller passthru on the target side. And then the host can send
>>> commands using uring-passthru in the same way.
>>
>> Not sure I follow...
> 
> Doing this on target side:
> echo -n /dev/nvme0 > 
> /sys/kernel/config/nvmet/subsystems/testnqn/passthru/device_path
> echo 1 > /sys/kernel/config/nvmet/subsystems/testnqn/passthru/enable

Cool, what does that have to do with what I asked?

>>> May I know what are the other requirements here.
>>
>> Again, not sure I follow... The fundamental capability is to
>> requeue/failover I/O if there is no I/O capable path available...
> 
> That is covered I think, with nvme_find_path() at places including the
> one you highlighted above.

No it isn't. nvme_find_path is a simple function that retrieves an I/O
capable path which is not guaranteed to exist, it has nothing to do with
I/O requeue/failover.

Please see nvme_ns_head_submit_bio, nvme_failover_req,
nvme_requeue_work.

