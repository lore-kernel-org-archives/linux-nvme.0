Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE43C3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 22:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y4Y8GWJgjyJdzkPCuDCjUrgQR4XgPreS0qim9Maq/K8=; b=fedIqbs1EUpH3tPRHdti5urDL+
	DC/ztIp+LwjX6Ttzy/upGsAlby7YrGu3P2pcbYxksozBU1EiEY+rmfXcURBTiCVEKmWWAoubPCcS9
	vIjdzkZ76qHF+FyKNEg+19D3YBOA+B2e8j7OhJcODrs9oQeSVG+hzV2T2vdjwG7lbr8t/P2CUlrpH
	SwZmlicgbNcWdJrDZVYRycg4bi5dMicqpbHshL3rRBwfQyN7Ip2cmJOavVm49Hx4iuiQx+1xnRd3M
	8GFJTYsrv0BrOQrevBoN3RsSjQVhnjd1fJBSq0U1r2alkCGzG7ztS1pubgCJxctYxKMxphsZlEZpJ
	2NupNRGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45XO-00000000E6J-3lle;
	Sun, 13 Apr 2025 22:10:50 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45XM-00000000E5t-24qc
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 22:10:49 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39d83782ef6so2971977f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 15:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744582247; x=1745187047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4Y8GWJgjyJdzkPCuDCjUrgQR4XgPreS0qim9Maq/K8=;
        b=PJL3+8BPVAKRfd1/WGk+jPvoeqSIjXIbguhoOWr6Hbc4ZjBQmcB8ImN7svcgTVIn+4
         kfJufYIfc0KANKYAh/NFXYu6UwAQqLjThLe8eX8JY/M7gVW/WV9UyQ6C+rtnJGMbT0V/
         MwqvTCv7vIyGokdxmn28NB3vvLaA39DDn4ZGVY/JEQbFC/DNcQVTAs9aMzwg9u6HUOU9
         eBUMbTSSqFsargXrmYwUOdwgHf2JE+kyKRtTG0rH8zqAif9rYAei9tjXU6Ep1PW1mhJX
         g4rcmABVT0HkSvagAUtOx0uJdTmqRZclIT3UA5ElPSZSveo66HkCV9z+nlOoOnnyqIlU
         HSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhjC2vSqi0L43wupN6mxM8SFqIzI+YpgOHCXIeJVXSfCdoPJt2MOriOPGxxniaAqkEpNqQvk9eXjhz@lists.infradead.org
X-Gm-Message-State: AOJu0Yzoe571Mtf1u5pLYCXGerSUfE2ejKDpwa/O4A8Mp9FWuFBtJWK1
	sSo+s/2vlMKJ8kfsULl4uY+K3VoYMwdUSPT9tXmoyvbhj7foBb9d
X-Gm-Gg: ASbGnctJCO138S2uHmalaPb6iPFeshRYqbuLNLhVpWCHVMI+JYdJlcyynSwcirrMaIk
	FAFJASGU2g3kh7Bmbv9xhuNAIofBN4wcQPPprgmKu6ZxLKMubCmkkx2m/Z8yv8wtA27NbzhLowa
	aYIEAWuPLc7mah2ky6v/zQJ5LoWJ2x+O4YPSLDjo3bjPsOrGUJ2brV3HO3AD2iPsDgJxRkBfW2Z
	X3qTg3E+3eTBj2JoDWiCUSIuu7OzoK0fCtX3nb8WY1UfHNY/8r9hnynngKCX3oplty4+Hq10rpP
	N6n94Rk7qWtBB4nqiTIu5tAvhq8VzVvymPKuZGldiCrV+dsHGZbUG3NvtdqWjUoojQBguiwO
X-Google-Smtp-Source: AGHT+IH24PRq6NUwCfTeQZTPsdEVr3P0sCKTm0cIW/re21anWuBU5oMiFZBDgbTEzwBNltlxgjlcIQ==
X-Received: by 2002:a5d:59ad:0:b0:391:21e2:ec3b with SMTP id ffacd0b85a97d-39e6e45d55dmr7125805f8f.3.1744582246382;
        Sun, 13 Apr 2025 15:10:46 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf44572csm9324344f8f.90.2025.04.13.15.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 15:10:46 -0700 (PDT)
Message-ID: <f2596e53-d8c4-4e18-8632-baefc17eb7c5@grimberg.me>
Date: Mon, 14 Apr 2025 01:10:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: switch to using the crc32c library
To: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <20250226062841.60688-1-ebiggers@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250226062841.60688-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_151048_541422_E7796446 
X-CRM114-Status: UNSURE (   4.99  )
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

Again,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

