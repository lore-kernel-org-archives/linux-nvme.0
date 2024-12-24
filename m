Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A46E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 10:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+GksGZMZ89ePWGLgC1vKqG4cLO9duAvazI0aTFCguKg=; b=gEyRqt2/6dU/+OokxMF9tY8zg7
	uNQaOEovs5SUHP9gHTlbPx4wAA4WSv6z6FieQUA8g3CNf6u4/3ELL6tjJLThRPorg7MNokwRYgHmY
	J17onv0d8//Q0rdZkYbbiCYbmhyuJ9yFeNAeYj4zSQowfjGuNDuQZgXZ9h7To1rSozV5xQ1zRSOOq
	mku7ys3NMPwEIoHHFvvbNy4eG9bDBYua5v5Xm5tmI/AY28J5fGxNijVD1aeQlCb886c9F1ucy0Jlf
	zs1F/mIneoZq9gJGe2sQ7EwpQZ4Yexvm52nDH7J3A2pCtnbObElfeed6CvNdDozSdaUhAWuOHpV4x
	nVfygNfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2Xz-0000000Bout-1Wmf;
	Tue, 24 Dec 2024 10:53:55 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2Xw-0000000Bou3-25ni
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 10:53:53 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436345cc17bso37066455e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 02:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037631; x=1735642431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GksGZMZ89ePWGLgC1vKqG4cLO9duAvazI0aTFCguKg=;
        b=mvLWYta+pFdDmkcke6VJLrhi1pwNETXpOBIhW8I7bTKABXrjwVu2xyxqj3X2v9J8JX
         6I2w4LLaZHrIUz4PC+dq7LZZ8fhEIKnIXPMfnAbv0vmTLK+R/OMiAxtBFpfA+K8H3W7j
         rTzAzNvaC65gLm1629ynwedLldMUvO+i0IyyzxWRlnpdFeWL1YhF2BzA/3TKBz2VX5F4
         SpNDh5gy6iQR86CPgA1Q3QcpMuSrutQCCywn40oHYuAPJkPrMLzzwFZT8bAdq+hP25YS
         RIrDS3XfNnTUF0DP99eU0yBhgGvGIJnKakIhzQ8sb7wuRaKOcfZIJ5je7jt+I9AUEzsD
         I9VQ==
X-Gm-Message-State: AOJu0YxMn7rZc0J7ie6e6M2AGeVpU/tvpQjSM3HJmYhLBbk7OigWBDvf
	bjsRkMsdNCe+MYXYvWNkI0+Fz7H5JT+LI0Gjr4kBZi0we03hTBev
X-Gm-Gg: ASbGncvexQmOfhHQycl37hxQbPLI56e5wjRZvEqJXLr0YTGTSUSHCWKU/w95tuMV8K/
	YFRLc7dr2wy998xBSPRLaTe3q1aDnUZv0LK9uknj4f/9otsSmoPxO9KCP8acXY0ikGTtFW/116a
	TJ4kRufp3UViho1qCUVPrmrwVbzPijeD9spBKrJJt4rCsUJUY3kcgZK858vVUfIh/TVtSgasyVw
	U5JAClolUq2Tc9WgQHJZ6wTNgSAhDMUqBs0r38ok3ciHDOxJ71qyOhABzP/Sh4Y4Z3kHBxdF1fc
	RMHiza8d8D3VouksXUxxdpo=
X-Google-Smtp-Source: AGHT+IFbGQVP654MK1FweX0VXTxgyP1Z3Z4i2f5lOsLB6IWAl35nFXo0ZnSS06zaaLZ88GYxsCqKDA==
X-Received: by 2002:a05:600c:3b02:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-43668547462mr132519015e9.4.1735037630570;
        Tue, 24 Dec 2024 02:53:50 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b271sm197147225e9.34.2024.12.24.02.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 02:53:50 -0800 (PST)
Message-ID: <04a0778c-61d7-48db-b5f6-2dbe8b8ca752@grimberg.me>
Date: Tue, 24 Dec 2024 12:53:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: use dev_err() to make message more useful
To: Baruch Siach <baruch@tkos.co.il>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
References: <29637ab5b312249da0b0cfc5e138e2aa7f6cddfe.1734371040.git.baruch@tkos.co.il>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <29637ab5b312249da0b0cfc5e138e2aa7f6cddfe.1734371040.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_025352_546914_B4F9C920 
X-CRM114-Status: GOOD (  10.21  )
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



On 16/12/2024 19:44, Baruch Siach wrote:
> pr_err() produces no prefix when called from pci.c, and only generic
> prefix on other call sites. Switch to use dev_err() for more pleasant
> debugging experience.
>
> Since we now pass nvme_ctrl to nvme_find_rq() directly, nvme_find_rq()
> can figure blk_mq_tags by itself. Remove local helpers that are all
> almost identical.
>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/r/20241212062241.GA5586@lst.de
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>
> v2: Pass qid to nvme_find_rq() instead of tags (Christoph)

The call-sites are all printing similar errors. I'd just get rid of the 
error in
nvme_find_rq...

The change itself looks ok.. redundant, but ok...

