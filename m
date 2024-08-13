Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F34C52D7C
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 07:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GLMXoEnXQB4j6uGPV4owlqBBJTVhrRaJGaY0tIh4Xwc=; b=cDIlbq/kXBhUHYbxhJdLfq3Mtp
	seZdG6oQhMPUB3+1Xo1jpkXBZC6eckctkXw5myx1Yi+c69k/8vZ8TEGov2yjoqRNTakIPqyiNAD7f
	dwz9eupbftFTHNLh0sa3oz3A19R79owiPA2qM+nJ0UjSs2QT4OKcTm88s1FcHbJW4Ofa+eQ2ThXYj
	ruLtXwnVhiyDG2tPJjhtwAIKcH1ROx4cO2i5k7mF8LSSiJgCzbrdepMRoqqPf+jehMmdutoABrlYb
	l37fi4pdmn/+em94WIEUugAVy/SFx95kMe3imRKhyOU52X/ktWi41mepHa7mf7SpNbsMy4nbUlikD
	gu/n+ppg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdldt-00000002ejO-2mx4;
	Tue, 13 Aug 2024 07:08:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdldk-00000002eh1-1sF6
	for linux-nvme@lists.infradead.org;
	Tue, 13 Aug 2024 07:08:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723532898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLMXoEnXQB4j6uGPV4owlqBBJTVhrRaJGaY0tIh4Xwc=;
	b=LihRsRXEJW58EM+okU3jjvqg/VcmyY+iByoN0tRtZz7XqctN4CgyV/EWAlrC6402KFCI17
	kj841Om4yiMzMHv7UYLERf4pt+PNdqCB4AewROra+4rkbL0e6nwFJxc85sqjolnEnKbBIE
	h9tZCMjipPBQO0qBW7trMvvQ04yg2Ao=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-7VnqQvurNNyzLz2o-rEDww-1; Tue, 13 Aug 2024 03:06:46 -0400
X-MC-Unique: 7VnqQvurNNyzLz2o-rEDww-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-70ac9630e3aso4132745a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 13 Aug 2024 00:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723532805; x=1724137605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLMXoEnXQB4j6uGPV4owlqBBJTVhrRaJGaY0tIh4Xwc=;
        b=sqpl1auDjDzsgbL1OxPqq2lIKeEnOWrK9szUaEtpFdAlAAh0jh0AsaSSeZCHKYwqNd
         bV+J5VJlT+uiUKw39wIlvOjK89Ki9/hjgQpvviXMDSdRAlW2JxVDu5C4ok4Ph8id6cqC
         x4himdDxT5AaNrH8bds5E5QhMKWeFy5ILaEVwi2TnGgEccbaNDrdc2ncjqx40IXPLi21
         zIkBRAaG/Ji+HelXautfQOjfWA+JwZjK3B6QSgyk34CXe4HVJjr77OsYlSg27uhtp9iG
         qf8MFd5hnGgGNKkSJhecmwQ5ZoL3Wr9LmaCaL6gjWNj84QqmxX6O/HryEi2pDUXOXwKT
         azTg==
X-Forwarded-Encrypted: i=1; AJvYcCVPVNYOmbVWYJXbJqdd/dBhhBOzzO/9fePFbKVHjlKMsEWqAmAWe1v1iN+hSYy6LUnnf7N4gJcm+2rbWufoKL3vSLQBewnPxGfEQgNmuQY=
X-Gm-Message-State: AOJu0YyDTKYIJYqxeQJbjWWQhXq/5J0/ggeM2EvOwPoQED9srfemsVBK
	jJgTHw/cQ5CReVuwtVG76msbxrCunF6bzpQDq7hoKSkmE/mwGrsxHjaF3ddgX5lMsMNX5MO7tFU
	Y2C6KU/pOOCSi/P1MUJMmVuPj1JCdYhKdjBLqBKKWYGVBpBC9TsR9ICB5Xv+vEsnFqRyiF+Z6Ns
	vm0cb/qaVINyKpX2LvcEOQE4nQoZcidRvEPjP/Gj0=
X-Received: by 2002:a05:6a21:6b0c:b0:1c6:fc2f:40fa with SMTP id adf61e73a8af0-1c8d75c7c32mr3359008637.46.1723532805245;
        Tue, 13 Aug 2024 00:06:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4Sin0HKC9rjncXAyssbzbIMN1oJ/7IXsRidBfNy79BEr7HzyhaxZkC41l5rDTmBxwrSBe3UGPw42vPbsazvE=
