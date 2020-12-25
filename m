Return-Path: <SRS0=S77o=F5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4954C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Dec 2020 07:49:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD2D23129
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Dec 2020 07:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD2D23129
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a62wgCS039xI7QgltkMCyO6kzXFXPlo0rE2bnnRlj6w=; b=o5TdPMsgmmpUNCm6k1AHtAlJ+
	q3b04J4Rpfml5tT1kRvE+50+droh4vZ2qArDQue2UflhSoezek8pijy/il2VgJo4IrJ9v7YBXp/rH
	18wCCJ6td1pxCHckjXIXWLk4ajyRfrsrsdVbvsk93mCfPtHlifEL8TkywxDVBKDfj5LtHvybht9Gl
	JfkiwupqvUIH91XKPG3L0PrB0nuCWL+jb9HhmRiSrs+x23r4ksfkMXKXULPi6WdU6tvbv1yhsnQZe
	tlFdFqZhCpO+gaC4sJ1WnHugCeX7jWDh+k84fIoHdGPWKTy9QnU5jPlhcSbFL9UVFFTsFfpdMo/Sf
	QCqZMIBzA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kshqq-0004gC-Ci; Fri, 25 Dec 2020 07:49:28 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kshql-0004fS-Bt
 for Linux-nvme@lists.infradead.org; Fri, 25 Dec 2020 07:49:25 +0000
Received: by mail-ej1-x632.google.com with SMTP id ga15so5676279ejb.4
 for <Linux-nvme@lists.infradead.org>; Thu, 24 Dec 2020 23:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2gVUiFdb5mdjFLF4QUClkk+wFuKHTMz3FHyqiyqgxOc=;
 b=Pei1R7QW97r8sdv3fOb/zObYkZLnVLxzfBw5u697H0pBJItcdCVGe3Zu5pezzKN5HW
 8aQYPHYn0WjkRx8g6iqGCwH7DcgAzy+RL0kixhidYYh/IlTRGTlU7Hgf/Jc5anKNqS7s
 Xjz42w8sy02o28KEDS2qDKmkzClv73T5lf6CUvsX7Fo3cVIa3B2t6i54LPUoVDjEDvna
 cQwQ/rcesf/ahual1GWt6X42uSNt/T4eGygpeWgY1OkCyDU01nmvMjIHI4+VrKthqoZw
 ssBl1sW2p29xxxqHIqkVpgTcBkmlYdKwhHppraZ6MqI7T6o5up7siikbBtT4ogxD6Ac0
 EqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2gVUiFdb5mdjFLF4QUClkk+wFuKHTMz3FHyqiyqgxOc=;
 b=cqn+XJEsl/a0JVqw/SUCvXHjWToJLSPl0DFM6uVZMf1MsT9xfEe6Fc7SyKP0GbjqAr
 Q2WylueDmp+BV+UInZ4ayBiuJs2amXzD0vz8ucUc0u1W4VopCKLPpLG/HvljRTGUSo1l
 a1n+aDefOHu6c0/VeV5WVij6nNhBcv8Jcly2rZR2AH1szlat39jNz5dTypvIEE4bKeA7
 umuIQskoMaMHII7wcc3e3IJZjAuTsf3rwCXdAYJ62/qGrnyaj639VDu0l+oSJjegluv+
 732W9AyNxxwmP0QrXeQMx//STxDXaGz+utIfNkKWvA21ZbQJG4Ju3JGSFMcMnDFCUbjz
 7Rlg==
X-Gm-Message-State: AOAM531T3i2xcS1eagCyF8gB0sc+xhh0n7AI7Rr4ZeD/ZV3/CTS15yBy
 4JxN1tGjGKJaQFrXWe9w0KG9uIeZGJQi+4pPR7U=
X-Google-Smtp-Source: ABdhPJz4L+4XVmo5wnnGrqr40hQ8pZqYqwB6uc2JTztrPWAMZjhMZuEi/GpMrtzGpYOIvjdNIHXEQZS7zVvTxCuZ1Ig=
X-Received: by 2002:a17:907:28d4:: with SMTP id
 en20mr31438374ejc.196.1608882560076; 
 Thu, 24 Dec 2020 23:49:20 -0800 (PST)
MIME-Version: 1.0
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
 <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
 <fd4541e4-78c5-ec3b-b272-467fd11f7472@grimberg.me>
 <20201223084332.GA30502@infradead.org>
 <CAJS6EdijX6ws_wHxygdpcYGtB6JFwLDbDE3A0t0QUYS-LbRakg@mail.gmail.com>
 <16d876c1-524a-38d3-3cff-99ec694464b2@grimberg.me>
 <CAJS6EdivEF0c=3FmKj4wGZoVRKbUvjH_qJLXmO7Tvwsp+km0rw@mail.gmail.com>
 <f631893c-5ce9-95fd-c32c-35a7e70d093c@grimberg.me>
In-Reply-To: <f631893c-5ce9-95fd-c32c-35a7e70d093c@grimberg.me>
From: Hao Wang <pkuwangh@gmail.com>
Date: Thu, 24 Dec 2020 23:49:08 -0800
Message-ID: <CAJS6EdjUAb77-rWd=XmFhsM2_3Hds6VV6jQUVPJoJQHhk12J_Q@mail.gmail.com>
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201225_024923_439963_2D7640CF 
X-CRM114-Status: GOOD (  17.18  )
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

In my current setup, on the initiator side, nvme3n1 & nvme4n1 are 2
nvme-tcp devices, schedulers for 3 is:
 - cat /sys/block/nvme3n1/queue/scheduler: "none"
 - cat /sys/block/nvme3c3n1/queue/scheduler: "[none] mq-deadline kyber"
Not sure what is nvme3c3n1 here?

And disabling merges on nvme-tcp devices solves the data corruption issue!

Hao



On Thu, Dec 24, 2020 at 9:56 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Sagi, thanks a lot for helping look into this.
> >
> >> Question, if you build the raid0 in the target and expose that over nvmet-tcp (with a single namespace), does the issue happen?
> > No, it works fine in that case.
> > Actually with this setup, initially the latency was pretty bad, and it
> > seems enabling CONFIG_NVME_MULTIPATH improved it significantly.
> > I'm not exactly sure though as I've changed too many things and didn't
> > specifically test for this setup.
> > Could you help confirm that?
> >
> > And after applying your patch,
> >   - With the problematic setup, i.e. creating a 2-device raid0, I did
> > see numerous numerous prints popping up in dmesg; a few lines are
> > pasted below:
> >   - With the good setup, i.e. only using 1 device, this line also pops
> > up, but a lot less frequent.
>
> Hao, question, what is the io-scheduler in-use for the nvme-tcp devices?
>
> Can you try to reproduce this issue when disabling merges on the
> nvme-tcp devices?
>
> echo 2 > /sys/block/nvmeXnY/queue/nomerges
>
> I want to see if this is an issue with merged bios.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
