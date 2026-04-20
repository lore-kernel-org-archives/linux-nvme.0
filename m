Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783D9F8FA8F
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 15:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CD9/SaQbaCJB7OvL/7Y9DGnFoX5Sh5QHuy91IeKetc0=; b=zLL7jvdqvxuZZH3oeG9nRpjQbS
	Upn5MMS2b4tSHhdYXIrKVBbV8dstEBKrV9wVKTzNolwnd4MccCQSVHSC9Dy52Ur+e0zhlFI4emCCU
	A+ig/3bN2ACPcNdXiIbtA2OnDXLxQ75xIpWcq6l5ZAvDpR5FURmTZz9chTiiDR2DTcyW8d/RMalRt
	Wm6qcRwpgkJbeEC2joiA2gpCtQQAoNMy88TMklymMb30f/wwkWU8taUzNv574kmK0yNPQOeg8VMFA
	GTFSJaOmxo10UJ1NXUe0rpeY8pi2cglp1XNSlnr11EuM4Z/4ixLgQMxAmjkFcHtMAgmx4Az2gRtIV
	kikRAVFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCfU-00000008oS0-3nr6;
	Tue, 21 Apr 2026 15:05:40 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEoQ3-00000006xcY-2EWC
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 13:12:08 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-43cfce3a195so1871377f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 20 Apr 2026 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776690725; x=1777295525; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD9/SaQbaCJB7OvL/7Y9DGnFoX5Sh5QHuy91IeKetc0=;
        b=R/X8OWAnoIpj4fta6Ecb/9y7GlDpOl8qm6okHChKaqcI3WADVkXH093S2nR3EyNk6d
         HF13nSG8NA+vELT4GtaZxdsfnXhM/wfS9LNOt+aFX5wqJAxSZFix7KEqTpsK8EK9YInl
         sYOY0OXn+Le/lUA3N4uJjqe9HzIE2WbwXFqZRybpU/5fLt2NrsXytpOjaXCfNEFNZ7Qz
         91BGw1oJT72B4y2mVYqAjKLKtPjQN3VvW/L6qkfiPdqTMfeu7tARyiLiB8h8EhzA6EEy
         37H/zqtvHmmgzhkB8i+0UcH2dpXue0EY1iSakI7zt+w0vIg0oaj3pyR4YFuDoVLiubVm
         WgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776690725; x=1777295525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CD9/SaQbaCJB7OvL/7Y9DGnFoX5Sh5QHuy91IeKetc0=;
        b=q8ASxciQ8A7wAfAzGX9NifL4gCPnSS1iCqQDi6eq5is9qMvZPM2D4Bvw1vtolIG3xf
         bbYMvCfD/yLOAoVNpJIgbIt1MezWjHbBarPwwiUFdJb242rgA0pXNIEXycPJ5MEq1VE5
         cYAf0X/VCA0davsK08ixlthIbPZ5JAjFDjo2NHDL+CqdWaQYhpF1F8DFgt1ekN9yJ17K
         8AJGrt9pZzKV1QWEj9V76E5Rajzoz4jdpjLOvRhOZu2CQRBkUY0zUV7Qt8RudTcrkyTn
         Cdeh/eoHamOYom7s1i6Ywnk11LlKZpryhoQj5FZXeE57eeWjwnanitBYi9QUoKcVokmu
         sSUg==
X-Forwarded-Encrypted: i=1; AFNElJ9IAHhkHFdEy7REt2Ex+iIj0+SY5cBimIAQ24AutKWgwnF0/b8LKCj2bRTUU122bRbcohTXaiJN8TA/@lists.infradead.org
X-Gm-Message-State: AOJu0YxCFBDkUoYRlSi/AyxUtpWnRn6tty9tacxwz7VXjRZ9VEn0OUrD
	y0Vjan5bpysS54T7vyCXzE8Wexjy78bTWNiQ9TLWR/kZtbr8h35nGeNM1Y46w7srv/o=
X-Gm-Gg: AeBDievjoBR7f2minCozkkWvCc2kfxwv3VydaCRjWYlKDaYEwIYf3IqdKpQWW4KXdqa
	YKIOZ/h9W6I6lad/jCMtUdcIFaaLXsahs/+pn2/Z5kCFCAUXwsp+mWX2OnbAwrb52cnWrwiJggA
	ldGJa1EBfXTQsxCc2KNKEAeUxHGxqtX5RH1p9PjInnkNO5WeT7dt9eFo9wSPe7HcFn/E/6NyVf5
	G1fMzfNV4vwpQpHRqW3sUydHZS0qIXY+AfeElcg9vHNlSA7DrSWB11jBL9/FH6TboXpHJ8Ws46k
	/zFCoWdv6NVuMdDdHrogo698ncA2pgUtGzbczKE5arywG4czurlCVgJp+bQKAK9D6ME6Uzp8LxX
	gj1XbojjhDtwfRARzo6HAIWauJrXLNLO4b9IfWkY48d5mGU5OLtdfxk9KWpMIqF124RSks8d7VY
	7at7klGLoMS4+wp6lbqPdS9lkTT/z8cUuiBImlcaoHlH/oRK2yYQ==
X-Received: by 2002:a05:6000:25c4:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-43fe3dfd332mr19870492f8f.36.1776690724775;
        Mon, 20 Apr 2026 06:12:04 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d112sm32580385f8f.29.2026.04.20.06.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:12:03 -0700 (PDT)
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
	yphbchou0911@gmail.com
Subject: Re: [PATCH v11 03/13] lib/group_cpus: Add group_mask_cpus_evenly()
Date: Mon, 20 Apr 2026 15:11:52 +0200
Message-ID: <20260420131152.243488-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416192942.1243421-4-atomlin@atomlin.com>
References: <20260416192942.1243421-4-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_061207_587562_FFDC30BE 
X-CRM114-Status: UNSURE (   9.46  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 21 Apr 2026 08:05:39 -0700
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

Maybe I'm missing some background here, I noticed group_mask_cpus_evenly()
is called inside irq_create_affinity_masks() and the "numgrps" it is this_vecs 
in the latter.

Looking to group_cpus_evenly(), seems it is possible to have this_vecs
equals to 0, indeed this function return NULL if numgrps == 0:

>488 struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
>489 {
>[...]
>495 
>496     if (numgrps == 0)
>497         return NULL;

Without it, I guess the kmalloc() in `group_mask_cpus_evenly()` will return ZERO_SIZE_PTR:

>+struct cpumask *group_mask_cpus_evenly(unsigned int numgrps,
>+				       const struct cpumask *mask,
>+				       unsigned int *nummasks)
>+{
> 
> [...]
> 
>+	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
>+	if (!masks)
>+		goto fail_node_to_cpumask;

and this value is then passed to `__group_cpus_evenly()`.

Should this check be added or it is not needed? Or maybe rely on `ZERO_OR_NULL_PTR()` ?

Thanks!

--

Marco Crivellari

SUSE Labs

