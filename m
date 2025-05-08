Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A18C3ABC0
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pP1HhmeHBLveNBlNnV+UToK3//ptG+M9b2h3DJVfCS0=; b=jmv1WXNRizyaHtkuz2ZoxeXaVM
	f+I8I//p6mH+PFtVGNyocXzUPYxWBZ3W5pmwsi4rYWGBc9IXV3e4aSmS5gng+xVVLtG/l5lxTxKBx
	B89/Dlsban6WFlsoYHmLjm7bNhhsxX92DMWk0MrzKg+OXGfgnSmGqe1H9QWVMKXqjksSfWbK9foUA
	sPA3S3n8WUTEOXdw/r9hp88nC+AvrFrml7VzlcRTIGgUhmKPMJtTQUc0v4FADuqEvO9HJtrNfgVG5
	OpMJr7Ll2+efthBf6CDK9sU5ZlboPdt9RRbwM/jbpBbCVtBR8QyjZML+2kLZoTt362gmrRP/s6w/e
	aWS95Yww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD43L-00000001HHz-2XpH;
	Thu, 08 May 2025 16:24:55 +0000
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD2wy-000000015de-2u81
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 15:14:17 +0000
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3d948ce7d9dso3896505ab.2
        for <linux-nvme@lists.infradead.org>; Thu, 08 May 2025 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746717255; x=1747322055; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pP1HhmeHBLveNBlNnV+UToK3//ptG+M9b2h3DJVfCS0=;
        b=YsL9Ewvvh2Jv4k4mqvbx9HUlL4Bg8B4oaUOqZ5kzwwOQvCkap87nxZPP+HANBG+HGk
         px/YdHuwL8B6atrYWYCnTuUUCgNh9BXFNpu/P6Tc6PNLAr0+sXyc7fVHeWO5KxKp2p0T
         Ka1drVQIW1rlIuz9vrEu5WZTTY/nAHa5/CmP03KL18Quhek9vLjwYozC3g+KIL9eDuyE
         9ZDGHUhCsygzs3n/P8ySt5WRvBi+7xc8OXzSxj43EB8jcJ2UnLqk+XerNGw9K+6W8He/
         z88IzwpvYbcPQmla648eaLFNy+JbU8aThl2YE8wRN4WnYFRBxP7uFZNl9/3CL8NcXQ51
         KehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746717255; x=1747322055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pP1HhmeHBLveNBlNnV+UToK3//ptG+M9b2h3DJVfCS0=;
        b=STS6CnMtmYU7EJKaOBrEnTE1pIcUSzrhEmv/W1gDlbTCCCZg8UG46S2SfsSC3I1smQ
         fyDVjW8QIVzKI66jtiluIMxvuaeV++QMiPtP7p6BGFAc0sSLib2IYFussh+k7Fw0HWoJ
         JtO0Hagbmw+9e83WJGZ8jZ8ox8eJDVmVwj2co64PJyQjmtvKnBLayL/HdLds6HOoBsL1
         ui/H6bjdsPj3tDo3aP9IT50eS8Tpeo93tcdL+6Ig92YsuX73Iv9jgEojOD63knf1zn9H
         kSgD4HTRI7KNcDjysp/bNKnXYAR/c+9OYQESQAYci0INXQo+UvWfO0w59q5XplM1ivJo
         rpzA==
X-Forwarded-Encrypted: i=1; AJvYcCUT9AbAfUjQO7qCG011MQUP7+lWY9C2uyxcJMJL8dEYnyIURtr6aZi5TwryvwHr7BUIKCRKzhFCDXvI@lists.infradead.org
X-Gm-Message-State: AOJu0Yzod89XnBICF0ZP474fMze8V2DcfJA7tf3tPZ6s9i/WDKCkkgwQ
	4ci0D5hprPNy7X/F6M5Go9JeH+I6IGJ7/HvpzCb84L/W/cSkv4F2uq/ALHLkzSQ=
X-Gm-Gg: ASbGncuDBJyEmm3sdQ+Mc/EXvYYEz2l+h53bV8EQHO3fAfkP/7m+nJ/KuYJFKF+m5zv
	RKgPw5qanP7fDraz644r7ISg1nKljSs7uNBEvMyt2c8cWNcxao3wH/1jPAcQj+0/7dxWSd5+ed1
	N0cprVfJAZck13aUMicUMZr1fMb94b3TABKCnSSzdyOvxzwYI69bo1huaSrexyeeBH3TY3gbx9V
	RhsJFSkomN2Urppw9FvWVMC51GCy9P9yH97AAN2vsJnD+qQx9qBr+B52R5d7RE5mJT22CDb/cEo
	3hDEZ6qqAo3YzwzUEPXPPrktfFRwhAOZcPDt
X-Google-Smtp-Source: AGHT+IH8RZwgW3alkS++WNfAs4ztxtBsAFcQwltyiZQ9W6aCxVaVNDkliLlu5+QTwQQt4C2jyZU+XQ==
X-Received: by 2002:a05:6e02:378e:b0:3d8:8900:9a30 with SMTP id e9e14a558f8ab-3da785a5601mr53099995ab.20.1746717255587;
        Thu, 08 May 2025 08:14:15 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aa8f0a7sm3177198173.123.2025.05.08.08.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 08:14:15 -0700 (PDT)
Message-ID: <40fdf1f1-8e14-4c20-8057-1001dda22c80@kernel.dk>
Date: Thu, 8 May 2025 09:14:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.15
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aBzIw5ojzLmaen2g@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aBzIw5ojzLmaen2g@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_081416_730938_3B31E88B 
X-CRM114-Status: GOOD (  11.04  )
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

On 5/8/25 9:07 AM, Christoph Hellwig wrote:
> The following changes since commit db492e24f9b05547ba12b4783f09c9d943cf42fe:
> 
>   block: only update request sector if needed (2025-05-06 07:45:59 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-08
> 
> for you to fetch changes up to 650415fca0a97472fdd79725e35152614d1aad76:
> 
>   nvme: unblock ctrl state transition for firmware update (2025-05-07 09:01:20 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for linux 6.15
> 
>  - unblock ctrl state transition for firmware update (Daniel Wagner)

Pulled, thanks.

-- 
Jens Axboe


