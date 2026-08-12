Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDE8C5B567
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 03:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hooElFR/UaAU2c03fOW+qzzmNPOvItQogFD/Qzn5hWs=; b=bDJJKjkby1caDUIFrqbGq/5/MW
	dXN58tSeCiB53ctIKg0uRC9xs/F4uFgLZSLgrcrB7b5s/rRziGRbc3s3SYd8yPBYY48D6V/QTSLRa
	rhwTNeKPRmFt1MhPLLDclNUeAwYj4BA6PLO7wkagQjlIpCHYzmN5g1pJD+zMppOUBW0uh6K5J/68S
	90vE8JAB4wW74yW6HpyzFcKcZKtPxq6nrOZrq7fLPda73B1+N8L+7AC+VctB2MgK8LMhlZXPHErTM
	SO6l8VYyylXxrByPxeeLaqucmOHxrM2fOHAHju2yaKWJMJssUmKmTaWOUi4LT9rxIEvy+qPZsb8f7
	TpFxtFdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtzZk-0000000FLX5-1QAH;
	Wed, 12 Aug 2026 03:24:20 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtzZJ-0000000FLVg-20II
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 03:24:12 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so602447b3a.3
        for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2026 20:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786505032; x=1787109832; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hooElFR/UaAU2c03fOW+qzzmNPOvItQogFD/Qzn5hWs=;
        b=oUw2pjkiYfvxLUDB96L+QiiLZCh0I2O8uCgU7pUCARmh4sTCp7z4Pxvsh5uatZcTC4
         h0QtM7dQSlgJbzSBRp5mVk8DYJfdpRDZI8qU11AiRus1hcmDrupzyX3+qu3CXCa6tKUc
         COKPk5xS3G+18nfftQorrKyLzCjas3kYf/7sWCxV/5YDI9w3Uxzy7KmvuGLhVFomNEq1
         qBLHjeJgO9XwNDhkkcrHS+t5DaX/a8VWwKaV84g6HffT3aS3wJJiGMrQpJnCE0ELDeUf
         OM4FSmo4Fu2DobuI4VmGgpYL03rnd0qfiuAdWYV/8NYcOIxMopOAhFsEDzx2yjeqAOQR
         c8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786505032; x=1787109832;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hooElFR/UaAU2c03fOW+qzzmNPOvItQogFD/Qzn5hWs=;
        b=Qsug0/08KON87QQHBpeHXW4p/mZ9DszShY551K61fIfQjX6VU97FSp+/oBmn0vUKn1
         iXCXz3nZTBVT0VnLizMzPa1QVc3jG/CdtaHRNTbnjbNixyOBuSOA/KnB38TNo0g/8AFE
         lyUDMv2p7zk6MA0uLZRPlwembeVlIxlBRidTMOBjSlWnLBn30gfXrsuJ1GCBejYdt9tn
         T03NYf+MIjBvtEFWsnPau2sU6QLuSUsq/brtMe6d5q8uJupJjtI2B1UGlWaXYxe9WbTj
         s49jIsya/xSyGh+zQ/sKbFCJdTB8R6+jc+dQRuozp+he2flzx0m2wIiqGcOpyrjpQsVa
         YU1g==
X-Forwarded-Encrypted: i=1; AHgh+RoD60tejDbY0f/EXEltiKVxaqF4CHO9StyZeDotEv6DYQMBWrM9qDQGTIA0l/Fj+U4IrfySYRTuJpOr@lists.infradead.org
X-Gm-Message-State: AOJu0Yx78ZyP1FEigq27e3ruDpHKWQtLx0zx0Tfya7I6q7AxAHz8ytPm
	5vAcEjwykp7j3e5S5z8mlzXP9xeV9OiBX76grEWQUS8DoWoG6GkOkLhUZRXHXg==
