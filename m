Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA89C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 10:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+PyeWkhuJYg+ePFp+kSJvaI5luSTG8Uu2UJZLlj/UZo=; b=zOXrWaD6/3CchpYo6jl5dPBsA5
	NsenYarcnTqm3sgCZGfcOZwFAO6RMoH7TAKecEBqzGk+aXRwWVexnm4v7cmUj1Oc09N8qQmDp2fkK
	Jy+zNSDgmlLSFJiWkRIi0tXG8RmfdAZ2F5XcP1RmLZGha+NmYs2cxi2MIYqvY4iTn9rknQOBzk1HA
	mdMB/okrsFwLeTMhv9KrfrLvUP5sZkxs1IhZzdVd02R1/4jEw8/z3hSa53+ai3GMk46uBO60EDsJD
	p6SKHZ4dV+aDEwM1LVmF3sw5L+gBKuNQFJ4wi69/X050cF+RneW7bKz6Wjdof7BtJd7Zfd9ZUtHAo
	nGlLaw8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7v6f-004ppd-0P;
	Tue, 28 Nov 2023 10:14:17 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7v6b-004pog-38
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 10:14:15 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-332eac4dec4so784467f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 02:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701166443; x=1701771243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PyeWkhuJYg+ePFp+kSJvaI5luSTG8Uu2UJZLlj/UZo=;
        b=Gl3XtvuEQUTmwT+Xq2T1dR/U2eA9gxrqBECvYr4XQWcsYhRlgsOINciDPtzUVDT2Xk
         2my0eAIwAyYwzDQrkUbnarGe8udp8eYucmq6RdPsAXsJY4x6rXUgsf+4ajI9fckmVN4R
         XQ6FVB9JP4qJKzFERroLwctUYFo88Br3PHN6zt84ATfASIdnrbHq8oGWSrN6ch3B950X
         1d6e1K/8PmdwPovDcwLI7I60KyxgXNiTdK+rwM/aDOaKqr3JpURVsQBkvrsti3fn6ZvG
         fkWa1W27oKN5sHUXHL2uo1mak992DksvDAtQBZgDHmIZ1Qsxtwh9ZIh3FMNiCE7yBCdG
         H1Og==
X-Gm-Message-State: AOJu0YwxO7Zvewd+ZPGzcPfx3nYG1ur8AqtVdEhU83cGc15sRzgdmd5V
	d8MzeZ6JsDyhrxKileLacOQ=
X-Google-Smtp-Source: AGHT+IEhXK6aT8AMyc8alUu1ytihrGp9t8QAyTCs3EnK5NY0yhosUs59INceD/+o9lskOO1cBHEZVQ==
X-Received: by 2002:adf:e7cd:0:b0:333:7ad:58e7 with SMTP id e13-20020adfe7cd000000b0033307ad58e7mr2618743wrn.4.1701166443159;
        Tue, 28 Nov 2023 02:14:03 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a11-20020adff7cb000000b00332fda15056sm6524961wrq.110.2023.11.28.02.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:14:02 -0800 (PST)
Message-ID: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
Date: Tue, 28 Nov 2023 12:13:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix deadlock between reset and scan
Content-Language: en-US
To: yaoma <yaoma@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, kanie@linux.alibaba.com
References: <1700737213-110685-1-git-send-email-yaoma@linux.alibaba.com>
 <ZWTa0DJmcLKHRWWC@kbusch-mbp.dhcp.thefacebook.com>
 <65b0c372-b308-46dd-c2f2-a5ddb50adb10@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <65b0c372-b308-46dd-c2f2-a5ddb50adb10@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_021414_035090_B61B95DA 
X-CRM114-Status: GOOD (  17.05  )
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



On 11/28/23 08:22, yaoma wrote:
> Hi Keith Busch
> 
> Thanks for your reply.
> 
> The idea to avoid such a deadlock between nvme_reset and nvme_scan is to 
> ensure that no namespace can be added to ctrl->namespaces after 
> nvme_start_freeze has already been called. We can achieve this goal by 
> assessing the ctrl->state after we have already acquired the 
> ctrl->namespaces_rwsem lock, to decide whether to add the namespace to 
> the list or not.
> 1. After we determine that ctrl->state is LIVE, it may be immediately 
> changed to another state. However, since we have already acquired the 
> lock, other tasks cannot access ctrl->namespace, so we can still safely 
> add the namespace to the list. After acquiring the lock, 
> nvme_start_freeze will freeze all ns->q in the list, including any newly 
> added namespaces.
> 2. Before the completion of nvme_reset, ctrl->state will not be changed 
> to LIVE, so we will not add any more namespaces to the list. All ns->q 
> in the list is frozen, so nvme_wait_freeze can exit normally.

I agree with the analysis, there is a hole between start_freeze and
freeze_wait that a scan may add a ns to the ctrl ns list.

However the fix should be to mark the ctrl with say NVME_CTRL_FROZEN
flag set in nvme_freeze_start and cleared in nvme_unfreeze (similar
to what we did with quiesce). Then the scan can check it before adding
the new namespace (under the namespaces_rwsem).

