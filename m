Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFCAC2D0E2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 20:35:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3008235FD
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 20:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MkzIXNZH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAPH32nU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3008235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pOp9JZFKGmNlAmOZ4sQUDgt5LEX7b/5tJf7suJ2I+cc=; b=MkzIXNZHam6aZhU0EYRr160TZ
	aTE37aOxobV5izIz8Fyo191fDe6dZxBXnErv8j+hdccM7bXLRojOrWfOsEXKHH7D1+HqeyxSXObEQ
	cmbd4GQnTxN9F4jLfUneojNNqa6e5O+J/DgLXNlZ2MBXOJQuaEPEzST44JYd8O/ROA1TzpMuYiYVd
	OKJWuq2pcgFDhVnK1DAkdIYEual/AbULh10RMNMC07b1eUmd7hnK3/fTk91y7jzBvH14qoClgxrv2
	jeBXPi39UKGfE+3YsfK0ly29sxmmteot2r4xMlsCmhLwlJPVkKftOM0vWmG9NE11RLqeg+TgE7dsC
	70enoQ4yg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKp01-0004US-0v; Tue, 22 Sep 2020 20:34:53 +0000
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKozx-0004TQ-Sg
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 20:34:50 +0000
Received: by mail-qv1-xf43.google.com with SMTP id cy2so10268017qvb.0
 for <linux-nvme@lists.infradead.org>; Tue, 22 Sep 2020 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=R8GFEYnKOk8TfLXo80Jb83h+O7r3IGiEUB0d+BEz6dM=;
 b=cAPH32nULRT1ndOVXA23s7i0HDo2KeRFOCJ4JaJqPZMup5HWoOitcuiWUcNhlsuDXy
 7AKuY/3xBr9qmilRkJR5FX6FbYBDCcwLlde8YdrvPRsaGkCDAU9316RVdKzxQhafLTvg
 +r1gYI/FuuO1X6OFlqaVFp47NYewk14nfgAu30hntiVdlMmhGyaLWVxOYO/1lvgSsQ1l
 2z5MAjYVGE8qULyGCH0M2zcBjKxeWyHRfZKfg3Pwux5uq0em/OsryFyxJExTAI1G52dp
 kXlHcle51eZdLPRuLUBSOInrrrrzHNiUe8ituNAjHfb4abSdD28LywvBdyq5n/bl5/UH
 pWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=R8GFEYnKOk8TfLXo80Jb83h+O7r3IGiEUB0d+BEz6dM=;
 b=Ovy7Jwadb6sIr9Ekr2BOMl6RIvlwa+37KufIepZ9jGlh2503LQNQUikCH6SOwpzdvD
 Ncnd97b4NQhX0dxhfKEs4h8OPDLg9CdU0n2RGD3TbKJdh+APOv16JqQY837En9EkHiNj
 j1oNDgz/289GSV7+MmIoli6lPd2zagowikJFw0/3sEdsMwcWeyyMR1K/8JL57z1jnYQk
 7fpl235kzGc63WIjOXKrmv/h2hu5Yvctoc38AUlN+smgVh6FLJGRJ9FqNPsVrgME0UeU
 OF1srUu892xE+WS74n0QsP/TS9DBWHKMU8tLbQ4sbanKOreAQ4w2BNUjDOPI5jhUqTLT
 296Q==
X-Gm-Message-State: AOAM5325ockJL3UfPV04JdxTUNXKZM25Opuli44/3sIcrn2OdwdBgZZ0
 Tw6K+A7C4ql/I1Hy3Tni8N0=
X-Google-Smtp-Source: ABdhPJxBRbjg9BEfzJ1YSKVCiubduc02mIA0b5yAqerkWpYQWdVbYvqzZH9wV+EJZCbhJk6gtRAZyQ==
X-Received: by 2002:ad4:5006:: with SMTP id s6mr7787567qvo.51.1600806887754;
 Tue, 22 Sep 2020 13:34:47 -0700 (PDT)
Received: from ?IPv6:2601:5c0:c100:b9d:298d:87e0:b186:e81c?
 ([2601:5c0:c100:b9d:298d:87e0:b186:e81c])
 by smtp.gmail.com with ESMTPSA id k185sm11904002qkd.94.2020.09.22.13.34.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Sep 2020 13:34:47 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] nvme: fix use-after-free during booting
From: Tong Zhang <ztong0001@gmail.com>
In-Reply-To: <20200922164154.GA1894@lst.de>
Date: Tue, 22 Sep 2020 16:34:45 -0400
Message-Id: <61E8905E-E3FE-46EB-8283-9B35B4F069E1@gmail.com>
References: <20200916153605.5253-1-ztong0001@gmail.com>
 <20200922135956.GA23437@lst.de>
 <CAA5qM4BPKZaqH0SHS3zCO7oz=f3Ow_zB2fqtJYUrbbFBNbWsNQ@mail.gmail.com>
 <20200922164154.GA1894@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_163450_035194_AD69883C 
X-CRM114-Status: GOOD (  24.48  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "ztong0001@gmail.com" <ztong0001@gmail.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Christoph,
I modified the patch a bit and now it works.
Best,
- Tong

---
 block/genhd.c         | 7 +++++--
 include/linux/genhd.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 99c64641c314..8c432e5f97ea 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -835,7 +835,10 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	 * Take an extra ref on queue which will be put on disk_release()
 	 * so that it sticks around as long as @disk is there.
 	 */
-	WARN_ON_ONCE(!blk_get_queue(disk->queue));
+	if (blk_get_queue(disk->queue))
+		disk->flags |= GENHD_FL_QUEUE_REF;
+	else
+		WARN_ON_ONCE(1);
 
 	disk_add_events(disk);
 	blk_integrity_add(disk);
@@ -1567,7 +1570,7 @@ static void disk_release(struct device *dev)
 	kfree(disk->random);
 	disk_replace_part_tbl(disk, NULL);
 	hd_free_part(&disk->part0);
-	if (disk->queue)
+	if (disk->flags & GENHD_FL_QUEUE_REF)
 		blk_put_queue(disk->queue);
 	kfree(disk);
 }
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 4ab853461dff..9441077ee103 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -135,6 +135,7 @@ struct hd_struct {
 #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
 #define GENHD_FL_NO_PART_SCAN			0x0200
 #define GENHD_FL_HIDDEN				0x0400
+#define GENHD_FL_QUEUE_REF			0x0800
 
 enum {
 	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */
-- 
2.25.1


> On Sep 22, 2020, at 12:41 PM, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Tue, Sep 22, 2020 at 12:19:06PM -0400, Tong Zhang wrote:
>> Thank you Christoph for providing the patch.
>> However, the test shows that the issue still persists even with the new patch.
>> The call trace is the same as in my first email.
> 
> Weird.  What baseline did you test?  You need to use the patch on top of
> the latest for-next or for-5.10/block tree from Jens for full effect.
> 
> If that still feels can you send me a longer dmesg that also shows what
> happens before the sniplet you sent?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
