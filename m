Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187EE606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uTuZCcPY;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=se8NGDGV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rJYfrBILSClCR04UlysysrpC1Bblxj8hTGa/c5sK++o=; b=uTuZCcPYjkKW3W
	axcrYPhpGS6txra/EKCKN9U5j0+7NsFFaKnqHzdorxx1PNZQiGFS9ZBv0ndawOlAlXnQshtr3rML2
	rYhWHnzepTjlzsQlrrTGmiQgTUgz5fzPRMF1c8Gm7ftcfklg5THeBrfo2I2Cj1SYQF8jHNLIHNxuk
	kA8jHp9HbolFiJsgP2RQEGXaArxd2ap81Ifh8iNV4cNGuDzjARFVQaehTNjlKNCZITVDHwBpnHBPh
	FMwxFSEqtPwJyWArYNuFZ6dY6EKsE8JhhFsJ/ZTzVPTN0llYaCNKgk25HmUeos3xMl+qW1ozeIIAg
	7Y31SzLBo2Dj3Rh5VZZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xStYF-00000001t3B-35fZ;
	Mon, 16 Nov 2026 10:03:03 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xStYC-00000001t1m-3OEu
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 10:03:02 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2ed2bfe3252so10545305ad.3
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 02:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794823380; x=1795428180; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rJYfrBILSClCR04UlysysrpC1Bblxj8hTGa/c5sK++o=;
        b=se8NGDGV+JaGKmk/drDkyacedNOetiTQ2/aMW86EIOkLUwy+sZ3NSm13k/fB4K7adI
         4w2gFwqCHJ6beAPZsOsPaDW1pvHDaVLxZQqJ1JQsX8zSbSTKAi2gTwOXiBkyVkIT5nt/
         QG0YgsVsmjfrcep+4fNrmqhcaQqZR/SnNO1PBOhltDgPvQUmyC6QNzj5thFiQCk1V6Eq
         8lMZ4x0DbzOVHUmEY2jyEC/W3FetdTprkDggEMQNhYQKlXXd9YvPCWjMovG22EpI3Vlk
         xiFdykyYIFGKd4sH/l9wF7LLo+Mp2QFylEErtKfdxFrZdaXZVjV/wN+ch3s4JTogChl6
         +0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794823380; x=1795428180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rJYfrBILSClCR04UlysysrpC1Bblxj8hTGa/c5sK++o=;
        b=Cb1iWZ7MCGOTyOTOwCP9EvJJgL68ckyB4asHWbr1JmW1zccoir1WFMkXsmyY+3eIQP
         duEZvlA6ICFNeOXuSwugA/FbCwqAMJq2Rc+6YCiw6RnueEodC3xqpbrerhTmZMs9Uieq
         mzMS6maUNoxCRmHgTK98hUrDGbH1+kgJhauu2kJS8oCYTHKa1f+jN9qJ4XTTRNz15R3b
         8O+H3zbb/vxnYmskEP1LTlz/ITfwJvytKZZxBeKNnI0AryfSkzKzjGDS0UdFAm6FvghH
         213/Jvs7TGSpRTG9xkY2DIyMquY6ofOW3ak1E832sRU8WwFRyfR2cvToc6Vy97rCR41Q
         O8Bw==
X-Gm-Message-State: APuU4Z/oWUSwjgTDmoK2M0LrBt6lsACEXu1T5Xr0l7Gs4VUt7oqh4UG3
	09ffMeL4eHKDc38LBh1uOJf+IpI/bWCkQB4hYoYil30mGNY52MPtx+ULyuNU1i8t
