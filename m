Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25F5C19F32
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 15:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c462OaYKk6lfJmqhikiFrNOzY7hRupVX/eToM6qJ92c=; b=hHSsuH4q6cLs/i12G3viWNhAuN
	aoN1wBP0IHUxpU1x3gxK3IoWflzY4Ap3+aNXRUWT7Ax3QqmRPnNLmF5+wITy11CqcnU0qwt8wazFq
	1BL0ZaE9RcUaXvNVxkuunZBvUKz0EF9tDtQIB0XDIRfDBJQbzcJz4BdeIvf+LC7iDmfX0abY7o9Ol
	91Q0iyhjOjuHxyivXWK2bRsd504dvpR5A6v2ew11weP7n8kFHAvXQVT78hGaGoVijdzcsfOsf3bw0
	0weXAY+T9uhuz5Ub6G6w95DsYoGc1aMdcLjHHL6i7p1AU+UyXQnGUBwdebM9kV65cIgdLv70ZrWmk
	xzN7S24g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpr3s-00000008ZXE-1Hbu;
	Wed, 05 Mar 2025 15:53:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpr3U-00000008ZUf-3rOX
	for linux-nvme@bombadil.infradead.org;
	Wed, 05 Mar 2025 15:53:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=c462OaYKk6lfJmqhikiFrNOzY7hRupVX/eToM6qJ92c=; b=fHuN9xqVxvfa9Xo1UvgoJmAL1/
	lSgogJqySa1kASZkDvOJqM1DkZ9SQ6ehGDPcYPxUNioEpusYGvOiYfRv+vvfbk4OLe3tw4kDE1Jvg
	GRIjtLDee3HeinhixjEYkjEJfZLyAs9ic16q1KAwoUOksy7T4pImAvftLPjlN6+8WfS+9euHq9Dp+
	UboD6pp/YHA7VCZgsgiVARkKTmSDkpm+naDjyaM5lFPHiofxwZ0evfGci/meXwp2cbn+xy4vLVp9/
	zgX/6GTOcOMmcbJiQEOcAna89g8LW7MMzu/dj/BYvuCy0k9WZsD6tmY9jbiiX0t28lq99y7rkqQrt
	0zBLu1dQ==;
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpr3R-00000000cIe-3eaK
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 15:53:07 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-43bc48ff815so7024695e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 05 Mar 2025 07:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741189983; x=1741794783; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c462OaYKk6lfJmqhikiFrNOzY7hRupVX/eToM6qJ92c=;
        b=SILWkSNB6i/fAEcXeGLiwaucFItzyAK+tyPIVzsw/Mn9vUTyxMYW3JV0sHbQLELjYU
         +1Cf8y+v1QdX0MBJ6ct7VtEfgN1mKbgRGe9aqm3pRxVUlRLgwUq6WZid2L7Tp+D4MiQH
         v6OeEtExOzEjG7vlUUY5yqC70Ja7xpI+vE1QqIJF7XqQ8/pv4ajG9B4zemOiKaeWMADV
         o12dqn8/1/aZmLpHVBwOC4c3exFUzJGcNMbl4cOzcu/sHMB7LRrLNDbhSiGCYxaJ3sOr
         lngGZmIhPiLO2w9fBGus82H++UXW+etveKoYnSWvfoYoYoKTd6+LTCwtZGm0fHHcH5Jp
         OyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741189983; x=1741794783;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c462OaYKk6lfJmqhikiFrNOzY7hRupVX/eToM6qJ92c=;
        b=JJ//vWtpzZsdaF21/MURMHIGn+nFi9kqmKhHfero7nnhUvvn3eSROlfXRVZGT1D4MV
         OdkBOXZ5LavgaMUaGvucOT5E4RLRGzoywf2Ve+2ShW8RttY3M3TIg8yJfA7cV4c4BHgR
         6g0XstR/LFbStzHBu8W2qqurCcaXGKmkahFlsRGUcvI3kp1zbqTBsnkAhTnt75tfSQ9I
         lk9ajKB0APDhUBp6/lUusikQ3efZyZyjNWESTV/xu8O3sp27B4YHdD7HEnEPNkeNMXns
         dvxEMr8QIjG4IZeoJ60+GUDqdNQmiUZ0nGsRzGLhII6ItdSmqcMRyESUhJ4obPKXnIlB
         CibA==
