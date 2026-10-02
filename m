Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA0ACA5FC4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2026 10:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vpk8Ru4AsfGcR1vRakWQaDXiCf8WQJ/l86p5N9xJk9Q=; b=S/nLdSXxj4bfievDenmHRsYhEk
	s6MPaXOocNbnV3woDhzoCr+AzKIYJCrcL4AKDvAKwDHPyvXheuAjWGXUgqS0/T6aHmCmPbdNhkX57
	eBTskfHPyznA8tgYbtP9Ua0qlYwF/sBlFiSAHzA9bpEzw1u6Bq9LU+g24Mk/kteyZ1CbdOscdwUma
	dK8E2RA/PGZad1Ei5dKxtPMbkyVWAXaUbifdErup9eBPLjDMyLMRA6YjMVCXybTyB2tzGYvDyNYtr
	4P4BGxV+iHGKGssjY3pqqanwVvvIbR+/iPUekC5fnyul8QuZdzIhF6Kg1YaCEGne8LXGqGo0/rrYI
	0MK3d5tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCawB-0000000BOLE-20vf;
	Fri, 02 Oct 2026 10:56:23 +0000
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCaw5-0000000BOKA-0Hpf
	for linux-nvme@lists.infradead.org;
	Fri, 02 Oct 2026 10:56:18 +0000
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-482f6350f91so4363085f8f.1
        for <linux-nvme@lists.infradead.org>; Fri, 02 Oct 2026 03:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1790938575; x=1791543375; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vpk8Ru4AsfGcR1vRakWQaDXiCf8WQJ/l86p5N9xJk9Q=;
        b=Dw0SeL88+IBdSGkO+JAH0qCOVMl9zQKZjWei98FMBn4bvQkiVRckbBPx2GUJe8YVMH
         UHel3WEvwEGW2/GXJC2h7B00/F1SA8oHXbiqDZHvjF5PBiTMHv0EUk7cR0lx8L1++xG6
         zI/JfQ9+SjGqEvNPoUBgTnXiEtZhSI1YuFgJ9w4+mz5Y87SxLS1T5h/xAi8yhqJyHa64
         /VzrTTGx0QAfqDkHFFzoEpTRrpJnlSGzeVZjodhp/vtpbXPKZa7Tzb8OFIAq6qc0gVov
         AGZyxPwUQiK5QWmszyJEMXT7pfaJsEbU7EMRqICxKZ7enhLR4bz14hLIqivtVyogO46i
         jcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938575; x=1791543375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vpk8Ru4AsfGcR1vRakWQaDXiCf8WQJ/l86p5N9xJk9Q=;
        b=BmlsoqNd8/V2f1/7/7BDzyabNH4f+EXjip4sp9H9DLZ1cK/mg8kqp3L/c6xVGfvq1M
         Aoi+v2EtFRfD/AeAHy5Ayg6XcbISdkVgM8Th8182tQAwUyOC2CnblPYhghGM6q6cLdfe
         s/Gd9Y2lZJpzOYwzw7SAzjPEZZvAUeN1Jrt+TCSA+LawJe0MGth0vKc0g7bYEAe8xIl2
         R7JB+5rL6WtQAByHQbssIVRF7yR5QoCiyKgucOztjNSaJnoFvJXqquq8OAGrqGZzYowC
         K4/YHRr7PX5ReI8s3mONOYzPbfeI5sRtcecbEcEdHYsHA/sdOCX3s++AWWHLeYQL4EZh
         tLnw==
X-Forwarded-Encrypted: i=1; AKwUvBxVIqqINN+lQ3eT64MkPp8c41j3ZEDHTW5SEHc9bfcRnn3d8UlJDfm+bGyevKpLRyvEJJiK90dKkALz@lists.infradead.org
X-Gm-Message-State: AFq9FYLnN4bHQs2+VndfBGaJY3c7mzLWXHNG9bzp8McHWkAxuTWIsI+y
	4AZa8bqYQznNQ2kU1avKhNjxFQJIekbHFBoTTxvj3ujQrl+mqjBLo+fW88ST1fe+NT8=
