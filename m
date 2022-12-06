Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575E9C3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 07:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:MIME-Version:Content-Type:Message-ID:Date:Subject:
	CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=lFSw0Rw0tm55CFh7yXSGkwwnhTnrwsB1M29GgElaGwE=; b=UA79ShRTJuAXSXE/aDuE9Ys8Dr
	5IQO3GPDZKUTtnA/6hTXG427ZiC6woi77vYM1ZYI22mntZMQjUJE320TsG9XvGCBZCKfocLPuA3wa
	dMIILtka9SxKu71GQYpNvRtKsDtXv4vnc3dgdI188zXkM8qVz2lisYe8tjrchFbfIMQPpTNx07Jwf
	gGcGKj3/U9A2cFoc1ZgFMy08Li8JzQFJiYl0gKcuXZMHZVorVh3WrX1dAURYU3E6WWfQDA/uRBRBt
	x+4wRVCQO/YLdfE5GspWcz85VN0Z6nCO6iQQ9bfVJx4pDIesjK9EpMfYwMyk1ZJP72h8VTKKIegIa
	rtyuLmGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Sbn-003sqE-DO; Tue, 06 Dec 2022 07:43:19 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Sbd-003sQ4-Rh
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 07:43:12 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221206074302euoutp02750f5d7d2fbfa99c097ca56f06a9b622~uJHHIERMe3089630896euoutp02k
	for <linux-nvme@lists.infradead.org>; Tue,  6 Dec 2022 07:43:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221206074302euoutp02750f5d7d2fbfa99c097ca56f06a9b622~uJHHIERMe3089630896euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1670312582;
	bh=lFSw0Rw0tm55CFh7yXSGkwwnhTnrwsB1M29GgElaGwE=;
	h=From:To:CC:Subject:Date:References:From;
	b=bTa2k2AQSFp9As08+WQgyKjKd7e3uQSBUrJAPpkK1IMQHjw1dyyLjfzrxsMkl0osO
	 N/G3SVNiXsc/hIL7M/LfhDL/7Kz/m9gSs5hbgcGgjOO4TD0qXraPpjqLftLmZl9d5v
	 EvwpnVyMW6Q+1ibsvqk3eqK7MXrDmniz29U+x6RU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221206074302eucas1p1df511d650cec6bf2a3ac9802fdce039f~uJHGmTfOD3046530465eucas1p1G;
	Tue,  6 Dec 2022 07:43:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 6A.76.10112.682FE836; Tue,  6
	Dec 2022 07:43:02 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221206074301eucas1p2e2e5f28171cd08cfe6a8ec7623e5f1e5~uJHGPzUSP2366123661eucas1p2G;
	Tue,  6 Dec 2022 07:43:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221206074301eusmtrp1a23977c7de8adab7a48dab5753e95160~uJHGN0SNo1421114211eusmtrp1k;
	Tue,  6 Dec 2022 07:43:01 +0000 (GMT)
X-AuditID: cbfec7f4-d09ff70000002780-d4-638ef2863405
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id FA.C2.09026.582FE836; Tue,  6
	Dec 2022 07:43:01 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221206074301eusmtip28cb83538accf0c467cf6bbaa97b487b6~uJHGC-5Br1265212652eusmtip2I;
	Tue,  6 Dec 2022 07:43:01 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 6 Dec 2022 07:43:00 +0000
From: Joel Granados <j.granados@samsung.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <chaitanyak@nvidia.com>,
	<sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, <javier.gonz@samsung.com>,
	<joshi.k@samsung.com>, <p.raghav@samsung.com>, Joel Granados
	<j.granados@samsung.com>
