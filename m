Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0B4CE837D
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Sep 2024 18:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=4LBDHSJVU1H97AxnvlyhnVRQZzY6KCoCAgte1h6Y9Ng=; b=4ibMjKjFoRhy7HVtXh23nm3dZZ
	kXdotLdUVQoK1wyVOZOYqZ+zdbVyIEHi79m8IyPFrsViTUYHrB86b/xx9qsYDfWzNJlOzzbJQ6Z8b
	aEYkDEP3X31LvICCMPrup08lMjeiBQCGp6yNXe/IcBuWevsQIvQbXkjh5OVU/qQ9Dn2lfI+G5Dmep
	GABqQk7IOyVTGfHD22LKjnXlev4MiVouXxV3p+Xz02U2SVcYf652NsspnvrjuRWdQMiJYpHwbJKTB
	MNy5cCEHDwlhUv4B+CCyuwRna63gKmttzk67+w28eO5vR5OCUp6/YVk9bEOU74u/AtUmGdJwNdfcI
	qIJKrjJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svL19-00000000Udf-05ED;
	Mon, 30 Sep 2024 18:21:07 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svL13-00000000Uae-2G7W
	for linux-nvme@lists.infradead.org;
	Mon, 30 Sep 2024 18:21:05 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240930182056epoutp021f6915dcdaf1a48cedb8931911be05bf~6GJnYNcjM0776207762epoutp02l
	for <linux-nvme@lists.infradead.org>; Mon, 30 Sep 2024 18:20:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240930182056epoutp021f6915dcdaf1a48cedb8931911be05bf~6GJnYNcjM0776207762epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727720456;
	bh=4LBDHSJVU1H97AxnvlyhnVRQZzY6KCoCAgte1h6Y9Ng=;
	h=From:To:Cc:Subject:Date:References:From;
	b=PDIWA60HsX66Yl+6XwMQcuV3CMKnrJla0HRWBvwhf4xdjjAzMLLAFTTHV6HAVDsES
	 XM5grzbVxVObCatYW2KVmn13bfWdUaorWL0HmOWQL0yOf2CUo+AZCR01BpCZlxNQrm
	 4xo9hvZh9WIKE2rdr83ydHlDnyL9g5XLv10wS1cU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240930182055epcas5p1846d3252efb056c9fe61062565594212~6GJmjkRcY1760617606epcas5p17;
	Mon, 30 Sep 2024 18:20:55 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XHTsK3WZsz4x9Pp; Mon, 30 Sep
	2024 18:20:53 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BB.C9.09420.50CEAF66; Tue,  1 Oct 2024 03:20:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240930182052epcas5p37edefa7556b87c3fbb543275756ac736~6GJkcXrLq2353623536epcas5p3t;
	Mon, 30 Sep 2024 18:20:52 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240930182052epsmtrp2c5610fcd20805f353e1d082217316a9e~6GJkbaWbv2734327343epsmtrp2g;
	Mon, 30 Sep 2024 18:20:52 +0000 (GMT)
