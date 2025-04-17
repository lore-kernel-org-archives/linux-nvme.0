Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070C0C369B2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 07:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qgYgljJxI+hCrOOLR7b719OU8bcmPXVZJzM2YizyFss=; b=QPb3jQJMwpiI+5Q/A3zoi05jQi
	qccGSz4GZTXZiB4qjt3tiWZAbXmgUtLzXpVYZL1tiTczHV5d0rmkhYpXHrk27aWfBfHrclX3eefiw
	PdYjoSaJVqqvPiz+MI3m5g0TWyHtmdnKeJPN4B+UVLLDWthOG32bkD+NNHgUrtC1uMEyKX7PuLbLe
	iv07OLgZTdI8chLNr8wcOFGTOf/DS3cp3udUpDlF3uq3wtBes6DSgPSJZ2O67CNUPe45jtD2f6DiM
	xGy0N2tZUsmKYfKeypVRX1C1GeNcXng3y6rANNfUbEoAJjI7M5wuuH0A6+AQzvoUgVZ7S1C4ox6qI
	Lfe9HveQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5JOx-0000000C2Sa-2Gpy;
	Thu, 17 Apr 2025 07:11:11 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5JOS-0000000C2N5-2zyf
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 07:10:42 +0000
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-7396f13b750so438251b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 17 Apr 2025 00:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744873840; x=1745478640; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qgYgljJxI+hCrOOLR7b719OU8bcmPXVZJzM2YizyFss=;
        b=evo6Peasj6zamp4XYQXxDtxPJ4cgxCkjFaDGDvkA+No+ai56fZqmxAf8SC2axDQ8+Z
         i2Iu9lIZZcL1deRW1NyGXr8EfOz33wBHPiSJsH2BcbYhZgSA1m3oJb8tqnw2RL33zYt8
         xo5Dq8Np6QF0phKj1QNDlriuXYQMpV1q8QjtSjspuwnt6mmAFZNx7yOF+0mt+SQRda3f
         JsdBkUNpa8GtgDLQJ9Nin7yfgm0OfvrjXHCBC1IgMMo2oH47ZTfCgt0+HhWBWhNn/iNH
         8BDI/Rl2RdW54UvpcwOHd/D3nssy6CD7WKgfMiq5K3RfRakuQ0Vc/2mWGZq0DjyXOURd
         OVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744873840; x=1745478640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgYgljJxI+hCrOOLR7b719OU8bcmPXVZJzM2YizyFss=;
        b=vyYZaP9mvD1R8tj/p8OfgLRYChzMlJ56uXpF4ICYdcDSBuK/Jp7kQfb+R3Q2kYMsPQ
         t7fkEHIzPX4yXbd2BVangvvKzNQc/M0wkgsvuJo+vryDLd9fqXucxM90RRUWVM5zQc9L
         alBSsaOw1xD2a2M/DpkmHYO/q+oilceZ18hn14QPPLf6/5hw4lhbBfqRaLbZVm6bXFaO
         l25oonZot0u0qpxbj3JcDhKJwkRg4vNwWqHrxS06zviN+a6tCzSh/Qr4qZXKjshI7MjX
         afQAMJyPUw9FQZDI9IW3nNCagHtf5BgyD/t3eJuCe2bOW7S9E482E/BKhGdRInE+ZD4B
         itAA==
X-Forwarded-Encrypted: i=1; AJvYcCWjyX6gJFHPl8f9hw14Ly9n9HNGpmeK7qyW3UBDQtJ3iug9i4wKay31Drlx/R4wdHX70hFRtXwGaGrR@lists.infradead.org
X-Gm-Message-State: AOJu0YzyoMW+4JYN93+Vn4ycSzDHGMY7gefM3Gx1aDXX8PXB1JTfiFo/
	7DoSI2iMEehEJbRIF37x2wBNIPxhnHhGcvl/NKmqdYcsHMCTgPdfAKt8Ovfgf7k=
X-Gm-Gg: ASbGncsrhMg8C5UzijU/isF1GqWpJ833Q9dKMw3Cgt0Z0i70SFxmu6FTkyEfxUSgXO1
	+PsIpg53fzidqm9AfemTH/DjEbyrExYJwh1+FI7+fwe4zGrfu/109os3l9czgxuphle6/cddIkt
	J3tv/WVfcGFeUI86H5CeRB3VdjSGgUCfW+JSIbY6tYoJ7pH4i6bJwLwFi30BOdlDPgqw+y9eIpT
	xKI0wDuj62Fv4f1XWLIhBIvhd2j1Am/WOMQAyj/9ZofWhC3EQl7eYOYbFXCD7poodx+yB6xunPj
	T8jpkeXdpx7oP80lXYs1uJXf6hDeZ0SSY+8gPSriQdEpsGAH
X-Google-Smtp-Source: AGHT+IEVe/K3jTKEPBOICq/hXsLGkcQRGNxPHABsmFWTO+uu7X2IPJ3WbFKcUwQCvyFzgLk2C/HPZw==
X-Received: by 2002:a05:6a00:328a:b0:736:5822:74b4 with SMTP id d2e1a72fcca58-73c267fba0fmr7220974b3a.21.1744873839691;
        Thu, 17 Apr 2025 00:10:39 -0700 (PDT)
Received: from purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b22217f7bsm2338045a12.65.2025.04.17.00.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:10:39 -0700 (PDT)
Date: Thu, 17 Apr 2025 01:10:36 -0600
From: Michael Liang <mliang@purestorage.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Michael Liang <mliang@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] nvme-tcp: wait socket wmem to drain in queue stop
Message-ID: <20250417071036.a7nhovuokg7w2n5r@purestorage.com>
References: <20250405054848.3773471-1-mliang@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405054848.3773471-1-mliang@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_001040_795472_EBF09667 
X-CRM114-Status: GOOD (  10.00  )
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

Changes in v2:
 - Always wait in tcp queue stop regardless of the queue liveness, which
   fixes the concurrent queue stop from I/O timeout from multiple namespaces
   of the same controller.
 - Link to v1: https://lore.kernel.org/linux-nvme/20250405054848.3773471-1-mliang@purestorage.com/

Michael Liang (1):
  nvme-tcp: wait socket wmem to drain in queue stop

 drivers/nvme/host/tcp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.34.1


