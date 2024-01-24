Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67522C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ZWmoY1WJ6az7NkAgwWx+nEFGJg
	+ajWkqfL8dzAik5sQa6Ymzuuhkua8Xcvxl2xNvsnThNr97+pQfCu+ls2fu9E84Afd3h7/BTyvNMjU
	8nnUkoUxFTgtzdiQaUeqIfFGl1qMCeVYiemEuTBY4OnsKzxMHLZ5KzAPi41Hsz24aqUlsE0MC2O0D
	ZaHZkpYcrhoU/+UopJRtKndaD0KnBBFaiMBiUmPGInMX25xyekUUKoC9fjXf2HPVe3xNH7vwJ8NV+
	ikTdIlE1itnaRApv9YWqdKksuqXKq0hj9L6JisTO0ajuQWK4IwPk5GwUF/6H2oJTMVFUl2LU0/bMH
	o35QkVtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rScY5-003Gj7-2B;
	Wed, 24 Jan 2024 12:40:09 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rScY1-003Ghs-2t
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 12:40:07 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e60d74b81so7516045e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 24 Jan 2024 04:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706100002; x=1706704802;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=cD3PsM2u9+cqUAXRENM4ZLBPPgrmLMCZ2FWQ05zoOcyVt76/H+tkc8KuRAylJtGleT
         x4z/4Ir1h86XltOW1J9idmuo8xdJxMudDhl/GiDSjndfejic96MG17a7Y75sCjCUxKaS
         mg631XraZo7rFM0nswjPRHJHP+QhOufp2mCPcnmoLAJ8Qljf0yZZ18nd5m6UZtiFMA97
         UDNwUdU+tG/l1NCuhKUpb+4p5MEu7HgSs9j146HJc+ax6+LpM0njJZw+yJKYQjfr5Nwk
         KphEmx58G3vVS5LDdb0QQPG5ywqrt3pXLRN+uJkeRt/EUA6SoTp5/QxZUjQsRl7JDSFN
         RmhA==
X-Gm-Message-State: AOJu0Yy/VAeOPYfvsxpfBjN+vDgZlwnzYXwVl+ZqSXcnUtz5nQO4kZH0
	BSbhmVnJGOv5fYan+ETEpRUUjoX0HEuthB2zdBWslbau2IMjsowoi4ClyPYp
X-Google-Smtp-Source: AGHT+IG76OzFWMcz5XMvThRNAK7gBt3ChY8rwUOHWL8nKggDIhIPWJhrYjcSIU80F6V8dDq4bKwpEA==
X-Received: by 2002:a05:600c:1ca6:b0:40e:53ef:d9f8 with SMTP id k38-20020a05600c1ca600b0040e53efd9f8mr1498655wms.1.1706100002085;
        Wed, 24 Jan 2024 04:40:02 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v27-20020adfa1db000000b0033946c0f9e7sm3602292wrv.17.2024.01.24.04.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 04:40:01 -0800 (PST)
Message-ID: <b7752423-3e93-4bdf-af00-70e2ab64aea8@grimberg.me>
Date: Wed, 24 Jan 2024 14:40:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-rdma: Fix transfer length when
 write_generate/read_verify are 0
Content-Language: en-US
To: Israel Rukshin <israelr@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1706098587-20726-1-git-send-email-israelr@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1706098587-20726-1-git-send-email-israelr@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_044005_957942_F2DD295D 
X-CRM114-Status: UNSURE (   4.94  )
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

