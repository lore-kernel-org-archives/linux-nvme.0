Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E23ECAAD8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=MmjBLMKSx/pBQv2NYKPSBlbDwh
	Apl/QOw0H+bP+2PLwNh5WTKCPVfvfzewHiogolh52SdqHhv2RYdz7ay27PrsNK0MRNr815o8NsI3W
	y8UptFCVIFsV5sEqT09+kv37vjjuiRKJFGxpXCY9r5Ye524xswXPFL1UakPvIfaFiXO6Fh9H7ZbXQ
	kuXUu+7vxWbCzx6wq6eFlMYaZScRGhLIVe8L+8K6uNUAh614LlMMu3xyH6G6jsUgoacWvuET7k64t
	mmPaUzD2Zv8wNjVEQXNgZXibCZDs3RFhddEsEXu2z32qEM+WixzpGzYe2pp+kbnE/WNc+supBLbCa
	GH9Gphuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaxFn-00AwVE-KS; Wed, 21 Sep 2022 10:46:55 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaw2y-00APb6-SJ
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:29:38 +0000
Received: by mail-wm1-f52.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso3372845wms.5
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 02:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=U5y3iyMLC45jYwI/IvNkw7Rq7L4+9pK/RK4qZScdvhtKhTW5f7Fppw3WBI5kKzjED3
         CqwqiV/d634zeIdmOyuobbJLbncqPhKucCxxUZAOS5vj/wzbD6u17Z9pYzKJXoFqCbnQ
         vladsBRzHyZKvZEgpu5AUZmkh1rAASqJI02/eo3sr1ithh97DIEFYPLpoPaO5D9jJEss
         mfny1iDVdiIX8k0bhLbnmWVlJVdokxVLjorbq0X0aku1HuOtCHSIp27ayC6SsyBBM95J
         7gKcuQyXbPg9UVh4JthW+bTCxNxI6cnl9uGIj8wbiXznFJ7ZcEm//YP5Qm9+x5F+RfQn
         9jLw==
X-Gm-Message-State: ACrzQf2iLUHgERIU8gdhuVCzrsjf0TgY/7hfaZZF+f6KESfaBCNz36aR
	O9+zvrcYe9b3rQRU6pmF/Jw=
X-Google-Smtp-Source: AMsMyM4rPeqzbIpMabUMco6oQOBPXRS55Glh5RsWDIXWnXGZZGF510xx+2w8HxNDKKZ1sDVOv9tWCQ==
X-Received: by 2002:a1c:7c03:0:b0:3b4:7647:ccd8 with SMTP id x3-20020a1c7c03000000b003b47647ccd8mr5269856wmc.10.1663752574091;
        Wed, 21 Sep 2022 02:29:34 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id id21-20020a05600ca19500b003b27f644488sm2104552wmb.29.2022.09.21.02.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:29:33 -0700 (PDT)
Message-ID: <0f428954-7cab-5ed0-fce5-e9f20ea29c34@grimberg.me>
Date: Wed, 21 Sep 2022 12:29:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 06/13] nvme-rdma: use the tagset alloc/free helpers
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-7-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171611.1289361-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_022936_936177_64D4CB9F 
X-CRM114-Status: UNSURE (   7.43  )
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

