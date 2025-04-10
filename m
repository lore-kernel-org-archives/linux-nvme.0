Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32290C369A2
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 16:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6j20ZC1moE0WGHDxvSjsYEeGfnUUYsPAAQJslP73hnY=; b=PKh4PjV4j8yQnn8NCuS+tpKE4s
	aBsnfggMZE4Nd3o6RmaGIKdS0geHyJH5/q8ZcSh7Obn4eWmKwq81xAq0eQ5LhO3tyK/SGyhjqa8Yw
	jwMNd0bnl0i57eX3+5sM8CjYEEe82SclXgLjDtSBybPTAsZo9tbIP9x5PfNFlNtYeZJcnVWddh6SH
	phdUd7IjT1j+0KzR8x8GnVQFaYRiCBig4VS7DDMWY+fmgFnRGcBl3rUE3FB3wmENvZfYYyROZkOjH
	rtYWy7wqiJe2Qaus4CR52I4nz5vJJ76MVYMa4+OnSlYCcJADiOpuqg72byZ1agM3Z3o/Z/pAYnuDo
	Ukyp8U0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2ukT-0000000BBys-1TDO;
	Thu, 10 Apr 2025 16:27:29 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2tqb-0000000B1gc-2t3V
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 15:29:47 +0000
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-86117e5adb3so32004139f.2
        for <linux-nvme@lists.infradead.org>; Thu, 10 Apr 2025 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744298985; x=1744903785; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6j20ZC1moE0WGHDxvSjsYEeGfnUUYsPAAQJslP73hnY=;
        b=aHOgqV0i7c9ab5y7sQ8xOTdz7Wx2XN1oThEr+Iygh/yDp1NYCey8mOpmgRDmOi8tEJ
         yWQTiwqb7LgBsOoVFw1zsz7jzXwm10nuK5n2ydwR0xmKPNVdPCVDQI3ozXD2FVxTQ/FP
         0/yWQsYXqKsrnfLo3X8X99pl4Hsj8G2lf/kR5PWLfb10GZOfcTxliwuScOjEt/nlZBj8
         tyKK5SYf/bmF7AcDs56s2aUb7NlBCHWtc6dB8qUv6a62mhrmSRl8djG5xBI0v1rBOE6w
         9R2GveP/CHL+uu5YnnRyfXP6Tdsb2eoampK59OhD8hbTdR5OoQMd2/bemJeL/mPRvnic
         kq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744298985; x=1744903785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6j20ZC1moE0WGHDxvSjsYEeGfnUUYsPAAQJslP73hnY=;
        b=d0IfUCImf1r5vlc0ByoAIpRzG9G27JBK9Bb8k59Shb+dOdzC3Eloht+qsbcaAuy7cz
         2gsnwiUnukzlmMEhe/Swjkd3V78RRJoP6Cz8iPTgofe559oFG7s6a9TNW7NGf+ioKkzL
         0CuKv0sZvrgx669lZHt0KtyvpvPuIWlyLFEb/tYjcvBoE8HQGpBfJ4CiChsv6iU1jtYw
         gNg4m8hBndd5kJJSBny1Q9CBTFlxXB0hfPTRygIG562zwOGZcIZUWEXvNaRU00KoJq11
         BIwJY4kZB858nqRInjdOxbdr/TiaXDNdhqbYjhZoJff4VkIMIQV5T1F8F4n3LdFZVCLU
         pemw==
X-Forwarded-Encrypted: i=1; AJvYcCWBsmoD2LRRbFAOfdyeYzHGkwP6JMKuzD8pku/UsfRfGUT8l6u1AnhmpkdM/2eoW9RsMWv1IhUSqB2X@lists.infradead.org
X-Gm-Message-State: AOJu0YyjEws1hBS1P9/4LUC5yx9use2ObZp5aoPWJAEHl7PvkHRZlsZ4
	b1rjbIZyh7RRJ1JgD37UmhVjMGX/U+d9PIwHbS89tMHluQ8SU9dwWsLTS293yBIFNMSeDjdcHAg
	4
X-Gm-Gg: ASbGnct3l7r8T0Euq4JDnrra/lB11yt1YptQUFuTCYLHpgODhnnjoFA5QSux08gFjbS
	F6yjinZR6eRwWr/zuApPyzerdDCAFane2/VX9izxZI6Uk/oRNmpjOIm1NsEuaa7omXLOu4YxjtP
	H9gTW2PCWuOlkjOVf8myA3gxgJpdhcI4FwFBbc4iVX+a/ovX4tvuMk40GH1Y6NAKUgcZfXa1J8Q
	vjyX6e36zfqkDGTy/g6sZ5fSm3o8k1QbaHelnRLQ3+o5NKmyHZL8ichxuZEzNqUmlI7myGYJvL8
	kbkjO1FuOuTVH/b2LZogJkbHQpMx/2hsiUIl
X-Google-Smtp-Source: AGHT+IHnZ8Pp+hFpdn5IIg5PuaMTmrdjSIv5C6fTzZV5leQmTGeLKqtAIE5/gAeY0VFHa0wzpgfTaQ==
X-Received: by 2002:a05:6602:4894:b0:85d:b7a3:b850 with SMTP id ca18e2360f4ac-8616ed0e13emr374828639f.5.1744298984710;
        Thu, 10 Apr 2025 08:29:44 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-861654295d5sm62197939f.19.2025.04.10.08.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 08:29:44 -0700 (PDT)
Message-ID: <e613a857-fba8-4e46-8879-d791d37095b0@kernel.dk>
Date: Thu, 10 Apr 2025 09:29:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.15
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <Z_fdSjFqscMuzxYq@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z_fdSjFqscMuzxYq@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_082945_905391_EE020653 
X-CRM114-Status: GOOD (  12.38  )
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

On 4/10/25 9:01 AM, Christoph Hellwig wrote:
> The following changes since commit 72070e57b0a518ec8e562a2b68fdfc796ef5c040:
> 
>   selftests: ublk: fix test_stripe_04 (2025-04-03 20:13:38 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-10
> 
> for you to fetch changes up to 70289ae5cac4d3a39575405aaf63330486cea030:
> 
>   nvmet-fc: put ref when assoc->del_work is already scheduled (2025-04-09 13:03:56 +0200)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.15
> 
>  - nvmet fc/fcloop refcounting fixes (Daniel Wagner)
>  - fix missed namespace/ANA scans (Hannes Reinecke)
>  - fix a use after free in the new TCP netns support (Kuniyuki Iwashima)
>  - fix a NULL instead of false review in multipath (Uday Shankar)

Pulled, thanks - since this is late, it'll make the pull next week for
-rc3.

-- 
Jens Axboe


