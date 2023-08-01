Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10553C001E0
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Aug 2023 11:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=F7/Vx2vQrKZJtPQGs5BzH3RGbwK4yN0bYxF9djK4RRM=; b=VHyYzhMh7PPzU2OcFpl5UlOGtE
	CHAa/jzbCa0snU+L796gNw2R4YXFECdd2v58Frqe9VmpkkdgwmaMs2M0aj2f5zKDToXhwByAYeb8t
	PiDd+obj9dwHVXN1mxyf0FlJ4H2wFJ2GEP+cFmP9ZRoCMZlyJqlsUDReaqM1Co36T8Hs/ahf4vVOs
	T0ZzRTA4DF0V0C7JfHtFUH6lFVwxottw50lseNO8foGyq1RpVtKrlk9Al5c1Z7OGeLuFoJx4YZbSb
	O/TKPiObDThiBr6/KKW9BosCwGhS1foCmU/sFvcegNMbteriih4ixJc9QDFFJk+PHWQxO7aVtp1x3
	m0yLcDxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQnYn-00265h-0I;
	Tue, 01 Aug 2023 11:29:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQnYj-002655-1z
	for linux-nvme@lists.infradead.org;
	Tue, 01 Aug 2023 11:29:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690889338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=F7/Vx2vQrKZJtPQGs5BzH3RGbwK4yN0bYxF9djK4RRM=;
	b=Lhh5LHt4QaQVus3Bk3qkMSwmQ6mJvQI5AtEdUW8ooR5ZSCCrSpXAabrMRERWQhs6NNNsYt
	naDXJvD2blW/D64o1/kDpXHS+5TfnSFDUoiFvlTVXyTXaWyi3G2lpZmo5CQPY6Fgkr7jAJ
	widy814kvb9NLQizg4T6qCRtrhSatvg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-xVFZe8A3OHCdTYOeUL_T6w-1; Tue, 01 Aug 2023 07:28:57 -0400
X-MC-Unique: xVFZe8A3OHCdTYOeUL_T6w-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a5ad07254cso8030205b6e.0
        for <linux-nvme@lists.infradead.org>; Tue, 01 Aug 2023 04:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889336; x=1691494136;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7/Vx2vQrKZJtPQGs5BzH3RGbwK4yN0bYxF9djK4RRM=;
        b=VOA7lzw5vkCwnaXid+bVf7TujZeYspuOrIrwts1yQmO3KJ/gCCg265a8ctwrIy6zLR
         BwPl1sI88piWjJ1YKaJlj/vutsFPPAmEQgboRTUR+kzstBBM4N5jyYppp6WZiOZC058L
         /vme8dXyLmipFdSnmIHJwrruelRrSKKfoYNS6eIEFVi89RgI5LTnegVIg5XUWZY+UMo1
         nQLdsUghv9zZoem8tK4+qU4YKqlaVu+RKTtfADYC8a3Jzr9wwM7iFwA+MrtOjfQD3zrf
         v4ITHIMvZmpvyjAVLjfsyS3MbdxHCMdVuz0HhTrLvhRVLlkKVdmuVlEbwDSjiWlw3CZZ
         jkXA==
X-Gm-Message-State: ABy/qLbiTOgmyGUNYZTRbsTs+M2ZoeasgZiwO27jtl+h/k4XOHTRp8VI
	434lxdIuXOjY1a44EHH/OoRwwRyh0ypmLFeKbfA6OqsqNPqdLeD5jsEyfkAivBAAVZ96U0cA7/h
	9uOLbKQ/iVUsV8ggWTYS7hsvYMT0js3SG/O35ShfQdBhiGu/bwU1LkaCw
X-Received: by 2002:a05:6808:1a81:b0:3a7:1bd8:4eb6 with SMTP id bm1-20020a0568081a8100b003a71bd84eb6mr6000664oib.44.1690889336213;
        Tue, 01 Aug 2023 04:28:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGq5WBisi5MLVrJQkJb+u+kNQn8jJartIHndaKJkvl0JaqoT+K/XIH/4PHOkvNq2TGdInKUTu2Anm2CGwaIHiw=
X-Received: by 2002:a05:6808:1a81:b0:3a7:1bd8:4eb6 with SMTP id
 bm1-20020a0568081a8100b003a71bd84eb6mr6000654oib.44.1690889335955; Tue, 01
 Aug 2023 04:28:55 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 1 Aug 2023 19:28:44 +0800
Message-ID: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
Subject: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not created
 in time
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_042901_740997_FA0DC2AA 
X-CRM114-Status: UNSURE (   8.29  )
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

Hello

I found random nvme/047 failure on linux-block/for-next when I do
stress blktests nvme/tcp nvme/047 test:

Kernel config: https://pastebin.com/6i3sZWAx
============================================0
nvme/047 (test different queue types for fabric transports)  [failed]
    runtime  71.129s  ...  7.096s
    --- tests/nvme/047.out 2023-07-16 23:04:30.052101710 -0400
    +++ /root/blktests/results/nodev/nvme/047.out.bad 2023-07-19
09:17:35.949908134 -0400
    @@ -1,2 +1,198 @@
     Running nvme/047
    +fio: looks like your file system does not support direct=1/buffered=0
    +fio: looks like your file system does not support direct=1/buffered=0
    +fio: looks like your file system does not support direct=1/buffered=0
    +fio: looks like your file system does not support direct=1/buffered=0
    +fio: destination does not support O_DIRECT
    +fio: destination does not support O_DIRECT
    ...
    (Run 'diff -u tests/nvme/047.out
/root/blktests/results/nodev/nvme/047.out.bad' to see the entire diff)

After some investigating, I found it was due to the /dev/nvme0n1 node
couldn't be created in time which lead to the following fio failing.
+ nvme connect -t tcp -a 127.0.0.1 -s 4420 -n blktests-subsystem-1
--hostnqn=nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
--hostid=0f01fb42-9f7f-4856-b0b3-51e60b8de349 --nr-write-queues=1
+ ls -l /dev/nvme0 /dev/nvme-fabrics
crw-------. 1 root root 234,   0 Aug  1 05:50 /dev/nvme0
crw-------. 1 root root  10, 122 Aug  1 05:50 /dev/nvme-fabrics
+ '[' '!' -b /dev/nvme0n1 ']'
+ echo '/dev/nvme0n1 node still not created'
dmesg:
[ 1840.413396] loop0: detected capacity change from 0 to 10485760
[ 1840.934379] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1841.018766] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 1846.782615] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1846.808392] nvme nvme0: creating 33 I/O queues.
[ 1846.874298] nvme nvme0: mapped 1/32/0 default/read/poll queues.
[ 1846.945334] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420

BTW, I also found after disabling nvme_core.multipath, seems this
issue cannot be reproduced.

--
Best Regards,
  Yi Zhang


