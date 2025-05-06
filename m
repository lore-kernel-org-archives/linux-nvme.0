Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A556C3ABBF
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 23:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=vVay890xJtqrdHNy1eAaiDb/5d8yuuj6LdOngT+SQ5w=; b=Nje6a054rtymqbUlKOfVMHsdqq
	/krJSA6Xoiud0afgbSjtdi5BQbB0GefNjtNCRKd1ahFyzyBJ0WYVxVpQgHOdhwpHrwmw4vLUjBj9R
	MaWI61nlMja0PZnUyqgzfZa2QAXkOJCENYfnXwzuwqTpRaOhzGyIHkBXpJBuMq85qAJYrT8+rjT2+
	NVtumJFv/cscXK8BbOvLXECp2/dHgGpmFcxp3S0P/bXQA903zpKakLBhbVx2VPpj2wifKOQCtmw3+
	Vvoi/AwJau0KuHaZcOp+4V+u5xiesrF29ps1boBodjePypMTp7udNNQp+iWL9UfNEI5aHhFYpou8R
	KDZYiu6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCRqE-0000000DhMv-17hz;
	Tue, 06 May 2025 23:36:50 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCNU3-0000000DAdD-0pjc
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 18:57:42 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250506185733epoutp0302e5b4c4753a716946b436f66851470a~9BR0tjVHs0508505085epoutp03S
	for <linux-nvme@lists.infradead.org>; Tue,  6 May 2025 18:57:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250506185733epoutp0302e5b4c4753a716946b436f66851470a~9BR0tjVHs0508505085epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746557853;
	bh=vVay890xJtqrdHNy1eAaiDb/5d8yuuj6LdOngT+SQ5w=;
	h=From:To:Cc:Subject:Date:References:From;
	b=GxEB9z9BDivLY36GaoZxDs8TTrdfX90qLsZUbJzVqRSEsIhzjouzePx5XsoK+87vw
	 8tsutYnybi/4c7/Mh2XtkLXftvkA23G0SvgS2EHZIn/HaEn44Uaxcnh/lzfj71wWwc
	 4zt2rDuGAibp4E3BvBqiK6fC2gKUM0LiXWwMGIhg=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250506185732epcas5p286b5bd1005d3cf90425979513426c827~9BRzlovsm2807328073epcas5p2L;
	Tue,  6 May 2025 18:57:32 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.176]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4ZsSLy11xbz3hhT7; Tue,  6 May
	2025 18:57:30 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250506185729epcas5p42c58afcb24ceb7be79babb63932677bb~9BRw81ciR0312803128epcas5p4o;
	Tue,  6 May 2025 18:57:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250506185729epsmtrp2b39ce6b8b3dd1cfa5cdf60ad0de1b58e~9BRw8PvqN0765807658epsmtrp2s;
	Tue,  6 May 2025 18:57:29 +0000 (GMT)
X-AuditID: b6c32a29-566fe7000000223e-43-681a5b991906
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D7.84.08766.99B5A186; Wed,  7 May 2025 03:57:29 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250506185728epsmtip18ca5a1e1ab0c3404844b5f361a9ad94c~9BRwEN9HY0294602946epsmtip1I;
	Tue,  6 May 2025 18:57:28 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, linux-nvme@lists.infradead.org
Cc: csander@purestorage.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2] nvme: fix incorrect sizeof
Date: Wed,  7 May 2025 00:18:43 +0530
Message-Id: <20250506184843.25081-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSnO7MaKkMg5cdvBar7/azWfxfOJfV
	4uj/t2wWkw5dY7SYv+wpuwOrx+WzpR6bVnWyeWxeUu+x7WEvu0ffllWMAaxRXDYpqTmZZalF
	+nYJXBl3761kKbjDWbHw2zL2BsZuji5GDg4JAROJW+tVuhi5OIQEdjNK7N/7lbGLkRMoLi7R
	fO0HO4QtLLHy33N2iKKPjBJtd58xgzSzCWhKXJhcClIjIuAl0XzpCDOIzSzgJDHnYgsLiC0s
	oCfxYzNILwcHi4CqxJrNcSBhXgELiWdzV0ONl5eYeek7O0RcUOLkzCcsEGPkJZq3zmaewMg3
	C0lqFpLUAkamVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwaGopbmDcfuqD3qHGJk4
	GA8xSnAwK4nw3r8vmSHEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2ampBahFM
	lomDU6qBqdcu97Txi4V2Kee1V2+YfrvC8v+3+Phu9rWfLSRNLYRTLz44sCf67MI3C462Xvtr
	dqJfmfNCl4/LuhWP9r5gEpDYf11uwRyfBduW2y+fsL2RPzVs84Lv5lvvzt/64wTDzXaB1Wx2
	XaVOspvOdwpXbNlbWmSRVhW3qPG9RsGXKjd19U0mvJLsW56JTMhZlHdtcs/E+TOubvjifKEx
	+L6Lzjk27+cGC1l0+D29Vkx7+nTRpF7ujy0TXAy/G8QtX3V6fvhFwcXn21i+/5nN5SO/dObc
	olnfDv679K7yc9ITA+kZyybPXD5jyfZlXYp3Q4+XJOS6xPpk/hMvzvquEsrKVLzmUGPORaF6
	qQnu/TH2+xcrsRRnJBpqMRcVJwIAZB8vzbQCAAA=
X-CMS-MailID: 20250506185729epcas5p42c58afcb24ceb7be79babb63932677bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250506185729epcas5p42c58afcb24ceb7be79babb63932677bb
References: <CGME20250506185729epcas5p42c58afcb24ceb7be79babb63932677bb@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_115739_853415_BCF0A7FD 
X-CRM114-Status: GOOD (  15.53  )
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

The plid array, head->plids, is meant to store placement IDs, each of
type u16. But its size has been incorrectly calculated, as the size of
the pointer is being used instead of the size of the object it points
to.

Use the sizeof(*head->plids) in kcalloc so that we don't allocate extra.

Fixes: 38e8397dde63 ("nvme: use fdp streams if write stream is provided")
Reported-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
changes since v1:
- add reported-by (Jens)
- expand commit description (Jens)

 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 52331a14bce1..7c1b9f2bf0ae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2296,7 +2296,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	if (!head->nr_plids)
 		goto free;
 
-	head->plids = kcalloc(head->nr_plids, sizeof(head->plids),
+	head->plids = kcalloc(head->nr_plids, sizeof(*head->plids),
 			      GFP_KERNEL);
 	if (!head->plids) {
 		dev_warn(ctrl->device,
-- 
2.25.1


