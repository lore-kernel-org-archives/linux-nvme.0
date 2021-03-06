Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA84C433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:38:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9E664F5F
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9E664F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UkBaYFy4SLDeQqNKmJVzGZr1jLQ9eiqY0aQBRpjYsrs=; b=PDB5/vAuc44tqRBElaCrShRox
	W8JAQKghRvJhrZsMWvK2IPCefmsoRH8ilrJe7XLq1IdBILjzDfC4YXs3FU+NUhoqnFjzjLmt/Ermy
	o341JteA2xs9IcC40ooTRPzEbT9iPBhCdM9G7J/0LQ36Mtw459FRxe3mAyXHoRGTaXhdfGPrAWs0/
	CYkENVmlbv2ecaC/k/UirBpGgn/bNduPjsX59Qso7+bBuQGgQkRj7Nfics7M1bynUkpDtB/tg+TqV
	MgU6PMytnj85CkaXB56JNWnas28mFirJ69PiCi4HPkxI+0dokEO+7GZbItgCOecgnhAAHwxJXbhXB
	Ue8I+IZuA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIKxj-00HWGE-Ra; Sat, 06 Mar 2021 00:38:32 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKw3-00HVVl-OD
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:36:50 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKE6LIqVqIkcyjwUVyK0zKEj/Ni4qarizl0H2peRgyA=;
 b=CLcyYQua6HQ08Z6gUXZ3AndHnovuehqURFAndJx4hmo+G8yGIWPyZQ6aeXoMAMEpvjsISC
 RnytvjhBLjRxLlP28ZRHhsw40yW6Lhwq/Q/Es5cBoBg11F6NHP9O3EF62QmlXVADIxMyd5
 Rw25fUpJC1F9ruapN2BsXuPuK55bDyQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 04DFBAF33;
 Sat,  6 Mar 2021 00:36:42 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH 10/10] fabrics: fix invalid memory access in
 discover_from_conf_file()
Date: Sat,  6 Mar 2021 01:36:24 +0100
Message-Id: <20210306003624.21102-11-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003624.21102-1-mwilck@suse.com>
References: <20210306003624.21102-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003648_615260_F8604715 
X-CRM114-Status: GOOD (  10.15  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

argconfig_parse() assigns pointers in cfg to point to memory allocated
in all_args. If this memory is freed, these pointers become dangling.
This is particularly dangerous if discovery.conf contains empty lines,
comment lines, or invalid lines.

Fix it by setting all transport parameter to NULL after processing each
line, and not proceeding if the basic parameters aren't set.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fabrics.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index f2ff511..1fcc6cf 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -1508,6 +1508,9 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 		if (err)
 			goto free_and_continue;
 
+		if (!cfg.transport || !cfg.traddr)
+			goto free_and_continue;
+
 		err = flags = validate_output_format(cfg.output_format);
 		if (err < 0)
 			goto free_and_continue;
@@ -1535,6 +1538,8 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 free_and_continue:
 		free(all_args);
 		free(argv);
+		cfg.transport = cfg.traddr = cfg.trsvcid =
+			cfg.host_traddr = NULL;
 	}
 
 out:
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
