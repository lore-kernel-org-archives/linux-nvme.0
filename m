Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED02C54FD2
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 10:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kjllwinftrp6xZwvVjBSjRaiY0l+SGyxNnYLjJHUCgo=; b=eSQzC3LcxCLdaKOSJ/npUW9QLP
	G7DILQj4n/Q8+0zu81P5xcemc7O7JR2sQF1lMzX6e6X07oz/aUGafj8MBDz4JWT7aajqRW64sZyGK
	yHKs04sUXRPPcynBRYW0V1jP2Iihd0abNxPYe3qW3g1PWwyzyt2xgbTPo9jnxCNm4UP2LJs6QUKJ5
	v+ti5rP9Hs7Pr/WU8ALjVks2wmgkSkKr+N7XPwUXwbvUDbLqoKlrxRmmBWQudxBeeL4sAYAPcmGjU
	IrF/zITBDcG4wVeP7hWiYVg1ZLe29MfkJ03Dh22fuJBjQiIu3ga/qhGRWCnS0ew5gc5y56PzDs5Cz
	XijMUdUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpOD3-0000000AEzN-1Ffh;
	Thu, 30 Jul 2026 10:41:53 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpOD1-0000000AEyZ-2en8
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 10:41:52 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so2901830a12.3
        for <linux-nvme@lists.infradead.org>; Thu, 30 Jul 2026 03:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785408109; cv=none;
        d=google.com; s=arc-20260327;
        b=s2qlucMyinI5oK0gcPafRVm5fNNkfMxqFjAdfGo9VVChxXttOGJoHFnVFxgLhohOZi
         nrD7qc1IsvtqPSQ+qT1jAt5tYkTgBFGnNUfBTgVLt54+TPcKW8qw4cdz1zwPRYdtOpEF
         N0NWzMWu6mofg7vsfq1JNiaE4lyZO8cd8p1WrSbXMNWmErjCFYuvla+JTuvvFyELkHnL
         ldE1poI9N6s1vtuY9lli9coQrSGIRCFseB7MGuoEofIxAcnmRdwkEdo8eRqSC/RKsuGB
         IXzAPZxkDfEJx4IWS0SbQ4mB07dlErJOd0Nqdg6ccpiksAqvZB07fZeFTkjQzlAyBV5c
         ajfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=kjllwinftrp6xZwvVjBSjRaiY0l+SGyxNnYLjJHUCgo=;
        fh=F4m/U4jUA6qYXmnO+1KR9EE8CxIUHVx5yj7rlfmBQRc=;
        b=YHLilwnZvtAFVBSVHXYsW9yBSrXCi91GUzXlliM/tuL6h2WPMZlqZZ6hsjBgnxOcib
         XkTkRN/QaTimGnIbuV3grjh5uTvtH3ZfsjKrDaAtBXzwHqX9Rl0zE0LqN8ggmY19neNn
         T/STRldbd3zYbZOUhe236Fsa+IZSMnIRTW25VyFm+FSu+59Fmcmmg1fKc5PpoEtOYCiI
         QMn2OiOn/xIOMMGpQIdx8DzfFjOCT33n++o2e6pmda9kk35H67jJZVjMpU9V02jdyqRV
         oNytATd4hcA1B2CVOMGPO1HE1vkgJI4+3/oTE2emqgBf+MVG8uePwSoCAZ8gdZX3VQn1
         oXLg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785408109; x=1786012909; darn=lists.infradead.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kjllwinftrp6xZwvVjBSjRaiY0l+SGyxNnYLjJHUCgo=;
        b=ZQKUGPOb3iEQ6nQjdzFNhoYYhkzae2R/MJXEonrChCKLTVUxtgPcDCY/UGvMAldtvn
         OupM96kJ/DuBPGRNzf0yo4y2u2JbMolZTooje7wlk2hiHIO5k74QdKNKb1CThesPw7U5
         E4LaT4e1cGh5CSD83UlGRi5D8dD9/3i7iqsKnLFGJcQSdC/5o2c8MkIB5laBItuH566H
         PHTRfVGaqfrNDLhJGZBM132nf7iXgh6DKKJgJBA0JyOUSY8If4AR5e8s2pd1q1h8sLzm
         8hAMNX2c6I/uW2D6CVxbByeO5fD8mfyht9qiQfR4MXA4nMwDovEPSYyi7Y6IU4Pu85Bc
         xltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785408109; x=1786012909;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kjllwinftrp6xZwvVjBSjRaiY0l+SGyxNnYLjJHUCgo=;
        b=Io2yR3l0gO4KTaO0gGZ65Ph69tJFElqYq59MZP/UoA3zOW4I1YgTnLld5+MmNCUVb1
         mDS1oIuKRIQKmodjJyvcfSo+Gcdj/+T0x4IAvWKc1zOAkcT+B7C+1ogaGeko7pPJA+Is
         NqtPNXfQ5n/3WMU8h51KbR32U9u7dfIKwZSSey/Y0Wbf/7KNNxykJLnuIlx4qZ5yOIv3
         3wSSCVg0CV+DZvzy8zuexkxiPGSYKJSluv9ZNQTIuiNkXPGwAQeSehyJHb2w4NRNHKYN
         0gBgmE0Eg6LzjtveNzas7VYIlx8p3i+M3bM2NokkJYsA4XWQcPwIPbSacxVLcetJIq6B
         gSow==
