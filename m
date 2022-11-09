Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5011AC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 19:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U+mvbOgkTI1BGbH6lHPEni7k4Kv13utf47ozf34a940=; b=ccu5wKTk6JLx9XE04gHaybx8bP
	W0bMJz9CqmC6d3hLyn+uNgOU5vzbDpRtrK+KJjQRdin7U6P5brpRNqL65ZbtKYnjpK03dIV841khM
	SBQgX0xT8NsxmSqoX6EGzjoE74B9JUUhf9I62QqAbey6El6v3tGfOxBnPpyAdkpVqA1PhCzAzMQUZ
	M1V3hxS2OZWWcITaW16mHs7M5rghksQOQAf2VS6FEN4gJ2vAaEaEXl4pUC/GoHifJBC3JiOYULOAZ
	XmPwuOZWT7FHjtQoRZw5XrvtHJDHkYp9yPLhUZzyHwDue0dk6/8yrTGOPZ0qFKuCT6iSxSM+nPPu0
	3R4R+JLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osqJv-00GQe1-D0; Wed, 09 Nov 2022 19:01:07 +0000
Received: from mail-oa1-f51.google.com ([209.85.160.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osqJp-00GQcv-RE
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 19:01:06 +0000
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so20693532fac.1
        for <linux-nvme@lists.infradead.org>; Wed, 09 Nov 2022 11:01:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+mvbOgkTI1BGbH6lHPEni7k4Kv13utf47ozf34a940=;
        b=5O1kQR/tTVy7rIpJgQfADbUKtXVDT0Sb2KB8hmHGnhEdoMqJR0OOd/0zoaaXCIJr0A
         PPGQFZ3B7iYqnLEnv15g7GvWd1IUd0HOHACWn5mYH2RSs96sIzTcwf+/95HJGt5mhDaI
         3tULbkI5sHteRyOhfc2pDnRrpQwhYCTXcrNHESgWstPgv9MOaWDVpIwCENpS7oXvRY5U
         lelYAv8A3HOSToXrK9H6ktX6xnr2qmNnD+U1GfDjzxYM7i9a7H0DPmMuSq18CIiwfhm/
         LzGfp+34KTm3HMvsvIBpHbkczEjBiDuQZ4bWEmr1bcx8AsP4ePNNJZbPHUc2V0HlLOP7
         jsOw==
X-Gm-Message-State: ACrzQf344YQtO3RzZ61fQ/fwd+q8qlWKoSnCnVAT6z3OFSp6KoGcw3Yv
	OKEk3lStctpmC9bCqJJ/3fk=
X-Google-Smtp-Source: AMsMyM7uM2Tel3T4KpbQfJEVjtufrcBIJnFU/Vwrx1aCaXKMilex55cODzvMK8kdrEwjSTjxQ6StaQ==
X-Received: by 2002:a05:6870:a2ce:b0:131:a8bc:54db with SMTP id w14-20020a056870a2ce00b00131a8bc54dbmr38002482oak.187.1668020460747;
        Wed, 09 Nov 2022 11:01:00 -0800 (PST)
Received: from [192.168.82.40] ([108.95.161.27])
        by smtp.gmail.com with ESMTPSA id er33-20020a056870c8a100b00131c3d4d38fsm6460856oab.39.2022.11.09.11.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 11:01:00 -0800 (PST)
Message-ID: <54b0a8c6-5152-07a5-4b14-b8ce814c101b@grimberg.me>
Date: Wed, 9 Nov 2022 21:00:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 03/16] nvme-auth: don't re-authenticate if the controller
 is not LIVE
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-4-sagi@grimberg.me>
 <d0aa9900-8289-0312-593a-8b1757a17f0a@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d0aa9900-8289-0312-593a-8b1757a17f0a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_110104_510524_1DB480A4 
X-CRM114-Status: GOOD (  16.40  )
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


>> The connect sequence will re-authenticate.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/nvme/host/auth.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index 734928282d3e..93c0fc71bc7c 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -939,6 +939,13 @@ static void nvme_dhchap_auth_work(struct 
>> work_struct *work)
>>           container_of(work, struct nvme_ctrl, dhchap_auth_work);
>>       int ret, q;
>> +    /*
>> +     * If the ctrl is no connected, bail as reconnect will handle
>> +     * authentication.
>> +     */
>> +    if (ctrl->state != NVME_CTRL_LIVE)
>> +        return;
>> +
>>       /* Authenticate admin queue first */
>>       ret = nvme_auth_negotiate(ctrl, 0);
>>       if (ret) {
> 
> What about a state check in __nvme_auth_work()? That should only be 
> called if the queue is not in CONNECTING or LIVE.

I don't know why that would be needed. Now that the ctrl level work
checks for LIVE and waits for queues works, and nvme_auth_stop flushes
it, resets should never compete with this work.

> 
> Otherwise:
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> Cheers,
> 
> Hannes