Subject: [PATCH v6 0/1] nvme : Add ctrl id to allowed passthru commands
Date: Tue, 6 Dec 2022 08:39:13 +0100
Message-ID: <20221206073914.1243191-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduzned22T33JBj+mCFq8P/iY1WLl6qNM
	FpMOXWO0mL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB59Da/YwtgjeKySUnNySxL
	LdK3S+DKmNE9naXgEX/F7X132RsYb/J0MXJySAiYSDQtfs3axcjFISSwglHi/97b7BDOF0aJ
	Vce62ECqhAQ+M0o0HXaD6Zh3/DgLRNFyRokHk/exwhUtPG0OkdjEKHG4bzMjSIJNQEfi/Js7
	zCC2iECIxNIr05lAipgFZjFKzNt5HSjBwSEs4C7R+tgXpIZFQEWi5fB7sM28ArYSKw7NZ4bY
	LC/Rdn06I0g5s4CmxPpd+hAlghInZz5hAbGZgUqat86GKleU2DLnOyuEXStxasstsLUSAic4
	JHpvfmSBSLhIbPq7mQ3CFpZ4dXwLO4QtI3F6cg9UTbbEzim7oIYWSMw6OZUN5AYJAWuJvjM5
	EGFHibanG1khwnwSN94KQpzDJzFp23RmiDCvREebEES1msSOpq2MExiVZyH8MgvJL7OQ/LKA
	kXkVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYEo5/e/4lx2My1991DvEyMTBeIhRgoNZ
	SYT3xcbeZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8K6Z0JAsJpCeWpGanphakFsFkmTg4pRqY
	ljzbWMpgUS/Gbmix7Nb8uObfR5QrHM5Nk5oaJZY0w/bBnRNnyoI33d9V5Jg478qbTy83yR7d
	bvD6gcSZw/3iPzoUdW7uuaO89nGQa/vlg2WbS1asSXxjsZVZQ33bqzyZ7cpeM1Z6b2xV7A5m
	3NZioBEctaTSq1mUhXtr9KOan/slz3PUzVST9dmydIb43b9t3T0ftAQP1ihvLnJjCm0XeZA2
	b+omPsWZhsHbF7Hrpk5R+LPD+FjiAZH9jUZhtj8WSR6O5t93fpa4p1lfBTd3RZXNimkn+GyP
	bbGdfvpr/bJJc06cPcEdE3Rk3d8Lv6uvrjFx+T9FvCRy2nHFE0Lbt/gZLGOe/kPw88KMlB/L
	JJRYijMSDbWYi4oTAcbddNiYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xe7qtn/qSDdZ+NLF4f/Axq8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGqVnU5RfWpKq
	kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXMaN7OkvBI/6K2/vu
	sjcw3uTpYuTkkBAwkZh3/DhLFyMXh5DAUkaJY2d2sUAkZCQ+XfnIDmELS/y51sUGUfSRUWLl
	3I1MEM4mRol7C1ezgVSxCehInH9zhxnEFhEIkVh6ZTpYEbPALEaJeTuvAyU4OIQF3CVaH/uC
	1LAIqEi0HH4P1ssrYCux4tB8Zoht8hJt16czgpQzC2hKrN+lD1EiKHFy5hOw45iBSpq3zoYq
	V5TYMuc7K4RdK/H57zPGCYxCsxC6ZyHpnoWkewEj8ypGkdTS4tz03GIjveLE3OLSvHS95Pzc
	TYzAONp27OeWHYwrX33UO8TIxMF4iFGCg1lJhPfFxt5kId6UxMqq1KL8+KLSnNTiQ4ymQN9M
	ZJYSTc4HRnJeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAOTZ4R4
	84PIb+UZz9ay3Izjr54gW7f4SvadrLJ3HZ1x394Hz5WX+V/6S6/z1aFNTz8r16tezTB4Y595
	ltci4vDFb/FreI+l1kWYHL06vTUpuKHEzX/9dVnPla2t9z9ke+Vm3nweGHpEND31+cuJIgyP
	+U3KEqqEz82u4Vz16EjYn5eimUqTd4j9OyfhtGGX5WspN5X5XSyFuakvz2Qf7i5V39fVfko1
	RKawskUpuUFGrTTgSHAZx+Ufzenb5hY+LLMzceFi7+tcu3PjEd0Tl6PPv+L90M+5osX41c2q
	5eWbpPR5WybwH1Oa5DM35uKrB27mH1M4K9vPsyqaHji4QPBdvebrtVOu/3nG9s10Io8SS3FG
	oqEWc1FxIgBh+S1/LAMAAA==
X-CMS-MailID: 20221206074301eucas1p2e2e5f28171cd08cfe6a8ec7623e5f1e5
X-Msg-Generator: CA
X-RootMTR: 20221206074301eucas1p2e2e5f28171cd08cfe6a8ec7623e5f1e5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221206074301eucas1p2e2e5f28171cd08cfe6a8ec7623e5f1e5
References: <CGME20221206074301eucas1p2e2e5f28171cd08cfe6a8ec7623e5f1e5@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_234310_183479_75274758 
X-CRM114-Status: GOOD (  14.05  )
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
In this patch I add NVME_ID_CNS_CS_CTRL and NVME_ID_CNS_CTRL to the nvme
admin commands that are allowed in unprivileged passthru.

Why?
This will allow access to attributes that are needed to effectively write
to the char device in passthru.  Applications with write permissions should
not need to be privileged to write to the device. With Kanchan's latest patch
(https://lore.kernel.org/linux-nvme/20221020070205.57366-1-joshi.k@samsung.com/)
the nvme IO and identify commands in passthru now follow device
permissions; however there are still some controller attributes like
minimal data transfer size (MDTS) which need a privileged user to be
queried.

How?
Add NVME_ID_CNS_CS_CTRL and NVME_ID_CNS_CTRL to the allow list in
nvme_cmd_allowed.

V6:
* Added two examples of write attributes in the commit message.
* Added review tags

V5:
* Drop the ioclt implementation in favor of just adding the controller id
  commands to the allow list in nvme_cmd_allowed. This resulted after a
  comment from Kieth Busch pointing out that adding a struct and an ioctl
  for stuff that is already there, makes no sense.  IMO the ioctl
  patch is mostly done and is there if we need it.

V4:
* Fixed an error where the ioctl number would change if new members were
  added. Now I use _IO instead of _IOWR to avoid leave the ioctl number
  static. This is very similar to the implementation contained in
  https://github.com/torvalds/linux/blob/master/include/uapi/linux/vfio.h

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
  nvme : Add ctrl id to allowed passthru commands

 drivers/nvme/host/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.30.2


