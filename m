Return-Path: <SRS0=eYGd=M4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A8AC4338F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 13:16:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8792A6113B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 13:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8792A6113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/iRbbkDQPGmRpPomNdEw/fKRB7BcGLqiCDzrQyeSmYE=; b=HvgslVJs910wmG
	SY+faA8ndf3XH99tJytanLYfFnT942GmsBqwsrfp4H6gdFw+C6c2dEG+NWW8uGccB8MA+4hqV1H07
	0FejjI2HG66rBaOji8jpCydEa/+Yn4wBAY4u4coxvu7Oop6OasESBKaJ8wQLrrlvH4LPL2Y1bvPfr
	rKL7JVYlnPQ5DJC9DRO/XYL7KyuyycWbRNa+Xz6zZKG79Gzw5XqZfTl91EXKzspH0dKDdMWDgupZS
	5Pf1xvxlqaCCvYRR1Guw1j+Wmn/mytwVP6QXHAhLgqBRSMdsUu3Aw4n8GeCi/iWu55KDPx0BBNhsa
	q/knU6q5ZrmhglvSiQDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBdEi-009e0I-HY; Thu, 05 Aug 2021 13:16:36 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBdEB-009dsf-Bo
 for linux-nvme@lists.infradead.org; Thu, 05 Aug 2021 13:16:05 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20210805131601epoutp03595bf502928f2aebaa8ae886a515e78d~Ya2hnXbDv0187201872epoutp03H
 for <linux-nvme@lists.infradead.org>; Thu,  5 Aug 2021 13:16:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20210805131601epoutp03595bf502928f2aebaa8ae886a515e78d~Ya2hnXbDv0187201872epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1628169361;
 bh=fIJCN9Y/rz8bn+EH2L76Gy/qPIeZ6Uzl8ogEjLHpUxw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hi1ybmstkV2CcaDfT50VGS2cpQtUSkh0kqwNHaRqkustcEixF5oM/7jXHSxbQjIfp
 L0gKgQYKrf8ErYx3PC4mg67iAz/OU+qgrVlD6Mk9278+ofX4lHtEYJDR/2sh0w1vJU
 A3S98a/y69ChpbHPAp6qQMlEQhPvfGuMIDcGDbFQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20210805131601epcas5p24ef7b3a94025e99a82549fc46b6de4b0~Ya2hNYyW21931919319epcas5p2k;
 Thu,  5 Aug 2021 13:16:01 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4GgTd75RbMz4x9Py; Thu,  5 Aug
 2021 13:15:55 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 58.FB.40257.B84EB016; Thu,  5 Aug 2021 22:15:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20210805125931epcas5p259fec172085ea34fdbf5a1c1f8da5e90~YaoHzCw4E0613106131epcas5p2J;
 Thu,  5 Aug 2021 12:59:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210805125931epsmtrp14e3f217fc64f12d1d4ae36b0bab806ca~YaoHyMGk_3021830218epsmtrp1X;
 Thu,  5 Aug 2021 12:59:31 +0000 (GMT)
X-AuditID: b6c32a49-ed1ff70000019d41-1e-610be48bc582
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 93.C5.08394.3B0EB016; Thu,  5 Aug 2021 21:59:31 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210805125929epsmtip159e8bda1dc0f0c03379da04be74049e8~YaoGK4eIR1233312333epsmtip10;
 Thu,  5 Aug 2021 12:59:29 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com, hare@suse.de, Kanchan Joshi
 <joshi.k@samsung.com>
