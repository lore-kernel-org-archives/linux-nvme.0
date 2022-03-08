Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F016DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 17:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H53xp6yeGBlTuoGeu8BDVoyhOFj9m5618FQoTrdC9pQ=; b=yBYQbQjB8LhYlzSWpPrCd0guBf
	0SDX82mDyLmjXOLY/g4ghIAlaHtxuI7pyiCem13FYQrWfbco4NUwZYin6cRyXwsb5I0IAGU82y0vJ
	DRlgJyTNm8ukco8FA0mPZSY7m223/L35SsRONiFPwZ74efkhXeFXldBcNGgAwWrnrT3manHnIiOHs
	eCErQJdQHbHb5squPJ6A9bK+eikfOZfnkC3YIvlR6dBE9TcypLxftJdyz4JbGmM0Bai0pLdn3g9G3
	UMvSG9HWHJca7DfDY5AgaIwwIPCm8qswQsYpavF0eLV0b9cmUAQvbmu5AeVacMg701PhPokohlWW+
	F42z9Y1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRdMY-005R9e-BM; Tue, 08 Mar 2022 17:11:06 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRd6j-005LpH-W6
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 16:54:47 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220308165444euoutp0175fa0cc7c3ea52761459b5a2d4d08c41~adh3ov1EW0237902379euoutp01n
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 16:54:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220308165444euoutp0175fa0cc7c3ea52761459b5a2d4d08c41~adh3ov1EW0237902379euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1646758484;
 bh=H53xp6yeGBlTuoGeu8BDVoyhOFj9m5618FQoTrdC9pQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BQ1ndsTEal0EQVH1QKa750Kwu3/+ZGAobYTIZtSdStjcNFGqwbF2meimoWHdDEiG2
 CuPQcdPw7cpF5G1xP0gkBGPENHFW0B3V6i2JWVcZKj3NRDqpOUdFG6RnCp2VHp6JCP
 2dqEiD1Oic8XWhHbOpKN1nGbtc1MxyKwdyDEKUiI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220308165444eucas1p1dc6f150ebe97c32b17af0c232b120eec~adh3TqMe00406404064eucas1p12;
 Tue,  8 Mar 2022 16:54:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 80.BD.09887.45A87226; Tue,  8
 Mar 2022 16:54:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220308165443eucas1p17e61670a5057f21a6c073711b284bfeb~adh20X0_30374103741eucas1p1A;
 Tue,  8 Mar 2022 16:54:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220308165443eusmtrp22016d5d24eb1bec006c0eb956c4f0969~adh2zoTfc0464104641eusmtrp2k;
 Tue,  8 Mar 2022 16:54:43 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-43-62278a5498c3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id BF.96.09404.35A87226; Tue,  8
 Mar 2022 16:54:43 +0000 (GMT)
Received: from localhost (unknown [106.210.248.181]) by eusmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20220308165443eusmtip2d2d4bc26adfa27ddce92481060f6f699~adh2iffUO1078010780eusmtip2c;
 Tue,  8 Mar 2022 16:54:43 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Adam Manzanares
 <a.manzanares@samsung.com>, =?UTF-8?q?Javier=20Gonz=C3=A1lez?=
 <javier.gonz@samsung.com>, kanchan Joshi <joshi.k@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Damien Le Moal
 <damien.lemoal@opensource.wdc.com>, =?UTF-8?q?Matias=20Bj=C3=B8rling?=
 <matias.bjorling@wdc.com>, jiangbo.365@bytedance.com
Cc: Pankaj Raghav <pankydev8@gmail.com>, Kanchan Joshi
 <joshiiitr@gmail.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 5/6] null_blk: forward the sector value from
 null_handle_memory_backend
