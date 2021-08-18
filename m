Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC705C4320E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 06:42:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEBF60F39
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 06:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6CEBF60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xOHViaoJy3N8DI/1TH2CIwReg2eI4VYW5ADfqGrD1JA=; b=EdwBkqv0mZ++3M
	q/Tam9IWqwmMJrVaO8dfwZOitaj/ydmMWrJjUH0aR2jLSG+toB7yRttdrSzsBxWKUmwrApEs02ROv
	svA1wEN+zg5pGBQg6F4xb3hP3M5o8BKI0oBKPAgBiUB/vWm8PqbkAvSVuEF3OK6gYj8rwJ1mWp/YI
	SsAXdxM4p6+XxbU0VoxMy5g+rM6fIq5ER68ajLs5Aa72HGGtmWuC0eREKb8uYJai1KZ+yV7u5iQFJ
	4UNsuKopXEM6GPkzV9jMqy/LEnnroNKfeGL/cxvlD+DsU73ln9SyMfA26py7458RBluVrA5/VJITw
	rbn0EvMhUFvz0uGG6GXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGFHM-004PYY-Q7; Wed, 18 Aug 2021 06:42:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGFHJ-004PXh-At
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 06:42:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629268940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q3f/VvpnkNZSqXYWa+oKcTrwUzMPqogsGw5YbCjK3vs=;
 b=COdLXvxsS7Vp9BGCFJ5XS+gkQstkuv56dgQVI0YO9lNRnOxd2oIonoMYnavNVYxkl/B5G7
 +FPAtDbHnluspG6+Jy+rw/4skzn9HvrW6+SQ0PC1D2HbVw29QxA4ypf2ILPicorhzFQth+
 Cz/U7kFM1fqENcGJEqS6c1OBc0jKvBU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-UIikboQCPmylnN3kINxx7Q-1; Wed, 18 Aug 2021 02:42:18 -0400
X-MC-Unique: UIikboQCPmylnN3kINxx7Q-1
Received: by mail-yb1-f199.google.com with SMTP id
 p71-20020a25424a0000b029056092741626so1785962yba.19
 for <linux-nvme@lists.infradead.org>; Tue, 17 Aug 2021 23:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q3f/VvpnkNZSqXYWa+oKcTrwUzMPqogsGw5YbCjK3vs=;
 b=Zjzvk2+hTb48g3AuGjjBStoHEAuW1E5+/DJVXJQL9QUnnfhJM6FpHWixSZjenXXQPg
 S9mkeT5be9UKYstmpqwmZmKJZ59WAv0EzF6tLsHQkD45DFEnNYXKIi25cAAcVPhsYt2Z
 b/vY4DHRKeoR+OtneAOefmYADR6sjqKgUxPZC+hAsdwN+NzwdQNZKgQuKqDOILTqzSgy
 tL4O5bs+sHaJ+penCmPnVRXE1b85aq9qNGVydIJeOZmqOtlERz93u9RfSglrcsmeJnKY
 KW+3ytuv1Oj3SYJKOpEGBwnJaaerj2Yxe5ofKKyLzFxgoxe1uAdfh+r6zS+XnIy9WxIy
 IiaQ==
X-Gm-Message-State: AOAM531zYtd7DDp9TYp9p5hISvC4WWKiItdPXouxqrc7E7hJX88Dg4LJ
 VadB62fjH0c/jFJv6adTXX8vLfJ69e9lHSqMRWqorqInx2KXJu4SgPDIBY9OvI+7JsDgVYmMWgs
 57c4WiaLnp/PwiTD5JWq0Ik8JRt0NXYZ2pRJ7mga35hw=
X-Received: by 2002:a05:6902:134c:: with SMTP id
 g12mr9103934ybu.251.1629268938032; 
 Tue, 17 Aug 2021 23:42:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxt6DSeMVEWmZkPr+JwXnqnfF9y1RGHu23or4TgKrwyA9RaRBrszd5acbOoV7uzWNxU3hy2kITKuNNjj8NeDOw=
X-Received: by 2002:a05:6902:134c:: with SMTP id
 g12mr9103916ybu.251.1629268937783; 
 Tue, 17 Aug 2021 23:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_M_PJ-7U3QdUxG5=Ce56mBP+WUwko2JqBO6gu_3CqJwQ@mail.gmail.com>
 <CAD=hENeOwY-EgELJox7WkrJEdR-4tTS5VvFULWibxbRSB9OWww@mail.gmail.com>
 <CAD=hENfMKGEJHQvkpDtE4-Z0thT5rK2QuRksoN_O679umhRdEw@mail.gmail.com>
