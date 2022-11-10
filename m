Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE9AC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Nov 2022 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:MIME-Version:Content-Type:Message-ID:Date:Subject:
	CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=cYXe/+ZlY5MVeM4C/vm+5HmmqqKUz31aAc6WZh9Xtq4=; b=oo3Wxqw2fo/A18F7r965ZXAWm5
	/yVG/A8AGqmjpB9jAkfRJ74y7Oa6SgK6Dh9m/NaeKVPm2wHhHj6G0jysRZ7kH7McIwefonqTxecfn
	ZVinWjV9VkE2jaFimJ6/JrCg8uwic++GApkVMby6vTgOK5Hpy1iIIQyrnf1I02/Qv1e+1RrZusTYb
	wqyedH133iARrY0V0nvWKU1MRCM52WJZ+G7STE0WvUsfX4mDHqt+f6U+GKzjgjVLRXcWrbRJr3hFr
	FfH+FtuTnUPZ9TgQdYzmu791EtRHL5yKzc3HiHTbl2aTaGtzUTqd5fnUwR5p1qg4HEtkeCIk3RACZ
	BCTHyASQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ot5lA-005MxF-B4; Thu, 10 Nov 2022 11:30:16 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ot5Qf-005EMC-SH
	for linux-nvme@lists.infradead.org; Thu, 10 Nov 2022 11:09:12 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221110110858euoutp019e78fec36f367293510cf7f7384d78d5~mNJfWuCSO2317523175euoutp01O
	for <linux-nvme@lists.infradead.org>; Thu, 10 Nov 2022 11:08:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221110110858euoutp019e78fec36f367293510cf7f7384d78d5~mNJfWuCSO2317523175euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1668078538;
	bh=cYXe/+ZlY5MVeM4C/vm+5HmmqqKUz31aAc6WZh9Xtq4=;
	h=From:To:CC:Subject:Date:References:From;
	b=gTR56PQvZlDi9zpVD5xmH6z47AV3cez/lEsjPdXnQlGhrA+nExOLdPnvYUaVAF0JQ
	 5bVgofIRv3Un8jDFl0yT6VcRtjHe8owVLIjAxk6y82U+I5oNmjtuaGuZhV0JAKbJH6
	 LSJTBmhT9vzqtR7gnDFy6OKb0TCFRXp/I/YdSb7k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221110110858eucas1p27374ff9adf69027aa28acbe01b82b2d1~mNJfDqq9Q1437514375eucas1p2r;
	Thu, 10 Nov 2022 11:08:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 6F.8B.09561.ACBDC636; Thu, 10
	Nov 2022 11:08:58 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221110110857eucas1p220b898666956f5fbccce6bcd451f2e3a~mNJeko9ma1658916589eucas1p2g;
	Thu, 10 Nov 2022 11:08:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221110110857eusmtrp284a8dabf0f290fa3d786428a25b1b2e4~mNJej456c2576225762eusmtrp2r;
	Thu, 10 Nov 2022 11:08:57 +0000 (GMT)
X-AuditID: cbfec7f2-0b3ff70000002559-b9-636cdbca3747
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C3.01.08916.9CBDC636; Thu, 10
	Nov 2022 11:08:57 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221110110857eusmtip25b16fe322232bc85ea3860acb155abd8~mNJeZzFeu1105311053eusmtip2r;
	Thu, 10 Nov 2022 11:08:57 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 10 Nov 2022 11:08:57 +0000
From: Joel Granados <j.granados@samsung.com>
To: <sagi@grimberg.me>, <hch@lst.de>, <kbusch@kernel.org>,
	<chaitanyak@nvidia.com>
CC: <gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>, Joel Granados
	<j.granados@samsung.com>
