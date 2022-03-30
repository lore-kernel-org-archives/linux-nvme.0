Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907D9C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Mar 2022 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9BlHNceObvs8svTPNkUIqkjVnr2UfFszQ94lWgxOO9U=; b=WuZCRazm3pAbby14IXzFWs1hSP
	jyAwtMkPutwtKAHeot3c55xRVHnD4SVePz4WS5blYHbKwk1fnY7b2i5KXkQd0lrbus05gOS0W1+aK
	eAsVKx96r1XQvVqljUKot7gmwKI2wRxi2iYfRKJG5cQbsEtEdvXKlkBjC78h4ibyrL4ii0sEbZnMH
	J8UOHbfeTrssV/+ZFRM4rJkf6I7hgujA4zSx8EnaWmQDDTayU/M9vFW4jeCe2NfQ186kyR/I7f7/R
	ndUUhx8rHcgqoph9ZXNt2qSsXVDQuDKursJeVBXvKXn5pb7Di09zszTw2H+z+/1Pxury2u7UbMarH
	oK2ZazVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nZSo0-00EbD9-5X; Wed, 30 Mar 2022 07:31:48 +0000
Received: from smtprz01.163.net ([106.3.154.234] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZSnt-00EbAm-Pb
 for linux-nvme@lists.infradead.org; Wed, 30 Mar 2022 07:31:43 +0000
Received: from localhost (localhost [127.0.0.1])
 by vip-app02.163.net (Postfix) with ESMTP id AF1044400FF
 for <linux-nvme@lists.infradead.org>; Wed, 30 Mar 2022 15:31:25 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1648625485; bh=NMMsM4W1Upu0QGhDq7i8xxMqcVrHRP8FulbAb4qUKvI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RRSK37blWxBsX8WXHTiB2rV2W0PL9ZU3153JEGF055Fntq6lLx8F34UizJd0NH1WJ
 gxyV5yPsXRTXP0jhD/W3P33FgVHUzNNIz5MrlxymLnmaVp7cE/A6nIL/rcCeXsTyS1
 YRvpm3MnxRbCsTYrC48S92wRkiVGNfBN+v6lItYU=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
 by localhost (TOM SMTP Server) with SMTP ID 1434490312
 for <linux-nvme@lists.infradead.org>;
 Wed, 30 Mar 2022 15:31:25 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1648625485; bh=NMMsM4W1Upu0QGhDq7i8xxMqcVrHRP8FulbAb4qUKvI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RRSK37blWxBsX8WXHTiB2rV2W0PL9ZU3153JEGF055Fntq6lLx8F34UizJd0NH1WJ
 gxyV5yPsXRTXP0jhD/W3P33FgVHUzNNIz5MrlxymLnmaVp7cE/A6nIL/rcCeXsTyS1
 YRvpm3MnxRbCsTYrC48S92wRkiVGNfBN+v6lItYU=
Received: from localhost (unknown [101.93.196.13])
 by antispamvip.163.net (Postfix) with ESMTPA id 1C5AB154209E;
 Wed, 30 Mar 2022 15:31:19 +0800 (CST)
Date: Wed, 30 Mar 2022 15:31:17 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni
 <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, "David S
 . Miller" <davem@davemloft.net>, Hideaki YOSHIFUJI
 <yoshfuji@linux-ipv6.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/3] nvme-tcp: support specifying the congestion-control
Message-ID: <20220330153117.00002565@tom.com>
In-Reply-To: <20220328213353.4aca75bd@kernel.org>
References: <20220311103414.8255-1-sunmingbao@tom.com>
 <20220311103414.8255-2-sunmingbao@tom.com>
 <7121e4be-0e25-dd5f-9d29-0fb02cdbe8de@grimberg.me>
 <20220325201123.00002f28@tom.com>
 <b7b5106a-9c0d-db49-00ab-234756955de8@grimberg.me>
 <20220329104806.00000126@tom.com>
 <20220328213353.4aca75bd@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220330_003142_037567_C346BCD7 
X-CRM114-Status: GOOD (  12.55  )
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

On Mon, 28 Mar 2022 21:33:53 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 29 Mar 2022 10:48:06 +0800 Mingbao Sun wrote:
> > A server in a data-center with the following 2 NICs:
> >=20
> >     - NIC_fron-end, for interacting with clients through WAN
> >       (high latency, ms-level)
> >=20
> >     - NIC_back-end, for interacting with NVMe/TCP target through LAN
> >       (low latency, ECN-enabled, ideal for dctcp)
> >=20
> > This server interacts with clients (handling requests) via the fron-end
> > network and accesses the NVMe/TCP storage via the back-end network.
> > This is a normal use case, right? =20
>=20
> Well, if you have clearly separated networks you can set the congestion
> control algorithm per route, right? man ip-route, search congctl.

Cool, many thanks for the education.

I verified this approach, and it did work well.
And I furtherly found the commit
=E2=80=98net: tcp: add per route congestion control=E2=80=99 which just
addresses the requirement of this scenario (separated network).

So with this approach, the requirements of our use case are
roughly satisfied.

Thanks again ^_^

