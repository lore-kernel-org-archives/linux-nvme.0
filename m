Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65E60A261D
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3XZpehkS;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G3KFZySr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Bt2PQaCOWWl5wAhg9mJHVrkNYzA12/JaAR8E5rJGHP8=; b=3XZpehkSRz1e2U
	9xEwxgtlCS1jKnc9IDxqbZGBJq/hXQVUv4w4sWjZPMzTZCyy9FwkAgEBmxj3PpTdQsBAQF+pQ2kOK
	L1KPHzYMq6BXhirBdPenZVc5hLbBjoXBqtZCyrAxGdUlvPMAnGLkdRISkkIqudhzjZ+3p4Tt9QueZ
	LjKPKI6vHt0BYXjKa8j50uWTuOWA0ZhnCVJ3CnRwQ+KkgjDWSFxPVJuG9ezbtJ5KgP6bVYT2zGv+v
	aTIIHl1OQrQZ8l+74s4Cohv9d9R0FMfo4RQIVjhnblLuJKbtkr7w1QmG+jfzmAtUCrtSgiOQADbv4
	60ibc9T6oMyB6oOsGcdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNq1S-0000000GHPp-0rwn;
	Mon, 02 Nov 2026 11:16:18 +0000
Received: from mail-yx2-x05.google.com ([2607:f8b0:4864:41::5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNq1Q-0000000GHOe-1dLL
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 11:16:17 +0000
Received: by mail-yx2-x05.google.com with SMTP id 956f58d0204a3-67a3a16844bso844148d50.1
        for <linux-nvme@lists.infradead.org>; Mon, 02 Nov 2026 03:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793618174; x=1794222974; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bt2PQaCOWWl5wAhg9mJHVrkNYzA12/JaAR8E5rJGHP8=;
        b=G3KFZySrG4Zbxho7upxBEJX/+aP1cWWr742eFiYV+X4Ru1jiMXpvmWj39VF7eHOZVc
         YzxbzB1m50GFmdkBi7C5jZTrE0zAvi3voKHP1IGE05Zstm+TURpH2X0iXXVksQL6/aVl
         aDoZjNl8W7rENJUgAeRjKkFq2wWQKE+gDM+/KoJzCIDR/PepGJMAbvBALn9q94S60bZK
         jROXHV4lVA9up6Bu9CjZldEmDBI0phdVglurAwyqZB8X4BTVF6sXFnAogB9OBvtD/yJg
         dePawtVmf0NgwlSPAtNgN+XaHgsyv2cc5RAxxn0h9qlzJLn0IvkplSxqlAsBOncrmr/r
         EIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618174; x=1794222974;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bt2PQaCOWWl5wAhg9mJHVrkNYzA12/JaAR8E5rJGHP8=;
        b=fW/B3YUpf1KEcjuCyjuf3VcH3UIRXeAZkxPkiySN0k49Dlay9upybThgENe0+G3fQR
         kv/crU83ncs/1wtZZ3cfvJn4iRv/EiXnk+mIMCBeAxD9errRrWHi/hCrpTFZWlWmIFzE
         fjgZxlWBDEUXcjef0sZL4hSBXt08Sw8pVAOxs/stiTFRA+eL8c4xvmT1Q1JdOaV3FUAy
         /wi3EE01j5LnwhwyI5Tu3UTL9cWzqHpjMCycQhNEeEkflFxIhU2I6fjh+VsAAZ9naVXC
         pXaKe3wp++7L5PHp0vi+BemZSmTO4WJ0fC/0LSsOmP7MTyqbCazewL+cD8bTmFOKVM1A
         doBg==
X-Forwarded-Encrypted: i=1; AKwUvBy9FWWAiAqUZv8F1/f0RzxBIPhe0+oEWr7j/Y+TSQ3mukdhemw3uEgbZEB6UJo085KQlqIUNHwXrvg1@lists.infradead.org
X-Gm-Message-State: APuU4Z9w8BRV8Q4h6ir0uDx3HEygHKsbG1HOxNCkvCY3JkRuC0xwdbho
	DyVzKbQg4387O4g3Zh5kVdbV/0eo3y44CMP5Dda3Zoq48wEbNpazqu+a
X-Gm-Gg: AYBFou0RVgYJmrIlIsFitARnGeXoG1quZfkGatNvmqtwB0mYkJopHzGlJy7itbQfRQk
	HrtraguJ6ts/DBdI77hm7vfJe7RLMAP0z7GUkl9qTtaEuhfEQJ0kBiJGeDe44VODhN2x8U0XNez
	omsh60CTV2PTZK1f10Bim5tpFoHqq1ep7RTAgvf7mb2/0YwI5PofXGwtbpWHAQT1gNS9R2b6tpb
	gctMGpwshmNYlxOCG+bXhdfGNxBMyhV/Qo9NvjChUlN8bl1RMBgVRfuEF+mWynteEu1iq+R8zV/
	yeZSqC+xjzd3CVHC5HxlB3UFjozA1ZQ6KzgTbWA2oU7uGimnik29dXgPSAITOzBV/7eXzK1Ph1k
	8syMxXWB/yNkKCrFDxvB2bn0ZsmvlMHqdnfYOQa8GWDuXWMYnlko6q+gx1C/b7LNLLDybOCfSdS
	0756/AxjiXZdJaWor0916H7JTHqotCqS6IAEArWFTq9ANHnwNHZeqvHj9ljH/IJc7LupRh0ui5n
	zD2HfPKFsJ2NIaJohN5PS3YIOumWUQNty/ru6XqRc1rzJTPvWBbjaGtYYMZbIcn1t5Uu2hTOGXB
	Rvy+wG1YghrAQXnGefQmQgxHihySyF+x1AqB
X-Received: by 2002:a05:690e:128a:b0:679:9ad9:b103 with SMTP id 956f58d0204a3-67ba50262b2mr5935282d50.136.1793618173443;
        Mon, 02 Nov 2026 03:16:13 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf27263csm4858032d50.4.2026.11.02.03.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 03:16:12 -0800 (PST)
Message-ID: <b67c43d4-7cfe-4217-b3f5-ed1425d2f3bc@gmail.com>
Date: Mon, 2 Nov 2026 06:16:12 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] nvme-tcp: parallelize I/O queue allocation and
 startup
To: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 mkhalfella@purestorage.com, randyj@purestorage.com, adailey@purestorage.com,
 Hannes Reinecke <hare@kernel.org>, wagi@kernel.org,
 shinichiro.kawasaki@wdc.com
References: <20260922200718.3941465-1-sgogte@purestorage.com>
 <20260922200718.3941465-4-sgogte@purestorage.com>
 <705f4452-3d07-4d91-9dcd-ea53b2cd75a5@gmail.com>
 <CAMof9cU5s0ck20fcSAYSvK-xpcP5_Hv2BmN20Bh3btpLum7THg@mail.gmail.com>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <CAMof9cU5s0ck20fcSAYSvK-xpcP5_Hv2BmN20Bh3btpLum7THg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_031616_444186_AF02F7C2 
X-CRM114-Status: GOOD (  13.19  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/30/26 17:25, Surabhi Gogte (she/her) wrote:
> 
> Hey Martin, can you try the tests once with tlshd using commit 3a6658e
> ("tlshd: Link the NFS keyrings per handshake instead of at startup")
> or ktls-utils 1.5. blktests nvme/062 and nvme/063 passed with this
> commit. I believe that change fixed the keyring race in tlshd
> independently. If the issue persists, let me know the reproducer
> script so I can also take a look. I saw the same errors while running
> blktests with an older tlshd version from ktls-utils 1.3.1 and
> updating tlshd worked.
> 
> Best,
> Surabhi

Hi Surabhi,

You are right, thanks. The tlshd in my test was too old.

Same kernel 4 CPUs, 4 I/O queues, 40 connects:

- tlshd a0bd51d: 19 of 40 connects fail.
- tlshd from ktls-utils 1.5.0: 40 of 40 connects pass, no handshake
   errors.

So this patch only exposed a race in older tlshd versions, and there
is nothing to fix in the kernel. Sorry for the noise.

Martin


