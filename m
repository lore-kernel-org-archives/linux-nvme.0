Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90A6C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 02:37:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FF360FE7
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 02:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FF360FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z50azbTuRQFYq7ZZtK9NFyAdcfLaMDkE4fT4K+EwKOE=; b=AtZORNdrOvkujVjPrQgI4xmy8j
	g+Wq8HVGMVH/inrNk7A5Tnw0oZtMOoD/lYxoHU4nTa0UHUU+O1ijQC5E92YYzPJBfFNR5VFvkZcwI
	/WHA31jOCyLuOER5CO+05+U4Nst2xIJ9v4GJyvyZ4baaMAHBjdPrOUe+f1MUNuXMtpjSRfpsfLQTk
	rNapVqc3FzeiTbd9XGOb/FrLFqUCBaj/0BeP4DvPw2s2qaNe7rpVfXQ+h34rYCi031Z1X+aNlrgI5
	vzNpvXu1+792j5O+lKiZYCWBR9snr0GK558NsrMRRsOpO/V6WgCeiksDgaPoULyyZbVFcPLlcMUDd
	sGi93GXA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljv1c-003X7F-TC; Fri, 21 May 2021 02:36:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljv1Y-003X75-Bw
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 02:36:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=EXEBguwPDenWLsU2sUOy5CU8LJxWbWUCaf1AqvfJRHY=; b=O6H1bwp+5i6umIeuM2iWoDQ+s5
 K3cJpeBV0SPw7qlyHdFT6LNwuDBrQ4Zj0w+KrKAll6Oh1uR+QetNpniY3Ozi5mxbc5ESfSqPllBfv
 RQCAzWW5z7hH2BO99rVIpY+78OqAGHnxIeAYnDUZAEnSfyWtWgIv0WMIysUa5tfFVz/602pnS8PKU
 IFFcUIdT37f7xO2o9jNzRJDksGqmWTf4Dy3LXb3hzLhA+aLvGGSUFafI/cGEb/EqkAGEWLZ+IBb5i
 muHW11EMuWquLinnyUBmWb/i96eyq8ZUpBPeP+SXS6aiUZrrwQhlSihO4CpoKOwYfLJZQIpC9ZEmj
 zhjD0EAA==;
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljv1V-00GmEM-LV
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 02:36:26 +0000
Received: by mail-il1-x12f.google.com with SMTP id o10so16015589ilm.13
 for <linux-nvme@lists.infradead.org>; Thu, 20 May 2021 19:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EXEBguwPDenWLsU2sUOy5CU8LJxWbWUCaf1AqvfJRHY=;
 b=cvaYCad/SWpBeb82zYa7NuM6fykNFbgIFbA5Jnzmsgo1cC7cs9pRK6X874DJ13GWKK
 nlq/nnIG2RoPIyzwenjl16VZpfGc4HJ3uQA0uUTmrbKmnfkQCIt5t4gY1h2Y9mhb8+JM
 jR5bLWVmcipOTtxwIQPOxkH2IF8rTXqJLHcYQCQhZsYg5qgWRNIgbSFyf4W1WNbw2Mec
 Vr5bApbxSdM8NnoS195Ylu/NHzxY07J5Cbu1q2lZqqVPpw0NQImmk0xJHyZsYSN98H30
 e54ahlc58JJf+tJauCtjOrfr7RAnX+y6s8tka0y9++URVXL3/fsCUAlMcU84l4jKowDb
 QbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EXEBguwPDenWLsU2sUOy5CU8LJxWbWUCaf1AqvfJRHY=;
 b=gPA+8iDHpd9GdsZS+gVzRFm6Y0DZm9ooARfek8imNzQ+ovZLC+zLblzjXKEmQRioaJ
 /36sb5qqpsQHYZZm7bsYIapY4RPRjtaf5XO4oDbvnziXMDGx5TsVwglqvKBe3PmWK8MC
 NAxBEWw5menH51LL4/yrsgLyKnDA45SA6jt0AzBQTuBRveH29QkacDH+Qhtx8g0HSw1p
 7cVt6IEBlyuj68F3UHhliR1JzuHVElZqQR1XRntd9dLLWEsV4qnr6KG50w9erfdyTJKi
 ZiBoFIjs76SNbVXr/yOCbP4DRfVDxiygJpJmiinBtnkknI4XnDSt3mDaOE1/BQ+wiC6j
 9gaA==
X-Gm-Message-State: AOAM531yanxGgmWCUf55heg55CR6EJ1iwSvYZ0GYiFCNTd76cdo8MRZo
 whN+komsFRLQZCknD/WyfJWV3H9VN//9lk8bkOI=
X-Google-Smtp-Source: ABdhPJx6T1X77xNC5SSuBbGJOkB2lCk/1Q2h8ifuIYTgNkgfmoR0xq0+e5yKeteCfegDVFaDl59MIL3guiPgzgvL1e8=
X-Received: by 2002:a05:6e02:1348:: with SMTP id
 k8mr8484822ilr.104.1621564584486; 
 Thu, 20 May 2021 19:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210520113046.27821-1-houpu.main@gmail.com>
 <20210520113046.27821-2-houpu.main@gmail.com>
 <89265081-d16a-27fc-bf70-a39e3609859d@grimberg.me>
In-Reply-To: <89265081-d16a-27fc-bf70-a39e3609859d@grimberg.me>
From: Hou Pu <houpu.main@gmail.com>
Date: Fri, 21 May 2021 10:36:13 +0800
Message-ID: <CAKHcvQgz5By1Pggb8-mVz2o6Mz5th2s77ogAQGy-ervEBTJHMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvmet-tcp: fix inline data size comparison in
 nvmet_tcp_queue_response
To: Sagi Grimberg <sagi@grimberg.me>
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, 
 larrystevenwise@gmail.com, maxg@mellanox.com, 
 "Grupi, Elad" <elad.grupi@dell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_193625_734518_949C7D9D 
X-CRM114-Status: UNSURE (   7.90  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 21, 2021 at 6:39 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Thanks,
Hou

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
