Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F338AC00A89
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 05:32:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF542083B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 05:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D/aNLPdu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NK9WZsgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF542083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hMHnCvQdlf4xmfLMlYnVKAOljoZ+DodXMXVH27q0HZ8=; b=D/aNLPduNLnQnfTWQ4DDYoEIz
	ZoM1B9TS5nP3/GHSX1cISdyPMqXqSXe++a4keCWWzMpWyN5ix0tNA49rJIcCzyGooREPV3inRS8lg
	skSmC0flS4bU+b2i3HVILkZn0vT4Xx93bHxrg65OZ0+WHwBSJfiyK90n+R/m/zO9XqzjZAvgyeGH2
	xliN23OIW5WTQiC5WpLb8mt41xb9hkRONXVDPqGOK7c/yp5dfdS1ZRZRFuiFFvQti0WWflsd0MvoP
	gcayzNXtn4XbsJxsVreRp8jB1y/rSJ0b8ycO6xSKYkKK+6eCdB0UOYJHf66jlNELvUrgd/kIchsUI
	due8haDSQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaXtB-0000qc-C7; Thu, 05 Nov 2020 05:32:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaW6g-00016k-M4
 for linux-nvme@merlin.infradead.org; Thu, 05 Nov 2020 03:38:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=bz2fbm4kvqAI/vyCn70BFZuOgc3H1RSF0ZVMI0mK84s=; b=NK9WZsgdX2+i7ZnLmL0yqBBluH
 flgjP8GZ2QfkAYWkUBt6zNsDbjZpTg30h3j+2OMKyys+Xu+I0SLuPTjAZi2R9WNaOGiDzZ5sOa4Bp
 yD2TYn9AKgYA++N0LDhGupv0o4rWTN+/yHWEtV4+Hxl9FNUP7nA6SsiKTPufXo/5Jm60b+4xt1xk9
 lbrqU1FKzo0Kj46TB0ViJqLS2U1pB4xTHnnOV/HiZs8bc5yUQ9+JZKRuSMBqys9E1KwDL7j1lV2JP
 3Qgw1+M9ZYPRSt768XRYGdXbCmFa+ikwBjwRScYAZzQNRMFJqrQA0yo3/R8g85CWbOkaFj6Q9LuCX
 tq2bhVrQ==;
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaR2Z-0006BB-O9
 for linux-nvme@lists.infradead.org; Wed, 04 Nov 2020 22:14:05 +0000
Received: by mail-wr1-f66.google.com with SMTP id e6so160689wro.1
 for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2020 14:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bz2fbm4kvqAI/vyCn70BFZuOgc3H1RSF0ZVMI0mK84s=;
 b=dl+WG2HlLNRHWqP1L823HCYFsW53wouLUV+PKwF5BDL2W7iHR73YrlIGlqd1Jfb7+I
 a07wQNGhCpDbALAsYU3gng02y8QDn/DNuHMuPVCNpT+rmlXYlIyZQdIKbzEWlrbSCcAx
 DgDTLbp2bkoCb7Z9v9f71QmTt7mSMNCo3m/3g6ES+KvnAv7UEm5kUqtgbWyX9ccHZ0sb
 GHVHFXlNtRcD3FlLV8CZpAvHp9paZbXt/+R9nrjRaqmOZsGkC3Ka0NIMYShayb3jGBR2
 sLsQq9lbgcW/0L8Rs0ha2CTVTzSV0kK8b4x6Nb2t+GMQx4owVhDr4KZnaZYOJ/wx2roc
 XL2w==
X-Gm-Message-State: AOAM533SBnzXD1dKyUt59Y81OW2K1AXqIOXWJRT9oqENrCUOc9tbQqwo
 1lAw+NS0ATmdkM4xDI3xm1c=
X-Google-Smtp-Source: ABdhPJxKKJMkco/DU6vEROgHd+DBAZDTPAtsogT6DSoyQPeMAI4GWuzhNQ2VB+kUTw0dsUDpQSxrqQ==
X-Received: by 2002:adf:fd0e:: with SMTP id e14mr110625wrr.119.1604528040900; 
 Wed, 04 Nov 2020 14:14:00 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:f032:e586:d54c:b9cb?
 ([2601:647:4802:9070:f032:e586:d54c:b9cb])
 by smtp.gmail.com with ESMTPSA id i33sm4840818wri.79.2020.11.04.14.13.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 14:14:00 -0800 (PST)
Subject: Re: [PATCH V6 3/5] nvmet: add passthru io timeout value attr
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20201104203736.62745-1-chaitanya.kulkarni@wdc.com>
 <20201104203736.62745-4-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6b9f9cdb-c480-c63f-2b38-94bd00bca3b1@grimberg.me>
Date: Wed, 4 Nov 2020 14:13:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104203736.62745-4-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201104_221404_032393_FCDF4494 
X-CRM114-Status: GOOD (  15.36  )
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
Cc: kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 11/4/20 12:37 PM, Chaitanya Kulkarni wrote:
> NVMe controller in the passsthru mode is capable of handling wide set
> of admin commands including Vender unique passhtru I/O comands
> (VUICs).
> 
> The VUICs can take longer than default NVMe commands, that is for
> passthru requests the timeout value may differ from the passthru
> controller's default timeout values (nvme-core:io_timeout).
> 
> Add a configfs attribute so that user can set the io timeout values.
> In case if this configfs value is not set nvme_alloc_request() will set
> use the NVME_IO_TIMEOUT value.
> 
> This attribute setting is only allowed when ctrl is disable to avoid
> rcu calls in the fast path, in future when needed we can always make it
> fast path friendly using RCU.

Same question

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
