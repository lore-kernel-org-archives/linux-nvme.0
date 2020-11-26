Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1986C56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 16:30:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31158221E2
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 16:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rU12URr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31158221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UGiCo3lrSLZzB2v6ea+C4MTXaSIJ9OoD++Car8+fung=; b=rU12URr993sctCb7NqOiiwZbb
	IBaAz517p6pE3ZezfwMSiAQQIYnzEfjZXgowmKqG/H2/uXwlpYLuynUaJseHZpvZ476RnPCiOxuEN
	6yq0+MpA2W1TGTXzGANswsSKPF10URvRzUslD9VHQYIfMR/Wd5ZgkWrebZ2dfzl2T7Y5W1ASjuQFM
	iAWlY3EpEg0voHyoWpGevhGET1vSJTsxOD8HzD1ZqqjpHKB70vKGj3/4iKSAnIB35CF/Ia9t83lrR
	uxYe2A0QC6j1vxZ2d2+xrUotM0FADV00iDqe+I9eXEurukXziuHTfb6T1jix45zRgrC/nKQkdEi+F
	PO9GAqZ3g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiKAE-0008Ln-IC; Thu, 26 Nov 2020 16:30:34 +0000
Received: from mail-pf1-f172.google.com ([209.85.210.172])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiKAB-0008Ko-Ow
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 16:30:32 +0000
Received: by mail-pf1-f172.google.com with SMTP id b10so649674pfo.4
 for <linux-nvme@lists.infradead.org>; Thu, 26 Nov 2020 08:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ifkGmc8mND+qMLzPASunlgScgpmcRlcaiOr+D93U+SY=;
 b=dITFkuW2fMnrdmD1i2VzqbJXsrjRK5SjDTmos1EVvc7dhJ5WSRHz2RFNug/JE3ouKN
 ATyzK35WcLLNB93TzkKM6WR/eoljCEjkKTe64HoxEhQChwvSNIYSV4C160LVldYwDrR1
 5fPDFaFyxdRwoeH1hyCi+l4WyDvnKRM34EZxsI0nW6/qqLgrlpEziR41aWNLGGqUpeev
 F4qw98q5EUu+ELnxu7tEEEY7OpbePDMf2Ne5fsRneFtI9kNV4fu13YeBC1ZgLH4NhKxi
 4c1UDGGD/JCGTi9BDbA84mGCZqdGdmQPsN5bxZnmsvxQ6aXOYkbMbBy5qicHCkw7hnvB
 6ZeA==
X-Gm-Message-State: AOAM532jKWi7GM7CDq/oDDSSIzCXu0qWYfm9URmAuqr40YLX9SWlWjzx
 n7qLCbHYMUYXAVB18byUsjs=
X-Google-Smtp-Source: ABdhPJyoJjePWFaBIoXwfXZ+BXPnfyVGyk14GMlM6KSqnB50vUSSjdUYY6MZhqNcmISXr/p6Ec0D6Q==
X-Received: by 2002:a17:90b:93:: with SMTP id
 bb19mr4538489pjb.102.1606408230289; 
 Thu, 26 Nov 2020 08:30:30 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id a16sm5261301pfl.125.2020.11.26.08.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2020 08:30:29 -0800 (PST)
Subject: Re: [PATCH V3 blktests 4/5] common/rc: _have_iproute2 fix for "ip -V"
 change
To: Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
References: <20201126083532.27509-1-yi.zhang@redhat.com>
 <20201126083532.27509-5-yi.zhang@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <deef3eb7-2e2b-7e9b-572d-248200e2eb4d@acm.org>
Date: Thu, 26 Nov 2020 08:30:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126083532.27509-5-yi.zhang@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_113031_897372_FBB89838 
X-CRM114-Status: GOOD (  11.07  )
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
> With below commit, the version will be updated base on the tag
> fbef6555 replace SNAPSHOT with auto-generated version string

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
