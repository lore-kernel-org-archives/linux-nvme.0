Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85DBC3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 22:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=KMh7FuRTNCG8I0LnGU51FZSIqH
	yoS3CU5qwjP4fxVwPmLKyqtvpED48XdCzEBqHcXdc5posyjz+DPA8k6nWQC8nMVQYasfWQMfqQMrt
	Wv7rwwGwLd1nOuvW3nbzUG0pcW6pP/6c5D9QE2B+k0I2oeAipYNP3AM6iX4BOGS4UhCFgjSxJ6A7i
	QsYJ6EoR2ANatvUfFZCzTMa8hUbOhegxpN6oZz2XITexbu5L/jDaVpAadObhfA1SBeGiHZZdn0B9W
	Q6+146bKTn3TbuI7X7vtbGuaZpMvq5rPraPMJvwjmx/B2akkzOoa/QL/LNl4PHcbEZSUZPAjylgGj
	sdcpqDXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCiM-0000000F302-2Gsu;
	Wed, 17 Jul 2024 22:01:34 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCiJ-0000000F2zX-2svy
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 22:01:33 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-427beea4ebaso126335e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 15:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253690; x=1721858490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=NZKG2tDAsKyRjqDzg3+fR8F7G4v0gqnPv3gXK/UgTna/mqsmi0mXd7E8vLugb7JFKe
         IC6coZVQi4Bgpi1g1slg+k172pxUh3NdqnDvysZY72t4iOd7Ks6DjXNvNldf/tuIb5Mb
         EZezAIm5FyvcJVlnOC5pC8XyhAJPESqkMXASIPSOU9RT3lj9ahtPI0v+/BIQqeOuN41K
         OJqFrVl3P4kRZf7Hxk6mWIK9v7AIe8KNTaoJYksv1H91v9+aOqUwlhIzmF+bLGKI4XAR
         JmIUEBdCSxGA7/Wl2j/5xeAnr7d3LX60ZBuSlmBzmvFg8SmPxmsuG3SK9ew8UJjfQZqF
         oWpA==
X-Forwarded-Encrypted: i=1; AJvYcCU0zVL9XZM0k3n354Q2NhHv2JVlH0Dn8rf0mpuTqH0Fa135/IGfbskG2qlCh1ipoF1XUeRm/QpOyGHRcD64trbrET0oOgoRY6dhgXsvwaM=
X-Gm-Message-State: AOJu0YwM4DX6w2asEYNvUQ3NdJjmfh+w7d/xYa3eGUo0M+MAbRfaZ9yy
	Wv9uAYDx0ydgJYsl97VbslfzmPIPgrmWXg0Ucj9/d2zT+AqBXCwu
X-Google-Smtp-Source: AGHT+IFJONRftLIFfoQziYleqxMyxchub7HKnfoWpzqvX2QPu53v0f1QXrLS1Cn/fSro+KYykpfBZg==
X-Received: by 2002:a05:600c:1ca9:b0:426:6ea6:383d with SMTP id 5b1f17b1804b1-427c2ca910cmr13278205e9.2.1721253689735;
        Wed, 17 Jul 2024 15:01:29 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c784167esm11625815e9.32.2024.07.17.15.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 15:01:29 -0700 (PDT)
Message-ID: <f948cde4-3a57-44d7-8965-7afcbafc0749@grimberg.me>
Date: Thu, 18 Jul 2024 01:01:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] nvme: add nvme_auth_derive_tls_psk()
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-11-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091031.143188-11-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_150131_733446_1FBAB34E 
X-CRM114-Status: UNSURE (   5.73  )
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

