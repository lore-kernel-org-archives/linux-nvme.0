Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379F3C6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 15:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=MvcHktEqvyCgnldWs31ZuxoeA2
	sqjojkQKrs47R9iSgDb0+RHzqpMyzBAFpP36zOfe6nwOCBTo9R/hu6lRqKVW6fcrPnaQyqmhNFLGY
	qi5IcWSvVhPmgDw1RQNnnbV6Xn8+jX2Shbz6i9cKvyTX1AsXthd08vj9n0wKMWaEOfXNCCWE0kOWv
	wSSBrSMXFxrWQCPeFEkNpGsx2fdsnmoetsb+gScOtqykf3WsbezjPH44gb64xeSkhdIdoQ8u3HXAv
	VSOoU50bJB3TzHxEKIlINjr0LTRjDCEL7HqwOsSuQbTAIXK/yZiaqUALno4prgT8y8StOhpdfESQ9
	yDHgfVuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcSuD-00DsGC-0K;
	Wed, 15 Mar 2023 15:19:09 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcSuA-00DsEK-2s
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 15:19:08 +0000
Received: by mail-wr1-f54.google.com with SMTP id t15so17649634wrz.7
        for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 08:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678893544; x=1681485544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=y6PVoWAksyw+JuxgjcAtuVOOn8z6q+uduMwwnb0+nHhOS/NzFknpNNTRSGcMerqLZG
         tQwuLy60iiN46px/4fvTJTKf7ZwlNSAWcR7JnxUMNDXMO7pHI5tLtEqWbhQVfzndLZkp
         yLHcPwpiugMQYZm5pYyi/l2gfW65gtg/fNbqo3WPvsijIRShMZg9Olk3IBIAdxMigCo3
         JoNwmkyB97c7MX/gQGR3JJdcsu/btr0hMYsjme4A7/p2aYZsrdGCEMDAm5fqYqlgWiS/
         vqOhF4vPxTkZbACGbJFobN2HOVk74pivQiv0EpcT03c0nDstnD9D/ypU86ILJFcDshod
         Y28A==
X-Gm-Message-State: AO0yUKXXVRcMi6usd+r3fj1Tdo2wrKbhutRXt8C0LD6jUzQ4hhW16sH4
	kSlVELPFxIiVFqHB+4snbJg=
X-Google-Smtp-Source: AK7set8JJQTMC0rg8y+F80J8v4xFgJlUt0RVc2CjLYptkt+qO1+yr5zr0lw2zUcDe3/6Crp8XSJTuQ==
X-Received: by 2002:a5d:434d:0:b0:2c7:1c4e:1d16 with SMTP id u13-20020a5d434d000000b002c71c4e1d16mr11548902wrr.0.1678893544088;
        Wed, 15 Mar 2023 08:19:04 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4d11000000b002c5a1bd527dsm4877005wrt.96.2023.03.15.08.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 08:19:03 -0700 (PDT)
Message-ID: <050c2c8f-ca68-986d-8ee7-7ae07d011f59@grimberg.me>
Date: Wed, 15 Mar 2023 17:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] nvmet: rename nvmet_execute_identify_cns_cs_ns
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 linux-nvme@lists.infradead.org
References: <20230315142032.507083-1-hch@lst.de>
 <20230315142032.507083-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230315142032.507083-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_081906_930577_7EEAD8C7 
X-CRM114-Status: UNSURE (   6.83  )
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

