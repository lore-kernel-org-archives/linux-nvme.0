Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB711606AFE6
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=21zdKR5B;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YkDHkKiV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=LltqYqMO5IFPdo7aDrnjYrEfWgCKAqWsTYdw6iB4Gzk=; b=21zdKR5BG3MmVoiR/UwmwPAPbP
	CxtH4oXTded1M6qwjjhE/36jSvu6az9vX8KlqGM+mRp7Q86ND32pBpQpEshFiXKDkzbA6VOwiN0aL
	KjAjzYXBPL4YpiQvScxty2wMNPbkK3n1kowYfJJS7R9b8Ceut3gADzCnzGIsEOC4x5qrBMVk5sIfr
	vUBXxcuiwOqNhTTp0XnzgZEOx3yqGQxfD7nYnWtUwCHlczveyM5WepfkzhuxuEgxg49qaKMqS+18B
	w1TQ6x3pHUpwAy0zHZrXgIA+AGLQxIINw0DKmhxI7CqV4RJsO/rI1Oj1sWdeTN9p6lFye7nhWCDZx
	CC1E3d3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuTn-0000000Df4B-22GF;
	Fri, 13 Nov 2026 16:50:23 +0000
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuTk-0000000Df2p-1SeJ
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 16:50:21 +0000
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-36dbde64409so1820139eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 08:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794588619; x=1795193419; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LltqYqMO5IFPdo7aDrnjYrEfWgCKAqWsTYdw6iB4Gzk=;
        b=YkDHkKiV0lwZBNqpRmnRmDD7dg94KF+rinVTE4RAUi9i9oDKXX68X65qwUuP2JqtVs
         iKrdG9byOZQYWjltZCDT2/EB4fVYqEWT5UB//jRChoRfYHqAgOVzNSezZ2eRaLw4OkBO
         UqZnEbwYu9nxnHrkSjNhKhCaAr4FsVOH6oLrMcSFdq+n9F/KSq++b39ZCIGhVzHfy7Yn
         3Y4mwp+xJun7lehr1mI1S3GvMegLt+AL19+n2HGlrro62PzqoqM7uZSXW1tCjOmg0FQ9
         yPcVd/V3bFpPXNH7nMx1+TS8pzttgH5CJkpqSb0tF0LDx1CsowI21kDRN1q4fjnEMLyl
         7ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588619; x=1795193419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LltqYqMO5IFPdo7aDrnjYrEfWgCKAqWsTYdw6iB4Gzk=;
        b=qJObQAo9QlIyuUaNfNKtH6KeYQzd4xJT0SAvF1j0ENC20NZq8OE69qTf+a1hmQ39z+
         HKCqTALIpomFJzYxvsAoxWwE/K29AzsptEHIHJ97HnGP9e/EJH3zHi8T3JRvbKp06jkf
         s6O37k2a7GQZxGRfqoom5zzofgFAMSMdWeB0zM7HyeRS6GksWxLs/4DlGcvNjMdpTiA1
         VfFjvIE1Oa8IE4sGpnjTzMqQpjuctaTdzbnixZ8jAzoaGFWnJwy2b7nmHjPhhhoJH+FP
         EoQnGwJNRgZpjaaTthvjyCsMwlQAI9rI+Psn+JiZmNOUiidPCZuYXZKuOdlTq3KcIWpz
         0p2A==
X-Gm-Message-State: APuU4Z9xsznUvw2hC0YEcvf7mzPdbQ0za7+r+5gVT06wdSko/RnvZKiK
	iBiZ18wrgOclcVzAktMCZNpLjX19xHC4r3I9hd0NSAFOXbGV+froB3KWJW9z3lZW
X-Gm-Gg: AYBFou2kwmUoAjZh5ee2HeJv1xSFvaaVIKrhGZ5nT6oQ6wbrMmTmdjAywZcige6NDT+
	qzDgj5i6KN2m70STjCIlqlYuQBCRkuj7SnQ1KwjyJN4vO5Qs+ByMNPP+UBulrlY1vPh6aQc4A7k
	eggiz0sp1tGBmoJW+rY1AUZ2DIzGOxvAhyTPEjG9y9c14DRetPw4vJt/tmGkdR4E5l1v98MP+G1
	IWNXj4regKneQmoMGEiy/yCI93bSsbSXV0PoNsAuT8FbaZPmkpudZOZBNRWorpve2SQHKhPVl+y
	/kmzHJWFAXK1chIrcqP6W5/PMGP7rJZL6yN7w8b1NE0w9kDwWQvUuP0XKUskY7oqH4NoqBTjhqX
	4vtII6Ail9kKZw6VPqxuGiR6/V/c4D8VsK3/pwV50p2+QoVzjf982ogCOi+yDlR2uU+z6B95wRp
	LnjIPxpzREXaa4KS+HngPVjebPDKNi7Zef9voRXWNZvQ+jNSzmBWl3hcGj2vlbh3JldNeLzmDF2
	evqToH39LGxgL2YyfxUxCUsfvmek6benvasU2XuvQgqnbe/5/WiHqH4EyiPA8BY9YVwm+UZjia1
	peyo6F7nx+cqO1tAMbJMV8GKU3ZW248=
X-Received: by 2002:a05:693c:41cf:10b0:34e:9923:e372 with SMTP id 5a478bee46e88-37967506841mr2597908eec.29.1794588618884;
        Fri, 13 Nov 2026 08:50:18 -0800 (PST)
Received: from Ubuntu.netapp.com ([136.226.242.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955822d58sm8284403eec.10.2026.11.13.08.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:50:17 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	loberman@redhat.com
Subject: [PATCH v2 0/3] nvme-fabrics: bound reconnect_delay, kato and fast_io_fail_tmo
Date: Fri, 13 Nov 2026 22:19:59 +0530
Message-ID: <20261113165002.12536-1-marting@netapp.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_085020_389292_14EE402C 
X-CRM114-Status: UNSURE (   9.72  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

reconnect_delay, keep_alive_tmo (kato) and fast_io_fail_tmo are accepted 
in seconds but later multiplied by HZ (and, for kato, by 1000) in 32-bit 
arithmetic, so large values overflow and yield bogus timers. Bound all 
three at parse/store time so the conversions can't wrap.

The target already does this for kato via NVMET_MAX_KATO, and the host 
recently fixed the same class for admin_timeout/io_timeout (4a5aeebf1a00) 
and partly for reconnect_delay (f92fe8dea19c).

Changes since v1:
 - Add patch 3/3 bounding fast_io_fail_tmo, which is the same 
   "seconds * HZ" overflow class and was unbounded in both the parser 
   and the sysfs store (spotted by Laurence Oberman).
 - 2/3: reword the changelog to drop the inaccurate "1000 >= HZ" claim; 
   the bound is safe because kato is unsigned, so "kato * HZ" cannot wrap 
   even where HZ > 1000 (noted by Laurence Oberman). No code change.

Martin George (3):
  nvme-fabrics: bound reconnect_delay to avoid overflow
  nvme-fabrics: bound keep_alive_tmo to avoid overflow
  nvme-fabrics: bound fast_io_fail_tmo to avoid overflow

 drivers/nvme/host/fabrics.c | 10 +++++++---
 drivers/nvme/host/sysfs.c   |  4 +++-
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.53.0


