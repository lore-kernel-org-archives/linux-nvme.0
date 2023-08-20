Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557F4EE49A6
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Aug 2023 10:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=PObTlb8g6w+mDz3uRGMIbTrWnU
	cMosxTEc2C0xAXSzJW2B6UIlZGVK0UBRntNcNvob74zw9EzR2MQiMRX0hsehbNYZ93rO4ixheIHLo
	pi+rb4+jusN5PlEvTURGgAuXDJdU2dbKDhF5cKEBJFnSfOK2wZ4OcpZSX1a4YKCzOhk8WrZkwzzPo
	VoJXI1PPELL1orYeoKZ9tqFSMN75tJ5XhIUfV4sDrq0kIozKLS0I4axpE5Py4YeEPwLOz4lF4PbuH
	N9vceC6TbItUeU0SBYQnFHJ/8qXbn9q+WAk1NnJArRh65SSMwYElD7+yKoDSgm3KYfdwUTHJpnBQV
	l2qOqfaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXg6b-00BnVn-1T;
	Sun, 20 Aug 2023 10:56:25 +0000
Received: from mail-ej1-f44.google.com ([209.85.218.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXg6Y-00BnRV-1a
	for linux-nvme@lists.infradead.org;
	Sun, 20 Aug 2023 10:56:23 +0000
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-98273ae42d0so66827766b.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Aug 2023 03:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692528979; x=1693133779;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=DKtmluq736HEILnGuGX4iptmMi7RaWwlOu7Vx68e7ooLQk1icoM92W3NLNq0lRCDfN
         8pSsAxi72lnCZtoPOFcq8+VDs/VALHrBVKxdtCDGqw8zj5A0zk/MPXXrrUoW1MIXbZVN
         Qm0RyxtC0G/w3C1vHI7fhQNSiAbHxIsB+YAksSS3cxXtYc8bIQplJkwSVnxVhza124gk
         T1sARxdcxnY6DELlb0AP9t/un+BLDI9eXKd9nNAWczDsQIoKbkfxqhX/OMy8/Ro0HffV
         AxNp8E7MS9rzqLqAakjHgTnUxHuuYmnIT+2bbVpZ/C8A6VQGpEdlf8bthVm0dsj7Dtti
         T3fQ==
X-Gm-Message-State: AOJu0YyVbRSXeMHkiBW4QWItOUbb8L8S8eMPtipdu+aIHLflBlRC59xo
	twobWk2V8tzN2CIDIrc2foA=
X-Google-Smtp-Source: AGHT+IGtRTECD/MNIoTuqfoiFY5OsDcl7m8aKRiDkCJ/u9CJP1gkkzpFhqmboZfnDeOPDjXcZLv85Q==
X-Received: by 2002:a17:906:74ca:b0:99d:ed5e:cc77 with SMTP id z10-20020a17090674ca00b0099ded5ecc77mr3195961ejl.2.1692528978743;
        Sun, 20 Aug 2023 03:56:18 -0700 (PDT)
Received: from [10.100.102.14] (46-116-234-112.bb.netvision.net.il. [46.116.234.112])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906151000b0099df2ddfc37sm4398037ejd.165.2023.08.20.03.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 03:56:18 -0700 (PDT)
Message-ID: <0071bc88-7080-b0a9-63e1-8133841e19ea@grimberg.me>
Date: Sun, 20 Aug 2023 13:56:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH v2] nvme: host: hwmon: constify pointers to
 hwmon_channel_info
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230820092139.45029-1-krzysztof.kozlowski@linaro.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230820092139.45029-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230820_035622_531437_2D266E4F 
X-CRM114-Status: UNSURE (   7.39  )
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

