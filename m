Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3233CC432BE
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:57:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC66E60FC0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC66E60FC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=40hsbWDnWnnNPt9OaLuDxAyaPN227DuAogfgGaJNCnc=; b=go3T6gDyZM8KgrG7JOYLhG3HFa
	D0ebX7WwexVPqBWBjX3c9nuVLi4pGmnzKLTejaTofS99VH7Hg6vUTtOjE+hquSXthp8jucVcSt77W
	Vd8Jpxng3h1I8yOU10iwvNe2x2dBCFse59s8MUgJTcnF9nnHxbTnFVhXZ/hUpKbSOmcZ2vfAICvmY
	aC86SULHRh6LiimvnIEu7dFEGRwqfxbwJYpRTVDlIv3tynntcorlgTtsVH0V1KSWIPsI1TnJslEAM
	RKTZA2vCljgO+RQpRbsKkXKsCP3rHaTflM/+r/osiz8Q4PP2k+cfXGr1sBY57ZtEQC10MJ5pWSVDc
	OlxgFN6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLPne-0065UF-48; Wed, 01 Sep 2021 12:57:06 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLPnW-0065TP-VC
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 12:57:00 +0000
Received: by mail-wr1-f52.google.com with SMTP id t15so4363083wrg.7
 for <linux-nvme@lists.infradead.org>; Wed, 01 Sep 2021 05:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q7eJgsFCDDu//A9dArP6EKPTwZl8/KBOAT5nUM1zqw0=;
 b=nJUz+ZZU8nPlqxi7kba6C7YHEx0EMhWEYlQOpCRYEIWBAyjBNDJ5u5gCOwIahfC83J
 kxdt5JxqB2pGZFWeuNye4jMD3J1e6MRXkEduTMJAonmo4ez9PxSsurAx/l8bEsAraVPr
 gHUOBHIwmvRumOpV1Z+mN9amukg9LuqknzfGekkGwP5312cAuofPqBNBua3KVVgSlLUg
 1zdoxut+kni8K/4kKFiaDlTmHweWsd06fDgHgVwDickREAwegttAx7jB3B4zTHNQM5Py
 D1hlLSXOpR0fe8xrogRU9hNMAW6TG8w7I7AjiBgzjru250v77GWMu1hgQOb20vCde230
 WzMA==
X-Gm-Message-State: AOAM530cOaoD2+0Rx7PX11lxXxPb8ba5SXUYH3cJNh5uR6AJdEzutHr9
 chVqJABYRwWp2Vv3oadQuFCsiqVSRGA=
X-Google-Smtp-Source: ABdhPJyVARQICk5s7BeUyx9feprGFixyA6z896eGw+oVkL4cG/osZ6VxI7vPGdUfxXvfKJpJJyk/tg==
X-Received: by 2002:adf:f08b:: with SMTP id n11mr36381325wro.176.1630501016894; 
 Wed, 01 Sep 2021 05:56:56 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id l15sm21273702wrv.84.2021.09.01.05.56.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Sep 2021 05:56:56 -0700 (PDT)
Subject: Re: Command timeouts with NVMe TCP kernel driver
To: Keith Busch <kbusch@kernel.org>, Samuel Jones <sjones@kalrayinc.com>
Cc: linux-nvme <linux-nvme@lists.infradead.org>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <20210831023712.GA4046@dhcp-10-100-145-180.wdc.com>
 <20210831024435.GA4884@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <82deb992-e42e-a0c1-4e55-0f8108c11dcd@grimberg.me>
Date: Wed, 1 Sep 2021 15:56:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210831024435.GA4884@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_055659_061655_7AA7A6D8 
X-CRM114-Status: GOOD (  11.54  )
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


>> One thing that looks problematic is if 'bd.last' is true but
>> nvme_tcp_queue_rq() fails early after enqueuing previous commands in the
>> sequence. That could cause the io_work to never kick.
> 
> Eh, your observed problem should not be the above: the block layer will
> call .commit_rqs() anytime an error occurs during .queue_rq(), which
> should kick io_work. So yeah, I'll look for other possibilities.

Also, any temporary failure (EAGAIN) should trigger write_space
that will also schedule io_work.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
