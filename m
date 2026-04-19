Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A0DEA71AD
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2026 21:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=crRQmQHyg4MxT/wLW9vc4SYD3U+N/wKd83cupDhzFY0=; b=VSCbDfqmPF3g2yQm+wly1mRM2W
	aWpTYwZn06b/uBqNP6GIefLKV7d5ijxmz+/NnK8k+TXfB+LpNIlLIXaCE+3An+HOnlKbyU+y4uJfT
	FU2CLOPK6rPdGgBmNlNSPZV7t80cmki6k4BP45io1Ma1jK3ohyVgcNrzZFTdnM1+wem2kg2j2y/2Y
	ZoFfjwCYF6TLVl+FXLAGXU/7eEmvhEq8qLFZrQ1Y8TQ9I0bDzO+TcKI0HvN4CgG4VbkA8AQ/Gnuxh
	eSmLRRm4dKtSPjZtixNQZDEi12bNcCfL95i1mlWnKnQoAQfA3uq6Tl0ufnhAppx2kK+kgCS4PFZFo
	s7RZEJmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEZo8-000000066ZS-0v1Q;
	Sun, 19 Apr 2026 21:36:00 +0000
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEZo6-000000066Z8-2uya
	for linux-nvme@lists.infradead.org;
	Sun, 19 Apr 2026 21:35:59 +0000
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-610e2e8f57dso828776137.0
        for <linux-nvme@lists.infradead.org>; Sun, 19 Apr 2026 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776634557; x=1777239357; darn=lists.infradead.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crRQmQHyg4MxT/wLW9vc4SYD3U+N/wKd83cupDhzFY0=;
        b=W1X+kVINcD7t+h7IZ1lXBTnUEjnpWcr0MJH8EzNNaSk01RUEjYjI/HtA6+CkZXBl8n
         VOAyrExE2AfUpFDEMtWSiuIg5Srqdd+BKoA8gb5nP2KMGeGZ4k8WQMUhNCaf4b5gp2q6
         Ixpwl/e46Y1wlKmOACA+PkLpW+Ws9Wk1eXA8ZoHlfdWKVGWUS9P9oWceaAoN8j7AF13V
         1ewRA5y424OR8JfzcGEBDqjaFLGbKm8uWWfb5BNBrWrPgoraoLKWyDjtQ6hX2FQ7kZir
         s0Rr4G3BbrkMeVbA8VH660tkf4T3arfJAYusvPrvaV9oFIONNfrd6oXbev/E9xppD11p
         p9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776634557; x=1777239357;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=crRQmQHyg4MxT/wLW9vc4SYD3U+N/wKd83cupDhzFY0=;
        b=igJ8EaDPt1Fr093pcoSEBrYmQTeG3Koe6ROMY2Y+rg256UWx9zRljeC73buCPdD0h1
         HMHIdM8e7Gpex01Jsu9yP7C71eYAqTOsTw3Um7T86o3VeLYjbcInVifuIMY53824Hq0R
         k35wV5VxLZc3w04lAeAvgvTbPX38GPSmNxRCGULUrzkBNMIhyj7mv6TvtYRlCurb3b5n
         kWehTCUL5ct3JtVPzddKPzkXGhAag8hiJbSbbtKZQmbcP2d7V5cVyjcDtZ4mtS7pMj1t
         Px6AwIWf2xPurDy9rDylTNDojQ5aXRaU0YZvm4ys1wb1cY8iiJu/EDw+g9QmVyga9zZ5
         t3uA==
X-Forwarded-Encrypted: i=1; AFNElJ+d6eJULisN/QeBwTR04hOP1Oqv3AhiFovpatyLwd2m3Dzz4BQy9NJwg42eXmbpqz0Ab1kZP8YQvQ7W@lists.infradead.org
X-Gm-Message-State: AOJu0YzjOm8hj6a2ETEkHpk5RUfaaG14O3Xs3SbtSwdwPjcozeAaZAP8
	+DcaK5mIeJ7r0V0GBan/NQxRLIkOi6U0ugweaoEOttypJxoQtLspo8Ip
