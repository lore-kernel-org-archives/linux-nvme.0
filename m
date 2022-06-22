Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40507C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 08:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:MIME-Version:Content-Type:Message-ID:Date:Subject:
	CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=MmihwmOTyXvlrD0efFf+lxQN3G5RZjx22J4qKk21eUw=; b=vLmcyJDeB2yHkWC7jAvF3QNcPJ
	UcesAUcslLuqZE2pPGcTNnAmjP1qQOUbKThcCfwx+yY8rFWLpsOWHpclqsEZwr0AkfTNzg59vmojt
	6PcW/cxIs83lwfMgJQSBj7q5kS+Cb5OzgDgjJ+4pquhggkCU00wqP248vQNk7IkzDkmqBl+IlOeyi
	M9UgHFbOtGKqwUnGdbsW0RMrrOuC15jObTMYvYEZiBGm/g2NB7B6jioOd9h1JKw0Moksc7oj/GwjZ
	TWwyEwi2BvzAFzpkgZ2RU8jD+yLWU2S9PkRtiA5YXiW1HRh5TS6F/XB9BIg8xfpEMbwTkLVRtR/YO
	AIRVNJEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3w5D-009MGH-5j; Wed, 22 Jun 2022 08:51:31 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3w59-009MFZ-LU
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 08:51:29 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220622085123euoutp013f9fab70e1c46fb1de6d677b97b2c3b2~65UHIShl-0657406574euoutp014
	for <linux-nvme@lists.infradead.org>; Wed, 22 Jun 2022 08:51:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220622085123euoutp013f9fab70e1c46fb1de6d677b97b2c3b2~65UHIShl-0657406574euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655887883;
	bh=MmihwmOTyXvlrD0efFf+lxQN3G5RZjx22J4qKk21eUw=;
	h=From:To:CC:Subject:Date:References:From;
	b=qTgLSEwieyHY9d5ZQ30YAphx7fBvZ3RrLyOsHHGF77GkGMg9zRoS15i3J2rRBTXcD
	 yoPrQsfec6T/C575F4wkzh6KOxgM+kQgPqCk6q+r01SDZJkRZG+nyc3iwH7WDp2x0t
	 7DGT7e2fybAZ5CmcfvnqeEL+iVek4yrvUJ/ukzro=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220622085123eucas1p1c211ff5adf02ce5bdac60e5c080311d4~65UG_J6iC2639126391eucas1p1G;
	Wed, 22 Jun 2022 08:51:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 17.B8.10067.B08D2B26; Wed, 22
	Jun 2022 09:51:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220622085123eucas1p25f724850a5397fa90a0e26eb4d5af92f~65UGo01l71041110411eucas1p2y;
	Wed, 22 Jun 2022 08:51:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220622085123eusmtrp2e2c778d8d71f2543e9850eef14f2cadb~65UGoCdqV0824208242eusmtrp2o;
	Wed, 22 Jun 2022 08:51:23 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-c4-62b2d80b3413
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 3C.A6.09095.B08D2B26; Wed, 22
	Jun 2022 09:51:23 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220622085123eusmtip27df81f7032ad83b74c7ebcf32c550ab0~65UGfUiqO0387003870eusmtip2G;
	Wed, 22 Jun 2022 08:51:23 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 22 Jun 2022 09:51:22 +0100
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>
Subject: [PATCH 0/1] nvme: Remove unused enum constants in nvme.h
Date: Wed, 22 Jun 2022 10:48:58 +0200
Message-ID: <20220622084859.1937878-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7djPc7rcNzYlGRxslrVYufook8WkQ9cY
	LeYve8ruwOyxaVUnm8fmJfUeu282sAUwR3HZpKTmZJalFunbJXBldO02LejmqJj//xhLA+Ml
	ti5GDg4JAROJfw+Nuxi5OIQEVjBKzH12lg3C+cIo0fF4ESOE85lR4tK37cxdjJxgHU/nTYOq
	Ws4osW3zX3a4qtcnd0NlNjNKLHj6iAmkhU1AR+L8mzvMIAtFBFQl9rXYgoSZBVQktt+4DlYi
	LOAoselQC9hNLEAlh5p0QcK8ArYSr/7PYoFYLC/Rdn06I0gJs4CmxPpd+hAlghInZz5hgZgo
	L9G8dTbUnYoSW+Z8Z4WwayX2Nh8AO1NCYCGHRMvCN4wQCReJr1/+sUPYwhKvjm+BsmUk/u+c
	zwRhZ0vsnLILamiBxKyTU6FBZy3RdyYHIuwosXdtHytEmE/ixltBiHP4JCZtm84MEeaV6GgT
	gqhWk9jRtJVxAqPyLIRfZiH5ZRaSXxYwMq9iFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQI
	TBOn/x3/soNx+auPeocYmTgYDzFKcDArifDacG9IEuJNSaysSi3Kjy8qzUktPsQozcGiJM6b
	nLkhUUggPbEkNTs1tSC1CCbLxMEp1cBU+itiW8BMoTXx2+WnfNywbUPe4/zVqkI/mQt4v0/R
	k5u9sPl+Kec69uNq574eTD/58vmNH5I5tuoWs/5oH935KMvw0i+mOn/dk93Xc89OzeuV93db
	aH7WStkmTCVgwuafmZtefVy/UWyGtJ+LXRETi+NK2/MZu3s2H9i54q2px46H8z12X/49c5GH
	Zyx/jcR7fq6/x0Vuq32/93u9Wu/mZc/1lm+sWH7y31Hlfrcn15dmFDIVW852+51/0S+0qjba
	q5D9u5/ja9/lszukAyRW2+wOFdcNN154cHsD44Mj97a/rKhKeBtZX/3aaIGUb6UUr1x20dGe
	1lv32qrWshfvivn6i/mt7c3/F2VnzC2wUmIpzkg01GIuKk4EAGZ3Pf6CAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e/4PV3uG5uSDB4fY7NYufook8WkQ9cY
	LeYve8ruwOyxaVUnm8fmJfUeu282sAUwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
	m8daGZkq6dvZpKTmZJalFunbJehldO02LejmqJj//xhLA+Mlti5GTg4JAROJp/OmgdlCAksZ
	Je69CISIy0h8uvKRHcIWlvhzrQuohguo5iOjxJ+ta6GczYwSN069YgapYhPQkTj/5g6QzcEh
	IqAqsa/FFiTMLKAisf3GdSYQW1jAUWLToRY2kBIWoJJDTbogYV4BW4lX/2exQOySl2i7Pp0R
	pIRZQFNi/S59iBJBiZMzn7BATJSXaN46mxmiXFFiy5zvrBB2rUTnq9NsExiFZiF0z0LSPQtJ
	9wJG5lWMIqmlxbnpucWGesWJucWleel6yfm5mxiBcbHt2M/NOxjnvfqod4iRiYPxEKMEB7OS
	CK8N94YkId6UxMqq1KL8+KLSnNTiQ4ymQM9MZJYSTc4HRmZeSbyhmYGpoYmZpYGppZmxkjiv
	Z0FHopBAemJJanZqakFqEUwfEwenVAOT4iFLZ9kJFTk5lzbc6GdmNPl2WffjwV9FnjdTmaNC
	dkxx5XpbddZW4VnU8d3KjP8W8vx1/zn3jnAq5+Or2qXmr3v/cOmscp32RK1smuXJ9s973U9W
	bmX97qfy/6bCX8P1zw9J7A+6dkGvR2H/ZqNKY0aJJ/Ys1TJVfGsP6assPeleUl5uU/otN/Zp
	uH9QwFwbqzinWPukxh2sjgEljEmnuj8yHPN512dZ5PHvG//7JXc2xEyTrEvYH+e202O7u2Hr
	8yfaRySmK864YGG4W1vu0/r8BTlHpj+0kKwuLeOsSOH1D5lycYpxyLaKRfVrA19J6Pjrrcwr
	+RnN+L7Y1CyNR/l70Ndqxh+/r7+w2aLEUpyRaKjFXFScCAB/vhGhFAMAAA==
