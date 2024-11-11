Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700B7D2E9CB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 09:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wSo8owcbmmdZLdtSUlDCR3rgaYI63gjofW60l0l59dQ=; b=Xx8uZGPUJyAogFx5ISzdx1gBDd
	nDMJKQrNrbNL8kO6W9GL6DrJ/sFZvInbuzh4eA6zrU6fMLIgto7w7GltlUbbNye6nuthzOdAHCCHr
	lwWFpLON9jpcse5eKBdSxYtzSFaf7kPCU0BjMYz12nNnL3wB0qMeIfCwDSpzbpKUW93sIh7++8VfT
	lWRN3cBs9rytvVWXHY2Iz9trqrWorQHDw9RL8BZogIKTz0e0z3YhVSAcI0m8/sC6tvgv3nScFNAO5
	xCw77i54+rJZzYJFAELlY4G/whC5BwxsxyuPTDBlVcipD+fXms+TeQzaLZeRFUBDk27I2ct0yE0dy
	Koo0BWCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAQmr-0000000H70U-4BFK;
	Mon, 11 Nov 2024 09:32:46 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAQmB-0000000H6po-0NeA
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 09:32:04 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241111093156euoutp01d845c7f7ad2984cbb069a05945ac18de~G4BuzP36o0702207022euoutp01S
	for <linux-nvme@lists.infradead.org>; Mon, 11 Nov 2024 09:31:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241111093156euoutp01d845c7f7ad2984cbb069a05945ac18de~G4BuzP36o0702207022euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731317516;
	bh=wSo8owcbmmdZLdtSUlDCR3rgaYI63gjofW60l0l59dQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=qnk6fON3KC6vXoYoKz5NYq3yWytrFaVhI9pMfcLvw4/M7MlpJv0bwFiTstGg3AzIz
	 wCjN5oYjCOLD8n/M3/DElueVI2ytgnoVT2/b7K7T1CkctO3cMklGTT5PZoXh6nTGx9
	 RtTr39oIGeit7Spk9vHrZR3X+Kcuzoz58LxnErYY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241111093156eucas1p1daede80b307fed0064acc9ea541373dc~G4BuoOCQC2892328923eucas1p1K;
	Mon, 11 Nov 2024 09:31:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 66.58.20821.C0FC1376; Mon, 11
	Nov 2024 09:31:56 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241111093155eucas1p21a04cbacd57cffa49c2158c7b5f8d801~G4BuS7j2T3162731627eucas1p2O;
	Mon, 11 Nov 2024 09:31:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241111093155eusmtrp1c2e1f6559e1b7f89df28018594ce4ffe~G4BuSUaNm3074830748eusmtrp1L;
	Mon, 11 Nov 2024 09:31:55 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-84-6731cf0cf5e4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id FD.AB.19654.B0FC1376; Mon, 11
	Nov 2024 09:31:55 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241111093155eusmtip19a835f2627c842b28105af41f3a00884~G4BuF1Afm1735817358eusmtip1E;
	Mon, 11 Nov 2024 09:31:55 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 11 Nov 2024 09:31:54 +0000
