Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7714C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 10:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YiQ6cGvbmTBR8dtlA4Egcxwr16tnNOfj1fz/jTYPkRc=; b=esr+pv8EDZhgY96LKC8PK+Eklk
	E3TdlDtxPs9GrZXG8gIXsP+2GAQaDKsWArLZcPwvXAu+AGjAIoY9inAgFTen2rRoO8+QmRMW3hqtU
	+neYovh+TJwEV5jCh0AKbp9h4hyoQU3GA5u3ePpIDgA4IoEg7UQY0oPLzZOTZyz69CULVN7FkqlKH
	mi2yUFC9nuW9PCjog1YSQtJUfDxmwY0bWtu2bKWwaw/WU8tutLWuYHLMx97T2G7xAkofWROA75ZpF
	XlIyvYKyVpjg9Z83ZLdzgn1T94UPFwCfkL5FQJR2a1URDJZ9mMCFgck+S3e6JBQxw5bcLYQMOogHj
	GfKFb7Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peZ23-00BzIj-37;
	Tue, 21 Mar 2023 10:15:55 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peZ20-00BzHE-0e
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 10:15:53 +0000
Received: by mail-ed1-f54.google.com with SMTP id cn12so11871392edb.4
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 03:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679393749;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YiQ6cGvbmTBR8dtlA4Egcxwr16tnNOfj1fz/jTYPkRc=;
        b=iQyWcOXyDags9JUDOBxlNyJhfPLC9VnQCt8S9TxrNmWRPcSyLXdu3VxGiarv4UyXoi
         j2bprVWpFqVM0Z3WPWi7U2dJIFL8fBFSO1/uOV6Y+2OLckWO498wUjyCtZ0lqXu8EAu7
         Blcn7wzzD63l6qGONKYFnMpopL8W1D31e/9PbgOj65bLRMKJv2/BUjzNlIgpFPGhltql
         43PvjZ35YVP1icrAyreldKjtRrgX9HNl9KaCwpDCZX6b3JieumU3HQNkU5+kwzBQwav2
         zZ0TGUyA44Ma60vzpr46qlrUlkopyPybbMz1God07ly+WwPMmuP0QiZzS6dDmpc57Lmc
         U9HQ==
X-Gm-Message-State: AO0yUKWRsvUpY/AinrATxU86w4OSUg9JsPSNxKVJRkxMeUuCP3+5Cxe5
	jwIC3iPcsbZcpTxynm5LXqGWXmm/OeI=
X-Google-Smtp-Source: AK7set+efQRgL5BhCAN5tvU7e+7jgjk+fuXlZrLwwuHLZLSpChZhKTvUY8Easy4eVrC+Xf+jJISJkw==
X-Received: by 2002:a17:906:5307:b0:931:5145:c51d with SMTP id h7-20020a170906530700b009315145c51dmr1963585ejo.0.1679393749075;
        Tue, 21 Mar 2023 03:15:49 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id z26-20020a17090674da00b009310d4dece9sm5584080ejl.62.2023.03.21.03.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 03:15:48 -0700 (PDT)
Message-ID: <038ea0b7-9cf4-4b19-0fd3-bf3cd69342ca@grimberg.me>
Date: Tue, 21 Mar 2023 12:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <32741f55-f5aa-cd59-351c-df87ee2b2818@grimberg.me>
 <ZBMz1FUB3qJGKXeW@kbusch-mbp.dhcp.thefacebook.com>
 <6232d774-bc94-fae8-bab9-7151fde4f719@grimberg.me>
 <ZBNPs3ukEpbm/NSn@kbusch-mbp.dhcp.thefacebook.com>
 <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
 <20230321082308.n6ed7ieu5jdb2gj4@carbon>
 <20230321084917.s5xqklrttauxilnx@carbon>
 <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
 <20230321090913.gwuvyuw76ha62hgb@carbon>
 <4c4b93b7-891d-cd5f-e4f2-50c242c799ce@grimberg.me>
 <20230321092556.7m3etb25jnd4sfj6@carbon>
 <316be6c1-0d90-0ea8-f9cf-1ec0086877a3@grimberg.me>
In-Reply-To: <316be6c1-0d90-0ea8-f9cf-1ec0086877a3@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_031552_258664_5B33BCC6 
X-CRM114-Status: GOOD (  20.65  )
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


>>> The admin tagset does not have a polled hctxs map to begin with,
>>> so I'm unclear how any fabrics or admin requests end up polled...
>>
>> Hmm, if no map_queues() callback is provided for the admin tag set, 
>> isn't the
>> default mapping function used and this would add the poll hctxs map? 
>> Let me add
>> a map_queues() callback and see what happens :)
> 
> admin_tagset.nr_maps = 1 (only the default map, no read, no poll)

Oddly, I don't see admin/fabrics requests being polled...

I just attempted with the below patch and it seems to work.
The only change I did was to pass to blk_poll the cookie as well,
from bio_poll that is bi_cookie, and from blk_rq_poll it is computed
from the hctx directly.
--
diff --git a/block/blk-core.c b/block/blk-core.c
index 9e5e0277a4d9..098840fe8bef 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -844,30 +844,11 @@ void submit_bio(struct bio *bio)
  }
  EXPORT_SYMBOL(submit_bio);

