Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382E5C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Mar 2022 02:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zds00GOn8tHFSRvTLh6GQC0CKk9En23eaRKAd6OHkM8=; b=YykzEzbwdUJZQ3inx5f53sYlad
	S58XGypWvFOf/+sQOFYYMTeHWayFfm6bfxmVUXOaHlKOj++G/K/jRaVYZKl86H7cm6eVp0lFl2XpU
	es4OxGorLccDIjf5wqzcyMzZASXCHaMOq2LjVHWGqSjjXN3ufXKi6BFvP+JJ1/bao8zYg0VLJ1TyA
	NpxR3NKcpXnuQARiuCreBTSqzULXjg6D03JeI0x+p12ZP9gEVXoThBVkOCI6q6ynckIYR39djDvCh
	l/Bop7FnH+zDDZCQAEeFOTcFVhFP9xhFGazXnEyNlja+QMKF+u26JBFFtdQho7jqi7qbY/H0qup3y
	Zb/v1D3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nZ1uE-00AmFS-NY; Tue, 29 Mar 2022 02:48:26 +0000
Received: from smtprz02.163.net ([106.3.154.235] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZ1uA-00AmDX-Fi
 for linux-nvme@lists.infradead.org; Tue, 29 Mar 2022 02:48:24 +0000
Received: from localhost (localhost [127.0.0.1])
 by vip-app02.163.net (Postfix) with ESMTP id 0F840440114
 for <linux-nvme@lists.infradead.org>; Tue, 29 Mar 2022 10:48:13 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1648522093; bh=UxIN0gCQWDCPxHwAlV5GfBTdHsvgwdbGdcBxlAMphuU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tldl+zM9wCHeoSbbbGREhe+8sTnhTcn8wFE4ZeUS+AlCVBKpTdibyHmQIzdvntJWm
 MHSQsYTEnKPK9Fwqzws6ChlYDEjboiqEarPf6zbljnOgWk60GrkJf5Hr07YbMg/2h1
 4LSOaqdhF4vwSWvpjTxLWqdsLzyF43rulM2mjUfk=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
 by localhost (TOM SMTP Server) with SMTP ID 1818385158
 for <linux-nvme@lists.infradead.org>;
 Tue, 29 Mar 2022 10:48:13 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1648522093; bh=UxIN0gCQWDCPxHwAlV5GfBTdHsvgwdbGdcBxlAMphuU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tldl+zM9wCHeoSbbbGREhe+8sTnhTcn8wFE4ZeUS+AlCVBKpTdibyHmQIzdvntJWm
 MHSQsYTEnKPK9Fwqzws6ChlYDEjboiqEarPf6zbljnOgWk60GrkJf5Hr07YbMg/2h1
 4LSOaqdhF4vwSWvpjTxLWqdsLzyF43rulM2mjUfk=
Received: from localhost (unknown [101.93.196.13])
 by antispamvip.163.net (Postfix) with ESMTPA id E79AA15411AE;
 Tue, 29 Mar 2022 10:48:06 +0800 (CST)
Date: Tue, 29 Mar 2022 10:48:06 +0800
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
Message-ID: <20220329104806.00000126@tom.com>
In-Reply-To: <b7b5106a-9c0d-db49-00ab-234756955de8@grimberg.me>
References: <20220311103414.8255-1-sunmingbao@tom.com>
 <20220311103414.8255-2-sunmingbao@tom.com>
 <7121e4be-0e25-dd5f-9d29-0fb02cdbe8de@grimberg.me>
 <20220325201123.00002f28@tom.com>
 <b7b5106a-9c0d-db49-00ab-234756955de8@grimberg.me>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_194822_729631_CFA26A02 
X-CRM114-Status: GOOD (  16.01  )
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

> As I said, TCP can be tuned in various ways, congestion being just one
> of them. I'm sure you can find a workload where rmem/wmem will make
> a difference.

agree.
but the difference for the knob of rmem/wmem is:
we could enlarge rmem/wmem for NVMe/TCP via sysctl,
and it would not bring downside to any other sockets whose
rmem/wmem are not explicitly specified.

> In addition, based on my knowledge, application specific TCP level
> tuning (like congestion) is not really a common thing to do. So why in
> nvme-tcp?
>=20
> So to me at least, it is not clear why we should add it to the driver.

As mentioned in the commit message, though we can specify the
congestion-control of NVMe_over_TCP via sysctl or writing
'/proc/sys/net/ipv4/tcp_congestion_control', but this also
changes the congestion-control of all the future TCP sockets on
the same host that have not been explicitly assigned the
congestion-control, thus bringing potential impaction on their
performance.

For example:

A server in a data-center with the following 2 NICs:

    - NIC_fron-end, for interacting with clients through WAN
      (high latency, ms-level)

    - NIC_back-end, for interacting with NVMe/TCP target through LAN
      (low latency, ECN-enabled, ideal for dctcp)

This server interacts with clients (handling requests) via the fron-end
network and accesses the NVMe/TCP storage via the back-end network.
This is a normal use case, right?

For the client devices, we can=E2=80=99t determine their congestion-control.
But normally it=E2=80=99s cubic by default (per the CONFIG_DEFAULT_TCP_CONG=
).
So if we change the default congestion control on the server to dctcp
on behalf of the NVMe/TCP traffic of the LAN side, it could at the
same time change the congestion-control of the front-end sockets
to dctcp while the congestion-control of the client-side is cubic.
So this is an unexpected scenario.

In addition, distributed storage products like the following also have
the above problem:

    - The product consists of a cluster of servers.

    - Each server serves clients via its front-end NIC
     (WAN, high latency).

    - All servers interact with each other via NVMe/TCP via back-end NIC
     (LAN, low latency, ECN-enabled, ideal for dctcp).

