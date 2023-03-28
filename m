Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CF3C76195
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 08:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mxu2yCxpOGd76KyGwcDydtWoB5vjdBQAK5ayZ11SrHs=; b=01/QN3euOfG118ORi50sDaDoIy
	feMk9wgiBPG6L846LZdi7+QeRZm14jcWDIyG+nmD7wlz8b4FLsoI3nNHznvAGcubEHTemG4S1spoq
	sof9r+F/SLbH2xTo7ngEu22jofSkkQTVGNZLBcQQDBURasxnwHsdFs+eRiuKmBuqnrea5UZEadfL4
	uTSIkAX/tLh7qxZtsiaFp+YS0qAiDj3fZhZJwMeKGrW3iE0aehyhnDjFS70huHTjzw0DIsWwUp/kS
	JNOp+ySQWReqKCAoGQb/QvJzSSuIsCsFlJYsFFZ/b6uEd2o1S5Z6Im1knfUdqd4SO2C6jqfyOD0XM
	zoI8/1cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph58b-00Df5y-1Z;
	Tue, 28 Mar 2023 08:57:05 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph58Y-00Df4f-2p
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 08:57:03 +0000
Received: by mail-wr1-f50.google.com with SMTP id m2so11316657wrh.6
        for <linux-nvme@lists.infradead.org>; Tue, 28 Mar 2023 01:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679993820; x=1682585820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mxu2yCxpOGd76KyGwcDydtWoB5vjdBQAK5ayZ11SrHs=;
        b=nwggVbjGC7CCDxTLO24NzCxRa8JOtCg5MRdViSf4x4iOYz/6iWSqcX93MyHQg0ZdYH
         m5lihG0Wj/fzgLN4BuwfT3JH40/9pokqDWcO3kLop6z6xK7Tw7FY4GWDJjtf/gU6KEdz
         Db8qnwa1z82oaps/g4sllWTEEolmcK+ukXmtrxE/DkVOQyUT0u658GiCXfVpkLb1ti6Q
         JVy3ChI1uwrkf5nHCwY/vxYB2rR6mtG38XoboyqB/WaD1k/N/ERLRESyz4meM4KjCFsf
         FDJBZqoYBgQ6pSRxE6//t9YcPSLsNlGq7kkbkc953CiGbi5OATh3aRmnmusWDALP4xCd
         VyeQ==
X-Gm-Message-State: AAQBX9fBtYqhU0MQASd92iQsvuDgDMyzjmorreVgmkfgmy7X4Z9GvhG5
	cCplm6LIKGrv1/KciPU2+Fw=
X-Google-Smtp-Source: AKy350ZrQzsVzwOEK1KDlfFl8/G/34CL5UYJmffj8iftfy9bx6oLZxPGJ+Cc6QG0NqKZN4R6NbHm8A==
X-Received: by 2002:adf:de84:0:b0:2c7:1755:30ad with SMTP id w4-20020adfde84000000b002c7175530admr9032128wrl.2.1679993820194;
        Tue, 28 Mar 2023 01:57:00 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d4b87000000b002cfe0ab1246sm27126431wrt.20.2023.03.28.01.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 01:56:59 -0700 (PDT)
Message-ID: <30e218de-a6ed-6f5e-500b-212f918a6cba@grimberg.me>
Date: Tue, 28 Mar 2023 11:56:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC v2 3/3] nvme: ignore starting sector while error logging for
 passthrough requests
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, p.raghav@samsung.com, kbusch@kernel.org
References: <20230323230316.2914077-1-alan.adamson@oracle.com>
 <20230323230316.2914077-4-alan.adamson@oracle.com>
 <20230328005529.GA21497@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230328005529.GA21497@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_015702_917440_C7B72E47 
X-CRM114-Status: UNSURE (   9.78  )
X-CRM114-Notice: Please train this message.
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


> Yikes, no.  Anything that needs to poke into details of passthrough
> commands is fundamentally wrong.  Maybe we need a separate log
> message for passthrough that is just based on the cdw values instead
> of trying to decode it.

Agree

