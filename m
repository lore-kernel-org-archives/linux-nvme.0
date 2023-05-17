Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23730C77B7D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 06:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vF9lD3NAibz1hpQy4bgPq6IEM4SGxX0lLIRi3TZVHaI=; b=DsBgjzioHIVPnv6T1olWgM5g0D
	Gi0jqFG5X9Up0U8l/+eFIc83M89INfWJ/Qqz8uSOy2Kxq1uwz5nD3OMI0wAZJ0Euoxd7Q8tMFTfQJ
	FW2n4+WnowOIFtRXCMNYYorXQ4l6vy+QiM24eTRetSYyUGl59MobGpsNye4AqAzl3kVQLr3AyFrEs
	JTxueBB4AJgg8muozdvcKY2ivoLZsX1OvdUIBIE0+DwnllHQMi6WRnFkBBD+WHqcP/qCD76UBx3k5
	Pg1PGI61wodWYflsXlKTeg2mm8BDYrZIo3c9sAAey17dMGy7QiczSCif/NxIbqp8h3kEHEK32vfJk
	psGFHAsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzAsm-008W8f-1W;
	Wed, 17 May 2023 06:43:32 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzAsk-008W7M-0U
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 06:43:31 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f42379d553so914115e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 16 May 2023 23:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684305807; x=1686897807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vF9lD3NAibz1hpQy4bgPq6IEM4SGxX0lLIRi3TZVHaI=;
        b=Dz6ib1Cuxb4JeTQxPwQyIQeLD+Akd7r60Wd0rFSTVvvartFh9phTmbHuqlZoozUJUd
         UUjYEjZfL1SXQOAtikVPmUakH9T0amhe1LMq2+N+4NKPgJCCoOvQ6SY+8XeDiVxqXKxM
         oitY+j0Dfe5pm4C52nLWKkallwDiJ+htdXe5GnGk9aN3bL6WZ4NJTg+wwNpq5NrxArQW
         RL9GfwDUk69rCtTO/+70AFky84rdlYqEeJvBWfLb5+ALpnOlgDryxiPs/Zp+Rl+wyeP9
         dTcRvMw83JGeuLqgQ3bkDcRR9jpf/TrbloMinYMcgnbBx09Ua6pL9B3L7A6qWgp3fmbE
         8l4Q==
X-Gm-Message-State: AC+VfDy/meXeAddRcqq5UKhk4OkUatYUel2HSQop4ImRBgQ93y1ukr9h
	OkaLr1rXBfPR6ZVvODXFrvg=
X-Google-Smtp-Source: ACHHUZ5MPt4sOTjoGUUXkvmk4G68kB/12dg8gjnDVmvo7AxQ98lhup6OgO9KQfI8xQueymcbHZ+VLQ==
X-Received: by 2002:adf:f60e:0:b0:2f8:15d8:e627 with SMTP id t14-20020adff60e000000b002f815d8e627mr782517wrp.7.1684305807014;
        Tue, 16 May 2023 23:43:27 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l5-20020a5d4105000000b00307b5376b2csm1797353wrp.90.2023.05.16.23.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 23:43:26 -0700 (PDT)
Message-ID: <0097e7c0-351a-b922-dd77-ab414b53170b@grimberg.me>
Date: Wed, 17 May 2023 09:43:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/17] net/tls: implement ->read_sock()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-7-hare@suse.de>
 <da7135cf-c96e-f79f-9d49-87ee269871cf@grimberg.me>
 <20230509174724.4a198306@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230509174724.4a198306@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_234330_187513_548BDF0B 
X-CRM114-Status: GOOD (  12.53  )
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


>> Can we get an ack (or review) from you on this?
>>
>> The only consumer of this is nvme, and seems to at least
>> work on the limited testing this series has seen.
>>
>> We can take this piece from the nvme tree or not, whatever
>> you prefer.
> 
> Let's get all the TLS patches posted to netdev, reviewed there,
> then we can put them on a branch on top of -rc1 and they can
> be pulled into both netdev and nvme tree.

Hannes,

Are you planning to resubmit the series soon? Please make sure
to CC netdev on the next round.

