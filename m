Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC11AC4743C
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 10:01:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E41061164
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 10:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E41061164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RDF/9hjpe3HXKILoXtupwYhiSIYDZQvo9qRtPtU/kFI=; b=1Rit+oS0xoOv+2
	kSrYBbIaaEEpTMGq/M/vJ7DhFbEN/H5e+BK8wEL2894rJBsCT6kaTLZ4hFCzbENLk4RtW8uPRHumm
	I3VvBMwlUyIAhpkd4WGkNLCCuX/B20tTsg0zaCNvr9SyphxacTclD+PvNuDwcA39NNxWYoxMqMJV5
	e4lxkQUPP6AnY5k7Fq5WfpKBM3tiDo3xykU2SdFl7eIerzvVJCji8rbGHxQ1KMqLHwI6LpODytY4h
	dD2EjWhK7snaZXe9ieu+uPhjn3KsZSnl++8mLTj2cvXRglzxrlzHagaRzSyuEkQWXxeLju32gtAVs
	C/7dOfoyx12QiP3eTBmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvzhA-00AEIz-Ue; Wed, 23 Jun 2021 10:01:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvzh8-00AEFp-3J
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 10:01:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624442475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yQR3kWoDpNUY1FDcAA8oN8bLTedbRvN61RpEng3B+UE=;
 b=RiGeQdpYuyzselG1crCSKcGiRikXTvi/QWJuLIdsih/QgmNWZo/sHMQQsjv4OFJL3w375D
 m57f/kzroPo0sqFGgvk/Mt848175Dgrmq4fkuyaSprUltYXf/1wBlu4rFEjVqXXz0a+OpE
 MuEK6BHufO7MSi0L8II8vZAibdi1VuY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-CblA1k17OH-qtSoQpecyRQ-1; Wed, 23 Jun 2021 06:01:14 -0400
X-MC-Unique: CblA1k17OH-qtSoQpecyRQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 q10-20020a056214018ab029027751ec9742so2393711qvr.7
 for <linux-nvme@lists.infradead.org>; Wed, 23 Jun 2021 03:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yQR3kWoDpNUY1FDcAA8oN8bLTedbRvN61RpEng3B+UE=;
 b=Tt70l2b3L8ovpD4rzb1jC4HEpJz/5u05Vj0pIpvPN5+54t8JPzKdSJlM/t/zyR42aC
 sfJaKU78agsNwDa8uMV3vGjqdmeBn3szhxw9JV/Q69BYHJM0M4OmS4idDTZzrekctlLE
 NxEqG9fWI7+qY988GQYO0tN06qLq1AgWxmKkYxsuTLa0RhIICrcKTqAZYY/hHp8GRkox
 Rj8WMmfV7Lm2G9y/bGctftkCpLaF/kVODjRLYw8CGr+yisoIERKYMs1tyerc4osMZ3EE
 5fPvinMZTr9cSbhZ8EQVQKYFWTMRrX8ClJLEf9TczjVnDlsIFQWY+4/3ABSh1CqLH56Z
 EcmQ==
X-Gm-Message-State: AOAM533HHrF+XhUqEpZnbw4Iz1c5gFv4djTh8C48W3XMXd0fJj1d4oJS
 r7ywrQKO1ls0Ohj4mQBPXDZBX94DhWm3CnG44Dr/uEM4j6uGjIRbFqDXlJ7VS3zQBfXWO15cEz3
 lYE8U7YRip2bE5U/oOaSe1vCeFmNzSzUse/sBhayOerU=
X-Received: by 2002:a25:3d87:: with SMTP id
 k129mr10932197yba.205.1624442473927; 
 Wed, 23 Jun 2021 03:01:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8fNfj6F1w3LldNmDx1Cyu+8eqR0Cir+Zc+au7eaqC0bnW59h79EsFCMVOJxkRMwAFLote6T7IhBVGoDP73LU=
X-Received: by 2002:a25:3d87:: with SMTP id
 k129mr10932175yba.205.1624442473708; 
 Wed, 23 Jun 2021 03:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
 <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
In-Reply-To: <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 23 Jun 2021 18:01:00 +0800
Message-ID: <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210623_030118_255019_4BB34FEC 
X-CRM114-Status: GOOD (  17.31  )
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

Hello

Gentle ping here, this issue still exists on latest 5.13-rc7

# time nvme reset /dev/nvme0

real 0m12.636s
user 0m0.002s
sys 0m0.005s
# time nvme reset /dev/nvme0

real 0m12.641s
user 0m0.000s
sys 0m0.007s
# time nvme reset /dev/nvme0

real 1m16.133s
user 0m0.000s
sys 0m0.007s

On Sat, May 22, 2021 at 12:27 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> On Sat, May 22, 2021 at 2:00 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > > Hi
> > > I found this issue on 5.13-rc2 with NVMe/IB environment, could anyone
> > > help check it?
> > > Thanks.
> > >
> > > $ time echo 1 >/sys/block/nvme0n1/device/reset_controller
> > > real 0m10.678s
> > > user 0m0.000s
> > > sys 0m0.000s
> > > $ time echo 1 >/sys/block/nvme0n1/device/reset_controller
> > > real 1m11.530s
> > > user 0m0.000s
> > > sys 0m0.000s
> > >
> > > target:
> > > $ dmesg | grep nvme
> > > [  276.891454] nvmet: creating controller 1 for subsystem testnqn for
> > > NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> > > [  287.374412] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> > > [  287.399317] nvmet: ctrl 1 fatal error occurred!
> > > [  348.412672] nvmet: creating controller 1 for subsystem testnqn for
> > > NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> > >
> > > client:
> > > $ dmesg | grep nvme
> > > [  281.704475] nvme nvme0: creating 40 I/O queues.
> > > [  285.557759] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> > > [  353.187809] nvme nvme0: I/O 8 QID 0 timeout
> > > [  353.193100] nvme nvme0: Property Set error: 881, offset 0x14
> > > [  353.226082] nvme nvme0: creating 40 I/O queues.
> > > [  357.088266] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >
> > It appears that there is an admin timeout that is either triggered
> > by the reset or unrelated.
> >
> > Can you run nvme reset /dev/nvme0 instead so we can see the "resetting
> > controller" print?
> >
> Yes, here is the log:
> ------------------------0
> + nvme reset /dev/nvme0
> real 0m10.737s
> user 0m0.004s
> sys 0m0.004s
> ------------------------1
> + nvme reset /dev/nvme0
> real 1m11.335s
> user 0m0.002s
> sys 0m0.005s
>
> target:
> [  934.306016] nvmet: creating controller 1 for subsystem testnqn for
> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> [  944.875021] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> [  944.900051] nvmet: ctrl 1 fatal error occurred!
> [ 1005.628340] nvmet: creating controller 1 for subsystem testnqn for
> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
>
> client:
> [  857.264029] nvme nvme0: resetting controller
> [  864.115369] nvme nvme0: creating 40 I/O queues.
> [  867.996746] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> [  868.001673] nvme nvme0: resetting controller
> [  935.396789] nvme nvme0: I/O 9 QID 0 timeout
> [  935.402036] nvme nvme0: Property Set error: 881, offset 0x14
> [  935.438080] nvme nvme0: creating 40 I/O queues.
> [  939.332125] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>
>
> --
> Best Regards,
>   Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
