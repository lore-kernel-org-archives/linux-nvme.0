Return-Path: <SRS0=5HbI=KR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D587C2B9F2
	for <linux-nvme@archiver.kernel.org>; Sat, 22 May 2021 04:28:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EE66135A
	for <linux-nvme@archiver.kernel.org>; Sat, 22 May 2021 04:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EE66135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IERnisY6v+uNrIhM9MaXvI/mGM3obcrvboB/RtxcN1Q=; b=QMfOqHdx8w4Cv3gNJagV5mmyyt
	kwfj1BynwUF2HIv8GdCHE1VrE7l8ZKlTyDNY+uz+PxRU7K8O6rQIGXLBzFRMEjmIVOIRVaaUE4/VS
	ftaD6hI5leOwfb+GlpdfhNzU+d0JWv9wJJ2mTKp8zf2Nx0mfBSE7flKq6wD9mp+9dwAGXsxV7fOxl
	KL7b5GalSqbXbN85Fo4925P/ULs2/uCDQAsuEieipsUxFZzoRmxpvLv3QBZRrq4kRu3lzm6NLAeZ2
	RcOxpHKIKKkGcr3kpPTI08ayr0Z3W8GUQP9KZ+5p277IyxEBoDSHmtgc+Dm2DkL0H0F5mg622pLUF
	fyFPzHbw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkJF2-001msr-Vk; Sat, 22 May 2021 04:28:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkJF0-001msg-Ot
 for linux-nvme@desiato.infradead.org; Sat, 22 May 2021 04:27:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3iPfp8v43BKfwbs3sPZW9HPPg81McHGYvPwCxny2veU=; b=3e2RiA7ozI42sHrikwPRZep6n2
 OotdlrsUJBIIuDi9N3P26Ky1Z/hQFTPR8r/1WCzamUCA+gNf/+gd/xF/l6p2w3F9YQD9lQ6ntI2SC
 CPHs6vDnXMjSoaS5pW/fiAPuD3JwHqoGl9zqVZV4Opf/OHrUnzOFPVrH6YkmSu16zdO4NXqaS8OCt
 1QFjo4XJxBzdH/0Utdm0WRNTULJP5C1dlGaKO13N8HAy1lkCqx0iwrLGkX1Dx/zOGQ8JLuNUSge+5
 rQOhF44EoW/+XtozzjUaFk+9DgUj4NJ+VTzns432EfNHgN3MkZMhtsy410ae7A5a1bXx6Rq13ZpFF
 rfbbiAXQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkJEx-00Hayt-10
 for linux-nvme@lists.infradead.org; Sat, 22 May 2021 04:27:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621657671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3iPfp8v43BKfwbs3sPZW9HPPg81McHGYvPwCxny2veU=;
 b=PD2xY9JRHQ9vdsyTmWx/ptyXyjZIWBrnoen7/g/SE2lUC6P6twm1CZPmbNLpoA5uQ/IUFw
 x/Lrwi8jDhO4f4jloltA5cYgks3rhrm0MVHXg6KUj4Fd99LA5NncK/9QNfMsKELCsYsTWj
 0mmbMWBpvXbsnSm593oXOTYVHtOwBnc=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-H14O0WMiML2V6X0IrDbpjg-1; Sat, 22 May 2021 00:27:49 -0400
X-MC-Unique: H14O0WMiML2V6X0IrDbpjg-1
Received: by mail-yb1-f200.google.com with SMTP id
 u13-20020a25f80d0000b029051d7fee31cfso2050044ybd.22
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 21:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3iPfp8v43BKfwbs3sPZW9HPPg81McHGYvPwCxny2veU=;
 b=nV56Iw+uZDlDiEZAtT66JHenGVI+y2eyusdElzu90okMLYu8/VLQd6Q84jSDf3hEEw
 4/EJ6lU5pxOb9jZvIu1xRgDjXaYaJ6DqudI3ZEvqk8XHw6kOh8gH+MP8QXhduLboHJvH
 dfgeE24bnSloUlCG6txjhcZnXMrigba/NeVrz1WmwC1i7ORRO/uk2+F7n5Bzvu+98m8Q
 jF8kdAXI3NjNckdnQhgnPwwYvKODjmYW3+iBs6PU50CpGEkxxqyc4g+CbIRmUt465Fh/
 dqQYcXQNiYh3HhlFgcXmxDCq2L42BSYrEsdV5sbfXnF7FqGaP/7bwuGptSab9lE2ZLw9
 3VYg==