Date: Mon, 11 Nov 2024 10:31:54 +0100
From: Javier Gonzalez <javier.gonz@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <20241111093154.zbsp42gfiv2enb5a@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <2b5a365a-215a-48de-acb1-b846a4f24680@acm.org>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTYRCG/brb7bZaXYrKKMajBoMYQaLB9ap30njWHxo0RqmyFqQU7FJB
	8GjkVhRF8UBFiHLYJsbQFg2IgaYFKgRUVJCIaMSooA2iJSJqtN16/Htm5p3MvJMhMUkpfyIZ
	rUlgtBqlWkqI8Mr6odbZo1pDVXOyavj0uf4hjL5htPNoZ3oLTudZnyK6+UkxTtd0zqLv1jhw
	+mrpGwF9vP0OQQ9/vUwsE8nbHq+Vm8qD5BWGbEJuun5EXv1MT8hbHibJP1dMVgi2iRZHMuro
	/Yw2RBYhirJklxHx3XhSV42d0KM+7BgSkkDNg7OOc/xjSERKqHIE7R8sOBd8QWCxuQgu+Izg
	W+Hb3y2kp8VVhXH5MgRNPWbsr8jZe9UbmBEMGM0C9xCcCoBK1yPkZoIKAcPt+x4eSwXC4Msy
	zzyMGsQgrSjDU/ClVkLOlS4Pi6klUDJgFHDsA46LPbibMWohZPcf5btXwih/KPtJutNCahE0
	VtXxOHNSeP3uI+L4ENw3d/Lcs4BKFcKnE4Ve0So48a5IwLEv9DaYvTwJms7k4ByngN7R6G1O
	Q5CeZeFzt1gEJ5vVnGY5dDtP41x6NHR89OHWHA15lee9lxNDVoaEU88A44sP+Ck0veA/YwX/
	GSv4Z6wIYQbkx+jYWBXDhmqYxGBWGcvqNKrg3XGxFej3KzX9bBi4g670fgq2Ih6JrAhITDpW
	HLgxRCURRyoPJDPauJ1anZphrcifxKV+4oDIKYyEUikTmBiGiWe0f6o8UjhRz7uQGzCP9X22
	oUBks7OX8lmfqVtsHfr5/i9bozJt+/qI9pvWlH6H8bjZ5GfPrc6cVhxTvbdOP3dcUEeUve29
	M/XodEWxCfWF7yqvbEgJi40TZdQbcsz+tYUrbLWTh5sHfRewwvBE+pQm+dUyXe/rlryA7cyP
	8LA39GJZ6uG2tPiU7DV+aaE3D9oT1I/Sq6a+DYywdO0YOT6znoXGmLVjZu7Lp2r7XIpbiVj3
	odIjnTvbNyc9uLduOKFxT/0Ik8a5XjZQ0jX0Taa56zOrtSQw7MDCfDS09HmxwF4Liojrhq2b
	vi+HpebkbZrC6NUPRpRe273hgi6iR9YJcyfUtYx3KaQ4G6UMDcK0rPIX+UEn37kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7rc5w3TDU61a1lM+/CT2WLl6qNM
	Fu9az7FYTDp0jdHizNWFLBZ7b2lb7Nl7ksVi/rKn7Bbd13ewWfz+MYfNgcvj8hVvj80rtDw2
	repk89i8pN5j980GNo9zFys8Pm+SC2CP0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2
	j7UyMlXSt7NJSc3JLEst0rdL0MvY2rmcreA+S8XdvUfZGhhfM3cxcnBICJhIfN0FZHJxCAks
	ZZRo2/SXqYuREyguI7Hxy1VWCFtY4s+1LjaIoo+MEr1nzrNDOFsYJXY9+M0CUsUioCqx7esl
	RhCbTUBfYtX2U2C2iICGxLcHy1lAGpgFvjFLtCxoA0sICzhL9My9C2bzCthKLP20GmrqImaJ
	T28PsUMkBCVOznwCtoFZwEJi5vzzjCB3MwtISyz/xwES5hSwljix6yDU2UoSj1+8ZYSwayU+
	/33GOIFReBaSSbOQTJqFMGkBI/MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwOjcduznlh2M
	K1991DvEyMTBeIhRgoNZSYRXw18/XYg3JbGyKrUoP76oNCe1+BCjKTAsJjJLiSbnA9NDXkm8
	oZmBqaGJmaWBqaWZsZI4L9uV82lCAumJJanZqakFqUUwfUwcnFINTKwHI2cUSwQkdfkcFZkv
	Oyvmb+x1rujg9n+eBptOXv1r3a/A/u1ZVsGLZ4psSalctn4+v89V1r5dGBkSddirbPs585W2
	Eb8WMia+XXvmmGgem87Ux//du4riuqdbyO7IaxR/lRG9r1n1/dxtS3zU5zlftNfbe5734c/v
	JnINxfJFJ1l37lozMaZr5s1vJZWGXTpm/u7niuy/TmV7l7VbT+Lq/di/LkfOrju+QPzFxArj
	av+IudkyZVNMwn/wr+S8+uvB8tXOorbq/wNEmtrfLGrOZfFhK14ixlBenNr8uZfjyI+a3cWi
	ylYK9y0496hd6M1cfiH/yPt9x2ZvnP/rr/F9xVzf4E8btMu/Ok5drcRSnJFoqMVcVJwIAJ5m
	i7hXAwAA
X-CMS-MailID: 20241111093155eucas1p21a04cbacd57cffa49c2158c7b5f8d801
X-Msg-Generator: CA
X-RootMTR: 20241108165444eucas1p183f631e2710142fbbc7dee9300baf77a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241108165444eucas1p183f631e2710142fbbc7dee9300baf77a
References: <20241029151922.459139-1-kbusch@meta.com>
	<20241105155014.GA7310@lst.de> <Zy0k06wK0ymPm4BV@kbusch-mbp>
	<20241108141852.GA6578@lst.de> <Zy4zgwYKB1f6McTH@kbusch-mbp>
	<CGME20241108165444eucas1p183f631e2710142fbbc7dee9300baf77a@eucas1p1.samsung.com>
	<Zy5CSgNJtgUgBH3H@casper.infradead.org>
	<d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local>
	<2b5a365a-215a-48de-acb1-b846a4f24680@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_013203_424755_53DE5588 
X-CRM114-Status: GOOD (  11.75  )
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

On 08.11.2024 10:51, Bart Van Assche wrote:
>On 11/8/24 9:43 AM, Javier Gonzalez wrote:
>>If there is an interest, we can re-spin this again...
>
>I'm interested. Work is ongoing in JEDEC on support for copy offloading
>for UFS devices. This work involves standardizing which SCSI copy
>offloading features should be supported and which features are not
>required. Implementations are expected to be available soon.
>

Do you have any specific blockers on the last series? I know you have
left comments in many of the patches already, but I think we are all a
bit confused on where we are ATM.

