Return-Path: <SRS0=1xwY=4M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB01DC38BE1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:49:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0C720836
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l8Yxbw/B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rK+ubFIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0C720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=M6e+DSrL4xs/f52kWnGwDY9LURpbMsPS4bTGvDAMbQs=; b=l8Y
	xbw/BG+V9PRVHe7ivo9P0YEqRR9rLNTnBQHJ2Uj1+pAzzccaQAcxkiiM0PAT8a693mc0Ti3tfQJgu
	xNYktm8ygzVtwLQ54+PpSDsa6S3ZjWWjI3Zc1F8ZttOIPqj+fmlyHEv2pLYd7MedwMyzquqBVd0i8
	oAaY1I8yPW82EicJU54mE2C56qbuGKgl0s+ah+bkEUzFeNshzuv/BWx1Uii9P7ndJEThADqEJKqxD
	6alGIMF6jvMxeKsloTUo7dugOV/o6COEJcYeHf3v5Ei+b6hA0wYXSIKTVUowXZ39xDZuwRNtLer5O
	605rHuvTIKqHuuTWdT2hluGF2/RIN8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6In3-0007Fl-MQ; Mon, 24 Feb 2020 18:49:13 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6In0-0007Ee-Cs
 for linux-nvme@lists.infradead.org; Mon, 24 Feb 2020 18:49:11 +0000
Received: by mail-wr1-x443.google.com with SMTP id r11so11647467wrq.10
 for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2020 10:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=LTQLNWO+Vp2gVjxzXtjnfqbCDtXUZV3BKQy9xDrdCQs=;
 b=rK+ubFIyEe/L2+sNMJgkG4pFpDqUIWtypo7soivl6MbZf2MyvKhQ2MELc5/smTQ9Ix
 sMCjPzbot9GfljAgQza+Bit49g4FBAYXWx+0Zx8RoSQPMTDJtgcfnxz7OUV3sM/PUeIB
 /Jd0dm0MNNQQKC+R5VVWEnW2IAFx24s/n2ngd3HZwE7otI558DTJ7vZGYV9VC+wptXaT
 2A0qAhAK7bJNPkrak6F1KJ2gEazOMB7LzW1l+bxa/kYUXbKGxRgkHFUIjWVQbr+3Fzy/
 e4b+40hrmXm/H2c6k9z+sgMn1KxYWsHWyOB6PLdgugXtJcUlTCMm5MBzkACCSWrjyH0Q
 Smxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=LTQLNWO+Vp2gVjxzXtjnfqbCDtXUZV3BKQy9xDrdCQs=;
 b=O36NbSeLZvftSRCMlqdM/t4ch2xtBLNStnd4rQ+FXW0zs3wyGPrzAAEPQt1+HjvKOO
 NPeegc/UBDqmqdbJZX88VLJBMUL+bxOcypZi7YoiaUiACqNDJIv+0KFjEGJFy0gYACSo
 Ncje3uqussZKkz7lsG+5adwk5J0a1lFVg3guO2b80cLA05PMCA5GZZ/wZgZqyPM+s+lT
 YynsA6TEaOmDuZjCBeL9osz/k7IqFfUK2OqX2pmwPRv2vinPGKDZuAXaWb5QhOWBaPDd
 nOlQHeVxyB5VM0vGO2uiybYncABEDpu7pEcEPrBjvwAF7baFYNWJxfKMu527YUdMlHyh
 eEOQ==
X-Gm-Message-State: APjAAAUS9MgOxHtOHKYuM2PaPHgiSQ2rZOTlPnvRZ7hgpsZj+Ko0Uxsf
 A65VPghJis3wjUEzE9N+Df92EP3t
X-Google-Smtp-Source: APXvYqwNW1NkAtS7Mo9rpQfuiL3ARXQaWKEud5d0r1mSvpy8L5EBYk05a9GQNq7RE61GWmjUqIo/4Q==
X-Received: by 2002:a5d:6690:: with SMTP id l16mr3717573wru.251.1582570148578; 
 Mon, 24 Feb 2020 10:49:08 -0800 (PST)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id l8sm460047wmj.2.2020.02.24.10.49.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Feb 2020 10:49:08 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [RFC 0/6] nvme: core layer metadata/pi support
Date: Mon, 24 Feb 2020 10:48:53 -0800
Message-Id: <20200224184859.20995-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200224_104910_432240_E2819E4E 
X-CRM114-Status: UNSURE (   9.86  )
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
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch set is alternative to the core layer mods proposed by Max
Gurtovoy.

This set adds much the same functionality, but does so via transport ops
flags that indicate capabilities that are then stamped into the controller.
Transports can fine-tune the capabilities on a per-controller basis by
tuning the controller flag values.  The patches also use different
language. Rather than introducing extended lba data terms and naming all
metadata as "integrity" data, it keeps things generic as "metadata", that
then may or may not contain pi data. It also revises some of the checks
in the core layer to better show fabric deltas and options for metadata.

This patch set does not cover the patch adding a fabrics "pi_enable"
option. That patch may still be used, but would be implemented differently
in that the rdma transport would look for the option, and when set, revise
the ctrl->t_flags after calling nvme_init_integrity. The rdma transport
patches would also largely not change in function, but would change in the
flags and how they would look for items.

This patch set does not address (yet) the nvmet side.


-- james

James Smart (6):
  nvme: Add ns to nvme_request struct
  nvme: make nvme_ns_has_pi accessible to transports
  nvme: Introduce max_meta_segments ctrl and ops attribute
  nvme: Add t_flags and pi_blkszs ctrl and ops attributes
  nvme: Add pi_flags to nvme_request for transport pi support
  nvme: Introduce NVME_INLINE_PROT_SG_CNT

 drivers/nvme/host/core.c | 115 +++++++++++++++++++++++++++++++++++++----------
 drivers/nvme/host/nvme.h |  46 +++++++++++++++++--
 drivers/nvme/host/pci.c  |   7 +++
 3 files changed, 141 insertions(+), 27 deletions(-)

-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