-/**
- * bio_poll - poll for BIO completions
- * @bio: bio to poll for
- * @iob: batches of IO
- * @flags: BLK_POLL_* flags that control the behavior
- *
- * Poll for completions on queue associated with the bio. Returns number of
- * completed entries found.
- *
- * Note: the caller must either be the context that submitted @bio, or
- * be in a RCU critical section to prevent freeing of @bio.
- */
-int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int 
flags)
+static int blk_poll(struct request_queue *q, struct io_comp_batch *iob,
+                   blk_qc_t cookie, struct bio *bio, unsigned int flags)
  {
-       blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
-       struct block_device *bdev;
-       struct request_queue *q;
         int ret = 0;

-       bdev = READ_ONCE(bio->bi_bdev);
-       if (!bdev)
-               return 0;
-
-       q = bdev_get_queue(bdev);
         if (cookie == BLK_QC_T_NONE ||
             !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
                 return 0;
@@ -902,6 +883,39 @@ int bio_poll(struct bio *bio, struct io_comp_batch 
*iob, unsigned int flags)
         blk_queue_exit(q);
         return ret;
  }
+
+/**
+ * blk_rq_poll - poll for request completions
+ * @rq: request to poll for
+ */
+int blk_rq_poll(struct request *rq)
+{
+       return blk_poll(rq->q, NULL, blk_rq_to_qc(rq), rq->bio, 0);
+}
+EXPORT_SYMBOL_GPL(blk_rq_poll);
+
+/**
+ * bio_poll - poll for BIO completions
+ * @bio: bio to poll for
+ * @iob: batches of IO
+ * @flags: BLK_POLL_* flags that control the behavior
+ *
+ * Poll for completions on queue associated with the bio. Returns number of
+ * completed entries found.
+ *
+ * Note: the caller must either be the context that submitted @bio, or
+ * be in a RCU critical section to prevent freeing of @bio.
+ */
+int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int 
flags)
+{
+       struct block_device *bdev;
+
+       bdev = READ_ONCE(bio->bi_bdev);
+       if (!bdev)
+               return 0;
+
+       return blk_poll(bdev_get_queue(bdev), iob, 
READ_ONCE(bio->bi_cookie), bio, flags);
+}
  EXPORT_SYMBOL_GPL(bio_poll);

  /*
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cf1a39adf9a5..8161a07ca59d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -66,9 +66,6 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
         return bucket;
  }

-#define BLK_QC_T_SHIFT         16
-#define BLK_QC_T_INTERNAL      (1U << 31)
-
  static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(struct 
request_queue *q,
                 blk_qc_t qc)
  {
@@ -86,13 +83,6 @@ static inline struct request *blk_qc_to_rq(struct 
blk_mq_hw_ctx *hctx,
         return blk_mq_tag_to_rq(hctx->tags, tag);
  }

-static inline blk_qc_t blk_rq_to_qc(struct request *rq)
-{
-       return (rq->mq_hctx->queue_num << BLK_QC_T_SHIFT) |
-               (rq->tag != -1 ?
-                rq->tag : (rq->internal_tag | BLK_QC_T_INTERNAL));
-}
-
  /*
   * Check if any of the ctx, dispatch list or elevator
   * have pending work in this hardware queue.
@@ -1359,8 +1349,6 @@ bool blk_rq_is_poll(struct request *rq)
                 return false;
         if (rq->mq_hctx->type != HCTX_TYPE_POLL)
                 return false;
-       if (WARN_ON_ONCE(!rq->bio))
-               return false;
         return true;
  }
  EXPORT_SYMBOL_GPL(blk_rq_is_poll);
@@ -1368,7 +1356,7 @@ EXPORT_SYMBOL_GPL(blk_rq_is_poll);
  static void blk_rq_poll_completion(struct request *rq, struct 
completion *wait)
  {
         do {
-               bio_poll(rq->bio, NULL, 0);
+               blk_rq_poll(rq);
                 cond_resched();
         } while (!completion_done(wait));
  }
diff --git a/block/blk-mq.h b/block/blk-mq.h
index a7482d2cc82e..7100ba5edd16 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -86,6 +86,15 @@ static inline struct blk_mq_hw_ctx 
*blk_mq_map_queue_type(struct request_queue *
         return xa_load(&q->hctx_table, q->tag_set->map[type].mq_map[cpu]);
  }

+#define BLK_QC_T_SHIFT         16
+#define BLK_QC_T_INTERNAL      (1U << 31)
+static inline blk_qc_t blk_rq_to_qc(struct request *rq)
+{
+       return (rq->mq_hctx->queue_num << BLK_QC_T_SHIFT) |
+               (rq->tag != -1 ?
+                rq->tag : (rq->internal_tag | BLK_QC_T_INTERNAL));
+}
+
  static inline enum hctx_type blk_mq_get_hctx_type(blk_opf_t opf)
  {
         enum hctx_type type = HCTX_TYPE_DEFAULT;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d1aee08f8c18..70532cafd3a9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -872,6 +872,7 @@ blk_status_t errno_to_blk_status(int errno);
  #define BLK_POLL_ONESHOT               (1 << 0)
  /* do not sleep to wait for the expected completion time */
  #define BLK_POLL_NOSLEEP               (1 << 1)
+int blk_rq_poll(struct request *rq);
  int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int 
flags);
  int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
                         unsigned int flags);
--

