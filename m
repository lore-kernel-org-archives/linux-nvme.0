Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3EEC5DF81
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 23:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WyfhSoFNnYYX0D8jv3J4muu2enJ2xRbpA2u5JUDTurY=; b=I0K7VFnAyy661O9FH3duy7DXx5
	o1AEu1l4I4Acx2E2vizUPNXqtuJL9qDy8bpz7dbvw2rOMCvBn/oLvMB8ymyQAf08L+Rfasd4IUCc1
	/WvlKHZgv4CHMr8656lBIX7AXqh1nTtqz5BEUt8S3s3rQ0QqrODxanEY6iHaqYHK3q8rNcZ0ZJVpV
	s9/ZO+WQWz6U+aQsJeltv1G6yzYh69hfxFWMMpno4A/1XXA2ihnhjgF3nr7EwdEEZBKy3LDfv3Du3
	yfd0aolQ1AzpulqhqMxrjSKeuh8XV59Kl2PG/MPZYmjaEHk9SIkcgdA27viAE8m96Lt6yNUC1jumc
	YEC3GadQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyeYW-0000000HVol-38NE;
	Mon, 24 Aug 2026 23:58:20 +0000
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyeYU-0000000HVoP-1FpI
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 23:58:19 +0000
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-5bf9466412fso4010133e0c.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2026 16:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787615896; cv=none;
        d=google.com; s=arc-20260327;
        b=SV9zG1jrMen4gEIdRGdsShAoFbMqPvcXtNMH3SIbpkJ7UA8fatuTPlASK/PuFg0cdA
         eTfXoiPpxbh7jxEG8//a/2sn1USxjWXiR6TeufDv4eTBjq8QxlbUMlUY0gqdETayuEl4
         txQAS8Oebb7NT7G1NW0MzC+oUmZvKvsj4tdQRgWW1VU132IwR2dfZUbOGw3t8qdDwg86
         0GPlX7y4XKVPUjB0XU063I1OirXlzwbOc2hvC+kwZeVWGSHYeDaG4iaastOA1ueUD2HB
         kS9l4Q87LSJdjWA7c4W+9942/1RmVdAD/fQ6ZxqjjNhiksz+37+e2LU6jhoSQD8igIq9
         q4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WyfhSoFNnYYX0D8jv3J4muu2enJ2xRbpA2u5JUDTurY=;
        fh=TEjWZHtDOWILPXH6EW357xnCbaEiwbPUfu/+F2N7tT4=;
        b=RU82fFtLWcMdTGMV/jPot5lK+QaMN7lo6zAmslAJxNM565tBXJIvJ1r/KzSpLKnOaJ
         Ts98ucMMz6+JNvC+PleQ1md5OF7ZtWcZM+XGeS600KEQ4P3vELgx8y3rdrQrE347pVCt
         HP1aZ7P477G4mOQaH4qFaZpM7yuTJdxTN34uomXCl4Yv6uU8FXO6uzCmI4u240uxP/Ut
         MCDFKr/oUnx6rwys8VuML/p+Pzt4+UQ3/NVUflVYj8XXDSuEBO5lycNvITLrap70QxFg
         UtzX57XL3E4AOOprbQn0IdTOBTe8h6vkg1MUC7vlqTtC5gbOPf+x52lnph901tvfSs/1
         EXRQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787615896; x=1788220696; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WyfhSoFNnYYX0D8jv3J4muu2enJ2xRbpA2u5JUDTurY=;
        b=fL+tGxTHHGA+oIrGfYVUib4iPbqwnNAT4CWg+uBZHursPj44fmWikwb3Xmz02KmuHT
         Z+3zuFwhug41gI4pORxRenDYl+1WAb2Sswl10SdKgBju1jljZQbpEJl/k3YgAuo9u9lg
         BlBpImKMUABiToPvift/3ejfz/uk4tqwVQIHjwXEcnykRAk7mP9p4hazst9TmsV5YK/9
         m+AFkKp2aeChPYkEw+8djX+Trwi4KTwULK46PGZDKOUOP69vfyJ12CZq2m+3000flnOz
         l/TXV8SPSQwvepykruJ3lvD1wuD6qb1Jj8ZVxB5mLOoWnkgwxjMbyX4/WsWLnIX1Z4ot
         mjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787615896; x=1788220696;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WyfhSoFNnYYX0D8jv3J4muu2enJ2xRbpA2u5JUDTurY=;
        b=EXxtvhpijKxli4bWnAxWRABOvdNLsBskjr1yOESudPzfhcgapbUF7rS04V+fVdsybK
         z3u/9slgro//zFz+HGNqBaicU4/CgiM66N9kxG+kXmGfxRiO549C/m/fTXei1k+PxOwZ
         6vvS/B2owhn4nNvL7sNfgRIGuO+3L+GNEx3wX3evyjMB7b/AIezl4038cJUhhezPnYIm
         9JJ/5qbXO1KRMbNUTPUEmoG/sWDhmreajIifLIEmkEXaQhg99oVQyqf+rBvgB/VoLQsT
         dKD8jqwB3Qxxf9rO/jZQV+dmDjXH48MuIImnzbxqcvOcnmXihpdtyokNmewRdpoxeH9y
         oUsA==
