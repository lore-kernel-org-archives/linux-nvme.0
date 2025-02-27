Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019C2C021BE
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 10:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=2YJQt0t3g21bFO5ChhupdnFK+7
	E/cN00ujUIbAPCGbPzGgrJ7al2d8gl402/OEz9bSRVok/ri+N8W3/BWJtY9iD/KQzglBFMReYC4Fh
	91MnSDqtf11nJVAXNIbCwd4kWi6Ka9qeOFkENIEygosmTtypmQCAwRbcnNsLS2kVqRDuPljIeLHVt
	h85VfyMgWMLMJaM6qcD1GyUKpCu7MqrMe2eIHWXMHvkh2Au6KGhn+CbEpmsDddJ7K51G/ssZYMjlK
	MmrAl8ZPMFe5rXaGQ6NGKHtbBgdydZkrFdH2ptOMBreYK6nvRvKUqQEF9byRnnvVClxabJGTJ3j4g
	nquDKhNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnajp-00000006wIA-1ir0;
	Thu, 27 Feb 2025 10:03:29 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnaih-00000006wBd-1yza
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 10:02:20 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390e88caa4dso127869f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2025 02:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740650538; x=1741255338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=N6g0Cgsq3iX/FjttDbVGrUe9NiFU5m/r4PKejMqGd5A7euNL5tufETCpKN9Uzz4vYE
         3Af71MWn3vl2hr1a1Ozxux7+7OfIVvx7eLkJGS2vI5qQ9s7Ey5g89bi7IoaDEEzQY+am
         Iu4r9uQVva4XgazdBTjRS/l5+r0stikoTgQGWg47mRxCo0iyRvKglZQ6H0xIWVFq0Y3E
         NSg9QNIUlEEVxSsJnZDff6Fq3675z8xJxVziShQXe3O4lGXtuw9ibuhthw6PNZxcRcx5
         r62gM+dcS019LsZkHMINtd53MnGNc6MeJJYlygBXE+zrQi/Bq+6+2F4IIMROmbHUNgYW
         +OYw==
X-Gm-Message-State: AOJu0Yxe5sEoCgVM1Ny/IA3wZNWmIf8b994LgWNIIQqZakSxc9PnfxVp
	EsXya8yk9DMg5/dbUGQPJf4zzgRXJ58SKb4A0kSVFzIe0pwD0p8METVVhHxz
X-Gm-Gg: ASbGncuuQNTDQxQ0QP0VA9O5IdT87DHqGqlZDer7HyQ7vhFQqUaP3INNUokNZf9sXbc
	2qiygAcpGWqb/6VDIluEtU0n4jeDAJY7zWSQwqsj/cK0GJ9+TRFTnkAtaiBUQ8RB4DGybPSVz7V
	G/TnXjzQOt/FMmwlAZ5K641O63Xj9hUL6k7O+rQXDccf6UNOYa6CXoSaI2jHMH9jV9we+LLZBf0
	Hi6KQ3X0n2PDTqf0/P8KxyecpvO5Da8xILzYs4S8aS1tmG1VpFeA8ZES5asrsddjALxS0Zs/q0y
	pLcXgtJaZLaIEqnHXqvxK6A1x6dQaybHt2cnudmswtJTrRY3SxFWS7JlD+PGrbe+OII/
X-Google-Smtp-Source: AGHT+IEVo7CEXkSW4O/BU1v9ig+Y06JWx64s3J2y5a208uF9l5c/hptgo3IC+n0aeGmULr8JFinkOg==
X-Received: by 2002:a05:6000:1f88:b0:38f:2ffc:1e99 with SMTP id ffacd0b85a97d-38f7085d549mr15941737f8f.49.1740650537584;
        Thu, 27 Feb 2025 02:02:17 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d6dbsm1491505f8f.82.2025.02.27.02.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:02:17 -0800 (PST)
Message-ID: <e1fb673c-15c5-44d9-82f3-9bdf37b1aba8@grimberg.me>
Date: Thu, 27 Feb 2025 12:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvmet-tcp: Fix a possible sporadic response drops in
 weakly ordered arch
To: Meir Elisha <meir.elisha@volumez.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20250226072812.46089-1-meir.elisha@volumez.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250226072812.46089-1-meir.elisha@volumez.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_020219_511993_60B14B1C 
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