X-Gm-Gg: AeBDievosEpqfJuROMvAzbNlthA7gWlCxwfs8epNZSIQ5ii44BP7eo5qLEgusImXjof
	qr47AmqwEnGbMsHsOD2FlWzvIa3d/EgzUayHBqqrCRRh8Jm7VOD+inkwD7Xjgy3CGsrMajl0CyO
	0xoJTmkTEonhH4+4zG9SpKRncnMw16OJspmOLbpryeE8QO+x5UcJFNGCjKXUXo/TKRQh2l52sps
	OOjGV3TALKp+FkIT21MAGwim4SOeZTpvWQ8ew4OniVxKCt/6sH1rbpKx2/LFm3Jc0T9Hl5IxR27
	DeIuaBRTHPtvwC+8hOYV1UVApGsXkY5gdQLYNw1vLyi9QNajpCRGasVO1NPzK4n/KIaj6YwB95h
	dNniK22v97dPAqZbpK95cSACnJax2oxh8WBi1ludjQEcH4AQ5zHXgXQiHgW4cQxZGADOZPAJrkZ
	SRa+DdlZ4g6V0Ro/KVqVFVaEui5cZFJZy0rgqL3YY/Y/SRBFscmJCr4JAYC4pw4ywDLPCisp6Xx
	YwWG6D2Ui/8RkbJUJel3Zr0XekWcQt6hcwesYPO/sHFDagfPC8V5z0/cjNmqMw=
X-Received: by 2002:a05:6102:3f86:b0:607:7991:f02e with SMTP id ada2fe7eead31-616f8392189mr3715182137.26.1776634556986;
        Sun, 19 Apr 2026 14:35:56 -0700 (PDT)
Received: from localhost (host63.190-224-190.telecom.net.ar. [190.224.190.63])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-617455b52bcsm3948901137.3.2026.04.19.14.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 14:35:56 -0700 (PDT)
Date: Sun, 19 Apr 2026 18:35:53 -0300
From: Esteban Cerutti <esteban.cerutti@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [RFC] block/nvme: exploring asynchronous durability notification
 semantics
Message-ID: <aeVKuVLhpjkNxLtg@yanara>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260419_143558_785700_999AFC01 
X-CRM114-Status: GOOD (  14.36  )
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

Hi Hannes, Christoph,

thank you both for the detailed replies. They were very helpful and
corrected several misconceptions on my side.

In particular, I now understand that:

- reliance on synchronous flushes is not universal and largely depends
  on filesystem design (e.g. ext4 vs btrfs),
- FUA already provides a per-request durability guarantee when needed,
- and that power-backed guarantees at the system level are much harder
  to make reliable than they may appear.

Based on your feedback, I took some time to read more about how this
problem is handled in practice, especially at the filesystem and
database level (e.g. journaling, WAL, group commit, batching of fsync).

It seems that the cost of durability in fsync-heavy workloads is indeed
well known, but is typically addressed at higher layers rather than in
the block layer or device interface.

So rather than defending my original idea, I would like to refine the
question.

Is there a fundamental reason why these optimizations are handled
exclusively at the filesystem / application level, instead of being
exposed (or assisted) at a lower level such as the block layer or
device interface?

For example, is it due to:

  - lack of reliable visibility into device-internal persistence state,
  - difficulty in defining correct semantics across different hardware,
  - or simply that higher layers already have enough information to
    optimize safely (making lower-level support unnecessary)?

I realize that my earlier proposal likely underestimated the complexity
involved, but I am still trying to understand whether there is a
meaningful limitation at the lower layers, or if this is primarily a
question of where the problem is best solved.

Thanks again for your time and for the insights — this has already been
very useful for understanding how these pieces fit together.

Best regards,
Esteban

