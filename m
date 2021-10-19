Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6932DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:47:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29EC7610A1
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29EC7610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PgPtcIz8pCyjSs9m2cff+kOAQY6at3QbO6/FqlTpxws=; b=W/sbTsUP5GN3SkmNLWfDDbfMHv
	xkXV4tZfdbKKO+s1xpT7lfIuO4PPj6p06hDGZYyuiUue2Cjg5XqQ/vaGt5WuW9NZ89GmZuNwfPusO
	90ohEP1Gtc+CH08Lf2tQOzSLGfM3ShqqXtEBgwzC1+KLoa9SmVGi610+m0fVJqMs+JRC6SD+O/Vnz
	o6AIZyg8vweD0lGktwYMONVA8h/H6ML8Wk4wUDa2AludLlDZH/iZpovuddeC7YJWknuJOBwnBTw8/
	qD5MqY5S3wvoujYxxvS3iXmJoq2033+HkSAm8G39aW1fuHB0TkSCNNqEOZ1qzpCwP56DGlkLrO5We
	I1UMo/rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcoW9-001HmG-Ec; Tue, 19 Oct 2021 12:46:57 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcoW3-001HlF-Q8
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 12:46:53 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 63-20020a1c0042000000b0030d60716239so2561183wma.4
 for <linux-nvme@lists.infradead.org>; Tue, 19 Oct 2021 05:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PgPtcIz8pCyjSs9m2cff+kOAQY6at3QbO6/FqlTpxws=;
 b=fcbK/k+Bg4REiGZay6LRwj+L2XSJOd971xsmXXUYKjZDFDNtG6nfDOjcpn0Lwnjomg
 lOtAcKNX/xdxBxsMk1aEkiv5RUZa8KcWxfgW0mIGCdRuCpTcEn3VSFmBYe+2+LKGZUEP
 eMLvNSpdzYiV+LzjCeQaU/Ola2zzSJiGIhkm1q9XnbyAItZyy9uBbIT03xVsRVlmwt07
 sRVYEG6afYEyMqWgfbO7E5bSpPS2n2097tcUyuUKiRBTEUgVZDDdfEmdKMh7hg0H/EFk
 p5LKKSsLHxOYuQCEfEFFTkbCmyPT3PHPqQdbj6mQebHtQtlXsBWr4fuPKiBducIEsoas
 jEZA==
X-Gm-Message-State: AOAM5324nduUlGaOoKtEOvNKulAiRiDZkuk1bZWFoeim44nVsjiGcFfO
 cINNcDK+NNkjZcFJUoxNFGk=
X-Google-Smtp-Source: ABdhPJwYfabB/oHNQ6w8ZM8JcM3NHzrIqHqWSaeCFYNx8duMAZP+iwomH1pIvRcZjw2Xyem8aQIx4Q==
X-Received: by 2002:a1c:f713:: with SMTP id v19mr5807969wmh.188.1634647609822; 
 Tue, 19 Oct 2021 05:46:49 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id n9sm2259715wmq.6.2021.10.19.05.46.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 05:46:49 -0700 (PDT)
Subject: Re: [PATCH 7/7] nvme-fabrics: add nvmf_init_ctrl/nvmf_teardown_ctrl
 API
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com,
 jsmart2021@gmail.com
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-8-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6cdd8b87-7d7d-d27a-1d0a-57f8b25ce71f@grimberg.me>
Date: Tue, 19 Oct 2021 15:46:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211018134020.33838-8-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_054651_997609_6B1B5CAE 
X-CRM114-Status: GOOD (  10.27  )
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


> +void nvmf_teardown_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	cancel_work_sync(&ctrl->err_work);
> +	cancel_delayed_work_sync(&ctrl->connect_work);

Name doesn't represent what is done in the function at all..
possible names:
nvmf_uninit_ctrl
nvmf_deinit_ctrl
nvmf_fini_ctrl
...

