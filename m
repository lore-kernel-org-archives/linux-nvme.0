Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E68EB64D9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 02:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wHf64wmzfW9+hm6TK3O2bmp46tpQudGp2nslJmzIAdQ=; b=SMH8hvTGhb8yeXzmfM0TKhr8ID
	n+z/4P6P3Cn2B4FXYdccSp2TQ4NcuVGgJTlTaR4SxdEeEgI8fA3uF6L6FndjAfBzawk/UY5OuNyoA
	hz7vX6LjF5NkYHGBrjIaggjn0bF81BfJARc4gnp04CuYcPXZPE0mw7eACdLGMdEJWdm1+giKu/Hej
	288Oh2UthESez7ILdD5Xa6tRg87NLAz2cZ9I1aORpIvH3h7CObSs+Qa6KP1F+QqdXZQV2j5A14ugm
	TKIvY80Q1gCDJbfJCy3rj1xcFrHU/KOpbEELShF1DH02oDEMzPEkDLa2AkhklLA8nowS+LZBCs5N+
	6aOrGZpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qELON-00Ee2g-2N;
	Wed, 28 Jun 2023 02:58:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qELOJ-00Ee1y-2d
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 02:58:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687921125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHf64wmzfW9+hm6TK3O2bmp46tpQudGp2nslJmzIAdQ=;
	b=DRqpxmhdvBF9uTNZ7ETfox+X6iXkUqlUpzd/wy6p2WbWiXtO1T/GnvkbOqS717bdJ9n3uY
	ehw7BTWolrb+MXGQQoh0LatR1Y+at7Oy1lMIrPPkvhiERpBH/ETlhbFT7e7E6zijKsDzTB
	lZdQ1cgtPNaTf7tQPdJ7M2F2UP7CWUo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-Jjiu90UjPmqp3p8sIUbM7Q-1; Tue, 27 Jun 2023 22:58:43 -0400
X-MC-Unique: Jjiu90UjPmqp3p8sIUbM7Q-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1b7dec879e6so17107995ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 27 Jun 2023 19:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687921122; x=1690513122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHf64wmzfW9+hm6TK3O2bmp46tpQudGp2nslJmzIAdQ=;
        b=M3dAhmb4Z+iv8MNH1SfslDgHnaqzpyKrfw7TlHkR486oMLe/HBsz+HjfkCAqGqKvIm
         HbRIO2NRPuIB6L8FthUOnuQVNFxP/Z5zL87GsE8Bwy3cvPClhOElbN09DhWOOr0ysxbo
         8XRuf1qr0kjfDhzBfsvH+kmaItoWgU+Obe3G/cSSfJAsPoVAmnfiMX00/dan4FkSJJNt
         xbyaAgmWPqoEjDch+15QPPWA/i5jvXYwtRYXXK8mAb8lxDNE2h4dW0FabHt08+hRqHyy
         1xOFd5NcVclG3Pzd5jeaJsVlWQYWL/r6SycFZzXpL09wXhIfBLepn5KdLtwz2FEaNvlB
         JGBg==
X-Gm-Message-State: AC+VfDwNjZlU7KMQ7XqVzdWFMqfVoTX56cmqO+kwYTlzPCvmjPHCaRO0
	x4jbbR12oI5jMRHoP7+dQtddHlI3ePt8z7brFeK9pXZ5WOjQWeBUz4bZvkcm1q5p1ZZR5k1Z5cp
	3HX1UemYYPmbvtp+L54kpXkWljs3hu1luW34uWSuD0Ic=
X-Received: by 2002:a17:90a:fe0f:b0:262:e6c4:80db with SMTP id ck15-20020a17090afe0f00b00262e6c480dbmr6109548pjb.16.1687921122367;
        Tue, 27 Jun 2023 19:58:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Xk3pckjT2z7BspqSGf0Qm+R7sIMBNf3+ffNOr5NRJlicwBdOoZGIz4bn+Ce9rD0lCUdp5cxkrBAGL1PUHZPs=
X-Received: by 2002:a17:90a:fe0f:b0:262:e6c4:80db with SMTP id
 ck15-20020a17090afe0f00b00262e6c480dbmr6109537pjb.16.1687921121936; Tue, 27
 Jun 2023 19:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me> <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
