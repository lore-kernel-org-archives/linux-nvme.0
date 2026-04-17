Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70CEEA71A2
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2026 15:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WF57saiDQPuLgei3ntL2rXLAGu55hVNv5gn2ybVfrAg=; b=PCSC4beabenKZzQfsLsA1lFrL1
	Wo9ncJS97Ljv/C01YVB3ciORv+vUYBScKMz3BjZlTncTT18WMD/UYgieC2eUE+d/5Lk5TUvvJ03Op
	53yeozCVow3Bztzuk8Fc8GhCpylVX0b65WtHfvwrSG/CbU/EopV+EI4K8b61ppZBplidFY3nNSGgT
	wDjJitsXL4wmSvDSH5EOc6r3j+Ef/VEo0z7xT/rR4JXxMD8ZZFl/xkTCK0ioW6hqxtdSzZtybIfVh
	tPjTu8/VsXJAnKjZxr5jPDqRKNvgpca1pM+SrpEF94DMWiKUGIjK8zbL2E1XCW69odda5kz/1tIrb
	+DCUvjDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wETvb-00000005sw1-17fq;
	Sun, 19 Apr 2026 15:19:19 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDln1-00000004FZp-2zFh
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 16:11:32 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so6110055e9.3
        for <linux-nvme@lists.infradead.org>; Fri, 17 Apr 2026 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776442289; x=1777047089; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF57saiDQPuLgei3ntL2rXLAGu55hVNv5gn2ybVfrAg=;
        b=Do80Ib8OETlHAyJvUg7n/d4n5Hpw0B1u5fJ/0MLpBoKy9OqoOhrKjN36Bpp/ZVJSLM
         rMs4qrAiPUyJCiFxLg9Wso1aFll3nxk5oi+T+F9m5N3Jr5LLQhSjj0ySJBP1sagIF5nS
         fkE5ALjiQbHlQOJ0NihdrE0a9DwXBl5MMGEBCbTOpLsGithhOLIYeX9A2ne4xToYlKFP
         LJKBFvNqJf7fLDbzdcvQV+Ji3lIOLBwtauMjvoWLuS4lD2pXPawD/TPMnKZIjq+snA0S
         8pOkthmoa9in75/nR/77VHPSNutsJ7C7KwCzv0E+r0b1IvR4d8T0/vWhJ6c0bWifLn/N
         4jQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776442289; x=1777047089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WF57saiDQPuLgei3ntL2rXLAGu55hVNv5gn2ybVfrAg=;
        b=okgRMFQ1lVBMUW/pdq3hsGca2U3jiQ9Jv6PqCodf2aX5bjQb/rk9D7t5Yc84v/rkLT
         RdQmDslD0C1bzvp7CIYUi/TG9jrmHznjCQz8KaYWabhUV8ZvB5+MDqa7qkEGZJRpyjxW
         +Wo0W572Bw1MP1EL1DuQXt7T4HtEubVNVs4gwaf0u6G0OKX7CVS0283eTG3z39KJrohb
         5t5iVgnty4/dc3k1WLNOQFt5caC2Y1fRIwkgVRmGvU/6xm9z3Yl7KlldxaiB9TSWMz+O
         6at63NLao1W6uTFqNJpzPRoQ5TovVU24bpSgL4eEyu9JNer3msBfUitiMxZW1yVPoxQI
         6FZg==
X-Forwarded-Encrypted: i=1; AFNElJ/BBFXm60J7rhdcNqxTyspGpvb1l7sbYqMkliOVoiHskRCQrMsp9mpmjriI/3QDgKnoT/m9GguOdNtU@lists.infradead.org
X-Gm-Message-State: AOJu0Ywu7CqAu/7cvoEsflyvp6KVAEDF7iDYCm/OC46W1ATN8bWtm1V2
	ilmvspVAk2yrAM01ukY/5P83W8hHtLccp6s7T9n/M6mOze9lx0jXuc9M8Ol7bUwB4Vc=
