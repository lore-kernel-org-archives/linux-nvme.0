Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C39606A31D
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Oct 2026 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=V+AevDPZ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UU9GDv4x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=piH3lxdjVU4RYaignxMIKWlUZiFBMo0J6b65E2PX6yk=; b=V+AevDPZ4VUVIC
	84Jf8QC0btmYvh1aaGATrsr69b3JU7NteMMAnbJfuqMlydMUkUhqqyvamgZ/dA9ijM4dqZ5m++cx+
	gEs82EzK1WcLhDmGKGoy/pQlT3hlEV/V30Sj8JWnQ/ZSa4V3ThGQTuIcrIMJRLdfdN9NDPZHKSC4G
	V40CJ12HzybSH8tWfKHHr1rMmh14u6tXHq1c2t9R7w69lE3zCd5NpJ9tkgcZJMw1yDU/+yJ1qGm8t
	EvKLUkeTbovljgYvRFp7fokkF7EIZ9F6ULb784jYAMo9ws8glIqdIajIlyzPExzNlrey1MNgn7y4p
	QagVFu5EvIR5Jn7kLJMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN5UI-0000000D8bb-2vNS;
	Sat, 31 Oct 2026 09:34:58 +0000
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN5UE-0000000D8bG-2GAU
	for linux-nvme@lists.infradead.org;
	Sat, 31 Oct 2026 09:34:56 +0000
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-36a17a332ecso2621751eec.1
        for <linux-nvme@lists.infradead.org>; Sat, 31 Oct 2026 02:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793439293; x=1794044093; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=piH3lxdjVU4RYaignxMIKWlUZiFBMo0J6b65E2PX6yk=;
        b=UU9GDv4xHF1FiFWOEm2SduqKqmBwb22N1a/RXZzKI552T1jDszSbUogiw7jUgaGp9Q
         RDe09aew8oZduJFvnQ1fqBtEOCFrTVe2K5kfj3YllorBxwAZiifIfmtQLFAFKW/UFqZa
         5fBhkFPm7cqf7nIFeFob/r8IjqgMJYzOkNO0S5HkITySeFuLFOb7pRt/EkCh+thJeCUi
         qFxbR7/sji/4UVl5NxvAXPCxzXlHkdwi6OW8WvxTgFzeRC6AXLEOeDYcfy5sZS4bdb2Q
         zrdSbcjB4qZtclqZmohRRGcLOpqRyfOxHrJ9dXztPw6Jmbr04f5VFLBX6vB6HJdbviyt
         W9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793439293; x=1794044093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=piH3lxdjVU4RYaignxMIKWlUZiFBMo0J6b65E2PX6yk=;
        b=Fu4c0NrJNeEDy94xVoNB0famv4IyVcZBA5EbKJpaZVfrlr19Qyb0VBPNWWSMgXj2NT
         t8jI4km04spjPLcHfhm6oWIZwghMy4T0eyqwriQn7gIGdF+Y490U1uF4KMPQlH14JrZu
         qG9B4yz+hM7SQ8Kb0WiNsXekxxr4rPh0awUSG/RvBwpsbaUaSxbgwaRCVJ6wVa1BMJXp
         c07WIJvqFYIgG83SAoL4vg0Sad8BZmPskZmgLp1P5rcn5cQdw0TwnX95h2iG+23e/x/m
         wq9LGeXebQZQV1p+ZiMjx+7AoRaEQ4w7sb5hXSy7rXXrttC86GYWHgFNWJrTpdZyo0rg
         U+FA==
X-Forwarded-Encrypted: i=1; AKwUvBwDEK3oId7wD2UKwVCzs1Eu+pvFKulEufdHjygmfGm9z5z9lS4/vPK+GmXQEviRaquLH2c0jBaCSz3x@lists.infradead.org
X-Gm-Message-State: AFq9FYKVtmL4BP/AIHWEVMQr4G/O2LIHOTRAi4s7lOyYc++7E53Seohp
	afbOEvpdyFqfRSdVMEtqX2CiFQUaSBfxXCLrNfvCKdDdnMGM1zWjxIZ06ZPNSw==
