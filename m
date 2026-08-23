Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63340C5B572
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=YOjwco4+Lurz8gRTH+sq9YjakO
	1kcVei7VtF8I1hNcIS/vfdNgy8fQNZX/5OPDvnPdwrA8y8Xnc/tXTQP0+/MuO6dsC3s2pcFDP53i/
	5P/QlnOyX5k/BOFuN47vBXxyua0gLpuPbbSLA9fWNy7RWnqfCTeckyKtyBowxnC/dmkVH5++HonJ0
	5ANibyzxUB6xFUviUri/N5FlDbX8kuZPk8gGNyTbdlrBIpJSd41wTAFJralRkvn6WjToQWEIb2p/f
	2WLS06fNlOfigV4C1BxbQTq55sI2WfTrjD+VdyxMXlmHMSh98sCPi+Kbgt9OOh4R/iZX/eKK5aJkg
	aFb92nvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxw0b-0000000EvGz-0Dkh;
	Sun, 23 Aug 2026 00:24:21 +0000
Received: from mail-ej1-f52.google.com ([209.85.218.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxw0Y-0000000EvGa-1SzY
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:24:19 +0000
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15e592da74so320839366b.1
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787444656; x=1788049456;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=joSXHsP/0hypzBu5JqeySZeviMYmS6B5KvsyV6dfWNXnjhTdvlO+s4fS4An2G6X+QO
         SsVg36n2gVzOKdGolkOPboKRPfvSZky2sTnPS9E+Lh1Os4PXjVFaVuitl6Dix+VpKDz6
         CqRtPxJjqc8krmAdauc7Mq1ln1+tFOHKKj35sTUBpogEbATf9t/QtaJXUEJIEgm4lHXG
         G7EcXyzOCzEfqqJKdblYcbfyRk0/Bv4jcESjQ7TS5pw3HDP6/SMeq9LtSKsMT9bbX47a
         1VvjC6amfPoCPYVUHr1lIdizsTz0oWpS9f0qCqMSXAzaNnp6IWZG61z2KAbaQhavMHpC
         Cm+Q==
X-Forwarded-Encrypted: i=1; AHgh+RqqWpu9UAbqijUzYDoGJ3sBbjnExbduiZcgo8bRmIK+EiKqNk0XupRHKShF7NIOPSRi0ZBMABJOYVUB@lists.infradead.org
X-Gm-Message-State: AFuF++kjWii5jaHLq76/SkitGMjk0UBmhBNNUHlJb/wnaIa5PGKxp2iO
	kKKiEJQ1eDyp77pOE8irBOH1iD96Ki7IYf+kPC3EAZS65v622irfgtxj
X-Gm-Gg: AR+sD10dcaEdER3ODXo+eIE2OnUqkL7wKAubHt0MUZ0jCjCtoEKbx7Ovy4hHCspVVOk
	b+RoJq/ndltzp4TYEuMY1QXrGsqJ+dKzIcegAsx8zCFRq+kyuGd1Jka2TM7XmGgol6gxQ6wEgWC
	q9UT1f57+reC2XXAcjT9so4QT6Loaevv6zhFoEmAMBWvvVn5L/0ANJyZGf0pX7TaBPr5cwFd6A2
	E174UAt7DnZ59fBxWJIkf3HXXsg9sBDNZWV/x6ac+xKsmHdc+d+8dl844KZ8yBjW0snUvBIGTMY
	Ca8dXBTCdMB+IuM9rkN1EInQONM2qMwdUjFQucs6ZOM2CPfFMEkMjuXMmxdycWsZjw4v+FnWB1o
	r6whwMU4T4+SJTcJFA7zf/zMNcthMk4Q0HbDzu1x72ChmTObouVSvKakMhA+IEXkSm4C4fKRkgq
	ZXfoJsbnt4xMTg9KzbIrMTXEDAcEXgprO21g8SSNRpzrdSbSOJvXaHUfREd4FYWIJ+YChhDUstF
	/cf9bWyNZBrwNgaAk5/PTQ=
X-Received: by 2002:a17:907:60ca:b0:c24:6985:d7a1 with SMTP id a640c23a62f3a-c24924b79ebmr990876366b.7.1787444656275;
        Sat, 22 Aug 2026 17:24:16 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24968a2e42sm438723466b.59.2026.08.22.17.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:24:15 -0700 (PDT)
Message-ID: <3d1c6882-9ac0-444e-80e6-9d2bbade8d64@grimberg.me>
Date: Sun, 23 Aug 2026 03:24:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] fs: configfs: add helper to identify configfs
 paths
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-2-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260819155228.84938-2-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_172418_390189_9FC086C7 
X-CRM114-Status: UNSURE (   4.88  )
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


