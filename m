Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CD4CA9ED2
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 10:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GhN5QPUwL1Bq4m1uEuHr6tNGLQly3fEYwhLYLsDwGEw=; b=4waxhhObTI4i1EIUsPz1ulTS3p
	Pt5cXtHyrpYGxrJU7+RJ8ER9zdk6MtRlnJdl1yTGMDCBke73XcoRCQ5wAvii7WrObrrqFNJvnWUyE
	ypT6jEJY7rOxikKEu/8JgqCljtA9OVsKHWeyVDTzHkSGvL/IKO0Sl6KNs3Zk7rGr4Z5BBTUgXZkfg
	RZ8Wyn+uuXpd1Z2Tmm7wGK20PyTQl0xLdH31w6nEAO5yc3zvzrzYIwXlBQVmiIP+Q8n/nsX1e8t7m
	k1DC4HfOjYtgIkiLbrbwgtcMAatejhPTIFDXcCcD8BJREMK2drQsL2yTurQzAZNM+SqAnxn9uKOfs
	AnjpxMsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGZkK-0000000CZQ1-0ECS;
	Tue, 13 Oct 2026 10:28:36 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGZkH-0000000CZO9-2BXs
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 10:28:34 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-3ab8309dcbaso1903648a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791887313; x=1792492113; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GhN5QPUwL1Bq4m1uEuHr6tNGLQly3fEYwhLYLsDwGEw=;
        b=IoEoAyn9y/FIn+iF2Z6pghUJ9d3SftpSgmUP6m+u9GeXCrC15vxeKcL9riwBxNis1Z
         3ItF/JMy/R2Pw3A1dIpD/Qs5J6rBpYjMC60OrmuoRfrqek3yoadPQDlzFzqYvO05GjW9
         LzDFrp/j4JqHHf18MlZ/oN2rO6wt5G7JblpEfzPCNIyHOf802dPWq12reo6dK7WJpiy2
         jpOY9/ibl2YhEpBZbQsifPm5kFl8T4cnHUibd6KaJnKhkcddinycHxnrF7zlIeEenG7U
         c4XjKvTEu5x1pJOfR5ci+U7xXIxMDPN93FHlKPskyzo2s1uGek/7bllR1FK9Mh3DAVXW
         VuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887313; x=1792492113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GhN5QPUwL1Bq4m1uEuHr6tNGLQly3fEYwhLYLsDwGEw=;
        b=BgVKWAoPn+as1WBsO6WzX0Yz2T+Y2ZigqBWCYw4doerD+3LktKFZ6+jOA9rk2p7JEx
         T8XgCofrftOcy0S2QT7ohej9VsU/A9cZj2Rx4Bys/AYGn3BgkwABVELpWO9Tg3qnTwsC
         Hzny25q1jhOZhyv+MiRpYz1oc2mh5HjqL6kXOk5owLaRQIiPGIQ2H/9UH07EshW2LkCK
         +GSeOZpdjUcvsmtwSfRXkU9w/SEzzm/BYQrEyUW7NvwUJcIUNx4k2rsXummPrpaqOnTW
         sEIK0RRuzt1eu2IU+4U0kQBBadpV8kJrHBqK79HRevwKeER+50A4aleCuHu4b7V2F/iI
         +GPA==
X-Forwarded-Encrypted: i=1; AKwUvBw6aE0+q8oBiwi4VvDVlhVSznSUqA2jvhAVzZRy9sMzZ4G9hlyg5YTrR2Vly+Z/bLJqoEALMmYvtxw/@lists.infradead.org
X-Gm-Message-State: AFq9FYKEn1lfaROT0jaEJ9Ho44gZVPc7h0wE+p3wAS4cjXqofyTC7bIl
	GDbhOgz7FwEDdVIMdluRmjWBNN8HCt2N1jI0gJPNqahbplxmB3oecIYQfqINlcWDmyQ=
X-Gm-Gg: AYBFou2wr52SXY8z+FIubAaeq4vhf6P5HjdvGQlJU7X+F+Hp2T6Yp+HVLEdYVmxwRqq
	bye12kD8aQXk0tHi8WQjBqmHsSqiurGtZQr/Hlk9eEsQ/oi8Fpnfupi8S460Bp72ihyM71G/LU/
	4xQenhDANSyFo/FFhr01Z+ULQhDsehIIq7lHXj1WtU93bb6FsemOWFdQavrtpHrGaXCFiAOJxT5
	MMFQV6unqk8W7H3P+I6Y1dqT6kYoD9pYij7iimqxVGzArZhwv9wqqLYpRrii2gfIOT6m2YoefIs
	DvGPTU6joMtDqzrY+CobNdKgsrueWeWHE4q4KUWLeZCWe7e17eApTXV8dfS47x4aT435fBqQxMo
	WHufzbx0Fza+pwj1zihiKK+Wf9mC8VhcOVfhb000rU1tz7lTj8lUxIO61SMamsrcLBNrqP1T8pz
	ipP6KwdHkaI6jSVuxeHRk3gM50vNsQ6sns3peYQgHaEpE7MugFNEIbzOakNWUcLXxr3+mUErjDc
	c0fyA==
X-Received: by 2002:a17:90b:2d0b:b0:3a6:f6b0:30ce with SMTP id 98e67ed59e1d1-3ab3acb9c79mr6801718a91.36.1791887312674;
        Tue, 13 Oct 2026 03:28:32 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed040dsm25809485a91.6.2026.10.13.03.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:28:32 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: bound FDP config log reads to the received buffer
Date: Tue, 13 Oct 2026 19:28:24 +0900
Message-ID: <20261013102824.3020520-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <66bf5def-eabb-4c9f-bcd5-0143655ffd1f@samsung.com>
References: <20261008182453.1262733-1-yhlee@isslab.korea.ac.kr> <66bf5def-eabb-4c9f-bcd5-0143655ffd1f@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_032833_583297_9DB2D27E 
X-CRM114-Status: GOOD (  12.33  )
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

Thanks, this is cleaner - I've folded all three into v4: the minimum size now
requires the header plus one descriptor, and the per-descriptor check is in the
walk, rejecting dsze < sizeof(*desc) (which also covers the 1..63 values the old
!dsze test let through) and requiring the next descriptor to fit.  I kept
kvzalloc() and the unaligned accessors and added your Suggested-by.

On the get_unaligned part: I reproduced the out-of-bounds reads under KASAN (a
short config log faults nvme_query_fdp_granularity during namespace scan), but I
could not exercise the alignment behaviour as a fault - x86 handles unaligned
access transparently, so it only matters on strict-alignment architectures,
which I do not have.  I verified it only at the code-generation level: on an
-mstrict-align build the accessors emit byte-wise loads where le*_to_cpu()
emitted a single load.  If you would rather not carry an untested hardening, I
am happy to drop the unaligned accessors and keep just the bounds fixes.

Thanks,
Yehyeong

