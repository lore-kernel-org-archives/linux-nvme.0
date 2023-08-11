Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8021CC04E69
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 21:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L6HRkLM0SkoQZVLyx2qLkyNekZfBcDgxJqKY8rpzcgg=; b=qTnNExtAVi2UR2SI8EptrKlygh
	QSbnAXvE9xU/OqwafaiqEUBotb1tXFaRDGgH8n0Y+YfBUmhCKr48VXZh+goBk0O8+RVY3WzS9xtDH
	p8Y1s1IQg/APOzsvUu5D4vq/J9Ba/tw4lk3xg2+w71jlRSpa19JX/Yo4Yspwr3U2GY6hswMg8TzrX
	fQHYHYrXEnf1i7AQGtmC7rDnaEOkWY6MDJmBENB16vkZNJqaMeHs1nup+355X1XtrIDFOwRwba93i
	tcTn43EP7kHXgim9OQJbSAzahc0K8uJyKvti7zg06vaocujLqOANt9O6u3sahlJABSLD1Z1AK/zx9
	HdCXaYZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUa9a-00BjqQ-2x;
	Fri, 11 Aug 2023 21:58:42 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUa9Y-00Bjph-0p
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 21:58:41 +0000
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1bc5acc627dso18058455ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 11 Aug 2023 14:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691791119; x=1692395919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6HRkLM0SkoQZVLyx2qLkyNekZfBcDgxJqKY8rpzcgg=;
        b=CfEjNuljkmAQ89h038bSqR48tNiG/RhTWwwo/RZBUvTQYWVF3jpl1F/ZPSPxl0cEF7
         b/E0fZqAujznh0aXrBWN3jxsVmH8lTInIn8DWGsMZnGSFa1xuanbdj8gO5NQGGhazTne
         89r/U5YIJ+h9xT9Q8NqvhmMhQy9VHtIgPSifJVVt7vD+hgbkwR3N1u372ZO24ytCk74Z
         3CorAgEAE8HEE84jHNKg3qwHcCnESrPQ8k4aGoBtgquREJUCHtb1VACPtNLQPEKE9+At
         meQuEZLGVjx39kD7IiwL5pGfCLD1X1Y7xU7vljcoIIWhZBZ0e1sdYYyOSr+CDbUfunjw
         bazg==
X-Gm-Message-State: AOJu0YzZ/6Vj3V+/Qt7IDJ8T0YLO4I3WVfwlsFwJ/tf2tMBbokc0oaru
	O1eQrRzO2hxpgO/S4Py15Wo=
X-Google-Smtp-Source: AGHT+IGwHdIE3Y5YV9a/4Hh9MIcPpfsNQVJE3AlI+jbV6QV1hWBOlM8CNMnC6D2YYbg22mOHJHHRnA==
X-Received: by 2002:a17:902:b907:b0:1b9:de3e:7a59 with SMTP id bf7-20020a170902b90700b001b9de3e7a59mr2960940plb.10.1691791119094;
        Fri, 11 Aug 2023 14:58:39 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cdd8:4c3:2f3c:adea? ([2620:15c:211:201:cdd8:4c3:2f3c:adea])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902d34d00b001bda42a216bsm4135429plk.100.2023.08.11.14.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 14:58:38 -0700 (PDT)
Message-ID: <355bb623-9cd9-fe33-106e-1f091c09fb32@acm.org>
Date: Fri, 11 Aug 2023 14:58:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [dm-devel] [PATCH v14 02/11] Add infrastructure for copy offload
 in block and request layer.
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-doc@vger.kernel.org,
 gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, mcgrof@kernel.org, dlemoal@kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20230811105300.15889-1-nj.shetty@samsung.com>
 <CGME20230811105648epcas5p3ae8b8f6ed341e2aa253e8b4de8920a4d@epcas5p3.samsung.com>
 <20230811105300.15889-3-nj.shetty@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230811105300.15889-3-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_145840_303310_62F2453C 
X-CRM114-Status: GOOD (  10.52  )
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

On 8/11/23 03:52, Nitesh Shetty wrote:
> We expect caller to take a plug and send bio with source information,
> followed by bio with destination information.
> Once the src bio arrives we form a request and wait for destination
> bio. Upon arrival of destination we merge these two bio's and send
> corresponding request down to device driver.

Is the above description up-to-date? In the cover letter there is a 
different description of how copy offloading works.

Thanks,

Bart.

