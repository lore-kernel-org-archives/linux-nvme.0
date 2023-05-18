Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D21C77B7A
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q2fRsDrKu+OxW5IeoVus6WMCEhUKTOwsV1t12XewfeU=; b=GVva8Tea2Xv47GPbJdq/l/QJfk
	7Xfzyf5K1GoJhLUlm++PlrbOVmKdbJR1OaJfwqMBcX5btYNV9wJiucCbvqCbVci0Q2m29aYW6ezo8
	FF1E6gwDjDUKK50BWjdxxGBvsHhPzSbNsGIObnt8qYzq/Y7qiUSmK0dxsbF+sV8s08vqKZwcBw6dO
	9r/jIzNqqcUBjkXERD7WW+Gjp36ZMN2JhEIQPTuwgTxz1Tet0wYnPi40EiaYqoxp7gWcGJiPCO7W+
	301sGfZOrnak3G5GkaBLKdDsDugYHt+CzBgcZjsXa3g/jRv+tyKk3D2zc3OpQKyPmaDTHnt5z+kSk
	NIw1bDyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pziRk-00DpNU-2o;
	Thu, 18 May 2023 18:33:52 +0000
Received: from mail-qv1-xf64.google.com ([2607:f8b0:4864:20::f64])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pziRe-00DpLU-1o
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 18:33:49 +0000
Received: by mail-qv1-xf64.google.com with SMTP id 6a1803df08f44-62381fe42b3so10837656d6.0
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1684434823; x=1687026823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2fRsDrKu+OxW5IeoVus6WMCEhUKTOwsV1t12XewfeU=;
        b=J1qUnDI3ZaUfAPvp05bBVDPkLPJ2HlK3MMb2CCrgaYJbAA8AyZ0dZKzTRFKGvbfPjw
         wL4dwnUofb534JJAAa8bSIv6w0dnJjnnkhaiKvNQcBIuzbAF1ejDaaOZYK3zl9eAbdnC
         dEGWhn2eiy7v4vzrYdBPhHgUWV0laWeY8cfMzLx95acj04IHTdM4f+AfzL/1Me/siXwf
         tVRfppzFsmWVzcgkXEw8DxbNEd37D0O99WW9ftnBxP+HkSwXOIB6Lyefn19NAzxbWaJx
         t40N5UIaHF9Gs87g+KTz3BECrq7orQ8TB4aWHz6mGGIz3qX+U3afDF38bEKEl8uOtFwj
         QJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684434823; x=1687026823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2fRsDrKu+OxW5IeoVus6WMCEhUKTOwsV1t12XewfeU=;
        b=W7kcec0dld0DXWGVrqEZDM/EOmh/a4DS4p3CkWqa8y+uYDjEpnEwnIOnnFLKH0JY/V
         Dj4qHTuc6p2bwujZ/Q7Ykz1n9Q0hN7XxyWzo1YGFyqP8efQlCXf2EBDFRuHEOiHmVvxN
         Wsolu2Vnq5uo2eNmliNoJ+sBhbdc5nLVqx7N7Y5G+TtNyF7n+QNBQ6hcchiVhDFHl8f/
         /cUd+GoklgWUd2f0/zcBqjYKec3xJteJyFxxQB3uApW0xwJIJ9PEO8TVvcA/DaVZ29ND
         ddci9U6Nv0fTHJ7NDXiIZNuvGrB/zCf5kYsKhJ7zI2Kom7IYbpmyNAf8eu7SiB6JKirS
         o5xQ==
X-Gm-Message-State: AC+VfDwxYPgBQB5Lybpprr3PE9I5rS4iJpmBo5+/qZmqaaBLPq5vvi6R
	TDzDiQazFIHz5fCEkD3/2q3HKPWxAMkPSWWBFqBWcnrQtzRkBPfhLiTi2rC4UYtHnA==
X-Google-Smtp-Source: ACHHUZ7+t9NCe/ltTg/TNcNA7YhMWIrYeQm3vjWDK0ruH0W2Fvt8I5Q1BVFaY6Q++PL8SjljN/ZTvADgkdjI
X-Received: by 2002:ad4:5f8e:0:b0:623:690c:3cd7 with SMTP id jp14-20020ad45f8e000000b00623690c3cd7mr1034128qvb.47.1684434823761;
        Thu, 18 May 2023 11:33:43 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id g14-20020a05620a218e00b0073ba5191dd5sm63722qka.0.2023.05.18.11.33.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2023 11:33:43 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id A6386222AB;
	Thu, 18 May 2023 12:33:42 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A2D03E432E5; Thu, 18 May 2023 12:33:42 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH v3 1/3] nvme: double KA polling frequency to avoid KATO with TBKAS on
Date: Thu, 18 May 2023 12:33:09 -0600
Message-Id: <20230518183311.3224326-2-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518183311.3224326-1-ushankar@purestorage.com>
References: <20230518183311.3224326-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_113347_468701_620056C9 
X-CRM114-Status: GOOD (  15.51  )
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

With TBKAS on, the completion of one command can defer sending a
keep alive for up to twice the delay between successive runs of
nvme_keep_alive_work. The current delay of KATO / 2 thus makes it
possible for one command to defer sending a keep alive for up to
KATO, which can result in the controller detecting a KATO. The following
trace demonstrates the issue, taking KATO = 8 for simplicity:

1. t = 0: run nvme_keep_alive_work, no keep-alive sent
2. t = ε: I/O completion seen, set comp_seen = true
3. t = 4: run nvme_keep_alive_work, see comp_seen == true,
          skip sending keep-alive, set comp_seen = false
4. t = 8: run nvme_keep_alive_work, see comp_seen == false,
          send a keep-alive command.

Here, there is a delay of 8 - ε between receiving a command completion
and sending the next command. With ε small, the controller is likely to
detect a keep alive timeout.

Fix this by running nvme_keep_alive_work with a delay of KATO / 4
whenever TBKAS is on. Going through the above trace now gives us a
worst-case delay of 4 - ε, which is in line with the recommendation of
sending a command every KATO / 2 in the NVMe specification.

Reported-by: Costa Sapuntzakis <costa@purestorage.com>
Reported-by: Randy Jennings <randyj@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f586a4808e6e..7726277b951a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1160,10 +1160,16 @@ EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
  * 
  *   The host should send Keep Alive commands at half of the Keep Alive Timeout
  *   accounting for transport roundtrip times [..].
+ * 
+ * When TBKAS is on, we need to run nvme_keep_alive_work at twice this
+ * frequency, as one command completion can postpone sending a keep alive
+ * command by up to twice the delay between runs.
  */
 static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 {
-	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ / 2);
+	unsigned long delay = (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) ?
+		ctrl->kato * HZ / 4 : ctrl->kato * HZ / 2;
+	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 }
 
 static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
-- 
2.25.1


