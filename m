Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B24C10F1A
	for <linux-nvme@archiver.kernel.org>; Thu,  9 May 2024 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7a6YwSwwmOzUkY13LO5oOyaPEfffpsv+a/e8X8kCbTo=; b=ASU+7bygGdp495+bW5dYxMOARy
	bIb2XLCyHm3iVm6IDMxupjqqNC0kpoNrgdCxofjoAtThwl1RVfGhb3aK8PYIUuxSpuEYDKvO1Le8i
	I/hBVRwQRZyOOcLeW5MirGWAO6XMA9iv9nlmBQElNWKGGR8Umj7UecDa86Js7oc+31lUcqqrGJ2Ee
	m0bAJ0TkewqP39zK/PuGgtK1L3TKs75PxoOzUMTYbpYhV8hrtZYsL00vCaO1QHAUmH5DTsDF6x00w
	ZbIMY1UZIiuMFRicPAI+DNS1HmmCNZfSfFby+8nqGin4t9r7ZlqZb6qaPkdbdjFRYMh5hPMEhdXNo
	7/dOxWHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s57ux-00000002IKi-1bUu;
	Thu, 09 May 2024 17:50:55 +0000
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s57ut-00000002IIr-0Zjh
	for linux-nvme@lists.infradead.org;
	Thu, 09 May 2024 17:50:52 +0000
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-36c2cf463e3so1046195ab.3
        for <linux-nvme@lists.infradead.org>; Thu, 09 May 2024 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715277047; x=1715881847; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7a6YwSwwmOzUkY13LO5oOyaPEfffpsv+a/e8X8kCbTo=;
        b=xhKcpjl/qNb5R5o+guZReLz5FClpG9u+1F9eYhFVL7IgKkdC3H0ZPyCLXOdlkVFB3U
         ZCl06xhkL9xKaSwkzBjEM1XY9AOjU1P33+sY3ywK4ykfWa/Osz3izMJ0I1bTPIKUeLbM
         lsDW9Bu6xtvhIODzYfP7BObFecoNqG40MdW6dz4QEVq/XEbcE+CEcGwVrZvU4FahuzCU
         q6Fj9A9DKoZnqsY3LERFNRcCJtgjU+YL571mtg3YgHHtPEe4YBqQCdmeg8gf4HWkKirQ
         BQRIjAdKaBWDjiczF3NTTJw/+pJqeb/M7c4UyX+Yesgd/aYtYkX7s7Qq+vXBTENMs0J1
         6lWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715277047; x=1715881847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7a6YwSwwmOzUkY13LO5oOyaPEfffpsv+a/e8X8kCbTo=;
        b=ZFeBj5TYPywC41tzBFcCciJLC7zsOjnTWDvxrsmKFaKcsvR4P8t0SrrtePS53zBmY8
         w5lcIGAkvcUg7gHO4C70qMa3b5Ab5WzYsgAhPw3dMlXJKPZhG8O0ZNIHi+pyciS8Y4Tj
         dMi6XA4QweZuTs7PhTnmAf1EFEReL2155n22Qbem367QWkSRXN7ptVWTb00yTlZgEwsF
         K2gHsga+ri5FcaX6wCXNdqKZxiIO8l2vrC4TJlPwl5YYMzH/8l9u7Z1u4ZBwavbutAIH
         qChLD6F14LsAAYx0NMqfsMAnQl4YeZZkpQr095OBwzP28yEzmKDSiaSZqLqXa2iuyqyE
         CGdA==
X-Forwarded-Encrypted: i=1; AJvYcCWbqWHzCovCp9A/+ZkYugs5YXalu5p0UYOriNGECzSk+6zdgfcp2Rn3tq5U1xCR0c+dpt3uq/rc+Caub+xO11mlGHnmTw0nL963y6CFto0=
X-Gm-Message-State: AOJu0YySTOoeEqoEqpTXf7o2hcjXcPWmu0vxKLlcM/yJJhfz64zWWGyu
	jBAJrrgmG0zE0Ux1j/zld8pJHHLBE9yXNaVAJjoiRi3yFcVDuxIi+BqH+9C1dRY=
X-Google-Smtp-Source: AGHT+IGrbxswNkoXSp2Xhnb0utxj1uIvvDQyEr9OiSjqQ3BknaUdOtTOCG8Y/VAzXpFMxj6Rov8qyw==
X-Received: by 2002:a92:c009:0:b0:368:8d92:3262 with SMTP id e9e14a558f8ab-36cc14ab08emr4002045ab.2.1715277047351;
        Thu, 09 May 2024 10:50:47 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376fb91csm475458173.172.2024.05.09.10.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 10:50:46 -0700 (PDT)
Message-ID: <aa6666e1-fb0a-4bbc-9202-1ca58d2f549d@kernel.dk>
Date: Thu, 9 May 2024 11:50:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.9
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <Zj0MbxfIuy8Hd03c@kbusch-mbp.mynextlight.net>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zj0MbxfIuy8Hd03c@kbusch-mbp.mynextlight.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240509_105051_227179_0A9E5E8D 
X-CRM114-Status: GOOD (  10.39  )
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

On 5/9/24 11:48 AM, Keith Busch wrote:
> The following changes since commit ffd379c13fc0ab2c7c4313e7a01c71d9d202cc88:
> 
>   block: set default max segment size in case of virt_boundary (2024-05-06 20:27:51 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.9-2024-05-09
> 
> for you to fetch changes up to 73964c1d07c054376f1b32a62548571795159148:
> 
>   nvmet-rdma: fix possible bad dereference when freeing rsps (2024-05-08 06:17:01 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.9
> 
>  - nvme target fixes (Sagi, Dan, Maurizo)
>  - new vendor quirk for broken MSI (Sean)

Pulled, thanks.

-- 
Jens Axboe



