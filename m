Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5C3E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=dwvbDw3RJH7Rn+7YQSkhGZxJap
	YvKinvtwmGo7L3mEuYVJ4X2IXAqEUi0jjpS71qvZb/WV4e2jL9TxffkZ4OvjctR92GArqLuXA4dP4
	6+4yhD61yvTR0ZNCvPSLd2+mWSZbqGsAXHLWZ6KANQ9wSGClRaz1xwYp0RaSGlnFYga4EvUUfwgVj
	/AnMTpCr+0gFZsUlTpXkLcJtm/cVx60vtg2AmMk2S+yXqZ7FZoa5WjgAI+9vQ5W67twigI3GjDvv7
	FS/sOqAv4fOb2gclVP8oP+2gtN6PdI3J7SxyqgsJ4ueE4/KcvV+B2rdVubIU01r/3dp1apZ34UBCd
	LH7tL45Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWNpl-0000000HBdq-24xo;
	Fri, 10 Jan 2025 22:50:29 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWNpi-0000000HBcX-3mb2
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 22:50:27 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4368a293339so29153685e9.3
        for <linux-nvme@lists.infradead.org>; Fri, 10 Jan 2025 14:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549425; x=1737154225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=pUiJrE5q/aDzlvuAe7kkoupBdMwSqVdWmT/fG8a1IM1XD0zfCpOlFjpkSZEX+hmr3I
         wZkxzkmJvf0XM1bWvGkiURdTE9rip09OjmCqrZaaW2kMmBKHpMlslbmZCXf2dOY97YKc
         zH0i1CMpv1gL9G/mpDhwEFmmfmU8Q++wJjDVChx6Ji5v7QWfBQmlosyUAdans7nEYSWT
         XaTRINZmmXbQRD7w+sZvsfD62ZDvbOi9v9no2guHhZqmKP7wjmWR+gS8IF4HL/JWQZ+6
         vXWCmXeiCgfjKPLhxbexZ/btWMInBbbS3DXbdPMa4H6SZyf58rQ6R5pYb66UXgJcCSea
         qeAQ==
X-Gm-Message-State: AOJu0Yz/HINYx1OzmlEi7sm2fUMblnQgj+UaTKzgQt4oeIYzvAXbO3Pz
	Oq7aDriOR7CSiI/Pn3Dy7JBbwWjnyPrnYtTX/VfgAPYY1VObYEi2
X-Gm-Gg: ASbGncsrztNk7lLSQNxSl+PH4w9q3KH2CCdFXv/J6XXab7ncw3cgWxyCrGzZgsGqEJK
	rug5euGP1adzYiidkvW80F+Rz/VcPZquwQQtrzKqIRMXtsDT5UQ8HWStCMnHioHkOTleC2cuc+C
	xpjmTjKi/L3MrudXnjZ5eq7jb0zT2w04m16C7Li4HicPCvO0ME4M0EB7QFe3utP9f/KKvjHMSaD
	+9wYbhJrJx7UgmdGP+ZirN3337k6/y2Spgvc40IpAVx6ZViz/yYX4/+Ce7WnYCz1uInyrY2D/CH
	9knpToUnMX7RGOg0
X-Google-Smtp-Source: AGHT+IEbcCvklw2TSxxgwRBf76EWyd3GBp1Qx2lsYng+hYnmUj9RpGRKSCslJbar4DjbuIt7HTeFPA==
X-Received: by 2002:a5d:6c63:0:b0:385:ee59:4510 with SMTP id ffacd0b85a97d-38a872fb0f9mr10230099f8f.9.1736549425047;
        Fri, 10 Jan 2025 14:50:25 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38f0eesm5728948f8f.61.2025.01.10.14.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 14:50:24 -0800 (PST)
Message-ID: <7777bb3c-5bf5-4346-88f9-0ee458084259@grimberg.me>
Date: Sat, 11 Jan 2025 00:50:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: Add error path for xa_store in nvme_init_effects
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
References: <20241216152719.17923-1-keisuke.nishimura@inria.fr>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241216152719.17923-1-keisuke.nishimura@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_145026_940719_B9DD12E6 
X-CRM114-Status: UNSURE (   7.10  )
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

