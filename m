Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B842ECAAD4
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=X6JT6ip7Nn6a2G1O9BmdIQj80J
	Jw6Hp2sH8BL9V3o1RuVv7QV9p3bMC+k/d7rBlcxvoha4vxq/4UoyotvUox7m1kIayTEU4sjyKcO/7
	ulsSBfOzdNjQIL5kTkSEmCnu9yDfrbq777lrmac8qd7emeTWfHCP9eMW3OJ/PoNsyoPWleSOpnKlA
	tYOpt4mbuo0ECJyTLWw5iFuMIHL+zAQ4rkiFLsYVULGfXJrMfiYvXHaF7lwZv9k7w+QO2Ja+jGytX
	mHvPhECbfh/bxLmlrY67RLuuhHws2ejQ+xPVIt5FTXtjbt5vfNqhYfSY+8HvgwBg/qihLPJUIScMQ
	0pQKdfow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaf4-006UEo-KA; Mon, 29 Aug 2022 09:02:26 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaey-006TsD-Qs
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:02:24 +0000
Received: by mail-wr1-f42.google.com with SMTP id bu22so8967919wrb.3
        for <linux-nvme@lists.infradead.org>; Mon, 29 Aug 2022 02:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=O8opa00w9KW0S0yDJOBo0cUAwFO223h/8bK5pt+rIWmDSuy6IR40tKuj4Z6b28aZpM
         dAxMGtEs/zx0Cu6vkK2aw5sM2Rucc6eVh9ikujAdnvvZwb5IYqgE97AG9iOjp0y5H+KO
         BQB7wBMfv71MQK0JzRU9tHo+6FeoFohnEImYJC8iz+IAO7IIJ9KplVtQ4kzzyazlBj6t
         tnPBEhX9qiR3rIw/wH0Gaq9OEvuY23gnzs3558JpyZWen9szNcS/5Way8fNQm1jzfRSk
         Vt1hvSS0zdmi26ZQP3oztTofkCzmpUassYPzGPo5sNj85I5pIoEELs4rArOxp9C40zOQ
         ruVw==
X-Gm-Message-State: ACgBeo1M957MDaP792/9iuAgiZLtVebC2Dzjw54fFurxVRfVMtTFZPL0
	LzUm53qJcUz2baz7TUOu8b0=
X-Google-Smtp-Source: AA6agR7WuD7C0bj4zfklMBbQ6xtvBSeXiJ2ACOWG/VqnkuAbpx3U9/tEwkSq5TzJz43O7+z73fMf8g==
X-Received: by 2002:a05:6000:1848:b0:225:586b:e64f with SMTP id c8-20020a056000184800b00225586be64fmr5878445wri.173.1661763740420;
        Mon, 29 Aug 2022 02:02:20 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c4f4300b003a84375d0d1sm4594705wmq.44.2022.08.29.02.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 02:02:19 -0700 (PDT)
Message-ID: <c6db2d34-26a2-8927-a9ab-a6ad788d30a3@grimberg.me>
Date: Mon, 29 Aug 2022 12:02:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, mgurtovoy@nvidia.com
References: <20220829081256.24570-1-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220829081256.24570-1-lengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_020220_915077_7A0E62E5 
X-CRM114-Status: UNSURE (   6.79  )
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

