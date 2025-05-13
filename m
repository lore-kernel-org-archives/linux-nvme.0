Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8105AC3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 14:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=R0OZWkcQN2f+NXkm5Mwmz6NPBk
	E90YYQnk7ZCk9bT2XoaJw+nbZE0rmG8HEADNvGCXKMV3/1co/trhNJBvFV2ohH5LtE1Ci8SjNGcrU
	e4Qb7QhOb0I4VtXlgioZu7mV+cJ1qOrFIwwXT7DRpBn90y7VVhjooKgHcGKHivxvnCASblB6/dljR
	nUpvwViinpwlkUFMqisJnb1v3KgQuVYaZa7V2IKHiajQ6qjSYGR9E2cUu/mBvPZrFzRKtvIWEAfST
	Cgf175XptPg4nFyDTXc5AD94Eyx6kYYzytfkLi1MMZ+6qfx7Km9zvO579a8CyPby7a+xThUBpWM3O
	qQkvF/+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEqQi-0000000CaeK-3pP6;
	Tue, 13 May 2025 14:16:24 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEqQg-0000000Cadc-19p6
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 14:16:23 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250513141619epoutp03e4444ffe051b84374eaef199340b7714~-G9RTFG1g1122911229epoutp03f
	for <linux-nvme@lists.infradead.org>; Tue, 13 May 2025 14:16:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250513141619epoutp03e4444ffe051b84374eaef199340b7714~-G9RTFG1g1122911229epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747145779;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=F/IEeZVj29ERM0IfVUp8UMDQ67fZTJzjqrXOH/W6DFlHQc/qunu8j6s4NmwHNPhJO
	 gqkL2JPReYBnw11WAUq8WOrReosyTDhU+hXfLc3+qLCHGwLYwN0+DQKz76Ssrq7Km6
	 WvGXfALK/0FWcJQdY/Vt83w1nz1ktJXqffwbbr9U=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250513141618epcas5p3f97fad08fcc2c46d90a1e511a702905a~-G9Q2XP8m0689006890epcas5p37;
	Tue, 13 May 2025 14:16:18 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.181]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4ZxdnG08ykz2SSKX; Tue, 13 May
	2025 14:16:18 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250513141617epcas5p43f541c3654f4956efa30693386a1b5ab~-G9Ppv1Rw3141331413epcas5p4W;
	Tue, 13 May 2025 14:16:17 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250513141617epsmtrp220a50445dbfc54eea6c4eeb3141c2006~-G9PpGogJ2141421414epsmtrp2f;
	Tue, 13 May 2025 14:16:17 +0000 (GMT)
X-AuditID: b6c32a52-40bff70000004c16-73-682354317356
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	24.48.19478.13453286; Tue, 13 May 2025 23:16:17 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250513141616epsmtip29406692f790a4ce53f03600eb10e46fd~-G9OsrdXT1875718757epsmtip2Z;
	Tue, 13 May 2025 14:16:16 +0000 (GMT)
Message-ID: <93fd033c-4945-4b9a-8384-26c2460d94af@samsung.com>
Date: Tue, 13 May 2025 19:46:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] nvme-pci: rename the descriptor pools
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
	Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Leon Romanovsky
	<leon@kernel.org>, linux-nvme@lists.infradead.org
Content-Language: en-US
From: Kanchan Joshi/Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250513070025.830930-5-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvK5hiHKGwdsHohb/F85ltVi5+iiT
	xaRD1xgtpvxaymwxf9lTdot1r9+zOLB5nL+3kcVj06pONo/NS+o9dt9sYPPY9rCXPYA1issm
	JTUnsyy1SN8ugSvj1I6lTAVGFdfm9jE1MOp2MXJySAiYSHRemsPUxcjFISSwnVFi+eMPzBAJ
	cYnmaz/YIWxhiZX/nrNDFL1mlFi8czUTSIJXwE7i+PY/YDaLgKrEtP1dUHFBiZMzn7CA2KIC
	8hL3b80AGyQMVH/nUQdjFyMHh4hAusSzriKQMLNAmcTqIytYIeavZpQ4sPUiE0RCXOLWk/lg
	NpuAucT2eWfAjuMUMJR4urSbEaLGTKJraxeULS+x/e0c5gmMQrOQnDELyahZSFpmIWlZwMiy
	ilE0taA4Nz03ucBQrzgxt7g0L10vOT93EyM4QrSCdjAuW/9X7xAjEwfjIUYJDmYlEd7G7YoZ
	QrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUx9cx2ucm1a
	ueIP97Xsf2obcoPmzP1919Ly87vXC4Id1vy5cLN0n7ldeH+uSuZiXstLGZ+DwtKnfHmdzdT9
	tP6Mr1zDn/SiclX/cGGHt4sUI64cV3cWzVQ42G5m7ynyn/vks7s9F/g1zkza07GUZaHIjKIt
	2fyd3h4Trux58XuC9fUjhYvZ3u88bqjzfuOjTXHxPGqsZz7dmrM1uO++58Ow6287EpcZvEoS
	rp6hlN2mbsbbNm8h94Sau2f9lapYHp2W+7TxwgX/yGN+N3+zrLTax/sza3XhwUmzd2S9UpVs
	+V8jm/HPY/fy016zJjzeYaZxx39OySUGnU18jC+edc8/fVdCo6tae7W5cQTHA6N8JZbijERD
	Leai4kQA4hannP8CAAA=
X-CMS-MailID: 20250513141617epcas5p43f541c3654f4956efa30693386a1b5ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250513070148epcas5p1e79d48067c46439f07177fe05d3380a3
References: <20250513070025.830930-1-hch@lst.de>
	<CGME20250513070148epcas5p1e79d48067c46439f07177fe05d3380a3@epcas5p1.samsung.com>
	<20250513070025.830930-5-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_071622_629146_2B5254EC 
X-CRM114-Status: UNSURE (   8.86  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

