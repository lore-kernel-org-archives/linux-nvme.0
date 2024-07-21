Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487C5C3DA5D
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jul 2024 11:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=XRlCnwrsHBkca2z1tHnANV7NFj
	QP6firs391PLIzAzguDxM3Gd6auFeANnSc90OcDEKJKzzC9j5Gpki1fvUKe0oyc4pUfUHYjCNh9B1
	L5VnDAKaMD+T++FK4Przr0zPEDq66CLgbN7f48DHeITUFGceRRMVgYpMGKhZjVTjrNahF5kTZYOfz
	xm5Ku80PKLtI3wOpG2J5xkN9WyOsjVBbOk8lNrNx/VOr+WzuWZ4JxHLVEsHeNwvXF0t78Ox4glAEI
	eOhgv8Me6F0WZandDxLpBbIiaYoq80OcpKR7x+thor/bo6y0hvoCCkomPVHe2gtdYzDHbOoV/V+ec
	Q3Z/Hhqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUYF-00000006i3o-3oZR;
	Sun, 21 Jul 2024 11:16:27 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUYC-00000006i2T-0ZJn
	for linux-nvme@lists.infradead.org;
	Sun, 21 Jul 2024 11:16:26 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-426744ca29bso2995925e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 21 Jul 2024 04:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721560582; x=1722165382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=nJ9NeHWPXaupBjw6N7FyW5rrHO/hdcxgIfiC4B1wwlnXeRX9JD0shk+BN+WK6AzxS1
         MHkyVEqlzkphuXWlQao/hRY5Xk3kYcQDWnCsxe2HcKvNOmspByr4/Bhrdma7Mz3MhX2x
         GcLyOpJfWyJTAkkwhPC/Z7mqgZakP4bMZNTVLPNH+RA8Ghrsjl+D4fRemaU37x+Ve4a/
         XJVgloiMnH8Z2PYoHNi+1Ut1rzPZvLjwEzT0ZtDbDapwYN9aQxdL7b1DGacl9rY0b/EL
         aZc9kuCRya9HqaGJ5OcPhEIvRmZ8LGx/tpqaj3v+XnK1F2rNuYYLAJDbUTbvet+FebBX
         nBnw==
X-Forwarded-Encrypted: i=1; AJvYcCX4q19jGfwA/ZeJT4cf63yFsTlFh6KxGN8HgRX+AXWVLzn377qa2hdsyVj392j4PCjmDzltgzWD2ko9YZKxjqr1U+bygj3UWC9EEQGdKc0=
X-Gm-Message-State: AOJu0YxnmQRrumHInayqvvk5pbFEMxcy0OubKaU++wK1R6+3QNBZguPz
	mjkWhPbesK3Sh7a0DDt6RZsGlkNN6xJpC/l6hS8cp3OvhWzsAP/G
X-Google-Smtp-Source: AGHT+IHyhtCSK39F7ed+UCF+1yJapgRf/+AZNjXEdTW+UN7AW5kVQr2czKl3zWm7htzFLQ8mfrqPUQ==
X-Received: by 2002:a05:600c:35c3:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-427da99aedbmr21560215e9.0.1721560582473;
        Sun, 21 Jul 2024 04:16:22 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868ba9asm5772507f8f.41.2024.07.21.04.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 04:16:22 -0700 (PDT)
Message-ID: <6ac933c1-df1f-49ae-b319-57ce53883a8e@grimberg.me>
Date: Sun, 21 Jul 2024 14:16:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] nvme-sysfs: add 'tls_keyring' attribute
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240719083901.35399-1-hare@kernel.org>
 <20240719083901.35399-8-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240719083901.35399-8-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_041624_190349_B8908554 
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

