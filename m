Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D338AC83026
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ELm99uPzefns5ujW7UPEs6wpoLN78rLcaBSD261dIAg=; b=JI9wOBVoUbtZYczkBO+e5Jkjlo
	JQpnt/xFAh6jP2f+Tam+dWRcC/rKxGx8JGRH0GfR1et4xgWOZtiB781Uq1Bj6U/ZS4IBXQb7lXMum
	mWJIO6ZDkHZyG/IPsfMhU5Z4+ZzROJqJSoNyS9r2OiRVCkK0ZAviu83GxIx1DQWGzZVk8Q0yFpp//
	n2BsIQtb9Wsri0BzzsJjD5kD6L+8elbgnNqG3lblt1aJ+vnudCSkoYN7t9zMGkOlR02xf5MkBmyWr
	8wO2g+WfmMH/y/wl6KU8tpJwMevGa9GeZiiKzvQzT0/NzPLLU17UFgP1hAB1saGhSisu90qsAvCSf
	+Om7IMow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAv8-0000000F4Dp-0WqW;
	Fri, 27 Jun 2025 15:23:18 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAhe-0000000F0w7-3m9o
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 15:09:24 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-ae0df6f5758so284568866b.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Jun 2025 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751036961; x=1751641761; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELm99uPzefns5ujW7UPEs6wpoLN78rLcaBSD261dIAg=;
        b=cQ2rwqB4EnHRjP/kmHQgXrcahU9F+sy+Bo8w0FoHhfZhKE+fRna8MH3J1uON6BxwFf
         mMtQhXfXWOoky8yUqbiAHod0/Z3MVx8ncoE21dsrwawUq5cR8W7krgNUWFluqS+/Ft4/
         x5e7GR1H8Un2pYNA9mkpVHazlwYNWrEOLMYF/sadVTGiLzbLaYzxlGe4z4I57aiVY/Ga
         hfPKt6pYsWwNO56WVZ9oJZsMBS5q4u8zyKZhmEBA9wqM1XerNWT3ovKmBjJimE/F+OA+
         3ejofNYbgQN9xmtEoRMy4x2wFl9LmQ4w25BLBLR7lQMh7ZZUEsLrFExUUvupSkcPtCFV
         g4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036961; x=1751641761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELm99uPzefns5ujW7UPEs6wpoLN78rLcaBSD261dIAg=;
        b=aQ7ttQEWRKkcWhb31hO3I9iHLphUi70FJIwb8FQUaghz3SEYpuyK2D3QVi+99OqRNU
         jk5VHXCp2yRVc1hlOZhIYKvKmQtZxZS0PzzzR8WpNDQat/8WOcvvkPp9lCwE+7Aa5gSl
         VuTtYymf1ltpX40wRwGZ7x+qk2HO6l5rhx+W8gmkW/PpjNKxieVFQpiMTcJuZetc8J5A
         aXl6aRd0aTimInZdqBK6SoBWcpoMLlMtQRzrXddpCz3RpigkBkd6UGbJOs+Bm4qoPvrh
         7Bu8bkV8TL5wW8F/iB9TVpWaQCoXk39hlpGskiA7BdJPOmPMN5HzT3zFYQpqMp43qUKW
         2svw==
X-Forwarded-Encrypted: i=1; AJvYcCXLC3qOo18TuGLRuDDsnetdyPBjcyNUOXu60p/DR04AXEQgFVfFTAl6N8/EIa77laEVchHz0YoxN8ee@lists.infradead.org
X-Gm-Message-State: AOJu0YxuhmkhCP5Z3/uMljdI4GHdriz71jX8fsJXEzx7JELUsod7LjYt
	VMq+RKCda4uHeVcAvXjo5bO34Po8h0dRXJ8t75tUAHqbbIrpqmHxryEC
X-Gm-Gg: ASbGnculhKiAEAqfR5NWr4lM7bwjXl+DSJZ0ucio/2joi65fOflV4A8suaJXpj/75xm
	kNN2kiedLBz6+T+MS/nfOfhHmbEFSfi60Xu4tHUwP8QgFE1cM97tVOIR0FQJfYSqaDbGyrt0v/k
	uw2zbdKSpnasi0gNqIgG4umP7r7jI5efycLphK6C835KKHQ5yebymvSs1+YXUk3xxRyS8BuBoha
	YwQ4SjxOGdkzRRHQPyBDf6QcDptINsyzfyBeQmMP3RuYxaq59+Aewd7dCgjqmzCRroQR0+Iiu5z
	hR+pQtcCcStGoM/SwHrm0NaWPHx5dOtn2bNXD96T31yQ0/UaE/jW1RF77l6XgSGweJQQq4fu89X
	AjErS0+5sjiM=
X-Google-Smtp-Source: AGHT+IGtD0aKzaeEpz5uiE2KrXY9RJd/4VVbesLyvcMptugbexjQLqKCOv+z9jBUY0enkQpZug83hQ==
X-Received: by 2002:a17:907:724f:b0:ade:8d5a:cf37 with SMTP id a640c23a62f3a-ae35011fc71mr334022966b.44.1751036960987;
        Fri, 27 Jun 2025 08:09:20 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.147.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c014fbsm135802866b.86.2025.06.27.08.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:09:20 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Vishal Verma <vishal1.verma@intel.com>,
	asml.silence@gmail.com
Subject: [RFC 02/12] iov_iter: introduce iter type for pre-registered dma
Date: Fri, 27 Jun 2025 16:10:29 +0100
Message-ID: <66ec20266c87e323f365fcc82b60f00aef6e2334.1751035820.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751035820.git.asml.silence@gmail.com>
References: <cover.1751035820.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_080922_941098_85593CA3 
X-CRM114-Status: GOOD (  20.12  )
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

