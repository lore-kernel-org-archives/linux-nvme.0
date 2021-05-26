Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456DCC2B9F7
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 08:41:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54C2613B5
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 08:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54C2613B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YxLC0zPc0SbqDoPyASZ+04OcuY1UeoYjlvSDi+0fAkI=; b=lxE6rb2LmUsNyCROnuLi0yVeuO
	j1/KhuSOT6o+A+UL2KQazIYk/3bUBRsS1m9pOn+GIcznCY4e6/LlS8ogOph8EdKSWSxMme6ftDO1c
	9Ym0gLQBc2lOM8nwVcTdo3wMZeCm00T7xR5BhRaMr/A3qSTpsZcwAr0ByiqMPBdJ9SkROadRGgV/k
	x3/6tZL9a8ntWRVAL/Prq0whK4wm/27ufA3kZ1oCufJn1Fc82CzNZxiTrh9Ko43STvjc9+5exHnsq
	Xbw5sbwmY2hB6WyNt8MIfwpiHwIMHF5cwgHa0EHBC/2MzefAmgNe2Ectg2yH5qBbXiN1WEht4NfIJ
	xTsfIaAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llp6Q-00CX5G-TQ; Wed, 26 May 2021 08:41:22 +0000
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llp6O-00CX3x-6T
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 08:41:21 +0000
Received: by mail-pl1-f171.google.com with SMTP id a7so265800plh.3
 for <linux-nvme@lists.infradead.org>; Wed, 26 May 2021 01:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ot2aady08af0JCOof9zx1VDllF1phCPqIA/QYJ7uoTo=;
 b=SzTv0Dc75ofgBX0DLUYjxBOiGroVK+LfCMqI5WPRioEzI2FyfManNF31p+vMTE9zri
 YCWkaRDQJaF0560dB9pC/OQWEhe9skYJreRw6KjS0HHF4Ti/upp0jTmIDjWTurMtSEs+
 CaGxbowgGI7UqlCgNY4fyyG/d+jyCjBX5sHTUbRQMqRw9cSTWjIUXWVMZRKIRC3McqmQ
 ch4dO66ogMXU/Z/DvDVaJNOf/QgPTzq7V7m/kecTNF8Vt5Bu/qHFJcQ6H7IzOhTnaR3/
 Ukzdnd3zqSMkq/oKVJnLIgFezFiaPcsOnoNQD9JA/ByHI5FZI1YjyY9Zs5N7X2X51wNO
 OXKw==
X-Gm-Message-State: AOAM531IRxLUEqe36eh6yd3Uwbq4qs3NPWM8xvPc6VoLf6sQJ6/06b52
 ppKTZSM2bmjfCHgqNEtQiEQTXdTNnb4=
X-Google-Smtp-Source: ABdhPJzGf0Oj5/6iwwgF+GZqraXK4X7XZc9CCsHRwPMrt9ohkmSr9h48I698miJWAprSm7nBJQPlow==
X-Received: by 2002:a17:902:aa46:b029:ef:8a47:ca53 with SMTP id
 c6-20020a170902aa46b02900ef8a47ca53mr34975704plr.74.1622018478909; 
 Wed, 26 May 2021 01:41:18 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3726:dadd:2909:e6bb?
 ([2601:647:4802:9070:3726:dadd:2909:e6bb])
 by smtp.gmail.com with ESMTPSA id o17sm10205741pgj.25.2021.05.26.01.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 01:41:18 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] nvme: code command_id with a genctr for
 use-after-free validation
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <20210519174340.1144806-5-sagi@grimberg.me>
 <57030aa5-976c-8d0c-b6ee-7c69fb5f807c@nvidia.com>
 <20210526003900.GA3704949@dhcp-10-100-145-180.wdc.com>
 <BYAPR04MB4965873E107F598F6BD95B1386249@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2426b42f-b345-2689-3bd8-8a24d6670ac2@grimberg.me>
Date: Wed, 26 May 2021 01:41:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965873E107F598F6BD95B1386249@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_014120_295329_1DA654F1 
X-CRM114-Status: GOOD (  26.11  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> The bad controller should be fixed.
>>>
>>> In the past, I've sent patches that check that sqid match in nvme cqe to
>>> protect faulty drives that might send
>>> the completion on a wrong msix.
>>>
>>> My patch wasn't accepted since it added an additional "if" in the fast path.
>>>
>>> Now we're adding much more operation in the fast path because of buggy ctrl
>>> ?
>> I shared the same performance concern on v1 on this series. I haven't
>> been able to test this one yet (only have emulation for two more weeks).
>>
>> Hannes says the bug this catches happens frequently enough on TCP. If we
>> don't catch it, we get kernel panic or corruption, so we defintely need to
>> do something. Sagi correctly noted this type of bug is not unique to TCP
>> (or even NVMe, for that matter), but if there is a performance impact on
>> PCI, and no one so far reports such an issue, I would still recommend
>> this type of mitigation be isolated to transports that actually observe
>> invalid CQEs.
>>   
> 
> Please do that if possible.

I disagree with that. The original report was about TCP, but that is
pure coincidence as far as I'm concerned, as I indicated before there
is nothing TCP specific about this.

Today we don't protect against such a scenario. I originally dismissed
this issue as we should probably address the a buggy controller, but an
argument was made that a buggy controller should not be able to crash
the kernel and we should have a safe-guard for it, which is a valid
argument, but this is not the worst that can happen, this could have
caused a silent data corruption with a slightly different timing. So
it seems absolutely appropriate to me considering the possible
consequences.

The way I see it, we should decide where we stand here, either we
continue to ignore this possible panic/data-corruption (which I
personally think would be wrong), or we address it, and if we do,
we should do it in the correct place, not limit it to the observed
component.

As for the performance concerns, I'd be surprised if performance is
noticeably impacted from 2 assignments and 2 optimized branches.
Also the overall nvme_request did not grow (still 32-bytes, half a
cacheline). But let's see if measurements prove otherwise...

Before patch:
struct nvme_request {
         struct nvme_command *      cmd;                  /*     0     8 */
         union nvme_result          result;               /*     8     8 */
         u8                         retries;              /*    16     1 */
         u8                         flags;                /*    17     1 */
         u16                        status;               /*    18     2 */

         /* XXX 4 bytes hole, try to pack */

         struct nvme_ctrl *         ctrl;                 /*    24     8 */

         /* size: 32, cachelines: 1, members: 6 */
         /* sum members: 28, holes: 1, sum holes: 4 */
         /* last cacheline: 32 bytes */
};

After patch:
truct nvme_request {
         struct nvme_command *      cmd;                  /*     0     8 */
         union nvme_result          result;               /*     8     8 */
         u8                         genctr;               /*    16     1 */
         u8                         retries;              /*    17     1 */
         u8                         flags;                /*    18     1 */

         /* XXX 1 byte hole, try to pack */

         u16                        status;               /*    20     2 */

         /* XXX 2 bytes hole, try to pack */

         struct nvme_ctrl *         ctrl;                 /*    24     8 */

         /* size: 32, cachelines: 1, members: 7 */
         /* sum members: 29, holes: 2, sum holes: 3 */
         /* last cacheline: 32 bytes */
};


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
