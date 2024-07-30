Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27E4C49EA1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jul 2024 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3+U7lnBvQdTWY0wt5vNGhlNRsDDYUKfHlNtAqocrpgA=; b=3Tg2XuQiPA51Ig4d5agJsmvy6U
	m5fyt3jsBRpnzfH7n3UZ06s9hrHZPIQc24LXYeuzeuyjd2txjABq8WpCJqEPj0uBB6RkqK9fIGuEj
	+SuWSR0F2EAye3zSBbtTwsbcIvVIRnUek6cotKaCrrB5KUL2hkIda5VZrzlDoWLV0CxSeVYqr4B/S
	Wsile94ckzmv3u7vAZ8BxPzX2uQNEdjDSHZdVbvu5AQQ4mUsJxR6L2csLqVvb2Nbn9FyeNwEz+LC+
	osuyeSHAbgnnBoq4mHCRdJ6uQqs1N6Ahtf73/IWqtLBmbjdQLEmG+UA5VnQmSSlfrBPGwkR3nqW1h
	ZrCjLBCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYkH7-0000000ElfW-0se8;
	Tue, 30 Jul 2024 10:40:13 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYkH3-0000000Elcj-2vyB
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jul 2024 10:40:11 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240730104003epoutp03fb12ac13b13a961474b1c6dc42dc36d4~m93g0Kc3a2177721777epoutp03I
	for <linux-nvme@lists.infradead.org>; Tue, 30 Jul 2024 10:40:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240730104003epoutp03fb12ac13b13a961474b1c6dc42dc36d4~m93g0Kc3a2177721777epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722336003;
	bh=3+U7lnBvQdTWY0wt5vNGhlNRsDDYUKfHlNtAqocrpgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+0DpnDnTQjPHGhKVBWDPUyqMvFpm9yyp+9/WphGhktdaKyOne6Z2kQjXM2+0Y2xC
	 kXQJqenE2eWh0zVIYQXfDaYteRkz6ge5FTryJxxMTzSCAPVhh43ZSUrBuC2WvpmVEl
	 vDFtvvtvy/BsNBoTxO7Xk5GksRtxKKA5uci3cwJk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240730104002epcas5p1dfbf06c4aed5a1e075b356f9fefefd37~m93ghLV8u0271102711epcas5p1g;
	Tue, 30 Jul 2024 10:40:02 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WYBZ94hZLz4x9Pt; Tue, 30 Jul
	2024 10:40:01 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AC.22.09743.0F2C8A66; Tue, 30 Jul 2024 19:39:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240730103943epcas5p392d6c4261213e7a9cf43e103e4dc76b7~m93O9lz2O3199231992epcas5p3R;
	Tue, 30 Jul 2024 10:39:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240730103943epsmtrp2ac1830185de22625473538c31618f5d8~m93O9BARy0352303523epsmtrp2u;
	Tue, 30 Jul 2024 10:39:43 +0000 (GMT)
X-AuditID: b6c32a4a-14fff7000000260f-40-66a8c2f0c157
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4A.F8.08964.FE2C8A66; Tue, 30 Jul 2024 19:39:43 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240730103943epsmtip1056843bdd37a00df45a20021b5ce0146~m93OIwPSU1684416844epsmtip1F;
	Tue, 30 Jul 2024 10:39:42 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 2/3] nvme: change data type of lba_shift
