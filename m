Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D25AD49228
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 13:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eNWAtJf0aipEWiZoRKzT5GLAwdrH7hKYwdPEwrlpEtA=; b=e4zGuVM0lxiHGfs9yNRoKQoJDi
	XFx752F0Gp+Hs+G2QviGwU8lHfTQ3E1UCpDwBRPeRq4PhZ4M2+alLgLQn0xiKoLHuvFgvhCGbfadj
	CNHIoXfBlg6RvSIexEFGkK7gmscnK90hZf/+QDWlMEmHcSzduuUDpFkTOLdrJGBCM4H8sPPNL9Axr
	3UIxZ8nVYncvl2SzlxULSWTMC2keESZILVuOJrYHpOB4Volvpgc3Vnq6H666g2ECFxkniTYEqIl0v
	qxn9jEyCEgqP3uxvWiFILyMDbnT1dO+7ZuHQ07CcIRT9/QYOrtEgIP4co0S8RFzOb1c3b+4qPvOuM
	GTltFqcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU3Qa-00000000Zb8-3K0i;
	Fri, 12 Dec 2025 13:43:24 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU3QY-00000000Zaj-051z
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 13:43:23 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so740272f8f.2
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 05:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765547000; x=1766151800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNWAtJf0aipEWiZoRKzT5GLAwdrH7hKYwdPEwrlpEtA=;
        b=wHv5g+GwchY+9vcJiRLLbM+qiFQ+3CHPKm4h56+y9g/nDSEQemHNHidj0eOn1Nss3+
         CX91TXsG7gGcVql1XlFMfdNFGRo6Fszs92RVhRMb4ZvZScGHtwfhbCG+gLtaqecdZiSd
         0j0/AViVzO6iQlSV0hQxbPATGULAiK5gMfyl0vgLKe24NBcKj2DiVgZDrtT0D5hHPaXl
         jjO9ib9eQfc42Zi7mQep6Mwwh1DuX0+F9hxoL5+Ja5Kdx70XRW3Acqs6Agb7kB8qZ8Cx
         RCOVMHJTiSvnbKWOC/36qBZ72JLynsXaESWoEPHTsggU9czqyHVE9Vdk6ZqCHnVERf3j
         yFNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjc61VMe4gt36tug1fgXep6Sx9E8YM2RJv6aYC/54H8H+yB0jMGA7QCqEREbOT+G1kFhGD1DG00I1P@lists.infradead.org
X-Gm-Message-State: AOJu0YwTer+sZE+F16uxhdpzW+d3aN+lNoP/uxDPf8LdLivxBLpWDCJn
	8y3iAp9/OTACMvgaQgugjy2vvh5nZvn70SmRQkmfELTx1oQObxedIjkf3nfrkVva
X-Gm-Gg: AY/fxX4XlIQt9kWP4bhy0jwmHMybleZGQTiiuud+rimyvC55XuB/K+ijcl+xgma8prm
	JpN0sO34VfFWIPP28DAfXXz79PErb/erTJeAOOhBWFLsW9fQ2Gpj0NaLstIqiRFml7SgkSWoYtB
	wYDAeLkeLFzXMyvG3Zvb34lamMBiK7mhfRA4PUZPKiNRABSF5XiACYV9OWwrovpg+sNJnNMABHx
	DDHdbLMW8aa/ib79GywERz8uPJzHQESvT7W7DJy92kw627KD+2A8PJprkR8J00YOF/xgMUzDZtu
	OJDiLxnsfQ+/0SmGULkzEXZo5swAsyDcsLWAZsKCYrxd/3uG+c6svw1FLwHQxp0qGu1LMUKSrGR
	iyxbnSR0lXGApVb/ea2HpRqG0Vi3zjbk9XU5/viMB3mt0y0VC9cv6Uq6tT0GEr2x5icNdVzbtnE
	SM2CHl1b+6dW+X2NGGAzDxb2FFRc+QWth8ug7tHo7Pa0H0RQ==
