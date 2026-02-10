Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A7AEA3F18
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 22:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o6sy4uuXvCbNviIUj/GXjxaghsA7uqLm97sRPMmTTdk=; b=G1lxJuSiuOhvPdIJmnsXNlqZiH
	BpxveFQwlde3OCa73Dny5M/4l5EUIHDTaWCDOsG3QTsnLvR68sYH7EKqVyT1B+e4DzLMd4H6XFuZG
	oqFRlXOSq1zd5+xaynRL95zo4IJeC6w6KvdMZnLHpfDgF8P5X5WMIZ6VejDkWJfxR7BX0fp+aX+hS
	lqD7DsxZY4stPi6b0DxR85H2S5WneJOqvjFgU7AEBg/oowFLEV89yTvUz3c/vifTJTS7dw5fR8Df4
	nRakmMYD08UOHp7tbleCvmzKWINrYNqiBS/v0Y/sWhHC8awDPQ2x+YeuAr65nextYm5sbt5X4cCWB
	JCjufmgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpwXp-0000000HaWo-3wI1;
	Tue, 10 Feb 2026 22:49:21 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpwXn-0000000HaW4-1ayL
	for linux-nvme@lists.infradead.org;
	Tue, 10 Feb 2026 22:49:20 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-50335b926c2so11438421cf.2
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 14:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770763758; x=1771368558; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6sy4uuXvCbNviIUj/GXjxaghsA7uqLm97sRPMmTTdk=;
        b=lOpP8jGTKhaR7xt1Z74O78iDscg3MNNQY6xTVhheqH3HTlURcR7FB/0tJz1ZqHmzYm
         SFXE77f28ZUI7n+bSLuM7c/MCFhqa5CjZkSSM69BuzZr8pDL9eTzpviiezeLGEpO+2WP
         tHXzLQl/KyzrDaRRv7iDkt0XiBq3EOrhKz0fxMGNP5CGLlo/ge2mcpb36YBcFgG/cBUs
         w0OdV1SbfIis/Emzbat59vmM9ooAnbdLsEnEybp6M0ipQ3NohDbwwyWBkIGgEpxaz27f
         VjYdkKJTPe18YpAp+T8F8QDHmnWg3POXf/U+qfc6J7jbn8SxMXA7N6dW5SQzcQLxDMCY
         dtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770763758; x=1771368558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6sy4uuXvCbNviIUj/GXjxaghsA7uqLm97sRPMmTTdk=;
        b=BY2rmt35UrVYkFSeBYyE5C8SGJHhGDI9kFIMghW2D4tlUgjjzzEKIxWMCFUkIcob3z
         FEXasxeC/P8TKGP+8LTkYgQTUqQCGT5VDzVpRmN6z51pPBpVcB1KDi/2ApbeSxyj2weF
         cSf5LLGH0OjksyYuZ4KveGJhcOd6dTVnEkwDMEXZ+VnrBQ6EL/nM3B1/nAen6K7JPIC6
         jyLZMrC3x+E8R7Ikx+flyrgsb1vHDg3Otl8y9SDDh9QhvGLeRQYsq3pdxm2aioINlKEa
         mr380n6TjRURBpx9RQ+qEumNKpVKtcMwtf/44f8t6aePYImJPH2N7JD5EEtAfNzmaLAo
         DL3g==
X-Forwarded-Encrypted: i=1; AJvYcCUearDBOCDvAO6ccGV+lCZB1ZeXw1AXmm/gUyBkGuSdHHCiTeaSTSyowcA2a5FuYfc4q0oZpDYuhJml@lists.infradead.org
X-Gm-Message-State: AOJu0YyVVfI5DldcaK2e9c0P61z3J44M57bqOd+9bY8S1LF/288IVy2M
	9bwsQ/r5Fl+JTUSSlrkkMF83JaEp3Wyb5U1xaXPsd2ESaq/CzPkt2E42
