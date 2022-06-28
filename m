Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95811CCA479
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jun 2022 19:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:MIME-Version:Content-Type:Message-ID:Date:Subject:
	CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=4g0q1of4SPHu/9KGOBmjfZnAazSeUUqr10ZdT6+k4zg=; b=VXnwVANqLun1uxPZYMWEQui1mx
	XMr7+KiGJDfemj9E7PGMSub02Aejon9bTgexKANydFbrZKDzIaoSI1xXvh3/i/3n1tUm0p6b4fkk4
	62Gwhj/c4xHl+qI7cvmWnXRmPuz/DwLucXVT14+4FQtkaVpngDcObulBwBCgisrt7xxFcjAjs2I8r
	1O8atqlbSIXJksGgpwLzPgm+fdcPCR6sYQ6HVE1r+Mr+U6dlpQLZ0LDy6+s9gqjoA14+qIiIdLIzF
	v58RT7MBGmM6NTsZww8YQ2j+noWqH6W+mL8SfsjINnMvzLWH2ID2K4kJlyZ50GOnrp/ICsXqDuS+W
	IALSrprQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6Ge6-007mzP-1k; Tue, 28 Jun 2022 19:13:10 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6Ge0-007mtP-S3
	for linux-nvme@lists.infradead.org; Tue, 28 Jun 2022 19:13:08 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220628191256euoutp02deade2a066d20b08fc8f97d7dc0fa29e~83qgAbL4z2703527035euoutp02e
	for <linux-nvme@lists.infradead.org>; Tue, 28 Jun 2022 19:12:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220628191256euoutp02deade2a066d20b08fc8f97d7dc0fa29e~83qgAbL4z2703527035euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1656443576;
	bh=4g0q1of4SPHu/9KGOBmjfZnAazSeUUqr10ZdT6+k4zg=;
	h=From:To:CC:Subject:Date:References:From;
	b=n1x049DjhKk+gi4950fR0xT1PlcNt5Td6qC1i7y9r8iIFvMQtP40vz8Sn+b62C3bH
	 WUdGcPvAkPPOskOGfjGH4io3qefy7zEohpeP6KoG5r/nJwF5AeNEHj1wmPSi/n+Kc+
	 fKvmdKPY4QNKo/YG2+4tEhBhFxxEZopJH+ECLAT0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220628191255eucas1p1ee91ca07127fc43160953d49771e39f5~83qfvDf9b2508525085eucas1p17;
	Tue, 28 Jun 2022 19:12:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 56.95.10067.7B25BB26; Tue, 28
	Jun 2022 20:12:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220628191254eucas1p12ed413b659dbc6c460158eecbe2c0cac~83qe7Tso91300413004eucas1p1S;
	Tue, 28 Jun 2022 19:12:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220628191254eusmtrp1bfee2c7a0a0ae63dbf73b642124c12e9~83qe6uQJn2062620626eusmtrp1d;
	Tue, 28 Jun 2022 19:12:54 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-f1-62bb52b78f1e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 0D.6F.09038.6B25BB26; Tue, 28
	Jun 2022 20:12:54 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220628191254eusmtip2f1c39e8ff4e1505baac9fa0079c8032d~83qexZlNk1650616506eusmtip2S;
	Tue, 28 Jun 2022 19:12:54 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 28 Jun 2022 20:12:54 +0100
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>
CC: <joshi.k@samsung.com>, <k.jensen@samsung.com>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>
Subject: [PATCH v4 0/2] nvme: Enable generic interface (/dev/ngX) for
 unknown command sets
