Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1342AC624DB
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Sep 2026 00:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wSuGwIjurOhCkGUZcJ+V1N+iWG3IYHtTy130K1hSOmI=; b=OJlv2WttNC2GXIrB/rU+WOpnK4
	TW1AI39A87pdPjWWn4Q8OaUMO1b1NYDRuSf4tVoKUSBctJVhnDkQ35z5NLaAQGV3z0Mz7mSZhsjV1
	J20kOA2VJlSMseyFT9lqQR1+4lry3/5cR3ecVNj51m8COtD1QcZadZ7pYusjqRk/R7yFYpfSS0i/+
	/kc6sPx+7yE/BbP2nYpnBf+IgNfFF5g5IEtY59jZ/QcVgY2M/bU9gunlCYVNV8pXmeVL6YhDgGh28
	lV67N01TZ7bR0+Zz5Xoy680fobzFbeiV0NK6vM5zx8n5abBi9+EANqBfsZp1LzSR6ULA6A89L4ZYI
	Q6vAccSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x30Xb-00000004VVR-2RXw;
	Sun, 06 Sep 2026 00:15:23 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x30XY-00000004VUr-0XyK
	for linux-nvme@lists.infradead.org;
	Sun, 06 Sep 2026 00:15:21 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48436216a98so1467148f8f.0
        for <linux-nvme@lists.infradead.org>; Sat, 05 Sep 2026 17:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788653718; x=1789258518;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wSuGwIjurOhCkGUZcJ+V1N+iWG3IYHtTy130K1hSOmI=;
        b=Ce50tM10QVvYcwTsTSIh05txtDzkMrXajZcQogxZKud7S6n2i1lv2pOjPXbur4d58E
         VPx4aIudW6Nrd8w7eGVT8ncxcFRbcqZqLDiYOyXoh4WdYKg4nbVJI5sFKrvpQLcB28A/
         2fnFhf11M7D+B7+wje2AiZ0lVTRmIWuH/lPHRFU4hB0AU03DHlL1sIRWLOd2YXvE77r2
         vwp+HECbFaUd3lJb8O9fcKdQxQX5sDORNXGXG68MMa0edGz+lDYrFO5hAme5gdvR3VmA
         TGd+oX8sBWpAVhnaOp4EXltl/kWeNSpdCElEHr3XxnpjPJyjA8Vcd+3qCDo1thpvZPSG
         FAIw==
X-Gm-Message-State: AFuF++lvijS1XjB5L+cWhf4qJACmh9/5tEWOk9D1EQmR4BY7ytbjQbjU
	9gZ0GMuyvAq1XR5DSCICCce+IXqhRgD+MZyoLFTEhiAi5/ZYxrKvXgrh
X-Gm-Gg: AYBFou1u+Gd0HDZRQrN7rY1TrtGa8GOE5502KsDsDs7G0WRpUmwyCqqvz3JLoRwt1oE
	pm6ENOkJ/RUPcL2SUbYU7FlUsiSdEI6w0lfMrtNTmn8e4DkaiWan0ZSKt747SnmDdB2ubYpfRgD
	tGBOLTFRcagg8EWYxijIV/nC5wMj/1tiQQFCN7Jtn8PnvRaLrvyDA4HH5mDBiofuHvTZ8vCyy4U
	JF39IUKNT3n+UoF/r1GBctNbg2KNsMSVI/CErptO57CU3jRbEw86t7EcvXWGAtu/V/Kkwefe+C9
	8uUuQYa5ZC5mFcwGW+Ebx1En/BA9EtoTj9xqKBUrbSLD4Ag4dmsHw8ufJrGFg2eintk4ZDEqerP
	YwqajKlN1s8MElQQbEx8BR3keZJocPBmbyCNywKkMqXFfnpGF/V7zEkLZ8HwCLCllcaedW10SLa
	bdRVcZ4A+pEfiFABc+0BdRg/SUZgvOuZmSkZ/hDHvTlficDxYvUClObNke/8yJG4inlSL1rBxbN
	AjgvX0MYruAiq1b4m+PBw==
X-Received: by 2002:a05:6000:4909:b0:485:8c17:9764 with SMTP id ffacd0b85a97d-4858c179966mr11929174f8f.38.1788653717646;
        Sat, 05 Sep 2026 17:15:17 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859162f354sm8861493f8f.20.2026.09.05.17.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 17:15:17 -0700 (PDT)
Message-ID: <2a05c494-9ad3-492c-b805-1ee6d6ce4fa8@grimberg.me>
Date: Sun, 6 Sep 2026 03:15:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] nvme-mpath: support controller crd when failing over
 request
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Daniel Wagner <dwagner@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>
References: <20260823084903.193188-1-sagi@grimberg.me>
 <20260823084903.193188-5-sagi@grimberg.me> <20260902134300.GD21649@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260902134300.GD21649@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_171520_203391_23CA932B 
X-CRM114-Status: GOOD (  17.30  )
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



On 02/09/2026 16:43, Christoph Hellwig wrote:
> On Sun, Aug 23, 2026 at 11:49:00AM +0300, Sagi Grimberg wrote:
>> When failing over a request (due to a path based status) we should
>> repect controller crd returned in the nvme completion as much as
>> possible. Hence we want to delay the failover command execution by
>> the controller crdt.
>>
>> We allocate a new nvme_mpath_failover_timer referencing the request
>> stolen bios in a staging list, and when the command retry delay expires,
>> and only then the bios are moved to the mpath head requeue list which is
>> immediately kicked to re-submit these bios. If we failed to allocate
>> a fot, we fallback to the existing behavior.
>>
>> Given that we now have a new staging list for mpath devices, we drain
>> them when removing the device.
> Given that we only have a few potential CRD levels, what about having
> the "container" for the requing statically preallocated for each?

I am not sure I understand how we can do that. While there are 3 crd levels,
requests can fail at any point in time with a given crd level, I don't 
see how we can
reliably requeue after the crd level has elapsed without getting into 
the situation
before (if any command failed with crd level X, it would extend the 
timer while other
commands are pending on it).

The allocation in the failover path is not ideal, however the fallback 
gets us to the normal
failover which we have today. And failovers are fairly rare, so I don't 
know if it is worth optimizing for...