Subject: [PATCH v2 0/1] nvme : Add ioctl to query nvme device attributes
Date: Thu, 10 Nov 2022 12:05:21 +0100
Message-ID: <20221110110522.1626637-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduznOd1Tt3OSDU7NELJ4f/Axq8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGsVlk5Kak1mW
	WqRvl8CV8f7sZuaCFwIV8zeqNzB+4O1i5OSQEDCReDdpLWMXIxeHkMAKRomTV/8zQzhfGCWe
	fPrOCuF8ZpQ4PX8PC0xLw9I9UInljBJdU/6ww1VtvPEfKrOZUeLl5iOMIC1sAjoS59/cYQax
	RQRCJD5u+c0KYjMLpEm87z3ODmILC3hIHH7QChZnEVCV+PBlAlCcg4NXwFbiwyUHiM3yEm3X
	pzOChJkFNCXW79IHCfMKCEqcnPmEBWKivETz1tnMEOWKElvmfGeFsGsl9jYfYIewj3BIbJnn
	BzJGQsBF4vt8Q4iwsMSr41ugSmQk/u+czwRhZ0vsnLILamSBxKyTU9kgWq0l+s7kQIQdJXqW
	72SBCPNJ3HgrCHEMn8SkbdOZIcK8Eh1tQhDVahI7mrYyTmBUnoXwySwkn8xC8skCRuZVjOKp
	pcW56anFhnmp5XrFibnFpXnpesn5uZsYgenk9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRFebo3s
	ZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8bDO0koUE0hNLUrNTUwtSi2CyTBycUg1MAn/azaxm
	eXBYXDnQvuZO/Gat8AO/7dO/8ecru56dY/Rt+t9ci3+Mu6barLZckqWr+GbVqf87jvfqW85V
	PBa5bI3FryP3owtXTL6xnaHUwiTmX0nrpJCkMz5/5HecneOY/uDik7kXwuZMWH4oljvyQ7q3
	KJ+7SNB5dnFxebXK/8EHnD9+leX6dvHsVOaDRk4763yMLzOa2fWYTtb20btRoBhr0BDQ2Lpi
	e37wZ8kVx5aEc96/ouWU3L1cZt9l2dT2gK6El9vKZ558d4DvTqTRBY3QO3ZS+UJZs5ieizHO
	jeOzOZUR9Z+PT3qbwZbd7OFaMs5t+1M3qBxSzblwx/MFh+6j74Z71r++/UtezuuDEktxRqKh
	FnNRcSIA/LwzIZYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7onb+ckG/x6amjx/uBjVouVq48y
	WUw6dI3RYv6yp+wW616/Z3Fg9Th/byOLx6ZVnWwem5fUe+y+2cDm0dv8ji2ANUrPpii/tCRV
	ISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4/3ZzcwFLwQq5m9U
	b2D8wNvFyMkhIWAi0bB0DyuILSSwlFHizWdtiLiMxKcrH9khbGGJP9e62LoYuYBqPjJKzPz5
	mh3C2cwo8XrNLbAqNgEdifNv7jCD2CICIRIft/wGm8oskCbxvvc4WI2wgIfE4QetYHEWAVWJ
	D18mAMU5OHgFbCU+XHKAWCYv0XZ9OiNImFlAU2L9Ln2QMK+AoMTJmU9YICbKSzRvnc0MUa4o
	sWXOd1YIu1ai89VptgmMQrMQumch6Z6FpHsBI/MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2M
	wAjaduzn5h2M81591DvEyMTBeIhRgoNZSYSXWyM7WYg3JbGyKrUoP76oNCe1+BCjKdAzE5ml
	RJPzgTGcVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAVJ7Xml3Y
	mL9snUrW7JOJX9bpvGeadCDmfre06OS6xwaCPDruBm3+076wXPabv1Rq17HDOkGTDte/rb96
	6sA07QcabuWecu1XzBf/rO1Jfu6p3M3j/lLQa8raJ62snv//7XX+V+fKfVT8/bPenn2aeUKr
	l3DG5D8zfSVjZxj96JxdyHYGgzZ2+xC582oyv00ey+WfOMpiMeXQnJ9zd1+p/Hepwy2q2u8C
	r+4C2ZkqzNtUORROte9+olWycfX1dctlZOddUSoVWh0uraTkL2fEU/2iy+SGuWVg9oRHctuF
	ZaR+LHl2uGCiTcP256ynWgxfG5su0m94xhrkV3M/Vdj7cKSsssjPgM6ZlQfr5kYrsRRnJBpq
	MRcVJwIAhGpjCikDAAA=
X-CMS-MailID: 20221110110857eucas1p220b898666956f5fbccce6bcd451f2e3a
X-Msg-Generator: CA
X-RootMTR: 20221110110857eucas1p220b898666956f5fbccce6bcd451f2e3a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221110110857eucas1p220b898666956f5fbccce6bcd451f2e3a
References: <CGME20221110110857eucas1p220b898666956f5fbccce6bcd451f2e3a@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221110_030907_387074_F7EF93D9 
X-CRM114-Status: GOOD (  14.46  )
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

What?
In this patch I add an ioctl that provides nvme controller attributes to
the user that can open the char device file. We also provide them for the
block devices for convenience.

Why?
Applications with write permissions should not need to be privileged to
write to the device. With Kanchan's latest patch
(https://lore.kernel.org/linux-nvme/20221020070205.57366-1-joshi.k@samsung.com/)
the nvme IO and identify commands in passthru now follow device
permissions; however there are still some controller attributes like
minimal data transfer size (MDTS) which need a privileged user to be
queried.

How?
I have rebased this on top of Kanchans "nvme: identify-namespace without
CAP_SYS_ADMIN"
(https://lore.kernel.org/linux-nvme/20221020070205.57366-3-joshi.k@samsung.com)
because this only makes sense if we can also do IO as unprivileged.

Added an ioctl (NVME_IOCTL_GET_ATTR) that fetches existing and new
attributes from nvme_ctrl struct. The new attributes are dmsl, vsl and wusl
from the I/O command set specific identify controller data structure in the
nvme spec.

I have made the call extensible by embedding the struct size as the first
member and using it as a version. I call copy_struct_from_user to make sure
that struct members that are unique are zeroed out.  For this I followed
in the steps of the openat2 system call [1] and the extensible ioctl for
vfio [2].  Another interesting reference for this is here
https://lwn.net/Articles/830666/

feedback is greatly appreciated :)

[1] https://github.com/torvalds/linux/commit/fddb5d430ad9
[2] https://github.com/torvalds/linux/blob/master/include/uapi/linux/vfio.h#L56

V2:
1. Changed comment from // to /**/
2. Took a call out from an if condition and assigned it to ret var.

Joel Granados (1):
  nvme : Add ioctl to query nvme attributes

 drivers/nvme/host/core.c        |  5 ++-
 drivers/nvme/host/ioctl.c       | 58 ++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h        | 11 +++++
 include/uapi/linux/nvme_ioctl.h | 74 +++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 1 deletion(-)

-- 
2.30.2