Date: Tue, 28 Jun 2022 21:10:14 +0200
Message-ID: <20220628191016.291935-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7djP87rbg3YnGfT1aVusXH2UyWLSoWuM
	FvOXPWW3WPf6PYsDi8f5extZPDat6mTz2Lyk3mP3zQa2AJYoLpuU1JzMstQifbsEroxrDwoL
	tghVrJ05j6mB8Q9fFyMnh4SAicSNtb9ZQWwhgRWMEmdfiXUxcgHZXxgl3m4+xAbhfGaUWDHp
	ExNMx4ezE1khEssZJVad2MkO0Q5UteusH0RiM6PEh9/9zCAJNgEdifNv7oDZIgKWEr0fboHZ
	zAK5Epu37QDbLSwQI3FvzSIWEJtFQFVix5ROsG28AjYS2y8cYoHYLC/Rdn06YxcjB1CvpsT6
	XfoQJYISJ2c+YYEYKS/RvHU2M0S5osSWOd9ZIexaiVNbbjGB3CYhsIND4s2hd1DfuEhMmjwV
	yhaWeHV8CzuELSNxenIP1N5siZ1TdkENLZCYdXIqG8gNEgLWEn1nciBMR4kFl1MgTD6JG28F
	Ia7hk5i0bTozRJhXoqNNCGKGmsSOpq2MExiVZyG8MgvJK7OQvLKAkXkVo3hqaXFuemqxUV5q
	uV5xYm5xaV66XnJ+7iZGYOo4/e/4lx2My1991DvEyMTBeIhRgoNZSYR34ZmdSUK8KYmVValF
	+fFFpTmpxYcYpTlYlMR5kzM3JAoJpCeWpGanphakFsFkmTg4pRqYZpVvXH5sYaj9Fhlnr8xn
	kqbfNkWIrmh2cRVafuyP94ONp4+LVsSuPytoGMsa1lrW9NRuguT5rVfUZvt6ST6KmR54QonV
	lc+v89r6CXznxHoi8xaXTBb4uDzgnm/I2g9LZrg/WDrrEeuTE94+rW8mTew+dirByDts6lpN
	3Z6JghGfNKM8Y1L097/gWD/pJuPyVen1a/Y7ePNntKikJ97VaHgb7n3D+6tv65enMVPnTl6X
	27FmyaXGu7wpwfy8XWcvsuxsmqLFkyuScPSC32vhrz1RewrsjDi2V/UodO7iY3C9q/bukPHR
	HZbuTcZbEgqiG/972Sc9iPI5UpyRo+v+8tKHa3r297rMJdSkPzIosRRnJBpqMRcVJwIA6pTl
	04wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4Pd1tQbuTDP6/NbFYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRejZF+aUlqQoZ+cUltkrRhhZG
	eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnXHhQWbBGqWDtzHlMD4x++LkZODgkB
	E4kPZyeygthCAksZJXZszIKIy0h8uvKRHcIWlvhzrYuti5ELqOYjo8Ts9WdZIZzNjBJT/xwC
	q2IT0JE4/+YOM4gtImAp0fvhFpjNLJArsXnbDqAGDg5hgSiJE+d1QcIsAqoSO6Z0MoHYvAI2
	EtsvHGKBWCYv0XZ9OiNIObOApsT6XfoQJYISJ2c+YYGYKC/RvHU2M0S5osSWOd9ZIexaic9/
	nzFOYBSahdA9C0n3LCTdCxiZVzGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRGy7ZjP7fsYFz5
	6qPeIUYmDsZDjBIczEoivAvP7EwS4k1JrKxKLcqPLyrNSS0+xGgK9M1EZinR5HxgvOaVxBua
	GZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTDN/m+4xXiKHQer6a+GFCmm
	aq9HXLc31Zm+0d1VPVO43nL73NuZC+81PBbheaz/T5zfNMH98rpmXZ3JmWEf+kVPFkyd75vx
	ifNU+sOHcp2bXiycKNNRUef5pvyGQYnaDmvO0+mXun09953Y47otOCdlq/fGciujX4p5Jy6L
	brgfyi33kqfiZOuh6XlT2k//sLD79ezkdLf+abHbch2mX995+In9F4f21a8lowSYtyxv23J5
	XvEHuXjbzMszZjleN0/9+6+QhWHLyVs23oel0jczf0qNTFa7x/XmgPKn/zYHPl2dsigoZd9q
	Bie9C4nK/ycu7JzfVnQm5H6K7UTBKp3ZjR8mvWx6mMtQekBROe6oEktxRqKhFnNRcSIA5bno
	oR8DAAA=
X-CMS-MailID: 20220628191254eucas1p12ed413b659dbc6c460158eecbe2c0cac
X-Msg-Generator: CA
X-RootMTR: 20220628191254eucas1p12ed413b659dbc6c460158eecbe2c0cac
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220628191254eucas1p12ed413b659dbc6c460158eecbe2c0cac
References: <CGME20220628191254eucas1p12ed413b659dbc6c460158eecbe2c0cac@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_121305_376181_48D9FDF9 
X-CRM114-Status: GOOD (  17.28  )
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

Currently block and char interface do not show up for any command set other than
NVM and ZNS. This series enables char interface to come up for unknown command sets.

Patch 1: Is prep. It allows the re-use of nvme_mpath_add_disk for
supported as well as independent command sets.

Patch 2: The following functions become aware of whether the command set is
independent or not: nvme_alloc_ns and nvme_validate_ns. A switch statement
is introduced in each of them to call the relevant helper to identify and
update the namespaces.  nvme_update_ns_info_cs_indep is added to update
command set independent devices.

Changes since V3:
- Stop ignoring the NVM or ZNS controllers that do not support
  command-set-independent namespace identification and allow them to come
  up through the usual command-set-dependent path.
- Only devices that are not NVM nor ZNS and do not support the
  command-set-indep NS identification will be "abandoned"
- New function nvme_update_ns_mpath_info_general that is called from both
  nmve_update_ns_info and nvme_update_ns_info_cs_indep to "update" the
  mpath device. This removes repeated code.
- Warn when when command-set-indep NS is not supported or it returns
  error.
- Only assign the independent id in nvme_identify_ns_cs_indep when there
  are no errors. This is to keel NULL value on failure.

Changes since V2:
- Removed unnecessary include to types.h
- Call nvme_identify_ns_cs_indep only once and reuse the created
  independent id in the nvme_alloc_ns call. We call
  nvme_identify_ns_cs_indep regardless of ctrl->cap & NVME_CAP_CRMS_CRIMS
  value
- Replace 'if' with 'switch' statements making it explicit that the command
  set independent functions are used when the command set is not NVM nor
  ZNS.
- Set the hidden flag in the multipath case so the block device does not
  come up when multipath is enabled.

Changes since V1:
- Use command-set independent id-ns to enable unknown command-sets

Joel Granados (2):
  nvme-multipath: refactor nvme_mpath_add_disk
  nvme: enable generic interface (/dev/ngXnY) for unknown command sets

 drivers/nvme/host/core.c      | 164 ++++++++++++++++++++++++----------
 drivers/nvme/host/multipath.c |   6 +-
 drivers/nvme/host/nvme.h      |   5 +-
 3 files changed, 120 insertions(+), 55 deletions(-)

-- 
2.30.2


