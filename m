Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467A3C46CCD
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 13:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bt//LsY7Q7z89FsCe6tAsWpOtLN8NTtcLKIPMtXnaws=; b=m6aH79tKGNAv/M0TEXseABSMYe
	krE/aW2j+o1GbiyiQwlF9VkjCpS81lYufIfIxtXTsdae24ZlyS2e+EYsqMBIKdvfiULDDt2cltSyY
	LeZwNQDOrCPXyi1k68V43/BN1z1ttYlUqKQ5xqzvqD7kG6OlS3M863f7Y7+YzXiJjF1r5EQKHih+z
	bTBlhgkDUV7/vKZV/7diKG27tz1iK+bnEcJ7KzjNDU5V6jjoWzujcSEGMNrjzF4eYy51xescpVDeK
	Jvsa4kIF8C0dmsdM5u4i2ZmVfYgnNSknfJYD/JzfPLRhptgt0lLaQ9fSYeZ55N0ih2bpZ/o4jmFZ3
	nhm8qhxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFaXt-00EFnV-1T;
	Tue, 19 Dec 2023 13:54:05 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFaXq-00EFmJ-1X
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 13:54:03 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c192f488cso8920565e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 05:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702994040; x=1703598840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bt//LsY7Q7z89FsCe6tAsWpOtLN8NTtcLKIPMtXnaws=;
        b=CTpl/ph38+7Fcebs66P4cX9CGpikFml/GuCnL1G1OxNE7JyEMYo0AVjx6QTzqHyoZq
         WpaKOpUpmnEVIOMkCAAQChKfVC3fW+O0kllNto7abVCCLmoyLEN3TgHX795qV7OtT7sz
         9aRP2mtT5BFaR7xFXHosfGOMOXLfviIr6LHotmIogQL/tn9mSyEIF9oTcXyfK0vxvmuz
         wdZdpLVLQxAg3Xgw29BgItx71uh+mA1yX88bvnRMUscGLYgsXa4Y2/BcOqJnu5jkTVlJ
         p8qSQnCTeng/JYVbaMk00jkOYZxIIBBLo+hN0+hj9lkfwNXWtbnoygzDk88IYShurQ9L
         ErIQ==
X-Gm-Message-State: AOJu0YxAfk3JtkUp2triKyCyFSRvhyc0ieF9MmOY4VtN+f6GJHN5wpA8
	mIk7VehRyzYiUb2Ixk9L2++x9HzZPF4=
X-Google-Smtp-Source: AGHT+IFQQ4aozALcgcIC6skGJ7CGJNzLSGE/BonhpgNVXnSQWkJ2KyoaoTE6AiMlAesB0zt3ndVKyA==
X-Received: by 2002:a05:600c:524e:b0:40b:2708:2a52 with SMTP id fc14-20020a05600c524e00b0040b27082a52mr22111659wmb.1.1702994040549;
        Tue, 19 Dec 2023 05:54:00 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0040c11fbe581sm2947317wmq.27.2023.12.19.05.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 05:53:59 -0800 (PST)
Message-ID: <ee662fd4-b33d-4d81-8e80-1b2655505e8d@grimberg.me>
Date: Tue, 19 Dec 2023 15:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: fix sleeping function called from interrupt
 context
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>
References: <20231215143136.252497-1-mlombard@redhat.com>
 <ZXyMCcq7I0ZBNU-K@kbusch-mbp>
 <CAFL455nBx_tRj3QDVXwU2pReoryF3bVfMvD1O+4YHDZzWnzS2w@mail.gmail.com>
 <ZYCE0Tam0HOVfVI_@kbusch-mbp.dhcp.thefacebook.com>
 <ZYCH8Hsn4UI_7j3-@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZYCH8Hsn4UI_7j3-@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_055402_511374_5C7B7275 
X-CRM114-Status: GOOD (  14.28  )
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



On 12/18/23 19:57, Keith Busch wrote:
> On Mon, Dec 18, 2023 at 10:43:45AM -0700, Keith Busch wrote:
>> On Mon, Dec 18, 2023 at 04:11:38PM +0100, Maurizio Lombardi wrote:
>>> p'a 15. 12. 2023 v 18:25 odes'ilatel Keith Busch <kbusch@kernel.org> napsal:
>>>> What async event occured to cause this? It looks like the only AEN
>>>> handling that cancels anything is the FW activation one, but that only
>>>> applies to fabrics, not pci. Still, that AEN hanlder sets the state to
>>>> "RESETTING", but we only cancel work when transitioning to "LIVE" from a
>>>> CONNECTING state.
>>>
>>> It looks like the stack trace is a bit imprecise.
>>> It's not the call to nvme_change_ctrl_state() that triggers the error
>>> because, as
>>> you correctly noticed, moving the controller to the resetting state
>>> doesn't block.
>>>
>>> The problem is the call to nvme_auth_stop().
>>>
>>>          case NVME_AER_NOTICE_FW_ACT_STARTING:
>>>                  /*
>>>                   * We are (ab)using the RESETTING state to prevent subsequent
>>>                   * recovery actions from interfering with the controller's
>>>                   * firmware activation.
>>>                   */
>>>                  if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
>>>                          nvme_auth_stop(ctrl);     <----------------
>>>                          requeue = false;
>>>                          queue_work(nvme_wq, &ctrl->fw_act_work);
>>>                  }
>>>
>>> void nvme_auth_stop(struct nvme_ctrl *ctrl)
>>> {
>>>          cancel_work_sync(&ctrl->dhchap_auth_work);
>>> }
>>
>> Oh, got it; thank you for clarifying.
>>
>> In that case, let's move the nvme_auth_stop() call to fw_act_work. The
>> AER handler doesn't depend on auth_work being sync'ed.
> 
> I also want to mention nvme_auth_stop() ought to be a no-op for PCI,
> right? The nvme_ctrl struct seems a bit overburdened at this point, I'll
> take a shot at splitting optional transport specifics out of it.

Exactly what I was thinking. However we should make
nvme_handle_aen_notice() allowed to be called from an interrupt
context even for fabrics, so we should move it out of there anyways.

