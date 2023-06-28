Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D295EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 06:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N2aTIOvz4XJe57bXOVjFUq29J6D4NLC5k/ZFmIGBHVM=; b=zJ0jG3Kv/qtMZlOLveu2JW6izx
	ZzjAXCVTJGEpNEB6qvpUKJaaiSbNPH7YFZgV/JZCjSHDrcKYjIRrdXJPSiWoZB966CHpXv5XWRu/1
	9vBVLSoXu9Toe1HHob3OQLvZ3/gS8jCFaX5VIpawmWXqtrRq8Ma3HxSSs0GjZO4+ywXUJCgdxT5AM
	tYZ2F4sSoSazYUwyYOqZ59aK1WVq7tm6978RBvysuipQsYvpre64eJpgpPuFiXtthVEZyCQ9uzrEW
	nbQ3pwgmCMCZWvIZuA54flwKDnIZ7beLCl044QH4E7DGB9gPsMXdxlcoJP8mWrHZ0LoyclOuerqZp
	SPkkBtMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEONK-00EwEj-0e;
	Wed, 28 Jun 2023 06:09:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEONG-00EwDw-05
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 06:09:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687932592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2aTIOvz4XJe57bXOVjFUq29J6D4NLC5k/ZFmIGBHVM=;
	b=GGZDov2JVlOUivoCZg+iSRx2l08gJRy8873d2sz+3PL6xlng+obx186LFYVhcpv7OaxaGH
	CcJIBNBEfZ8AvLGqLN0pKiWZoWxvDMnmTENQx8onIq2vnQTMsXPlg0BRBC5BJPgeowfz2T
	GMnHY0vpryw5CCxOf8zW9Dq0OUbFmSI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-5q2PrWeTMR2q5tj-tRvI8A-1; Wed, 28 Jun 2023 02:09:51 -0400
X-MC-Unique: 5q2PrWeTMR2q5tj-tRvI8A-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-262ecb0c44fso2551862a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 27 Jun 2023 23:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687932590; x=1690524590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2aTIOvz4XJe57bXOVjFUq29J6D4NLC5k/ZFmIGBHVM=;
        b=P53dxn+CcENa2ZCDTz1+tzmOZs1md3YZnOFPcA0KoAXpGEjAj4PZNu3Oj0BNuYaR52
         NGpJjwFcg6+Mm3riQrMVQbGfdbT7GXkgdy767qMRhMVTb2q5VvTo4NemDvRImkcpQp3M
         cqW3YmIHqeH/OAYWjJni8/xiSUHnJcYbiIHa0l+D/3WyH9dZJx0zf6lj9F6E1fsHRW3E
         ELThJ+/P1uvsJBu/xRj5c9/C0Tfl3jZdjlhK1e3ep3CYFdmHQH8kIfXYbC/GDOi2eGZ8
         CBBN2/yTEpTzBv3Islz9AWodjjZ+k681Jc4sfyTq78o5eAZueKsiPi9c6kYCMNRB4vQK
         MblQ==
X-Gm-Message-State: AC+VfDw++hFoKmo2Dw4IP+mzkYfZRrsKlpb2DVgf9c2i9/wduVOuzv4D
	xiG3iDDfnl1lHDX07YrdPJUso4dZun4hc2QhwEowdvT5oYmeCtMGo1ODCQ4pOOzdjxAJzMKgRAy
	5X/lpEI0FWFTubg2v7rj0JrVEH8t4L4lTzyka/ZBZOS8=
X-Received: by 2002:a17:90b:23d8:b0:262:ea30:2cc3 with SMTP id md24-20020a17090b23d800b00262ea302cc3mr8289107pjb.2.1687932589959;
        Tue, 27 Jun 2023 23:09:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5s7SyMopRJRZKzSOPgfFd9tQJivRcekGjqP2PGfWNTD2a3NygiB31O+kngtlu8mO2q1D+Is9m115DkQKqGaRY=
X-Received: by 2002:a17:90b:23d8:b0:262:ea30:2cc3 with SMTP id
 md24-20020a17090b23d800b00262ea302cc3mr8289092pjb.2.1687932589580; Tue, 27
 Jun 2023 23:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me> <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com> <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
In-Reply-To: <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 28 Jun 2023 14:09:37 +0800
Message-ID: <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux tree
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_230954_242018_663731F8 
X-CRM114-Status: GOOD (  24.82  )
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

So bisect shows it was introduced by the below patch:

