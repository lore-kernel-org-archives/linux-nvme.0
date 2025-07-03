Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AC7C83F05
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 20:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZUdIcOI06WIcUUhPkMpxJUvRFyK/KzBRoJLe1YIWZus=; b=I04kUER7BZhtHemJ/mM/2WWAZ0
	FUsp96PXrmB1qWIp5PAbYDFwkO0pFJdhUVMPTQv974/fVDNiV13c3d7rSF5WPCpkYiocAtAIubOaL
	7w3CvxEhf87Psacw3ee8/xOMhsYm+rzzn8k1A4F21wS5tjbL1yZOAv8XBNF5GJV8PUjXO/nfKR2w1
	T9DYDFAWKSXbNM0awr6RXCp0dD3C/LFc6C2/EehsbXap27hU2/3Fijomf9Pb60T2N7atx5+2FYBpt
	chQhYh6E/rXxDwZ89PohVNCXHM79wP/F4txUbMOey3MDgSEujOMScwpmUYFQNrwDZrsYwScXNjEUA
	kQopMa9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXR06-0000000CU7u-1ofU;
	Thu, 03 Jul 2025 20:57:46 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXM5T-0000000Bs2y-0W9L
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 15:43:00 +0000
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3e05bb6efe0so383475ab.3
        for <linux-nvme@lists.infradead.org>; Thu, 03 Jul 2025 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751557378; x=1752162178; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUdIcOI06WIcUUhPkMpxJUvRFyK/KzBRoJLe1YIWZus=;
        b=rnNs+dZY+HxM1iMKpkav60ZkqKSXB26/ppZeZpxHEs1iRtKzMwG++tgF5ud4/yhwa2
         0NpKpZIZ9CECiJOPveLgk2W4tImTzFU+fznTJVDY5Ghb8rItjNj4F2f5fogmvGsdpfSn
         4g8UkuD1o+PRT/FQfrWw1I6CNcaQFuobRiq8oiG0mvcUtdJ2INgTSj3M786zJ/hEPEw0
         XG4+WAgD4P4sVXsuSoG2g0/9FRrafwIrIW/7aNPjObZ4tPGnspZc6YqyJzv5q0OO9fRx
         nFeQQvTGQIL7ZYV+KxAsw4FYIPrrISVOMXokTiyTQ664lf9JvjZyc2z/wDDuI3rlA/u6
         WC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751557378; x=1752162178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUdIcOI06WIcUUhPkMpxJUvRFyK/KzBRoJLe1YIWZus=;
        b=U0GVozjNEQ5mPvvtUXJcx64X1p2/wbeykkhittLYR3rJJxHUMj9YPUuhGjblBLynXm
         E4Kur7k1RSj0iUH9y7GwzLf/GuPCYccwYC+XQNgZq1UyHflmEhka8qYvaHSlGBkZs7GP
         KDGuKPdB40expQ1YCIYjyhaJoByuz8smOZNfhJZzaFRKDkM1xx9Iu8hayu/35NAK7s5X
         oEcewKPSHdHHEqvu5htfcnBBUMFeBjOhyYTfPzLKKsguuVvVAwv39zebVbUmVCwDNBzy
         0pT67NrjoZfIc2BkBTwIaKXUW+XeGiIWz3/zqEQ47Zp9WN9WVC+RKp9VC9ohIkfbYWsj
         aB4g==
X-Forwarded-Encrypted: i=1; AJvYcCXwe9gAvaxS6nTsJ4pOplSbFZyaTzsYCyxlTFMW1l7bendfIACDoofi8BvJCrUVwygIU9CLC4FV83uA@lists.infradead.org
X-Gm-Message-State: AOJu0YwMnh+QVF3Imi+mSRL1pX60GEVbiEDUVtbHtRQnzw20hdvdzAuw
	7sbT0Q+2lgzU75Y7QkeY7S866dEPYo2Af7ftBWZ7yHUg5a/ATKAMWMceMj1Z5zmovHw=
X-Gm-Gg: ASbGncsahaTq4OFxfnhnVGvb2M64IbC0A0Lg9c/HTpG1D1JD7CCs3ba7EEj9G98Sd6K
	BZmtu6v7o65d5+kuZM97Ks3ufCvvAFG0RQ0+dkcfacaCraAW+0tL39UNB4fKc2phrPDAtdT2eI5
	6rZfH3TPUz+7Fe1jKVsAtvggH8B1gcjtMCcWmeskUWnEMoG5M3GClX2Hg5+0FbmZtu1XSdrlM3v
	m4KLNedOzID2QDJ1gJ55v+0MJ5eZNeNyziS9WHiYHXIlMc6PkGKmDQUFfZuqfp9O6t2wj2C5o2N
	wzHjNPKYYpb3VsOiyli+K7HFH4DOh4hVpz0Fi0gW7hhyfkd8+utm8Hj8mQ==
X-Google-Smtp-Source: AGHT+IH+T+gmi1h401kOm7Z/YrnSwqdLG8+PwSpem/9GQovNq7iXvi2qRBVRYbs/e9ZwB/RBQ6Nqow==
X-Received: by 2002:a05:6e02:1fe6:b0:3dd:b808:be68 with SMTP id e9e14a558f8ab-3e05c9b4c23mr39626035ab.16.1751557378080;
        Thu, 03 Jul 2025 08:42:58 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e0f9b7bf01sm307635ab.5.2025.07.03.08.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 08:42:57 -0700 (PDT)
Message-ID: <c88dede7-9654-43e6-bb04-47d948e7cfaf@kernel.dk>
Date: Thu, 3 Jul 2025 09:42:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.16
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aGZuyPbzY__Rb8Kz@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aGZuyPbzY__Rb8Kz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_084259_404989_1C75EC8B 
X-CRM114-Status: GOOD (  11.93  )
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

On 7/3/25 5:51 AM, Christoph Hellwig wrote:
> The following changes since commit c007062188d8e402c294117db53a24b2bed2b83f:
> 
>   block: fix false warning in bdev_count_inflight_rw() (2025-06-26 07:34:11 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.16-2025-07-03
> 
> for you to fetch changes up to d6811074203b13f715ce2480ac64c5b1c773f2a5:
> 
>   nvme-multipath: fix suspicious RCU usage warning (2025-07-01 08:17:02 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.16
> 
>  - fix incorrect cdw15 value in passthru error logging (Alok Tiwari)
>  - fix memory leak of bio integrity in nvmet (Dmitry Bogdanov)
>  - refresh visible attrs after being checked (Eugen Hristev)
>  - fix suspicious RCU usage warning in the multipath code (Geliang Tang)
>  - correctly account for namespace head reference counter (Nilay Shroff)

Pulled, thanks.

-- 
Jens Axboe


