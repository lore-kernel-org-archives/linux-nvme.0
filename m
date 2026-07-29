Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB3BC54F51
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dB+7/oQwJJufIkrffkclEaWLXIsbNym3Q34Uk29y19o=; b=naGNp5ByedZqHQ4TJ3TEkENpEA
	2YceOGUGcP4kmCTj662saTO89yD0YZiijJjmidH9MvEv4nD9CXkcazehSVUCeJ4JcPTLVj6tca08A
	o7VdBGcnXNsiSTGzLYJM2BG+a083Ee5Ys1ahQ03TdPJjsacwnt8kxJ9jFPQ7BM20cTPihayv+Maql
	i1MukleaGSMf3WjLqnwUuVevQJeLLUKnyETpS3o9L9OxHej2KyOe2eGXM50hU3I7L4s/it8y/z+3I
	3Y2ZGZ99AuWsB5IOz5FTx7OTvXR/kaOXgarEhObQQZPOdZtZV21qct0avWmHigd09qZqgS7tHLVlx
	onjF1hyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2OA-00000007iPf-2paL;
	Wed, 29 Jul 2026 11:23:54 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2O7-00000007iPF-3w17
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 11:23:53 +0000
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-51c2808dbc3so5046181cf.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 04:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785324230; x=1785929030; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dB+7/oQwJJufIkrffkclEaWLXIsbNym3Q34Uk29y19o=;
        b=KYWVLAnzq9TWNgsY8g37ZjS0/cRJ8o6L0VLrJ8DwIN067CDThp+lualQvCVez5HZe2
         GnlHaWt6AkvxsiBHzSyE0BhIL8iLEczply69L/L36hxcVf/k5UpdxFTPH0q5/eboA/PN
         +P+1RJZStq6kJVE/tH/IJu6T2cmJwpCMCxfYwOWenltt0IU8zc8FgiCy3W105JrA/u5+
         6N/ndX87RbNM+POmFRlaGhuv8U2iCAVoJqECtLgcZYJ9iBN8wSOSyC4aUfq1a2CXY2FK
         omH7CJYNEpwsHQAfmEgbldbL9iOWw+DAXsPb2Jcd6PDy4/UEb7mKF/+9d8K1iidj/WRe
         RY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785324230; x=1785929030;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dB+7/oQwJJufIkrffkclEaWLXIsbNym3Q34Uk29y19o=;
        b=LnKFKl5Xy3L1FDt4bAB+JoaXwQPb7lPhF9ODlZIdcCL/Wj7ZKrOQQV/eZ7Wwop4GzV
         qNq3XwVQdg3UdvDWKwWF9VILDFMgmV+SsDiehunqzCbXNVL/W1T/NlnHTpW8qP6PEYJN
         B+UulgGApdqs2so6pzMdn0M+MfHKcekTWgWNDQoAu8jEH7mJtsBehxNSZ7hnOMI5Pdxv
         RoUjVyfcyev6BpaSAq30fT7EH9KUXedtEGYawmTlVutohHzLc3XN+LBz4b5tIB4hfR16
         BUf/obvwl7/T1pbBFqGZOVWMaUzXJUAuOYqLNK3+RRuRUYdjKuzv+mANK8lV30vNYCrD
         fj1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpz8zUx23ZKzaJiTBVcl8oYgv+li0ISuWnxgyEhNVfNrJDaVxXmBgnQptjJ3ss7DHQmbrCqzNdm7ryf@lists.infradead.org
X-Gm-Message-State: AOJu0Ywz5vQwEaqVBiwFlHroEkqXlxQiTQ0N4MF5mddLuojdY/jvB/ZU
	DP3HeZm/nyHEsVtLAPLEWMyZtAuHly+vUAllC36Bl26ItlfQGt7gq1G2auwmhFXQrk4=
X-Gm-Gg: AR+sD11loTuNM3btM6mwgVyU3/sXQ9tPABBHzgBMc8TIQta1PONjF4J8gGIG9UEsGF3
	vUQPCLfBeUqaW73E7QyssJylpDjkoF9u6WwcSj4KJZf9R/3PjjGxiLSwbQx0Tp9KO1mQXZuOz71
	Ayeym3sj/vgcp3D9R2u/1MXSvOQV3bPLWEZOujycd4dUDbNCe8gwnQ8rhRPALbj+ONl0lCkoFAN
	sAdsVVv1iXE2kBL1rhG8Wn3HLxEN9djMsqy7eeaJQ3Qt5O9qX0Fk+IzZFE+V0ix8AkaoGgx4ePd
	dcjJuR0yiHQzinvNJ9z5Ez+6aqiGv16ejXpd40wkgTigvxpKLPShN3pB9FFfyCvDDLZq4ZNxymL
	8/XDGUchTjcbm+yXkIzVmr0hmXhguoMRIzYxwYwoQXx8hlu16XtX2Sida95AXUYuqs09ApXgoa/
	Cf42uKh2da1P8ebDWL/pUDkGaHbA0vzgHDeIWp2Fed8fO145zF/g+EoBIi+93PbMSKx6SvdnVWH
	CYXijXapHFB5AakwCv52rIkWndr6++KQdfm+fd2FQE=
X-Received: by 2002:ac8:5dcd:0:b0:515:189c:e0f8 with SMTP id d75a77b69052e-529d709f79cmr54719331cf.17.1785324230042;
        Wed, 29 Jul 2026 04:23:50 -0700 (PDT)
Received: from [127.0.0.1] ([50.234.234.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2b63008sm16556611cf.10.2026.07.29.04.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 04:23:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Chao Shi <coshi036@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, 
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 Damien Le Moal <dlemoal@kernel.org>, Weidong Zhu <weizhu@fiu.edu>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260727201257.211635-1-coshi036@gmail.com>
References: <20260727201257.211635-1-coshi036@gmail.com>
Subject: Re: [PATCH] block: stop the timeout timer when releasing a never
 added disk
Message-Id: <178532422849.2568853.3142469605707392497.b4-ty@b4>
Date: Wed, 29 Jul 2026 05:23:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_042351_982419_6A9C55E0 
X-CRM114-Status: UNSURE (   9.88  )
X-CRM114-Notice: Please train this message.
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


On Mon, 27 Jul 2026 16:12:57 -0400, Chao Shi wrote:
> disk_release() undoes blk_mq_init_allocated_queue() for a disk whose
> probe failed before add_disk(), but it only calls blk_mq_exit_queue().
> Nothing there stops q->timeout, and that timer rolls forward: it stays
> pending until it next expires, not until the last request completes.
> So if the driver issued any I/O before adding the disk, the
> request_queue is freed while still linked into a timer wheel bucket.
> 
> [...]

Applied, thanks!

[1/1] block: stop the timeout timer when releasing a never added disk
      commit: 26cb8ebbfaf713c82e142d08828d4d765057633b

Best regards,
-- 
Jens Axboe