X-Gm-Gg: AZuq6aIBfP3GhrQoEQrbEewMTub3j4RhUCCMgQsWfDGIZ0mxOyHku+R+SGiXaUG5NlM
	oqEsJR8EEbnBbAxJfg4SyR2tl68fFUQ4/DROTJHyBjAGVLmSem6WLynzpHS6aneT6+fno3Yp9sf
	VtG/r8+tLQcplXMsvDK79YRryi5Romr+cQyNvEmZsM5msRNfsYe62+MsHYBiXQPCmki4iXulckC
	wWopQq8K6pNM3OmfSqU3GHdR4qQ3fo1cszRmka7IGPnVP8oVg/0dcJ1dFA4/5cqgTH9la7s1duk
	GgY5wLfOWIBMazazz4g5pzjw7zPf/F8Ip7ogrLfY/jBSYjfrYSF0vgTCBgN5IlfN6WRRWINsoKt
	yHG0q1zm4ic7oUKocQKnExp2HNuwygb32KtApixbjzmUHmavWfU2kg22i1/7FQGMJBWPCZqAzOH
	m2ZBjEG5TAh1KyWsiBmkQn1TlFM/cCOdsAIsu/Uh0vx2M=
X-Received: by 2002:a05:622a:15c3:b0:4f4:de1a:7a83 with SMTP id d75a77b69052e-5063986a990mr238726291cf.1.1770763757859;
        Tue, 10 Feb 2026 14:49:17 -0800 (PST)
Received: from [10.69.50.72] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc7f559sm405926d6.1.2026.02.10.14.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 14:49:17 -0800 (PST)
Message-ID: <5f3c9cf0-7fee-432a-b6c5-44fb2acb0b1d@gmail.com>
Date: Tue, 10 Feb 2026 14:49:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] nvme: Implement cross-controller reset recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-9-mkhalfella@purestorage.com>
 <05875e07-b908-425a-ba6f-5e060e03241e@gmail.com>
 <20260210222732.GQ3729-mkhalfella@purestorage.com>
Content-Language: en-US
From: James Smart <jsmart833426@gmail.com>
In-Reply-To: <20260210222732.GQ3729-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_144919_435495_7D2A0606 
X-CRM114-Status: GOOD (  18.26  )
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

On 2/10/2026 2:27 PM, Mohamed Khalfella wrote:
> On Tue 2026-02-10 14:09:27 -0800, James Smart wrote:
>> On 1/30/2026 2:34 PM, Mohamed Khalfella wrote:
>> ...
>>> +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ictrl)
>>> +{
>>> +	unsigned long deadline, now, timeout;
>>> +	struct nvme_ctrl *sctrl;
>>> +	u32 min_cntlid = 0;
>>> +	int ret;
>>> +
>>> +	timeout = nvme_fence_timeout_ms(ictrl);
>>> +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
>>> +
>>> +	now = jiffies;
>>> +	deadline = now + msecs_to_jiffies(timeout);
>>> +	while (time_before(now, deadline)) {
>>
>> Q: don't we have something to identify the controller's subsystem
>> supports CCR before we starting selecting controllers and sending CCR ?
>>
>> I would think on older devices that don't support it we should be
>> skipping this loop.   The loop could delay the Time-Based delay without
>> any CCR.
> 
> I do not think we have something that identifies CCR support at
> subsystem level. The spec defines CCRL at the controller level. The loop
> should not that bad. nvme_find_ctrl_ccr() should return NULL if CCR is
> not supported and nvme_fence_ctrl() will return immediately.
> 
>>
>> -- james
>>

I would think CCRL on the failed controller would be enough to assume 
the subsystem supports it.

I'm not worried about the coding on the host is so bad. It's more the 
multiple paths that must have cmds sent to them and getting error 
responses for unknown cmds (should be responded to ok, but you never 
know) as well as creating conditions for other errors where there will 
be no return for it - e.g. other paths losing connectivity while the ccr 
outstanding, etc. yes, they all have to work, but why bother adding 
these flows to an old controller that would never do CCR ?

-- james

