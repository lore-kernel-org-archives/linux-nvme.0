Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EA7C369D1
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 22:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vv3Lcuk2zHbRg2A1c34733cjx9f4A8lRYudhuogEzGc=; b=29fR6RmNJJ5rTTOBeRUl9PHY9I
	rb5kKRVirpdOk44n0DPcRVa9R10SLRz1U0WJ/fT2kj4pxmJ9tkLShgGLAg1Ip5c37cw0WGEOU8uIq
	MWdxsd1rTZE4Lddjr4i05QPeWoSh8XaLM4CGcu3R/yWybmsUqdhrqJQIbKLmS5/U7deQvVSUov4gR
	QfPxtQmU/dPLKpTzjbnryAa7j15BJywIuaXy8fs7wKc23L8davouWqtqRroaxAh4v16DphtlfpFVU
	QqNj83ZLHhKD3bfToKY0AIcY3zpOYeq/z7TVUKhwHhBjv5VKdVq4EOuyFLcjoio00C5Th0uXbf8iJ
	FWLqqthw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8RVQ-000000012kD-38PI;
	Fri, 25 Apr 2025 22:26:48 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8RVO-000000012jf-0MfR
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 22:26:47 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so27221865e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 15:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745620004; x=1746224804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vv3Lcuk2zHbRg2A1c34733cjx9f4A8lRYudhuogEzGc=;
        b=CAd741GWI7BYbD7XyT51zrO6p4fr3cZJBEG61gRa+nZcrFMoa5Td9Sm0oEx9ia1Bj0
         mKSbPND1EIEcSsROjwi676dS8EcXEagzf6AdqXIXD7sWp81OkF2xnA1gaiK1ovx5PFQq
         2QD2cLaW064nkPY6U3ePNyHOdRl3MygYjr6910beLLqg5+WkYbPtbtYgL0ePQ9Qonna8
         /RYQpO3StkorFVzzqnwfI69NYcQx5PrjHFhvRrkqqbwqsM7IkwgYTXXonrG4hKG0s1nr
         H+xtqwOkoilDF2f3yjkVO+BhE8HrKKxO2uIH1aIaHTE7ux29c8mbSbVT2F5LuIzhYbEU
         0RWw==
X-Forwarded-Encrypted: i=1; AJvYcCXxMHiVQcuLsOjh9tTiRmjAIK5BiEPkF5uERXAq8J/FpodkNnlK+YlRdp+FFKkUSTX2WrGf/mQoueP7@lists.infradead.org
X-Gm-Message-State: AOJu0YyV8arHj4yOvD5ok7vtGZQ4iwM18n0fSUZgNVtYlxCB+MXt2NVm
	bE6okM7w7ARX21q0TivQUjyE/JP9peqnqOmRtLyNwrDX7u4YdaQF
X-Gm-Gg: ASbGnctT8xtRw41sESp7+2cz2MJtXMETdeHqT8XY2R3sXoPs3A+tuCi8RUTSBfUZjWU
	dNOo1o+x64DZz0YH0NE/7LaRdmt/slxvkN84JVzvH0W9rr1+fb0iHWCoV7LTs2A52qfjQSNVaPc
	SBV4dLlJrHunBhrOC95OCp07yujuCeQdook8AjJNck3Ga1ZJpXCV7RN0x2V9ZxwjDomjNbFexSM
	XKxGE4cIdOsFPihUqXxtDt6/vWEoUoUKJ+slqzifuL8BYoWzV6Ou/KvfHkxgxChwALZBJxG4xJO
	ZvD96YWHHKquwZNfyMelfVcT6q/91YB/34D0NDNy
X-Google-Smtp-Source: AGHT+IF/hntH0u4F3AtrTN8I/iKUCb2J5R31WaVPD84iqfJWy5SW4v+i4wSyHBLjvVFqRVV7i8QoPA==
X-Received: by 2002:a05:600c:a418:b0:43c:fad6:fa5a with SMTP id 5b1f17b1804b1-440a66d91cbmr31165025e9.24.1745620004423;
        Fri, 25 Apr 2025 15:26:44 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a538f691sm38542595e9.37.2025.04.25.15.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 15:26:43 -0700 (PDT)
Message-ID: <859e8758-83a2-46d2-81ed-c5199f326508@grimberg.me>
Date: Sat, 26 Apr 2025 01:26:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 1/3] nvme-multipath: introduce delayed removal of
 the multipath head node
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, jmeneghi@redhat.com,
 axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250425103319.1185884-1-nilay@linux.ibm.com>
 <20250425103319.1185884-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250425103319.1185884-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_152646_126765_46BD7D68 
X-CRM114-Status: UNSURE (   5.38  )
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

>   
> @@ -3688,6 +3688,8 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>   	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
>   	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
>   	kref_init(&head->ref);
> +	if (ctrl->opts)

While this check is correct, perhaps checking ctrl->ops->flags & 
NVME_F_FABRICS
would be clearer.