X-Received: by 2002:a05:6a21:6b0c:b0:1c6:fc2f:40fa with SMTP id
 adf61e73a8af0-1c8d75c7c32mr3358990637.46.1723532804789; Tue, 13 Aug 2024
 00:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <5yal5unzvisrvfhhvsqrsqgu4tfbjp2fsrnbuyxioaxjgbojsi@o2arvhebzes3>
 <ab363932-ab3d-49b1-853d-7313f02cce9e@linux.ibm.com> <ljqlgkvhkojsmehqddmeo4dng6l3yaav6le2uslsumfxivluwu@m7lkx3j4mkkw>
 <79a7ec0d-c22d-44cf-a832-13da05a1fcbd@linux.ibm.com>
In-Reply-To: <79a7ec0d-c22d-44cf-a832-13da05a1fcbd@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 13 Aug 2024 15:06:32 +0800
Message-ID: <CAHj4cs-5DPDFuBzm3aymeAi6UWHhgXSYsgaCACKbjXp=i0SyTA@mail.gmail.com>
Subject: Re: blktests failures with v6.11-rc1 kernel
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_000820_576930_E91E4CAE 
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Aug 3, 2024 at 12:49=E2=80=AFAM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
>
>
> On 8/2/24 18:04, Shinichiro Kawasaki wrote:
> > CC+: Yi Zhang,
> >
> > On Aug 02, 2024 / 17:46, Nilay Shroff wrote:
> >>
> >>
> >> On 8/2/24 14:39, Shinichiro Kawasaki wrote:
> >>>
> >>> #3: nvme/052 (CKI failure)
> >>>
> >>>    The CKI project reported that nvme/052 fails occasionally [4].
> >>>    This needs further debug effort.
> >>>
> >>>   nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subs=
ystem) [failed]
> >>>       runtime    ...  22.209s
> >>>       --- tests/nvme/052.out        2024-07-30 18:38:29.041716566 -04=
00
> >>>       +++ /mnt/tests/gitlab.com/redhat/centos-stream/tests/kernel/ker=
nel-tests/-/archive/production/kernel-tests-production.zip/storage/blktests=
/nvme/nvme-loop/blktests/results/nodev_tr_loop/nvme/052.out.bad     2024-07=
-30 18:45:35.438067452 -0400
> >>>       @@ -1,2 +1,4 @@
> >>>        Running nvme/052
> >>>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
> >>>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
> >>>        Test complete
> >>>
> >>>    [4] https://datawarehouse.cki-project.org/kcidb/tests/13669275
> >>
> >> I just checked the console logs of the nvme/052 and from the logs it's
> >> apparent that all namespaces were created successfully and so it's str=
ange
> >> to see that the test couldn't access "/sys/block/nvme1n2/uuid".
> >
> > I agree that it's strange. I think the "No such file or directory" erro=
r
> > happened in _find_nvme_ns(), and it checks existence of the uuid file b=
efore
> > the cat command. I have no idea why the error happens.
> >
> Yes exactly, and these two operations (checking the existence of uuid
> and cat command) are not atomic. So the only plausible theory I have at t=
his
> time is "if namespace is deleted after checking the existence of uuid but
> before cat command is executed" then this issue may potentially manifests=
.
> Furthermore, as you mentioned, this issue is seen on the test machine
> occasionally, so I asked if there's a possibility of simultaneous blktest
> or some other tests running on this system.

There are no simultaneous tests during the CKI tests running.
I reproduced the failure on that server and always can be reproduced
within 5 times:
# sh a.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D0
nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subsystem) [=
passed]
    runtime  21.496s  ...  21.398s
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D1
nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subsystem) [=
failed]
    runtime  21.398s  ...  21.974s
    --- tests/nvme/052.out 2024-08-10 00:30:06.989814226 -0400
    +++ /root/blktests/results/nodev_tr_loop/nvme/052.out.bad
2024-08-13 02:53:51.635047928 -0400
    @@ -1,2 +1,5 @@
     Running nvme/052
    +cat: /sys/block/nvme1n2/uuid: No such file or directory
    +cat: /sys/block/nvme1n2/uuid: No such file or directory
    +cat: /sys/block/nvme1n2/uuid: No such file or directory
     Test complete
# uname -r
6.11.0-rc3
[root@hpe-rl300gen11-04 blktests]# lsblk
NAME                                MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
zram0                               252:0    0     8G  0 disk [SWAP]
nvme0n1                             259:0    0 447.1G  0 disk
=E2=94=9C=E2=94=80nvme0n1p1                         259:1    0   600M  0 pa=
rt /boot/efi
=E2=94=9C=E2=94=80nvme0n1p2                         259:2    0     1G  0 pa=
rt /boot
=E2=94=94=E2=94=80nvme0n1p3                         259:3    0 445.5G  0 pa=
rt
  =E2=94=94=E2=94=80fedora_hpe--rl300gen11--04-root 253:0    0 445.5G  0 lv=
m  /


>
> Thanks,
> --Nilay
>


--=20
Best Regards,
  Yi Zhang


