Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C55C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jul 2022 07:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1uI44NZwmhrlPEANiHm/8u9CtkmxBAhtfKZluHWwzP8=; b=itwAEEVJoYL+XTZqQg6vjiJp1Q
	1K6QNhgoWdzJGUyecz8zJ5uy2I9RV3lZ2ZAkrpYGGsEiq9v6hZo45Dmus0W56A8Fbxru5F3uF06cM
	G3ce3D0lQiK1fZFrq1twgxBkWu+HbZ5hpf0p3UWFnUko1SAWABFiLIKiKb+yPxxfsuupSL/gEcHD6
	mbfNQW0HxFL+Z2Q+cA2otINx0PLqNGljo8xIbbo4F2GoB6uU/BNN+7HVMNINN4R6j6Gg4e5V57/rW
	gDYeZBbTRGJxiEPWeeaP7YuoWkKVUlmZzRK7NNmiv+G9JNxmElx6oLmX6JP8kTZ78PeMd8DgiLYm3
	Zv3+wXXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDhR5-005qvn-Cc; Tue, 19 Jul 2022 07:14:27 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDhR3-005quJ-4A
	for linux-nvme@lists.infradead.org; Tue, 19 Jul 2022 07:14:26 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220719071416epoutp0460341a3b7090ff8a0ebfdfaabdb48bcd~DKaBG4K1h0317203172epoutp04-
	for <linux-nvme@lists.infradead.org>; Tue, 19 Jul 2022 07:14:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220719071416epoutp0460341a3b7090ff8a0ebfdfaabdb48bcd~DKaBG4K1h0317203172epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1658214856;
	bh=1uI44NZwmhrlPEANiHm/8u9CtkmxBAhtfKZluHWwzP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HDBy4YmZu2k+R0EvAQc9qXDUzg/Fe5DppYRnJoEYHwyoLDhzr7h3K6SaTjkBg+4x2
	 J3JDYFPc4tjFu4NRBFKpDbfzO16He1/BVQprM7XgrQk0FDvhJ8MUSNVFGpz5jylgsu
	 g4et2qh3hRcCrZ9fsQse+Giw2JdXx8AwiLQEvV6Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20220719071415epcas5p1e771ad9940033f0b2df2ef8f7e85a5f3~DKaA290zn0534705347epcas5p1u;
	Tue, 19 Jul 2022 07:14:15 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Ln9781LK6z4x9Pw; Tue, 19 Jul
	2022 07:14:12 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B7.35.09639.4C956D26; Tue, 19 Jul 2022 16:14:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20220719071411epcas5p19f00125e6a66bfaa54af78ce3011784c~DKZ891IZs0534705347epcas5p1g;
	Tue, 19 Jul 2022 07:14:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220719071411epsmtrp1cd821d18ce746bb95e77dffccf38c837~DKZ89EMCe3124831248epsmtrp1O;
	Tue, 19 Jul 2022 07:14:11 +0000 (GMT)
X-AuditID: b6c32a4b-e83ff700000025a7-b6-62d659c43399
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	0C.3B.08802.3C956D26; Tue, 19 Jul 2022 16:14:11 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220719071410epsmtip17dae8b4954439f66083f1c52643d45fa~DKZ7pUrZo1748717487epsmtip1e;
	Tue, 19 Jul 2022 07:14:10 +0000 (GMT)
Date: Tue, 19 Jul 2022 12:38:45 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Joel Granados <j.granados@samsung.com>, kbusch@kernel.org,
	sagi@grimberg.me, linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	k.jensen@samsung.com, Javier =?utf-8?B?R29uesOhbGV6?=
	<javier.gonz@samsung.com>
