Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D7CCD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5pjt0FrMMwit5DYfS92Ak9WBTmgGmBpLNVOwC7PnYW4=; b=gfKT2CCTVKeVeFN/BW7mjkTXNh
	wguEMuQzOJJHic4UJnzyrsjBMzvJLOHh1zOqybqRoqN2h7FtPz/Jo8ZID0A5YRRVjqf0tW17KUbyJ
	/LGCJQPLM5Hr9E+UvlI+U0a83WHn3kLxbCW9W7gSqJV2HbFBQaceudM99NwJQ+kr1TGi8hedYEgky
	3M8zAlc02jQunTOXuO62ikLAycYjBlNBM4jhM2eJ9UQhSH3rgX97C5I2x30/yjsu0Vjwh95KZ61tJ
	WoqH53r+qKeYlCF41LLOiA9pjk3UbcJRg2O/0Qu6l5VBoi1T6sskOpdXsSUrmvHNkqH3lJmULR61x
	5m0fqt6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFmN-00000004M7W-1v1v;
	Wed, 27 May 2026 15:02:43 +0000
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFmK-00000004M6d-0pD2
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 15:02:41 +0000
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-7dcd17e19b6so6647376a34.1
        for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779894159; x=1780498959; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5pjt0FrMMwit5DYfS92Ak9WBTmgGmBpLNVOwC7PnYW4=;
        b=ICQaHxhUnaodOvw7H1Z3zqJ5gKcVQaKcBjHCFa2WF5d0B2TO2MtdgjYZz3PelAwTkM
         ykOr1gskx0OIfXe3hK6BofT/ZM5A4GWNRq/yb3BRX3HhmBCDFnHeYQwZ2+M3c4R0N1N1
         93H4Ad5fo1yVd1JplMqcBiv3kPAAENm1N5xa2enlpZKLxRwVv8Xjemoch6LqockNroMC
         g9mC79SkLjc65voaZnQgb3nIFCy6ltDQl60/CLcH5AuhyciNNGdXfPoIIKn8niOrMgKh
         KNVG1TbISdprPn40jENPinQVBSTi/upqVY4Y3QhZaMWqTpC27+6oE0svnZq4Nv8TzVmc
         EZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894159; x=1780498959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pjt0FrMMwit5DYfS92Ak9WBTmgGmBpLNVOwC7PnYW4=;
        b=UDqBrYuWrGMBDMsxpPa6iWLadm2Wv9RBxTVuVEpT9npFEj+PJWK8pBIK1MkPXmNqLc
         J+dlLqU+COJwahENJhEw0w1Rvl94TtOq/W0yxgwszkGxJG8FGGnd7Rp3h1KPpt9UHavN
         W93Y1U0a3KrbnJiiw/m53mRn9i2kp6vFgyTzHmUU+IlthMLuAmXDRhf6MUYHaVpZ9/Yd
         1LQAldCi6HyMEAseX7wmByr5wloZr/cXoSA5URzG1QSosSM7cEDvXJbIzU23E6dNOBuA
         4iCHvaaotYaT1DbdNvdDw1ekWkBrSODmRnXZKeYXueYpCHIYmUQKlxjboACUIAW4lNk1
         FeWQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GLHuT/KPfWae1Ird8Y/HH81L7cLrqKwMrE+0SaygiTuxwx5b/QeS0xOvvKFAkPFhMu1eLiQejrRWy@lists.infradead.org
X-Gm-Message-State: AOJu0YysMB434xOMgS72iqShlu9/8NpXt8gFBKMGD0QDg0g+QdpKyuGc
	+g1yrA38aYCfsUii4acjjwhMJhEODP0TSI5NOu2ggKnN53XAI9ks8IJl/lD88KFhlHQ=