X-Gm-Gg: AYBFou0KTsBMDADnGxcxyXzjZIlHg77aPRJKh6R5yW/VUiLmLiG/6bmu+TwcfvZJcLK
	gNHCyCzXKQvkwEbUMs+pLevctEdxsjk+ug1bq9SRjqYLTPEzTb7VtQZ87VxloSYnoKwIjctmljY
	HwiLs0AuYPuLdo53YqGBJ3IMN8lPczzYmceHWoVTHTcb5PFnvo+7xgvSBsDqkFWeYpGQhuHKeIS
	PYEanRS6aAv18FpeqQNlPdpZb61PGjOKE8dElxlZjT1pyHxwVwHXgkGah43cC7uTMPlNFX8uHnV
	0jAH+2TI4nkSaihuF3qyFyMFhRCHJRmFKcTDJxqRBneeYy+1L31RdAzHGno3Fq1xjBQwshfWMlI
	lFdyTfqG48VF26klSCkdYU0z9BkTN9cGb1fCniaR4GT/0AYRHuRIYhGEf28pVqtzE1G4Ab44EG4
	vaGAqJYOIKSIZp1SPLun1IIZCKzIEplpGU0oVhuE0TtuWwdF9jwkJd3dJXGK4kAoPnp3z8AGJEv
	39lx04jfRxH+RBre9R24ALbG3SzUlwBT8coFEHMnKU9oQ==
X-Received: by 2002:a05:6000:4304:b0:48a:fba3:d5b1 with SMTP id ffacd0b85a97d-48b127762c2mr4417736f8f.55.1790938574625;
        Fri, 02 Oct 2026 03:56:14 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([83.71.242.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f9ae1sm5102058f8f.39.2026.10.02.03.56.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 03:56:14 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: Hannes Reinecke <hare@suse.de>,
	Nilay Shroff <nilay@linux.ibm.com>
Cc: Krishna Iyer <kiyer@crusoe.ai>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	saravanand@crusoe.ai,
	sjpark@crusoe.ai
Subject: Re: [PATCH v4 2/2] nvme-multipath: add fail_if_no_path sysfs attribute
Date: Fri,  2 Oct 2026 03:56:12 -0700
Message-ID: <20261002105612.25298-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <4a4e228f-7143-4d5a-b773-2c6238852503@suse.de>
References: <20261001094857.74567-1-kiyer@crusoe.ai> <20261001094857.74567-3-kiyer@crusoe.ai> <4a4e228f-7143-4d5a-b773-2c6238852503@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261002_035617_119064_26DEFC12 
X-CRM114-Status: GOOD (  14.91  )
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

On 10/2/26 11:39 AM, Hannes Reinecke wrote:
> I do get the problem, but I think that 'fail_if_no_path' is a misnomer.
> Problem is that we already have a 'QUEUE_IF_NO_PATH' setting, so
> 'FAIL_IF_NO_PATH' really sounds like the inverstion of that.
> Only that it isn't.
> Maybe rename to 'FAIL_ON_CTRL_LOSS' to make it clear that the two
> settings really describe different use-cases?

Agreed, and thanks. You are right that fail_if_no_path reads as the
inverse of queue_if_no_path when it is not, and the v4 split makes that
clearer. Patch 1 now fails the cases where a path exists but cannot
serve I/O, so the only thing this attribute still does is stop waiting
for a controller that is gone or reconnecting. I am happy to rename it,
and fail_on_ctrl_loss describes that well.

One piece of history worth surfacing first. The fail_if_no_path name was
Nilay's suggestion in v2, so I would request we settle on one name you
both agree on rather than change it twice. Nilay, does fail_on_ctrl_loss
work for you?

Cheers,
Krishna