X-Gm-Gg: AYBFou0SHIuZpEZBfT9td4g5/PS3s8Kb0yYL9/KruG4XJ7X3pczmjWOqyF9NZzBdL3v
	g8oCttds0LVlXdAoxMo2ZgGtWGvK+GQBRX+e7xd36o0KnJE9VUyozgIqh2ZPpogLj4KV8tuRScG
	juHQNo3EgBHDhx8pUl4C8wgFhtFrQo7Dycgex/I1OP4ZgdcuMOSHtEkbKjZerm1tB36yfSOj6Nv
	gEP5ampm3ugaj/dRljRE6pwKwV2NSUBWPR3mF+8088Q1w9bNMcBGyro26EXsj8/9SxFdarRRXc6
	+TPXosfn9qbyRHOAclW6KCWPV/odNmDbp7OJ8PXD1PXye0WLiZDLDwxEVHktDm0kxwVznCZTrWi
	cD4BHhxEpkqvz+6k6QQlU2Hzt5fzlSrjiQDwcDD9dYPoplAiJ75ltabaUHClhYeq2uvH0QXw964
	ZI0LBAfeR23ceRy2CS1KlbwZQVEgN3LbDwVcOm6+lfAnoKNNuGwyAKr+uDb1Gda0Z0PWQbrGTR/
	k0SCY5owqGSgYz7riXj5FQkMJPZCYsPT1RuqXB9a31tVVX2QZrCTOXUoboCc3wdL9Ft6chFPd85
	mCoeO0h/NQQg73BMno8i+cgeKk5znvPN1k5HsSTTHSBFYPOII9iJ+C/rUJ0T9ISzDUjeDOg=
X-Received: by 2002:a05:7300:d0a5:b0:36a:1b23:a1cd with SMTP id 5a478bee46e88-36a4239359bmr6654389eec.9.1793439293236;
        Sat, 31 Oct 2026 02:34:53 -0700 (PDT)
Received: from localhost.localdomain ([103.170.55.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a504c6sm15850027eec.21.2026.10.31.02.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 02:34:52 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: sreekuttan2156239@gmail.com
Cc: hare@suse.de,
	hch@lst.de,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH v2] nvmet: preserve ANA log page copy errors
Date: Sat, 31 Oct 2026 09:34:20 +0000
Message-ID: <20261031093420.3017-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031083505.4767-1-sreekuttan2156239@gmail.com>
References: <20261031083505.4767-1-sreekuttan2156239@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261031_023454_619415_26115F09 
X-CRM114-Status: GOOD (  12.95  )
X-Spam-Score: -1.9 (-)
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

Preserve errors encountered while copying ANA group
descriptors instead of unconditionally overwriting
them with the result of copying the ANA log page
header.

Ensure that allocation failures are reported correctly
and that short ANA log page reads can still return the
header containing the change count and group count.
Preserve genuine descriptor-copy and header-copy
errors.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
v2:
 - Preserve the allocation failure status.
 - Handle short ANA log-page reads by checking
   descriptor length against the requested transfer
   length before copying.
 - Preserve genuine descriptor and header copy errors.

 drivers/nvme/target/admin-cmd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 26028be8fe4d..b0bcfbc94b93 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -542,17 +542,23 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 	u32 grpid;
 	u16 ngrps = 0;
 	u16 status;
+	u16 header_status;
 
 	status = NVME_SC_INTERNAL;
 	desc = kmalloc_flex(*desc, nsids, NVMET_MAX_NAMESPACES);
 	if (!desc)
 		goto out;
 
+	status = NVME_SC_SUCCESS;
+
 	down_read(&nvmet_ana_sem);
 	for (grpid = 1; grpid <= NVMET_MAX_ANAGRPS; grpid++) {
 		if (!nvmet_ana_group_enabled[grpid])
 			continue;
 		len = nvmet_format_ana_group(req, grpid, desc);
+		if (offset > req->transfer_len || len > req->transfer_len - offset)
+			break;
+
 		status = nvmet_copy_to_sgl(req, offset, desc, len);
 		if (status)
 			break;
@@ -572,7 +578,9 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 	kfree(desc);
 
 	/* copy the header last once we know the number of groups */
-	status = nvmet_copy_to_sgl(req, 0, &hdr, sizeof(hdr));
+	header_status = nvmet_copy_to_sgl(req, 0, &hdr, sizeof(hdr));
+	if (!status)
+		status = header_status;
 out:
 	nvmet_req_complete(req, status);
 }
-- 
2.55.0


