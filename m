Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE044C77B76
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 23:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w0GIdBsSAN+S4m6LGKpp+pKP7FlSk7a6lxNLr0cQf88=; b=35PiA5ivrkkGGKLdVefJHCucMQ
	vjjynAP3Az+NOw9gEAxl709YE4FsNjqF/fdixeVIUSC6ZvPxBaoWrZKxZptCMQ/cjqdFmKeXUInMT
	gX1lnsw2goBwmrja9iCvf0gEowP5GyiG21hOfNmM70xN9jORAJzqsatGloK3E14fwij7tTLamS7KL
	ckp1L2zxqWN1oKvTFvFWJZeH3nVNEDn+IWb5z+VmVDgpCC9bCG/8/T7qWU3+G9pr/l8al2cwMSbdc
	AR4qFjtDq0sjyuxwTUU4/Twnz2++wpa9q3YJZ5GQi8AV6vW8ybW7iDZauzR9fm6L3k5nV/R7vz++I
	CmMSDCEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pr5Wi-00HQ3a-1S;
	Mon, 24 Apr 2023 23:23:20 +0000
Received: from mail-pj1-x1062.google.com ([2607:f8b0:4864:20::1062])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pr5Wd-00HPzz-0Y
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 23:23:17 +0000
Received: by mail-pj1-x1062.google.com with SMTP id 98e67ed59e1d1-24ba5c1be6dso1479251a91.2
        for <linux-nvme@lists.infradead.org>; Mon, 24 Apr 2023 16:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1682378592; x=1684970592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w0GIdBsSAN+S4m6LGKpp+pKP7FlSk7a6lxNLr0cQf88=;
        b=Ru4mfZRNRDQCJdgCSJYWbFp8MXM8jG/cXXnXZyCh9zJPk9+VnXk+QoI3JMQauEfSjB
         GIQwkJq5mUnw5UrrOORHqPrTuQekdyyjINcdzL26ExWxoGc+xhLKpjQahBpsBwPAFQxw
         17UFJfLQTNx2blC4NXnIG33xnTDjepW+aRorWCOaFnVOZKRRj6H232NBhRTsctC7PqUZ
         pp0sjR8Btr3FmRiSK0vnkCFnVZc9EYbjzRlto4oipj1/ussd3ucQsPkNq/NlxzlsgIgx
         QJViO8HNFGnLrOWlATW9chtvRjGg72OYyZDbZgK6Pluh28Jt9rjDv58dk0kYKXzBDeG9
         APWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682378592; x=1684970592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0GIdBsSAN+S4m6LGKpp+pKP7FlSk7a6lxNLr0cQf88=;
        b=JYneugVX00RY6OBjhBOCiDr8iCx/Ps2EgGkTEy5AMBhqf+t7dTlqw6ebH7j65D3GX2
         uUmTPFQumbENIdhPAIIUgdhR+i0IRmGTGDaUlP6cr7SkiCCLE23JoRlWr5FSTQNJePzD
         geTerslAFFdGgJt+lLwdIc8u69+BHEqby/KiBcCTgVODGAzxCdUilK6uzj5eVdGsM0kO
         z1eCKMbbJnRA3URN4GFhlu4MXl8+mfVnLObne3kSPhEihr0WSBWINNriCF3Gai2bPyV8
         8QO5VX8IMQRV1F+oeFCTZ352236onVWagI3+xwzKAO3lkt6O9G+Su25oGRtYbAxo/BTr
         nmuA==
X-Gm-Message-State: AAQBX9d/Y/NJlQkzdUke3O6la+ctYSxw7RwUljfQoc3yttgEAcH8fttg
	SOcJdOho+00QPe4sLLL4B49ixpfCcimaSVDroJji7/caukEHTRdlRG08g+VZFV7eOQ==
X-Google-Smtp-Source: AKy350Z/E35/vSKgz9Aj95ISJ4fqL5c6NZSeHjaCL8fDkYCHkMC3X4rTHkt9RAXccl6f2i0pSjkfJtSodUEW
X-Received: by 2002:a17:90b:3841:b0:247:e4c:d168 with SMTP id nl1-20020a17090b384100b002470e4cd168mr15223433pjb.10.1682378592539;
        Mon, 24 Apr 2023 16:23:12 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id q3-20020a63e943000000b0051a16c5a37dsm658065pgj.18.2023.04.24.16.23.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2023 16:23:12 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 8EBEB21E3B;
	Mon, 24 Apr 2023 17:23:11 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 8013CE47CE2; Mon, 24 Apr 2023 17:23:11 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/3] keepalive bugfixes
Date: Mon, 24 Apr 2023 17:22:22 -0600
Message-Id: <20230424232225.1975793-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_162315_649189_7F58D744 
X-CRM114-Status: UNSURE (   9.35  )
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

While reviewing the Linux KATO implementation in an attempt to better
understand the current NVMe Keep Alive specification, we found a
few issues in the host implementation that could contribute to spurious
Keep Alive timeouts being detected by controllers.

Changes since v1 (https://lore.kernel.org/linux-nvme/20230417225558.2890062-1-ushankar@purestorage.com/):
- Patch 2: fix indentation, set start_time even when stats disabled

Uday Shankar (3):
  nvme: double KA polling frequency to avoid KATO with TBKAS on
  nvme: check IO start time when deciding to defer KA
  nvme: improve handling of long keep alives

 drivers/nvme/host/core.c | 38 +++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  4 ++--
 2 files changed, 37 insertions(+), 5 deletions(-)

-- 
2.25.1