X-Gm-Gg: AR+sD12dUc9bIuz/XAmIjQYOmXHQwaWA3kA+RdN4sgaH6hsJs+GeG7zBPVYUwKfcMGb
	kc7hmDmO6BT2JaNq6anUG8izgscrh8aNYxGFD23Zi17uLTfv0I+b8wZkjpcMYpzDJ+5FP30ntXn
	5M+N2Rh5OVmO6RbHpMdfmakix72D/OBXcDe4LHXsPdfiPz4XxU7AmL4xOiwOvjMPywZS8ZPo3KJ
	caEeAboQtSa17BppHVDYsjmaxiNy7uCXkJGjzQUFOMI6cadcYdCTrezrKaxnHjj2yQKxzj2vwTt
	FUMYmfnE9MoPdTH0NSPB8VOqKBEQHA2W49bb4H2S2DBiqMYN3DdtGCiZ3wkiwsJJXA32DmMdajx
	UWAxyTyUaxki0TcNRAJvM+SVV9TdcbQxHSyeQM/1oghsXXUk7rs5EabKH7u5Gxq9sGHqp5NJ/p7
	65i/KNKxOpucB4mJ6pimGKPNbMs/IoXr59wbS1KqXl8HQUYr4kcqjLsTQN6WH5MOVBbjpLiiST2
	KNSjwcJDoRlvA==
X-Received: by 2002:a05:6a21:4685:b0:3c3:a024:1360 with SMTP id adf61e73a8af0-3cc3f7393f4mr1884991637.28.1786505032199;
        Tue, 11 Aug 2026 20:23:52 -0700 (PDT)
Received: from [100.82.105.140] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14124542f10sm4520653c88.11.2026.08.11.20.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 20:23:51 -0700 (PDT)
Message-ID: <52fad18e-9938-4cba-8145-aa88acb7e4b1@gmail.com>
Date: Wed, 12 Aug 2026 11:23:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme: reduce firmware activation poll interval
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Guzebing <guzebing@bytedance.com>
References: <20260728121735.1627370-1-guzebing1612@gmail.com>
 <antR2u1eeBDCr0ux@kbusch-mbp>
From: guzebing <guzebing1612@gmail.com>
In-Reply-To: <antR2u1eeBDCr0ux@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_202353_558614_E63BB268 
X-CRM114-Status: GOOD (  17.65  )
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



On 8/12/26 12:46 AM, Keith Busch wrote:
> On Tue, Jul 28, 2026 at 08:17:35PM +0800, guzebing wrote:
>> +static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
>> +			   u32 timeout, const char *op)
>> +{
>> +	unsigned long timeout_jiffies = jiffies + timeout * HZ;
>> +	u32 csts;
>> +	int ret;
>> +
>> +	ret = nvme_wait_csts(ctrl, mask, val, timeout_jiffies, false, &csts);
>> +	if (ret != -ETIMEDOUT)
>> +		return ret;
>> +
>> +	dev_err(ctrl->device,
>> +		"Device not ready; aborting %s, CSTS=0x%x\n", op, csts);
>> +	return -ENODEV;
> 
> Actually, I'm to back this out for a moment to think about this. I like
> that you've changed the error to ETIMEDOUT for that condition, but I'm
> not sure we need to convert it to ENODEV. None of the callers seem to
> care about the specific error, and the user visible side effect of the
> condition is more informative than ENODEV.
> 
> So if we can get rid of that legacy behavior, then this simplifies even
> more. Thoughts?

When restructuring the polling loop, I tried to preserve the existing
behavior and return values as much as possible. Converting -ETIMEDOUT
to -ENODEV was part of that effort.

However, I agree that -ETIMEDOUT more accurately describes the actual
failure. I checked the callers and confirmed that they do not
distinguish between -ENODEV and -ETIMEDOUT, so propagating -ETIMEDOUT
directly makes sense to me.

Please feel free to fold this change in, or let me know if you would
prefer a v5.

Thanks,
Guzebing


