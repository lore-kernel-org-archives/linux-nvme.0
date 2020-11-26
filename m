Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BDAC63697
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 16:30:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803A621D7E
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 16:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jn1v8yDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803A621D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+eARNmibCt1o1IK7wXzP/BFv2+6UoqIHFv+co2VwAKU=; b=jn1v8yDRLJC06p4UPP7t2qGTV
	x/oytsDpcIrlkGEc+jXhNxeZpDMTUZHXg7qfJOGeK/4mU/9rQUnr4mDOVPtSFf7Hd/kEBOvxqSYm0
	IdzRvrFza2F9PP4Ho3ae+BKsiOsymKIG5rbWQi9Ym/N2/sxHL1iA2nCaCX+ntHlUTHRrLntnweta0
	7lD00GpCdezrre9iiSPJc3OHAoZ/xl3mv6E+iCYGlWFL+KP4EC+UkKN7jeNMhfPNVV20rdYD75ObM
	FvGy0EqgUMg1i7lHCUZxnLs3EAloFKHqZ2Co4Yob2wvABtEMDgIdzzBGxFHXQbgk1i8JW62Ot5tTq
	k4IcZUTKw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiK9h-0008I3-1E; Thu, 26 Nov 2020 16:30:01 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiK9e-0008Hk-Kj
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 16:29:59 +0000
Received: by mail-pf1-f193.google.com with SMTP id q10so2076331pfn.0
 for <linux-nvme@lists.infradead.org>; Thu, 26 Nov 2020 08:29:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YpPNWLAEZvfDLmtn1UVmuL6TdVtdtW47XBHPkQR+4T0=;
 b=VB0MqMdc0QnLg7OutZOrB472C7ablK49sTCD4UqQ0ShsZYELfdwfkT28vGFZxeUfm8
 TaYqDMUiVgrOevb0x8qVDaSmZ8sFbugryQ1l9J9RzTsbdwEAbumaIUpjAyfC9f4qB1sV
 IZQSH1ZJws2hyEoersqwNpoC5AS456W9lcIAC22MkSx+k3ceW/ENaJtdBRZUqTVjVNli
 CkcOUOnSYog8BiRyq8bycOCFAX/Sv36Wxc/kQ++YLsAeZqzyWhZxyM9aTJ66Xg0pCarO
 X0h1BO5U/cZXR25Pcxojf2bQATvELXZsMy3ZdQm/yL+jzSNNNTRB8brqVznl36KqAf0U
 6LVA==
X-Gm-Message-State: AOAM530ivhZrtwISWsWpoW60l/PEfADx8950PERPCIITWd5Sbk7FHVRM
 tVHp4d+eNYlpYyytP8sw1iQ=
X-Google-Smtp-Source: ABdhPJwcjvWooGLhPUWg+nuP5QqUyF064g2qmXXvKG8T7dlRDmAZv2RHTyExdgpeK28UpW0ddZaLRg==
X-Received: by 2002:a17:90a:6393:: with SMTP id
 f19mr4569899pjj.227.1606408196962; 
 Thu, 26 Nov 2020 08:29:56 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id z3sm446187pfn.38.2020.11.26.08.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2020 08:29:55 -0800 (PST)
Subject: Re: [PATCH V3 blktests 3/5] nvmeof-mp/012, srp/012: fix the scheduler
 list
To: Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
References: <20201126083532.27509-1-yi.zhang@redhat.com>
 <20201126083532.27509-4-yi.zhang@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <26365d1f-743a-4aac-57b8-3a542639c0f8@acm.org>
Date: Thu, 26 Nov 2020 08:29:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126083532.27509-4-yi.zhang@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_112958_717762_3E90E297 
X-CRM114-Status: GOOD (  11.04  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/26/20 12:35 AM, Yi Zhang wrote:
> There is no cfq scheduler and new added kyber scheduler in lastest kernel,
> introduce get_scheduler_list and fix nvmeof-mp/012 srp/012

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
