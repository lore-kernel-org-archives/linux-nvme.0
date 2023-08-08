Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA97DC001DB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 08:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fe3HYBBNrBsCfVwosrVYyR1qukOyzkNRsF+CRQzIjcE=; b=eg3F3g3A3pL5m2SAMX0aF7JNEH
	JJh04Lb0OKHnIJAhqH1exudAZmNiLihmQEuhItpq2GgIAyWfgHSOmFHPccNUQUD2D2k+bJZkB54By
	ZGpNwCNV9R+FWOaP+GrCvr3CiRpGcZvKd4wdvPkYEMTo8f4nH9ni7VRk4de7dAvZyPXrmpAT+s6K8
	juYKnPvdnYcUnWu14WUXlaCATGbCW4lCXoirhc4/ww8x+b9GPfkr7LC+ZzgVDBX+GL8bzKfuWNrBL
	UoTT6Wg3RvbhVc0RvZSrn1/twdb5kLPOartz/3VZcFbScOjNw7JQTJdBnSopfbpzv97UwtPMskgH1
	Oc/jNGLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIK3-0024Fh-1p;
	Tue, 08 Aug 2023 08:44:11 +0000
Received: from mail-lj1-f180.google.com ([209.85.208.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIK1-0024Ag-0Q
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 08:44:10 +0000
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b9b6c57c94so16875791fa.0
        for <linux-nvme@lists.infradead.org>; Tue, 08 Aug 2023 01:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691484245; x=1692089045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fe3HYBBNrBsCfVwosrVYyR1qukOyzkNRsF+CRQzIjcE=;
        b=XkJ47ynrtUkg2soLHyaAtaUarx+kRxoch17YZq/S1/QtBBXJwWko7q+sTBfO2WW0ok
         V72t3ohtW4iCnx7ctKcx4h6+jh0kbuNyIXZKHZl1sI+owCp5+pFdp56FdV5huE3pFStY
         /cixuaE8117tuETryAK0uNE84KKre2PR30X5kGQXn+YTnmCT6P0wbQhToPTuJOXNlwOn
         rtT5fe6nTxvghqCl74vpB3IHVoNolaanXXvCCIhoOr4zu66ig0ieobk8+xRmzbbqg6tN
         8L+XgE6WoXWrXwH/KWRfV6aBSZb1QlhBjGXyCKYg8QHVP3dXQ0a4IsS4p7M41awuNeLf
         viKA==
X-Gm-Message-State: ABy/qLYaJeRNhrTgfa2zerOfwv51bcfqSh3Doma+xDJiI/+4VRJGJ3KA
	maDo9lLHrpr9xXPQcWbW+Is=
X-Google-Smtp-Source: APBJJlFeIo6/DmDaaPWtj1G9VhTc/XSsPQkR28CBMPQaJZqxL5/q5y50mQEzMiOqaWRkjJ9PXse4mw==
X-Received: by 2002:a05:651c:2c6:b0:2b6:120a:af65 with SMTP id f6-20020a05651c02c600b002b6120aaf65mr14671242ljo.3.1691484245520;
        Tue, 08 Aug 2023 01:44:05 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bc8ca000000b003fe20533a1esm13004789wml.44.2023.08.08.01.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 01:44:04 -0700 (PDT)
Message-ID: <044969f1-f6dc-fa3d-f933-5e4c928eaab9@grimberg.me>
Date: Tue, 8 Aug 2023 11:44:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/14] nvmet-tcp: allocate socket file
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-13-hare@suse.de>
 <0ac55b10-6917-9247-59f3-5f3b8e121a9f@grimberg.me>
 <432fd12b-3da0-a3d0-73cc-863a272a0f85@suse.de>
 <8e0a1503-266f-0368-9eb2-ebeb256bd091@grimberg.me>
 <4e14f8b3-27ac-4afa-91e9-8ccb41a8b89b@suse.de>
 <3dca56b7-f981-73a7-386f-099c6f008064@grimberg.me>
 <1b3cc664-ad7d-493c-50a4-6fc473f06f5c@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1b3cc664-ad7d-493c-50a4-6fc473f06f5c@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_014409_174232_50596AD2 
X-CRM114-Status: GOOD (  12.54  )
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


>>>>>>> -static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>>>>>>> +static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>>>>>>>           struct socket *newsock)
>>>>>>
>>>>>> Why does the function change from retcode to void in this patch?
>>>>>
>>>>> Because the return code was never evaluated.
>>>>
>>>> ??
>>>>
>>>> I see it is evaluated.
>>>
>>> Yes, but this patch moved the 'sock_release()' call into 
>>> nvmet_tcp_alloc_queue(), making the return code obsolete.
>>>
>>> But I can make it a separate patch if required.
>>
>> But now who calls sock_release if you failed before allocating
>> the sockfile?
>>
> That is done in nvmet_tcp_remove_port(), and independent on
> queue release.

I'm referring to newsock, not the listener socket.

--
static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
                 struct socket *newsock)
{
         struct nvmet_tcp_queue *queue;
         int ret;

         queue = kzalloc(sizeof(*queue), GFP_KERNEL);
	//i.e. you fail here...
         if (!queue)
                 return;
--

