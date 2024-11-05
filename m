Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F88D2B92E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 14:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9AxBS4AgzGj59YVTCUYvd42ihdYP8pHXV5d+NntJdng=; b=eUlcYaV+dfqmQeuW+q8iQrDCEz
	nTrJkTLM9RnkbYPPo6crP0hgJBemMG5JmGTxr/V20Oc4EPvIKfJ5pxyry9nS4EDjm4Kkq+tTrfBi7
	6ZEf2IW7fCHQYVi5yfxfqlGeh8yZ33vQvXgr1ehUiJlGDKOPdoe8EUnMcbMuTF5IQ6cYyRLfdFG5b
	lrWRnnEl8Y3W8EA3U05r7Kf0Fj6GBMXzJHVDYYnTn41A2N1W+NmnHx7HP3F4QAcH7Hrc/0d9V9/Uy
	xZBVC8s5QYHpelI+hkeb+BiT2HOmNZWHmPhqV8j2JnkeD2Ky0YHZVBITvtDIvkr0JaabECHQo/o1A
	Rl5xFYZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Kdy-0000000HIZB-2PRq;
	Tue, 05 Nov 2024 14:34:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Kay-0000000HH6M-0uz2
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 14:31:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730817102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9AxBS4AgzGj59YVTCUYvd42ihdYP8pHXV5d+NntJdng=;
	b=VLvEcuUCMpgMH1bo81cGEgo7GhYjIVe+k4ac7K5FSBu9ZF7pKB2Nk+9Rd+AP978lOJEwbj
	08xiKO/N2la2oO8sklZzwGl432wDSzFgmPrtn71J5cSKl4VMb6O9I98umxVLa0OZLtf1jd
	QupbGTI34YJokCMhxWBWG+lhD6580sI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-IErlIAbHMICHTWOEjIKuGw-1; Tue, 05 Nov 2024 09:31:40 -0500
X-MC-Unique: IErlIAbHMICHTWOEjIKuGw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2fb3c9f3ba2so28083311fa.3
        for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 06:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730817099; x=1731421899;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9AxBS4AgzGj59YVTCUYvd42ihdYP8pHXV5d+NntJdng=;
        b=SC6xAxYrlMRKJvKDkj7Z2z6AfaaXHFArc11WbLTHPWVNS7nQoHTZUbvHmikkXKfs0x
         /0cArtSclUGABxPZVwHR/vR6LHwUSj0cDPIonoIKk1NIMQ2QZvwY/WAQYUtuUWt82XSC
         EaiaWMWGjV8uKEMCpXgTNi67HD531coFw3sZvDD3EBPkydX6ImDj0hUBX2pPS2YjnIKA
         9gnSEG7YzsK1ijEBMYnlJosKUQM5NmDWWiYwIpf1c4v2gLUkI7rHsBFNfFHYkTqaDP+5
         LbpcP74CQB0fDrc1B7i8zdypqB026cRGPQm+eSYPufsQn3260gcssE8EddRRmpYGQd+w
         c1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRQQ6c+D2WrxoxTtai9JZlh1ZoresB3ihxCfY+2VjF/0Yp+eLNVsq21hRtXLNQaDaKTI8alc+oGlkn@lists.infradead.org
X-Gm-Message-State: AOJu0YzRh72uEBxq8lU12db8EnvL81H5EklxG9+3SKZz6WmxUK/4lRgU
	wUQ1LnEpH7UPI95l/LhXnNERN6uKdFe1ah2d1FYoRE1laWl5aRpiV7x0sYLkQbeqNWTbqrYmhbH
	OggwBSqfLXk8Su1Dw1ccRkvFRc6bDnOvHSvLXVEch3WrhMVUSLaw1R7aSjhGRdNhv4dBI2wfsBq
	PcOKDCxdD6Wh+lZVsY3PUst4ElRf3qD+yisWJ1Uyo=