Introduce a new iterator type representing vectors with pre-registered
DMA addresses. It carries an array of struct dmavec, which is just a
{dma addr, dma len} pair. It'll be used to pass dmabuf buffers from
io_uring and other interfaces operating with iterators.

The vector is mapped for the device returned by the ->get_dma_device()
callback of the file, and the caller should only pass the iterator to
that file's methods. That should also prevent ITER_DMAVEC iterators
reaching unaware files.

Note, the drivers are responsible for cpu-device memory synchronisation
and should use dma_sync_single_for_{device,cpu} when appropriate.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/uio.h | 14 +++++++++
 lib/iov_iter.c      | 70 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 2e86c653186c..d68148508ef7 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -29,11 +29,17 @@ enum iter_type {
 	ITER_FOLIOQ,
 	ITER_XARRAY,
 	ITER_DISCARD,
+	ITER_DMAVEC,
 };
 
 #define ITER_SOURCE	1	// == WRITE
 #define ITER_DEST	0	// == READ
 
+struct dmavec {
+	dma_addr_t		addr;
+	int			len;
+};
+
 struct iov_iter_state {
 	size_t iov_offset;
 	size_t count;
@@ -71,6 +77,7 @@ struct iov_iter {
 				const struct folio_queue *folioq;
 				struct xarray *xarray;
 				void __user *ubuf;
+				const struct dmavec *dmavec;
 			};
 			size_t count;
 		};
@@ -155,6 +162,11 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_XARRAY;
 }
 
+static inline bool iov_iter_is_dma(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_DMAVEC;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->data_source ? WRITE : READ;
@@ -302,6 +314,8 @@ void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
 			  unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
+void iov_iter_dma(struct iov_iter *i, unsigned int direction,
+		  struct dmavec *dmavec, unsigned nr_segs, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f9193f952f49..b7740f9aa279 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -559,6 +559,26 @@ static void iov_iter_folioq_advance(struct iov_iter *i, size_t size)
 	i->folioq = folioq;
 }
 
+static void iov_iter_dma_advance(struct iov_iter *i, size_t size)
+{
+	const struct dmavec *dmav, *end;
+
+	if (!i->count)
+		return;
+	i->count -= size;
+
+	size += i->iov_offset;
+
+	for (dmav = i->dmavec, end = dmav + i->nr_segs; dmav < end; dmav++) {
+		if (likely(size < dmav->len))
+			break;
+		size -= dmav->len;
+	}
+	i->iov_offset = size;
+	i->nr_segs -= dmav - i->dmavec;
+	i->dmavec = dmav;
+}
+
 void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
@@ -575,6 +595,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 		iov_iter_folioq_advance(i, size);
 	} else if (iov_iter_is_discard(i)) {
 		i->count -= size;
+	} else if (iov_iter_is_dma(i)) {
+		iov_iter_dma_advance(i, size);
 	}
 }
 EXPORT_SYMBOL(iov_iter_advance);
@@ -763,6 +785,20 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_xarray);
 
+void iov_iter_dma(struct iov_iter *i, unsigned int direction,
+		  struct dmavec *dmavec, unsigned nr_segs, size_t count)
+{
+	WARN_ON(direction & ~(READ | WRITE));
+	*i = (struct iov_iter){
+		.iter_type = ITER_DMAVEC,
+		.data_source = direction,
+		.dmavec = dmavec,
+		.nr_segs = nr_segs,
+		.iov_offset = 0,
+		.count = count
+	};
+}
+
 /**
  * iov_iter_discard - Initialise an I/O iterator that discards data
  * @i: The iterator to initialise.
@@ -834,6 +870,32 @@ static bool iov_iter_aligned_bvec(const struct iov_iter *i, unsigned addr_mask,
 	return true;
 }
 
+static bool iov_iter_aligned_dma(const struct iov_iter *i, unsigned addr_mask,
+				  unsigned len_mask)
+{
+	const struct dmavec *dmav = i->dmavec;
+	unsigned skip = i->iov_offset;
+	size_t size = i->count;
+
+	do {
+		size_t len = dmav->len - skip;
+
+		if (len > size)
+			len = size;
+		if (len & len_mask)
+			return false;
+		if ((unsigned long)(dmav->addr + skip) & addr_mask)
+			return false;
+
+		dmav++;
+		size -= len;
+		skip = 0;
+	} while (size);
+
+	return true;
+}
+
+
 /**
  * iov_iter_is_aligned() - Check if the addresses and lengths of each segments
  * 	are aligned to the parameters.
@@ -875,6 +937,9 @@ bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
 			return false;
 	}
 
+	if (iov_iter_is_dma(i))
+		return iov_iter_aligned_dma(i, addr_mask, len_mask);
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(iov_iter_is_aligned);
@@ -1552,7 +1617,8 @@ EXPORT_SYMBOL_GPL(import_ubuf);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 {
 	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
-			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
+			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i) &&
+			 !iov_iter_is_dma(i))
 		return;
 	i->iov_offset = state->iov_offset;
 	i->count = state->count;
@@ -1570,6 +1636,8 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 	BUILD_BUG_ON(sizeof(struct iovec) != sizeof(struct kvec));
 	if (iov_iter_is_bvec(i))
 		i->bvec -= state->nr_segs - i->nr_segs;
+	else if (iov_iter_is_dma(i))
+		i->dmavec -= state->nr_segs - i->nr_segs;
 	else
 		i->__iov -= state->nr_segs - i->nr_segs;
 	i->nr_segs = state->nr_segs;
-- 
2.49.0