X-Google-Smtp-Source: AGHT+IHTCFUrGRpqNrKQ9lg15u/4k2gGC1fraovFUBU4m7JXjkHAMXlp+sgXiOH0bfa/EYyTyyi2qQ==
X-Received: by 2002:a5d:5f54:0:b0:42b:2ee0:569f with SMTP id ffacd0b85a97d-42fb48ffb94mr2274165f8f.33.1765546999619;
        Fri, 12 Dec 2025 05:43:19 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b8601csm13130186f8f.22.2025.12.12.05.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 05:43:19 -0800 (PST)
Message-ID: <1b396ea8-8256-48bf-bee2-92e500f3ef80@grimberg.me>
Date: Fri, 12 Dec 2025 15:43:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: Let the blocklayer set timeouts for requests
To: "Heyne, Maximilian" <mheyne@amazon.de>, Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251204-tests-bryce-8b3b2823@mheyne-amazon>
 <aTGzL5t7Gu1tpebp@kbusch-mbp> <20251204-pause-lima-29ecb942@mheyne-amazon>
 <20251205-myopia-been-ed739f86@mheyne-amazon>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251205-myopia-been-ed739f86@mheyne-amazon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_054322_081907_9B8F63CA 
X-CRM114-Status: GOOD (  27.18  )
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



On 05/12/2025 9:33, Heyne, Maximilian wrote:
> On Thu, Dec 04, 2025 at 07:34:26PM +0000, Heyne, Maximilian wrote:
>> On Thu, Dec 04, 2025 at 09:13:35AM -0700, Keith Busch wrote:
>>> On Thu, Dec 04, 2025 at 02:11:50PM +0000, Heyne, Maximilian wrote:
>>>> @@ -724,10 +724,8 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
>>>>   		struct nvme_ns *ns = req->q->disk->private_data;
>>>>   
>>>>   		logging_enabled = ns->head->passthru_err_log_enabled;
>>>> -		req->timeout = NVME_IO_TIMEOUT;
>>>>   	} else { /* no queuedata implies admin queue */
>>>>   		logging_enabled = nr->ctrl->passthru_err_log_enabled;
>>>> -		req->timeout = NVME_ADMIN_TIMEOUT;
>>>>   	}
>>> I was trying to think of any in-kernel path using __submit_sync_cmd with
>>> an IO queue, and quick search shows there's just one: zns report zones.
>>>
>>> Everything else uses the admin queue, which doesn't have a sysfs tunable
>>> for its request_queue's default timeout. All we have is the nvme module
>>> parameter, which is writable after loading. Since that's the only way a
>>> user can modify the default time for that queue, I think we need to
>>> leave that req->timeout value as-is.
>> Ok sound like a v3 is needed where I only delete the line with
>> NVME_IO_TIMEOUT but leave the NVME_ADMIN_TIMEOUT and add a comment about
>> it. Will prepare such a patch.
>>
> I thought about this a bit more. Considering that the module parameters
> can be written to produces even more inconsistencies.
>
> With my proposed change we will have the following situation:
> 1) when a device is probed current settings for IO and admin timeout from
>     the module parameters will be the respective default timeouts
> 2) almost all admin commands to the device will default to the initial
>     admin timeout
> 3) almost all IO commands will adhere to whatever is set via sysfs or
>     the initial default
>
> -> changes to the module parameters will (mostly) not affect already
>     probed devices
>
> When we keep initializing the admin timeouts to the module parameter as
> you suggest (so half of my patch), we'll have the following situation:
>
> 1) same as above
> 2) some admin commands will use the module parameters admin timeout,
>     some (ioctl's via nvme_submit_user_cmd) will use the admin queue's timeout set in 1).
>     This can be made consistent if we fix nvme_submit_user_cmd.
> 3) same as above; IO timeout not affected by module parameter changes.
>
> -> changes to the module parameters affect only the admin commands but
>     (mostly) not the IO commands which is inconsistent behavior.
>
> Therefore, I wonder whether people are actually making changes to the
> module parameters at runtime to adjust all device's admin timeouts. In
> that case it's at least broken for ioctl's currently.
> Should we make that timeout runtime configurable per-device too instead?
>
> In summary, I think my patch as-is leads to better consistency.

Perhaps you can simply add admin_timeout sysfs file for the controller 
that would alter
the set->timeout and take the value from there in nvme_init_request

