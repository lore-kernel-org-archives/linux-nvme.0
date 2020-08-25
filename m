Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FA8C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 15:36:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439BB20782
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 15:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gnol0MQ9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DsDGVeH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439BB20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uunJO36Dj2SscrxHVQB2ECRCzT96oM8bZM3ItFkFMiU=; b=Gnol0MQ9cnEVz7djtns07HL1y
	N9+/T35Xq3fe/SEy/G8ikkI9bk4Q+ZgwlyQ6lkOjjz+jrExii5t9+5Y4kyOxQ1e+EPo7eRibKHDQi
	kL7fmkd24oiU7No7H2XHPSw3wa0uIl5ffZtoT8ijM5plFzHfmW6E7H/ad7b2MRvjNBv1JbIfpm4dq
	CxqsehNQnZqkzJc9V3C29aKpuv8e6s3z++SjRWcweRNor8+u186U5vioZpFIUL5aTv7zE7G6lZbry
	x1cFwlYX6Vm91c24YuhGXFEwvsTMumnUByj+xWdXAShTWwsEq8BFxhQzgO2R3/v3HiTO+fVi7BKBs
	Rg8ORXJoQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAazW-0000j5-Ql; Tue, 25 Aug 2020 15:36:06 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAazS-0000ih-Bb
 for linux-nvme@lists.infradead.org; Tue, 25 Aug 2020 15:36:04 +0000
Received: by mail-pg1-x542.google.com with SMTP id i10so7086723pgk.1
 for <linux-nvme@lists.infradead.org>; Tue, 25 Aug 2020 08:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=U7xxpXbXwybNMlmAa/iggS0b0gQCEcrqJloMdR/oxkI=;
 b=DsDGVeH9REKO9cBAjHouVDOjKJxdK75gR0Sqc+LOeAv3TZB43DjC33SDd+jJ9zprMr
 mhI6F37mF73Er+vAzAXdxPgtMmQlLAeC/jRo0lmDdV95YeeavMeRiVpLTfX7qxbgCYbT
 hpujyEDIpYcJfvyKr1+M1Q6guWC3dGIFApp0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=U7xxpXbXwybNMlmAa/iggS0b0gQCEcrqJloMdR/oxkI=;
 b=afS9yLdcfse3XBWC477/maYz/yoI/EcMn3i+hiRdFLUnzkfKgZBhFXVwssGHJhHTjn
 meEs5jnLSwToIYa4RdCSWYR1YIzfq5xGBpKWadpbA5FJwCDXt+pvkBlF68QBxUktbxuB
 B50mEulDG2hZZ2loKd8+EYskHyyiXd2POQOGFnKd0YFTvXvFDyS3Sv4WUAMQ7Mo5uU0z
 v7YAx+Ea5DUKHzPqQMkfHrFkHb63oTG7DWAdDa9GdQsG/WiXgrxw5TpHx4KJ1vsEFTwT
 OHnndipg7LTrrU6f7IaE01EqL0en6JTJoIzMoWv5qT4vxDGXWO0sMdX6CftCeMf3l9mv
 0aDg==
X-Gm-Message-State: AOAM531Z1axrMzfD34nNKSS7cLyXPORIc14kgW68iKOeEAnWyT76I7YR
 oRYnhKwcIrL47BZa337J2+c3Uw==
X-Google-Smtp-Source: ABdhPJxo9h8p5vkmNsMfySpsuAT7ryUm3X3RK3V2yVUyE2CCAGYcAPrfTPWB2ToamtaoUarFSCxLGA==
X-Received: by 2002:a63:a55a:: with SMTP id r26mr7042435pgu.171.1598369758812; 
 Tue, 25 Aug 2020 08:35:58 -0700 (PDT)
Received: from [192.168.1.42] (ip68-5-85-189.oc.oc.cox.net. [68.5.85.189])
 by smtp.gmail.com with ESMTPSA id g17sm14903123pge.9.2020.08.25.08.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 08:35:57 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] fix possible controller reset hangs in
 nvme-tcp/nvme-rdma
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <5490be43-8be1-3c98-de3c-40b5323c10ec@grimberg.me>
 <20200825071638.GA29661@lst.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <272b3e85-08e0-07cc-580c-67a6b580ad4e@broadcom.com>
Date: Tue, 25 Aug 2020 08:35:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200825071638.GA29661@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_113602_617946_81D3A5ED 
X-CRM114-Status: GOOD (  13.66  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 8/25/2020 12:16 AM, Christoph Hellwig wrote:
> On Mon, Aug 24, 2020 at 11:29:49AM -0700, Sagi Grimberg wrote:
>> Guys,
>>
>> Given that there is consensus on all patches beside patch 2/9,
>> can we get all the rest in and specifically take this one as
>> an incremental step?
> Fine with me.

fine with me

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
