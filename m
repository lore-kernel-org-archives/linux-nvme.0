Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBD8C3ABC5
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wjDuNoSFiRz4CkWSAwppu947WdTvad1etLrMIw3zmIU=; b=K3jj75AAJIgjhDZ14PAfiHsJY6
	35q0sMzb1xLE0DAO3yg4amDvMT527FX2gc66WV711Oyj9RlExhxMS2GidFggZZUzQI8CO15IQ5zHf
	pemnOxUkI9rh7BLarv5Y2Gw1V2bucubfw/yowE2jlEz2sLgrApULE1vtjCmgMSbOJ7Obrbmww/dvk
	7ah0L7r9XhAFCQVBTMrTl8qVyyzBsmFDfIA5b2q2v/PKpElxLtj3j9/J9CHywmaNIE1izIAstW0sD
	x2ndmCqM3G6iyqlqGt3OlLwmYRRArRvua9PW7yy/kJEvWXSzSh/gdZ6pJEvWzctjB0jLVmzlIPwmB
	GHh7gkRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaOp-0000000EoAE-0qmZ;
	Wed, 07 May 2025 08:45:07 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZaU-0000000Ec6q-2rMH
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:53:07 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso40769765e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 07 May 2025 00:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746604385; x=1747209185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wjDuNoSFiRz4CkWSAwppu947WdTvad1etLrMIw3zmIU=;
        b=DPdTM4MONA1U7KvE4kD1TuHtq6r0xjbSiXqlpLoQHjkGYPixNt/azNvJPKPFFYV1JV
         bfFv+C33gBaJTVGhUiDR16RNQ+yRml8a2pdfAyEM2ZGktu+BPyjj314p2hjEpQkWGWD0
         2bp5bvhEn3SjRLDEyGLWqerPRcEdnc0E8Hj2zEk4JaJZJ5eSG2LYYSP9Jfcn66vfSXT4
         txMoC8cPeSTv+oKMJ70hb3VKqIr4LiC0vWD0NC5JpHAu0mE1TG2iClkIg1Rz/6sHN8Fy
         qbsNmb06sf0ISxkbSt5iEeZsBS4kqvLHYE8WSL1oX/rcnzw2nm1clLLf3nNgQdrGUb0v
         SH0w==
X-Forwarded-Encrypted: i=1; AJvYcCVuLX2JCjeKwvOk+biA/SfvV+RnSJLgWV5lNxTP0372g9AienUDkL4N/PwpSBxIB2M85btithwKKCy/@lists.infradead.org
X-Gm-Message-State: AOJu0YxeSuazYJTSi9QUp+7wLn0UQvPTCmXBQDBx8qgl/tex8WWdTDS5
	OWH4sVeWqNo3V9ykSnXLCwiacs/wI2FEa+ce4oU8LfclomkKz8ci2VaODQ==
X-Gm-Gg: ASbGncsL3ibj5oervc2f/Wf8JOuf450I7yBzl80FaLuOPgwEZQyHenakg4ZSmMKetT2
	K9Wbnxkgffk4kjqHFtd9bHAjpBfqNeHMV3P9bXm/SelHTl1mVbYafXwslaYARDivHSXdrKQNbR3
	C6YP9g7kupH4LI3OoKmyo4j4/FrpckTZTzVFisn8BoCVEUkLtA4WDToTcSGCEbPoZczqoy8Sq0D
	fabHNR3ekM52Ea6Cz3v4AwhW9UMyEegHoZndjc77+NUshS5bTY9AySp4RkL3GdHthNe4/JFdwn5
	+e60h2gC95kO6dLtCNjhCHTFgURuQlwXMGcQYWaxxz/uBvwhaMMQLeyVIhrWtGtZxMJbE8b0gzb
	Ht8RKIw==
X-Google-Smtp-Source: AGHT+IH3ic5dJE2J+2aMZUkcIrpHbLcLK4ADeSqSQ0StJ/xvsZ/TfKLYi3kVxsZOJL57bG5ZjZREWg==
X-Received: by 2002:a05:600c:3d12:b0:441:c1ea:ac35 with SMTP id 5b1f17b1804b1-441d44c7e83mr16792215e9.18.1746604384929;
        Wed, 07 May 2025 00:53:04 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d43cb5f0sm22572095e9.6.2025.05.07.00.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 00:53:04 -0700 (PDT)
Message-ID: <aa0a20ad-9800-4f26-9f0c-c38f6cf86c58@grimberg.me>
Date: Wed, 7 May 2025 10:53:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] nvme-auth: switch to use the kernel keyring
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250425094927.102656-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250425094927.102656-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_005306_720294_59516956 
X-CRM114-Status: GOOD (  14.33  )
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



On 25/04/2025 12:49, Hannes Reinecke wrote:
> Hey all,
>
> the current NVMe authentication code is using a hand-crafted key structure;
> idea was to have the initial implementation with a minimal set of dependencies.
> (And me not having a good grasp on how to use the kernel keyring :-)
> That had the drawback that keys always had to be specified on the nvme-cli
> commandline, which is far from ideal from a security standpoint.
>
> So this patchset switches the authentication code over to use the kernel keyring.
> User-facing interface (namely argument to 'nvme connect') remain the same, but
> the key data is converted into keys which are stored as a new key type 'dhchap'
> with a random UUID as description in the kernel keyring.

A welcome change Hannes.

Did not look into the patches yet, but we should start logging deprecation
messages on the existing interface I think.

