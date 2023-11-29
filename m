Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F89C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 12:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rCBpwoGJiILtrBeFVDdliZqEf7BsITxGWUPpTBUG2Fg=; b=u7XfeZBuxNXZGhpAopBgccYwSY
	1uX607kfdKFyC/3oidC/1faSrreiGS2JO874GXQEjKEAkiXqQqSI0V9QKWDMtgrGKv5B24p6OSnOH
	OjA5jYxUAiln8gAcoGtU9s8YhbIMdQftJllvQwPNV4gOmNTKilcdUIRtctPHh4t8cBcVO1NcUNZmG
	S0ZmSNb6x1Jt5riwHqyIKT3zhj1Q9E8035FOvcvynhoKknXH5YejyDZplwFtM3wBfCRo8Z+sv/0/f
	g24E5CNbsDa3RxlinQ4NmaIE4Z/BypNLKLUBfODjvQFSfqhjzDrXnKmsoxDgD9ztlO+bDUDCzXPOK
	TLTI8dcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8JTH-008GgC-0V;
	Wed, 29 Nov 2023 12:15:15 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8JTD-008GeU-2E
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 12:15:12 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b474c925bso21519395e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 29 Nov 2023 04:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701260109; x=1701864909; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rCBpwoGJiILtrBeFVDdliZqEf7BsITxGWUPpTBUG2Fg=;
        b=D7FIWgRu8alch35g7BA5NaMO7bqY9MmrH1rbkjXqt0TxjWbU1KjZMollICYnVrV8ye
         9LwkkPqloyznHr6B/zuhjd64A7O5IlQlkJrlNrosAt3t1tATZN6oow2em9CruBToHiKd
         HbsJNQs6TvpncD4oHt9WD3/9i3gGRZ9cmIJiJ+hkyOmGQcfGplSwRjCg2akUe5S+KfEX
         u+0eKzKo75fa5nqVw1EuUWd9c4t5Kh2G9PnxpbzAVesKzqJhTNlc3s9TJFf+Da6hFrC4
         xL3FdHlx8i13jghbiW/CnQCLmR56ztJsoMdie0H1RpzsqI21X3ZOKPSlpJalx1R7JQzJ
         ljlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260109; x=1701864909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCBpwoGJiILtrBeFVDdliZqEf7BsITxGWUPpTBUG2Fg=;
        b=IZJdc+SCjJfGBtdP0LYo63PlpzgXsjr5bV3d3YdnaEHYne5+jochg3uSUwXYMUvCpK
         XY7TGebdBPcSjJa111MRRVqDd78qQLT5crF2M2oseZnLSXKpeCp5RE54gLOdajgrzemm
         TanV4TsT5UapbhZ7ZGmoHFzvPP6j8Bx3b6dXgF7o4co/xGDuFrE01CKtR7fuXKQ9BGfL
         q36e0xKw3u3I5QmoIxZQEp/xNHRJft49s/CsExGFYaojWqmwB2bNLdtMmcQPHUU9e576
         L3areaMQ4eYCqfp3qfB125HmzW3SRV84QIcnV5ZJ3OS4XOUlRpy8zkTJVZikejQzZN7U
         WX+g==
X-Gm-Message-State: AOJu0Yx+Wvvx5yLH9DUBokg8ASxX3kci+0slkKgkrwa58FsKvtT1mSkv
	DTThwWLu5jNQbHOamaZwUD0KRQ==
X-Google-Smtp-Source: AGHT+IHXCZHVhiQsTBCF+dOLPeMR4tIn2HFIvymCl/DwP/ulwlloLviT1YfcyxEG0XVEw2fGIxfBKg==
X-Received: by 2002:a05:600c:19ce:b0:40a:3750:46ff with SMTP id u14-20020a05600c19ce00b0040a375046ffmr13264013wmq.11.1701260108810;
        Wed, 29 Nov 2023 04:15:08 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b00407460234f9sm2014318wmo.21.2023.11.29.04.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 04:15:08 -0800 (PST)
Date: Wed, 29 Nov 2023 15:15:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, error27@gmail.com,
	gost.dev@samsung.com, nitheshshetty@gmail.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: Update type from size_t to u16 for
 opts->queue_size
Message-ID: <c72789ac-9b3b-4857-b50b-a175027cb0bf@suswa.mountain>
References: <CGME20231128123622epcas5p4940679fbbafdf0da802deea3e531f850@epcas5p4.samsung.com>
 <20231128122958.2235-1-nj.shetty@samsung.com>
 <0cd6862e-8037-40b3-9fde-b7f10d66e31c@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cd6862e-8037-40b3-9fde-b7f10d66e31c@suswa.mountain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_041511_736874_BC0255BD 
X-CRM114-Status: GOOD (  18.59  )
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

On Wed, Nov 29, 2023 at 12:26:24PM +0300, Dan Carpenter wrote:
> The ctrl->ops assignment happens in nvme_init_ctrl() and it should have
> been easy to track.  I am not sure what went wrong there.  I'll take a
> look at that and fix it.

I suspect on your system you don't have the cross function DB built so
it's not aware what happens in nvme_init_ctrl() or the other function I
mentioned.

On my system there is too much data so it isn't parsed.
1) When there is too much data it should just mark ctrl->ops as unknown
2) I should try to consolidate the data.  I should just mark all of
   ctrl->ctrl_device as unknown instead of recording any of the struct
   members individually.  There might also be stuff that isn't used like
   ctrl->namespaces_rwsem internals.
3) On my system, I have 2187 bogus entries that say we removed an item
   from a list.

Probably any of these fixes would silence the false positive but it
would be better to do all three.

If you don't have the cross function database though, you're probably
out of luck.  There are always going to be more false positives if you
don't have the cross function information.

regards,
dan carpenter

