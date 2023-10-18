Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5942CDB483
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mX735E4T9/gdZwjC3yEtPDHRkLbK38DCqrcQzMrfDBs=; b=C1IkJthUiCA9XiS1uo+ey1RKhl
	rV4JTl3MWHLSLCkJ3ZgUmuxdmk12UcPNBRZMXsCIe0aDXSy16MYAPXDgdkc2UIWSsjOFW3gyVsxMU
	xyPRz1o5GXj8p9QOmn/foxJxIHCgBB1hkbXGxciH3Ut63BNLpugl157uF67vVAYYPa0CwljoVYlOA
	UIGvylGZzVtEyMXIgH8r0tPG9o0XQpyUZUDuyWeNQ8+gpjVyD63iR2VLkE9y85AF+4gdVHJ/3Wj/j
	868GUZfzDNt8+vm/HMb/sCFFHvDmDFzYL/1fhpMiqDEqzALcs3lwdZrIsYjtBctDPUzu7OCHjIl8g
	rKqtQ6mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtCiN-00FaqT-0o;
	Wed, 18 Oct 2023 20:00:23 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtCiI-00Fapr-2K
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 20:00:20 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4083740f92dso14118015e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 13:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697659213; x=1698264013; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mX735E4T9/gdZwjC3yEtPDHRkLbK38DCqrcQzMrfDBs=;
        b=mMeYpJ6IFxDHT4XgeyZsnkOoXuJbdh4OA/HQajhvaKnPPi7Jbhbu1PNxIB3SKOj3Co
         84mQaxaQqeNhRbAI5409PN6w86RUfD01/nh9qQTR7Meq1bjUheX+vf6uyG4g+tlMhdDn
         +hajsNIYtwaX86Mr2lwZ1qLaVcW+wCvuF7Y2nY3crXq9X7k3C8EnuykZncx3PVw+avl/
         S4pKnRqvsMV+UT9+0Axyi/birrqXDjkYdQcIqLhqex7OtqUcQm/MFQ/KSmhhceZXLgeP
         fpGKIGEaxoF4aaMWNZiPKJgg3vM9JZkMnZWY3bzHcYtvYOcmhuh0Xq1HfbecuXTaVRhU
         z47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697659213; x=1698264013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mX735E4T9/gdZwjC3yEtPDHRkLbK38DCqrcQzMrfDBs=;
        b=VcMjnq/xMQyOL7Dn5fiHPCSqXGtV9KF1Bz/h3Ah52WvYzS6B+eae6f3OK/5fLzSqG3
         +/v658p4fHo+cgB29kiYwphmYrR9llkrgxZQaTa1NRnoQwvcDwWWAErb/E0lonB4EU/1
         VGvrmx6NB+ul+3MaBIrQmApbgpISAfKUlQ3uD4Oo/5ifHJrbCExbH52CdiaD3Lh5RqJ1
         q2UcjphgIREXSnlRqF6TAQoEWBTiGpXE0Ct3n57OqbdEZ4mvMgjUnDMuEn5cXEl+snAI
         enFIdK384ljOQWw50g1xfuS9PpVbmYVWISfYkUnRg4bieMGg48xqSEj5tMFf34QnpEgQ
         POKg==
X-Gm-Message-State: AOJu0YxG2rrHKdV/5ulYF90qrskD5DbhhZayaayuK1hPP0abDB/5qgCO
	PmDmSnCEbaYAEYh/vgo0yRZEopfG1QqdFmX0iNkUm0PvrWo=
X-Google-Smtp-Source: AGHT+IF6+JBh9nlpfzltexnOdBIxay0cz9aVe4uA8gxT4vMEnw2mtTAlUtqB03MjlB0ka08zcvN/LRy2uv1lJ1Hfjks=
X-Received: by 2002:a05:600c:3b8e:b0:408:3c8a:65ec with SMTP id
 n14-20020a05600c3b8e00b004083c8a65ecmr295571wms.8.1697659212955; Wed, 18 Oct
 2023 13:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231018183620epcas5p26ab74bdd1f2739ef3ec1ee2431329dc4@epcas5p2.samsung.com>
 <20231018183003.41174-1-joshi.k@samsung.com> <2f6cdecc-d51b-4cbf-a0dd-ccd22fac8a98@kernel.dk>
 <ZTAzaJ_4zrFF3Tag@kbusch-mbp>
In-Reply-To: <ZTAzaJ_4zrFF3Tag@kbusch-mbp>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 19 Oct 2023 01:29:46 +0530
Message-ID: <CA+1E3rLF7ZRoo8hPPPLp19FvT7ae-3aDfBy_+hjgNGT9pRnk1Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Unprivileged sgl-only passthrough
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_130018_761240_96B01390 
X-CRM114-Status: GOOD (  10.48  )
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

On Thu, Oct 19, 2023 at 1:05=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
> SGL for metadata is definitely slower, but it's the only nvme protocol
> way to directly specify how much memory is actually available for the
> command's transfer. PRP/MPTR vs SGL is like strcpy() vs strncpy().
>
> Similiar to Kanchan's earlier experience though, I haven't found real
> nvme devices that support the SGL mode for metadata. The scenarios this
> enables might be pretty limited. :(

And if not this, what should be the solution to have non-root
passthrough? This is the third one (excluding iommu) that we are
discussing.

