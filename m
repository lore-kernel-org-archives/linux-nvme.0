Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BE9C636CC
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 10:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yww7k1x3Ia7RWCoX6ifvXNH0vFjqqBaeINYnboZN8j0=; b=Gmzp9pY6Rp43wh5IiJpJe0gD4I
	OhMcsEZGXlrsyZGrXgav1zyiqI3k7dEAoNvKortk3eLULpYJWaByV+c+mrsXjpGzpNzFd8GJ/WGQ8
	T4WJQkgE4fDKlTq06oi6tQlOnAPhF6wpg9U5hh5vTZMxZfvvPuCvrbzTXesd84LsA6eS5ysJisY8t
	6f3I25Nhd+khHDm+hEPKPSDIzuYOAHL4xPCZ1i/kiJyyOKsUE3NMXpueutezUUs56RVQRLkrKn7mD
	MUUO2yLrfbXj3SRdqJqajdpkNIVeRpB/DQsiaFdwutw4jIrt6fVMWJywDHhcSBTIAfIgQ8qKAS2KJ
	dt15a1Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRW9E-00E7ff-2T; Mon, 13 Feb 2023 10:33:24 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRW93-00E7eK-U9
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 10:33:19 +0000
Received: by mail-wm1-f50.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so8626759wmb.2
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 02:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676284392;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yww7k1x3Ia7RWCoX6ifvXNH0vFjqqBaeINYnboZN8j0=;
        b=if2gdl6GOCNggRMJ5yH2yvwN9xiLPA+vEeFsIVpjYgtFGphRfZ6iqEDwDKI8hahnCp
         EqEe/DPf2/lWUk8sf+d/L+l0+8maE0P8Z3aQj1PeaL7XMXCGarejT6dn7RUqDu0qV3S8
         eviuYBc9aw363qvY77v4NdO6eOaqbIcqws7H8eWgnbLBKppYPZfcnER/dDG/Rsm27nxI
         oim9ldnV0v4nSD8zIgpwGg0pFuimRn8L+b0SfyebwvtyrEPlTsHt0cQvfcuK/0LoGKWd
         kJC0VNgmw8dqpNvtlEEXcE2mpAx8DYLDH/kscXZgo+lIU78fcclnNC0jBEM+bPuOqhht
         5jNA==
X-Gm-Message-State: AO0yUKVpeflAvWADvWrFsNwT1Ww0qgCgSx6GCXxs7ERSMYFeCXJpk5pl
	Cqz3gWXokHpXj9fe56J1JUU=
X-Google-Smtp-Source: AK7set95i14rSL6j2ozYfQrLGJ/rZa4bv+9E1ilgRi6r8nWcCGtU0xgfcg7Sd4bncMAcnuS9gTpmAg==
X-Received: by 2002:a05:600c:3b28:b0:3df:fc67:cfe4 with SMTP id m40-20020a05600c3b2800b003dffc67cfe4mr22599619wms.3.1676284392439;
        Mon, 13 Feb 2023 02:33:12 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c129-20020a1c3587000000b003dc1a525f22sm14097300wma.25.2023.02.13.02.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:33:12 -0800 (PST)
Message-ID: <7126416a-0839-4b47-0aad-1ac1a1875681@grimberg.me>
Date: Mon, 13 Feb 2023 12:33:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/5] nvme: retry authentication commands if DNR status bit
 is not set
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 "George, Martin" <Martin.George@netapp.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230209143820.118097-1-hare@suse.de>
 <20230209143820.118097-6-hare@suse.de>
 <43e6c4b4-cb58-0873-2d0e-48499fcc1e31@grimberg.me>
 <42618eea-5a4a-f0cf-9e6d-e1ae36357847@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <42618eea-5a4a-f0cf-9e6d-e1ae36357847@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_023313_991366_C037B22A 
X-CRM114-Status: GOOD (  19.56  )
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


>>> Clear the FAILFAST_DRIVER bit for authentication commands
>>> allowing them to be retried in nvme_decide_disposition() if the DNR
>>> bit is not set in the command result.
>>
>> Can you please explain what is this fixing? and is there a test
>> to reproduce this?
>>
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/host/auth.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>>> index ef5dcd885b0c..935f340607a7 100644
>>> --- a/drivers/nvme/host/auth.c
>>> +++ b/drivers/nvme/host/auth.c
>>> @@ -87,6 +87,8 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, 
>>> int qid,
>>>               "qid %d auth_submit failed to map, error %d\n",
>>>               qid, ret);
>>>       } else {
>>> +        /* Clear failfast flag to allow for retries */
>>> +        req->cmd_flags &= ~REQ_FAILFAST_DRIVER;
>>
>> This should come right after the allocation.
>> But what makes this special than any other fabrics/admin command?
>> Why is it different than connect for example?
> 
> It is not different; it does, however, introduce a difference in behaviour.
> And hence I didn't enable it for all commands, as previously we didn't 
> retry, and it's questionable if we should for things like 
> 'reg_read'/'reg_write' and friends.
> 
> But you are correct for connect, though; we really should retry that 
> one, too, if the DNR bit is not set.

I'm not sure. if the transport is unavailable, we cannot set DNR, which
will lead to a retry of the connect (or equivalent) command. Today the
host will schedule another full controller connect within
reconnect_delay, which is what we want right?

