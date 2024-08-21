Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE66C52D6F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Aug 2024 10:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j9wlWmDhx1n/J1zGPtYAE+h9t4heJJblAC9mVdhxh/8=; b=NvNtlq31H5P72sluoksIS7WzcB
	XbDEgIgMsbjkb400PxOdhPrDODoQVL2TQsg59fnN1ugNbMmkIxCCbfjWUon7KvaCy1C4AW6Pw3dgO
	pSC9zB4L/lLoEc+UznyYs1mATumtJ4RlvW8OJtU1tniIguAbJ0l0nJztwL/EZU3A2UaU12AalUcYR
	FhrBkw4yVDuylr2h9OSImyxnFki2Ph8S8leXsghZuuPMJ9nXw2yg7nMJhveq4HNQKhl1J68ksMrN9
	44W0tVl1nsLjckojkYKSeCpXm/rCRaK8IDMJgCoOXrR4gjF1a18F0VjqaIHTevEz5A6js6QzGMyDK
	iWqIJr0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgj1z-00000008WZR-36XG;
	Wed, 21 Aug 2024 10:57:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgj1v-00000008WXQ-00xA
	for linux-nvme@lists.infradead.org;
	Wed, 21 Aug 2024 10:57:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724237848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j9wlWmDhx1n/J1zGPtYAE+h9t4heJJblAC9mVdhxh/8=;
	b=FKEV001sCiwmdeCdbTpY/Qgiyexank1lyeZ+RW09tuOhH6U4XryQtkv8+fAy2E0dcd7hU2
	tGPiFxnJ5phoLrAixoXQraJ9uMb2H5DDLm+oVe3/4lktzX4En3irCSqxYftqyw/uxFkiz1
	PfUkr63PtPJVbyOtfpalU3JoGbKaNps=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-u1abf28WPDWNKVJye0q3bw-1; Wed, 21 Aug 2024 06:57:27 -0400
X-MC-Unique: u1abf28WPDWNKVJye0q3bw-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5da9378be80so4545464eaf.2
        for <linux-nvme@lists.infradead.org>; Wed, 21 Aug 2024 03:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724237846; x=1724842646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9wlWmDhx1n/J1zGPtYAE+h9t4heJJblAC9mVdhxh/8=;
        b=mJdidTYKbdGA7AfuFpciYDAZ5H6Z3yWu/uWjo/QjVtBZ6irpE0hDmQI/wvl5WVXXJk
         tyIlZjU1oFLDS47K6erfDUjmYecSiRVfItvlMZyQ7Wc46SaMAeMIaOWbkzD75dZArBuu
         jbxKHQ4YK09RzA/UBrZnkptpzj4hClinDNKCJUAf4DxkaHq6toa7XlUFySSmM8sSp26h
         n8Ekm878WO6+ZH/LvUG2o3hH8CRz8IbIvnHu/iyF3N297cENLHcKUSIo8HOpDWRE0tb1
         +CY23LVTmM3pdbbbi3oqkwopMS+jJSckkdtJ4ySHQQys4ziwqSwX6DBc1tV5q9MXV8yU
         mxKw==
X-Gm-Message-State: AOJu0YzQW8cpggLWuJ9XotCYULa5MNe8HXANcSYnCJoL1lAghxWPZ8To
	k7C1MEj5+O26g+DIirsKr2e+ltUYVO3SSHKVi3HhSToQTnht+MuZBOpzJB5rOD/cWcfDpoAELPP
	y7kXrV/rJyW3ktu7Q+q4VeVYr23mactbdwPfUx5Cj0hBMeYUNVkfXQKJtd6mCxMM+ki3+hZ+ult
	rxpvSPLbzWaKJ/PfKVK2W3WIkrkjG/pCb265qYXvn1k3LPjYh2lw==
X-Received: by 2002:a05:6358:5697:b0:1ac:6234:fab6 with SMTP id e5c5f4694b2df-1b59fce1368mr217264655d.29.1724237846576;
        Wed, 21 Aug 2024 03:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKFiZCn/kR9uIgxjSHdAaTTDlINB1vmBUPh6QaOZIOUDkyL3LYGiBpbJmz8dkJ7HgtBrK78HQp3xAlR2bxEyY=
X-Received: by 2002:a05:6358:5697:b0:1ac:6234:fab6 with SMTP id
 e5c5f4694b2df-1b59fce1368mr217262855d.29.1724237846051; Wed, 21 Aug 2024
 03:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <364590b3-c3d1-49d6-be6f-d36c1a1412d8@yawk.at>
In-Reply-To: <364590b3-c3d1-49d6-be6f-d36c1a1412d8@yawk.at>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Wed, 21 Aug 2024 12:57:15 +0200
Message-ID: <CAFL455mQ=0VoTPsTN-YZzZ9bu7gy4y2eUnEv69wACjODSQChzw@mail.gmail.com>
Subject: Re: Occasional kernel error with NVMe-oF TCP target
To: Jonas Konrad <me@yawk.at>
Cc: linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_035731_142253_2D17F194 
X-CRM114-Status: GOOD (  11.01  )
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

> Is the stack trace enough to go on? Is this already fixed in a newer
> kernel? Do you need me to gather more information?

The stack trace was more than sufficient, it's still reproducible on 6.11.0-rc4
What happens is that the nvme-tcp failed to allocate sufficient memory
for the commands and the
queue release procedure dereferences a NULL pointer

Easy to reproduce with this patch:

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5bff0d5464d1..9cdb6e81169f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1516,7 +1516,7 @@ static int nvmet_tcp_alloc_cmds(struct
nvmet_tcp_queue *queue)
        struct nvmet_tcp_cmd *cmds;
        int i, ret = -EINVAL, nr_cmds = queue->nr_cmds;

-       cmds = kcalloc(nr_cmds, sizeof(struct nvmet_tcp_cmd), GFP_KERNEL);
+       cmds = NULL;
        if (!cmds)
                goto out;


[   66.397317] nvmet: failed to install queue 0 cntlid 1 ret 6
[   66.398385] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000008
[...]
[   66.413549] Call trace:
[   66.413739]  nvmet_tcp_release_queue_work+0xe8/0x2f0 [nvmet_tcp]
[   66.414199]  process_one_work+0x188/0x410

Maurizio


