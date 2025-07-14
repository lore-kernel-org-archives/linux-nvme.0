Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832E8C83F25
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 09:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y6nLnw0GbLCf4L/h1AinO3RsoOxfQwT7yJtI2iJcrhk=; b=OKYhyDNO1e0c/Q1uRcf+F0hfEA
	lXz+ky7a8LSCm4g0KckkirzccSiOIe5SVlwUS8qnad34vPZMcGo/K+mxThaTi6Dd6uceqp4X9QJgq
	Dco+PMlWmhHcPl+UHlPOTKnaC54xmvOugnkAb7eRP4FX+dkQAkn7vyHPUU7l3N+UCuoVleXsr0aEZ
	sQl3po9UBS9MoBgt4u+0FeS769kllCxtIIiRXvQDsDNiFNrvyb85TXHwyUMt+ixAWgF4AUh/ZzsWC
	XxrxeTEWyFprvJ/UKYolKct27uRaKT9iXxg/l9+YYKvnXqi15bzTkDwgBP+252tc7covzp8hgi3KM
	/u9tFGmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFId-00000001kc4-3i7R;
	Mon, 14 Jul 2025 09:16:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFIW-00000001kXo-3mVc
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 09:16:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 01BD2467EB;
	Mon, 14 Jul 2025 09:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C26FFC4AF0C;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752484591;
	bh=EHkkGMG990RW999qEL6xHGIOP1Da82Ed2KKxscvok4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dHYti68u5key3zQoDOmqHc1mq5/Ji1JpVzQ3rNOXdksoiB56fb8yC1EVTVun1uPP7
	 LBntUcZvWq8ofUdCL7vz+3mxBJbBHGPzoBuFwQQOdoaPBMMyuBsDMqwxh7WkJ5MBOr
	 rCHT4k4SQTqcz4jv9eSRfO1ma5pJelcKnB7DaBcBN4YW/tSqQfnYcxHGNAU24Ei4xb
	 6RQHb3BEvhWaegwNVCO0u5rBCm//mlCNubqAIa3T1ttwZUEjCItGjS611zyCZpvj4i
	 VUEs1lSBOjqcxsVBRMNjhl/qTbVMpGGumsFiPUXIUcupZcZFsSaDdF9mUaAAzubs8V
	 yxfh3lDgAf0gQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB39BC83F26;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 14 Jul 2025 11:15:37 +0200
Subject: [PATCH RFC 6/8] nvme: Add a release ops to cdq file ops
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-jag-cdq-v1-6-01e027d256d5@kernel.org>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
In-Reply-To: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Klaus Jensen <k.jensen@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=EHkkGMG990RW999qEL6xHGIOP1Da82Ed2KKxscvok4M=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGh0yuzCPnoh3XuDoNYYYg9pd/tFQFMVzY5jm
 1hhsoBW+XgbM4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJodMrsAAoJELqXzVK3
 lkFPKH0L/0qsA6rA7Qq1k+nKg8zYcsedZJbW9A+9Njb5EJ9ozssyLfDi/X3F7mERgG3L4s06IMM
 lIXAJW6WeOi/bsENRotDv1nJmzZYbHF2zEjNjYnM0WgGbOzxHk1vgAmvd8ZXk61GAqal+gm4MsB
 7CxCoxBnFGCmzkpuOdqJrMM2FGQ8JROLPd0tqkwwbT0G+BvFp6UU8luqhfy9T8BVohqsBriRiRL
 tpUfm7nj9DqOhLMNMUhUbkbWdANEGzhvSioV2Dxtd+JbGMzIH72e4wZAG3Vrf7Pl5X+yP/IFd4d
 fxxHgq1CEQnRJscAFA05rYDaTQjKVgHkfZqNAhAkRtyetX4OU9B+MrcQ/pMze3S5MrrfAsEmc0T
 mT++IqnKhop6Jv88b6GXHvIWzgsPg+SfttxF91MNHrxJEJ9O8AvLuNTxB24lh+vQ5SzLG65cxzN
 ccvbUNGREcQtQXRNn3qGPeKVjA7X49tGvIPT/QcJvCXbDB6WQ6CGllmjtwMKNVsj8EHt2j02x97
 HE=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_021633_001514_26916B4B 
X-CRM114-Status: GOOD (  11.49  )
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

When user space calls close on the file descriptor or crashes,
nvme_cdq_fops_release will ensure everything related to the CDQ is
properly released.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 427e482530bdb5c7124d1230f35693ba756ce4d9..4745b961c6b874375ff4399c104f312b5ac608b8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1313,10 +1313,18 @@ static ssize_t nvme_cdq_fops_read(struct file *filep, char __user *buf,
 	return nvme_cdq_traverse(cdq, nbytes, buf);
 }
 
+static int nvme_cdq_fops_release(struct inode *inode, struct file *filep)
+{
+	struct cdq_nvme_queue *cdq = filep->private_data;
+
+	return nvme_cdq_delete(cdq->ctrl, cdq->cdq_id);
+}
+
 static const struct file_operations cdq_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nonseekable_open,
 	.read		= nvme_cdq_fops_read,
+	.release	= nvme_cdq_fops_release,
 };
 
 static int nvme_cdq_fd(struct cdq_nvme_queue *cdq, int *fdno)

-- 
2.47.2



