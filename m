Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0583C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 21:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=k+BnWS5OeSY7CsrCJh6P9WkyqV
	idEb7a1dmhfjf3X6m0nAf/ZAeStynY4yu2Nm5dMrwXd6dPXfZ9Mb5TJrqXPgCyli+Gtkg+ghO+Xaq
	JhXJ5XBG5P2aQsgr2XLfATYVrqtLSkFPzPQN4wXTdz7+vpMCKC46fKspjhd6VD9Lr13bOrP3gKVe0
	Vrr1C1KGiPdU77L7NFG7WRb8AAqxkKWY1meKKP55nkpmjrCAjBcMc5SjDCFoB1G7/VN07ZC3IhhiH
	yilKH0XkVlgE2Lm0wliEOyl3vzoA1N0UykH4wilffg5MjAYP1eMfGUGCcJEhTYpatTvk6SoOMuGrP
	ee2VaD3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCcU-0000000F2D7-1N0v;
	Wed, 17 Jul 2024 21:55:30 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCcR-0000000F2AV-02M9
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:55:29 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-426719e2efeso244465e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 14:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253325; x=1721858125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Rmm5q0kmoVmdZEvjWDsMiVvV24SFs5lwUf48wZSPqGCXY8KbJ9OA2qdGKOEAwjOqsm
         Fcipka9jNXTnpvHck853ZscWOYUKsEDbMFHrdTWEevhxztXkruvDIA0GVQ3aKK6bzLb+
         UDTeKbXKTzuc44HbKVPoMgqVP7gKrmLRqaSSvW1vcA+JR5q9QIs0zDIztVZevhF8RrHw
         SFkeylQ1CD/vHsQH6V/iz6Y1w0Ve8u3QMFAWfP6YmoIpXA7f2zFBX09mI4RFg/W6fGDg
         GrX9CVSa2MBF2xXPCv+ArXhMp+/wg5CwMfbjaABgms3ivZ6hDTOgk2QGq+dUl1060Myg
         R4Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXgQyZ5DUBwzjAToYgqICwmG4eBqfCGJX5BtqD9s1vuaJ/yL4ILqrd/gTWWwrxRZCbml9BwsHRW2LaeSYY/dC49IXrH415aqnB0BPluGSs=
X-Gm-Message-State: AOJu0YxY4/VahGgo+KGc9y1pOaVz/g6BO+5Cz7wQ8c5lXbY2cFrVfBSY
	8tWY1aCu62/aQ3dDjzHU9bbNHPLgVZrxOLV/hTi+M1ipF+zidRIE
X-Google-Smtp-Source: AGHT+IHRj4XIqCSlGZzliwPD0Dkb2zUX8BZjjryh5wPGhj3+a97/qfQUPyo4bxPYXeCBlBoHVfpmWw==
X-Received: by 2002:a05:600c:3ba1:b0:426:6fc0:5910 with SMTP id 5b1f17b1804b1-427c66cc312mr9321095e9.1.1721253325534;
        Wed, 17 Jul 2024 14:55:25 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7840d3dsm11604525e9.38.2024.07.17.14.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:55:25 -0700 (PDT)
Message-ID: <5e5e7fe2-5ce8-4302-8f7a-c10eaaa661bb@grimberg.me>
Date: Thu, 18 Jul 2024 00:55:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] nvme: add a newline to the 'tls_key' sysfs
 attribute
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-5-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091031.143188-5-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_145527_054240_684F7930 
X-CRM114-Status: UNSURE (   6.13  )
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

