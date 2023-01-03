Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F67AC46467
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 10:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U7Y/PBHNcjx5tkAEWjXW7oLX3bvJO1/dr4vrz1x5gR8=; b=P63FcoRSBGofIAAxXuu39xfuz+
	meyuGWF2oGkk3wm7EtLGjT8w229SkWUCDTbZG9CfHRiusHlxHZAaJWySty7IIB1m7JK6yreaylUhp
	7epMaXPwwh7M5rc9wpCJk/kifM9bF0YQ6dlsMClH1z+RgYYJ30cf5EfTq/e2tilxYj9eC9wEpzyu5
	ce2IDVUjpEmFTzS6WylcyABB8YtVRhCg/LhUXDz5mJ1wozS5jPZBQfHghhrw5RU7qC94d55H/UcWk
	NhBNsSdZjM08eGRkiwMxmoHlkx6ZGqZtRRv7cddVWH3MD2U82noBcnW6A+2V+pKXm9x9fmcEhmrEr
	LtyJBGxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCemm-000n7e-VE; Tue, 03 Jan 2023 10:44:49 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCeb9-000jLr-Vp
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 10:32:49 +0000
Received: by mail-wm1-f54.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so22728390wms.4
        for <linux-nvme@lists.infradead.org>; Tue, 03 Jan 2023 02:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7Y/PBHNcjx5tkAEWjXW7oLX3bvJO1/dr4vrz1x5gR8=;
        b=iZBE7tY6AvfGkrDa32kkSuWYMj48Hn3ti4K92Dg9PqXacRKKOrD20XXgRXnxh1nw0p
         zJwg19S30QYuYYGDvDfiNRSJBc8LcMoHN3lwuiWQl42MJ8r/FdI+rcHqsTKflWouvqPl
         b0agqkfUSQAOvhgE6qygiqZ1Ji0/H0bBy/p7i7TQBds26w67lPJflG0IcZw1CcibGbOV
         pqKt/6GW+M3cnkIcY0GLAhPBo1+Kjd5wfmzQKjzss7Ay3dlkZWvP5stgJrKT/rsnT8eV
         UH+hZKnXUKOq6dsT054QFISATu2HDPTvsQ5X8Sj5Hgwz3hItWsD5e197AQn+At1mW4Uy
         94dg==
X-Gm-Message-State: AFqh2koIJBW1JB3gQgF9lZaFCNBpw7gqrNWkKznS31ClW6Qtgk1CxXCg
	HqNas2TiUbnkS+ShNSeqv4o=
X-Google-Smtp-Source: AMrXdXsymvHgW7PTFKd7aflrXvA5msnePLCIyvW68eASC6VgL1vEcBxbbx7AFlf/OLTQzyVNmHkdRA==
X-Received: by 2002:a05:600c:48a8:b0:3cf:7197:e68a with SMTP id j40-20020a05600c48a800b003cf7197e68amr31159804wmp.18.1672741966296;
        Tue, 03 Jan 2023 02:32:46 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003d9bd56e9c1sm4638300wmo.11.2023.01.03.02.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 02:32:45 -0800 (PST)
Message-ID: <9f70dbef-ece9-93b5-5b35-e457d1fcb2c7@grimberg.me>
Date: Tue, 3 Jan 2023 12:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/4] nvme: fix reset uninitialized controller
Content-Language: en-US
To: Taehee Yoo <ap420073@gmail.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, axboe@fb.com, hch@lst.de, kch@nvidia.com
Cc: larrystevenwise@gmail.com, anthony.j.knapp@intel.com,
 pizhenwei@bytedance.com
References: <20230103100357.875854-1-ap420073@gmail.com>
 <20230103100357.875854-3-ap420073@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230103100357.875854-3-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_023248_130262_E7C0F17D 
X-CRM114-Status: GOOD (  12.00  )
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



On 1/3/23 12:03, Taehee Yoo wrote:
> nvme-fabric controllers can be reset by
> /sys/class/nvme/nvme#/reset_controller
> echo 1 > /sys/class/nvme/nvme#/reset_controller
> The above command will call nvme_sysfs_reset().
> 
> This function internally calls ctrl->reset_work synchronously or
> asynchronously.
> At this point, it doesn't sure if the controller will be reset after
> initialization.
> 
> So kernel panic would occur because ctrl->reset_work dereferences
> uninitialized values.

This is strange, the reset_work func is assigned earlier than sysfs...

> 
> In order to avoid this, nvme_sysfs_reset checks
> the NVME_CTRL_STARTED_ONCE flag. This flag indicates the controller is
> initialized fully. So, reset logic can be executed safely.

Same comment, the reset should fully fence the controller
initialization.