X-Gm-Gg: AeBDievp45DiEKx/AEm0VRlOvQVVOiTuYkZweu6NAzyuW/iYzAQCCM7KhDT3opXa45J
	QhFHroDPc8OMj8q2wHlrjhzR/VuPAr0Omy1z1OfXD0YgP0/tHDTF9cGfpuUCTqKZ1NrgfO2z8bR
	+dVQpvtTFRofS+BQZ5CcWbzIjdS+1a9pDsTk95QxuvNJQebuRdrIy62vGWX8BGc6FjOVlFzd8cW
	fudFKHhF/AZHDc1P9Q0pumnrgUJNQdamWdbp8GZvX6HTje+JSJJv42LOdkVhBftQRq1VndEg6Lt
	cTWVnW9vmqYwLXZ5gj3nYXsiknImptDv4OL4I5jqgZi3V89kiKcomoNTbJE9LC9odPvpWZQNAQa
	7tSfYnrGRGc0fiYC3e9oWPZqJqBw8gDoWrSFWLoq3dLV0hO5N0kH9WM5006mXv1C/sv1pgM0R+u
	T4pyO3rfJA8JS6tS00I6vp7vWGbbeZgXKh2fOutFWEFczaG3ajN8ziEoq7Fg==
X-Received: by 2002:a05:600c:6296:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-488fb73d764mr52764605e9.1.1776442289414;
        Fri, 17 Apr 2026 09:11:29 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm54863625e9.15.2026.04.17.09.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 09:11:29 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: atomlin@atomlin.com
Cc: James.Bottomley@HansenPartnership.com,
	MPT-FusionLinux.pdl@broadcom.com,
	aacraid@microsemi.com,
	akpm@linux-foundation.org,
	axboe@kernel.dk,
	bigeasy@linutronix.de,
	chandrakanth.patil@broadcom.com,
	chenridong@huawei.com,
	chjohnst@gmail.com,
	frederic@kernel.org,
	hare@suse.de,
	hch@lst.de,
	jinpu.wang@cloud.ionos.com,
	juri.lelli@redhat.com,
	kashyap.desai@broadcom.com,
	kbusch@kernel.org,
	kch@nvidia.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	liyihang9@h-partners.com,
	longman@redhat.com,
	martin.petersen@oracle.com,
	maz@kernel.org,
	megaraidlinux.pdl@broadcom.com,
	ming.lei@redhat.com,
	mingo@redhat.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	mproche@gmail.com,
	mst@redhat.com,
	neelx@suse.com,
	nick.lange@gmail.com,
	peterz@infradead.org,
	ranjan.kumar@broadcom.com,
	ruanjinjie@huawei.com,
	sagi@grimberg.me,
	sathya.prakash@broadcom.com,
	sean@ashe.io,
	shivasharan.srikanteshwara@broadcom.com,
	sreekanth.reddy@broadcom.com,
	steve@abita.co,
	suganath-prabu.subramani@broadcom.com,
	sumit.saxena@broadcom.com,
	tglx@kernel.org,
	tom.leiming@gmail.com,
	vincent.guittot@linaro.org,
	virtualization@lists.linux.dev,
	wagi@kernel.org,
	yphbchou0911@gmail.com,
	Marco Crivellari <marco.crivellari@suse.com>
Subject: Re: [PATCH v11 11/13] blk-mq: prevent offlining hk CPUs with associated online isolated CPUs
Date: Fri, 17 Apr 2026 18:11:16 +0200
Message-ID: <20260417161116.373130-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416192942.1243421-12-atomlin@atomlin.com>
References: <20260416192942.1243421-12-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_091131_771034_48B06480 
X-CRM114-Status: UNSURE (   6.32  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Sun, 19 Apr 2026 08:19:12 -0700
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

Hi,

Seems like the commit log of this patch is duplicated, isn't it?
I noticed it's like this from v7.

Thanks!

--

Marco Crivellari

SUSE Labs


