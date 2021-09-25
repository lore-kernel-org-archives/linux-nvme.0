Return-Path: <SRS0=MUCY=OP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13549C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 20:47:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8625B60F70
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 20:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8625B60F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=NZrFjUQKpxHqh5wBvOPjjK6HtE
	BvF2lrt6DUwakj9QuKo8c/4So/R5FSlMxhLM2+DKTb4Queqr910MdJoAANodYofHV41/3veld96PB
	0dkSF7LcKVC/4JYeEmGDvVb51rci1BcioBVGo5jQDjeMUBkDts+Nemaywi71y/6W8v1MzgVO0gzEL
	d07ZsjWe0dJ6lMKYqf4QBW9jWnwfTJrqau2UrzOOISpYsxZVJooKgM73NhA4EM9gRHLDGGXIV7GQu
	fLXVAeWFeE+vRdRTrmzLvbwt3mvn5MJkXXOAZSRmKbsa+LYPm6eJonGJxLQ6ynyQxbiJvVNYW/tfy
	3rG/oi/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUEZp-00HDxF-Ki; Sat, 25 Sep 2021 20:47:17 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUEZm-00HDwm-RT
 for linux-nvme@lists.infradead.org; Sat, 25 Sep 2021 20:47:16 +0000
Received: by mail-ed1-f46.google.com with SMTP id v18so15506051edc.11
 for <linux-nvme@lists.infradead.org>; Sat, 25 Sep 2021 13:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=UIw9Wxl0lVbPAi/y2yCHHDXOL7ZBD77RYnxl4DSA0aUOcpVsi3SEvVLVVnb+VDAnCv
 5QIB5OcQzNj0yRRxzkdvI/UYgv1rE4v5trmq7aNQ4JnBmee6U8bWerrXXy5IdBCnxaZt
 N3aoxQPL+czMOJsQ0Q6d7H7M0Q+KkGYfaJ1UEdfhU5BkrOUscgMB9G7y8wq+hGQaDQaP
 +CiOSicXlFUKzCcMfb+pP9PNaeJKq/KZ7Ybzj9u7gJ/QmaXSyoG9zkPru0U5X2YCMafe
 Qvi5rr8I2+PO+++6eLuOdtsss66fVQvEXIGcoKq1Jkz8wk24LjCW1JkoiHfTBq+WJs5V
 HV9g==
X-Gm-Message-State: AOAM532W7srHw1HDmDJQf2L8CZJyEtGbNuGzjmycN8qe5NemHnIwA2gJ
 KKTy+LCNQiwPoEe+w9rVLCXcjdH9bpo=
X-Google-Smtp-Source: ABdhPJyw6UPoslsCu8vca3acwLG7tleBpc1A+YmaFXflSKy0Fyfuaaev8Pum9bdpBpIComcVo11IoA==
X-Received: by 2002:a17:906:31ca:: with SMTP id
 f10mr18227187ejf.73.1632602831920; 
 Sat, 25 Sep 2021 13:47:11 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id d11sm6666403ejo.35.2021.09.25.13.47.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Sep 2021 13:47:11 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvmet: use macro definition for setting nmic value
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, chaitanyak@nvidia.com
References: <20210923101744.4204-1-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <df6da607-291a-2218-d1a4-81bbfab9eca8@grimberg.me>
Date: Sat, 25 Sep 2021 23:47:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923101744.4204-1-mgurtovoy@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_134714_923616_9D75C628 
X-CRM114-Status: UNSURE (   8.53  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
