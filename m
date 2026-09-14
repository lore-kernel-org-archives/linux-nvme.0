Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62893C88E64
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 10:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bzA4Ev9bFl4S+BlvHkgaYE+G7jqrAFXbwzypM6V761A=; b=dXnCQ/1deRRry6Noq8fuiBvWLr
	aO2ZYOLDl7Yjm9ksBQS4uKzAI/JVa78/SRkGF5Z4p23WAJhuk/T5QNUBSjR31+eyg/9Dn2CgayXE5
	jSnsb6YhAxiRVjO9tBPMoQXai6/iZPNMCfMeazCjfv7De/vcEP0xwPQIviCrAU0i2xqcJzkA5MC1p
	e8t0GXAxTB4OHDE2FhGuFza92iRXJQbQriy8d+w0An69t5L7Iqtsrqfe+7W28u5Udb1htKrSEzfwu
	3cKNcSewArJhGZDDsEnGdDWvCk37xyZRKkz5hJctf8IivKnicpFzfvwBifhk7IQaAmEYma5zx1/3q
	MtSspOjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x641X-00000003A5i-2ddI;
	Mon, 14 Sep 2026 10:34:55 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x641V-00000003A4n-0WB8
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 10:34:54 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-486fa798933so1204596f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 14 Sep 2026 03:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789382090; x=1789986890; darn=lists.infradead.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bzA4Ev9bFl4S+BlvHkgaYE+G7jqrAFXbwzypM6V761A=;
        b=LHUkKMTlziYvE5VIm+LYacMGN3EB4pzMXaPEZN0quGC8L8aTtxrWUiaiYsifOXCTsD
         WuRXyMLi20jTKQOl9LKz+aXDTxQbPsA2jLAQy+BNaQZjtCHB/ryy1P1BB+o0aLPDvNW9
         wKQpHAEkfIQ3Lq+6pztt9CYyzByqc/VSkCSSt+LLziwA+Thk49pakfLdO5A0Pd5dkdAY
         UgaJjm9Sx6TT7hNCr3cbcCeTiaP5E6+fr5EI90m7AFoxcAitmYsW2drOaLacTqO3poUW
         7ojUs9M3oVKLJHCaYvNI9snjgsVa5KuAtGDWOZtFVrzCr2RxSk3bJ/iCuFKT+w+xUSxu
         QQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789382090; x=1789986890;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bzA4Ev9bFl4S+BlvHkgaYE+G7jqrAFXbwzypM6V761A=;
        b=F+R/qKhkekmqjoNAe7eXRIDLzC6g4axdRYyLkPakVKrf3P3wxvLO9Qh1wuoiGXbiQM
         9lTdKPoVCobGkeKrr0OxEY2vOzzmdCtB0H38FVk7X4WrXFC9/dVzTxflokndBQqj00mU
         kTrIGbnvMhAOkxqtZrFdCtCGAMNNPl8Cd7uBRSFfS1b+jV5diYsviklOPQ58p6k5ly5x
         4oWKwosxZyDylazbR+a4ygYOGyJah50oQqB5t6TFKTxf9mnBPUBKWD3jhjhhs1YgFFCm
         6v3O8pQ++ykLprqEAJ0FXPGWnU+OwCFP8Gb6BZMeu6Jm+pjP8eS3EMFV+PS2Zajnya16
         RbWA==
X-Forwarded-Encrypted: i=1; AKwUvBwr/57OE0++RrlWSbNoLsaaHKuIuk32pWM2sgC/9+M/6H601232gYeZ2KkVzSLwep2Obk7PmeVzHU4l@lists.infradead.org
X-Gm-Message-State: AFuF++mNyMsVdhTbvD45Bh++QoPvskNyfEJxkLnz5GTv55+gUdqiu/aG
	z/N5mj6MVP2sMT8VCF/zcbqnAcV/ZeK8wfDDg5b1ZE575S+Uxo4M0lEqpcZ9IMGPJAxu7Q==
X-Gm-Gg: AYBFou23+JAR2EvKK5/zr7bieUECJcq3sGI7aYUWo8Ku9LUvZXqVLqqFVUuJubm0bKT
	pyq4emey2ap3eoeSA7hl3vED9Jf51VKgyIggo0JRc3j4nKI+Zu9ghynsfs9eurgVmuAO8P9KeHf
	1E+PeZU7Jfcg628qVy+pqxOzyK3oB3R6qqAqrrjQyZy4FqKW7hZDH/5X11iuG2QXVHjLQz85f/G
	xZjAYzxFQOwyNmdioVsND1A9VuQjPBKfvmvsYj9Wqub1MEmk19lwVwat/0EuI1k8e2sffZfWbad
	nB4uBAQj2sBLBRpQySnUrZrKKbw1klOkSvj5dcSqSNhPngOioXwnQAj04VdSRqq4U5H0cnMw3Tt
	EqHMm3lVORlGwFm2tHNHqjZ5ooBwxs+xVwU26eub+AtOT4lCrrNoINtkFRjB3H29bQ4Ada9Ph69
	WQCuWA/GLkUl7I4LfXm04q7MCh0t+2c4GS9cfiEImwdakvGG41oeNPra+0lvEjiwQRAm8=
X-Received: by 2002:a5d:6f16:0:b0:487:37f:9ea7 with SMTP id ffacd0b85a97d-487037fa075mr1474421f8f.32.1789382090414;
        Mon, 14 Sep 2026 03:34:50 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ed106sm25223409f8f.1.2026.09.14.03.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 03:34:49 -0700 (PDT)
Date: Mon, 14 Sep 2026 13:34:46 +0300
From: Dan Carpenter <error27@gmail.com>
To: Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: [bug report] nvme-apple: Destroy the admin queue on removal
Message-ID: <aqfNxqqlIRbClbOk@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_033453_168043_36CB2F53 
X-CRM114-Status: UNSURE (   6.93  )
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

Hello Sven Peter,

Commit 87d5b9864c81 ("nvme-apple: Destroy the admin queue on
removal") from Aug 6, 2026, leads to the following Smatch complaint:

    drivers/nvme/host/apple.c:1642 apple_nvme_remove()
    warn: variable dereferenced before check 'anv->ctrl.admin_q' (see line 1641)

drivers/nvme/host/apple.c
  1640		nvme_remove_namespaces(&anv->ctrl);
  1641		apple_nvme_disable(anv, true);
                                   ^^^
This dereferences anv->ctrl.admin_q

  1642		if (anv->ctrl.admin_q && !blk_queue_dying(anv->ctrl.admin_q)) {
                    ^^^^^^^^^^^^^^^^^
So this NULL check is pointless and can be removed.

  1643			/*
  1644			 * If the controller was reset during removal, it's possible

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

