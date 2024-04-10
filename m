Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502DACD11C2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 09:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LDT/oY3awcAwQE4mcsuVEFxbVxfgOvx8G4jS3rgNFkI=; b=atn7+sEJE6Nb3rgolKObGxceeM
	061aRMsZwjtiqHKW7vN5SfxJTmEJn5cgC33m62pdaENKtT6cK/yt+Syjn0whyZXNrEwNRDx3aB3H3
	0x6LQLYgUgRBkgawwUFqxKSJPjhlahTByTWAg1Mcqeb5jmc53i9p+avtWqTKrkGslTt7Yv+6ZWwEM
	cTz0lGHNP3J7y1sd87YdAalZDb0mqHFJdHMBDswI/cYmsueCsH+j0l7DZ8Sl7WRHedFt4XHw7j+f3
	iXexYNnkW+mJVU88EhPXF4N11e7hGQxuCLLei0fDV/89AT7ttEHn/dG/xQGgE2LRuLwqwGx3+QjLo
	XnGipFRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruUbj-00000006ENR-2o05;
	Wed, 10 Apr 2024 09:51:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruUbf-00000006EKl-2zEO
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 09:51:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712742661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDT/oY3awcAwQE4mcsuVEFxbVxfgOvx8G4jS3rgNFkI=;
	b=St9xOS0vnHIWWujFcRMECZ30g+4QumPkSqNRZx9aNa4VK9XsalDnvjXsYT4wRWSc+fMvbn
	L877/qyt6+kXgIrIHvaUfLZZaZbITfzL0vHQ5BB4DsYkFWrGextoJOBQCLAjvmE/8HHojM
	68/HuLyZdB4Qd/yUElmjkznz/vNs52Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-cybhMVMANkScpi_eOtZiIw-1; Wed,
 10 Apr 2024 05:48:54 -0400
X-MC-Unique: cybhMVMANkScpi_eOtZiIw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93A6638000A9;
	Wed, 10 Apr 2024 09:48:53 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.181])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 02B18492BC6;
	Wed, 10 Apr 2024 09:48:51 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: sagi@grimberg.me,
	hare@suse.de,
	dwagner@suse.de,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvmet-auth: replace pr_debug() with pr_err() to report an error.
Date: Wed, 10 Apr 2024 11:48:42 +0200
Message-Id: <20240410094842.370170-3-mlombard@redhat.com>
In-Reply-To: <20240410094842.370170-1-mlombard@redhat.com>
References: <20240410094842.370170-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240410_025103_907171_4EA62971 
X-CRM114-Status: UNSURE (   9.19  )
X-CRM114-Notice: Please train this message.
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

In nvmet_auth_host_hash(), if a mismatch is detected in the hash length
the kernel should print an error.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/auth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 9e51c064b072..fb518b00f71f 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -285,9 +285,9 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	}
 
 	if (shash_len != crypto_shash_digestsize(shash_tfm)) {
-		pr_debug("%s: hash len mismatch (len %d digest %d)\n",
-			 __func__, shash_len,
-			 crypto_shash_digestsize(shash_tfm));
+		pr_err("%s: hash len mismatch (len %d digest %d)\n",
+			__func__, shash_len,
+			crypto_shash_digestsize(shash_tfm));
 		ret = -EINVAL;
 		goto out_free_tfm;
 	}
-- 
2.39.3


