Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6806C3DA7F
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jul 2024 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=tR1qOM61JGY/ed5g62FdZ1jLEz
	Vc5msGCH3rZXEoo+JEMytSLjkH3DrYxMA6okKXAVJ7CvPax+H8dQt7eNWDWrwhSbM8/it5Z1o/J+/
	n2yGfZfmorY3oVmc4BDRqcNWToMSl85ovfHa3IG7hlzP9iFAfc2uyCtJbSJMTvcS/rqdR6YGtuoKg
	ui9APKCLkqTAsahUn7fb7FFmWgyoXYD9wU+SOXbPXy16XX4ICsWhzoTBxRJIPXhRBm9D76tRXrsPR
	bNKbayugyoA49hAcXWMUXKDG0vs4zdYsBJxvWIrmayHH2S0B9noJSfftp0Qv1BYEP5wMklXYtCxIM
	4utg2pLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ5wG-00000000bFy-0K7v;
	Wed, 31 Jul 2024 09:48:08 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ5te-00000000aKc-0JwX
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jul 2024 09:45:27 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427d71e746aso746505e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jul 2024 02:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722419124; x=1723023924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ed7jelFWx2Tv47j2F4LbT4nTFu13fColEqVamoSnSHCHuPe1XUWD/F8W2I7jkX30Sb
         axeAuVO5X7u6Vi9GapTUQOB5VdULQh5XV/pEVh+cEbrqVqSYDoxCEf5CIWT2NCb3dONJ
         F6mJafhZoUfexxwRUmVbn1DEyJkTOZrNgHtpQYv+0OxZYvq84kff3UZila5IKfgZWhpm
         ao4rLTPpcc7lYZgC63+6KlWLWxzD0iYkzvhseVTVqvqdlktF8hxAYLcMxvfxHrTPv/we
         GESr3QfkoN4zuwMEx7bj2TT5KuLwoVvo9bz9YQckzjuD9rUze0gXoflU2sJLGUsGPtC3
         RnKw==
X-Gm-Message-State: AOJu0YzIgE1YL8oV/dhDb62fBzuaN/LVPVnyFnLF52rP4JdUTqLt7g/g
	Pwd0deMlH8lWT6WvsJx7HERHjIbWsM6t2GgxeZQaYpjTcjAWN819
X-Google-Smtp-Source: AGHT+IH7/6x6wCCffSg2N7KXSEJeNAEemLArOs6wl6DDe/KYkazM2ZngC961Uo0S0Nbqv1EjIrrd/w==
X-Received: by 2002:a05:600c:3b87:b0:426:668f:5ed7 with SMTP id 5b1f17b1804b1-42805700160mr87928175e9.2.1722419123914;
        Wed, 31 Jul 2024 02:45:23 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bba2833sm15285875e9.45.2024.07.31.02.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 02:45:23 -0700 (PDT)
Message-ID: <1eb7c6c3-9a39-45c7-8bd7-4649dc75a26b@grimberg.me>
Date: Wed, 31 Jul 2024 12:45:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme: remove a field from nvme_ns_head
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20240730103138.66714-1-joshi.k@samsung.com>
 <CGME20240730103942epcas5p3aecd4ed3b49c99fa3e14b7b7e2d93ba5@epcas5p3.samsung.com>
 <20240730103138.66714-2-joshi.k@samsung.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240730103138.66714-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_024526_150517_FAF98145 
X-CRM114-Status: UNSURE (   5.06  )
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

