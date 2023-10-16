Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79788CDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 20:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YfsDvzRYGiS5ZGFgJs//6rK6tev3a6zeqag/0Ikuq8s=; b=uZbsS9d0MZifCixEN1EXsVmdlF
	6juGrk6Dl7zl1Xf+blIEOMJgbSIc40w/FnG1trLO4z/mb0xxZaStqQlG/+8JE9mng+wguLW8DXd2j
	ietjfzAjMHlX9H67+UgnnLemEST7m6xqTVKqTc3VIxDkcyPJx/xV0XiR5tBqk/XBLXCBlm9J6sDEx
	i6BIyw6DJAPy3vs/vZWmiIwolbwXDpyi80B3SM9hgebEcploIGZJCflmkHGD6qeydm7/2LrcZbVs8
	vAxkv73LW+CaLLrHTUAchTiilDUze/0XYzTGg0nFSvBr+C5vKlwTX7LPoNa5OHoApm2Vdn7L39TFy
	Gy/7650A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsUPT-00AW4g-03;
	Mon, 16 Oct 2023 20:41:55 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsUPQ-00AW3B-0i
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 20:41:53 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ca79b731f1so2820855ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 16 Oct 2023 13:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697488909; x=1698093709; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfsDvzRYGiS5ZGFgJs//6rK6tev3a6zeqag/0Ikuq8s=;
        b=tRSbKruAIvcpSRQvLuQgBkuNlEvo1MMJQbAAAkrMVtGY+HQS6OvWoMPpGrgWCa55tU
         gP0/qSaGIauyfII7QvPNpDugcvH+7dbZjBQGaJala1OgnurIjPdJBD68diNIacrD/YnS
         0U3/FWie6sfZ5jwajuKYjz+Qy8+IIcUDzaIlJ6KfNxLViJYiqJ7zibcClbY61aWUe+iU
         z3Vy+QbA+IhO6BfuFZAdaRDGIiGG7UZinz6mIw0wUD9i8BoJ3cVUpSy0vAmmFNQWpWEh
         FP9rdQ+Nu6IM4F0LqofohyGMmVeXzsSlQS5zrBOzLhppo8dzbsX8JEj2SnGXuqDxnjXM
         QSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697488909; x=1698093709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfsDvzRYGiS5ZGFgJs//6rK6tev3a6zeqag/0Ikuq8s=;
        b=h5B/tcXofTKa+J/TCm9qaNcU/mb9/Ad2EC5QnZEGwsu+Urq7cbELaymfmPfgk1SUnD
         nkC5Caj/IZDHQiOzHU84ww61aDDkwP15wJFAEdtyUiMuBgwFJBa/KfJdZikaRNuvaegH
         wqW+xT68UDXUM9vFWq6HQwtXuH/zki1Mr0MKgYm63LyHEu7M0242daEuxtfiU2U2YQjD
         bixb8TNTXsaG2T+xhwTCUx3M2plHZ66Z672NW8hO04MdWyXiPmSL+gENSnNxIvWB9dFs
         P//5UXkch2XxZXmbXzToeNQwfOhCm4VOBOQ2I77XW+m8AmIqNqYPUp0qqmBpYfj4qPjL
         kybg==
X-Gm-Message-State: AOJu0YzKByhqOxV23o2Yb/rDugoq/fycrMRDMVbChLkxaUDsaKlZgbmD
	N+1oRfwg2gOgTTBq7rLUstk2S5e1kF1GRgs3r1QGOw==
X-Google-Smtp-Source: AGHT+IH6MjfoPFn/OOzdCFovcg3ZZY0spCOMVm9aqHLZqLyqVZS8L0OxU8eKdKK0pXZlhxhIQrmkhQ==
X-Received: by 2002:a17:903:30c4:b0:1c3:a4f2:7c99 with SMTP id s4-20020a17090330c400b001c3a4f27c99mr373893plc.4.1697488909241;
        Mon, 16 Oct 2023 13:41:49 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b001c5fc291ef9sm41343plb.209.2023.10.16.13.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 13:41:48 -0700 (PDT)
Message-ID: <e04eec37-ec31-4c35-bf26-acbf90fda43d@kernel.dk>
Date: Mon, 16 Oct 2023 14:41:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: sanitize metadata bounce buffer for reads
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <20231016202124.2957213-1-kbusch@meta.com>
 <90fd6d9e-5bcf-40d8-b85b-9d33c91406b6@kernel.dk>
 <ZS2dmakCEln97UNi@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZS2dmakCEln97UNi@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_134152_259058_957F4F9C 
X-CRM114-Status: GOOD (  13.00  )
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

On 10/16/23 2:31 PM, Keith Busch wrote:
> On Mon, Oct 16, 2023 at 02:25:11PM -0600, Jens Axboe wrote:
>> On 10/16/23 2:21 PM, Keith Busch wrote:
>>>  	if ((req_op(req) == REQ_OP_DRV_OUT) && copy_from_user(buf, ubuf, len))
>>>  		goto out_free_meta;
>>> +	else
>>> +		memset(buf, 0, len);
>>
>> Do you need this else?
> 
> The 'if' condition just above copies user data into the 'buf', so yes,
> we need the else to separate how buf is initialized for each direction.

It still looks wrong to me. If it's writing to the drive AND we fail
copying in data, -EFAULT. But the opposite of that isn't that it's a
read from device.

	if (req_op(req) == REQ_OP_DRV_OUT) {
		ret = -EFAULT;
		if (copy_from_user(buf, ubuf, len))
			goto out_free_meta;
	} else {
		memset(buf, 0, len);
	}

would look more readable, as it splits it on direction, rather than on
direction and the status of the copy. And follows the normal idioms for
erroring on the copy condition.

-- 
Jens Axboe


