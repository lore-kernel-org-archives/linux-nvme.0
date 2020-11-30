Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428C4C64E7B
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 12:48:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B85320691
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 12:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nBkuVdzJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exWGyhJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B85320691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zWrpG6dLqomsKoUI7xexLXpBTRugaanRPQOwOPRVc+4=; b=nBkuVdzJfzghn0o+5mj6nTbtSW
	xJMIE69dy3xpiwepnlVUUg5tm1/z090HYIUQS4CD/VuL0yBTujwe18TvJNVh9/wwCSl6CoGc6sjZg
	k4/IkoTpX1BZ4ANSFz0QfCtzVUpuhtxkRHopzIKBj+MGiu+35QNDaJJBshPoWcIZXNrLwaRIu6UuV
	Qi376ljZcBLY8c5YJ1vitbU9I7QpAdRHuTlVz2GSz8fqytHAzZKt8xVflY9ZTciie2wrnB6A6gWPm
	6KfTMFYY688ey+RpVoIqrmwgyTFTTCaQvK4WBWFnMofvVdlvSP8ZaGimyR8iU8hlRn9ea5ZOmTKYg
	mISCr9kQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjibI-0001Kw-C3; Mon, 30 Nov 2020 12:48:16 +0000
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjibF-0001KK-Dc
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 12:48:14 +0000
Received: by mail-pj1-x1041.google.com with SMTP id l23so371716pjg.1
 for <linux-nvme@lists.infradead.org>; Mon, 30 Nov 2020 04:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=FauZMIGNuDOl7SsiN7Fqn02v1zzNPUKHZdVomhf8R6k=;
 b=exWGyhJWu2+t4769i1bjLY4jJX5QavPRoZAluXeEiMhMMANMgsoLq2HODHB2KYUMh1
 RXBzAeaUFk8Tx6Erax5WvKt0cjnLYtq3tovtAmXKMqrrV6DdVTgH6RwOqmI6wCm8s0RB
 ua4VLPwqoveRQoEuGmqw69+dJve+Mv44tdUht51bvG6t0rOJMOC05K+CFpPerHEAK6sM
 oV27ygbJ4d7gi/pLz/R78baTsnBO1j/QqxKnDyPTYlLdHcCK3W8iqqJ5fbnrcPyjQqxz
 JdFbSq4WLJXelAeeLHm9xwKoFEGdcWbpcI/d1Wu+AC5bZb9DRTt/4Rhiw71sYe8hQ3c8
 11mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=FauZMIGNuDOl7SsiN7Fqn02v1zzNPUKHZdVomhf8R6k=;
 b=n61fSthIQUw23na4HLSnt3b44gzX3c1lJMem4yvGyHOmwfFxr9aPgGWW7s6lLG2VuS
 ITOvHXA3r8SmIxtsl0YwzO3Z/cgCvIKKRpuaGPLFrMtokMHxRcIILlQwGDii7eM4x/f/
 LVMj5ZRUOKXVoSUszX/o+ORgKEOhbjLi2xWXNX8IIzerxH9UmgnMWSxAFMGdgOkRlxJY
 gbTHDnUjYcw03YDnAMI9L8dulbbTkLsgfJidhcAcujOsu/36TbOMkvqEjn0GPfIQoltS
 alebU2u9hmZqKlPux4+0fsQHUxo9B+iyxmVQ4PJGvfYOVdGf5w7R9uhhoTBmJrEb6Qq5
 sPyA==
X-Gm-Message-State: AOAM5329CKI2kpXmNaHSaD8gPw+iaTA9OowIDUP8jKDlgEjsNHlLfkxa
 ahC8vwK9djDS8//U8UXblrIPnBiIqNk=
X-Google-Smtp-Source: ABdhPJwJwrlHd1rwIRBX8ouEOQFQUxRNmiZv5K9EE6Hioh/lFJ1uhRF8eC4gVG1+wsLAmflixhh7UQ==
X-Received: by 2002:a17:90a:488f:: with SMTP id
 b15mr25455537pjh.99.1606740489667; 
 Mon, 30 Nov 2020 04:48:09 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id q19sm16625918pff.101.2020.11.30.04.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 04:48:09 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme: Improve warnings for scan_work
Date: Mon, 30 Nov 2020 21:47:45 +0900
Message-Id: <20201130124747.14725-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_074813_491896_9596B0A4 
X-CRM114-Status: UNSURE (   9.87  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

These two patches improve warning logs when identify commands fail
during the scan_work.

Please have a look.

Minwoo Im (2):
  nvme: elaborate ns-descs failure warning in detail
  nvme: Print warning for list-ns command failure

 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
