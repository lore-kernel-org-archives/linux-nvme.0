Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE5BC4346E
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 18:39:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51DC207BC
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 18:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ES1nWlOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51DC207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nucleodyne.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:Subject:Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Nqr2mwPvzjYOTdRd8XEiobHq86q4MOKepWax8xIYBeE=; b=ES1nWlOJ2YfX9ZPwZpSpMSmSSA
	+bPIbXJmkRvH+89HQuwImTp04NtkRb3cveK2WIK6u+vHIFXc/DMdfKFN6rsvrwXF2Oe/OENxTRvZC
	nNbosuy3MchJkBZzTQUxiHfKKolg76eO12kyXKOAr5KfUFpk1PtHR8ZtChpTGijL4GszEr6SEC4AN
	RutC2Sfd/NDAIGj/zto/8aq6TI22nlEppRJboAjGrzfr5weVyyf0DmMGRUPY9QzfhL7LF0K7YecRt
	8uVbkgy77sRJ5jMCnIV47dO4dwYAklQw8M2a5A9WFSqZq3qWjyp2VEbrV0WbwBMa8IO3bqT6OT/Q1
	ZXlwLFvA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKQiP-0003tI-M4; Mon, 21 Sep 2020 18:39:05 +0000
Received: from mail-pf1-f172.google.com ([209.85.210.172])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKQiM-0003sr-3Z
 for Linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 18:39:02 +0000
Received: by mail-pf1-f172.google.com with SMTP id o20so10031161pfp.11
 for <Linux-nvme@lists.infradead.org>; Mon, 21 Sep 2020 11:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ntaTqbrr0rmtCf5rlhR9Zpo5oVmCg+MXi4Dpg69nN74=;
 b=aeKHTH+UMuH56ntwx+pAqwSy+w3+4ZOY5HjtzogTbWyPmErd0j++FzZnCiiW4l9/VZ
 mChm74AGP8JDD9+V5NDrVNAX1Md5McWRz5vHePmMk/NG+AaDN7tBWGcQhhI7/8Ob7dpT
 HiMdHCGbMlJ0VMfCksXRwLgDHr7QQj+Hk7woW/Kau6JdpwPBrhaj+x9pVK1zoTykYUAQ
 M93GU4DazulTzifwm6a28PuJx3XRfn/9rDw2kC5eIvnqMWL7YaUTk7XCHaAZvk0xbXvn
 mM5AVWUDmwDKDH7lSN1HMXp5myzZYJ3Fqu7Jv7MHTu5aK9EEYOqPth5/ptrv7QhwnHRy
 pm5A==
X-Gm-Message-State: AOAM531BGLAW4WG14osTHjHV7EB60zZUfCOv0yCMMK5s4VWV6B0xkqMU
 eAJ0h4Xu3Go8MRB2eJx64k2sWDm3Jxn0dIUALLGsMUg5g9BGUmm5
X-Google-Smtp-Source: ABdhPJwc4nEw5fn0CbfEVisFwt7Os733PdszKFV2UTcnyeR7ana3zJs0vkJuzx+8IQXuusSjtN3KFmAtl2FLBGmdFjM=
X-Received: by 2002:a62:7c82:0:b029:13c:1611:6532 with SMTP id
 x124-20020a627c820000b029013c16116532mr1083718pfc.4.1600713539447; Mon, 21
 Sep 2020 11:38:59 -0700 (PDT)
MIME-Version: 1.0
From: Kallol Biswas <kallol@nucleodyne.com>
Date: Mon, 21 Sep 2020 11:38:48 -0700
Message-ID: <CAH=XD5_UeVPWHskOwwPeHZpv9sKXKvvA8BS-_58KqdXfpY8OWw@mail.gmail.com>
Subject: processor reboots if nvme host controller is surprise removed
To: Linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200921_143902_160078_59CDC6AD 
X-CRM114-Status: UNSURE (   4.98  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I have an issue with powering down a nvme host controller while fio is active.
Hoping someone from this list can provide some input so that the
problem can be resolved or worked around.


System info:

description: Motherboard
       product: X570 Phantom Gaming X
       vendor: ASRock

*-cpu
          description: CPU
          product: AMD Ryzen 5 3600 6-Core Processor

Fio with 50-50% rdwr traffic is active and when the power to the
device is removed by an external means.

A few commands are active in a submission queue.

I/Os time out.

The nvme_timeout routine is called. First register access is CSTS.
Sometimes the read to the register returns 0xffffffff.... sometimes
causes the processor to restart. When this returns  0xffffffff the
next processor restarts trying to access the PCIe config register
PCI_STATUS.

The root port had big CTO value, I changed to 0, still it did not help.

DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-

To:

DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-

This change does not help  processor restart in nvme_timeout()  routine.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