X-AuditID: b6c32a49-0d5ff700000024cc-38-66faec05defa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	4C.79.18937.40CEAF66; Tue,  1 Oct 2024 03:20:52 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240930182049epsmtip23462ac72f0fbc210f05d50b83d060b98~6GJhYF2Fl2298222982epsmtip23;
	Mon, 30 Sep 2024 18:20:49 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, hare@suse.de,
	sagi@grimberg.me, martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org,
	dhowells@redhat.com, bvanassche@acm.org, asml.silence@gmail.com
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v7 0/3] FDP and per-io hints
Date: Mon, 30 Sep 2024 23:43:02 +0530
Message-Id: <20240930181305.17286-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfVDTZRy/57ffXkAHPxncnqgQdyedKLDVwIdOIgm7H7k/uMzs6jxc7Mfb
	2It7KUE7CA+JgUiECIMQiaC2O4iJAgHJjQgtA0qxxgmSDCUYzFhiyFsbm+V/n+/n+Xy/n/t8
	n+dh0fwcjEBWulxDqeTiTB7DG7/ctyM0jG57nMJvucBBNYbLABnHzjCQbq0NR7N9CwBVPFii
	ofm8ZRxZejsx1F1fhqGvjf0Yms8fxFH1uZMYsrboaWjytoOJ+tfnGKjMfAug8oo8gHpGd6Lu
	nms4Ot84xURNA2sYap6142hodYCOhvQ1zFe55I2b+8lO/RiTHBpvxckbP2tJk6GQQZoWypjk
	xYYcssuSyyD/mhrFSft3IwyypM0AyOt13zsPfzpOOkxBpMk6hyX6vivdk0aJJZQqmJInKyTp
	8tQY3v4DSa8lRUbxBWGCaLSbFywXy6gYXrwoMez19EznDnjBH4gztU4qUaxW8yJe2aNSaDVU
	cJpCrYnhUUpJplKoDFeLZWqtPDVcTmleFvD5L0Y6hUekacVdwwzllS3HVswjIBeUsnXAiwUJ
	IVw6dQfTAW+WH9EFoO3+bbq7WADwK9sM7lJtFPqiuCcdZ6w/ekSdANb3XmW6CweAhrpahg6w
	WAxiBxz+TOvi/YlyDFqMho1JNGIVQLNF5MIcYhc0Dp3f4HFiO6zuu0p3YTaBYH/+LeB22wqr
	fn3EdPNb4LUqq2fOVnjyUjXNZQCJAi+4OD/laYiHQ6uzuBtz4MxAG9ONA6FjvofhxlI4cXfC
	ozkBOy6W0N04Fuau/E53BaA5A7R8G+H28oGnl62Yi4YEG35yys+t3gbHy6Y8nVz4R2WDB5NQ
	33mT4V7cYVhkrqWVgiD9Uwn0TyXQ/29WB2gG8AylVMtSKXWkUiCnPvzvLpMVMhPYeP2hCR1g
	bOJBuBlgLGAGkEXj+bPHzUspfmyJOCubUimSVNpMSm0Gkc61fkoLDEhWOL+PXJMkEEbzhVFR
	UcLol6IEPC57Nv9ziR+RKtZQUopSUqonfRjLKzAXi20UvGk/F33XKH//BBZQlxEXNtMwqC+c
	1LF2cw9Z3iqS+RpGC/78hXz0Rbdc11oynf1DsndTZU5nCtF6JAmwL8w5Qu+L38jale3T/GXt
	3NGFON/nSr8pZB4os+ZfetYnbO8hk4jzMGRtb1XteM2VzVPLi8PHr4s6KFmAbdOxpZHRj4jf
	emcLirkhvW+fPZ2Sau8pWdw0EnsvtGsga/vm9cOadjPe/reXZGfGw9Z60VF7wjaWbaBdOENN
	Nt1p/PifSW55x0p85XTC4LSwRK2q8M944Xmj7/jB9bwgHfMsflBqu5dvj4gVzb1HcnqbHyta
	LenKd3IDihO79mnHpBx+TgjOw9VpYkEoTaUW/wv9VadwhgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvC7Lm19pBnfu6FnMWbWN0WL13X42
	i65/W1gsXh/+xGgx7cNPZot3Tb9ZLG4e2MlksWfRJCaLlauPMlm8az3HYjF7ejOTxZP1s5gt
	Ht/5zG5x9P9bNotJh64xWkyZ1sRosfeWtsWevSdZLOYve8pusfz4PyaLda/fs1ic/3uc1eL8
	rDnsDuIel694e+ycdZfd4/y9jSwel8+Wemxa1cnmsenTJHaPzUvqPXbfbGDz+Pj0FovH+31X
	2Tz6tqxi9Diz4AhQ8nS1x+dNch6bnrxlCuCP4rJJSc3JLEst0rdL4Mro2X2BrWC/YMWfQ1cZ
	Gxgn8HYxcnJICJhI9D85xdrFyMUhJLCdUeLgjKlMEAlxieZrP9ghbGGJlf+es0MUfWSU6D/w
	CKiIg4NNQFPiwuRSkLiIwAomiW1P/rKAOMwC7UwS1ybeZQbpFhbQkVh9fj4LiM0ioCox+/AJ
	VhCbV8BC4mjrNUaIDfISMy99Z4eIC0qcnPkErJ4ZKN68dTbzBEa+WUhSs5CkFjAyrWIUTS0o
	zk3PTS4w1CtOzC0uzUvXS87P3cQIjk2toB2My9b/1TvEyMTBeIhRgoNZSYT33qGfaUK8KYmV
	ValF+fFFpTmpxYcYpTlYlMR5lXM6U4QE0hNLUrNTUwtSi2CyTBycUg1M5ebHPAwbpMTKpmy7
	2xZzIeH/kuBT+u/+X7N4IBPm4XM3stP6gvzpO/cOXP273NTS4NeEU6WzX5yKaAq5bZ29P6Wp
	p/+8wbmQkr7UxZ+bn7Mpvf9c91eofuILF8uVyYtnH2p5zOs2tceJLXOmgFu8+waJf00N5kt3
	bfr92sX88QIGHpco+X3SrOw+2snrU1bs4C6I2PPqOv+D2uRrqb9+NYe+NF6XIvTXbPaDkvOa
	/SXsRj4LuEXTJ9/8mHBc+0JKU+U23nN/7HbMY5Hd789xMKJ534VXtu8vXl6f08Roybqn/MuW
	AztarOxXBkesm1C45e8G19nrl7QKFBu4mt6TWnsosOOX60y9lh6Z3ysMlViKMxINtZiLihMB
	v38qDjwDAAA=
