Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B336C0218D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 08:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ZERWVFTpxzNieM7oj3yk+7vUt1
	zYHl0c8URdHmYCjOwI5gNC8Zj2rPeiTPHy7bQNlSNaW8u2BvESJWd+WR0CMf7B8qob8G5KZXOfXyS
	5ZitAl3+SuQ0CLq+M1lnrvjsvlLdYJASpMfCPW2hgudLzky2r6355dF7yqCCpQ/Y4rCHEvMDkjG7l
	HN80ryAPd9wP/zRxvPIf0s86VAqJ/crj5ypIYSVq8/YKrsy6/8t4NjyzA0syLXUJwvzZpnAlSx7AV
	MjOMZSkYhlIYZborkV8lhYxcaWcowXK121kRccN9jxpadGPW2vQjBkFKyJDywD9POY1xkPVzulTzC
	Nmvj7n/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgYu-00000004KA2-45Sc;
	Tue, 28 Jan 2025 08:03:08 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgYs-00000004K8d-0fuA
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 08:03:07 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385eed29d17so2738677f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jan 2025 00:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738051384; x=1738656184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Q7zCoeI5+TnqZSxWoJCH28DqMq76w+3tz+2r9BgCs1wODjNPdKvyC54GeAuboAWhiG
         usEVr+eKa5wwlj7efvGPaqMewJUNmpFSXs1MpsIhl9usJa0JpMPyN7RtJWXnkHiN9mXE
         zIV95El90EKvGKYm08LY/3gPY4E9j7b3ajpi+YuDLhsRl5FPy44hOa1lxqp9vj66Mkgh
         XJjMsF/LGlhodQDl+Jj9L4ouOFJIKcUPtAlKbJekWnPe+V9x62z/MemNx7Nf82F5fkz8
         KZyS1yB7Wc8AbPWIoh0MdFiyUgV628ajI9qJLw2scpqgJmnlIeYdSTHUtiA8on6TK4dt
         Cx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKEmLL39G9VsZHkFb0k91TaKz2alLH5gOYIaMCy2mDHf1u+A7lggm4djzzYErecpCPA481ruWg8qC6@lists.infradead.org
X-Gm-Message-State: AOJu0YzgZh1ehIkLltufu7a0wN4lXyDfUkj8MZyzcqwtInHJrMC/XWwm
	J7jOxxxz0q1lDi7LeY02qJfdKy/8y/VBtj5Z62GDIScQcTHXtEV/
X-Gm-Gg: ASbGncunNUO324AMF4yJJMHUgSPDHATYh9/uyt/sja4xeQI+4kMHj40zU5fpLDRRctc
	VEsLkYNdreze3VMkLogW5tCV1EgMVaYvb/Zv0FWpJng0WOsl+CMYn/nOgJiwbb3rkt82ozVtyoQ
	d2k2fUGA8bemSrtdF6YqmQHG06QCdBoI9aBpppG0lgzuVuEyYxS3VlhpUf8qoPRSZFsSfH0FaWt
	95+eh0GjOIu02rOh1wLoE+e5EJPd8oVj9AllJ+NiSYkqKLXP9bhCHX+pOP9U4P+zFnfpo7c1EB4
	AzWcNwkZvY6PRY2zNnU4k9PDDl+JPK+9CzHqSBYhRbf8jkQi8QcnEh8gyg==
X-Google-Smtp-Source: AGHT+IHCh7Uw+GLbaXGm1FHPllyEQJwGrC3ZJyszZY1zZFyiWKtl6ZGiGIjx4ggD+VhcbOzV8as4FA==
X-Received: by 2002:a5d:5f4d:0:b0:38a:614b:8632 with SMTP id ffacd0b85a97d-38bf57a6969mr47457779f8f.39.1738051384436;
        Tue, 28 Jan 2025 00:03:04 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1766d8sm13765126f8f.14.2025.01.28.00.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 00:03:04 -0800 (PST)
Message-ID: <bf553543-5bf5-4e97-8b17-7a96cd2c3c01@grimberg.me>
Date: Tue, 28 Jan 2025 10:03:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet: add a missing endianess conversion in
 nvmet_execute_admin_connect
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org
References: <20250128075539.693870-1-hch@lst.de>
 <20250128075539.693870-3-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250128075539.693870-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_000306_198062_1A2FDEA9 
X-CRM114-Status: UNSURE (   5.77  )
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