Subject: Re: [PATCH 3/5] nvme: refactor namespace probing
Message-ID: <20220719070845.GB22571@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220718052503.235270-4-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmhu6RyGtJBk8WcljcPLCTyWLl6qNM
	Fkv3P2S0eHznM7vFycY9rBaTDl1jtJi/7Cm7xbrX71kcODzO39vI4rFpVSebx+Yl9R67bzaw
	efRtWcUYwBqVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
	lpkDdIuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQ
	wMDIFKgwITtj/v6DjAVnBCpWfnjN2MC4kbeLkYNDQsBE4uz9pC5GLg4hgd2MEu8nz2GGcD4x
	Stz79Jmli5ETyPnMKHFifwiIDdLwfvECNoiiXYwSs5c0MUI4zxglmk6cYwOpYhFQlXj19zgr
	yAo2AU2JC5NLQcIiAkoST1+dBatnFrjDKHGq+ztYvbCApUTDv2/MIDavgK7Eng23mCBsQYmT
	M5+AXcEpYCix7cRnsBpRAWWJA9uOM4EMkhDo5ZBY9X0GO8R5LhI90zrYIGxhiVfHt0DFpSRe
	9rdB2ckSl2aeY4KwSyQe7zkIZdtLtJ7qB1vALJAhMffMLSibT6L39xMmSHjxSnS0CUGUK0rc
	m/SUFcIWl3g4YwmU7SHxbdMeaDCuZpT40NDBOoFRbhaSf2YhWQFhW0l0fmhinQW0gllAWmL5
	Pw4IU1Ni/S79BYysqxglUwuKc9NTi00LjPNSy+FxnJyfu4kRnDq1vHcwPnrwQe8QIxMH4yFG
	CQ5mJRFekdrLSUK8KYmVValF+fFFpTmpxYcYTYHxM5FZSjQ5H5i880riDU0sDUzMzMxMLI3N
	DJXEeb2ubkoSEkhPLEnNTk0tSC2C6WPi4JRqYPIwvCbH84Z5gda56/MMVvl9NtgdsPbqsTO/
	HYqK7h/SCb4603naksn5728urXA6Yur44EW25iQ1luWT3bs2nL+yZZ/aK3cvDq6PDx3KJwhn
	V9cW/FG+fW/B5EWCJoJ2c9IesrpmfbP4EGS6bKaVYU2/tPEO7skBC/l8iwOmP8xd/2ihzc26
	rOnfTu6pvzXvZtPH/qP5Gl2hp5uNZpzYtsh5FsuOCEae7e1b8iYEZZz5lh8Vo6OW+Khhb+NW
	DhP7g8kuX7JCjizMjEkWXz+9vm5BgtySfcd9+6QvzfCv9+Qu3DdBOSBJPnfPW2mJcFl3Zcub
	zbHClpJKN3Rc8qr3cKVVTXN/edaOrX7ZrKud5kosxRmJhlrMRcWJAAj/D9AmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnO7hyGtJBmfOqFjcPLCTyWLl6qNM
	Fkv3P2S0eHznM7vFycY9rBaTDl1jtJi/7Cm7xbrX71kcODzO39vI4rFpVSebx+Yl9R67bzaw
	efRtWcUYwBrFZZOSmpNZllqkb5fAlfHgyAm2gn+8Fbu2P2ZqYPzL1cXIySEhYCLxfvECti5G
	Lg4hgR2MEh3H/7FAJMQlmq/9YIewhSVW/nvODlH0hFGi6eM1sASLgKrEq7/HWbsYOTjYBDQl
	LkwuBQmLCChJPH11lhGknlngDqPEnklLWUESwgKWEg3/vjGD2LwCuhJ7Ntxighi6mlHi5P/n
	LBAJQYmTM5+A2cwCZhLzNj9kBlnALCAtsfwfB0iYU8BQYtuJz2BzRAWUJQ5sO840gVFwFpLu
	WUi6ZyF0L2BkXsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERwPWlo7GPes+qB3iJGJ
	g/EQowQHs5IIr0jt5SQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbB
	ZJk4OKUamKaeiX+SJJnYUrutz3HPJP2FTy9/ZrXOCRI6+/mvWOnEO0z/e6trut2VLp7Wi9o0
	8/fl6++PSeVe+fL56v8DH7UyPzy/k/M0f9nLSScN7+1RXyL/IP9CxPmIhTPeM/oKl/EJ/Y19
	rnJ2JYuCW2bi1Pklp9yct5X7T3TbvE5NZ1/x/4efZ2qvfLXuyWbmFRXMdyv3RznNkD/0/Ypq
	28QCtu8lMiHNr09b8unvWJh19fDkPo6JO76lrb9fbGx5WH+6580zXlsNw6f53TOfY/abkf93
	sXSs5yeGp2rexQ9++aW2mIrdFX/aIXJl7l1dywvv9+tbblnuMrVZY8/JvUt8r/8x1M+bLn+n
	RW7p1NQvgSk5SizFGYmGWsxFxYkAavRv//YCAAA=
X-CMS-MailID: 20220719071411epcas5p19f00125e6a66bfaa54af78ce3011784c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----OEEzMZle2oafIX2psGkTvPl59BrXC3apHO-sLjJPJT1qP5Pe=_a4305_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220718052850epcas5p24450d4c756d1eb0db6f4cc9c24bb184d
References: <20220718052503.235270-1-hch@lst.de>
	<CGME20220718052850epcas5p24450d4c756d1eb0db6f4cc9c24bb184d@epcas5p2.samsung.com>
	<20220718052503.235270-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_001425_505125_796665CB 
X-CRM114-Status: GOOD (  15.69  )
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

------OEEzMZle2oafIX2psGkTvPl59BrXC3apHO-sLjJPJT1qP5Pe=_a4305_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, Jul 18, 2022 at 07:25:01AM +0200, Christoph Hellwig wrote:

>-static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>+static int nvme_update_ns_info_block(struct nvme_ns *ns,
>+		struct nvme_ns_info *info)
> {
>-	unsigned lbaf = nvme_lbaf_index(id->flbas);
>+	struct nvme_id_ns *id;
>+	unsigned lbaf;
> 	int ret;
>
>+	ret = nvme_identify_ns(ns->ctrl, info->nsid, &id);
>+	if (ret)
>+		return ret;
>+
> 	blk_mq_freeze_queue(ns->disk->queue);
>+	lbaf = nvme_lbaf_index(id->flbas);
> 	ns->lba_shift = id->lbaf[lbaf].ds;
> 	nvme_set_queue_limits(ns->ctrl, ns->queue);
>
>@@ -1967,6 +1995,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
> 		disk_update_readahead(ns->head->disk);
> 		blk_mq_unfreeze_queue(ns->head->disk->queue);
> 	}
>+	kfree(id);
> 	return 0;
>
> out_unfreeze:
>@@ -1980,9 +2009,30 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
> 		ret = 0;
> 	}
> 	blk_mq_unfreeze_queue(ns->disk->queue);
>+	kfree(id);
> 	return ret;

Seems this new function (nvme_update_ns_info_block) requires kfree at one more place?
This one:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bbdf0f95331f..5a917211e377 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2011,8 +2011,10 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,

        if (blk_queue_is_zoned(ns->queue)) {
                ret = nvme_revalidate_zones(ns);
-               if (ret && !nvme_first_scan(ns->disk))
+               if (ret && !nvme_first_scan(ns->disk)) {
+                       kfree(id);
                        return ret;
+               }
        }
	
With that-
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

------OEEzMZle2oafIX2psGkTvPl59BrXC3apHO-sLjJPJT1qP5Pe=_a4305_
Content-Type: text/plain; charset="utf-8"


------OEEzMZle2oafIX2psGkTvPl59BrXC3apHO-sLjJPJT1qP5Pe=_a4305_--