commit ae8bd606e09bbdb2607c8249872cc2aeaf2fcc72
Author: Max Gurtovoy <mgurtovoy@nvidia.com>
Date:   Fri May 12 18:41:55 2023 +0300

    nvme-fabrics: prevent overriding of existing host

    When first connecting a target using the "default" host parameters,
    setting the hostid from the command line during a subsequent connection
    establishment would override the "default" hostid parameter. This would
    cause an existing connection that is already using the host definitions
    to lose its hostid.

    To address this issue, the code has been modified to allow only 1:1
    mapping between hostnqn and hostid. This will maintain unambiguous host
    identification. Any non 1:1 mapping will be rejected during connection
    establishment.

    Tested-by: Noam Gottlieb <ngottlieb@nvidia.com>
    Reviewed-by: Israel Rukshin <israelr@nvidia.com>
    Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
    Reviewed-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Keith Busch <kbusch@kernel.org>

On Wed, Jun 28, 2023 at 12:12=E2=80=AFPM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 6/27/23 19:58, Yi Zhang wrote:
> > Hi Chaitanya
> >
> > Here is the code I used, and I will try to bisect it later today.
> >
> > # git remote -v
> > origin https://github.com/torvalds/linux.git (fetch)
> > origin https://github.com/torvalds/linux.git (push)
> > # git log -1 --oneline
> > 98be618ad030 (HEAD -> master, origin/master, origin/HEAD) Merge tag
> > 'Smack-for-6.5' of https://github.com/cschaufler/smack-next
> >
> >
>
> I ran blktests on the above repo and it is still passing for me see [1].
>
> The only testcases are not run those are nvme/auth since it seemed to
> have a bug when kernel is compiled with git hash for the sake of
> debugging. dmesg log is also clean :-
>
> linux (master) #
> linux (master) # dmesg | grep -i same
> linux (master) # dmesg | grep -i hostid
> linux (master) # dmesg | grep -i "found same hostid"
> linux (master) # dmesg | grep -i "found same hostid"
> linux (master) #
>
> None of the testcases you mentioned in your log are failing :(.
>
> Waiting for your bisection result.
>
> -ck
>
> linux (master) # uname -r
> 6.4.0linux-01691-g98be618ad030
>
> linux (master) # git remote -v
> origin git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> (fetch)
> origin git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> (push)
>
> linux (master) # git log -1 --oneline
> 98be618ad030 (HEAD -> master, origin/master, origin/HEAD) Merge tag
> 'Smack-for-6.5' of https://github.com/cschaufler/smack-next
>
> linux (master) # ./compile_nvme.sh
> + umount /mnt/nvme0n1
> + clear_dmesg
> + modprobe -r nvme-fabrics
> + modprobe -r nvme_loop
> + modprobe -r nvmet
> + modprobe -r nvme
> + sleep 1
> + modprobe -r nvme-core
> + lsmod
> + grep nvme
> ++ nproc
> + make -j 48 M=3Ddrivers/nvme/ modules
> + HOST=3Ddrivers/nvme/host
> + TARGET=3Ddrivers/nvme/target
> ++ uname -r
> +
> HOST_DEST=3D/lib/modules/6.4.0linux-01691-g98be618ad030/kernel/drivers/nv=
me/host/
> ++ uname -r
> +
> TARGET_DEST=3D/lib/modules/6.4.0linux-01691-g98be618ad030/kernel/drivers/=
nvme/target/
> + cp drivers/nvme/host/nvme-core.ko drivers/nvme/host/nvme-fabrics.ko
> drivers/nvme/host/nvme-fc.ko drivers/nvme/host/nvme.ko
> drivers/nvme/host/nvme-rdma.ko drivers/nvme/host/nvme-tcp.ko
> /lib/modules/6.4.0linux-01691-g98be618ad030/kernel/drivers/nvme/host//
> + cp drivers/nvme/target/nvme-fcloop.ko drivers/nvme/target/nvme-loop.ko
> drivers/nvme/target/nvmet-fc.ko drivers/nvme/target/nvmet.ko
> drivers/nvme/target/nvmet-rdma.ko drivers/nvme/target/nvmet-tcp.ko
> /lib/modules/6.4.0linux-01691-g98be618ad030/kernel/drivers/nvme/target//
> + ls -lrth
> /lib/modules/6.4.0linux-01691-g98be618ad030/kernel/drivers/nvme/host/
> /lib/modules/6.4.0linux-01691-g98be618ad030/kernel/drivers/nvme/target//
> /lib/modules/6.4.0linux-01691-g98be618ad030/kernel/drivers/nvme/host/:
> total 6.6M
> -rw-r--r--. 1 root root  2.6M Jun 27 20:53 nvme-core.ko
> -rw-r--r--. 1 root root  491K Jun 27 20:53 nvme-fabrics.ko
> -rw-r--r--. 1 root root 1000K Jun 27 20:53 nvme-fc.ko
> -rw-r--r--. 1 root root  780K Jun 27 20:53 nvme.ko
> -rw-r--r--. 1 root root  928K Jun 27 20:53 nvme-rdma.ko
> -rw-r--r--. 1 root root  899K Jun 27 20:53 nvme-tcp.ko
>
> /lib/modules/6.4.0linux-01691-g98be618ad030/kernel/drivers/nvme/target//:
> total 6.6M
> -rw-r--r--. 1 root root 541K Jun 27 20:53 nvme-fcloop.ko
> -rw-r--r--. 1 root root 471K Jun 27 20:53 nvme-loop.ko
> -rw-r--r--. 1 root root 826K Jun 27 20:53 nvmet-fc.ko
> -rw-r--r--. 1 root root 3.1M Jun 27 20:53 nvmet.ko
> -rw-r--r--. 1 root root 902K Jun 27 20:53 nvmet-rdma.ko
> -rw-r--r--. 1 root root 760K Jun 27 20:53 nvmet-tcp.ko
> + modprobe nvme
> + dmesg -c
> [   74.521561] nvme nvme0: pci function 0000:00:04.0
> [   74.545758] nvme nvme0: 48/0/0 default/read/poll queues
> [   74.548527] nvme nvme0: Ignoring bogus Namespace Identifiers
>
> linux (master) # date
> Tue Jun 27 08:53:51 PM PDT 2023
>
> linux (master) # cdblktests
> blktests (master) # ./check nvme
> nvme/002 (create many subsystems and test discovery) [passed]
>      runtime    ...  18.920s
> nvme/003 (test if we're sending keep-alives to a discovery controller)
> [passed]
>      runtime  10.087s  ...  10.080s
> nvme/004 (test nvme and nvmet UUID NS descriptors) [passed]
>      runtime  1.471s  ...  1.437s
> nvme/005 (reset local loopback target) [passed]
>      runtime  1.210s  ...  1.784s
> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
>      runtime  0.055s  ...  0.058s
> nvme/007 (create an NVMeOF target with a file-backed ns) [passed]
>      runtime  0.045s  ...  0.030s
> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
>      runtime  1.164s  ...  1.462s
> nvme/009 (create an NVMeOF host with a file-backed ns) [passed]
>      runtime  1.120s  ...  1.421s
> nvme/010 (run data verification fio job on NVMeOF block device-backed
> ns) [passed]
>      runtime  93.167s  ...  58.078s
> nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed=
]
>      runtime  81.600s  ...  89.008s
> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> device-backed ns) [passed]
>      runtime  95.264s  ...  52.273s
> nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed
> ns) [passed]
>      runtime  66.072s  ...  81.176s
> nvme/014 (flush a NVMeOF block device-backed ns) [passed]
>      runtime  6.727s  ...  7.060s
> nvme/015 (unit test for NVMe flush for file backed ns) [passed]
>      runtime  5.914s  ...  6.356s
> nvme/016 (create/delete many NVMeOF block device-backed ns and test
> discovery) [passed]
>      runtime    ...  12.591s
> nvme/017 (create/delete many file-ns and test discovery) [passed]
>      runtime    ...  12.933s
> nvme/018 (unit test NVMe-oF out of range access on a file backend) [passe=
d]
>      runtime  1.121s  ...  1.419s
> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passe=
d]
>      runtime  1.161s  ...  1.421s
> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.122s  ...  1.417s
> nvme/021 (test NVMe list command on NVMeOF file-backed ns) [passed]
>      runtime  1.123s  ...  1.404s
> nvme/022 (test NVMe reset command on NVMeOF file-backed ns) [passed]
>      runtime  1.172s  ...  1.740s
> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
>      runtime  1.144s  ...  1.425s
> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
>      runtime  1.122s  ...  1.427s
> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.119s  ...  1.428s
> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
>      runtime  1.114s  ...  1.424s
> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
>      runtime  1.140s  ...  1.417s
> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.117s  ...  1.424s
> nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
>      runtime  1.258s  ...  1.547s
> nvme/030 (ensure the discovery generation counter is updated
> appropriately) [passed]
>      runtime  0.137s  ...  0.207s
> nvme/031 (test deletion of NVMeOF controllers immediately after setup)
> [passed]
>      runtime  0.849s  ...  3.837s
> nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
>      runtime  0.016s  ...  0.012s
> nvme/040 (test nvme fabrics controller reset/disconnect operation during
> I/O) [passed]
>      runtime  7.273s  ...  8.021s
> nvme/041 (Create authenticated connections)                  [not run]
>      runtime  0.440s  ...
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
> nvme/042 (Test dhchap key types for authenticated connections) [not run]
>      runtime  2.712s  ...
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
> nvme/043 (Test hash and DH group variations for authenticated
> connections) [not run]
>      runtime  0.731s  ...
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
> nvme/044 (Test bi-directional authentication)                [not run]
>      runtime  1.240s  ...
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
> nvme/045 (Test re-authentication)                            [not run]
>      runtime  3.630s  ...
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
> common/rc: line 212: 0inux: value too great for base (error token is
> "0inux")
> nvme/048 (Test queue count changes on reconnect)             [not run]
>      runtime  6.244s  ...
>      nvme_trtype=3Dloop is not supported in this test
> blktests (master) # nvme_trtype=3Dtcp ./check nvme
> nvme/002 (create many subsystems and test discovery)         [not run]
>      runtime  18.920s  ...
>      nvme_trtype=3Dtcp is not supported in this test
> nvme/003 (test if we're sending keep-alives to a discovery controller)
> [passed]
>      runtime  10.080s  ...  10.086s
> nvme/004 (test nvme and nvmet UUID NS descriptors) [passed]
>      runtime  1.437s  ...  1.140s
> nvme/005 (reset local loopback target) [passed]
>      runtime  1.784s  ...  1.188s
> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
>      runtime  0.058s  ...  0.060s
> nvme/007 (create an NVMeOF target with a file-backed ns) [passed]
>      runtime  0.030s  ...  0.035s
> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
>      runtime  1.462s  ...  1.152s
> nvme/009 (create an NVMeOF host with a file-backed ns) [passed]
>      runtime  1.421s  ...  1.137s
> nvme/010 (run data verification fio job on NVMeOF block device-backed
> ns) [passed]
>      runtime  58.078s  ...  60.132s
> nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed=
]
>      runtime  89.008s  ...  85.854s
> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> device-backed ns) [passed]
>      runtime  52.273s  ...  54.886s
> nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed
> ns) [passed]
>      runtime  81.176s  ...  80.462s
> nvme/014 (flush a NVMeOF block device-backed ns) [passed]
>      runtime  7.060s  ...  6.527s
> nvme/015 (unit test for NVMe flush for file backed ns) [passed]
>      runtime  6.356s  ...  5.831s
> nvme/016 (create/delete many NVMeOF block device-backed ns and test
> discovery) [not run]
>      runtime  12.591s  ...
>      nvme_trtype=3Dtcp is not supported in this test
> nvme/017 (create/delete many file-ns and test discovery)     [not run]
>      runtime  12.933s  ...
>      nvme_trtype=3Dtcp is not supported in this test
> nvme/018 (unit test NVMe-oF out of range access on a file backend) [passe=
d]
>      runtime  1.419s  ...  1.121s
> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passe=
d]
>      runtime  1.421s  ...  1.135s
> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.417s  ...  1.109s
> nvme/021 (test NVMe list command on NVMeOF file-backed ns) [passed]
>      runtime  1.404s  ...  1.108s
> nvme/022 (test NVMe reset command on NVMeOF file-backed ns) [passed]
>      runtime  1.740s  ...  1.154s
> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
>      runtime  1.425s  ...  1.133s
> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
>      runtime  1.427s  ...  1.107s
> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.428s  ...  1.115s
> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
>      runtime  1.424s  ...  1.111s
> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
>      runtime  1.417s  ...  1.133s
> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.424s  ...  1.101s
> nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
>      runtime  1.547s  ...  1.239s
> nvme/030 (ensure the discovery generation counter is updated
> appropriately) [passed]
>      runtime  0.207s  ...  0.116s
> nvme/031 (test deletion of NVMeOF controllers immediately after setup)
> [passed]
>      runtime  3.837s  ...  0.767s
> nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
>      runtime  0.012s  ...  0.015s
> nvme/040 (test nvme fabrics controller reset/disconnect operation during
> I/O) [passed]
>      runtime  8.021s  ...  7.278s
> nvme/041 (Create authenticated connections)                  [not run]
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
> nvme/042 (Test dhchap key types for authenticated connections) [not run]
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
> nvme/043 (Test hash and DH group variations for authenticated
> connections) [not run]
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
> nvme/044 (Test bi-directional authentication)                [not run]
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
> nvme/045 (Test re-authentication)                            [not run]
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
>      kernel 6.4.0linux-01691-g98be618ad030 config not found
> common/rc: line 212: 0inux: value too great for base (error token is
> "0inux")
> nvme/048 (Test queue count changes on reconnect) [passed]
>      runtime    ...  5.230s
> blktests (master) #
>
>
>
>


--=20
Best Regards,
  Yi Zhang