X-Forwarded-Encrypted: i=1; AJvYcCWX3RNeEOemiM6ScObXC61ryCLN4ne4h5SyYPAZrzXT5/1DYsIG9mx1Q6y79Yj6JuuudXwDaQjPXeTS@lists.infradead.org
X-Gm-Message-State: AOJu0YzslXKjglkqlqwc4QtPPJwX5ViMs/l0pcWtf37EOaUPhomRL8Rt
	WMkQOpvCITUy5Zlqd9lcsCb0478wc2dDumwomO3+Ae26YgYZYTw7Ilb+CMNhcOM=
X-Gm-Gg: ASbGncuKRBB7WJP4Y7ksNBnMa3qPc9Bu9kbELtHed2svUFWIhE0+tUtWrpMrr2SFFMF
	cU3Bc4aXKDkPbh2FdikxlgYnfDBu4OTrbts1PibImH0bDFILeJOL3Q7T9ynDRa437YJumul3r3K
	S8ElIFeO1mWZUWgeEZDQuL+hJOxNYmZQJuE9IjxfoG0zA5Pntq2A7MSV15WjwdTZYbNSy1Lue3F
	LyvXyhOoZRJuW+YCMSESGBmWyWcvJpy0iMkviIyF8JTClTCIuFz8vG3a/QTgwIYThpnD/xuRXN+
	Ie9BFaTdUtiIs7KepQw6H/HqkiiC7hTYVoLA3uCeYLsDelTISQ==
X-Google-Smtp-Source: AGHT+IEqknS+DmHCo8DS6gOa0BLl6DqpnB9v43dYGVNmBmhgHO9bWC9dVwlJMAbbJBAtRqT0CdjIig==
X-Received: by 2002:a05:600c:310d:b0:439:9737:675b with SMTP id 5b1f17b1804b1-43bd20b5147mr31087475e9.7.1741189983473;
        Wed, 05 Mar 2025 07:53:03 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd41c7cc7sm22761795e9.0.2025.03.05.07.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:53:03 -0800 (PST)
Date: Wed, 5 Mar 2025 18:52:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] nvme-tcp: fix signedness bug in nvme_tcp_init_connection()
Message-ID: <d3661d33-096a-45e3-8304-1123fd031527@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_155306_022810_B740BF7B 
X-CRM114-Status: GOOD (  17.13  )
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

The kernel_recvmsg() function returns an int which could be either
negative error codes or the number of bytes received.  The problem is
that the condition:

        if (ret < sizeof(*icresp)) {

is type promoted to type unsigned long and negative values are treated
as high positive values which is success, when they should be treated as
failure.  Handle invalid positive returns separately from negative
error codes to avoid this problem.

Fixes: 578539e09690 ("nvme-tcp: fix connect failure on receiving partial ICResp PDU")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
v2: Change the style.  Add the Reviewed-by tags.  (I will feel really bad
    if I introduced a bug in between v1 and v2 and cause everyone
    embarrassment with the R-b tags.)

 drivers/nvme/host/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8a9131c95a3d..b23ce31df97d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1495,11 +1495,11 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	msg.msg_flags = MSG_WAITALL;
 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
-	if (ret < sizeof(*icresp)) {
+	if (ret >= 0 && ret < sizeof(*icresp))
+		ret = -ECONNRESET;
+	if (ret < 0) {
 		pr_warn("queue %d: failed to receive icresp, error %d\n",
 			nvme_tcp_queue_id(queue), ret);
-		if (ret >= 0)
-			ret = -ECONNRESET;
 		goto free_icresp;
 	}
 	ret = -ENOTCONN;
-- 
2.47.2