In-Reply-To: <CAD=hENfMKGEJHQvkpDtE4-Z0thT5rK2QuRksoN_O679umhRdEw@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 18 Aug 2021 14:42:05 +0800
Message-ID: <CAHj4cs-szqzM4s9YPdWJ29JMjJCu1HDDWcpohUgtgZSy2RBzRg@mail.gmail.com>
Subject: Re: [bug report] rdma_rxe doesn't work with blktests on 5.14.0-rc6
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: linux-nvme@lists.infradead.org, 
 RDMA mailing list <linux-rdma@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_234221_507645_73FDB5A4 
X-CRM114-Status: GOOD (  23.28  )
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

On Wed, Aug 18, 2021 at 1:30 PM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> On Wed, Aug 18, 2021 at 1:09 PM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> >
> > On Wed, Aug 18, 2021 at 12:57 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> > >
> > > Hello
> > >
> > > I found rdma_rxe doesn't work with blktests on the latest upstream, is
> > > it a known issue, feel free to let me know if you need any info/test
> > > for it, thanks.
> > >
> > > # nvme_trtype=rdma ./check nvme/008
> > > nvme/008 (create an NVMeOF host with a block device-backed ns) [failed]
> > >     runtime  0.323s  ...  0.329s
> > >     --- tests/nvme/008.out 2021-08-18 00:18:35.380345954 -0400
> > >     +++ /root/blktests/results/nodev/nvme/008.out.bad 2021-08-18
> > > 00:35:11.126723074 -0400
> > >     @@ -1,5 +1,7 @@
> > >      Running nvme/008
> > >     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
> > >     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
> > >     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
> > >     +Failed to write to /dev/nvme-fabrics: Cannot allocate memory
> > >     +cat: '/sys/class/nvme/nvme*/subsysnqn': No such file or directory
> > >     +cat: /sys/block/n1/uuid: No such file or directory
> > >     ...
> > >     (Run 'diff -u tests/nvme/008.out
> > > /root/blktests/results/nodev/nvme/008.out.bad' to see the entire diff)
> > >
> > >
> > > [  981.382774] run blktests nvme/008 at 2021-08-18 00:33:21
> > > [  981.470796] rdma_rxe: loaded
> > > [  981.474338] infiniband eno1_rxe: set active
> > > [  981.474340] infiniband eno1_rxe: added eno1
> > > [  981.476737] eno2 speed is unknown, defaulting to 1000
> > > [  981.481803] eno2 speed is unknown, defaulting to 1000
> > > [  981.486865] eno2 speed is unknown, defaulting to 1000
> > > [  981.492862] infiniband eno2_rxe: set down
> > > [  981.492864] infiniband eno2_rxe: added eno2
> > > [  981.492904] eno2 speed is unknown, defaulting to 1000
> > > [  981.497957] eno2 speed is unknown, defaulting to 1000
> > > [  981.504338] eno2 speed is unknown, defaulting to 1000
> > > [  981.510442] eno3 speed is unknown, defaulting to 1000
> > > [  981.515509] eno3 speed is unknown, defaulting to 1000
> > > [  981.520580] eno3 speed is unknown, defaulting to 1000
> > > [  981.526600] infiniband eno3_rxe: set down
> > > [  981.526601] infiniband eno3_rxe: added eno3
> > > [  981.526640] eno3 speed is unknown, defaulting to 1000
> > > [  981.531693] eno3 speed is unknown, defaulting to 1000
> > > [  981.538052] eno2 speed is unknown, defaulting to 1000
> > > [  981.543115] eno3 speed is unknown, defaulting to 1000
> > > [  981.549088] eno4 speed is unknown, defaulting to 1000
> > > [  981.554149] eno4 speed is unknown, defaulting to 1000
> > > [  981.559211] eno4 speed is unknown, defaulting to 1000
> > > [  981.565201] infiniband eno4_rxe: set down
> > > [  981.565203] infiniband eno4_rxe: added eno4
> > > [  981.565242] eno4 speed is unknown, defaulting to 1000
> > > [  981.570306] eno4 speed is unknown, defaulting to 1000
> > > [  981.576724] eno2 speed is unknown, defaulting to 1000
> > > [  981.581785] eno3 speed is unknown, defaulting to 1000
> > > [  981.586848] eno4 speed is unknown, defaulting to 1000
> > > [  981.599312] loop0: detected capacity change from 0 to 2097152
> > > [  981.612261] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > > [  981.614215] nvmet_rdma: enabling port 0 (10.16.221.116:4420)
> > > [  981.622586] nvmet: creating controller 1 for subsystem
> > > blktests-subsystem-1 for NQN
> > > nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
> > > [  981.622830] nvme nvme0: creating 32 I/O queues.
> > > [  981.634860] nvme nvme0: failed to initialize MR pool sized 128 for
> > > QID 32         ----------------------- failed here
> >
> > Recently a lot of commits are merged into linux upstream, can you let
> > us know the kernel version
> > on which this problem occurs?
>
> I mean, the earliest kernel version on which this problem occurs.

It should be 5.14.-rc5, and from 5.14.0-0.rc4, the tests failed with
another failure log as below, and 5.13 doesn't have these issues.

[  196.022199] run blktests nvme/008 at 2021-08-18 02:06:48
[  196.107611] TECH PREVIEW: Soft-RoCE Transport Driver may not be
fully supported.
               Please review provided documentation for limitations.
[  196.121123] rdma_rxe: loaded
[  196.127604] infiniband eno1_rxe: set active
[  196.127606] infiniband eno1_rxe: added eno1
[  196.130061] eno2 speed is unknown, defaulting to 1000
[  196.135131] eno2 speed is unknown, defaulting to 1000
[  196.140197] eno2 speed is unknown, defaulting to 1000
[  196.146175] infiniband eno2_rxe: set down
[  196.146176] infiniband eno2_rxe: added eno2
[  196.146225] eno2 speed is unknown, defaulting to 1000
[  196.151338] Loading iSCSI transport class v2.0-870.
[  196.152607] eno2 speed is unknown, defaulting to 1000
[  196.158580] eno3 speed is unknown, defaulting to 1000
[  196.163661] eno3 speed is unknown, defaulting to 1000
[  196.168724] eno3 speed is unknown, defaulting to 1000
[  196.168783] iscsi: registered transport (iser)
[  196.174702] infiniband eno3_rxe: set down
[  196.174703] infiniband eno3_rxe: added eno3
[  196.174744] eno3 speed is unknown, defaulting to 1000
[  196.180953] eno2 speed is unknown, defaulting to 1000
[  196.186033] eno3 speed is unknown, defaulting to 1000
[  196.191511] Rounding down aligned max_sectors from 4294967295 to 4294967288
[  196.191546] db_root: cannot open: /etc/target
[  196.192018] eno4 speed is unknown, defaulting to 1000
[  196.200971] eno4 speed is unknown, defaulting to 1000
[  196.206033] eno4 speed is unknown, defaulting to 1000
[  196.212008] infiniband eno4_rxe: set down
[  196.212010] infiniband eno4_rxe: added eno4
[  196.212050] eno4 speed is unknown, defaulting to 1000
[  196.218428] eno2 speed is unknown, defaulting to 1000
[  196.223494] eno3 speed is unknown, defaulting to 1000
[  196.228562] eno4 speed is unknown, defaulting to 1000
[  196.240599] eno2 speed is unknown, defaulting to 1000
[  196.245656] eno3 speed is unknown, defaulting to 1000
[  196.250719] eno4 speed is unknown, defaulting to 1000
[  196.255853] loop: module loaded
[  196.272763] RPC: Registered rdma transport module.
[  196.272765] RPC: Registered rdma backchannel transport module.
[  196.277249] loop0: detected capacity change from 0 to 2097152
[  196.286992] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  196.289632] nvmet_rdma: enabling port 0 (10.16.221.116:4420)
[  196.299378] nvmet_rdma: post_recv cmd failed
[  196.303666] nvmet_rdma: nvmet_rdma_alloc_queue: creating RDMA queue
failed (-22).
[  196.325813] rdma_rxe: invalid mask or state for qp
[  196.330608] nvme nvme0: Connect rejected: status 28 (consumer
defined) nvme status 6 (resource not found).
[  196.340259] nvme nvme0: rdma connection establishment failed (-104)
[  196.450004] eno2 speed is unknown, defaulting to 1000
[  196.455067] eno3 speed is unknown, defaulting to 1000
[  196.460132] eno4 speed is unknown, defaulting to 1000
[  196.475683] rdma_rxe: unloaded


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
