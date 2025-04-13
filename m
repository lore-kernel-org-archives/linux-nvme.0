Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4382C3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 22:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s/D6+ei7THa2JwmHMh6XeSGYq7ahuDe/3zBUnRMKiVA=; b=q2TuTbQvUzi6NfRQ9vhdkT+DhP
	98VhdByfWxDkA0rTV+yAAxCELXyQ39xc7NLlNTMBRXP6hZ72Hnl6MOD8OK0KvOmF4ZeMkgttqShPw
	k3uLwrIhXmqRbmmRZ4XM1VRzOGjG5ZWXsMPZrs5ybyMz8cuLEGOqHtGj36NAeXXTQRbsH8YwcWASu
	o1nE0XzWWQYI74pzXxbaS3+fz1A8VQYnDm0aYzzX8iiQhhG3nMoKf6xSs49owo2x0BPL5zKDvLoxs
	meBvOvm8XOziUlQdUW74KLC81ZckqSqD+8zM1fw8D1SV4wsEnSb/pGo/6zhI+057YWn6JTEyO83I0
	Qb6BAM1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45TX-00000000DjB-1YBb;
	Sun, 13 Apr 2025 22:06:51 +0000
Received: from mail-ej1-f46.google.com ([209.85.218.46])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45TU-00000000Din-37nD
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 22:06:49 +0000
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso720852566b.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 15:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744582007; x=1745186807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/D6+ei7THa2JwmHMh6XeSGYq7ahuDe/3zBUnRMKiVA=;
        b=jKKmOt7SCm7sTe1OSIvw2c581ywOfzW2/79NjURb0NqEOu2sBPPeqoP13320L5X3w7
         ZAy8y37yDfdog4zzjLHSQP3WxzpWaatRfnMDCecNilsp7eb8jtYzqvqSho9BTTXJTWaI
         sqPsnI0zygZXi3CIYMu9ucVIp4kdlMVPqsatkbMSouYHg7mWPqRQeID4DmxG60N8WSrB
         v6U1oq3vNBPOID1L0dGuAV9NaUtyug1Sz4SWDB21Kb/O/URm0WIUchuhN1LEZSmtsIJR
         MwJO2WrH+zdoC2sQHs6/ulgeyIzWp9YN0Ct43+hebeGCjpOZDE7/N+rJbHmzZV1Cl7U5
         ruKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2aWDSO2fq/0THk+CTBKTIgDLWojwT24YHYAmTcQMepBLZzODn5LZcthyvUAqLokgq1pfzSXshvYLI@lists.infradead.org
X-Gm-Message-State: AOJu0Yw90bOEUwJWLCjCijCDffOsbzIxJN7PaxdSFYfO2vBfXYIF+lZZ
	BMuCRIAG1aTjSZPX1f0bpkESOQqzjTVxsChiAteWIAsdob4iv2K6
X-Gm-Gg: ASbGncsLGCQyEfQkc57TUDxtYnwP73z+yAG8bOuYGC0H9SKOFWhhvScANrSKU++AmWz
	iSikq8MLW2PD9cdNy92CAgzj3aJMi2jyVa1L6KS77hbNInfvOJHJuw1gK3gk4YiGXbFeO1rO9JU
	GtD8YSTos/Hh1Kyo1BhZgk31at13W5WYHhhud1uM//jfJEKQ6y8M1KopXuQTBcramTs+xo/bGsG
	lRbbA+rfBdT5u2YgyIRPbZTi8VIkCjg7koly3ExDCrjeVdZjMpaiDcZpLwvvpmeHX8JlMG4RRUi
	ERDBd+4/zZL/tHiv2FiKQDbP9n1M00ANiilO+eVfOocNMAqrBLxtmR91c8702D+D24B65ve+7cG
	H8tZcjVU=
X-Google-Smtp-Source: AGHT+IECuKLgLR0/eYTl91/98EQryOOoy6+HjlNFtIT0nrkfllpy0boyT/2aq6KhztAk6tRjy63m6Q==
X-Received: by 2002:a17:907:6ea5:b0:ac1:e07b:63ca with SMTP id a640c23a62f3a-acad34a1b3fmr761330466b.22.1744582006872;
        Sun, 13 Apr 2025 15:06:46 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb41besm795328966b.118.2025.04.13.15.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 15:06:46 -0700 (PDT)
Message-ID: <271b73e8-4864-46bd-a274-8fa85a537eac@grimberg.me>
Date: Mon, 14 Apr 2025 01:06:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvme: add support to delay retrying aborted requests
To: Jiewei Ke <jiewei@smartx.com>, hch@lst.de, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, kaiqi.chen@smartx.com
References: <20250410122054.2526358-1-jiewei@smartx.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250410122054.2526358-1-jiewei@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_150648_800088_D0EF35C0 
X-CRM114-Status: UNSURE (   5.22  )
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

Hey,

Is this relevant given the patchset from Daniel on implementing CQT?