X-Gm-Message-State: AOJu0YzKpWmRb18wfyaaDRcPglNRvQerjfBJGkEferdddI3SEqV+1kAo
	daPJbTaHppYHoeYtGhP/Wf6d6Gy1bB3rV5vdgpH6FsriTg16bRddpPv5k3+tH0QPCmdmlhZWanq
	GnIlkJbx7KHhO3HjOQ4R3nMyGskXTobzXpigH
X-Gm-Gg: AR+sD10wR+iWHsf34FNGg9MJEsBLKsw6f82EyyQgLGSKTjES74HR50JFn3u/8nAUnUW
	/zwbENCC9jMZ1DXLmtqNeHeiMEEPUqu5HMtXLGFRmxb1y1wTnjLxM95zKHI2F6JKmIsQ1+F7oOX
	gfBW/7DjdX0M5MhmVYyRFPDnifhOOPnE8zQxCunStZu8RWg7SPQ2v1OKR52olEQhF92EClT/kPs
	3dMlkCZaKncIr3T9MdechC5GaRD/Y1hNMsYIDv8gB3gD3c+x6rfXSWpHsu5xrXxczfrIVLVA6KA
	EGV4oj1Gxas11Teh1OJH+rPmX5oZHIPAZZXBeDZzvm6JmiroJpk4Xp8KRwEh5fGtCpZhGOx833C
	C
X-Received: by 2002:a05:6402:13d1:b0:697:add3:a274 with SMTP id
 4fb4d7f45d1cf-6a07b80f050mr1032405a12.15.1785408109375; Thu, 30 Jul 2026
 03:41:49 -0700 (PDT)
MIME-Version: 1.0
From: karunakar rao <karunakar.santhu@gmail.com>
Date: Thu, 30 Jul 2026 16:11:13 +0530
X-Gm-Features: AUfX_myYOo6R75o4EGoLHsZVURpJbBLWUhmEfNybKOtUJaMukOLD481xTN51l9g
Message-ID: <CAGB8rXbGnJTR8GdHM2jSpa4XMi0FwWKKhYKr=C1Co3-H-+Qqsg@mail.gmail.com>
Subject: [RFC] PCI_IRQ_AFFINITY limits MSI-X allocation on 384 CPU / 1024
 devices NVMe system
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_034151_691061_936346FC 
X-CRM114-Status: UNSURE (   5.67  )
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

Hello
I am trying to create 1024 nvme devices , each device requesting 2 msix vectors.
Total we need 1024*2=2048 msix vectors
Total number of available device vectors: ~ (200 * 384) = 76800
But seeing following messages:
  [ 9166.370948] Interrupt reservation exceeds available resources
  [ 9167.455029] Interrupt reservation exceeds available resources
  [ 9167.455572] Interrupt reservation exceeds available resources
  [ 9167.455888] Interrupt reservation exceeds available resources


In nvme_setup_irqs, pci_alloc_irq_vectors_affinity disabled
PCI_IRQ_AFFINITY flag with that
All msix vectors allocated fine.

In Linux 6.13, PCI_IRQ_AFFINITY causes MSI-X vectors to receive
affinity masks generated through irq_create_affinity_masks() and
group_cpus_evenly(). On very large systems with hundreds of CPUs and
thousands of devices, these masks can       become sufficiently
restrictive that vector allocation is limited to a relatively small
subset of CPUs. When those CPUs become vector-constrained, some NVMe
devices receive fewer MSI-X vectors or fall back to shared interrupt
usage. Disabling  PCI_IRQ_AFFINITY removes these affinity constraints
and allows the allocator to place vectors more flexibly.

thanks

