Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4730C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 07:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=taIqa6ZUwxcQAEJXQl8Mt62Wxo
	gdQKa6cOBYsUIqYg8P4T5QpCjJWSA+PVQoVDeR7Vc3bVO8A4HRNvMt1kuQtABDoxbxoXSwp6O0fP1
	wMCUXi2/5OR82QHK/22hcLkRZi58W2Iz5vE1dg+IhIFXWYvDnqCnbMgu7y6MGFJnx3Y9CCp1e69WR
	UHJjrQKwmjSI1oMiYO36rIoqtJ6/Z2BOFAHGt113cOnINUVRmAR9LIi7VOSO/NIuB15GvDj8/l2vU
	/I+ZvsEVp098NI1rARIIos2WQ3UYNOGGSab53oraGD/3A4EzxeY9uuNLqP3yFNvS+eZ67Iydm2OcQ
	YKZLKWvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8MB-00000003T0s-3Wxi;
	Thu, 07 Mar 2024 07:39:59 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8M8-00000003T04-13yC
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 07:39:58 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d855caf7dso136967f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 06 Mar 2024 23:39:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709797194; x=1710401994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=I1zcrCb8vVIk4AorkTotHduA6O4aWU+JKLzceHb8Byo7xyOVHu/19tgQIWuVgaeygS
         3Wa0RWVZc4D0ad77ZE16+8brkNSjzKLizEWQij7xA4/oKo38xT4L/5fRgVE14Gr9obfj
         All5XUUS2j2Kezh+WXOxcMhEO69pcI+YHDGbSUZsiuRQa1fE0PYWfeYtRl9kVlakpVvK
         sEYXAxZ62FGJFAgs6Gwn7hhDGW3b+kp6CNAPb+p044K4TTgKDSCGBt/8IgNF1YzRf8lj
         XnXgX2pVSN6LMrvU8duDIHhNnTyVVOb0/aoUopgxQTkxt8vL3X1QiITJEijVJCdVqQ9l
         n/4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlU4Po/kEV/q31NDjOUGp7fpCPLwxK6v7/4zunSheMtQE5wk0ipSZLUDvdqWd9KHmvD8oc9WLmRpSXUZOlyXToeVMXz8489Fgp0mZLVm4=
X-Gm-Message-State: AOJu0Ywiz+QINB9+qt0eJGRF5ygC/o7c4oGNOz6GXHPvWxp6n0gQjzcU
	v3hHxqsoVm2qEq7VHv+H/kdf2vNQyO9pG4N8uo+4z8ftao4mnkF5
X-Google-Smtp-Source: AGHT+IHHA6QKnLsezv1ouyL4F6PQAR02XSpxiQiCnDoo76btFiTKNzBGsZ1UC4cGPITyjK4VMXd2Ig==
X-Received: by 2002:a05:600c:444c:b0:412:eee0:a5e4 with SMTP id v12-20020a05600c444c00b00412eee0a5e4mr829823wmn.1.1709797193445;
        Wed, 06 Mar 2024 23:39:53 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id je13-20020a05600c1f8d00b00412fb4f5756sm1696207wmb.27.2024.03.06.23.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 23:39:53 -0800 (PST)
Message-ID: <91726839-6c3c-4b22-adf4-380239e45fa3@grimberg.me>
Date: Thu, 7 Mar 2024 09:39:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: Use pr_dbg, not pr_info, when setting shutdown
 timeout
Content-Language: en-US
To: Len Brown <lenb@kernel.org>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Cc: maxg@mellanox.com, axboe@kernel.dk, hch@lst.de,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
References: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_233956_374089_2AA920DB 
X-CRM114-Status: UNSURE (   5.03  )
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