X-Gm-Gg: AZFdTZe+yeuSZeSfHU92eRYyA85HrRgDF5YNszmhQ34Ol70vZyFcGhG51YNhFqwOWMX
	eGqC/0vkp4K4F5rAoVBzvz2LJvAKrdG/Rbui/vAWxLWi4JQze3i7SbZSo4JG4IlTrzzVNEw6Yxc
	5pBYWWS0Me99/scikxrr4c+x7VikKKtdKQTiyqk8icNgsUmZGOPXs9WnVBTZxdv4mEWc4PkqI5J
	HSPY0ItlyhIvisMO27YsK90F3Rk42JCFDlGYnj19baWQieSjvcrglV3L1mb6WCszJNWyo840Oxj
	9wMDMGKhMvZxlmjLhVLrQTOA+CvPftHlQ+8AmbliGxBtNh595FcwyeR6Ua38btaG9F+yVn/c2ov
	5gvBN8MjtPvFVS0VMO2nd6/hn3tROatpZiE/vkc9rhGpBUs2G07rJXBg3uRMWBQi7Vc/0fy4p0Q
	+n4FBNUNHLQiLUytDgzH7kmntmzfK4gshEOhlLEY5cTtS8WvPWrhS+srUAFiQyrxI5Y8yWT0lE9
	wyPbDMvv+btrufbPRn2m4xRt73TeJju/EBaWUiH5raS/fe6BxUFnclpUXPv+Xe16DU60hdqYEzN
	YGg/QRrRR8/QdR2OZgvuAjJvBXOjwrwXMaJ+kxylnwWTrwUWVw==
X-Received: by 2002:a17:903:184:b0:2eb:201c:91a8 with SMTP id d9443c01a7336-2ee0de4fa67mr102145675ad.29.1794823379886;
        Mon, 16 Nov 2026 02:02:59 -0800 (PST)
Received: from Ubuntu.netapp.com ([136.226.244.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7d994dsm33804245ad.33.2026.11.16.02.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:02:59 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@kernel.org
Subject: [PATCH 1/2] nvme-sysfs: use kfree_sensitive() for DH-HMAC-CHAP secrets
Date: Mon, 16 Nov 2026 15:32:43 +0530
Message-ID: <20261116100244.7824-2-marting@netapp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116100244.7824-1-marting@netapp.com>
References: <20261116100244.7824-1-marting@netapp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_020300_863375_02239DA4 
X-CRM114-Status: GOOD (  10.61  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dhchap_secret_store() and dhchap_ctrl_secret_store() free the raw
"DHHC-1:..." secret with plain kfree(), leaving it in the freed
slab. As these are the runtime rotation handlers, every secret
change also leaves the previous secret behind. Free them with
kfree_sensitive() instead.

Signed-off-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 9672ca3f74d2..35f871e3e0c0 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -850,10 +850,10 @@ static ssize_t dhchap_secret_store(struct device *dev,
 
 		ret = nvme_auth_parse_key(dhchap_secret, &key);
 		if (ret) {
-			kfree(dhchap_secret);
+			kfree_sensitive(dhchap_secret);
 			return ret;
 		}
-		kfree(opts->dhchap_secret);
+		kfree_sensitive(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
 		host_key = ctrl->host_key;
 		mutex_lock(&ctrl->dhchap_auth_mutex);
@@ -861,7 +861,7 @@ static ssize_t dhchap_secret_store(struct device *dev,
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		nvme_auth_free_key(host_key);
 	} else
-		kfree(dhchap_secret);
+		kfree_sensitive(dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
@@ -907,10 +907,10 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 
 		ret = nvme_auth_parse_key(dhchap_secret, &key);
 		if (ret) {
-			kfree(dhchap_secret);
+			kfree_sensitive(dhchap_secret);
 			return ret;
 		}
-		kfree(opts->dhchap_ctrl_secret);
+		kfree_sensitive(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
 		ctrl_key = ctrl->ctrl_key;
 		mutex_lock(&ctrl->dhchap_auth_mutex);
@@ -918,7 +918,7 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		nvme_auth_free_key(ctrl_key);
 	} else
-		kfree(dhchap_secret);
+		kfree_sensitive(dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-- 
2.53.0


