Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9ADC76196
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 08:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=msS+nZ0/yPSgOd/XOGc3JkFSI5
	Ly33TV7PDujvVrx13uynGcRM2kwFgq+1ds2eG6wiE87S1xB+PMNssKqU116PlIUYyzyWUzxOo0cGx
	m4vkJFWY4BWALhtYO04lOaG8SiXp0fJgqvUkHqJlOyIvIs/4ZxMz60eweCZ85TeqZSlRDSx6YadTG
	4upDRT9igLa45DsgNlRb/xbvLr++dT+of8g0/32DLMi7QXc1EEHh9TfgYjJS4TwDZDPr/wqoaRtEF
	h3ylZzYvmEo89yjj+Gn/ls800YFxem0jJXK7wDE9mBG9DohNJQrFSIUrk9uJZNmX6hD/LnXCQH4NW
	QSRcG39g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph4oI-00DblV-2M;
	Tue, 28 Mar 2023 08:36:06 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph4oG-00DbkB-0Z
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 08:36:05 +0000
Received: by mail-wr1-f49.google.com with SMTP id i9so11269219wrp.3
        for <linux-nvme@lists.infradead.org>; Tue, 28 Mar 2023 01:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679992560; x=1682584560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=wWBqvsu63DtFynzYeP3v/waS8CIRUHFzrwaXD30vi9LLJ33x1Wm9CJjVi+gFjncn1e
         g1mh6gGCsWe87wedhRPaZI2JGL8zwTnLJFW9pQOIQvjLmCXDGjGk9v1/LHXb89AI3QQg
         RFAARTRTv5g97nC2Gl9BXYzJ7678ix2LYPQ6imtIFh1qgyunn8a+MEmHqwTIeVHkSAc6
         tLAk1U2qSYvGAt15MYgae1oAfUJh5wqJ/is8tn9HhmC928rSnAqQ+QRe9dmCegrPFVbG
         pMKvUfz64VF0GEg1+w0NzsxDbFzMpgupHbnQGB6oO0ectdaE40XtWRxJW0DaBEJQCAx9
         ixFQ==
X-Gm-Message-State: AAQBX9chITRtorQrGpNNITZAvVKxEHvjutTFPrMsPQDPhAa6w5g3ohyg
	EcZOokUZjMqBevhx9yd8z3ou0WqTruA=
X-Google-Smtp-Source: AKy350bX8nmNsng/dpMqCxmjtfQyGmh65S1OgnXfW0O3a6ZMm6QTBREL1cVPF6zyHXSXcsWbyZqZPg==
X-Received: by 2002:a5d:4d88:0:b0:2c7:1c72:69ac with SMTP id b8-20020a5d4d88000000b002c71c7269acmr8603248wru.2.1679992560132;
        Tue, 28 Mar 2023 01:36:00 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e8-20020adffd08000000b002c592535839sm26971072wrr.17.2023.03.28.01.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 01:35:59 -0700 (PDT)
Message-ID: <de60ff8c-f7ed-e175-ed32-1e70d9b7da2c@grimberg.me>
Date: Tue, 28 Mar 2023 11:35:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] nvmet-tcp: validate so_priority modparam value
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de
References: <20230327053724.62363-1-kch@nvidia.com>
 <20230327053724.62363-2-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230327053724.62363-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_013604_218627_E482EDBC 
X-CRM114-Status: UNSURE (   7.41  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

