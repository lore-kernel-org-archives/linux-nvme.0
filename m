Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C22C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 13:50:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2912065D
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 13:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z71Wgrne";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zihd5bMM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J7GSAWZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2912065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wTqkSXDUidOKQoCoUwClTZtRKeDzpfuJh4DLfW4m+CU=; b=z71WgrneACBW/ogs+E7UPR2cVR
	H/2gyZRBiSxZHxz1emAl14rktwBVPmxotZtH2IsGhrOADxWTERCLXF1Vt1rDanpwULH4mOK7qlFsw
	dJC0tkuXu2a5zQIS3KyPtfBq0PkVkUibYi1AAxhL3NU5v3evSIFHZ3raJVYw5y5Q0MQ3ElSMQwBfU
	OG/JJhwyS0e70lVwG+JebnAW2VaQITZWZRA7thXamGdOrWiiTC7PFbdGjiTYYYDXLq8oo9FzytgMx
	w7cIX6dVDqvzRVR5Vf6Dv0Y226rzlyl5NSDlRhkGjAv6Yg6Y4eEubrM253l+/dZE5owe2yGe9SVXM
	efLg3O2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7fWj-00012h-3x; Mon, 17 Aug 2020 13:50:17 +0000
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7fWg-00011b-VQ
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 13:50:15 +0000
Date: Mon, 17 Aug 2020 15:50:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1597672210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=wZ6DLhs3/Nle2hWXNU/DY83Ezlnj/RloUcwPjKzeXfI=;
 b=Zihd5bMMlDli86Taj4JtvwpYpUqC7EB6v73VVfmCMWtCf3kotBdF/bAROQfLV0uzZp/W2D
 9OyxQ2HH3aAF1w584CRcligr7oDKrBME3pLt5tslArwX5Rkg0R7b+oUXTnpOUoVoLAAfM+
 Ii3OlPrxjTDZblfcNDHl+UQDVCoVC2R/8c95co5qZj3xvsGQ+K+PA94sQadXQbZWhM6vdM
 AqJHvU1CQ17k+rp83/olZR4VVJ5w/ep4IdhOqB9yWd2bb8u9SC6xpfiA4+FBLS92hCixUd
 YISQ+3bR0vXKyvYeZWUc5H2IlXnnsGzeQizcRRploB8o1ucvtwa6suLiGb5HvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1597672210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=wZ6DLhs3/Nle2hWXNU/DY83Ezlnj/RloUcwPjKzeXfI=;
 b=J7GSAWZo8tw2hAmp1FL/4OEBW3f0peMwb4DvtSd0zsKCiDLEy/QXi/hws+Cl03z2LybWu1
 OJ8AVBIra937b/Cw==
From: "Ahmed S. Darwish" <a.darwish@linutronix.de>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: v5.9-rc1 commit reliably breaks pci nvme detection
Message-ID: <20200817135011.GA2072@lx-t490>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_095015_192928_B579838F 
X-CRM114-Status: UNSURE (   6.87  )
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
Cc: linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

Below v5.9-rc1 commit reliably breaks my boot on a Thinkpad e480
laptop. PCI nvme detection fails, and the kernel becomes not able
anymore to find the rootfs / parse "root=".

Bisecting v5.8=>v5.9-rc1 blames that commit. Reverting it *reliably*
fixes the problem and makes me able to boot v5.9-rc1.

Please advise.

commit 61f3b89630973037f67d8e25e5d26e80a51a7b37
Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Wed Jun 17 10:05:13 2020 +0200

    nvme-pci: use unsigned for io queue depth
    
    The NVMe PCIe declares module parameter io_queue_depth as int. Change
    this to u16 as queue depth can never be negative. Now to reflect this
    update module parameter getter function from param_get_int() ->
    param_get_uint() and respective setter function with type of n changed
    from int to u16 with param_set_int() to param_set_ushort(). Finally
    update struct nvme_dev q_depth member to u16 and use u16 in min_t()
    when calculating dev->q_depth in the nvme_pci_enable() (since q_depth is
    now u16) and use unsigned int instead of int when calculating
    dev->tagset.queue_depth as target variable tagset->queue_depth is of type
    unsigned int in nvme_dev_add().

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
