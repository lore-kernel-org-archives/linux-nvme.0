Return-Path: <SRS0=Lvqr=QB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A08C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 10:21:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515F360E97
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 10:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 515F360E97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kHMS0JVyYmxNfkDzxHmZ2mLNKPke2fhCv/KHFKGfIQw=; b=PT+ezalQWEjWJ8BDVtQ/cQIvE5
	qBqgvY0z3yzHTGUSblObu/yVY9NmWtzyERXTdEXe4/adzYhEuUcO/A3cpR8/j6DlrDREoGinjYhEy
	wzp4jqJCifmg/hbkpSK5UP1VdobgNj3fw8eJOWY3Lgr79FmbDVyk78kltW7NPzRS3+qrV54SNVWpk
	O9Z/Wr74BcaT3XC43GbM8afH7r3jg0NSdqiKxxa+cogi052wfyv0SjOFCtHJBs9cMXyxwiHnW15QH
	jH3GaA4FPcSjdV9MP83DLjTPqrRiNSZPRsWr+6TWScXp3ml20vX3IbcYfNIXxqwMR0vW5IdSGqGiG
	6zj4hvng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmCdK-00DW82-Rw; Sun, 14 Nov 2021 10:21:10 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmCdC-00DW7h-VI
 for linux-nvme@lists.infradead.org; Sun, 14 Nov 2021 10:21:04 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 n33-20020a05600c502100b0032fb900951eso8066299wmr.4
 for <linux-nvme@lists.infradead.org>; Sun, 14 Nov 2021 02:21:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kHMS0JVyYmxNfkDzxHmZ2mLNKPke2fhCv/KHFKGfIQw=;
 b=aEhPEHGH+yrcewx80KAXw7VY/wemSgNNef9RfUxnhXuOCgt4SeD9QQGxPCA2VIFZBu
 PBKOD8umrLzrmQ1yRAnzvT9RVwyVwI09PWTG4ksdhzzsVgK9XwkC8UIF4GutEebnReZ4
 0k6OvDHvqir2Aj6fGMDQR1/sPU7TRmnYzyuBV9VEPgr2eg1HgA4dVOlmrs2JtXWqCkVc
 IXWOkSFc8Mynnvj2fpUh2v3gb1907vHf5CHkgmwVAJc6FasFq74JqyuYt31yh9oR9oOs
 IGbkgGeWBV0rT4UF1erDotMi8wc64eQoaWYTDqPdKyisxVf7R3/WVwvnKLmrNXI9Ybrj
 EY6w==
X-Gm-Message-State: AOAM531T7h/3yvzZ+w5Z9CgcAC+GuCRAo8qxEHWMwZwPQQ0fyUDFQDm+
 uzn4uztsIAqoaLD0HWkjE7xVvJ4MYr8=
X-Google-Smtp-Source: ABdhPJxM20t4vGZIXVPtEgmqeRXchElGYFQF3S1R+nIYJn2Ct9sFC7hdr9gCelQN7n3Tmmq1Qk53MQ==
X-Received: by 2002:a05:600c:6022:: with SMTP id
 az34mr33695706wmb.22.1636885259655; 
 Sun, 14 Nov 2021 02:20:59 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h18sm11683551wre.46.2021.11.14.02.20.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Nov 2021 02:20:58 -0800 (PST)
Subject: Re: [PATCH 1/1] nvme: fix use after free when disconnect a
 reconnecting ctrl
To: liruozhu <liruozhu@huawei.com>, linux-nvme@lists.infradead.org
References: <20211104071332.28952-1-liruozhu@huawei.com>
 <20211104071332.28952-2-liruozhu@huawei.com>
 <8165ac91-3ed1-f0c4-16d3-7e6741a610fb@grimberg.me>
 <88268d9e-92bf-83ee-13bd-8de2d975e669@huawei.com>
 <910fd696-250b-b8a6-8b89-62a7fb16a402@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c85b1040-f92d-10ed-5ba9-7da445e2ab9f@grimberg.me>
Date: Sun, 14 Nov 2021 12:20:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <910fd696-250b-b8a6-8b89-62a7fb16a402@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211114_022103_056940_D89F8B72 
X-CRM114-Status: GOOD (  17.09  )
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


>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>> index 838b5e2058be..752203ad7639 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -666,6 +666,7 @@ blk_status_t nvme_fail_nonready_command(struct 
>>>> nvme_ctrl *ctrl,
>>>>           struct request *rq)
>>>>   {
>>>>       if (ctrl->state != NVME_CTRL_DELETING_NOIO &&
>>>> +        ctrl->state != NVME_CTRL_DELETING &&
>>>
>>> Please explain why you need this change? As suggested by the name
>>> only DELETING_NOIO does not accept I/O, and if we return
>>> BLK_STS_RESOURCE we can get into an endless loop of resubmission.
>>
>> I just added the handling of the DELETING state here, did not modify 
>> the DELETING_NOIO case.
>>
>> Thanks,
>> Ruozhu
>>
> I'm not sure if I explained it clearly, my English is not very good.
> 
> If you think there is still a problem with this patch, please tell me.

Naa, re-thinking this I think it's reasonable to complete the command
for DELETING if the queue is not live...

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