Date: Tue,  8 Mar 2022 17:53:48 +0100
Message-Id: <20220308165349.231320-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308165349.231320-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7djP87ohXepJBltXcVhMP6xosfpuP5vF
 77PnmS1Wrj7KZPH4zmd2i54DH1gsjv5/y2Zx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5M
 eMpo8XlpC7vFmptPWSzWvX7P4iDg8e/EGjaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2z
 ASjXep/Vo2/LKkaPz5vkPNoPdDMFcEdx2aSk5mSWpRbp2yVwZUw9Z1PwW6Diwt07zA2MP3m7
 GDk5JARMJFb+OcvexcjFISSwglGi/8ARKOcLo0RD3womCOczo8St/z+YYVrm7v3NCmILCSxn
 lNjeLw5R9JJRYm/XXKAODg42AS2Jxk52kBoRgQvMEj9uKoLUMAtsZpT4MGkFWLOwQKTEk94H
 jCD1LAKqEjs35oKEeQWsJPZdeMoGsUteYual72BzOAWsJZ52zmSDqBGUODnzCQuIzQxU07x1
 NjPIfAmBxZwSt7pOMUI0u0g8n30dyhaWeHV8CzuELSPxf+d8JoiGfkaJqS1/oJwZjBI9hzeD
 fSABtK7vTA6IySygKbF+lz5E1FHie3cehMknceOtIMQJfBKTtk1nhgjzSnS0CUEsUpLY+fMJ
 1FIJictNc1ggbA+Jlw1PWSYwKs5C8swsJM/MQli7gJF5FaN4amlxbnpqsVFearlecWJucWle
 ul5yfu4mRmDKO/3v+JcdjMtffdQ7xMjEwXiIUYKDWUmE9/55lSQh3pTEyqrUovz4otKc1OJD
 jNIcLErivMmZGxKFBNITS1KzU1MLUotgskwcnFINTEuieaV/lp6RuanScO3kpBMbFjxlfF53
 RaajzbC3eeVTvW+akurXTv9x32OekrjgT5poz+TkpJkBcaeUK91V3fbcmpemFqqULP96acfM
 rR2Cumv+MHn82VDU2M289lnPGiF5Zh6h3prvLqmCy/uquHk2xueFTfo42XLG6/AfcvwzVjX2
 5z6fuX5Swm5nfvMnEXU564I+3Zzs2L2b58AJE+fNlct5ODQFfj67EXDAjEX6rtPmnV9Prsps
 ErZQ33X4v/JPFaPAtLD9b3S3bF5ev3f2ubNy28u2MogEyZ5O/bx6qe4OZ8fEvTK8ca2VPNM1
 xc8tr/sekP1xPa9+9tmVmkd+SgnL3H21zLnr/czVHUosxRmJhlrMRcWJAM4BaxPoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7rBXepJBtN3q1lMP6xosfpuP5vF
 77PnmS1Wrj7KZPH4zmd2i54DH1gsjv5/y2Zx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5M
 eMpo8XlpC7vFmptPWSzWvX7P4iDg8e/EGjaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2z
 ASjXep/Vo2/LKkaPz5vkPNoPdDMFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvH
 WhmZKunb2aSk5mSWpRbp2yXoZUw9Z1PwW6Diwt07zA2MP3m7GDk5JARMJObu/c0KYgsJLGWU
 +NKvDhGXkLi9sIkRwhaW+HOti62LkQuo5jmjxIKvDUAJDg42AS2Jxk52kLiIwA1miWVT2xhB
 HGaB7YwSG1bOYQPpFhYIl5i1cB8rSAOLgKrEzo25IGFeASuJfReeskEskJeYeek7O4jNKWAt
 8bRzJhvEQVYSvw60MkHUC0qcnPmEBcRmBqpv3jqbeQKjwCwkqVlIUgsYmVYxiqSWFuem5xYb
 6RUn5haX5qXrJefnbmIExue2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrz3z6skCfGmJFZWpRbl
 xxeV5qQWH2I0BTp7IrOUaHI+MEHklcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphak
 FsH0MXFwSjUw7XkU/JN9j6weC6uMgXP4wfNbnI/t1XY87a4dWpRld84++KajWa37Zc26iWlB
 gVU/7HnDObal/25oWDm96d3VZQyu13iqZnW6sUvWd1qtKdtieFKtNoeR527P1vj7s8odOvj3
 lOdIqP4ufndo9pOiSU82Rny2vf6K8fTab0zLTlidnfTmaoO92q6dMqKX67etsi5vvj5Fn/FS
 d3zTgt2paqdkL8TWzUvccuTzgekXw/1m/noRkSTPKDt5TqvGrejnRpePT5dn3XPMp6fssFaZ
 W+oM/z95U8pvVOl0lxkn73UvSF3b9d7N4lLP3Himn6f+16mV5DJ/suS6ctz8UcDhKwefzPP5
 L5p89dWXWQt3KbEUZyQaajEXFScCAFyGh6lYAwAA
X-CMS-MailID: 20220308165443eucas1p17e61670a5057f21a6c073711b284bfeb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220308165443eucas1p17e61670a5057f21a6c073711b284bfeb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165443eucas1p17e61670a5057f21a6c073711b284bfeb
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165443eucas1p17e61670a5057f21a6c073711b284bfeb@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_085446_382324_30182387 
X-CRM114-Status: GOOD (  16.85  )
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

This is a preparation patch to add support for power_of_2 emulation in
the null_blk driver.

Currently, the sector value from null_handle_memory_backend is not
forwarded to the lower layer functions such as null_handle_rq and
null_handle_bio but instead they are fetched again from the request or
the bio respectively. This behaviour will not work when zone size
emulation is enabled.

Instead of fetching the sector value again from the request or bio, pass
down the sector value from null_handle_memory_backend to
null_handle_rq/bio.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/null_blk/main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 05b1120e6623..625a06bfa5ad 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1204,13 +1204,12 @@ static int null_transfer(struct nullb *nullb, struct page *page,
 	return err;
 }
 
-static int null_handle_rq(struct nullb_cmd *cmd)
+static int null_handle_rq(struct nullb_cmd *cmd, sector_t sector)
 {
 	struct request *rq = cmd->rq;
 	struct nullb *nullb = cmd->nq->dev->nullb;
 	int err;
 	unsigned int len;
-	sector_t sector = blk_rq_pos(rq);
 	struct req_iterator iter;
 	struct bio_vec bvec;
 
@@ -1231,13 +1230,12 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 	return 0;
 }
 
-static int null_handle_bio(struct nullb_cmd *cmd)
+static int null_handle_bio(struct nullb_cmd *cmd, sector_t sector)
 {
 	struct bio *bio = cmd->bio;
 	struct nullb *nullb = cmd->nq->dev->nullb;
 	int err;
 	unsigned int len;
-	sector_t sector = bio->bi_iter.bi_sector;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 
@@ -1320,9 +1318,9 @@ static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
 		return null_handle_discard(dev, sector, nr_sectors);
 
 	if (dev->queue_mode == NULL_Q_BIO)
-		err = null_handle_bio(cmd);
+		err = null_handle_bio(cmd, sector);
 	else
-		err = null_handle_rq(cmd);
+		err = null_handle_rq(cmd, sector);
 
 	return errno_to_blk_status(err);
 }
-- 
2.25.1