X-Forwarded-Encrypted: i=1; AHgh+RqrHrrTrULAqYa+l3BdpmNfrVCWboFhyy95YKhYwfMenceb35tM7TL4NKAaqQaYzWF+BPKV7p93nTYo@lists.infradead.org
X-Gm-Message-State: AFuF++lhuilyA/ht7Dl0KaV19XAm63qcL7JLmardqkCZ5NMLMX8Hn3Z0
	PoGg2jCbLA3UfOCXULJE6teDhLHxV7ZeXCwkbR6Op6GW8kRjfwHMK9GcbQ6bOVMVFSlddbjt9Tj
	2dzKqtjNfmNj8YE/u2QarwA9UXSO7E4810csARyoABQ==
X-Gm-Gg: AR+sD11F3wW7DUk82U/QgEEHFdavGYJhDCRbVqsQ0G3obYDFJSNvQ77E0Cu1fIoXBvw
	w8ARUCT1ZWfkYonO5vPnVADbVk1ggmAMzLjgLgMeEHksEEG0MBQQsU+/lLvfafci7KmXLrfZsU7
	7l8zIeBUW+OvgD+1t5/XYeuDZSLuBumezEZR+8GFvQBuzAQT3M5RALBAebD5eAF0hAL8Xca2PAP
	y6hFgoZ+NLUPCzG4AFOfewm8Rb3a7eznuWBkjQfyJEIi5WQKLexXGaLyB+pnnP+JC6iqDLOa0Bl
	bpICyqWo4qiUF9KnQZDbmDZv+CydgXw3IdJFPjgusVE61K/uZbpIaHQdRar5Y8mdOI7dUqajVRQ
	AxjKwvGebuHZgNRWqNI94h3qLdLJTcYs=
X-Received: by 2002:a05:6102:a48:b0:77a:ce37:9884 with SMTP id
 ada2fe7eead31-77feac33b60mr968637137.14.1787615896490; Mon, 24 Aug 2026
 16:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260824225648.316962-1-sgogte@purestorage.com> <20260824225648.316962-3-sgogte@purestorage.com>
In-Reply-To: <20260824225648.316962-3-sgogte@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Mon, 24 Aug 2026 16:58:05 -0700
X-Gm-Features: AcwNN1Vvr6wXSUhaxSljPh8L3pUQL4NAkv1BhQkTlKP4HiiWS9p1hJIHJ9B_g7I
Message-ID: <CAPpK+O0sMz=WEuMVgjWh5i-C5w=5qiwx3N235+w3nharKXQb_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nvme-tcp: parallelize I/O queue allocation and startup
To: Surabhi Gogte <sgogte@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mkhalfella@purestorage.com, 
	adailey@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_165818_704257_4B52141D 
X-CRM114-Status: GOOD (  19.62  )
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

On Mon, Aug 24, 2026 at 3:57=E2=80=AFPM Surabhi Gogte <sgogte@purestorage.c=
om> wrote:
>
> Similar to commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
> allocation and startup"), refactor nvme tcp I/O queue setup to use async
> API, combining allocation and startup into a single parallel operation
> per queue. This reduces connection and reconnection setup time when
> there are delays in establishing connections, which is especially
> important for high-core-count hosts.
>
> Key changes:
> - Use async API to facilitate parallel calls for io queue setup.
> - Add nvme_tcp_setup_ctx for propagating errors from async workers.
> - Remove nvme_tcp_start_io_queues() and __nvme_tcp_alloc_io_queues();
>   their logic is folded into nvme_tcp_setup_io_queues() and
>   nvme_tcp_configure_io_queues().
> - Allocate the io tag set before the queues so that the queue range is
>   known, and only set up the reconnect grow case if the queue count
>   actually increased.
> - Serialize the cpu scan and claim in nvme_tcp_set_queue_io_cpu() with a
>   spinlock, as concurrent callers would otherwise select the same cpu.
>   The per-cpu counters no longer need to be atomics.
> - Use init_net in nvme_tcp_alloc_queue() instead of the namespace of
>   current, which is no longer the connecting task once the allocation
>   runs from a worker. A controller is not guaranteed to be tied to a
>   namespace, as the reconnect and error recovery paths already run from
>   a workqueue in init_net.
>
> Testing on a 64-core host with 64 IO-queues shows nvme-tcp connection
> time reduced from 61ms to 11ms.
>
> Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
:~$
Reviewed-by: Randy Jennings <randyj@purestorage.com>

