Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5834BC98314
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2026 06:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tJPZ6HTxNtNeAlRQ89jXZdruOuXjbaVPhr0XhYWbXqI=; b=y95CRYtX5e+TGzQLeLA4bQaUrY
	MIuWOP7ogN4VXcvIQmjQqAu9bwJz4ZWw1Jv7Ovp9QDjQUyC1Gcisvh2O+sf6AV2tPunWnEpEiYtK3
	gdfw6wPvwIaqQgA52/7TRnvLX5PTA3fxX2XQbj3G1g8bvWiSf/2fpsr0KIYtsqAKwEUZYtNf1BnYY
	beqJU4Hu+f89rZjcEHRANwcJZDIsrMUZLI1RGKbqW/gUHCE486NKbyUa9vqYSXhjsRo7kTY91g8ts
	NsZ3pwYNpYUoo1CN7mICzv36SdDjHwCeAqZhWEvlL8bUuzWJIf+bZlmQ/QMmC59TAgBBAUeGspNxV
	E/WObQQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9d3K-0000000AAOh-2TaR;
	Thu, 24 Sep 2026 06:35:30 +0000
Received: from mail-dl2-x0e.google.com ([2607:f8b0:4864:38::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9d3I-0000000AAOJ-3EZr
	for linux-nvme@lists.infradead.org;
	Thu, 24 Sep 2026 06:35:29 +0000
Received: by mail-dl2-x0e.google.com with SMTP id a92af1059eb24-144f47a9b57so1836760c88.2
        for <linux-nvme@lists.infradead.org>; Wed, 23 Sep 2026 23:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1790231727; x=1790836527; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJPZ6HTxNtNeAlRQ89jXZdruOuXjbaVPhr0XhYWbXqI=;
        b=Tfo6lbNiK5H9L9bCT4QL+Tavu1HdoATx3Gaf3jZ5bnC1WV1fpX0Up/O00j+PGIljRb
         2Jdcr0GGloHmNuG7dEzWgNDkhVsNgbavlGMF7UsHV71Y2t7U8vODdi7Y5Kz2uoMRG3wh
         tqdbo8cx02ufYwMkmnoAeGo+RR9q23oZYkrhAvCO3DzY6vx6DsyZbWO9CndJKmie5epC
         Y0cSuc/TZev5yz7nB22IvrT5Eeb0rpj8HYYs0LjNOTTpsgmL1GT1L46tQnXAdi1ziqRa
         Qcx0oguvH5I19UfwRptayYTjjlHmxMk31ormCDqIjbVD7dlAF3nrvY5678asXjrbXs+R
         /tUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790231727; x=1790836527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tJPZ6HTxNtNeAlRQ89jXZdruOuXjbaVPhr0XhYWbXqI=;
        b=LBrgPZcQwxjb7v/vG0laOl3gyvLe1o0SE8EzNVf/T+0EelUerU9+eNXXDxF115tg8D
         bdI3ode5FOIekT3S+CvnochnnTmx8MmMlnPT9P8euS4adoGwS5bh5vLC91wvykuOs8nm
         8dhzWEOhptHcuRun7BFNs8HLnGTix17MFd9KpEtEEIli+18geSojBr3APTlysWs/VEVS
         HlSIQ/AkGLCbQ3DxCIobusanvVtT6TM+aCE7SoWPzDsMNzc9CjqM4/qc7mXkOlPMzTvV
         +t7geF/O4gQVKdEMRiDNr6NQCKD6UjMWpqgFIHzLfCdBlpfLB9mRX9GnNr5wBotOObM2
         7wRQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2iEJ7z15PkPyD9737T3XecAl7+IF+f2yRpW87Z9pDnQ7rse3cr1GQAuTXgpeGY0hiFPj5JQXJhFk1@lists.infradead.org
X-Gm-Message-State: AFuF++kSCxrjKMq0zDkkvaK+ZF7q//M0ngVCArewSRxW2LTxoUlLU+sI
	xXDCufFs9VIPO3lUoChBWw3DWFQ3dFtlDk6VK4TdymCsqfY9aNEaGYuX+b3y1sb1Cb4=
X-Gm-Gg: AYBFou1RD/rm19MS38ss2oRvJGb+NhPWU00hWQI1M53PjluczaoSHy/zKy6TNXKPhn4
	RpwIzZz6HiLuuLvR0VmVB0jgBTVhY8lCZhAD3jPUG4dnI7aV3rYEWyOdl3PYlsQZRS4jTznOslL
	IbS+eJLFitYRUW100tjRwcGyVAJZnLzty9mb385pq9w1PSSFRz2gWTWocpcWyjmOo3t3UHM0Chr
	z/zkb+yELJbCIzYPTMXJ4TvK87Y3zegW8VtZ1VNbnt4F46YCuXO3mzlPUpiKWcekI0fGJAjFZQq
	O8hDmuCnGm//PxSr8kNmEa6LC07ZpJSoCXVaBD7iAxS0hnvCXZKgZhLPB+Tum/G92rFRr7nWp4N
	6QffleBUp5uzrHFoOsR/PzBzy4hoX+EKi/0oNEZFbaELKO1VhuOX6TrRgEHxSoeobWLkMEIxDgy
	7Xt2Ov9og/x63NhrWVWth/e7J9HZm9hHi5mdkSpRYpMAdQbsky3lvs1JvcV2zsVx+YI+IGAoPI2
	hqU4Q13IDKj5docjU4qIOefmHEtu0kWUaGjrNgHSrCKpUXf
X-Received: by 2002:a05:7301:7bc9:b0:33b:e77f:8a3c with SMTP id 5a478bee46e88-34000d3600amr1526565eec.33.1790231727245;
        Wed, 23 Sep 2026 23:35:27 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([2601:645:c68a:b830:3831:92c7:8375:9edb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7d003sm10291658eec.9.2026.09.23.23.35.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 23:35:26 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: kbusch@kernel.org
Cc: hare@suse.de,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nilay@linux.ibm.com,
	sjpark@crusoe.ai,
	saravanand@crusoe.ai
Subject: Re: [PATCH v3] nvme-multipath: add fail_if_no_path sysfs attribute
Date: Wed, 23 Sep 2026 23:35:24 -0700
Message-ID: <20260924063524.26807-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <arR3zlpx3Xm2mRt-@kbusch-mbp>
References: <20260923004959.88440-1-kiyer@crusoe.ai> <arRJLL4ki-sVQnHf@kbusch-mbp> <20260923225753.49224-1-kiyer@crusoe.ai> <arR3zlpx3Xm2mRt-@kbusch-mbp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_233528_826575_71D432D4 
X-CRM114-Status: GOOD (  15.62  )
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

On 9/23/26 6:07 PM, Keith Busch wrote:
> I get that failfast is at the controller scope, but that seems okay:
> when the transport is down, every namespace behind that controller is
> equally without a path. When the controller is live, the per-namespace
> inaccessible case is handled separately by the ANA state, so namespace
> heads that lose access bail and the rest can carry on.
>
> Is your intention to have some namespaces wait for reconnect longer than
> others?

Yes, exactly. Some namespaces should keep waiting out the reconnect
while others should stop waiting and fail their parked I/O, decided
by a condition only userspace can see. Here that condition is a
killed process stuck in D state on parked I/O that nothing will ever
consume (for us a SIGKILLed VM the host must reap), and it could be
any consumer known to be gone. Failing that namespace lets the
process exit, while namespaces with live users behind the same
controllers keep queueing and carry on when paths return. A
controller wide timeout cannot separate the two, and there is no
duration to pick up front since the trigger is userspace observing
the event. Reconnect itself is untouched either way. So the kernel
provides the per namespace switch and the decision stays in
userspace.

Thanks,
Krishna

