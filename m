Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F772E77197
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 17:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=edcGY47e8cPbqahe+0FHCt/HWeFfo/bXgMWRn11rNNQ=; b=bdH6kXj1DeNWcYYMLi1Tv0Cs/J
	NUVpKWe7/JOmDKii/FnCyzWwkTMG4y0IzgH9yUYyd2mKX6yMmfHxTfsfKIgJ/QBxnojtXf9X4d1Gi
	O3fDrFA8+xuAgjdy4rSBZWIRrBhUQI4HY47cTJQ/GvAJcta0v/lelsWghejpuVfiDfPkm4NoL3KtL
	h+JTpea6SjbCWy4v/U43ksp3X4M3xxsCJn8DkVpaONhDEblZ2m/uPb1TIx6vueGjUIumf5Y7LfbTJ
	y8f5vtUOpeMBV8mKVv6IGRAbKnTx6gzzPVpWEEmo0QqBxTya2NdqEqtcqN4oe6PiQFnWZEwMlJWUp
	wV5jQ/fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVwiE-0000000CuYK-3pea;
	Thu, 09 Jan 2025 17:52:54 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVwiB-0000000CuWQ-1ZhX
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 17:52:52 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2164b1f05caso20200115ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 09 Jan 2025 09:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1736445170; x=1737049970; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=edcGY47e8cPbqahe+0FHCt/HWeFfo/bXgMWRn11rNNQ=;
        b=DrWteNhl8/GVO9PZD3bW6RP2hEegZ+Zyoa0rSmF33CQcMwna4qXIvsWLO7jsXE8jYa
         uFOD9k7QJFRcpSqAmB4TJRfKMrafkbUedG1APogDWfazkpt6QIP8y2pMuwUGFoVMS2M7
         1qhOda8tRizSDJ+JSsWQRvwHvgnEpo1dbCaR3dWAJXeZqfKpP3keRqhvxOAYOyo4uZy3
         0lAoIZyOx1BmrpCmlgtXYOjeCaLcNO2N6SSysKPXLLN0CCgYrKyyNIrKUoMhF0WDzIN3
         Dil6on0Ry79pKDA3Kn1dnJN6bboMRYLaWAsEndwhM9s5PYY6q+rHNNKmQwbZVtk8Nc5E
         JVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736445170; x=1737049970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edcGY47e8cPbqahe+0FHCt/HWeFfo/bXgMWRn11rNNQ=;
        b=G4ec06KYpxgjpm3JKlU/zn/+2KfNnDmu8yjGyjcIhA1UFqWWk2OPCdS33hxV5q1a0u
         +2rmjmgFrhrhinOShZDUqKziYvhRoadKpqZ7lRsRazrFnLDYyl+gtM92vnIcGxaDmKqo
         4uGAaB0awM4/Nj1/UqHx4TdDsMxaNsjSNA4OEYWpqdSwOi7MygJJ5zB7afy6gGLuHXTH
         c0sY7CT1eIPYPoj/aAJIx6h5B7KEvqoSmVUCItDfSY0EMcqpK7c+9vkqcR9h6P0/TkYq
         FQqHd1hoZEo1332WKpN+Ki+kfE9c43JXC5gkyh6c9bBerXzfZodnGrdSg3/5LVBaLuqS
         oFcA==
X-Forwarded-Encrypted: i=1; AJvYcCVJZA2jtVOVgaM1KcuzKprxJZs+mX3CoRcfX9Y6De1DcqVX9/BSqXt6dgCftYCRIHjHOdg6AmBzZQuK@lists.infradead.org
X-Gm-Message-State: AOJu0Yx80lIS+13cABkEBXWPv7rsdtr9h8zps8da1SJZSGZmdhCc561S
	4SmO/fYQJvARD5vaiR/VcAaRaKJ2Yz/LoGJkm8EHfCY4qM6yS1kZNbfsjY1uVtI=
X-Gm-Gg: ASbGncuOUleiiLGyPyVzEHqc9iJ2qV6OtzvXRduDx9daVvy9o9qYi4WOIDKHMxBXfHU
	6a7mK8cqLgx6ZtAOG+Vk8hzSwzKzTBTc1GRRgp+0oMEttap4xRuPhR2wE718HS/6XcB9xos+bZM
	PW+le8hoOas4CwbYBqMphF42TvCK16nZLD4jYa6rpv/wm1qNNSghemYAZZa1LM5fWUMcjATqmbM
	wExm8E54306/9HP50TQLEAfoV0I2ls++66nqgyshCUMG2Zz2ZVLNxniQjo9v2e0usZqCXfbPYfC
	xNCw3WVTNLQo8J3Jhdq2wuzH7gK7ShGg/Q==
X-Google-Smtp-Source: AGHT+IEyLberA5bJMwMV7NiZUYaqA+N47+cATPH86wKqmaY+O4bdxHRh3HPkxXgbE56402NYe9ZH6w==
X-Received: by 2002:a05:6a20:c99a:b0:1e1:ae82:5657 with SMTP id adf61e73a8af0-1e88d0a945amr14140148637.34.1736445170370;
        Thu, 09 Jan 2025 09:52:50 -0800 (PST)
Received: from medusa.lab.kspace.sh (c-24-7-117-60.hsd1.ca.comcast.net. [24.7.117.60])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-a318f276980sm1583675a12.33.2025.01.09.09.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 09:52:49 -0800 (PST)
Date: Thu, 9 Jan 2025 09:52:48 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, randyj@purestorage.com,
	jrani@purestorage.com
Subject: Re: nvme-fc: Question about __nvme_fc_abort_outstanding_ios()
Message-ID: <20250109175248.GA1452351-mkhalfella@purestorage.com>
References: <Z38nGkThjH59LFrf@ceto>
 <Z38tZ99hIX2stF8L@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z38tZ99hIX2stF8L@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_095251_451820_25CEB036 
X-CRM114-Status: GOOD (  11.36  )
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

On 2025-01-09 09:59:03 +0800, Ming Lei wrote:
> 
> It is because many callbacks call blk_mq_complete_request() to complete
> request, and the request may be completed remotely via IPI, that is why
> blk_mq_tagset_wait_completed_request() is needed.
> 

Thanks for the response. I know that requests can be completed
asynchronously via IPI or softirq. This does not fully answer my
question about in-flight requests though.

