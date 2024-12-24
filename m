Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDD1E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 10:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=BtG7jNvbs/6aysqldqld3S6XBT
	7X6M5woJxA9agJkVqorgU54IFvUAaxguuELJwsy8+3vRKTiAcgHVmlO5pMbC2/Lwup/OYAB9ycokJ
	3YtBELxHvnzqERchwDXTEs/COe8fcMTco+6kr7LGy0DP111hVjz6DQ90oneIuzSXmdrqGIqabdJTG
	QN178baj5Xt7kAISNIROPQvgp8qafqJh3djw7RMU5cCb0qN3OfSlq+2mxpvPvS5E9kidOa7AvNZ0I
	A991h/rGrqE4VoseZD+M8ra6ePKjawzDnyRAruuYzSl9Up52oFDzjX7+SCr+qDrpXk33La34qSWZX
	tCZU3bjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2QH-0000000BnPI-0yPI;
	Tue, 24 Dec 2024 10:45:57 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2Oq-0000000Bn7E-3umT
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 10:44:29 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38637614567so2268247f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 02:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037067; x=1735641867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=DRr7sHc8rybjH5tlW5PvQ6y6yjakXRnHwd1j/j8GLejtMFq07sYPrit44Aqp84LgRY
         afwGY4yN+0uw3FqzShCDfaLM0HPOQstaY4xBg1U7xniq8mqKqzzeBN0E43k7a8yCP753
         y3pEBWeOaQKCJ3KqGCT6TBEIAzs7e/rqDellj9DAst9mzxAaXx9ce1msheb4cq1uQuCe
         gQpiRo1yBIKeDdUi/5LvnZBF2cynSni6E+Coa7+WPZcwwGbYWGHfY6Dkh41CbOKpqFNh
         yBaJw0CxMFjlMy+Swca8rM/Oed70Gqjm/TxXTJHu2ag1RhrxbqlyY2Ica3ujt/Gh8CRg
         Y23g==
X-Forwarded-Encrypted: i=1; AJvYcCUm5wss/t2BY28Sp8PNQiNsKCtClhIhY+iTV3YUQDV0ThU0qozMnZn6a1O1NbbAKtCn42sutaP6kAFc@lists.infradead.org
X-Gm-Message-State: AOJu0YzyjvCG33eBRjwt7XBeSFEuU1zFzD6lLj1rOI2N3umqjV4ETVF8
	39uRfMfjKLKUMuZ0oqJ/mZcGiTvZoox85jUuOZxFou4HCYAwIPQXC8B07w==
X-Gm-Gg: ASbGnct1fP6jbSor0dU/lvCt84+SSxgxuRu+ZE39WC0HD5aBwf7eXniYee2DoqHGlhi
	bNk5OY81BNU/hCuDfNQp8/oRThJCMvVG8SFtTxSCNo3EpmCUM8dkCO+AMw+azfoAxMpOtoMMHqt
	8o/Or6YlDIQkhzj5uRalxlCAPd61A9rV4g8G4L1ZVPOoqzPhEKOVijtarVJ/0uoFexCcplVrKsj
	VX7dLknujYkIQanQugYb6SitcUvlClhC42UtA3GZmlouhbVVyUPczu/2Idv2fJmqqGvjjSFwgO3
	yr3r5E9YNXGiDlZmeagdMKc=
X-Google-Smtp-Source: AGHT+IHxq/iA5grijNAymPWay23D0iFdsFNkmhYOlxQbOIIanspFe78QUP99gU/SefByF5UHbl8HKg==
X-Received: by 2002:a05:6000:144f:b0:385:f271:a22c with SMTP id ffacd0b85a97d-38a2240e20bmr15043579f8f.59.1735037067445;
        Tue, 24 Dec 2024 02:44:27 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c4d7sm163226825e9.34.2024.12.24.02.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 02:44:27 -0800 (PST)
Message-ID: <47f88e5d-e262-40e5-87bc-ea2e30ec8bc9@grimberg.me>
Date: Tue, 24 Dec 2024 12:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: core: Convert inet_addr_is_any() to sockaddr_storage
To: Kees Cook <kees@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mike Christie <michael.christie@oracle.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Maurizio Lombardi
 <mlombard@redhat.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Mingzhe Zou <mingzhe.zou@easystack.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Simon Horman <horms@kernel.org>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 netdev@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20241217012618.work.323-kees@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241217012618.work.323-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_024428_966166_D59880B5 
X-CRM114-Status: UNSURE (   5.83  )
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