X-Received: by 2002:a2e:a0cd:0:b0:2f7:4c9d:7a83 with SMTP id 38308e7fff4ca-2fcbe078a64mr140014921fa.40.1730817098757;
        Tue, 05 Nov 2024 06:31:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBMMD9kyToQ1azdoNbQU4z56w4HwHj2/Pa9kptejonb2KaCEb1LctswZitYWOOMCk+y+/R1Hi6xo+/Gc7uR2w=
X-Received: by 2002:a2e:a0cd:0:b0:2f7:4c9d:7a83 with SMTP id
 38308e7fff4ca-2fcbe078a64mr140014721fa.40.1730817098328; Tue, 05 Nov 2024
 06:31:38 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 5 Nov 2024 22:31:26 +0800
Message-ID: <CAHj4cs9yHr_ONWJ6NaSH4=0yNjqWUV8PVYsk7RiKQ5c5fsUVmw@mail.gmail.com>
Subject: [bug report] most blktests nvme/ failed on the latest linux-block/for-next
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_063148_362936_BE6E8732 
X-CRM114-Status: UNSURE (   7.32  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi
CKI reported this new failure on the latest linux-block/for-next,
please help check it and let me know if you need any info/test for it.

b872afe6c5f2 (HEAD -> for-next, origin/for-next) Merge branch
'for-6.13/io_uring' into for-next

# ./check nvme/004
nvme/004 (tr=loop) (test nvme and nvmet UUID NS descriptors) [failed]
    runtime  0.686s  ...  0.677s
    --- tests/nvme/004.out 2024-11-05 09:06:01.282151811 -0500
    +++ /root/blktests/results/nodev_tr_loop/nvme/004.out.bad
2024-11-05 09:26:01.244341975 -0500
    @@ -1,3 +1,4 @@
     Running nvme/004
    +No namespaces found
     disconnected 1 controller(s)
     Test complete
# ./check nvme/008
nvme/008 (tr=loop bd=device) (create an NVMeOF host)         [failed]
    runtime    ...  0.682s
    --- tests/nvme/008.out 2024-11-05 09:06:01.283151898 -0500
    +++ /root/blktests/results/nodev_tr_loop_bd_device/nvme/008.out.bad
2024-11-05 09:27:07.886096187 -0500
    @@ -1,3 +1,4 @@
     Running nvme/008
    +No namespaces found
     disconnected 1 controller(s)
     Test complete
nvme/008 (tr=loop bd=file) (create an NVMeOF host)           [failed]
    runtime    ...  0.660s
    --- tests/nvme/008.out 2024-11-05 09:06:01.283151898 -0500
    +++ /root/blktests/results/nodev_tr_loop_bd_file/nvme/008.out.bad
2024-11-05 09:27:08.984191003 -0500
    @@ -1,3 +1,4 @@
     Running nvme/008
    +No namespaces found
     disconnected 1 controller(s)
     Test complete

dmesg:
[ 1291.643684] loop: module loaded
[ 1291.664637] run blktests nvme/004 at 2024-11-05 09:26:00
[ 1291.700419] loop0: detected capacity change from 0 to 2097152
[ 1291.709104] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1291.749398] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1291.749673] nvme nvme0: creating 48 I/O queues.
[ 1291.756499] nvme nvme0: new ctrl: "blktests-subsystem-1"
[ 1291.805460] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 1292.536602] Key type psk unregistered
[ 1358.244570] Key type psk registered
[ 1358.279580] loop: module loaded
[ 1358.297947] run blktests nvme/008 at 2024-11-05 09:27:07
[ 1358.330793] loop0: detected capacity change from 0 to 2097152
[ 1358.337292] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1358.374101] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1358.374488] nvme nvme0: creating 48 I/O queues.
[ 1358.382225] nvme nvme0: new ctrl: "blktests-subsystem-1"
[ 1358.428686] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 1359.185821] Key type psk unregistered
[ 1359.369213] Key type psk registered
[ 1359.415584] run blktests nvme/008 at 2024-11-05 09:27:08
[ 1359.453797] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1359.492642] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1359.493086] nvme nvme0: creating 48 I/O queues.
[ 1359.500671] nvme nvme0: new ctrl: "blktests-subsystem-1"
[ 1359.556630] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"



-- 
Best Regards,
  Yi Zhang