In-Reply-To: <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 28 Jun 2023 10:58:29 +0800
Message-ID: <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux tree
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_195848_003877_51647D82 
X-CRM114-Status: GOOD (  28.16  )
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

Hi Chaitanya

Here is the code I used, and I will try to bisect it later today.

# git remote -v
origin https://github.com/torvalds/linux.git (fetch)
origin https://github.com/torvalds/linux.git (push)
# git log -1 --oneline
98be618ad030 (HEAD -> master, origin/master, origin/HEAD) Merge tag
'Smack-for-6.5' of https://github.com/cschaufler/smack-next

# cd ../blktests/
# git remote -v
origin https://github.com/osandov/blktests (fetch)
origin https://github.com/osandov/blktests (push)
# git log -1 --oneline
154e652 (HEAD -> master, origin/master, origin/HEAD) block/034: Test
memory is released by null-blk driver with memory_backed=3D1


On Wed, Jun 28, 2023 at 10:05=E2=80=AFAM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 6/27/23 15:37, Chaitanya Kulkarni wrote:
> > On 6/27/23 14:21, Sagi Grimberg wrote:
> >>> Hello
> >>>
> >>> I found this failure on the latest linux tree, and it cannot be
> >>> reproduced on v6.4,
> >>> it should be one regression recently merged to linux tree after v6.4.
> >>> I check the commit recently merged after v6.4, and found below commit
> >>> touched the related code, not sure if it was introduced by this
> >>> commit.
> >>>
> >>> commit 959ffef13bac792e4e2e3321d6e2bd2b00c0f5f9
> >>> Author: Chaitanya Kulkarni <kch@nvidia.com>
> >>> Date:   Thu Jun 1 23:47:42 2023 -0700
> >>>
> >>>       nvme-fabrics: open code __nvmf_host_find()
> >> That just moved code, no functional change,
> >> most likely the below was the offender:
> >> ae8bd606e09b ("nvme-fabrics: prevent overriding of existing host")
> > For nvme-6.5 blktests are passing with nvme_trtype "loop" and "tcp"
> > see [1] with following HEAD :-
> >
> > commit 99160af413b4ff1c3b4741e8a7583f8e7197f201 (origin/nvme-6.5)
> > Author: Sagi Grimberg <sagi@grimberg.me>
> > Date:   Tue Jun 20 16:07:36 2023 +0300
> >
> >       nvme-mpath: fix I/O failure with EAGAIN when failing over I/O
> >
> > Also, didn't find the following error messsage in dmesg.
> > blktests (master) # dmesg | grep "found same hostid"
> > blktests (master) #
> >
> > confused exactly how blktests are passing on nvme-6.5 branch ?
> >
> > I'll try linux v6.4 next and update you soon ..
> >
> > -ck
> >
> >
>
> I ran the blktests on linux-block/for-next with following HEAD:-
> commit 3261ea42710e9665c9151006049411bd23b5411f (origin/for-next)
> Merge: ad73f31646e0 6d85ebf95c44
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Jun 26 09:53:41 2023 -0600
>
>      Merge branch 'for-6.5/block-late' into for-next
>
>      * for-6.5/block-late:
>        blk-sysfs: add a new attr_group for blk_mq
>        blk-iocost: move wbt_enable/disable_default() out of spinlock
>        blk-wbt: cleanup rwb_enabled() and wbt_disabled()
>        blk-wbt: remove dead code to handle wbt enable/disable with io
> inflight
>        blk-wbt: don't create wbt sysfs entry if CONFIG_BLK_WBT is disable=
d
>
>
>
> It's passing, can you pleas share :-
>
> 1. git repo link
> 2. git repo HEAD
> 3. blktests head
>
> I'll continue to debug the problem  ...
>
> -ck
>
> [1]
> linux-block (for-next) # git log -2
> commit 0be6b9ec7bd1aa1b5629ebf2701fa3aa7237d313 (HEAD -> for-next)
> Merge: 7bbb53e97bb3 3261ea42710e
> Author: Chaitanya Kulkarni <kch@nvidia.com>
> Date:   Tue Jun 27 15:40:14 2023 -0700
>
>      Merge branch 'for-next' of git://git.kernel.dk/linux-block into
> for-next
>
> commit 3261ea42710e9665c9151006049411bd23b5411f (origin/for-next)
> Merge: ad73f31646e0 6d85ebf95c44
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Jun 26 09:53:41 2023 -0600
>
>      Merge branch 'for-6.5/block-late' into for-next
>
>      * for-6.5/block-late:
>        blk-sysfs: add a new attr_group for blk_mq
>        blk-iocost: move wbt_enable/disable_default() out of spinlock
>        blk-wbt: cleanup rwb_enabled() and wbt_disabled()
>        blk-wbt: remove dead code to handle wbt enable/disable with io
> inflight
>        blk-wbt: don't create wbt sysfs entry if CONFIG_BLK_WBT is disable=
d
> linux-block (for-next) # cdblktests
> blktests (master) # ./test-nvme.sh
> ################nvme_trtype=3Dloop############
> nvme/002 (create many subsystems and test discovery) [passed]
>      runtime    ...  19.523s
> nvme/003 (test if we're sending keep-alives to a discovery controller)
> [passed]
>      runtime  10.095s  ...  10.082s
> nvme/004 (test nvme and nvmet UUID NS descriptors) [passed]
>      runtime  1.458s  ...  1.456s
> nvme/005 (reset local loopback target) [passed]
>      runtime  1.199s  ...  1.808s
> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
>      runtime  0.059s  ...  0.066s
> nvme/007 (create an NVMeOF target with a file-backed ns) [passed]
>      runtime  0.044s  ...  0.033s
> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
>      runtime  1.148s  ...  1.476s
> nvme/009 (create an NVMeOF host with a file-backed ns) [passed]
>      runtime  1.139s  ...  1.435s
> nvme/010 (run data verification fio job on NVMeOF block device-backed
> ns) [passed]
>      runtime  113.605s  ...  113.720s
> nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed=
]
>      runtime  83.124s  ...  80.072s
> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> device-backed ns) [passed]
>      runtime  86.374s  ...  93.449s
> nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed
> ns) [passed]
>      runtime  78.565s  ...  64.751s
> nvme/014 (flush a NVMeOF block device-backed ns) [passed]
>      runtime  6.617s  ...  7.489s
> nvme/015 (unit test for NVMe flush for file backed ns) [passed]
>      runtime  5.939s  ...  6.214s
> nvme/016 (create/delete many NVMeOF block device-backed ns and test
> discovery) [passed]
>      runtime    ...  12.590s
> nvme/017 (create/delete many file-ns and test discovery) [passed]
>      runtime    ...  12.932s
> nvme/018 (unit test NVMe-oF out of range access on a file backend) [passe=
d]
>      runtime  1.120s  ...  1.422s
> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passe=
d]
>      runtime  1.148s  ...  1.437s
> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.124s  ...  1.437s
> nvme/021 (test NVMe list command on NVMeOF file-backed ns) [passed]
>      runtime  1.127s  ...  1.414s
> nvme/022 (test NVMe reset command on NVMeOF file-backed ns) [passed]
>      runtime  1.164s  ...  1.767s
> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
>      runtime  1.151s  ...  1.442s
> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
>      runtime  1.112s  ...  1.440s
> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.121s  ...  1.420s
> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
>      runtime  1.121s  ...  1.418s
> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
>      runtime  1.121s  ...  1.430s
> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.130s  ...  1.415s
> nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
>      runtime  1.261s  ...  1.564s
> nvme/030 (ensure the discovery generation counter is updated
> appropriately) [passed]
>      runtime  0.115s  ...  0.205s
> nvme/031 (test deletion of NVMeOF controllers immediately after setup)
> [passed]
>      runtime  0.802s  ...  3.861s
> nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
>      runtime  0.015s  ...  0.012s
> nvme/040 (test nvme fabrics controller reset/disconnect operation during
> I/O) [passed]
>      runtime  7.296s  ...  8.020s
> nvme/041 (Create authenticated connections) [passed]
>      runtime  0.448s  ...  0.759s
> nvme/042 (Test dhchap key types for authenticated connections) [passed]
>      runtime  2.757s  ...  4.790s
> nvme/043 (Test hash and DH group variations for authenticated
> connections) [passed]
>      runtime  0.705s  ...  6.904s
> nvme/044 (Test bi-directional authentication) [passed]
>      runtime  1.227s  ...  1.835s
> nvme/045 (Test re-authentication) [passed]
>      runtime  3.646s  ...  3.791s
> nvme/047 (test different queue types for fabric transports)  [not run]
>      runtime  1.718s  ...
>      nvme_trtype=3Dloop is not supported in this test
> nvme/048 (Test queue count changes on reconnect)             [not run]
>      runtime  6.242s  ...
>      nvme_trtype=3Dloop is not supported in this test
> ################nvme_trtype=3Dtcp############
> nvme/002 (create many subsystems and test discovery)         [not run]
>      runtime  19.523s  ...
>      nvme_trtype=3Dtcp is not supported in this test
> nvme/003 (test if we're sending keep-alives to a discovery controller)
> [passed]
>      runtime  10.082s  ...  10.087s
> nvme/004 (test nvme and nvmet UUID NS descriptors) [passed]
>      runtime  1.456s  ...  1.145s
> nvme/005 (reset local loopback target) [passed]
>      runtime  1.808s  ...  1.210s
> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
>      runtime  0.066s  ...  0.055s
> nvme/007 (create an NVMeOF target with a file-backed ns) [passed]
>      runtime  0.033s  ...  0.045s
> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
>      runtime  1.476s  ...  1.164s
> nvme/009 (create an NVMeOF host with a file-backed ns) [passed]
>      runtime  1.435s  ...  1.120s
> nvme/010 (run data verification fio job on NVMeOF block device-backed
> ns) [passed]
>      runtime  113.720s  ...  93.167s
> nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed=
]
>      runtime  80.072s  ...  81.600s
> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> device-backed ns) [passed]
>      runtime  93.449s  ...  95.264s
> nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed
> ns) [passed]
>      runtime  64.751s  ...  66.072s
> nvme/014 (flush a NVMeOF block device-backed ns) [passed]
>      runtime  7.489s  ...  6.727s
> nvme/015 (unit test for NVMe flush for file backed ns) [passed]
>      runtime  6.214s  ...  5.914s
> nvme/016 (create/delete many NVMeOF block device-backed ns and test
> discovery) [not run]
>      runtime  12.590s  ...
>      nvme_trtype=3Dtcp is not supported in this test
> nvme/017 (create/delete many file-ns and test discovery)     [not run]
>      runtime  12.932s  ...
>      nvme_trtype=3Dtcp is not supported in this test
> nvme/018 (unit test NVMe-oF out of range access on a file backend) [passe=
d]
>      runtime  1.422s  ...  1.121s
> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passe=
d]
>      runtime  1.437s  ...  1.161s
> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.437s  ...  1.122s
> nvme/021 (test NVMe list command on NVMeOF file-backed ns) [passed]
>      runtime  1.414s  ...  1.123s
> nvme/022 (test NVMe reset command on NVMeOF file-backed ns) [passed]
>      runtime  1.767s  ...  1.172s
> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
>      runtime  1.442s  ...  1.144s
> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
>      runtime  1.440s  ...  1.122s
> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.420s  ...  1.119s
> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
>      runtime  1.418s  ...  1.114s
> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
>      runtime  1.430s  ...  1.140s
> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.415s  ...  1.117s
> nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
>      runtime  1.564s  ...  1.258s
> nvme/030 (ensure the discovery generation counter is updated
> appropriately) [passed]
>      runtime  0.205s  ...  0.137s
> nvme/031 (test deletion of NVMeOF controllers immediately after setup)
> [passed]
>      runtime  3.861s  ...  0.849s
> nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
>      runtime  0.012s  ...  0.016s
> nvme/040 (test nvme fabrics controller reset/disconnect operation during
> I/O) [passed]
>      runtime  8.020s  ...  7.273s
> nvme/041 (Create authenticated connections) [passed]
>      runtime  0.759s  ...  0.440s
> nvme/042 (Test dhchap key types for authenticated connections) [passed]
>      runtime  4.790s  ...  2.712s
> nvme/043 (Test hash and DH group variations for authenticated
> connections) [passed]
>      runtime  6.904s  ...  0.731s
> nvme/044 (Test bi-directional authentication) [passed]
>      runtime  1.835s  ...  1.240s
> nvme/045 (Test re-authentication) [passed]
>      runtime  3.791s  ...  3.630s
> nvme/047 (test different queue types for fabric transports) [passed]
>      runtime    ...  1.701s
> nvme/048 (Test queue count changes on reconnect) [passed]
>      runtime    ...  6.244s
> blktests (master) #
>


--=20
Best Regards,
  Yi Zhang


