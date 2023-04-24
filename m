Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E21EC7618E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 13:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yfnEFrFtJGJ3vZVouA914wVhfSwmiln+woc3KIfez5c=; b=L2sS1zcpEJx9b8EPpaGkFMw/f4
	w2cwMvr1a4dMN7zZGs1hr9kapO/28SRo6X4ihJhMnN6uQ7ccZlaAuKJMjW5N093HjZn6KzuAGiZ/I
	ufNqsl4es8g3ycuxaFQALVrvQReqP++0qB2xYh67SRaIca6f/NrkvdUIb9I7yjFlo7NNr7f5cjAlp
	87bOBMdBMRKaGbvT8PUIr5BoPpwlykUKvl62lEMqj9XGn6zwkW5+LnILnznYvig3Uxld6jaAD2YDZ
	qZjfxqaCoZMjDbczt8hjQ3fbvspV/I+VPhTOeXn4FNxF82bpMwQgolGyHHIG9DxKGGmxfOOfkoIrn
	w+jDhrPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqwOP-00GRSG-25;
	Mon, 24 Apr 2023 13:38:09 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqwOM-00GRRf-2A
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 13:38:07 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f1745b7132so9960695e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Apr 2023 06:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682343484; x=1684935484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfnEFrFtJGJ3vZVouA914wVhfSwmiln+woc3KIfez5c=;
        b=jCNFCCRMzta6KATu5uvChaufbZ7K7uFlSR/4HNtQkLffSUyauTn3jEH/e+lyPOABjT
         Z96qR6UyHanC/BRewtt9GCsJilonh5go5hTH16E5ZqsR5XAa/IOsxc+R5PkM0D2PMJQ0
         iD2jhQst0/BTLXevMC85SmTrfwqPbCH/RIg0yfwpLeZszb77FZLwLliCjk1UmxqbozBV
         f5DroGhlksfbszuEQ8Vg5/tuPGn0gUkWKqjDHrXyRDFhPPP6q6hpttV2XkzAQmeKJ8IN
         VN8uXJnh4WcWiMcy3+YgeyljYI8Wln7Ign4wbMyN8TeVlWdv1FswCBsDxCGvydHApQyg
         MDhA==
X-Gm-Message-State: AAQBX9f4EZqncHUf6JhF+fBSLT0qxh7/YWgIrbkljgx75WZAeQ9Gy9uD
	DOPhuRfwzuHho0KzOL9v2lQ=
X-Google-Smtp-Source: AKy350a0rFqJmrjYHztPCLkX4OglmOF3XweI4u73cqfFZlVau7OOGo8khlTtTEZ29yIiD75Zr8BRLg==
X-Received: by 2002:a05:600c:850f:b0:3f1:7490:e595 with SMTP id gw15-20020a05600c850f00b003f17490e595mr9782161wmb.2.1682343484479;
        Mon, 24 Apr 2023 06:38:04 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id iz14-20020a05600c554e00b003f175954e71sm15623344wmb.32.2023.04.24.06.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 06:38:04 -0700 (PDT)
Message-ID: <ff1eb7b3-890a-7f12-94ad-6951bb1533ab@grimberg.me>
Date: Mon, 24 Apr 2023 16:38:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/1] nvme: add a dedicated .c file for sysfs interface
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, oren@nvidia.com, israelr@nvidia.com
References: <20230424130316.25805-1-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230424130316.25805-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_063806_707483_39FCC3A0 
X-CRM114-Status: GOOD (  13.83  )
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


> The core.c file became long and hard to maintain. Create a dedicated
> file to centralize the sysfs functionality. This is a common practice to
> separate sysfs/configfs related logic from the main driver logic .c file.
> For example, in the nvmet module the configfs interface has its own
> dedicated file.

Don't mind having it..

[...]

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> new file mode 100644
> index 000000000000..8d2aabe2d290
> --- /dev/null
> +++ b/drivers/nvme/host/sysfs.c
> @@ -0,0 +1,657 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB

Linux-OpenIB ?

> +/*
> + * Sysfs interface for the NVMe core driver.
> + *
> + * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.

Not an expert in this matter, but does copy-pasting full hunk of code
from one file to a new one qualify for copyrights claims?

