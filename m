Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E7DC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 18:48:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6302D61206
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 18:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6302D61206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HKjlxfeEWeRBgDDRrbrcO5JYFjOeSNZPmeXMGHX1Jjc=; b=nT29303iI4d/gKZUlF16TYZN+
	S+ierz2XyIWYwDsY4WdR8n77Tnvb6o0aaJcaxi6deBVk79xsiDwMkqqyjgXcIBOc8kXsFSH5SdCxN
	kOhEJLJA0E0nrMpgijiBOW3iej+b8F5uce41Pe1hfsGQTa3IXJ7TCcMgCuA77c/gFyE21jQZ8Wdt0
	hMqLBlKp83x9dKZUWDy7io8dmV+pSki//oIV3F7IQXEfEugdxdf81GX6Pd3uw1s2qjdfF0Npd+I9w
	3OETKg/t0WiMHZ1wDusXSo3Vv5Nt5+mIBQl3CVuGO153M21togFLlRVWeKjYUVP+HOCLZy1bpH6es
	kPN/aVcIw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhGNY-006Ass-3J; Thu, 13 May 2021 18:48:12 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhGNN-006ArP-RM
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 18:48:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=PyqVZjhU3w3jlGH8tofKMsn18YbEqFAInYWIcup7lgc=; b=svgZOCzNaov+UeLujPlypgNon2
 wnNOXKPhkDRFj7MK4PmA5UyYFENJ9scO2Cw1YUgXGuEKbIpT03QqPGuREM7wn+oqSSm+4aWBKrnuC
 9lsQG9ZbgyhzKDaUhQUMir2ZhxWdxqam2dZ0IpUKeBCDB3WixFgm1wSm4li1yWILOBjLJyeyqqKD2
 JteX9PCX4Ie1h4ECOfrPLnqpvSs+H9HRLSlDBVk/6tch1JhTTvmpH7XfizWqWiuKA0dztwOUtJFwq
 42f7sLZo2DVoivAB1fr6lefAi1Gidb/pUUNjqy7kbw5XUUqSTzHyq1rtS8f8SNkl/9k5N/efBHnpc
 Y7aVQSUA==;
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhGNL-00BRs8-7E
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 18:48:00 +0000
Received: by mail-pl1-x62b.google.com with SMTP id b21so14916597plz.0
 for <linux-nvme@lists.infradead.org>; Thu, 13 May 2021 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PyqVZjhU3w3jlGH8tofKMsn18YbEqFAInYWIcup7lgc=;
 b=KaDbEFpbTmQwJ78uwOgMpBb8HgWbHi9GXs7DXWgNGcTC4yyVgDasPWvb6ZCh59GMIT
 aqgkFIOS0/4a1vdRWkDi1IkrSLFcSVAYytJOhIQaLMtHLACzrA38/GLCLH8ryNJZyGWH
 lRrWp5sDXTM1AFRsz3lVcGlOTXq8rOWMIEg3ZNUaEaE5r0utPu9yzYeI1zLpPUCXsHAc
 76IVycFznz/D8UvT/UbqfwHZ/FsuxO5rci4Dt2gfRqa20L6V5GgL41CG8yHoKTNumk6V
 /1qc9RpdqS5bgIWPeKtS6HRSNUhlLYnXF/yVVdjA4FRdWLmqivr1eadmIrFGfOL7ljKq
 GZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PyqVZjhU3w3jlGH8tofKMsn18YbEqFAInYWIcup7lgc=;
 b=LYq8KpO6n1dY1jrfBmk+YCr1G8JjGlauf0XqsM8ClYY2mIRlcvjx8ghCJ0Q80nZfgs
 9T4VazFUNE5rN/ccn7x0y1hcSBDpHbv8Sz1szOyeKUUy21x7behWWMS5G2U+fa0OFW8U
 jCgtKOsSgi9hrhLAnxjU/kcDSqvhrDTzdl7ThztjyzglR2mBd07lpcUHzB/4LGOvFua8
 fZNXjtlKBzL156y6MqSVvzsHnLNcjFEf4p6Oco3YfImQ7SqookR9JGHEkBc/er67EKk5
 pZeOzG2oEGuh1QpG8CjgDrwtHFp2hICyYuByx53X2Tx1mMS18+eTKVC5W7mBR76dLeAz
 b+NQ==
X-Gm-Message-State: AOAM533X9U7EDVaYSha9Iyb7b2hPWOf5S6Yji3N57AkG5nIOLgD/tAen
 WaoMKeqrglwKDGBFohlCkZo=
X-Google-Smtp-Source: ABdhPJyhqv97qDa+bdraDFsRL1P4vK8MiJCW7EIiexhPvc25HFsYbWT8v8+Kqx8KLHbgFub/CtkPnw==
X-Received: by 2002:a17:90a:5d8e:: with SMTP id
 t14mr47422429pji.85.1620931677449; 
 Thu, 13 May 2021 11:47:57 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id h21sm3189947pjz.4.2021.05.13.11.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 May 2021 11:47:57 -0700 (PDT)
Subject: Re: [PATCH] nvme-fc: clear q_live at beginning of association teardown
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: stable@vger.kernel.org
References: <20210511045635.12494-1-jsmart2021@gmail.com>
 <601fa5a1-e52b-edf1-f32e-b1c454e23758@grimberg.me>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <f26aad29-aef7-6fd9-979b-a0bfc4f46a06@gmail.com>
Date: Thu, 13 May 2021 11:47:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <601fa5a1-e52b-edf1-f32e-b1c454e23758@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_114759_304632_F0E09FB5 
X-CRM114-Status: GOOD (  13.62  )
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

On 5/12/2021 4:03 PM, Sagi Grimberg wrote:
> 
>> The __nvmf_check_ready() routine used to bounce all filesystem io if
>> the controller state isn't LIVE. However, a later patch changed the
>> logic so that it rejection ends up being based on the Q live check.
>> The fc transport has a slightly different sequence from rdma and tcp
>> for shutting down queues/marking them non-live. FC marks its queue
>> non-live after aborting all ios and waiting for their termination,
>> leaving a rather large window for filesystem io to continue to hit the
>> transport. Unfortunately this resulted in filesystem io or applications
>> seeing I/O errors.
>>
>> Change the fc transport to mark the queues non-live at the first
>> sign of teardown for the association (when i/o is initially terminated).
> 
> Sounds like the correct behavior to me, what is the motivation for doing
> that only after all I/O was aborted?
> 
> And,
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

source evolution over time (rdma/tcp changed how they worked) and the 
need didn't show up earlier based on the earlier checks.

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
