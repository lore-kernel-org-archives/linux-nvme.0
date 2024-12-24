Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F3DE77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Dd2cFVEhdEti5mvcf8zmGgVU9p
	QGNkQlm+nK+ASc/D7esUY4a/j4r6++036QjRWKI2kZOUcBocb5VR08KqjFAgPee6EuOFwM99wJ7vX
	wwmveTNjY8voQm8Y013sARjk6YbM8vB2N8oaB+FiQd8AjF7GMY4C0z+HJhvqi9qbLjbQA4Q7ts6VW
	SKOOFy3Ifk2y9dkthOet4mhiO87wugC87ZWdPPMzJW5CjzmIk4xRnMSoxhI1cYJP+bHZ2Xitg2cMq
	EtOfNIjK2w1a2vdsfccTXVU6LJ+609HoxJfKFCjSwIHQhn/U7bwZSgBQ33kfPl3NVpQ25pklfBKyk
	t7SpZVxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ35n-0000000BrA6-0Eri;
	Tue, 24 Dec 2024 11:28:51 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ35l-0000000Br9l-1D5B
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:28:50 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862d161947so2442058f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735039728; x=1735644528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ZtqErv+I8K+z0A0XdlvX5eqRgUaXBH2OETOpS8rGR53yTtK94BaTe+1y7CYHq9Zato
         zBHp71x7yTTZsHtrA286gnLIiTQ525iFRHGeZLiYuQ1TDSNzaVxwAxvulEbQ5Titi4QH
         1d5UF3JP3DnBZHG76wd1zhNzWkYbDYvOjyZdhU8sR2ZN9i6/VTUK9eB6JA6yJSFMS26m
         ON4Sp2fjOF82vUTz5QWSxfYFuq5pTQGFEyQEsHZWbv7gtodlS/gCf5HgBPGqrYg0AcP4
         ZtqBMa3Yn7si6hu9YNwTFS/muP8Kdjw9N609YiShpV2kejkIEdiUW6fGcjqYNpU3Sx//
         OJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJSAMgKdjmj5x+EUUeMYu9R9wmy5k3Vl3jrdXGHV8AY6vj/UL314ywp51dOtQEuIe4L6MW2VQUzzep@lists.infradead.org
X-Gm-Message-State: AOJu0YyMVXe6O1tvM0XOfXhPi9h5aslKQEewSwbjLGM/oGV/lcnt5TmR
	Y0VoGuEc9Y40qstmPXiKYoADS9C9Uw1Rp0HwJtfShkGlhpQUXn96
X-Gm-Gg: ASbGncuJyQ6UsomslSJuw8fGXM/zuHVxoduBsISdI2vNMaga9WJ8GKNutJs7sVXY2Km
	DP+ApjProGCNzv0Vw3FwzT10uXnQHdfrpihqu/+VG0zfbtMmksn/e1ai4eYHp7/V3jVlw8g08GJ
	7zbcZJ04oik9d3WS4dVTzh+tRa1gvjBhFttSDQLWkKIlUaJfbjBBV/cTH3xqODOwV6Pu+N/dx1K
	jpfUooeqT8JYMjAz5QqALJYePTaqQPEDKVL6/uJjE6O4X01Usl3aN1exyjL+r1VPRnC0d/rmwH9
	Dmn2/Ja/thrtdip2sRtknAY=
X-Google-Smtp-Source: AGHT+IE0YTh6SpD8khtqeGfZ8vSwyJWn1yZuDRKzU6EhaH+Slwgxp/RmtR7VUkdvzwr3uCTlNWfNlA==
X-Received: by 2002:a05:6000:1acb:b0:385:df19:cbf with SMTP id ffacd0b85a97d-38a221f2e1fmr15407689f8f.28.1735039727491;
        Tue, 24 Dec 2024 03:28:47 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a28f17315sm8630170f8f.108.2024.12.24.03.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:28:47 -0800 (PST)
Message-ID: <0f1e5f43-5377-481a-8cc9-0b533224873e@grimberg.me>
Date: Tue, 24 Dec 2024 13:28:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: remove nvme_tcp_destroy_io_queues()
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hare@suse.de
References: <20241203033955.394595-1-brookxu.cn@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241203033955.394595-1-brookxu.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_032849_324891_22996623 
X-CRM114-Status: UNSURE (   4.45  )
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

