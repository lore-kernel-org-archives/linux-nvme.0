Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C70C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8D2WgAzSZip54EYxNiGNgBDLk/v68fpqWt3QVpTbJLQ=; b=I386xly3A4ZZqBPIdZMWoBup3t
	4GKXpm8fK/TGFanajw8HkuVWY/359LVcSpz1lEiY5ERsg8fFeqDAzBGocwgH1duYHZUh8CiOTFICy
	Q/mDk12UTbfvoVWmkF4K7sXkjwRz9KXpqzDPqHyLeqSGthEkSwt+h3wJNivPu89u1mLQII6Lh/XpC
	4EKMgCxBawTpYSdEDfOM/S7WQSzvXiOPEPOJH4egud7W/qJFfVqmJm1Th9h7kF9CXyb+3AkcX8XDX
	TqXnvfIQ63Eu3wR9gLrbSu7BtgfuMyNePRvVOBNlos1/3bduWcjpZcoLy+9ZGPxW+HNIUnTLIWAwF
	gCIfjBow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO7h-00000001d2G-3kwc;
	Thu, 18 Apr 2024 09:32:05 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO7f-00000001d1e-15vj
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 09:32:04 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-349a35ae298so58057f8f.2
        for <linux-nvme@lists.infradead.org>; Thu, 18 Apr 2024 02:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713432721; x=1714037521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8D2WgAzSZip54EYxNiGNgBDLk/v68fpqWt3QVpTbJLQ=;
        b=BCUYCkdjOHuuXQMM8ZMwiOHmI/Zto9dylBZZ7NBfw43KTIEyGZbWRuznFGvT8uR6bW
         JjTLDnjpQGKSStg7LRF1puNBKLReh+FeSmAYVLKmWy+3Hq40mN5CONgCLAaUPGB988Qp
         yhoHXeWs8D7ezScZ3Za1iiiKZc5QABd6c/YNc9SRlCoXvUBmcIMEjHJIXskAshh+ks8R
         vPdYDKlORCZWgdlJtv7o5P8OihUL5mtRL2KaGRDxD1qmymTAmxvZI1pgkdrOmS2gmXCO
         0sd3jgbhkMRoQr234yztFdT+hQth/l8dIzkMv3htSlUt9TRacc374LBeieUmxN7hibMQ
         QUtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPr+bGG7Vl0gREtxtP1pUuA0KSgdm9N0JD2Q7Sp7J097nvyT9+a1oWrAqVET5E7kHsKwUlRQdDzDlbm/L1k+ji9F5jQVsEE2fwLQ4S0zI=
X-Gm-Message-State: AOJu0YxxJlN1zTkCGGLV1IjjR4uVTsWnfRuFr16gYvRUIeYVzlN7iL1b
	qGKv4VtHNPChgnTn4PT7RRVseTn7PX29qrA2IfY7Qe3mOtbGBBy0
X-Google-Smtp-Source: AGHT+IF5zcQfE0dR9E7U5Yr/uVSWtFvXiMEGi01+aqIemxJPONnEvUlMo3sruBjZ4MDoyTYx4QB5Kw==
X-Received: by 2002:a5d:6392:0:b0:349:e1cf:33a4 with SMTP id p18-20020a5d6392000000b00349e1cf33a4mr1389919wru.0.1713432720895;
        Thu, 18 Apr 2024 02:32:00 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b00346ceb9e060sm1356930wri.103.2024.04.18.02.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:32:00 -0700 (PDT)
Message-ID: <556b3fb0-bb64-4d62-ac7d-84756cbc2a35@grimberg.me>
Date: Thu, 18 Apr 2024 12:31:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-fabrics: use post connect auth helper
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org
References: <20240208062427.31255-1-kch@nvidia.com>
 <20240208062427.31255-3-kch@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240208062427.31255-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_023203_333270_6E39D1EB 
X-CRM114-Status: UNSURE (   4.11  )
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

same comment here.