Subject: [RFC PATCH 4/6] io_uring: add helper for fixed-buffer uring-cmd
Date: Thu,  5 Aug 2021 18:25:37 +0530
Message-Id: <20210805125539.66958-5-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805125539.66958-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmlm73E+5Egz2n1CyaJvxltlh9t5/N
 Ys+iSUwWK1cfZbJ413qOxeLxnc/sFkf/v2WzmHToGqPF/GVP2S2uTFnE7MDlcflsqcemVZ1s
 HpuX1HvsvtnA5tG3ZRWjx+bT1R6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
 6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
 KTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM7YcmkxW8FS0YrZm3tYGxivC3YxcnJICJhIHL91
 kBnEFhLYzSgxewJXFyMXkP2JUeLEwg+sEM43RoneBd2sMB1/1yyGSuxllJhxbgsrRPtnRolv
 xyq7GDk42AQ0JS5MLgUJiwgYSez/dBKsnllgEaPE1vu/wdYJC3hIzJzyF8xmEVCV6Lr7jhHE
 5hWwkFgyYRPUMnmJmZe+s4PYnAKWEp8P7WWFqBGUODnzCQuIzQxU07x1NjPIAgmBXg6J9Q8W
 QzW7SBw/95kNwhaWeHV8CzuELSXxsr8Nyi6W+HXnKFRzB6PE9YaZLBAJe4mLe/4ygXzDDPTN
 +l36EGFZiamn1jFBLOaT6P39hAkiziuxYx6MrShxb9JTqBvEJR7OWAJle0g0/l/GCAm5HkaJ
 lz+vsk9gVJiF5KFZSB6ahbB6ASPzKkbJ1ILi3PTUYtMCw7zUcngsJ+fnbmIEJ1gtzx2Mdx98
 0DvEyMTBeIhRgoNZSYQ3eTFXohBvSmJlVWpRfnxRaU5q8SFGU2CIT2SWEk3OB6b4vJJ4QxNL
 AxMzMzMTS2MzQyVxXvb4rwlCAumJJanZqakFqUUwfUwcnFINTGUTJ8bEf99306/AnuPXBZbm
 0wxdZzbuqC5wbPY28q63bfzwmEmqoWfSp981939du/Nq3/13zencBy5e2PLk1dl97SlSrJH8
 ul2rcpa9XFGhYuMrn8h6faripSOvHk/ebzJngdnitdf2xpV1V2ieTxDrWLdkziUO5S+7t/uo
 2zEJTlpnudj5wt7sln1/FnnFWOwUfe1Ur958zblgrr9ZSuh7Y4djKmEtR9ax7wjhvGF/uXKi
 WspN64enBdKNVj4/N/l8NJPq2jv9QRUbZtdO7OVcqX5k19ZfJ8425q388kXzb86vTR1zWKW+
 XNvF/+h2iESiVgWTzKptqW6+617MOeUWMvXz6lR1rg/ck01u3ItSYinOSDTUYi4qTgQAY/Ic
 WDkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnO7mB9yJBrNOyFo0TfjLbLH6bj+b
 xZ5Fk5gsVq4+ymTxrvUci8XjO5/ZLY7+f8tmMenQNUaL+cuesltcmbKI2YHL4/LZUo9NqzrZ
 PDYvqffYfbOBzaNvyypGj82nqz0+b5ILYI/isklJzcksSy3St0vgythyaTFbwVLRitmbe1gb
 GK8LdjFyckgImEj8XbOYtYuRi0NIYDejRM/Ub2wQCXGJ5ms/2CFsYYmV/56zQxR9ZJRY/GQ2
 cxcjBwebgKbEhcmlIDUiAmYSSw+vYQGpYRZYwSixu+83I0hCWMBDYuaUv8wgNouAqkTX3Xdg
 cV4BC4klEzaxQiyQl5h56TvYMk4BS4nPh/aygswXAqqZuTUColxQ4uTMJywgNjNQefPW2cwT
 GAVmIUnNQpJawMi0ilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOAK0NHcwbl/1Qe8Q
 IxMH4yFGCQ5mJRHe5MVciUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1I
 LYLJMnFwSjUwtTx8Wr1XaHl8fJ1i610lrwb98C3XpJ1CVPTnOe/iefjkLF+v6eLLx2LW3z92
 QkbTJu3sr3ut22qOt7Ktb7F4PNchcd3ZQzPSTixltztxumL+6/ddXv/K9oR2WhfejKp+FOh6
 s+tFR2zBtka/iFeadx+r//rik1sx4advu95BLdaHQQ4h53yCbipO+z7POMTM8N/sdVv3nePJ
 j9EPfNLYNt8zYXJUwQcLB32l/hyrijUCVs33LyrFWNoIrfm1vaO8XyNb/Xlf5+Fo+5PMz/59
 lPlyMPnClj/OOde3fTzEcDZKu5zTzuH7/p9RS1wl8xsWZkYfeTZRXNYp22ZDR1zMzeaCT1qp
 ji4/rYzE1Q8rsRRnJBpqMRcVJwIAVBzKxe8CAAA=
