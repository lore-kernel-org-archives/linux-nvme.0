Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A11C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 19:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gHHHuPOnEHnkBHxJZ2Fftm4tk4/KKsCA2DyVLNo4Xnc=; b=ys35o3jCUjdPTAcqovhQZ0mQ9z
	aShbx+Czg9giBYAHKxCJryelH7HDhFeccBK57rHSal5fqNTq9KhoWYKOeUlY5fcJR0pDg3w+Hn/1I
	tCktkor6XMzOC6I6rmXzVoEkliP/Aes0XXFv25Nc/8XfTz0IkHo9PNT2jRCwGvc6mjd3h0Afh35MB
	A+SJlDJOjLlxJkJDVsZrCc4TXUdT2j8MVwsC0jWGqmcpKoS+AMZTfE/ayQz3eZ9bei6GyJQBGU4rm
	AMt+Grf2eMP1rCSNk3uNpjBYZDVnGT23vbIMd2IHfjo5ymWwzREuVUFYHWvV3Wwrd6P+6qC0BswDN
	ZYDkYmxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rG2EV-000lEy-0V;
	Wed, 20 Dec 2023 19:27:55 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rG2ES-000lEI-2i
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 19:27:54 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33677e66243so233934f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 20 Dec 2023 11:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703100470; x=1703705270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHHHuPOnEHnkBHxJZ2Fftm4tk4/KKsCA2DyVLNo4Xnc=;
        b=weH1vZU5/Rr7K36HYlPCphnX8mDUNBlIkQEvms7VVJT4s7QXBSG004i9xBBHumKTD0
         fyWZRbaJnl7vQ4bYLl+EIDS5Lt6FZUg86V+GZj+K+NSuF2LDlrW1p3A5NrlueSzaTPnb
         PqbPI3cwSs/fwleEj8+Svj4l7kxpxdE4T9qay5b8reEIsA7SyPS2y3iK5LfrlNO8zGJ5
         7+5BYakUrYymbDvObUceYvVctcyCStIwt3L7OBmhIkk63AglOwonOIaax7//ztEbMXRj
         hTgjGSk8UA4GlQXG5Bgil69aFOVFm/DArqOuTjwVeI5cLoAnbps1pSAFUzTFB/HcFwag
         LX7g==
X-Gm-Message-State: AOJu0YzCTvnFhB5So1ga5QUgYo4An7ab34MsaqWS7Z+JI1VBezzMdxUO
	HoW89CQr/FgA6aPqfIL8M94=
X-Google-Smtp-Source: AGHT+IHNmxCXsAwKWQzmhBaFDPqQQEummCzpGMWE3J43RS3bfmP53oPKLrB9OorwAhLFcxsYmpnaBg==
X-Received: by 2002:adf:cd90:0:b0:336:8094:3718 with SMTP id q16-20020adfcd90000000b0033680943718mr843047wrj.5.1703100470387;
        Wed, 20 Dec 2023 11:27:50 -0800 (PST)
Received: from [10.100.102.14] (46-117-87-214.bb.netvision.net.il. [46.117.87.214])
        by smtp.gmail.com with ESMTPSA id fj8-20020a05600c0c8800b004094e565e71sm590550wmb.23.2023.12.20.11.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 11:27:49 -0800 (PST)
Message-ID: <77df6829-3a14-49a1-82e5-f3389ba47d86@grimberg.me>
Date: Wed, 20 Dec 2023 21:27:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 2/2] nvme: rdma: use ib_device's max_qp_wr to limit
 sqsize
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Guixin Liu
 <kanie@linux.alibaba.com>, hch@lst.de, kbusch@kernel.org, kch@nvidia.com,
 axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
References: <1702971145-111009-1-git-send-email-kanie@linux.alibaba.com>
 <1702971145-111009-3-git-send-email-kanie@linux.alibaba.com>
 <82d16c8c-efef-41d2-b2ff-8ce8f5ac9b28@grimberg.me>
 <92b53d3b-8ee6-42b1-a078-9b51886c6003@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <92b53d3b-8ee6-42b1-a078-9b51886c6003@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_112752_881658_1BC1F55B 
X-CRM114-Status: GOOD (  13.39  )
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


>>> @@ -1030,11 +1030,13 @@ static int nvme_rdma_setup_ctrl(struct 
>>> nvme_rdma_ctrl *ctrl, bool new)
>>>               ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
>>>       }
>>> -    if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
>>> +    ib_max_qsize = ctrl->device->dev->attrs.max_qp_wr /
>>> +            (NVME_RDMA_SEND_WR_FACTOR + 1);
>>
>> rdma_dev_max_qsize is a better name.
>>
>> Also, you can drop the RFC for the next submission.
>>
> 
> Sagi,
> I don't feel comfortable with these patches.

Well, good that you're speaking up then ;)

> First I would like to understand the need for it.

I assumed that he stumbled on a device that did not support the
existing max of 128 nvme commands (which is 384 rdma wrs for the qp).

> Second, the QP WR can be constructed from one or more WQEs and the WQEs 
> can be constructed from one or more WQEBBs. The max_qp_wr doesn't take 
> it into account.

Well, it is not taken into account now either with the existing magic
limit in nvmet. The rdma limits reporting mechanism was and still is
unusable.

I would expect a device that has different size for different work
items to report max_qp_wr accounting for the largest work element that
the device supports, so it is universally correct.

The fact that max_qp_wr means the maximum number of slots is a qp and
at the same time different work requests can arbitrarily use any number
of slots without anyone ever knowing, makes it pretty much impossible to
use reliably.

Maybe rdma device attributes need a new attribute called
universal_max_qp_wr that is going to actually be reliable and not
guess-work?