X-CMS-MailID: 20240930182052epcas5p37edefa7556b87c3fbb543275756ac736
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240930182052epcas5p37edefa7556b87c3fbb543275756ac736
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240930_112102_063332_FA3FE4CD 
X-CRM114-Status: GOOD (  14.86  )
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

Another spin to incorporate the feedback from LPC and previous
iterations. The series adds two capabilities:
- FDP support at NVMe level (patch #1)
- Per-io hinting via io_uring (patch #3)
Patch #2 is needed to do per-io hints.

The motivation and interface details are present in the commit
descriptions.

Testing:
Done with fcntl and liburing based custom applications.
On raw block device, ext4, xfs, btrfs and F2FS.
Checked that no regression occurs for application that use per-inode
hints.
Checked that per-io hints, when passed, take the precedence over per-inode
hints.

Changes since v6:
- Change io_uring interface to pass hints as SQE metadata (Pavel, Hannes)

Changes since v5:
- Drop placement hints
- Add per-io hint interface

Changes since v4:
- Retain the size/type checking on the enum (Bart)
- Use the name "*_lifetime_hint" rather than "*_life_hint" (Bart)

Changes since v3:
- 4 new patches to introduce placement hints
- Make nvme patch use the placement hints rather than lifetime hints

Changes since v2:
- Base it on nvme-6.11 and resolve a merge conflict

Changes since v1:
- Reduce the fetched plids from 128 to 6 (Keith)
- Use struct_size for a calculation (Keith)
- Handle robot/sparse warning

Kanchan Joshi (3):
  nvme: enable FDP support
  block, fs: restore kiocb based write hint processing
  io_uring: enable per-io hinting capability

Kanchan Joshi (3):
  nvme: enable FDP support
  block, fs: restore kiocb based write hint processing
  io_uring: enable per-io hinting capability

 block/fops.c                  |  6 +--
 drivers/nvme/host/core.c      | 70 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  4 ++
 fs/aio.c                      |  1 +
 fs/cachefiles/io.c            |  1 +
 fs/direct-io.c                |  2 +-
 fs/fcntl.c                    | 22 -----------
 fs/iomap/direct-io.c          |  2 +-
 include/linux/fs.h            |  8 ++++
 include/linux/nvme.h          | 19 ++++++++++
 include/linux/rw_hint.h       | 24 ++++++++++++
 include/uapi/linux/io_uring.h | 19 ++++++++++
 io_uring/rw.c                 | 24 ++++++++++++
 13 files changed, 175 insertions(+), 27 deletions(-)

-- 
2.25.1


