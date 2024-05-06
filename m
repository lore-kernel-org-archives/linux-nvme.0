Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCC8C25B4F
	for <linux-nvme@archiver.kernel.org>; Mon,  6 May 2024 14:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xGsRzdul7Up+skuEvK4gHneP5XkWCFTOGP/JbN+2yaQ=; b=3IAKLkqgdq5F0eXpVlS/pvtMiM
	YpOOYB0kC+jx37Y3NUoj7IpoQDUU4T0pZRhNsKfhKIBuu8UjWamqcIJhUzfZaJKRmKMTvprbNIbHt
	S7WOPVL6cSOzsmuJZ/TKBLFcJBqyIp9feD10rT4znxNnBNVS7cTwkxkjGMfHi/KOk5U3a5WfSsI40
	zT3ZP+MUhGUZxggvw5Ks+3zzT9mKHCeKeeG7WGO+AmjJnMBIkjJrNGO9qHhHZOSGdvnemG2cLf4gH
	+rewVcV4OmjLJcf0ic+UFcBL/gUocDMxho4OTUoNE73qmmRamX+dC7/srz/x+CjZhgoP46r+oDqt+
	UZYfLHCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3yyA-00000007aAb-0BoE;
	Mon, 06 May 2024 14:05:30 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3yy7-00000007a86-0RoK
	for linux-nvme@lists.infradead.org;
	Mon, 06 May 2024 14:05:28 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41ecf80482bso1373235e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 06 May 2024 07:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715004317; x=1715609117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGsRzdul7Up+skuEvK4gHneP5XkWCFTOGP/JbN+2yaQ=;
        b=Ip7B4V4/w09AOMEjs4SKu8WKRrjFQ68pHdxZ2IMBY08sqcxNReXh32H9dd0KvTBBHd
         xrEJTBkf/zVBgKw8Y5kV70JIfgE/M5+S2j49Zejd5Fx8NS8zb2B2Vw7tO1gKQbbjbSnG
         tAgVX99m7r96SyQekiQy+YLjJNxO5O1btvWVb/+oskeUC433MLcXicUS2C4Zj5FC9xz2
         2XmHbzCVazO4sLM/XGU0nRldTDqnqsd16w6QD25cKuCRaFSepAtfkiggTuFCiRVP+X3w
         CxRsfn+cFTalun7JtyNCYvqofBeu8oXewBGo2lUxwB5EZB9roc379vw4umVFQQkE5N4O
         h2qw==
X-Gm-Message-State: AOJu0Yyje0+W32th2Ttx4emg4cYVj8TwrdSi9v0sEEgWYMPfuP2V056v
	3GFg/+koFzV3sWsUVwdzuE30OmdVgdfCSVpjGJvXL4F/voMZt/o6
X-Google-Smtp-Source: AGHT+IG/jwf2QdZkgAlXzs77WWUbwudrV5/WJsArKhcFobftnbN34iCMP1GPMD4vs4zHhYnJj/JifQ==
X-Received: by 2002:a05:600c:4fd1:b0:418:1303:c3d1 with SMTP id o17-20020a05600c4fd100b004181303c3d1mr8123141wmq.3.1715004316495;
        Mon, 06 May 2024 07:05:16 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c458c00b0041bfa2171efsm16331295wmo.40.2024.05.06.07.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 07:05:14 -0700 (PDT)
Message-ID: <470bf39f-e346-4899-b45f-5a7724a7039a@grimberg.me>
Date: Mon, 6 May 2024 17:05:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: make nvmet_wq unbound
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20240505103951.52413-1-sagi@grimberg.me>
 <20240506053308.GA5030@lst.de>
 <d15da519-2c81-42bb-8f60-89da4650f7a9@grimberg.me>
 <20240506120808.GA30005@lst.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240506120808.GA30005@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_070527_188648_9E7DBBC7 
X-CRM114-Status: GOOD (  11.22  )
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



On 06/05/2024 15:08, Christoph Hellwig wrote:
> On Mon, May 06, 2024 at 10:50:02AM +0300, Sagi Grimberg wrote:
>> It doesn't have any better justification. I never really saw any other
>> justification
>> to add WQ_SYSFS to a (usually unbound) workqueue, than simply have
>> visibility
>> or ability to control it.
>>
>> What makes you think this is not harmless and useful?
> Because now we have to deal with users setting more or less insane
> parameters on the workqueue.
>

Isn't that an argument against WQ_SYSFS entirely?
I can drop it though, its not really important.

