Return-Path: <SRS0=oc1E=F3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7646FC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 22:24:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9B522288
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 22:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9B522288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hJg0fZECgI2sLi54KYRRb/rly31Ps0otdsDY2ikrtng=; b=DEmjcmjZ+aDlvNsqPyEt6V518
	pVgLFofrhWIKDm4DkmfqLzOKGBanx6XXsKDJ24TsX/TjLVeyRkey2WYfhz7NIybwrOcGQO/f+a0CD
	TI92l2W6OuhwOCcHqCohYCHHCuJQvFXcrP7qdswX28rdgwv5nzLHnSPW2o39uIsYF43wWceBlLJbq
	XBmJ4erpaGqivtY+Fr6bU/7gSlEUnSvEo24p5RPDJc6JujDg4TX/tE7Tt4/awcyKIznDxh1auZID9
	PG4l5bUzMBEL4kYq6psafVVeb9JyPyR3gXJZqoEz7uDia0y/Fmh9v1+t3UARfg13sUDIxGrbVvcl0
	4GRm5XZvw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ksCY5-00074e-MN; Wed, 23 Dec 2020 22:24:01 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ksCY2-000736-8M
 for Linux-nvme@lists.infradead.org; Wed, 23 Dec 2020 22:23:59 +0000
Received: by mail-ej1-x631.google.com with SMTP id q22so1166196eja.2
 for <Linux-nvme@lists.infradead.org>; Wed, 23 Dec 2020 14:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=14hhMo/vu+YjLJzr6i01SHcrwO1ME2gz2aweK53416w=;
 b=u+QMw2u/zTt1zftzVVE3cS4HMzg5/F3kvuJhlIDrrvR9uHzdRmT32bwu7NP96YlIMv
 jDP7DqXNyWxHqNfRbCgRuLSMOybJuOoqoSAfD4FShTNtqHxt8Utc533ezoMNnjTj1Iqk
 +LVo362EHkBRahlwXzZTk3iOjSUr7M+ar7RcXstw8iQ5rqQ4wfMsf4z4RvUm2nZJm3bS
 IHBZWdqhYWimQgZDFrBSKS42Q8X1qhnMjyXgWKiDcd2rwW6HVFesVBhnRM/rOxDURziv
 PnPivQ5Hxd9aAjifahkG679nwkLVqVqxjZnOSMj6OBMB9VS6NSKDYem9kUjDpzpDqa9y
 UHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=14hhMo/vu+YjLJzr6i01SHcrwO1ME2gz2aweK53416w=;
 b=Pf66+HWJ1GfIhmkhq/7llr7+hxWdMj0ezwgEbbTNn55xkW/e5xPqsHI1UxlgvkbhNS
 NcZojI2KNp/FGJOTSGbYMpQ1yZbFlYi2gCTPei3md8gDFwra5B9DFb/llotOGW5sLy9t
 WrqOGE5ZWYkjq0ax1tIzbyCwj7j72Q0l94fSbNPiG/tqwTV18TBx9xhTi+gzLGtgEX4M
 gfi1RmBOK8+uVsbhBm1Jo9xxkhwtqK16THVSeHPI8YEjW9Uu62su671FBW5lxDInQTzz
 uDh393nQMZR4maV4haaRxE3BKZijCQU08aunM8zyZ1d6dIyxW6w4/6kH+NCgigaCsM61
 Iosg==
X-Gm-Message-State: AOAM531omfA/prDwG9NeKCXKOcCLUUJ4OliwA02ip6jbfymAVp+o7j6P
 MJkXcem3b/fbQVGWS8suZX1vUUnS5Q8VvCHrZgoDnOKPMBE=
X-Google-Smtp-Source: ABdhPJzcl6Uu3f8gm6daXkEZVJUz+RwGBKU76KZ4ARTJlPOnZUOwCOlb1/fVrCaPJ++m/J8QW5+xh7S8zT4lUWSshR0=
X-Received: by 2002:a17:906:edc4:: with SMTP id
 sb4mr25074923ejb.21.1608762235758; 
 Wed, 23 Dec 2020 14:23:55 -0800 (PST)
MIME-Version: 1.0
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
 <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
 <fd4541e4-78c5-ec3b-b272-467fd11f7472@grimberg.me>
 <20201223084332.GA30502@infradead.org>
 <ad826e9c-021b-7750-314a-f44ef58944f9@grimberg.me>
In-Reply-To: <ad826e9c-021b-7750-314a-f44ef58944f9@grimberg.me>
From: Hao Wang <pkuwangh@gmail.com>
Date: Wed, 23 Dec 2020 14:23:44 -0800
Message-ID: <CAJS6EdjusB9DWtaj=FOW1AxJmb7jA1-C+8TqwWN-TBqMM-Awig@mail.gmail.com>
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201223_172358_340155_3084730B 
X-CRM114-Status: GOOD (  12.58  )
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
Cc: Christoph Hellwig <hch@infradead.org>, Linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sure. I will try to build a new kernel.
This is in an enterprise environment, so it's just really convenient
for me to run with v5.2 or v5.6. For newer kernel, I will have to
build myself. But I will give it a try.

Regarding max_sectors_kb, there seems something interesting:
So on the target side, I see:
# cat /sys/block/nvme1n1/queue/max_sectors_kb
256
#/sys/block/nvme2n1/queue/max_sectors_kb
256

On the initiator side,
 * first, there is both /sys/block/nvme1c1n1 and /sys/block/nvme1n1
 * and their max_sectors_kb is 1280.

Then when I create a raid-0 volume with mdadm,
# /sys/block/md5
128

I'm not an expert on storage, but do you see any potential problem here?

Hao

On Wed, Dec 23, 2020 at 1:23 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Wouldn't testing with a not completely outdated kernel a better first
> > step?
>
> Right, didn't notice that. Hao, would it be possible to test this
> happens with the latest upstream kernel (or something close to that)?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
