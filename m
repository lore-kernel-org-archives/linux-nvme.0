Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06595C001DB
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 12:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:
	Subject:Message-ID:Date:From:MIME-Version:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zT3Azyi6LYo5ClSLK/Evv1/rHGcD9ctsIke87Cm9Ac8=; b=begrZHgj3JeEp7o4RFK8jMj358
	QyJc8iomE0MstPykBxNP2Bfvi+ctlmD8YunuGSWzZFgg4cfZesxGQklnRZWUvtQ02bdeBy72R4Dbq
	nvbm6Vg9T705i/0tAiWmUZDa8M5tefqaBIWdL538EpzJ+vkYmZSlQwfA9pFFx4riZjV4JqdfKRAw+
	hch4PeA/MCUvboRPs205q0ixsuGWoGessqsFtMOSp2eRI7Zuy7Wgj2MHe4Vl/bYl5sDoaGNWk62hv
	JbCwnQiwHGCFvPcGr1PvnSAkU2YNjutEbkjg3/iScSBfnO2DKUyNdgpIm/X/9Uy2zz7L5uvISGciK
	caZvV2FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU4tR-007cki-2w;
	Thu, 10 Aug 2023 12:35:57 +0000
Received: from mail-lf1-f42.google.com ([209.85.167.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU4tM-007cjl-2X
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 12:35:55 +0000
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe655796faso1292154e87.2
        for <linux-nvme@lists.infradead.org>; Thu, 10 Aug 2023 05:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691670950; x=1692275750;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zT3Azyi6LYo5ClSLK/Evv1/rHGcD9ctsIke87Cm9Ac8=;
        b=KSBLFX8miM0FlZ1dCy4SDicwm+bJ7+tmQSq5cGAHY+Zc69SRQqsVbDemkt6pkgXEni
         aIdRL05z0xEhaejBkArvva4mBKeWS0oeYSuGpSjQkoSXm8hsVn9z6SE7/IXr4q+kifio
         m828/Vy6zZk1awcJflrLVFd6ilu9I5JFslb6ykmbD0RwNZUtyt7kzq4EhBS5pmn9aOOV
         DxlvzpafQ8jwaZQVPlpU2RQKVGrqbHEXif+Uvm8LdJ9jCi/uFDO+1lJYcNz98h1Em9sX
         DIH8sosJXuKCMYqN+TZUOnHHMMl2LZ2pZhnyU8zepx5ApY0TlxLSFgCSFmHbPAV5Ndw7
         M2kA==
X-Gm-Message-State: AOJu0YxXFItExDgMXb7u4DdPhYE2A1e6M0hR7VUD3XKfYZvgls6AHmF8
	NnPjnqErdrb7ghjPESO5tNOHyjraT0/QmaIhRHv/Jbxap/c=
X-Google-Smtp-Source: AGHT+IEo2fxwxNCNy3VXwG6VRDrvGDdv5poIsCtkevc6Dny2KW8ViobcIeqJuFh4nQ7NdtWhwbr9j6wFEHTrEJqJC4s=
X-Received: by 2002:a05:6512:556:b0:4fe:3724:fdb1 with SMTP id
 h22-20020a056512055600b004fe3724fdb1mr1714645lfl.41.1691670949719; Thu, 10
 Aug 2023 05:35:49 -0700 (PDT)
MIME-Version: 1.0
From: David Sariel <davidsa@openu.ac.il>
Date: Thu, 10 Aug 2023 15:35:38 +0300
Message-ID: <CAKhp91GOYQURee7gvecynpskPi1=JbJFe5C8zMi812n6NnhQZA@mail.gmail.com>
Subject: Key Value Command Set Specification
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_053552_844018_B6EF5D89 
X-CRM114-Status: UNSURE (   5.23  )
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
Reply-To: davidsa@openu.ac.il
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,
Is there any active development underway for the implementation of the
Key Value Command Set Specification within the kernel driver and/or
QEMU?
Thanks,
David