X-CMS-MailID: 20210805125931epcas5p259fec172085ea34fdbf5a1c1f8da5e90
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210805125931epcas5p259fec172085ea34fdbf5a1c1f8da5e90
References: <20210805125539.66958-1-joshi.k@samsung.com>
 <CGME20210805125931epcas5p259fec172085ea34fdbf5a1c1f8da5e90@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210805_061603_836694_6E7E2FA7 
X-CRM114-Status: GOOD (  17.15  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Refactor the existing code and factor out helper that can be used
for passthrough with fixed-buffer. This is a prep patch.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/io_uring.c            | 21 +++++++++++++++------
 include/linux/io_uring.h |  7 +++++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3361056313a7..1f2263a78c8e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2792,12 +2792,10 @@ static void kiocb_done(struct kiocb *kiocb, ssize_t ret,
 		}
 	}
 }
-
-static int __io_import_fixed(struct io_kiocb *req, int rw, struct iov_iter *iter,
-			     struct io_mapped_ubuf *imu)
+static int __io_import_fixed(u64 buf_addr, size_t len, int rw,
+			struct iov_iter *iter, struct io_mapped_ubuf *imu)
 {
-	size_t len = req->rw.len;
-	u64 buf_end, buf_addr = req->rw.addr;
+	u64 buf_end;
 	size_t offset;
 
 	if (unlikely(check_add_overflow(buf_addr, (u64)len, &buf_end)))
@@ -2864,8 +2862,19 @@ static int io_import_fixed(struct io_kiocb *req, int rw, struct iov_iter *iter)
 		imu = READ_ONCE(ctx->user_bufs[index]);
 		req->imu = imu;
 	}
-	return __io_import_fixed(req, rw, iter, imu);
+	return __io_import_fixed(req->rw.addr, req->rw.len, rw, iter, imu);
+}
+
+int io_uring_cmd_import_fixed(void *ubuf, unsigned long len,
+		int rw, struct iov_iter *iter, void *ioucmd)
+{
+	u64 buf_addr = (u64)ubuf;
+	struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
+	struct io_mapped_ubuf *imu = req->imu;
+
+	return __io_import_fixed(buf_addr, len, rw, iter, imu);
 }
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
 static void io_ring_submit_unlock(struct io_ring_ctx *ctx, bool needs_lock)
 {
diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 235d1603f97e..0bd8f611edb8 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -20,6 +20,8 @@ struct io_uring_cmd {
 };
 
 #if defined(CONFIG_IO_URING)
+int io_uring_cmd_import_fixed(void *ubuf, unsigned long len,
+		int rw, struct iov_iter *iter, void *ioucmd);
 void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret);
 void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
 			void (*driver_cb)(struct io_uring_cmd *));
@@ -49,6 +51,11 @@ static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
 			void (*driver_cb)(struct io_uring_cmd *))
 {
 }
+int io_uring_cmd_import_fixed(void *ubuf, unsigned long len,
+		int rw, struct iov_iter *iter, void *ioucmd)
+{
+	return -1;
+}
 static inline struct sock *io_uring_get_socket(struct file *file)
 {
 	return NULL;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
