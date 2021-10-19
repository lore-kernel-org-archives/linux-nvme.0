Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5B4C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:37:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D536961260
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D536961260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=I9qCRIWsWBmtx21mx0dknXN2bZ
	YeC/BhHqFVCTEzP3yOi6RKVwi6biXpGWl2BWGJDOkpCbu5ajQcTcWzc9YC1AE1W3OpsrLyWqAQa8u
	NgLxV9k+RfZeN0WuljhxmDmqkdh0lvmRKHfDIeuNrdhciPqwpfl6S1b/IiGJEMt5nC2iacyablNtg
	fxCMOsus3tZbhsjF5aXdwPHLTA4OMEfGtNe2sSE80lXzp80PXcCP/4bBRdDrAvArDsohp9K8A1iR1
	FZzdolsxH3On5hS/GKdIpzTMzerYvus48yK/16PcwRn+evH+fCeB62hJZrtL7E2K1EnI0ryt6qfD6
	8Spy2x+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcoMY-001F6t-QR; Tue, 19 Oct 2021 12:37:02 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcoMU-001F4e-FV
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 12:37:00 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 z77-20020a1c7e50000000b0030db7b70b6bso2559361wmc.1
 for <linux-nvme@lists.infradead.org>; Tue, 19 Oct 2021 05:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=QyKgg6u5VHg7KYCptXFxHfmaVjs28KOap8d2YLys7hccTdf8wcU0pqYDBmOpQN2NaJ
 q0pG3JS0RAqa0uve06ithE4DWHtIXz4cgwvj8ZdrHME1GUWjG0v9lfhV1V6tIwV1pmMA
 3MMuHnZcKEjFpD+Ww5sZyM1vPvZ8rMQ/BBynSyMFNpI0vDPzlCoTDyonipM7JlbWiYoY
 rBWoInaJUHl5lvYc9aEpYTi5sdW9sE/ZkLbI+6Pi/G8bqUf5Lh87cGuyKjBbqM7Toif9
 SyKWa48VVWe4d6kmhBHPekjQgDlJNNIMSWy5dnvqLfxE2ly7p0ga/04bKXRQn7TsckGs
 C6Ng==
X-Gm-Message-State: AOAM533RXN/P3R8nzEjRaIIZ0dIq6VMOMJMoJycKa6ZOqbXSlhs9lza6
 2whwtMppfmARUp3wd7C/pf0cOxLhE4E=
X-Google-Smtp-Source: ABdhPJxPSV0RB++pRp0G0U+DXNlKP5yYeagPbaY0WWWTqWHQMrWnIc/KQZfG8jH3MwOyZa0/4whoiw==
X-Received: by 2002:a05:600c:3511:: with SMTP id
 h17mr5700623wmq.144.1634647016506; 
 Tue, 19 Oct 2021 05:36:56 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id q12sm2065612wmj.6.2021.10.19.05.36.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 05:36:56 -0700 (PDT)
Subject: Re: [PATCH 3/7] nvme: add err_work attribute to nvme ctrl
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com,
 jsmart2021@gmail.com
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-4-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c1123333-640e-413b-e10d-e292064e4997@grimberg.me>
Date: Tue, 19 Oct 2021 15:36:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211018134020.33838-4-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_053658_548219_28449385 
X-CRM114-Status: UNSURE (   8.95  )
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