X-Gm-Message-State: AOAM533xFFYE+cOe+BkBGyFetppRBtj3HLNylIesQ5QIJr2TvZ4RAS3K
 FE/2c/NYARuCvl+LlO35VGCfW+VJJFKa2JhG4xyJLZwuKXhuvT4QmHzxgTWkgtwmpFifE0uEUe9
 TnlnFYuucvWZTJQqXrmhKF45B6lM0LjMUpjeJAVEelIo=
X-Received: by 2002:a25:ba92:: with SMTP id s18mr21648658ybg.438.1621657668649; 
 Fri, 21 May 2021 21:27:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzB9s7qElD6UZO9OFRpEJaHTfHen0r3cGWVOD/6DD7nB5MAyOeymhIT4KqnhtVKoOp40ft4c8L0kLL4JeJY4No=
X-Received: by 2002:a25:ba92:: with SMTP id s18mr21648638ybg.438.1621657668428; 
 Fri, 21 May 2021 21:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
In-Reply-To: <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 22 May 2021 12:27:36 +0800
Message-ID: <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_212755_169876_45877FE9 
X-CRM114-Status: GOOD (  13.53  )
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

On Sat, May 22, 2021 at 2:00 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hi
> > I found this issue on 5.13-rc2 with NVMe/IB environment, could anyone
> > help check it?
> > Thanks.
> >
> > $ time echo 1 >/sys/block/nvme0n1/device/reset_controller
> > real 0m10.678s
> > user 0m0.000s
> > sys 0m0.000s
> > $ time echo 1 >/sys/block/nvme0n1/device/reset_controller
> > real 1m11.530s
> > user 0m0.000s
> > sys 0m0.000s
> >
> > target:
> > $ dmesg | grep nvme
> > [  276.891454] nvmet: creating controller 1 for subsystem testnqn for
> > NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> > [  287.374412] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> > [  287.399317] nvmet: ctrl 1 fatal error occurred!
> > [  348.412672] nvmet: creating controller 1 for subsystem testnqn for
> > NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> >
> > client:
> > $ dmesg | grep nvme
> > [  281.704475] nvme nvme0: creating 40 I/O queues.
> > [  285.557759] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> > [  353.187809] nvme nvme0: I/O 8 QID 0 timeout
> > [  353.193100] nvme nvme0: Property Set error: 881, offset 0x14
> > [  353.226082] nvme nvme0: creating 40 I/O queues.
> > [  357.088266] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>
> It appears that there is an admin timeout that is either triggered
> by the reset or unrelated.
>
> Can you run nvme reset /dev/nvme0 instead so we can see the "resetting
> controller" print?
>
Yes, here is the log:
------------------------0
+ nvme reset /dev/nvme0
real 0m10.737s
user 0m0.004s
sys 0m0.004s
------------------------1
+ nvme reset /dev/nvme0
real 1m11.335s
user 0m0.002s
sys 0m0.005s

target:
[  934.306016] nvmet: creating controller 1 for subsystem testnqn for
NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
[  944.875021] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[  944.900051] nvmet: ctrl 1 fatal error occurred!
[ 1005.628340] nvmet: creating controller 1 for subsystem testnqn for
NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.

client:
[  857.264029] nvme nvme0: resetting controller
[  864.115369] nvme nvme0: creating 40 I/O queues.
[  867.996746] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[  868.001673] nvme nvme0: resetting controller
[  935.396789] nvme nvme0: I/O 9 QID 0 timeout
[  935.402036] nvme nvme0: Property Set error: 881, offset 0x14
[  935.438080] nvme nvme0: creating 40 I/O queues.
[  939.332125] nvme nvme0: mapped 40/0/0 default/read/poll queues.


-- 
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
