Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3948CC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:10:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C66464E89
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C66464E89
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tbS1JP9W2CrCJd0bE2CXNIi/rha6nOjHyYFX23kHtYw=; b=R8PzZfqSUxoV1tg6be1j3ekqQI
	V+nNOju8xmE8UsOYQoUv6BPZOLUa/B0uhvll4K4R31ewSO7WKaEi3iuxjp4k4chWjpHJHGOOqsFIC
	tAzKGsMdxlKTzrNRSiyTFT+6ilVRyfWgscSELd8CnI4/UELmUM7rlTko7qEbI+62jxV58ANSdw+Lq
	AXAsMaY72r1CYPkzbkZ9Md3BJhXKndNKT7FOKIOZ8chfg6z7vHIJB46SzJY1h1YKjGRofl7pl5UHx
	+ZKz7ksmHeLWadIg5p4IHZkz+eJB1YvdfRn9HeS7ISUdqWvs5IfOIO6+6rx5zqAd3pevGG+LaxIIW
	JFuUubWw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMeNC-00403f-UJ; Wed, 17 Mar 2021 22:10:39 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMeN7-00401o-FY
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 22:10:36 +0000
Received: by mail-io1-xd35.google.com with SMTP id b10so190813iot.4
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 15:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qFhJnmX/s0oUEcROladmsKEjjXMSFe33w6iAkZJqd+0=;
 b=0oWT/E00w/f76eaGEEfnywI9EeZXkLvXaW89KycflSyDIvWxMtuOayhT5Xr+1yN8rS
 3vJaNQvjuDegrUBEtqDO+a2TAIkT8FemWaRbURwFm596X5RuQcxuL2FHbhxrJZA/ku1Z
 1Uhcto5dfHz+SBCX6nRfDPcrbJsYpd/kkAi8oT8TIuNw/19p8gh1QUw4xfYTZ1oGmbHn
 G+1Lgp9BZhwd4RuLsY0PyjZxrs1ZgTBfysvWDnIGO0ya72LC2pSTKdHOok7u5+rmQS/v
 2bMTnoy08wZOX4228PZqWp/x7LKlu8e60+8SVXtQUQcKLoO1NjOMVveEq15ZvFvwBFxO
 eQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qFhJnmX/s0oUEcROladmsKEjjXMSFe33w6iAkZJqd+0=;
 b=HvWgRpoBGrM/vyJ2X+sbQw2HQzRp+YLJW+SMUGC4U4a+Qkn9qnd+JPw6/o2cEySZa+
 r7ndix45aR55UY83z6aTPlQ+isKHdE6YHGVPhvjbcJqW0oGseE2b3qBc3h4qPXK9D4S7
 w4f+qssdeyxgHWi2q6Na/fnB7WPVBJLyFmmFofHq2aipgLnwN4Fty26YxgkOkaaBaP03
 XVMTZhUIC3TN2OqObCpdOP/Gb6H+WQtE9f4OqIvVqcilg8RfRKN2/tIcWfTLUYG8/gOO
 6dSu/U0i6PCznC690H4RtcVfveJgKWVEm9OTDASD8nFHuwWPD/euQTm5FdWaM5EIT5ec
 Qmzw==
X-Gm-Message-State: AOAM533X8D56iQ+C3m9xNNt4MfeL1BMLOyFu/+cgtDMEK1HDZET1PiWP
 U55fttMpAynnjOqcP1/GksJAnk0l5bQrqQ==
X-Google-Smtp-Source: ABdhPJxGlbDabSp3OtWPg2oo3h1A2WRDvHZzIhmSMzBeQg7akxFm83lwUcAt5NriSELf25wT5kBitg==
X-Received: by 2002:a5d:9245:: with SMTP id e5mr8312613iol.97.1616019032068;
 Wed, 17 Mar 2021 15:10:32 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id r3sm160700ilq.42.2021.03.17.15.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Mar 2021 15:10:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: joshi.k@samsung.com, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, metze@samba.org
Subject: [PATCHSET v4 0/8] io_uring passthrough support
Date: Wed, 17 Mar 2021 16:10:19 -0600
Message-Id: <20210317221027.366780-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_221033_661371_5243A6AD 
X-CRM114-Status: GOOD (  15.06  )
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

Hi,

I fiddled a bit with the v3 repo, and came up with what I think is a
better solution. Basically we split the io_uring_sqe into a header part,
and then a main part. io_uring_sqe remains the same, obviously, but
io_uring_cmd_sqe is then the sqe for these kinds of passthrough payloads.

In turn, consumers of that can then overlay on io_uring_cmd_sqe. Since
I think we need the personality in there, we may as well add op and len
as most/all will want that too. That leaves 40 bytes that can be used
freely. That may not seem like much, but remember that's 40 bytes outside
of the fd, len, and command op.

I updated and tested the block ioctl example, but didn't update the
net side outside of needing a tweak on the net command. Outside of that,
it should work like before.

I'd be interested in feedback on this approach. My main goal is to make
this flexible enough to be useful, but also fast enough to be useful.
That means no extra allocations if at all avoidable, and even being wary
of adding extra branches to the io_uring hot path. With this series, we
don't do the nasty split in io_init_req() anymore, which I really
disliked in the previous series.

This is by no means perfect yet, but I do think it's better than v3 by
quite a lot. So please send feedback and comments, I'd like to get this
moving forward as we have various folks already lined up to use it...

Kanchan, can you try and address the NVMe feedback and rebase on top
of this branch? Thanks!

You can also find this branch here:

https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-fops.v4

 block/blk-mq.c                |  11 +++
 fs/block_dev.c                |  30 ++++++
 fs/io_uring.c                 | 181 ++++++++++++++++++++++++----------
 include/linux/blk-mq.h        |   6 ++
 include/linux/blkdev.h        |  13 +++
 include/linux/fs.h            |  11 +++
 include/linux/io_uring.h      |  16 +++
 include/linux/net.h           |   2 +
 include/net/raw.h             |   3 +
 include/net/sock.h            |   6 ++
 include/net/tcp.h             |   2 +
 include/net/udp.h             |   2 +
 include/uapi/linux/io_uring.h |  21 ++++
 include/uapi/linux/net.h      |  17 ++++
 net/core/sock.c               |  17 +++-
 net/dccp/ipv4.c               |   1 +
 net/ipv4/af_inet.c            |   3 +
 net/ipv4/raw.c                |  27 +++++
 net/ipv4/tcp.c                |  36 +++++++
 net/ipv4/tcp_ipv4.c           |   1 +
 net/ipv4/udp.c                |  18 ++++
 net/ipv6/raw.c                |   1 +
 net/ipv6/tcp_ipv6.c           |   1 +
 net/ipv6/udp.c                |   1 +
 net/l2tp/l2tp_ip.c            |   1 +
 net/mptcp/protocol.c          |   1 +
 net/sctp/protocol.c           |   1 +
 net/socket.c                  |  13 +++
 28 files changed, 391 insertions(+), 52 deletions(-)

-- 
Jens Axboe




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
