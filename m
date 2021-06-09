Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC06AC47082
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 00:24:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A004F61351
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 00:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A004F61351
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=RP2DVmi5jiUeiFuPyh8ObjIpk1
	dVtS1QwWS18+48hCEhAPQRJPyj4oNyNWO7piufQ0+SaXKCWCJl9zYj/hnyTF5+OtUnjVlMkPu7dSP
	8nfgbX6WS48LhXaUmnD1BCOnSncmGywxSIM2KD3GRWD6Z1fV00e4QddUjmkue0AsMRMrkj+O6mqYt
	1NYaQqfpNCYxxDcPHoiHZj24fmRVOmQvBDmRBqTjwM3DCh3CZMdpDFh/MFfcBvM+GNATtmwkmW6nR
	FO+8R/iQceTd0tJusWyCfBWEq2EN04UNn+Iv8zLAA8K07eo3TOHXZwYXBn+X0w1cnfD4VvGFwzDFJ
	XpW/XxTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqm0k-00AsDM-3l; Wed, 09 Jun 2021 00:23:58 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqm0g-00AsCU-Sl
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 00:23:56 +0000
Received: by mail-wr1-f53.google.com with SMTP id i94so18374914wri.4
 for <linux-nvme@lists.infradead.org>; Tue, 08 Jun 2021 17:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=OU0jECQ463Hp+N3ZkfKzT3zdn9Uts8Ov9GtMDQO1jCWMdfY2n3VikgAi8Xei7cbCQT
 bJqY4hhB/byh9qDDQzS+csytAe+wxQ1oF1IePIuVlGr2ot2Izxm8vE/uCswxruT/rinW
 /EMTnPxWHjGTBq5X337BbbVd6MuVot1i9DgxLr8d4yGDPSi3m7gxOUjfYo57UylWxf7/
 OjK1dnoVyiQMcTIxb57Z5LO3w01b8GRdputRll2hSquRqZeDuGqRCf3HsnQE0vn7/V3P
 3Jxi9z2v3ts7DX2N1ppT4kIFOVzrWMZ1wxyqm91vPZUs13+xiHFx1lTZGczF4po6dxn8
 rBQQ==
X-Gm-Message-State: AOAM530Xqg1UsUknD/uLv99lvRK7rbP6sg3nCNfUeFqFv82ON75Jmkxl
 0Ij6r3wLrS9pws5SZ19qVVvYd69ZSuY=
X-Google-Smtp-Source: ABdhPJzbJh0O14QMFZSZaarROT3S3bdkL4Mt/b6bxeNY71QhI6eVoGGvWUMrxZrlby1iaB1DWZryGg==
X-Received: by 2002:a05:6000:1b8a:: with SMTP id
 r10mr25476599wru.296.1623198233435; 
 Tue, 08 Jun 2021 17:23:53 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:12a9:2416:ca98:264f?
 ([2601:647:4802:9070:12a9:2416:ca98:264f])
 by smtp.gmail.com with ESMTPSA id j1sm19157887wmi.44.2021.06.08.17.23.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 17:23:53 -0700 (PDT)
Subject: Re: [PATCH RESEND 2/2] nvme-tcp: use helper for ctrl sgl check
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de
References: <20210608191037.44251-1-chaitanya.kulkarni@wdc.com>
 <20210608191037.44251-2-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8f511cf9-ab30-ecca-5a93-ba9dbae387e2@grimberg.me>
Date: Tue, 8 Jun 2021 17:23:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608191037.44251-2-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_172354_962613_B568AE50 
X-CRM114-Status: UNSURE (   8.17  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
