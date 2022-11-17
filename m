Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6D2C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Nov 2022 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:MIME-Version:Content-Type:Message-ID:Date:Subject:
	CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=vvwWZN186XRKAPR8uccIQGiQzpQcGOuNLMqtkq7E2o8=; b=kkV9FRjEAjYLHBnf6jVPYp9Vcy
	atfboDFCepyQrmm7ViJinJQqSk/o22y/fT1UvwsuEykBbTsLrAJs/lWzsZoGkGiakaq4n3gdyJH/G
	aqpkNyrtjlW0QtoKt0QnDs0kk/3kLXljNVyEhWBd2kZ5w7UUw1ETw706jTmbnddGWsM/Elq6f8g4C
	8Ykb8QK2ta7eOqrHPj8ZtGkjKiB1DMeY7bpICak++7FLwW+nb58kSLer9lQIlskyC0jQaUQUW8xBB
	4lBN1WJGbsC7A5DTzTtLB2cPBd9CLBqA1iUzm9O6tL2Pad4pYe62812Gy/CqG6lj3hIaMMOHkH9/k
	r+HgNPSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovfhp-00Eklg-IF; Thu, 17 Nov 2022 14:17:29 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovfhl-00EkhI-4S
	for linux-nvme@lists.infradead.org; Thu, 17 Nov 2022 14:17:28 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221117141717euoutp021f7d49495a4e542728d2a242f7a455fe~oZO6Nt3G02486724867euoutp02q
	for <linux-nvme@lists.infradead.org>; Thu, 17 Nov 2022 14:17:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221117141717euoutp021f7d49495a4e542728d2a242f7a455fe~oZO6Nt3G02486724867euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1668694637;
	bh=vvwWZN186XRKAPR8uccIQGiQzpQcGOuNLMqtkq7E2o8=;
	h=From:To:CC:Subject:Date:References:From;
	b=iNykukA9ukYDsqfnBKmn69mWKIREF+rrpjFIsLOuMpcko6CU3aC4R7CVi6LbMNsDg
	 UxyjAZDmrfWxqJ6DBifiLFji5Suf3dlpcap15edHFU0V5aYZiJ8U5bW6QDfiDJtiej
	 iRm9c6ydlyyF8PhmLCQ1sIJLtdSJ1PAtinNsTyEQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221117141717eucas1p1817f7b6277d2e9248d32f915054a5720~oZO6EpsQw0096100961eucas1p1R;
	Thu, 17 Nov 2022 14:17:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id D5.52.09549.D6246736; Thu, 17
	Nov 2022 14:17:17 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221117141717eucas1p22722572ae0898b65a872658d5a4ef14e~oZO5xn2Y_2434124341eucas1p2o;
	Thu, 17 Nov 2022 14:17:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221117141717eusmtrp2fb9d2af3ba837aa6b2726390ae0a8f6b~oZO5xBTez2915429154eusmtrp29;
	Thu, 17 Nov 2022 14:17:17 +0000 (GMT)
X-AuditID: cbfec7f5-f5dff7000000254d-69-6376426d99fe
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 7B.E5.09026.D6246736; Thu, 17
	Nov 2022 14:17:17 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221117141717eusmtip1d515d026ed1d847ffe1c4a75bab152a1~oZO5on3Ja2698526985eusmtip19;
	Thu, 17 Nov 2022 14:17:17 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 17 Nov 2022 14:17:16 +0000
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <chaitanyak@nvidia.com>,
	<kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>, Joel Granados
	<j.granados@samsung.com>
