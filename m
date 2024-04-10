Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17F8CD128A
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=k7HscAw2RCo83tENVdnm6cuzoB
	/kvwl/hthzVfmzHYwUpeZteU0xLNVv2FZJsnEpemWQZ2dYed61YbXzqQxiEL+vH5wruga/5uN2hT1
	lf/RnVq5P+5oWKDO8Zw7gzVAiGaZb3KfkTl24vzJGrP2IZEscx3+3QgNlE4BgmKBxoxf/1zA+UkLP
	8gX0Ef+pWzeibfCksu8r0zu4DNcErjNyvR3zvo71jU4Z17/56NkhYD78b2s0pqeRiG0KcLxYlszoV
	Ec+7rXEJ98r5tMpMlD0NChp/84oTJu2wQaLm72lfXpA7keheJK6tov0j2jzV+j7ACcrJ0iFvmswOg
	mq/cfZ7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruYSb-00000007KJ2-29ui;
	Wed, 10 Apr 2024 13:57:57 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruYSY-00000007KGI-2UIG
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 13:57:56 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343cb97e7f5so1237945f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 10 Apr 2024 06:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757472; x=1713362272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=S4NT92RZpJdreKQ1NaCE6/h27xWpK9eZTp8K+LSZbIWgsIIL3DLuzrNNf6jOihWda+
         I4btuNn7hUc3mB5kZAXq8l78qajaRbyJfqpUdXHvdYV7P136FddrraC9masYBz5Gv4pJ
         XJMn9guCKxwQvKSETqySnVKnhfra6xRJ3hQBTgcCem5ZuOQijiOU6JCamug3TSKEZhMV
         EdSJrKd4eb5Dfy0Rk8EiRK23cIrCnEqrmOTpnIfzvVYrSrUm47r4KBhAiX+KNJlucAmy
         t5sSMd7gO9y724EOHcF5FSTkLFue4cv8ARuh/VqD+Zu4MytoXxXcszCYi0P6Nnhk3kqW
         xrvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzE68dSMgBPuin6IEDHIpSaqfhhaimuaqXVmzBTUViWVFfE2iOpxF5fjlr4IDEWvUsgvIw3zx3gXH2bZrQP0xpwX5yjKPlWCYW/key8vQ=
X-Gm-Message-State: AOJu0YwaiNQf6iHD+kbp53MAzhV0Pt8/larthGZNShaNm0kKK5emmIPi
	ARraO5CwjRQ3m4HBWWLUHoujXxfrQzhSXEJcjeYRowziAQtUhNMj
X-Google-Smtp-Source: AGHT+IHiXtQ7emG+mHcE/AAzbK8nZFKXlC0rfMF0GpW96J1WfM9Yi1kfVQnBYxYU16N1QzZ6PbLptw==
X-Received: by 2002:a05:600c:4fd4:b0:416:80b1:6a31 with SMTP id o20-20020a05600c4fd400b0041680b16a31mr2090171wmq.0.1712757471815;
        Wed, 10 Apr 2024 06:57:51 -0700 (PDT)
Received: from [10.50.4.160] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id bd12-20020a05600c1f0c00b00416645e7e47sm2371575wmb.13.2024.04.10.06.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:57:51 -0700 (PDT)
Message-ID: <1d90801d-818c-40d8-9042-37805f176788@grimberg.me>
Date: Wed, 10 Apr 2024 16:57:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet-auth: replace pr_debug() with pr_err() to
 report an error.
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: hare@suse.de, dwagner@suse.de, linux-nvme@lists.infradead.org
References: <20240410094842.370170-1-mlombard@redhat.com>
 <20240410094842.370170-3-mlombard@redhat.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240410094842.370170-3-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240410_065754_691760_6E8590DB 
X-CRM114-Status: UNSURE (   4.47  )
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

