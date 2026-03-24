Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E5CF532D4
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 07:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eJqRw8wJksOuCmbVXg0UKSzuvntxhtDkZlZiq7BcWIo=; b=0w3vAIpPntWsrD0SudPovZI0fp
	uebFiNUTOY9Xa8T+s/kyDNwAp8N5xQuSruUTu+ygk08DUvL3iDM0Tah6Rpoa1WTN7npG+7ydY/+IF
	RcF9bKSr23OgM8/ZxByoTnOKX4Py9VcBL0aliE9Lyz8I50Uln6aZn5YbYlaRYdpSzgBGzmP+kA/Pj
	fxvfVkgWGhCjrTiyF33D4p0EF6lymom+1++EHuz8rWqDYWsDVh13OKmrDBm28CDJgWUWyEVb4bS61
	WbfrDe4yzMUsMQ9w/Y7ktJDm1694+EiXBS3UZE0TM1Bj3u963uCnJF/MtIQHzgMBdwOjOqXYNpY86
	GWSUDNtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vpt-00000000rBs-3ao4;
	Tue, 24 Mar 2026 07:05:57 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vpq-00000000rB5-41vb
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 07:05:56 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-483487335c2so38659455e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Mar 2026 00:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774335953; x=1774940753; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJqRw8wJksOuCmbVXg0UKSzuvntxhtDkZlZiq7BcWIo=;
        b=J5l039Ej3vaEOswMeVnbjgjUTcvHQ/GqbkbCg+71xsaHI8IVlQIyghmYhSyk+57ccv
         ENWkIPNuhGf5899xoNuDqc6RqwP1EVPVsZf2C9RiSZloWBph4rdZW/nwtj4i/Y8qPtDy
         u8EIN5HTQgr9ID1hi62M1vdfc/d/weKal169vBrGpS5CHXQvtdxhgPuDg4a5dxe8rwMQ
         8mShMEozbKIlIT6050xMRmfRNfSB6w4Phg4oRrhSCUhL5WqfNzn90mMg3PnV9BsBM8ux
         k6x7LXMC1suOFXuA1STmk//ItFbVXb3xoxVZZkc++/CB0zH5G+T6eJnG1NRXi11mJ+lI
         StBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774335953; x=1774940753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJqRw8wJksOuCmbVXg0UKSzuvntxhtDkZlZiq7BcWIo=;
        b=T6KPiDetN+NX5vPaKSoH9ZfQGvoc4B71+MWDsy2ZhWekIISMkdXEWwG7cPYKfsrU/6
         CP5esUufnvm6x5XaTm2+/2ci6YHl6dD4upDjAFDO+efqbhfoaGe8rPUREtRaUy0dzIro
         FBzq/1yvzCKRUKLAqHkJ5aEr39oVCngm/Svfnwx2NWHr0FmQS4Lby9cy3p6wJbenu/vs
         +Mlsgo2tqMNcdBhofGWKBaKFsqjHRjo2Db/lD3K7zs6lnuGz4u+1h2FGhiKyNDmLWrGt
         GO0RK2iMuJ+jyBnnXkKhuaaXLbYpjC0/MxJlxhPdMqnYx5n+aQGTd2y0QMdHwhVtgtFT
         utwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDDmx07M7e3XbWCUVd0u7nmttMBaOPD2uXmcq9yhmau9EAfS4R8MC9BfaQ7Rr1K2kVFCZvmUO08VmQ@lists.infradead.org
X-Gm-Message-State: AOJu0YwS0fa6p2CKVnLtt+BBUqaECi9FMZdFgHXBanDTHZHUXzr81pfv
	dpUQG4HJrAKgCnkaOuZqgd2CxkJoC0c3knh2srxOcFWNDQCgOrIQQaMiXrFSi2+eI/I=
X-Gm-Gg: ATEYQzz4jjHBssYhjshf9t8PfoxnTOx+b6kwqff/MbugBSKJR4eaFM0kKn54Dz9ky9X
	oxWGSsvpkUuO2cTWvMuUMa458JyH0TzxJ+rNX0dVWaWNTabHob+73ZzAF+Wb8OTK+whk8pN2p58
	V8aN7tNepR+k5gPJ7Knjczor74AkNkGnEdEKK8PTSsragBWEXPlOljtywd6taFLEyit5D8C6sPg
	gyPXzQWOkp6nquh67Kk57QCfm7DV/lgDxkZHD+12hVvCFeV8ADWW+Mdk1/iJQclW0wh+bfgEVNN
	yONFXlmKC30QDPhz0/PpnE4ZpOFYydMH0aut5QI8dsKSx2Y5VzOjX2DHB3UC57OkOZQQPpyI2CH
	wYhD++JJBwvV+1zvUOBzyNqbDErdMFe60TmBxLFMJBgb+0HjWEGXRiftTgoZ8Idd3n8zOmQjdPy
	zsZtLv5bQ3nsLuiyZUJYd2PpxrgUGP
X-Received: by 2002:a05:600c:3549:b0:485:3fe6:21f5 with SMTP id 5b1f17b1804b1-486fedb5928mr200915295e9.10.1774335952742;
        Tue, 24 Mar 2026 00:05:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711022f37sm18358185e9.9.2026.03.24.00.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 00:05:52 -0700 (PDT)
Date: Tue, 24 Mar 2026 10:05:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Sungwoo Kim <iam@sung-woo.kim>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] nvme: remove bogus check in nvme_pr_read_keys()
Message-ID: <acI3zWfJ-ML-jPmC@stanley.mountain>
References: <ab5yUf3BqtlN3K-P@stanley.mountain>
 <acF-E8csusg-YbaO@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acF-E8csusg-YbaO@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_000555_035259_FA83921F 
X-CRM114-Status: GOOD (  23.31  )
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

On Mon, Mar 23, 2026 at 11:53:23AM -0600, Keith Busch wrote:
> On Sat, Mar 21, 2026 at 01:26:25PM +0300, Dan Carpenter wrote:
> > This check for if (rse_len > U32_MAX) is confusing because if
> > rse_len is > INT_MAX, that will trigger a WARN() in kvzalloc().
> > Fortunately, the caller blkdev_pr_read_keys(), puts a limit on num_keys.
> > The number of keys can't be more than PR_KEYS_MAX (65536) and the
> > condition is impossible.
> 
> There's actually two callers: blkdev_pr_read_keys() ensures the number of
> keys is smaller than 65536 and iblock_pr_read_keys() is a fixed size at
> 16. But begs the question, what guarantee does nvme_pr_read_keys() have
> that all the callers validated the number of keys such that it can
> bravely skip checking it?

We normally wouldn't check the return from struct_size().  We would just
pass it to the allocation function and let the failure happen since
nothing can allocate SIZE_MAX.

Linus added the INT_MAX check in kvzalloc() because it used to allocate
more but we capped it at INT_MAX to avoid a problem where sometimes
people store sizes int a u32.  vmalloc() can still allocate larger
sizes than that if you really need to.  Linus has since suggested that
the WARN() could be removed if people want to since hopefully all the
people who were using kvmalloc() to allocate more than 2GB have
changed to vmalloc() now.  So far no one has done that.

> I think nvme should validate that it's a
> reasonable value before calling kvalloc so we return an apporpriate
> EINVAL instead of ENOMEM. The existing UINT_MAX check is certainly far
> too high, but I think something like a 4MB payload would be a totally
> reasonable upper limit for nvme on this function.

That also works.

regards,
dan carpenter


