Return-Path: <SRS0=jUlT=MD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0DFC07E96
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Jul 2021 13:18:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66E1611CD
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Jul 2021 13:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66E1611CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u/pOE8p4RGLdjkOVYjEhLD4S1SuR94UaqccsX9WEYPY=; b=sW3zP3W0gVmKhT
	XKOaOzWlPA1iENkAg0b/ry86kdtDcUWjsAqBCVLBZ/s3M0PXmeivWp9XD5t/v1jTJ3TzHsiaQrU7D
	opNuu0o/L9yQfMBqvksJdOd1YGevW+A0b25M0cep1BnX9dYSMJy6t8Uu8jmiJLkhH8PDBr5bb2pQ2
	pqzlUCECoMKoaPxR9fxQEnXwW/R8QwoOcvLAZobQISh4bikTlDKOi8yKhhmvRPIgftBWSV2rZeGTS
	ovwXHA2PgO7tQAWOrPshYvSQ/QiuzNS1e8s3IbeGoG8bvk1jx3Wq0WpiBBZ5F7MOYh5kMpkTiMYmx
	frXbfvm5i2c0G1wQTEGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m2ZLm-0055bU-9q; Sun, 11 Jul 2021 13:18:26 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m2ZLb-0055bA-N5
 for linux-nvme@lists.infradead.org; Sun, 11 Jul 2021 13:18:17 +0000
Received: by mail-wr1-x434.google.com with SMTP id l7so19619088wrv.7
 for <linux-nvme@lists.infradead.org>; Sun, 11 Jul 2021 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M5uDJQvrfs2FeYSdl6uUYb8D/cvxHGUF/KDdl4rbaLQ=;
 b=jMozGSE+aeeuyjHt7Y7KphMBdYEAGw1FP67ly9FJCI0a1p8WnXLcLy/K8wzHE5Yglc
 1bhSapqPJgBYPK2/4p87K4EqScMiZ8deeaAleA7i633MxkuJ/viTygzEaqu1FP1JoQyD
 6EfgtuiOZKDzeG8R0tmRZ0Y9oh7uSRV+7BdGJ1RoF/Z/ajHbmtyOUyLvPU5hSKmlbl9q
 QRzpvTCro4g8erNIE4Tqm1eAfggS/PSDWQzf0n1BwTzWIV08NT4Qpc6qaz0H+3vILUJz
 eq4t2+cAk7cNR6C8peT3T28DMKHV1pScxfftdz8HT8a80ryDqTQKbdmjnJrGuOvik3Ws
 S2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M5uDJQvrfs2FeYSdl6uUYb8D/cvxHGUF/KDdl4rbaLQ=;
 b=HaUYtDyqhXNolb54ph6tk0oRNNT4FCe7PSUdBChspKbZW8grckf8YKC50xjFm+y0VC
 3P2NAU5SGQTiRfH1R5hTh9cxri65rm6KAim94PgoWBQuLIbaTdimSt61yRisYLK7jQID
 ciI4IisbH7sLIWQjxUYFA6xmNpOqiDt8U7HhHehmongxXIxSf/gDujAv9VASIMn0GPk9
 vRParxXrRGcBgiks/vkrGVqreRTXPs1t8YQIJ5Q9s/W9/Kypbras5T/piVRNKFKs8ppA
 QsPC5mWPzO5FNwb1lFWAI8/HW4lUnOUU08ZvmTDkyc04/VQAaQU2Ll5yGNzZoI349ykO
 rAUg==
X-Gm-Message-State: AOAM5322y7wBcOSIwOlwbxLXZEF8azR121pOPcbnl9nP2UDroJHoGPRO
 OJvKowIjJHAcZjPb5zj1z0VYib9yaNnsvyI1nRj40HlwzMp0vQ==
X-Google-Smtp-Source: ABdhPJzjQT+Zqi9IAVTCp/FHC6I6Z1Y9XLGEKiLnr5nzP299S9xM4YdDZdAQnufS4Ezf10j/wh5GIDLTJuln6lLFFVA=
X-Received: by 2002:a05:6000:1212:: with SMTP id
 e18mr8007761wrx.255.1626009493269; 
 Sun, 11 Jul 2021 06:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210618133956.10637-1-pkushwaha@marvell.com>
 <20210624063551.GB26612@lst.de>
In-Reply-To: <20210624063551.GB26612@lst.de>
From: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date: Sun, 11 Jul 2021 18:47:37 +0530
Message-ID: <CAJ2QiJJ8cUL2fOfuYeLqa=LOvCBRgZ3wJ=-t4t7CL-xOpS2dtw@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: Use __dev_get_by_name instead dev_get_by_name
 for OPT_HOST_IFACE
To: Christoph Hellwig <hch@lst.de>
Cc: Prabhakar Kushwaha <pkushwaha@marvell.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, axboe@fb.com, 
 martin.belanger@dell.com, aelior@marvell.com, 
 Omkar Kulkarni <okulkarni@marvell.com>, Shai Malin <smalin@marvell.com>,
 malin1024@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210711_061815_802787_532326AE 
X-CRM114-Status: GOOD (  21.49  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Christoph,

On Thu, Jun 24, 2021 at 12:05 PM Christoph Hellwig <hch@lst.de> wrote:
>
> I've applied the slightly updated version below to make it a little
> more clear what is going on:
>
> ---
> From 9de7d173c10b6be09fe9d5b7010ef182465897a1 Mon Sep 17 00:00:00 2001
> From: Prabhakar Kushwaha <pkushwaha@marvell.com>
> Date: Fri, 18 Jun 2021 16:39:56 +0300
> Subject: nvme-tcp: use __dev_get_by_name instead dev_get_by_name for
>  OPT_HOST_IFACE
>
> dev_get_by_name() finds network device by name but it also increases the
> reference count.
>
> If a nvme-tcp queue is present and the network device driver is removed
> before nvme_tcp, we will face the following continuous log:
>
>   "kernel:unregister_netdevice: waiting for <eth> to become free. Usage count = 2"
>
> And rmmod further halts. Similar case arises during reboot/shutdown
> with nvme-tcp queue present and both never completes.
>
> To fix this, use __dev_get_by_name() which finds network device by
> name without increasing any reference counter.
>
> Fixes: 3ede8f72a9a2 ("nvme-tcp: allow selecting the network interface for connections")
> Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
> Signed-off-by: Shai Malin <smalin@marvell.com>
> Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> [hch: remove the ->ndev member entirely]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

I am not finding this patch on updated "branch nvme-5.14" having the
latest commit 0755d3be2d9b("nvme-tcp: can't set sk_user_data without
write_lock").
Am I missing something?  Please note, earlier it was there with commit
ff5af4bfb6af.

Issue can still be found on the nvme-5.14 branch (top of the tree).
Are you planning to fix this problem using any other approach?

--pk

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
