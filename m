Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE3AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 01:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=la8M+n6yVY2tNzt2OtZpWZLCEQiw6qEsmP/hCq2zD/4=; b=5Dc7G9zS9xD+QtMU35FXA2KWBI
	lD3VvwHTP6OTOP0Mp1gJcl4byWRR+BpkqQWg5FUlF1e5spywWR4wWsEorY0Ta6jAjPVYYfVBGgphc
	KldbQZNHAb0zCmSJO1E5SY9ZLr3XgZS/PpeRD1H7FArxx3PLoiVHYYmPFgr0hL5N4MIe4KHXmjtDW
	1IqzTtIvXy5oZR2VE3SFT4EiBEengxu/8vIqC1hJgyLAWybwd4ay5NH0kCUcLnsjpNo8KXyM4VU5B
	Sv0etjtFKq3zncszDWPDaO6EoPYjwd2QuMsryvzB+UrVIx4hh4NnZ4JZCgxr+UoHZAOsAQXqX5HPH
	a84nNk6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTZbs-003ZUy-WD; Mon, 14 Mar 2022 01:34:57 +0000
Received: from smtprz01.163.net ([106.3.154.234] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTZbo-003ZTC-CG
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 01:34:54 +0000
Received: from localhost (localhost [127.0.0.1])
 by vip-app02.163.net (Postfix) with ESMTP id 8A99D4400C7
 for <linux-nvme@lists.infradead.org>; Mon, 14 Mar 2022 09:34:36 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1647221676; bh=tCwCTuNV8vbPzPftdhc6YfcqI53uXHjpEfLiz8JtAFs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qlNPI38Ru5megsySz0hlqi5dFvTo1d09355Ft149OqY9Tp8XbttvFcby18ciqCCdB
 qPut456z4j2INeNoL+Fb/c9tJA9y9mnpwEMWJJsSoR/WhZHj2xOoxX89BMAI7lP7ZW
 jtiH7M/pbQ9Bqj+xichUzNuZFsxsvGmTV+yRynVg=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
 by localhost (TOM SMTP Server) with SMTP ID -741027541
 for <linux-nvme@lists.infradead.org>;
 Mon, 14 Mar 2022 09:34:36 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1647221676; bh=tCwCTuNV8vbPzPftdhc6YfcqI53uXHjpEfLiz8JtAFs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qlNPI38Ru5megsySz0hlqi5dFvTo1d09355Ft149OqY9Tp8XbttvFcby18ciqCCdB
 qPut456z4j2INeNoL+Fb/c9tJA9y9mnpwEMWJJsSoR/WhZHj2xOoxX89BMAI7lP7ZW
 jtiH7M/pbQ9Bqj+xichUzNuZFsxsvGmTV+yRynVg=
Received: from localhost (unknown [101.93.196.13])
 by antispamvip.163.net (Postfix) with ESMTPA id 96EAA154146C;
 Mon, 14 Mar 2022 09:34:29 +0800 (CST)
Date: Mon, 14 Mar 2022 09:34:29 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Hideaki
 YOSHIFUJI <yoshfuji@linux-ipv6.org>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/3] nvme-tcp: support specifying the congestion-control
Message-ID: <20220314093429.00005b95@tom.com>
In-Reply-To: <7121e4be-0e25-dd5f-9d29-0fb02cdbe8de@grimberg.me>
References: <20220311103414.8255-1-sunmingbao@tom.com>
 <20220311103414.8255-2-sunmingbao@tom.com>
 <7121e4be-0e25-dd5f-9d29-0fb02cdbe8de@grimberg.me>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_183452_634044_10B41F84 
X-CRM114-Status: GOOD (  10.40  )
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

Before answering the questions, I=E2=80=99d like to address the motivation
behind this patchset.

You know, InfiniBand/RoCE provides NVMe-oF a lossless network
environment (that is zero packet loss), which is a great advantage
to performance.

In contrast, 'TCP/IP + ethernet' is often used as a lossy network
environment (packet dropping often occurs).=20
And once packet dropping occurs, timeout-retransmission would be
triggered. But once timeout-retransmission was triggered, bandwidth
would drop to 0 all of a sudden. This is great damage to performance.

So although NVMe/TCP may have a bandwidth competitive to that of
NVMe/RDMA, but the packet dropping of the former is a flaw to
its performance.

However, with the combination of the following conditions, NVMe/TCP
can become much more competitive to NVMe/RDMA in the data center.

  - Ethernet NICs supporting QoS configuration (support mapping TOS/DSCP
    in IP header into priority, supporting adjusting buffer size of each
    priority, support PFC)

  - Ethernet Switches supporting ECN marking, supporting adjusting
    buffer size of each priority.

  - NVMe/TCP supports specifying the tos for its TCP traffic
    (already implemented)

  - NVMe/TCP supports specifying dctcp as the congestion-control of its
    TCP sockets (the work of this feature)

So this feature is the last item from the software aspect to form up the
above combination.

