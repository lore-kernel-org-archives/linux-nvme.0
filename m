Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3940C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 13:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1oYqsIKkcmataEUtmeD5jZ99oldwbm2YOW3wd8l7PMc=; b=NISDjLUHy2nnrbKez1QX0E8EuL
	aaJBmFANJ8Wu1ody1FRC9cAR/JG8S9u9+p7uPD7W+y8brCKNnu9OrdsoAV9U+73dj5udQaGcCSPha
	7OB0LA5GPCSn3rz/15MnkkybyebSMt7fshmM9k7Tf03Hj+191OskmhAf10HiY0Rb3bd62cue4Z8Sn
	kXZz0uV60Lx1bzDWrYZefMLuSUSHUzhR2fV9ayKrQGAB7MeS/B+6X85nfE9zJarsUXjFrn//9/mj1
	ojn/QVwpLV18drKfdLCFWGBMmQ/o2L2CyhN0JkeF5jtaFsL/70Ke+ftqjYMau+vRxk5gSpDwfxN+3
	PYVgk7/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRZV1-004Rdl-KU; Tue, 08 Mar 2022 13:03:35 +0000
Received: from smtprz14.163.net ([106.3.154.247] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRZUx-004Rck-Uy
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 13:03:34 +0000
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
 by freemail02.tom.com (Postfix) with ESMTP id 624C1B00D3F
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 21:03:28 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
 by my-app02 (TOM SMTP Server) with SMTP ID 1055817587
 for <linux-nvme@lists.infradead.org>;
 Tue, 08 Mar 2022 21:03:28 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
 by freemail02.tom.com (Postfix) with ESMTP id 550BFB00D38
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 21:03:25 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
 t=1646744608; bh=BwJ+5quvHMWTci0mC33vVMP7HVey1Hn1WFiQ5Ovu7QA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ll+zPpn2OfUR9p0uvKDlDba2wHKrzE102C+jM+zxPCrbwwRORZ4pdhScfcoJGjQH/
 tMRaSliXE54mLy12+GFyLES0yWt971/YGvxE0L7J+cJ6zK5+l3as+GiX8GAAhbKwe0
 2shDzft0YDAXIcinDyPLVCNJ7QT0KCw0dS4Q9rZs=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
 by antispam1.tom.com (Postfix) with ESMTP id 52E47D415B2
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 21:03:25 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
 by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dmii8XDxoK2Y for <linux-nvme@lists.infradead.org>;
 Tue,  8 Mar 2022 21:03:24 +0800 (CST)
Received: from localhost (unknown [101.93.196.13])
 by antispam1.tom.com (Postfix) with ESMTPA id 77F9DD41599;
 Tue,  8 Mar 2022 21:03:21 +0800 (CST)
Date: Tue, 8 Mar 2022 21:03:20 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH 0/2] NVMe_over_TCP: support specifying the
 congestion-control
Message-ID: <20220308210320.000013ca@tom.com>
In-Reply-To: <20220304092754.2721-1-sunmingbao@tom.com>
References: <20220304092754.2721-1-sunmingbao@tom.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_050332_370797_49EEB7A9 
X-CRM114-Status: UNSURE (   9.28  )
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

I feel that I'd better address this a little bit more to express the
meaning behind this feature.

You know, InfiniBand/RoCE provides NVMe-oF a lossless network
environment (that is zero packet loss), which is a great advantage
to performance.

In contrast, 'TCP/IP + ethernet' is often used as a lossy network
environment (packet dropping often occurs).=20
And once packet dropping occurs, timeout-retransmission would be
triggered. But once timeout-retransmission was triggered, it=E2=80=99s a gr=
eat
damage to the performance.

So although NVMe/TCP may have a bandwidth competitive to that of
NVMe/RDMA, but the packet dropping of the former is a flaw to
its performance.

However, with the combination of the following conditions, NVMe/TCP
can almost be as competitive as NVMe/RDMA in the data center.

  - Ethernet NICs supporting QoS configuration (support mapping TOS/DSCP
    in IP header into priority, support PFC)

  - Ethernet Switches supporting ECN marking, supporting adjusting
    buffer size of each priority.

  - NVMe/TCP supports specifying the tos for its TCP traffic
    (already implemented)

  - NVMe/TCP supports specifying dctcp as the congestion-control of its
    TCP sockets (the work of this feature)

So this feature is the last item from the software aspect to form up the
above combination.