Date: Tue, 30 Jul 2024 16:01:37 +0530
Message-Id: <20240730103138.66714-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240730103138.66714-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmhu6HQyvSDNZ18FusXH2UyeLo/7ds
	FpMOXWO0mL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB59G1ZxRjAGpVtk5GamJJa
	pJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0XEmhLDGnFCgUkFhc
	rKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnbH90SLWggMs
	FX/bPrA1MJ5k7mLk5JAQMJH48eseexcjF4eQwG5GiQlnrzFBOJ8YJW7+W8QGUiUk8I1R4svb
	PJiO/c/+sUDE9zJKLJlsBNHwmVHi4Ls+1i5GDg42AU2JC5NLQWpEBIwlOlc2gNUzC7hL3H7S
	wwRiCwtYSBx6sAjMZhFQlXh3uoUVxOYFih9cv50VYpe8xMxL39lBbE4BS4mtK06yQdQISpyc
	+QRqprxE89bZzCA3SAjcY5f42TGLHaLZReJj0zI2CFtY4tXxLVBxKYnP7/ZCxbMlHjx6wAJh
	10js2NwHtdheouHPDbBfmIF+Wb9LH2IXn0Tv7ydMIGEJAV6JjjYhiGpFiXuTnkJ1iks8nLEE
	yvaQmLX7AjQ8exglzi3cxTKBUX4WkhdmIXlhFsK2BYzMqxglUwuKc9NTi00LjPJSy+HRmpyf
	u4kRnAK1vHYwPnzwQe8QIxMH4yFGCQ5mJRHe+CtL04R4UxIrq1KL8uOLSnNSiw8xmgLDeCKz
	lGhyPjAJ55XEG5pYGpiYmZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE08fEwSnVwGQTLCwR
	dimuv5/v94yJK7NED3Oce1QpvbNcf93C55k3b6xX5Tq1bIPA1sQdO/i9rBz/GpuujBOa5nDp
	ROrGbyZ7bJlXJ7e0Vof6iS+W45Dftu3dPNXAL+u1bIL0Wy4skOQ4tmOK7ApZ9rrE8pJJbgXX
	Jzd/nL90q8M7s/6WyFaLmO55XfuiGE16fn86tt1lc1mt3UbpVU0KcQfsFANv+ZTxiBw6ybap
	9z1b6IfYmbfy7gbbpAX0nXkQuWTaVbtjGc4bpG12pRzweCAi9OhMxXXPTbW/ulrMu2dcjm/Y
	/UvNdOqpm//WrWKbVLAwb568y4O75a9VzjP9P5ppwVN0eoejjFpupNPqsMP+9x9XpyqxFGck
	GmoxFxUnAgD9SmmQCgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnO77QyvSDOb0WFqsXH2UyeLo/7ds
	FpMOXWO0mL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB59G1ZxRjAGsVlk5Kak1mW
	WqRvl8CVsf3RItaCAywVf9s+sDUwnmTuYuTkkBAwkdj/7B9LFyMXh5DAbkaJZV/aWSAS4hLN
	136wQ9jCEiv/PWeHKPrIKLF07lymLkYODjYBTYkLk0tBakQEzCX2XXjOChJmFvCUWD9RHiQs
	LGAhcejBIiYQm0VAVeLd6RZWEJsXKH5w/XZWiPHyEjMvfQdbxSlgKbF1xUk2EFsIqGb2u9/M
	EPWCEidnPgE7jRmovnnrbOYJjAKzkKRmIUktYGRaxSiZWlCcm55bbFhgmJdarlecmFtcmpeu
	l5yfu4kRHL5amjsYt6/6oHeIkYmD8RCjBAezkghv/JWlaUK8KYmVValF+fFFpTmpxYcYpTlY
	lMR5xV/0pggJpCeWpGanphakFsFkmTg4pRqYBMu+2jy/d+LDlSi7btv/nNcKYrY6Z919ZDoj
	Yt3h/h9F31gSNmzfuqGad8dxpk1XTivmaPzcrV84J2ZKyIbPcwQuVZgUSizNyJrzyV9Db/mu
	t8s7p6RVzF66N4JtwiPDdTO0VATba348OjXxk7zh6ZAj9d7WKwsnxJ4M5Jc+fopZ8Y79v4rs
	nTv5uKOY9V6cPdDq9GuTyOSKj3OOnX97ojTq/kufTa1vLD/cazaw3/96/1arBTOEngcmfzL/
	YpH9/XsQd8uB/3s4ErlC9moIi55Rnjtf757ZjNdnWw5cf3S921fJStxulevkbGWtpavvnY5t
	qP0tc6wyYd1GdZ5FZxgZFKd8nLS2xFTK6P3O3elKLMUZiYZazEXFiQDmnw1OzgIAAA==
X-CMS-MailID: 20240730103943epcas5p392d6c4261213e7a9cf43e103e4dc76b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240730103943epcas5p392d6c4261213e7a9cf43e103e4dc76b7
References: <20240730103138.66714-1-joshi.k@samsung.com>
	<CGME20240730103943epcas5p392d6c4261213e7a9cf43e103e4dc76b7@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_034010_101773_444DE354 
X-CRM114-Status: GOOD (  15.01  )
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

u8 fits the need, so stop using int for it.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 09303454bb24..7bfa410d055e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -470,7 +470,7 @@ struct nvme_ns_head {
 	struct nvme_effects_log *effects;
 	u64			nuse;
 	unsigned		ns_id;
-	int			lba_shift;
+	u8			lba_shift;
 	u16			ms;
 	u16			pi_size;
 	u8			pi_type;
-- 
2.25.1


