Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB2CC4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Nov 2022 12:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:MIME-Version:Content-Type:Message-ID:Date:Subject:
	CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=lW33IeClMOms7q07PqtYJL4/p7p7WXeMBOLnPkvtdwk=; b=kssoyiMw4HdBhBz7Itt4sDTsZS
	ai+4vLflVvdo+4ND7+oyJx6JN/df8n00GS0Sr/FcbQpFGzYwI5GBZQAE2NSZ08mOP08+u0LMz9X5z
	pmsceqwxu0eeHDmJqIsbun3YbyU637NxXP38bsSF217Rq8S0l39NJYO/emq+U/EUUOvpdPAZQbKh6
	S3dpZ4Z3d3mHaJXKDXDsXHuRqEndeb3lkQLBhgUM+4/SmTimGRGRY1toNwwp2+ir/KJkY/BT17zB0
	n6Ns/gFP0LpuyR+Mo/NpGD6uzr7sQZ6XgTtubEmUV4/mWwDhFGGiHtfpbJXZUBZfaZEg8KSc75aFw
	DwpsU+Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqZNi-00HJpd-T4; Thu, 03 Nov 2022 12:31:38 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqZNc-00HJoI-H4
	for linux-nvme@lists.infradead.org; Thu, 03 Nov 2022 12:31:36 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221103123120euoutp0122afe4fa15fbe4f8f0ebc71d2eb185d1~kEwaHPR5l0853908539euoutp01r
	for <linux-nvme@lists.infradead.org>; Thu,  3 Nov 2022 12:31:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221103123120euoutp0122afe4fa15fbe4f8f0ebc71d2eb185d1~kEwaHPR5l0853908539euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1667478680;
	bh=lW33IeClMOms7q07PqtYJL4/p7p7WXeMBOLnPkvtdwk=;
	h=From:To:CC:Subject:Date:References:From;
	b=dwrQ63XPGDvdn+xTiKfwGWNK2FDfpQEj9fUdn3rldyjqWwrJRNCPqCc3dMXGQjxWJ
	 y9sYG1uttBYslOAJC+rZRq9rwQEvTSpCcEqem48lug4Zzl0IZiEe59RyHrYIyCJMfA
	 c4PM5xi1Xi8lfmzRsezrHL+jHUvrbsTfBpMq45l0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221103123120eucas1p10db56cf1984a2d5d460d154b8a653582~kEwZn62TD2452924529eucas1p1x;
	Thu,  3 Nov 2022 12:31:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id CE.24.29727.894B3636; Thu,  3
	Nov 2022 12:31:20 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221103123119eucas1p12e3ebbdff4e72cb73e5fc027b1de8549~kEwZNSBJe0943309433eucas1p1I;
	Thu,  3 Nov 2022 12:31:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221103123119eusmtrp282e947ec5aac98afee352b72e9e30c04~kEwZMhVj-2873828738eusmtrp2g;
	Thu,  3 Nov 2022 12:31:19 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-07-6363b49830eb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 82.9D.10862.794B3636; Thu,  3
	Nov 2022 12:31:19 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221103123119eusmtip258a27fdf2e2181011d3a14de97a31baf~kEwY-ZpOZ2051720517eusmtip2U;
	Thu,  3 Nov 2022 12:31:19 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 3 Nov 2022 12:31:18 +0000
From: Joel Granados <j.granados@samsung.com>
To: <sagi@grimberg.me>, <hch@lst.de>, <kbusch@kernel.org>
CC: <gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>, Joel Granados
	<j.granados@samsung.com>
