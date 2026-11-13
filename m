Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29A606AFE6
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2L4z8s0M;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TXYyBiAN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WkYC69sVqwqp2xGa8I5aRsAM9bELNg2C8umRTefF7OQ=; b=2L4z8s0M09lHei
	J1HiQwpzixkdFN6nBPXF7fEfi9Qd8j/4Eabi0hB+0NgYQTR6/ZifvUJx7JtSOGRBvgfW2ZjsjnS2z
	qcU51NUOzuVon/wMHlqCNTK212wEvUNlh3nmrvnHP0uS6hYQDKJGVVIoMAjNcZ130oQfdb7Y4z/Rd
	tAQ417ObdOcSDWJ+1OUYNqc4hSRrz39plRQNth1SR+dOGCFXAfwTOSVZfJL5T/XaYBtwqomwIgeIQ
	Dv9L/Gypgot6RxofycInRAamrDnmx6PHlSs3F8mXRjGT0YHo1CGA1EiSAmdpC5rjk91t1ecbD3/W6
	MT+R8EatVTohfM6WOlcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuTv-0000000Df8w-24ol;
	Fri, 13 Nov 2026 16:50:31 +0000
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuTt-0000000Df7N-1yUO
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 16:50:30 +0000
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-3282db206d3so3351178eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 08:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794588628; x=1795193428; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WkYC69sVqwqp2xGa8I5aRsAM9bELNg2C8umRTefF7OQ=;
        b=TXYyBiANWXYUO8NH6VYX28Us8lAaPA7A47K9vBK5agb73ZKSrwghMT6/uvPV5xVsRe
         QLYFQFRD4sEZwtGEigLO2mkv0yzcdkYpCv9yJd+Lupwp6Vlse0KZSSXd9MbTGGcJmNPG
         sge+hYm/IJlqEoiGXpOTtB401ym6IJGxKYQk68o7ndybG7SUpq7wvOSt9XPYwaVMHbg4
         oRALF6wTJMr8wyjpn0HaG0pOlxdWYF7TP7V6Ty+g2RLzwYIiwnDvXd1ZNLYU6YRcTO5u
         d1SylefLwSeuVWzQ7I9tMxN+lkTai2DbBRfZcU4cispgsx32IX3sLq4IJeLO/0V5hqia
         MuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588628; x=1795193428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WkYC69sVqwqp2xGa8I5aRsAM9bELNg2C8umRTefF7OQ=;
        b=y44GqH+okYnEoIec7MsowV0cLikvU8ewX+mfnEh9c47VJFJP6urEWnIJZkuINSjEHY
         vafl3WMl7rg7/7Sg8NTd6M6NGXa6FAk8EDwKYMBypjav0P4Kmao6EwwUYuNj9GtNueqG
         mz6XTrFAEkI+6o5Cjxn4TUgECuYM6ep/0ORDezP1rAAKN5Xy/gnSKVLiSvC/qzolTOwD
         YyBRAZisOd47uxw+XBh2qJhO/ClU4JBjHUkPXuYyg/eUAW6nBEd8cCwhi5YROd0mR2Qj
         58+ChN1gglG12lpK9784ImfI6qoIiLY3IRnAtFy+A16VB5kbdSqr3g3wPQOM+HtWisby
         Qvsg==
X-Gm-Message-State: APuU4Z+sF0OC+5TLt3c2yasIkI7b+ZTS97Qdzk3q4TsckkC04kVhpKM8
	cIzZeLMKKhEzJIUgdeV1MmlOdRY038LQOvancj1rZJCGuqbR9ujvBzuYianufRY1
X-Gm-Gg: AYBFou39CENaeFkzc/ekaEcQvK0lXbcWP2fbncS1dtvy4UzlU/dzWvo/OZbPQSj8FqM
	3ELQGGzENbH69vHvgnokCUV7wRCx07RENHSMACVE3bFLR0pe0p7QQfDgA15x3NQXREbyHIiS9ur
	lcikUSYSy+yp6N6MJcm5Nrc0Pfo9C2bDB+pWqitUtWM+GTzftfXxB1RIu2pmNe/RVSzMZ2WOJAF
	+99Rbx9dsJouT0nfCvLCY8v0HYqfmZsTfituc0xuB+4FxAblTpjEvrtEs7xU/dKJs12NBPcmFJC
	xjuqmpeWkOZs/BGND4sj1fyf+BH1nXLfT3LQnukhP5+sZujYl1AibAkLoqqOlGTbAmMrjZnNrpc
	StZ0SXb7S1zFEgvim1BOAVJSLuIS45nmhv6g5c9cbMG+/R61Fuem+JqOQ33Z/hfOKAS2CeWt7AG
	GfyK69eTDCu7HRREBD8LC/fAPjgJJiAK3DBBWg4RF1I02FKRdNgGbioG2Sojayn4HLNAbYn/P1R
	ftRe1+UjEo7MEa6ymcl3sbgsa3DDxRZQoYRuL+aMkfXyGmIOJobzyuS3jpmuHYUJPSAbrI/DVsp
	zEAO+RzeFa92IWooGme9sQPpSDtB9w==
X-Received: by 2002:a05:7300:d589:b0:36d:dd5a:4528 with SMTP id 5a478bee46e88-37966387cbemr2899801eec.7.1794588628182;
        Fri, 13 Nov 2026 08:50:28 -0800 (PST)
Received: from Ubuntu.netapp.com ([136.226.242.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955822d58sm8284403eec.10.2026.11.13.08.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:50:27 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	loberman@redhat.com
Subject: [PATCH v2 3/3] nvme-fabrics: bound fast_io_fail_tmo to avoid overflow
Date: Fri, 13 Nov 2026 22:20:02 +0530
Message-ID: <20261113165002.12536-4-marting@netapp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113165002.12536-1-marting@netapp.com>
References: <20261113165002.12536-1-marting@netapp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_085029_515520_FC1DCEF6 
X-CRM114-Status: GOOD (  13.73  )
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

fast_io_fail_tmo is accepted up to INT_MAX in both the option parser and
the sysfs store (only negatives are mapped to -1, "off"). It is then
scheduled as "fast_io_fail_tmo * HZ" in nvme_start_failfast_work(). As
the field is a signed int, a large value overflows that multiply and the
failfast work is queued with a bogus (effectively never-firing) delay.

Reject values above INT_MAX / HZ in both the parser and the sysfs store,
matching the reconnect_delay handling.

Suggested-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/fabrics.c | 6 +++++-
 drivers/nvme/host/sysfs.c   | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index b4ca0f9fd703..7da6fc344985 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -862,7 +862,11 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -EINVAL;
 				goto out;
 			}
-
+			if (token > INT_MAX / HZ) {
+				pr_err("Invalid fast_io_fail_tmo %d\n", token);
+				ret = -EINVAL;
+				goto out;
+			}
 			if (token >= 0)
 				pr_warn("I/O fail on reconnect controller after %d sec\n",
 					token);
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 8876d8db5401..dc59473f06f3 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -664,6 +664,8 @@ static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
 
 	if (fast_io_fail_tmo < 0)
 		opts->fast_io_fail_tmo = -1;
+	else if (fast_io_fail_tmo > INT_MAX / HZ)
+		return -EINVAL;
 	else
 		opts->fast_io_fail_tmo = fast_io_fail_tmo;
 	return count;
-- 
2.53.0


