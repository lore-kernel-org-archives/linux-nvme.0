Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FED4C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 06:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fzazz2LGm2icEmkVZBKyvXHDcPEponMOSCNSkIH0wgI=; b=qXHtOrgUnHjTQYrpuwdqAM4Qvb
	9x6K9i/IZ5eCEjE7hOsDvJcnTn6kP5Hzjjaco/8jnHiP2KE/+l2Aj5V4wyOjmx8FghkG8TPFJ69xr
	unczzvoqfmPYDO4ppQKvM41ADMa1V+w8MdXAzTwPvk50rS0kCAT1eNWpJ0RVYRDpevDyOVM1vDp2J
	vEqi0ej4XWyjjNogwrf+hgNnBtVHuiJ2lSu7kkY6YWFkq2eFbTPNHA6l0Uy8zVmkrZRFXIZKlO2gQ
	EU+dTW8pkNGhro5VqapScywncJKNi/RWncqaPRDNU8xinJIzSHdbjMHyEWzEXnaNzJhD6jtPy8aRr
	zk9ooAZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiVND-0072jz-U2; Wed, 12 Oct 2022 06:37:47 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiVNB-0072jR-FX
	for linux-nvme@lists.infradead.org; Wed, 12 Oct 2022 06:37:46 +0000
Received: by mail-wm1-f44.google.com with SMTP id fn10-20020a05600c688a00b003c6c44a1c8eso1710694wmb.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Oct 2022 23:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fzazz2LGm2icEmkVZBKyvXHDcPEponMOSCNSkIH0wgI=;
        b=3q6oPgBgV+eIhor6Sno75rHUY79QUSjNRAbsSuWiy6EFn4lT2eRsHE3noBx+UDAvhK
         yk0hg58A4Opht3V5eNqnvHjkzp18LM3IeEbKWU2xglQNHerfM50vobriWhyfzO/GQjHK
         znijemIeRu37yud/sGkQEPqdvUL6CM5bKd1W47/vWCsx2fdKA7QnO61G/UAEJIAZWt+X
         crjP3dVlrLWNFZFPr7f4rLVXnMcreOAu2T3eByjuySnPvtWTp44NrYk46zJ4a0xr+kf8
         0Dk6RjrItH88stWEV78kIuwUQPMGMzMnfD81L/3HvT0OvJcNFbtA1PanOSDh3/VxprPm
         Wz6w==
X-Gm-Message-State: ACrzQf02LEHSGM45EF6WfxvUyZbrQZxohVikQxhpjZszONNbXqT6b5Kp
	E0w5nH7a8XKxlNnW25hqWVs=
X-Google-Smtp-Source: AMsMyM4JijtLxbt2ktWylR00buTODn27IC2f7iR7kF5eewPHXO7bGTRr/sy3mSvEUvQ7Yvyf66bGTQ==
X-Received: by 2002:a1c:7407:0:b0:3c6:cc25:c02f with SMTP id p7-20020a1c7407000000b003c6cc25c02fmr1603832wmc.124.1665556662410;
        Tue, 11 Oct 2022 23:37:42 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6809000000b0022aeba020casm12952192wru.83.2022.10.11.23.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 23:37:41 -0700 (PDT)
Message-ID: <5fc61f6c-3d3e-ce0e-a090-aa5bcdb7721c@grimberg.me>
Date: Wed, 12 Oct 2022 09:37:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk
References: <20220729073948.32696-1-lengchao@huawei.com>
 <20220729142605.GA395@lst.de>
 <1b3d753a-6ff5-bdf1-8c91-4b4760ea1736@huawei.com>
 <fc7a303f-0921-f784-a559-f03511f2e4be@grimberg.me>
 <20220802133815.GA380@lst.de>
 <537c24ba-e984-811e-9e51-ecbc2af9895d@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <537c24ba-e984-811e-9e51-ecbc2af9895d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_233745_541536_8650F181 
X-CRM114-Status: GOOD (  17.96  )
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


>> On Sun, Jul 31, 2022 at 01:23:36PM +0300, Sagi Grimberg wrote:
>>> But maybe we can avoid that, and because we allocate
>>> the connect_q ourselves, and fully know that it should
>>> not be apart of the tagset quiesce, perhaps we can introduce
>>> a new interface like:
>>> -- 
>>> static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
>>> {
>>>     ctrl->connect_q = blk_mq_init_queue_self_quiesce(ctrl->tagset);
>>>     if (IS_ERR(ctrl->connect_q))
>>>         return PTR_ERR(ctrl->connect_q);
>>>     return 0;
>>> }
>>> -- 
>>>
>>> And then blk_mq_quiesce_tagset can simply look into a per request-queue
>>> self_quiesce flag and skip as needed.
>>
>> I'd just make that a queue flag set after allocation to keep the
>> interface simple, but otherwise this seems like the right thing
>> to do.
> Now the code used NVME_NS_STOPPED to avoid unpaired stop/start.
> If we use blk_mq_quiesce_tagset, It will cause the above mechanism to fail.
> I review the code, only pci can not ensure secure stop/start pairing.
> So there is a choice, We only use blk_mq_quiesce_tagset on fabrics, not 
> PCI.
> Do you think that's acceptable?
> If that's acceptable, I will try to send a patch set.

I don't think that this is acceptable. But I don't understand how
NVME_NS_STOPPED would change anything in the behavior of tagset-wide
quiesce?

