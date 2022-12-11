Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2236FC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Dec 2022 09:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rh5QAklyd4AeYLHpArFINipp6iRCr8KKOQb7s6HGEMI=; b=oPscczCg7gYTpm++MCjHTFwXQI
	CmI21pe/IBU9ZeaoImdtkEDBgonQsHDSEkSJbNiRIiOtFuhAegDUfnZV3wadEfS4OICe/ZgzUgyx9
	JG69CVFdTXvckbxcQbyQ1/qwxYklQMq6vRcplI2o83D8Dc28W+Zw25QRtDMWdrkEN7vT/Fy4w3q7F
	Z8mVN/oQ+XBRi1HjxK/oQCO2RtGXBz8leDopjIUzvw028dgwqqFngJCADqahnC/Xe3wrW/kEjT97o
	+BaLi4hCYC90Z12rWl0F477orJ7HTI2rcVry7iQVvmEMgw77B4gyWdramPjiKdASUlOGqVt2lVBYM
	GJLUh+yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4Iyd-00Fixg-HJ; Sun, 11 Dec 2022 09:50:31 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4IyV-00Fioa-56
	for linux-nvme@lists.infradead.org; Sun, 11 Dec 2022 09:50:26 +0000
Received: by mail-pg1-x52d.google.com with SMTP id h33so6314162pgm.9
        for <linux-nvme@lists.infradead.org>; Sun, 11 Dec 2022 01:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rh5QAklyd4AeYLHpArFINipp6iRCr8KKOQb7s6HGEMI=;
        b=PwZx72Aog3dMWak7X5RfDIKA0Stm9ImI03XPRB3S+OK2Lm094+5ABxaYH5mTN8ITc5
         0rkuCCeyg+P343biweU0dezATwKnk2bf1Z+2szM1asbufJO42JA5QLrD/7aW9moqEqh1
         J8psuIuFAqWpMvxZIs79Q5sQiBBP/MLRsufX+9mzb/85TVQSqLZs1m4jJbBw41PYdH63
         2sAISKQPJzZZyY6Vv26dVFhpDeoTf+OEEynL63DSXBk5gW0MhoguPc2C5t+d4r807v6d
         IZ8NDA6N6jz3XX613ndUDLeixIu12Z39o4LwE/lGUddlhukJ+k/leJpkPDBVdVgyvLVN
         LTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rh5QAklyd4AeYLHpArFINipp6iRCr8KKOQb7s6HGEMI=;
        b=GIbqenZTSiaJ6k0jLiN8R4ivBU8hzuw3m6BHQDUv9qLl066n+3bXtd701eFscOaqxA
         8EBrDMTYydBvBnZwO3o0Z+culeHFgzbkiA+Or6AQfOEdNHql+bnMcl13Y/FV5ioHRzcQ
         D/yCSIhpDJvDOepYBSkQKjf3pw8vP2OTFluHUkmVi9AHtpqLnPuSYeVbXj8L0lg5/Vzb
         G82E7v5xQaya26qcIaMtdaC+rT0uFjHoX/Qibb/pIZgmQ/DrrtebNEQDYdsetsq0q2t4
         /FPB5g21NMymI4X3Tq6IwY/Y3Fy53sgSh4FxZIJ0u8Uul00kM2fba16QfuKRg+Q4pC61
         kjwQ==
X-Gm-Message-State: ANoB5plYZ+FmKbE7XSLrJKVZCSho4JOC+VC/p3utfCAORjbpuPY3L0lC
	uBkvByzKvawyHdA6Df1TIVtQJkWJBJn+PpXgcCmwLQ==
X-Google-Smtp-Source: AA0mqf6sTgZzExROP+3AcD990q4QofPnx+7w4Ve/p3V7twkuqcE/V+srS9ihCucVMYKxVIFQ4amS8gQqv9Gu8amMX4A=
X-Received: by 2002:a63:2226:0:b0:478:54e2:ecb1 with SMTP id
 i38-20020a632226000000b0047854e2ecb1mr37001807pgi.550.1670752221276; Sun, 11
 Dec 2022 01:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <Y5BCQ/9/uhXdu35W@infradead.org> <20221207052001-mutt-send-email-mst@kernel.org>
 <Y5C/4H7Ettg/DcRz@infradead.org> <20221207152116-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221207152116-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sun, 11 Dec 2022 11:49:44 +0200
Message-ID: <CAJs=3_Bu+tZqQk3JDzP0JfNbPZ8FG7mRNnPE9RrWUs8VOF=FzQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, virtualization@lists.linux-foundation.org, 
	linux-block@vger.kernel.org, dm-devel@redhat.com, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221211_015023_895059_FC00ADBB 
X-CRM114-Status: UNSURE (   7.14  )
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

> Alvaro could you pls explain the use-case? Christoph has doubts that
> it's useful. Do you have a device implementing this?

Our HW exposes virtio devices, virtio block included.
The block device backend can be a eMMC/uSD card.

The HW can report health values (power, temp, current, voltage) and I
thought that it would be nice to be able to report lifetime values as
well.

