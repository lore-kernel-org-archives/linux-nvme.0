Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59551C4725D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 09:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kc3Br6sz0MrSKpxB5AuhZ7gmBL0uXvfl+0jO6EHhGY8=; b=Z2jA7x2/ZLzkazTGrhH6dBNs5c
	0/X5iRjuRww3TQQR03kj6X8scpxE6/k4EUEcZsj6Il+LTAS16oHZZLT3i50VZ3fZHUeCw+kPAQuf4
	UB4/Gww5G8/jDY7k6aT6gvC6+5CAt942XmSf1oaZaRGiQyq7lQjNfQaQI2xtD0Koov+sJYJcLa9rz
	0Rb4NGsuaLYYUKbMJnvQZoz6NmdDy1xlfTFi7v+Xl4/NewZ8LamD22MMX1QkkhbxKfpnnpnflTkjG
	8HP5b9WZijWcTtfXevH6BdEdFCqOTsHeiQrTFBUo2bz8iP1VmYDoiipSxUXPddbeR7GGBnG8wPSwt
	uRHe0IKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRqVd-00BGVz-1j;
	Mon, 22 Jan 2024 09:22:25 +0000
Received: from mail-lf1-f53.google.com ([209.85.167.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRqVb-00BGVK-0a
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 09:22:24 +0000
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7a0d07a0so356699e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 22 Jan 2024 01:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705915341; x=1706520141;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kc3Br6sz0MrSKpxB5AuhZ7gmBL0uXvfl+0jO6EHhGY8=;
        b=pbj9txDs24McGCBnx5l5u0n4hI/q+UpLN78qRXW5ki6h8UtKDHUTRWiBzeSo262fX1
         yz9Yu65ocGNmtVE+6vyq51S2a+u3fa4Xk5ZQc5H3RIzQGnUfl/a6BttwWZlVm4+vQ7MI
         1qYGnOCoehpPE60o/7QCWCxwUHuBIPdxUS5slskKhYRzu9/PbgrbA2rNAgHvjuQ+dsfg
         lVNtOkpQnMh0ffmuukIa4joxFhJQJWve05VKE062TKMW5mbIfrgmVXhk6Xux8lKUSIqQ
         TcVtWvJ0m7WvYH4Rg5IOFpH0vkSBLbEDsIW/wOIte9sxQWOTNUTT1kfPcmAz+1OX/Fh0
         eCpA==
X-Gm-Message-State: AOJu0Yx1n1uQjO24VKW+RpAcZpb+3dLe/B4zISq4GrPrnCl5n+pcmjR3
	gzZUSvpNxwwvT4sRfkZLzL1YwDr+xTG1pPVkFNLVc7s2OISLIPKLeK/7Nof+
X-Google-Smtp-Source: AGHT+IHavSm+sjBYYNitKqZw6ZB72IwtGaSCZBQv+ysTUZ24NKA0ZE1A1H4L9BFnJ2QJqW7/XeAhPw==
X-Received: by 2002:a19:4f13:0:b0:50e:7b2d:3618 with SMTP id d19-20020a194f13000000b0050e7b2d3618mr3223572lfb.6.1705915340468;
        Mon, 22 Jan 2024 01:22:20 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b0040e549c77a1sm42269726wmq.32.2024.01.22.01.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 01:22:20 -0800 (PST)
Message-ID: <943889fe-029c-4579-afc8-eb7837c9d74a@grimberg.me>
Date: Mon, 22 Jan 2024 11:22:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: unify aer type enum
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240118125145.57983-1-kanie@linux.alibaba.com>
 <8b9c7433-1f89-4496-a60a-93e2f587096d@grimberg.me>
In-Reply-To: <8b9c7433-1f89-4496-a60a-93e2f587096d@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_012223_221567_8A9C962A 
X-CRM114-Status: UNSURE (   4.80  )
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

Resending... didn't make it to the list, probably smtp issues....

On 1/22/24 11:15, Sagi Grimberg wrote:
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

