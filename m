Return-Path: <SRS0=M8F8=XG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFE6C49ED6
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 17:40:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCF02081B
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 17:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OGAKlq/D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8BDKJ3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCF02081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ly+CwQiTR8j+JLyU/mbmxl51qkDgp2fz3AptpZvl59A=; b=OGAKlq/DfxuMKN
	BHiiuOiKhSe6emjCWcMEHJxgcVf6An6YiWy36sXZYVFoeDC8f0q/C9L5xfqu4P9E8qIEn16IaCNNe
	WaI0xUbrYwLr2qSEVSAHETTw3jLLdQXbuBa/2Y20Yc9SqaJnq2mGRX3SRP6UtHBEshF6qvUq4XkIf
	kdhhRnrfUTEMqGFh5FjhpeubUupMCm53bMlcMzWWkq92dkUN1J+m2gEXi4m4+oc0MZpEvg8vXFJ44
	o0wcukZ6+DCMFr7KSscSw1ihTK5WNmUjNR0BeX3gR0ZihfFZPHZBPaHE9nLjDuMn/6BjQBE8e5r1n
	ELx2J/IJC51db9j9Uagg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i86b1-0003Zy-IZ; Wed, 11 Sep 2019 17:39:59 +0000
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i86ay-0003Ze-Fc
 for linux-nvme@lists.infradead.org; Wed, 11 Sep 2019 17:39:57 +0000
Received: by mail-lj1-x236.google.com with SMTP id e17so20789507ljf.13
 for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2019 10:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iZ4bkMZvPLT1/Opm4QEPQHR0cQUQ8Cpe6sY/FCCAjMI=;
 b=Q8BDKJ3DdYjGlgXI69cvGQJzrbAPvpSd4xRgsKeI+qMffujhmvMwKSEkU5pWb2aEgK
 qmpUX/grcxYWXnZ4B58oIl8a4ChOPpsZoNYuA9R5C2JfdBxm2nWd8RtERWbCaSbrUgmo
 bVKvz5pnVAXkIDuorb82kF4NMB1gTrEREpva1GiKoQs6qBJUBW0H8X4RYUECdbOzO48v
 ZUJrAXrMAvmhoOnskAZNDzyNVC8ivxJlqmJRtkew+4sUS5Du9js0kN5GKPceiT7dHM80
 /HZxUsCAkI0F278//twmhpCYJjTcFaIgI3pxo+KW63SoDLsblQYNLGPUr0QoziDiu8jd
 goCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iZ4bkMZvPLT1/Opm4QEPQHR0cQUQ8Cpe6sY/FCCAjMI=;
 b=ZR+C9rKwAXt0Z7OurL6DPPnMv7yfJ8pwHaFYJIOBun/SK0lSgO2wgT5Ye/lkLf+6gn
 XFA57ULvz3V+ZyaYw4KpJQPUCbsIF6Bgls0+Xu8/q27G0kvXNIUmK1NVbLHSK8SiBcSV
 xWhNyLVyL0ZXQtDBoisgwsz7yLVa+y6lJtqqxauW3KxQ8FC5AZ1bKdcx5hCgJzIn2HCR
 4OhkeX8vN9SCtzTZNQik86KD72j/tirfLWAVnD80/EyA5cNQ842bntgugp9r0iA1rLWH
 0N0XGZ3vms8rLzMFiqE8RmUyjQWBQacdUGTfZCLr1wTO3IY34xqeIC0XIZNBxHuHIA/p
 oTfQ==
X-Gm-Message-State: APjAAAWOAlY4tDIcpQZbjwzMWJjDSoKlRUG3jJuPXAl0mz95yHFiyytB
 vcBOllOg+xq1HQUuaFcwjd+bRomEEiOUWfq731Z9MRk=
X-Google-Smtp-Source: APXvYqxcEcaGL0kpZ9AoRZdVstIXRl31pitmLJg80TtGS10CvByWqy2SM92NjYkIfrzUKloNxit7KLak9j503SvALSI=
X-Received: by 2002:a2e:9114:: with SMTP id m20mr23592932ljg.103.1568223594710; 
 Wed, 11 Sep 2019 10:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkgivvhQ=tOOuLjY=iwBVCKQhmmjpfNDa1yJ5SreNQubw6Q@mail.gmail.com>
 <4581016e-b421-e794-e603-807d37aa1bf3@grimberg.me>
In-Reply-To: <4581016e-b421-e794-e603-807d37aa1bf3@grimberg.me>
From: Gabriel C <nix.or.die@gmail.com>
Date: Wed, 11 Sep 2019 19:39:28 +0200
Message-ID: <CAEJqkghexeFHwaGkNUp+SmdhtU6Mf8cZ=Kn9pfrUkX3hEz-MOg@mail.gmail.com>
Subject: Re: [PATCH] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190911_103956_525160_80AB6091 
X-CRM114-Status: UNSURE (   8.46  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Am Mi., 11. Sept. 2019 um 19:21 Uhr schrieb Sagi Grimberg <sagi@grimberg.me>:
>
> This does not apply on nvme-5.4, can you please respin a patch
> that cleanly applies?

Sure , just tell me from where to pull nvme-5.4 tree.
My match was against current Linus tree.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