Subject: [PATCH 0/1] nvme : Add ioctl to query nvme device attributes
Date: Thu, 3 Nov 2022 13:27:45 +0100
Message-ID: <20221103122746.3599480-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djPc7oztiQnG7zp4LBYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRXDYpqTmZZalF+nYJXBlHNtxg
	L/jOX9G06hJjA+Ns3i5GTg4JAROJy88+MYLYQgIrGCWW7wGyuYDsL4wSNy7eYoVIfGaUOLbN
	Fqbhzc097BBFyxkl7hydwQbhABWd27GPCaJjE6PE0vtg3WwCOhLn39xh7mLk4BARsJR4/CkV
	JMwskCbxvvc4O0hYWMBV4sVzH5Awi4CKREdjDwuIzStgK3F/yUI2iL3yEm3XpzOClDMLaEqs
	36UPUSIocXLmExaIifISzVtnM0OUK0psmfOdFcKuldjbfADsZAmBAxwS3X2b2EDmSAi4SLzf
	4AVRIyzx6vgWdghbRuL/zvlMEHa2xM4pu6BmFkjMOjkVqtVaou9MDkTYUaJj+jp2iDCfxI23
	ghDX8ElM2jadGSLMK9HRJgRRrSaxo2kr4wRG5VkIr8xC8sosJK8sYGRexSieWlqcm55abJiX
	Wq5XnJhbXJqXrpecn7uJEZg2Tv87/mkH49xXH/UOMTJxMB5ilOBgVhLhrT8bnSzEm5JYWZVa
	lB9fVJqTWnyIUZqDRUmcl22GVrKQQHpiSWp2ampBahFMlomDU6qBqesru3/af95p1dP++NTP
	kLux3ucqG9dl/oMPWVxSny+ceaTB3XRRS08d31JlyatMkuuL2ePkL3C4xTXWOIn+3sXx0fOk
	lV/83OlTIqW2WkZE5mev7ix98e/LS4m8F8csbebs198RvLHmWPFU/+0pbV+uvJMRCi9m8UpL
	aguZ46xyTkiyiv9KS3PE17j1ovtvnrD5rG1sG8f1NjZbiCt1xRUxn9numd/nmLU+V165xIhP
	hCVccHLLjGW97qxGO10PzP7DoH5Stu5P3Cor28OGXx7daTwxRUYvXLHgpF3Ym/kaG3ZdNI28
	oy+7PPZRybf/yjNqYr4aV3K21Ul83rzx8tN7fSc07ZtiUn92rGpWYinOSDTUYi4qTgQAdyqg
	MYoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42I5/e/4Pd3pW5KTDXq2aVmsXH2UyWLSoWuM
	FvOXPWW3WPf6PYsDi8f5extZPDat6mTz2Lyk3mP3zQa2AJYoPZui/NKSVIWM/OISW6VoQwsj
	PUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwjG26wF3znr2hadYmxgXE2bxcjJ4eE
	gInEm5t72LsYuTiEBJYySpy61cgEkZCR+HTlIzuELSzx51oXG0TRR0aJtseNrBDOJkaJ1U9b
	2UCq2AR0JM6/ucPcxcjBISJgKfH4UypImFkgTeJ973F2kLCwgKvEi+c+IGEWARWJjsYeFhCb
	V8BW4v6ShWwQu+Ql2q5PZwQpZxbQlFi/Sx+iRFDi5MwnLBAT5SWat85mhihXlNgy5zsrhF0r
	0fnqNNsERqFZCN2zkHTPQtK9gJF5FaNIamlxbnpusZFecWJucWleul5yfu4mRmC8bDv2c8sO
	xpWvPuodYmTiYDzEKMHBrCTCW382OlmINyWxsiq1KD++qDQntfgQoynQNxOZpUST84ERm1cS
	b2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwOQSsrimQFOTda7f9WI5
	49XfWx7u1wm9e1Xz6GSzC9vez95x7HHhQfY7P07+L/3762hz7My1D7dcOjBjdWnWC6slTlO5
	lngUb+1/KMhw6FpbjNC0BX1b7GLn7jx/1O/j+7P2vgKB956uEEhumauWO/teVmHsjI/R6gff
	RHatsJKbd5/lkJP59EO8ao5vphgs39a46cJnu4P5z1Z/mP8r7qqpZZaXUtOxT4/Lf+kUOjAG
	8z1bJsF/+233dsdljxx3ul5dfOeY8tmNB5xkd7ybtbLIdKN09xHd33POnU6dpL/8iXZoR5Rk
	6oNbcj3vJWYXKrj9EaxxqO29t8Tp0q3IR9v8Gxpz2K/N3xj5YcXDHyFXXyuxFGckGmoxFxUn
	AgBNoyHNIAMAAA==
X-CMS-MailID: 20221103123119eucas1p12e3ebbdff4e72cb73e5fc027b1de8549
X-Msg-Generator: CA
X-RootMTR: 20221103123119eucas1p12e3ebbdff4e72cb73e5fc027b1de8549
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221103123119eucas1p12e3ebbdff4e72cb73e5fc027b1de8549
References: <CGME20221103123119eucas1p12e3ebbdff4e72cb73e5fc027b1de8549@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221103_053133_995166_C6971D1D 
X-CRM114-Status: GOOD (  13.63  )
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

Joel Granados (1):
  nvme : Add ioctl to query nvme attributes

 drivers/nvme/host/core.c        |  5 ++-
 drivers/nvme/host/ioctl.c       | 57 +++++++++++++++++++++++++
 drivers/nvme/host/nvme.h        | 11 +++++
 include/uapi/linux/nvme_ioctl.h | 74 +++++++++++++++++++++++++++++++++
 4 files changed, 146 insertions(+), 1 deletion(-)

-- 
2.30.2