Subject: [PATCH v3 0/1] nvme : Add ioctl to query nvme device attributes
Date: Thu, 17 Nov 2022 15:13:36 +0100
Message-ID: <20221117141337.3719372-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduznOd1cp7Jkgws3pSzeH3zMarFy9VEm
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8epvfsQWwRnHZpKTmZJal
	FunbJXBlnF72lqXgpkDFh0dHWRoYL/J2MXJwSAiYSNzfUN/FyMkhJLCCUWJiR0oXIxeQ/YVR
	YtKhy8wQic+MEqt63UBskPopJ24yQRQtZ5T4eLebBcIBKlr3ppEFomMzo8Tbbb4gNpuAjsT5
	N3fAJokIhEicat3BBrKZWSBN4toXTpCwsICHxKEZc8BKWARUJU6smccKUsIrYCvx4E0yxF55
	ibbr0xkhOjUl1u/SBwnzCghKnJz5BGwpM1BJ89bZzBDlihJb5nxnhbBrgab0MINcKSFwhEOi
	d8VWqCIXiW/tn6GKhCVeHd/CDmHLSPzfOZ8Jws6W2DllF1R9gcSsk1PZIOFmLdF3Jgci7Cgx
	Yd8Ndogwn8SNt4IQ5/BJTNo2nRkizCvR0SYEUa0msaNpK+MERuVZCL/MQvLLLCS/LGBkXsUo
	nlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYSk7/O/51B+OKVx/1DjEycTAeYpTgYFYS4c29
	WJosxJuSWFmVWpQfX1Sak1p8iFGag0VJnJdthlaykEB6YklqdmpqQWoRTJaJg1Oqgaltr/Xb
	JUlfIh8LnBQ/9GBy2Y7l/x92B386lHnx1MSAJ1+v2Ic5W4efy9KY92Yd1y2nuR+UC9gWMvjP
	+y3zY3XhUf5ivztLWu5qL1io+VtyU3L55pcTT62LUfcS+ti40aBWnCG1V0c+SL1/xrs9zTuv
	z5QV+rDuusLEiXz897yaF5VNPWD7porJtuFd4nnxB/OCcjP+PfBbcdB1r17M/kP3JpQlfeIr
	VuO17fd6cLU8ZdNvj3ksvTut1rOFXuiveltyNGWJuOuVQ5WqNz+KKCyb6vPVfgeHJPcudo+H
	c6aZ3j6tm/DuJY+VoY7UkVlvO2ra8m0yRIxFJ29w+s74MVpI8ZeF0WzRf1OWOzy+PCdWiaU4
	I9FQi7moOBEAN+7Y7ZQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7q5TmXJBjvbuSzeH3zMarFy9VEm
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8epvfsQWwRunZFOWXlqQq
	ZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlnF72lqXgpkDFh0dH
	WRoYL/J2MXJySAiYSEw5cZOpi5GLQ0hgKaNE04e/7BAJGYlPVz5C2cISf651sUEUfWSUeH2y
	hRHC2cwoce/GC2aQKjYBHYnzb+6A2SICIRKnWncAdXBwMAukSVz7wgkSFhbwkDg0Yw5YCYuA
	qsSJNfNYQUp4BWwlHrxJhtglL9F2fTojRKemxPpd+iBhXgFBiZMzn7CA2MxAJc1bZzNDlCtK
	bJnznRXCrpXY9Ho90wRGoVkI3bOQdM9C0r2AkXkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZG
	YAxtO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMKbe7E0WYg3JbGyKrUoP76oNCe1+BCjKdAzE5ml
	RJPzgVGcVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXApCbS/0FG
	VJg3mnmhsBbHR0en5icbupSflOh8PJvV0mK1aMUD8RsdcSWnLNeU7tm4q1DocuQKh83iDucf
	ffJfW8F7Vj99pkHYqjk+pplyTW+3pyzd/YBXNaTRaPuebVWhVlc6rF56fX+9jT9dJYR7q8Kc
	gEyboMMH63Y2bRRP/tn8Ud3yWeWW+rO3ui/nZ9w/q/H2evIJz6aebSc2NkaxnTFwDvl9t7vX
	48PSg/5FN65rJkafW3XqtNY7oXk70w9lSh1znHjBVrIipeEt75mi+xd+y/lFFGQuc2X/8/KZ
	x7/urtUPsjUnyT02MlF/qfUyrO7q9muPL2zqOX/icWmgtfWDswltyxOenopIn+/1SImlOCPR
	UIu5qDgRAFo3dN4qAwAA
X-CMS-MailID: 20221117141717eucas1p22722572ae0898b65a872658d5a4ef14e
X-Msg-Generator: CA
X-RootMTR: 20221117141717eucas1p22722572ae0898b65a872658d5a4ef14e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221117141717eucas1p22722572ae0898b65a872658d5a4ef14e
References: <CGME20221117141717eucas1p22722572ae0898b65a872658d5a4ef14e@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221117_061726_612857_BAC314EC 
X-CRM114-Status: GOOD (  14.17  )
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

Feedback is greatly appreciated :)

[1] https://github.com/torvalds/linux/commit/fddb5d430ad9
[2] https://github.com/torvalds/linux/blob/master/include/uapi/linux/vfio.h#L56

V3:
* Removed unneeded comments in nvme_ioctl.h
* Added a comment to the nvme_sectors_to_mps function
* Moved size checks to nvme_check_size in core.h
* Changed struct initialization to match what we use in nvme driver {} vs
  {0}

V2:
* Changed comment from // to /**/
* Took a call out from an if condition and assigned it to ret var.

Joel Granados (1):
  nvme : Add ioctl to query nvme attributes

 drivers/nvme/host/core.c        |  8 ++++-
 drivers/nvme/host/ioctl.c       | 61 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h        | 11 ++++++
 include/uapi/linux/nvme_ioctl.h | 23 +++++++++++++
 4 files changed, 102 insertions(+), 1 deletion(-)

-- 
2.30.2


