Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6B7C76188
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 23:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZuGDkRSuRTT9UsA5SHVTSk0YiI61oZLvfJVCKwgMg2A=; b=hB4ckbS2shB0U2lJy+8kHthvWW
	/vWaDyWwkkq6LgA2MVKtau27GUCtAQ8QhOxqo2a8Dmou0Wg5BgGQf4Cq3pADhYZMTQRnviL5X4l+0
	oXFZ9GpYLkNQD4csPgqWNeldt7hTYAVkubgL8eE2P+Se5NCAqgEzyZdnJvr3RvKkxOKRfHXVgBUQ+
	8rfGCsI3lvHS4rQsAn8WKJahkUsFcyz03mLmOQxTK+7bWdnOLuDdmDGo2PddKC6GmhVpF6M+XuQVp
	pAGI5tuqx+onHH62IHk38BOdiFLm29lLEBhOcmDKo7mpjHNprTytrkr8gBn9+1L08t0nFQP9LHWKW
	v5ed6pSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjTcU-00HBWE-2P;
	Mon, 03 Apr 2023 23:29:50 +0000
Received: from mail-ej1-f42.google.com ([209.85.218.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjTcS-00HBUz-1s
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 23:29:49 +0000
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-947a47eb908so32297766b.0
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 16:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680564583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuGDkRSuRTT9UsA5SHVTSk0YiI61oZLvfJVCKwgMg2A=;
        b=UE1CDZehA26wsG4zgjjzGvhSnXFwbCsAXhwLS8KlVVLT7ZUs6hUJ61bfQr6vnrEWL9
         gJvG77F95Cjux6lkrs8iob/pkvUZMSzTCjYhKL1ck3yWm5dw/VcXd+JP9uTJm16jezwN
         hDTflj/3Lb7XaYCoiwWYtiDXOTPC0Id6jp72r70hi0FuONHpKK3a0WhR/jxuLs9tlNcE
         rXdALRW8Bv4z8YRH7w8AOebYCx4jDSx9FsHBg25dn9MzC/2SofpiKJRJzFTzZwxuyvb0
         RECVhXtm3igInwVHmtBDIunNSSyLXK1gkhQNq7iH0+K1by39AO2vgp/XT6qREY6i5TyS
         7mmA==
X-Gm-Message-State: AAQBX9dw8mgVMxKnWyNdBgqJdO1h8xV8OyzcjAKJs5JzpSJeLqSNnhDg
	HGboAsVGiL6kbOXQ6DLYVSo=
X-Google-Smtp-Source: AKy350ZOOMBGLxk5mV6h09mypoNZg1Fqiha2LvIrsiQ+dsaGiEydYoTr2gQCSkd0ic80AgRZfGmCEw==
X-Received: by 2002:a17:906:189:b0:92f:27c2:13c0 with SMTP id 9-20020a170906018900b0092f27c213c0mr286005ejb.6.1680564583344;
        Mon, 03 Apr 2023 16:29:43 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id qb34-20020a1709077ea200b00948f41af90dsm356004ejc.166.2023.04.03.16.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 16:29:43 -0700 (PDT)
Message-ID: <588e5542-9076-d1fe-c1cf-ba60ef3dd1d5@grimberg.me>
Date: Tue, 4 Apr 2023 02:29:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC v3 1/1] nvme: add passthrough error logging opt-in
Content-Language: en-US
To: alan.adamson@oracle.com, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de
References: <20230331221823.2806192-1-alan.adamson@oracle.com>
 <20230331221823.2806192-2-alan.adamson@oracle.com>
 <40dba1f3-8307-ca1a-ad6f-c80df87e0344@grimberg.me>
 <ca72677d-932d-29f6-5260-0b0d05fd6584@oracle.com>
 <132431e1-6c77-4e4d-1d48-fbb0bd4dc5b6@grimberg.me>
 <935faecc-e000-3d7a-71ed-7517b1f4c299@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <935faecc-e000-3d7a-71ed-7517b1f4c299@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_162948_622152_91166C98 
X-CRM114-Status: UNSURE (   9.39  )
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


>>>>> +    if (!nr->ctrl->error_logging)
>>>>> +        req->rq_flags |= RQF_QUIET;
>>>>> +
>>>>> +    memcpy(nr->cmd, cmd, sizeof(*cmd));
>>>>
>>>> Question, if we already introduce granularity to this setting, why
>>>> not per-ns? why only per controller? I'd think it makes more
>>>> sense to do this per ns. Will also remove access to ctrl in the hot
>>>> path...
>>>
>>>
>>> Meaning we should have both:
>>>
>>> /sys/class/nvme/nvme0/passthrough_logging
>>>
>>> /sys/class/nvme/nvme0/nvme0n1/passthrough_logging
>>
>> No, just the namespace logging, why would we need the
>> controller as well?
> 
> For Admin Commands?

Yea.... you have those...

