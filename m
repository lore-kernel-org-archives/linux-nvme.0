Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A51C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 09:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aEF9SMDKSQ9iy2AWYPt/c2qz1iwfRvfFHK33USvjSFA=; b=qTRU7iXY8hpvWlPaCkRA4bib0D
	k9e9UloFfMgkgKIWyXrv04WCggEKo7Hf3C0JQt58/MkLzOGfM5IPb6BPFylhV0bNYxp6aNDMqgilj
	Dw/sy+0JQWQW2UCvz8/qM2puOeu+VZVCDfhqq4xgng8T3G30+L1vIhAxciRUdsLv12uugjcIca+bs
	ds+gAJKvrmf+DaJX+cPLPhO6+AjpSaqNMw6TRv74eGjalyFRBkg9mWVPz0TfJ/tk6+3+0Gfcg37mW
	tUw8SZp2ykDOCxHDB4OG+rxlZBI8YOeeYLxEWn1ixS1UKu5uQ+Is7Ek1Ir57GX9pP/pvWhADBYgVA
	bCYCxBaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx1qB-0000000FSzi-1v8u;
	Wed, 17 Apr 2024 09:44:31 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx1q8-0000000FSzJ-0OAB
	for linux-nvme@lists.infradead.org;
	Wed, 17 Apr 2024 09:44:29 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-349a35aba9cso81868f8f.2
        for <linux-nvme@lists.infradead.org>; Wed, 17 Apr 2024 02:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713347065; x=1713951865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEF9SMDKSQ9iy2AWYPt/c2qz1iwfRvfFHK33USvjSFA=;
        b=NaZc9zZMYX02JHa/cFKW7+1VGSeoY2/KNNu1rs3mDD+4sS4b/gGHpN4AG4qSVioa5V
         z8SlwnLcoHe2vOb9YyUc8T5QEI8hC1VAhoWJGJc6NpIbcaPbLrQpa4cNPW/vm3PsnvSx
         rvtOl/swpdHJHFCIC0l4kefvLQ3nGyZoEhWq7XSJKbVOvmh0PGXuomuojfsqylVwmkkC
         4Y0XR1ohldo8VGX26uuyyFJ6weSD7WYBOZAj9OrOLsAZfpoQPCm1yss9NVK6J05l1h6w
         bsOZwyn1+Gil4lgoiaiPRow0O8yEgQUy3ksimnUSx6Kn0JvAKaRWE0OZGX0jRTO9u18K
         biMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWovIz11xaaJCaTXu09uOxND0yPs4EiJkQ8rnPNNw/ylJb1OVsxriQLKqcH0M8hMc1vkRj+NId00MiFhHGMAopjEa06mDWqKt8xw/0RQ84=
X-Gm-Message-State: AOJu0YwYGtq1VjyRl8JoBf6V+8NakfoK6mL8UfWJXoqIuDS7JYKjHMaq
	ezNedxMUV3f5K0HSuDdufOi7E5A0dlKZjrEeopE2oZZwJ33YeeLY
X-Google-Smtp-Source: AGHT+IHOetHi7K2fiQf1cVP/txdsPGgdtQERFkt/w+cCcNfmfYlJdIBKgXmVwa+/0t5KCzXo+f/3JQ==
X-Received: by 2002:adf:f308:0:b0:346:500f:9297 with SMTP id i8-20020adff308000000b00346500f9297mr10879960wro.2.1713347064591;
        Wed, 17 Apr 2024 02:44:24 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id di7-20020a0560000ac700b003439d2a5f99sm16935509wrb.55.2024.04.17.02.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 02:44:24 -0700 (PDT)
Message-ID: <2ed308dc-95d3-4f7c-8c3d-134f5ec56063@grimberg.me>
Date: Wed, 17 Apr 2024 12:44:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-cli spdk plugin
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Tomasz Zawadzki <tomasz.zawadzki@intel.com>, Keith Busch
 <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <xulnfwru3jfl2nooq27yym7nx3cdpxqslzqz5nvwnkymncapnt@pzascju2tmvf>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <xulnfwru3jfl2nooq27yym7nx3cdpxqslzqz5nvwnkymncapnt@pzascju2tmvf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_024428_260742_756DE93E 
X-CRM114-Status: GOOD (  13.86  )
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



On 17/04/2024 11:33, Daniel Wagner wrote:
> There is a PR [1] pending, adding a spdk plugin for nvme-cli. The
> problem this new plugin tries to solve is, that with the recent change
> to use sysfs only for discovering the nvme subystem, nvme-cli
> lost support for spdk.
>
> My question is, should we have a special plugin for 'list' and
> 'list-subsystem' or should we try to get this somehow integrated into
> the existing code? So that 'list' just works?
>
> Obviously, it would be nice if we could discover the spdk devices via
> sysfs.
>
> Thoughts?
>
> https://github.com/linux-nvme/nvme-cli/pull/2295

Can spdk emulate the way nvme devices expose themselves but in different 
path prefix?

something like:
/opt/spdk/dev/
/opt/spdk/sys/

That would make it completely transparent to nvme-cli/libnvme that can 
look for
these paths as a fallback or even in addition?

