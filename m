Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C500CDB46F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 14:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=n4dcnQDRYO7g/pijledoht4bAUk0uf+z8Em1nWTfv0s=; b=tBnGwqbqb2O9xn3M9xPvbx13D0
	H8X1qMtT+QQ3MgUti9LTRXjbk9bn4LMEeGRmWQDFei/sd8KOQ434g9SdXxXy5qaNxLsEYAtKrlpZ2
	DPicsBlLmbjF+orPEHkSldxGxT9oDLuxmH2Fp56WPlhUfCQMb0vnRhpIBhEEkog+QqecDJYWdMHut
	wpvZxzyXxOe2fSASiydrjW8JVknHsiDB+d9LGyxu6ifeW0Or1IbUHL2wzCyS6VmkIU48bsnPXRpd7
	vSjYt9v3bYKiDY3TMqt5KS8yNOjvwLhHJb40k6HKgY8kdRdNqvyq7xOz+C1vTwGkaVNJ7AmloJWEZ
	bsIxiX+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbfZI-000000053vM-0PxU;
	Mon, 22 Jun 2026 14:24:08 +0000
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbfZF-000000053uw-3SgN
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 14:24:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=n4dcnQDRYO7g/pijledoht4bAUk0uf+z8Em1nWTfv0s=; b=leumnoGD5LZ71B
	pHBi2q92ciQtCwK5pV2KwHivpCcR3MFR6kQM33GX6+IMp7uRo9y9Sdz/OsF+oWn1k80KTy/SrONM5
	8zdNiWPtISUz9xUGtzkrNNB7ueuiqPf0iBHOJz2gCE5vctQMXTXVvdwCtTN0+G61Le48Pn0sTVBdQ
	6HVVivdFCyEvHebJTg9MKkAGsVfWW/6i6V2N+QzOZKa+TTLFHcMhuHHzpPJrIwQPhPORFiRpiH/vp
	HdL9zZskLrvO60bWvhnecEDFeXHGZWi1IAlwKBtGAEY/D27CpWsROMxuKJfLxgLals46jXpzqwStr
	ui8iNHPxBYzuBXEEd0XQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wbfZ8-00EpVl-Lg; Mon, 22 Jun 2026 15:23:58 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1wbfZ8-000000024i3-1CN0;
	Mon, 22 Jun 2026 15:23:58 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] nvme: make unexported sysfs structures static
Date: Mon, 22 Jun 2026 15:23:57 +0100
Message-Id: <20260622142357.494750-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_072405_873173_035E6489 
X-CRM114-Status: GOOD (  13.03  )
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

These sysfs attributes are not exported out of sysfs.c so make
them static to remove the following sparse warnings:

drivers/nvme/host/sysfs.c:397:25: warning: symbol 'dev_attr_io_errors' was not declared. Should it be static?
drivers/nvme/host/sysfs.c:444:30: warning: symbol 'nvme_ns_diag_attr_group' was not declared. Should it be static?
drivers/nvme/host/sysfs.c:1150:25: warning: symbol 'dev_attr_adm_errors' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/nvme/host/sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 933a5adfb7af..75b2d69b5957 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -394,7 +394,7 @@ static ssize_t nvme_io_errors_store(struct device *dev,
 	return count;
 }
 
-struct device_attribute dev_attr_io_errors =
+static struct device_attribute dev_attr_io_errors =
 	__ATTR(command_error_count, 0644,
 		nvme_io_errors_show, nvme_io_errors_store);
 
@@ -441,7 +441,7 @@ static umode_t nvme_ns_diag_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-const struct attribute_group nvme_ns_diag_attr_group = {
+static const struct attribute_group nvme_ns_diag_attr_group = {
 	.name		= "diag",
 	.attrs		= nvme_ns_diag_attrs,
 	.is_visible	= nvme_ns_diag_attrs_are_visible,
@@ -1147,7 +1147,7 @@ static ssize_t nvme_adm_errors_store(struct device *dev,
 	return count;
 }
 
-struct device_attribute dev_attr_adm_errors =
+static struct device_attribute dev_attr_adm_errors =
 	__ATTR(command_error_count, 0644,
 		nvme_adm_errors_show, nvme_adm_errors_store);
 
-- 
2.37.2.352.g3c44437643


