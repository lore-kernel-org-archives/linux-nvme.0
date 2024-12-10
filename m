Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660A6E7717D
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 00:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xbnuhuWyJh5uw7aVsu3ZYXk49NwDHnfoGivEgN+cSJA=; b=GMUJ8Zc04/y+Q5hka7XK31a/GE
	Q2zqekyo7cq0q3N1CPn4iC0O51tLOFA+kyhsSfS8CksBaD5yh9UUSgYc/bEejlI5FEB1DSEtd93SC
	N5clLcNH7pTdRgAvqxFu30+Zhjctyu15sQqzHPBSLuejYiYkZjNXRTvNcpJgiAopePXUCnH7EJWoM
	hmngboUsDtLbeJZL/IxU5Z1pzvyqktPPxyWYg3WwhHkzqD3DKtweBNUa7pVwhT/H142W/0IxXeglQ
	egv2okhFhZtY5REBMpkoHo31JjIQrhtQG0QWFON3A00W0ABhxJuiLcCF5GNkWEDZ0wjVG6wa4JX9x
	GWhPKG+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKnge-00000009dc8-0cQA;
	Tue, 10 Dec 2024 00:01:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKngb-00000009dar-3Ur8
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 00:01:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AEFED5C0F8C;
	Tue, 10 Dec 2024 00:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903BFC4CED1;
	Tue, 10 Dec 2024 00:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733788869;
	bh=Ale575IuPr4rm0n9SxYopveFK7nxTzikh2cw1OPXyXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULjKlIxFUDu6c55NKRJ9eQh7ONe6Pivr+GcB558lh5SSvZqwQVxNcCqx7QaEWKgnv
	 PbEbrp/F7tulOcB23nFO4gbV1pHFkuQ3vohs5bROxuQ/dsAJ/PboKcucWBrEniIHiz
	 ZPmZ4xbGr1Nf5sL8kFY/sGr01+SHfq8JIVU9PWN/Cho9pJrgpqKzucbZLqMMpa28/t
	 4JM9kCcy9Z7H7v5r+uArilba6hBaBURLN+8R8IbPhfF4SalF+u0lEM+9a+7+uJE4QC
	 Im5GQa1MqjWrcHOCJWFQCX7BiWzrZjNP9sFCx0K8EXbSLIBhp0HY5fe9MFK5H48+y/
	 M+YNdZUsapoxg==
Date: Mon, 9 Dec 2024 17:01:06 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yongsoo Joo <ysjoo@kookmin.ac.kr>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: change the return type of nvme_poll()
Message-ID: <Z1eEwms3ArQBNHE-@kbusch-mbp.dhcp.thefacebook.com>
References: <20241209133343.125885-1-ysjoo@kookmin.ac.kr>
 <Z1cQXGWGRZ5dcWOW@kbusch-mbp.dhcp.thefacebook.com>
 <Z1djnrzTvra6wyMn@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Z1djnrzTvra6wyMn@ubuntu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_160109_912460_A313C5AD 
X-CRM114-Status: GOOD (  22.36  )
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

On Mon, Dec 09, 2024 at 09:39:42PM +0000, Yongsoo Joo wrote:
> On Mon, Dec 09, 2024 at 08:44:28AM -0700, Keith Busch wrote:
> > On Mon, Dec 09, 2024 at 01:33:44PM +0000, Yongsoo Joo wrote:
> > > -static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> > > +static bool nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> > >  {
> > >  	struct nvme_queue *nvmeq = hctx->driver_data;
> > >  	bool found;
> > > -- 
> > 
> > This function is registered with blk_mq_ops, so you would have to change
> > the prototype there too, and every other driver that also registers a
> > poll op. Honestly, it may not be worth the effort.
> Oh, I overlooked the issue you pointed out, which brings me back to my initial 
> suggestion. The function nvme_poll_cq() returns the number of found CQEs, but 
> nvme_poll() seems to unnecessarily reduce this information to a boolean.

Can we just change nvme_poll_cq() instead to return a bool instead?

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4c644bb7f0692..54910f8eadff8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1148,13 +1148,13 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 	}
 }
 
-static inline int nvme_poll_cq(struct nvme_queue *nvmeq,
-			       struct io_comp_batch *iob)
+static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
+				struct io_comp_batch *iob)
 {
-	int found = 0;
+	bool found = false;
 
 	while (nvme_cqe_pending(nvmeq)) {
-		found++;
+		found = true
 		/*
 		 * load-load control dependency between phase and the rest of
 		 * the cqe requires a full read memory barrier
--

> A minimal change from "bool found" to "int found" in nvme_poll() would 
> preserve this information, allowing any interested researcher to make use of 
> it. Also, the description of poll in blk_mq_ops can be expanded as follows:
>        /**
>         * @poll: Called to poll for completion of a specific tag.
>         * Returns the number of CQEs found.
>         */

Since you pointed this comment out, I see it is from an earlier versions
of this interface and outdated. The current behavior polls for any
completion rather than a specific tag.