X-CMS-MailID: 20220622085123eucas1p25f724850a5397fa90a0e26eb4d5af92f
X-Msg-Generator: CA
X-RootMTR: 20220622085123eucas1p25f724850a5397fa90a0e26eb4d5af92f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220622085123eucas1p25f724850a5397fa90a0e26eb4d5af92f
References: <CGME20220622085123eucas1p25f724850a5397fa90a0e26eb4d5af92f@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_015128_168419_E4A5EEA1 
X-CRM114-Status: GOOD (  12.53  )
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

While working in include/linux/nvme.h, I noticed that there are enum
constants that are not being used by the kernel. They are also not included
in any UAPI directory. These variables were synced to keep up with nvme-cli
in 48c9e85b2346 ("nvme: resync include/linux/nvme.h with nvmecli"). Since
nvme-cli now uses libnvme which defines all the structures within itself,
there is no need to synchronize any longer.

There have been discussions to introduce functionality into the kernel that
use some of these variables like in
https://lore.kernel.org/all/1558278418-5702-1-git-send-email-akinobu.mita@gmail.com/
but to my knowledge they have not made it upstream.

This patch removes the enumerations that are not being used within the
kernel.

Please get back to me if I have missed something and these variables are
indeed being used.

Best

Joel Granados (1):
  nvme: Remove unused enum constants

 include/linux/nvme.h | 32 --------------------------------
 1 file changed, 32 deletions(-)

-- 
2.30.2