X-Gm-Gg: Acq92OE5vPDnS/gEkS2wkRaGYyirwdb6PL1CaX0D0ohd+FPN+fCtng8ptLCUp/HP+Nn
	89MyPDfwXEQIuXPgTmEtNtMgACrblb5lWZuSIRJabzuA0VSBDgXcK7VLUajHX8NknnCT6+zs5mk
	TpSfjvsw232UZwzLuL/hjbVqKXd/PCoMYgdPWS7qzYyVhRia0rUT8MUtKj618YbDw2VRTRmHK81
	ZgFA0G1Xtl95sO3xvXodmABplXusoioI7Rlswf/qso6xJn4wneS1+QTzKIP7935CtqsFxNp8Go0
	E3yzIHfBJG/GwktbYCFyacuCKsIbhAsaaMhFnSoE+swlAoVN77gGCH6vq2AdvhCNBW1AA5NnNR9
	an6Fo5Aqw39bE09kkKQkP2dgIm9f/pKTN1I5pRTLhDQ0pLDGLWGGD2Y7glST5Hnspbmo1/TGBrQ
	OZXAcJH0D/lhY7+IIcQaKHiTQBEtW1Tsdo3Wi6Fmbk39KT4Vka8UQ01d8wVMBDRsCatcIpCrGk5
	+bRjti6
X-Received: by 2002:a05:6830:828b:b0:7d7:fbe2:9725 with SMTP id 46e09a7af769-7e5fed4d53cmr15343499a34.5.1779894159075;
        Wed, 27 May 2026 08:02:39 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e60667af4csm11816641a34.27.2026.05.27.08.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 08:02:37 -0700 (PDT)
Message-ID: <19251352-237e-4aaf-93ff-86b3e43bed8c@kernel.dk>
Date: Wed, 27 May 2026 09:02:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: reject completions for requests that are not in
 flight
To: Christoph Hellwig <hch@lst.de>, Chao Shi <coshi036@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
 Weidong Zhu <weizhu@fiu.edu>
References: <20260522153034.2168862-1-coshi036@gmail.com>
 <20260527141909.GA13578@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260527141909.GA13578@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_080240_242686_F9CFC756 
X-CRM114-Status: GOOD (  20.24  )
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

On 5/27/26 8:19 AM, Christoph Hellwig wrote:
> On Fri, May 22, 2026 at 11:30:34AM -0400, Chao Shi wrote:
>> nvme_find_rq() resolves a device-supplied command id to a request with
>> blk_mq_tag_to_rq(), which returns whatever request last used that tag -
>> possibly one that is no longer in flight (freed, or never dispatched and
>> thus with a NULL rq->mq_hctx).  Commit e7006de6c238 ("nvme: code
>> command_id with a genctr for use-after-free validation") guards against
>> this, but its generation counter is only 4 bits wide and can be matched
>> by a malfunctioning or malicious device replaying command ids.  The
>> driver then completes a request that is not outstanding, dereferencing a
>> NULL rq->mq_hctx or double-completing a command:
> 
> I don't think an intentionally malicious device is part of the threat
> model here.  This was added to protect against buggy devices.

Malicious devices are explicitly NOT part of the linux threat model. If
this is a real device, I'd say go talk to whomever made it and get the
firmware fixed. If this is a "hardening" effort to protect against the
threat of malicious devices, then I don't think we should bother.

>> +	 * blk_mq_tag_to_rq() returns whatever request last used this tag, which
>> +	 * may no longer be in flight if the device reports a bogus command id.
>> +	 * Completing it would deref a NULL rq->mq_hctx or double-complete a
>> +	 * command; the 4-bit genctr below only narrows the window.
>> +	 */
>> +	if (unlikely(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)) {
>> +		dev_err(nvme_req(rq)->ctrl->device,
>> +			"completion for request %#x not in flight\n", tag);
>> +		return NULL;
>> +	}
> 
> Although this check looks cheap enough that it should not hurt to add
> it.  So I think this should be ok, but maybe respin with your planned
> commit message update.

Only for the right reasons, imho.

-- 
Jens Axboe

