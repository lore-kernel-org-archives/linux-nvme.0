Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330C0D2CE0D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=41eqv+v2sxNkPISHr6IXeim2tPShJvPsqYKSkW7kUEc=; b=oJO88nNH5mnP7QieZaL58EydxE
	qZ25zuir092Bm1THKmatgJJ1ZoAeXXLuCQmwxvv+gGgAVPMB3wbekmByCtzQzcEAAGaoi2dz4KPNg
	fc289KFMjsMcEZ9Iqe3anqvljH7ga6LxC3Su+4JOoRt/Ue8bGPRORlqUHoTvZBp1Mg6+lFPc0x2S4
	NELxHqQvw2UD4d6CiCtUuZWxbf27O25mPSiBDnKZpedFmPgRITx6Bbd7K22jjeZJchHbyTQcYPisF
	tNfzZizTUoqodFU/z4gvm8qJTWJDTp2BIr+S3VJy7iocDR3Yc1lP3WiCdCvABZogAMNNZd0fTqg+W
	euPv5BIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3J42-0000000BjZw-1n1k;
	Tue, 22 Oct 2024 17:53:02 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3J2O-0000000BjH5-00B4
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 17:51:21 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-20bb39d97d1so55420225ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 22 Oct 2024 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729619479; x=1730224279; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41eqv+v2sxNkPISHr6IXeim2tPShJvPsqYKSkW7kUEc=;
        b=Yzcd+L3Yxp9z5BzlBiNU3u3oTQw/IOlvPXgwWIRaYbXB8l5pf0c//79ppZRuzLVw/O
         4lm1wZ1fxw/LxZZlqIn+Q4gLzx8KmLzuoeRQo0CSvrGYmvdLkMXBQIgejOlgajvCXpVn
         wxhPV3LQEpyNmF3qHof03+0eYVvR9AqDngUWQltLOj/Ya5Efvaiex7euNPtS8BxSnKf8
         5sd2FdMY9DfzMU/VubzWUBvcb6lT/dL7GBriJSBWuV3Nx8S7ay7Tekp0XuKB0Gbn77nD
         2H2H+uya6+Tnphfuf6P8KNz1pSd8ANewW2tm2EomBrla/iaLfgZLnnXnHJdiMrTcRNt5
         Z59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729619479; x=1730224279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41eqv+v2sxNkPISHr6IXeim2tPShJvPsqYKSkW7kUEc=;
        b=Z98JjOkxl78phQXs8RynsAvmDLhHb7Ui88lO5SIBbklgclGNEGLzBjv2v1vFxRXZ2B
         8gfKusHuN8qSQIJdMRwCZ9U9d/zaEdTXKheaNkxA1lE1bJR3V+a0uOiSMOB0PLTubMgf
         GoOrCJ6a5D31XGsf+5yITinCHmeE5h80BpMG3PVVTmOxKi+mFGLKtMcuFEiQgmlTKbyY
         O9BZg9CrKhSf2NLiUd+5qGxHCJsfTwAEpZ04Hqt9hKJCk+x3Jkp77dFCWvKi9VavKP6k
         TaXwc713kpjiqQd4GOZNLF7R+ae0Wd6zvm32vUsM61uLxbeT/LGPg3ESm8nYoWv2m2zG
         8u6g==
X-Gm-Message-State: AOJu0YzjW2XLCMuQU+iT0QFtNE/jWJhz1+ithODOtyK0stIz+N4CxXHP
	3jl9EEiXFJLYtyQ7sIq2+ip7y1yIzXMTrHcDYbeHSaDe/8mH295I3CRKSg==
X-Google-Smtp-Source: AGHT+IHkK+5tGHmIoNUapAM6yjqZFUyTQfrJwUXVdqK4mXvF/6hcVTRH0Ttv0vMiTMdfUVPf01562Q==
X-Received: by 2002:a17:902:da85:b0:20b:6f04:486f with SMTP id d9443c01a7336-20e9489afa8mr45095465ad.18.1729619478610;
        Tue, 22 Oct 2024 10:51:18 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:f6f1:2f90:dd68:7e46? ([240b:10:2720:5500:f6f1:2f90:dd68:7e46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd56dsm45533545ad.177.2024.10.22.10.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 10:51:18 -0700 (PDT)
Message-ID: <d38404e8-e01e-4dad-99f2-7bce3a68bba5@gmail.com>
Date: Wed, 23 Oct 2024 02:51:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: check PI size if metadata size or below
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20241022163504.10738-1-ikegami.t@gmail.com>
 <ZxfY2IT15o_2vTZq@kbusch-mbp>
 <d5735ddc-a3b4-4204-b8fa-b97566f8a91e@gmail.com>
 <ZxfiADxyL-uZYgBf@kbusch-mbp>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <ZxfiADxyL-uZYgBf@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_105120_062959_3E8E7CDF 
X-CRM114-Status: GOOD (  11.58  )
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

I see. Thanks for your explanation. To make sure let me confirm again below.
The nvme_ns_has_pi changed does not use PRACT as mentioned but still is 
it not okay to change the function only also? (I could understand as 
nvme_submit_io() uses PRACT then it does not work correctly as mentioned.)

On 2024/10/23 2:33, Keith Busch wrote:
> On Wed, Oct 23, 2024 at 02:08:52AM +0900, Tokunori Ikegami wrote:
>> The existing function nvme_configure_metadata() code checks as same as below
>> but is this checking case only okay?
>>
>> static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
>>          struct nvme_ns_head *head, struct nvme_id_ns *id,
>>          struct nvme_id_ns_nvm *nvm, struct nvme_ns_info *info)
>> {
>>
>> ...
>>
>>      if (head->pi_size && head->ms >= head->pi_size)
>>          head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
> This is merely checking if the metadata is sufficient to do PI. Nothing
> to do with usage of PRACT, which is what you're changing.

