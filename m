Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2496C47DDF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 12:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=acCD9Y9JX6uIKO7rLN6ujwJ8O5
	KRY3kYt25xLgEFPDwqslkRHjOPbXvNBjWJJEDmLBqUqywktO9jOGW6yDP6VX8NKzgojiubNsyR80A
	VI/6JX5PjMmXw/uz+3Ceyv2lDcpATRZbuEVTnqe3d9fvo6jRmFPxVTWiAzhW5AWKiObw/BzH1u/Ld
	uCHSCH5b+SIVjvAIP6JSg7Vfwn3GBrnLy9SVTbiMz4TFzl9L276Yfzkr6QztJdzJj3r4EwiBnsBWx
	GNkwhm8hlKmnqt9mQByR/KPA/vKxVUx9f4nVDjv2+sCI6UwXogNPfkt1kRTSjFPaYuH40jyTOtvIy
	CXUiN9ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rScjI-003Lj5-0B;
	Wed, 24 Jan 2024 12:51:44 +0000
Received: from mail-ej1-f49.google.com ([209.85.218.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rScjF-003LiH-1i
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 12:51:42 +0000
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3081516dd7so87608166b.1
        for <linux-nvme@lists.infradead.org>; Wed, 24 Jan 2024 04:51:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706100700; x=1706705500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=iQX4vZDfh68/lSRmZOI+YfZFw0II4HrYvGmm7RMt9oqbLsycTRjPr9DTk6S6yG2Fmv
         ahrzN2ZKhmBsguejnzY84R2320FbUXhpQnmGL0J8GrE0qI0WZocEL5QILaBUNw5Cb8ax
         cFxMP51E9UVFfWjyc0HMRV8dbzFGMBi4w0q9hO5aGsEhTISOHIOEdOwUD6Xupxm65qvl
         MB/hTg9I5cqEyGf1+MzQVNWBneCFu+jCzxRBuBav+gI+122HYaXsfSOPL05z09xdStYb
         ynPcsCBdREAkx1bqnf3OmxjrkQ8oKVcKvmxFEYo8qDcmCKJlwMIK2vO4g99yv9zYKKIV
         aswA==
X-Gm-Message-State: AOJu0Yx9DO2wwLLF/I1tUqyij78WVQ/SPmzTtkRE2yo0mkiibaMlPvdy
	ZfwJU5HJ+h1hFYOEUQWybzoPObpRn+rXKwirQ11woSpdbTMjV1PFuzhBEckk
X-Google-Smtp-Source: AGHT+IGN8zKglltVVi2ChiUxoD4ZW7N4Fs6bdL4N04Pjah1RjkOx2+jXCE8hiXrezuIaXmmC200QpA==
X-Received: by 2002:a17:906:c10a:b0:a30:d080:93 with SMTP id do10-20020a170906c10a00b00a30d0800093mr1688322ejc.6.1706100699716;
        Wed, 24 Jan 2024 04:51:39 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id vx6-20020a170907a78600b00a311a360433sm653189ejc.143.2024.01.24.04.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 04:51:39 -0800 (PST)
Message-ID: <439e2665-b00a-412f-a460-565a253a200d@grimberg.me>
Date: Wed, 24 Jan 2024 14:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] nvmet: add module description to stop warnings
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, james.smart@broadcom.com
References: <20240123221341.7902-1-kch@nvidia.com>
 <20240123221341.7902-2-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240123221341.7902-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_045141_568362_0D48A886 
X-CRM114-Status: UNSURE (   4.87  )
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

