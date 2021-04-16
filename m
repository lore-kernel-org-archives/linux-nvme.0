Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA13C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 23:54:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C629D6115B
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 23:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C629D6115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KQILaMI3unOuzrKnG73c1ynCzqIGH5/68CrRgieJcvU=; b=k53o8hJufDiO5XHRTFcqS/a2Xc
	/TcxdAZ3ssb/dkgTdc/bVNFO9yTiscGP0MdNMZ49WvEuYzYjDynAUrYHCP92EL8H6K1ky9akahaIR
	2yY/m7kp5GlXjSoZ0wV38jdGe9MtUCbJw2QErb3ZttRDgdaLdcK11BVxVmlL4+lK6EjDZLiysPKyZ
	XSKY0F0eRlL1ihuoz9vWpLwuwvAU81PSs178gcSAAHyfXu1z6fNEeDy2QfWSmR6FjTRhlYw0MiTQ9
	cHWVNXQ1Ak6SdnbB4ePd+IUXObWWbL6Y5+oQ9ET4Ovfa/0oBaW56493i+JcKupPAJ8Xqu+GV71uZ9
	wD9sxx2A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXYHO-003m4G-12; Fri, 16 Apr 2021 23:53:43 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYHJ-003m3o-AI
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 23:53:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=QyhvZCSvtA03X8xN6o/W0M+lSp8c9SWEUE8ZmCr9STo=; b=ixHKou/EJNIZwECz520xpj5Pal
 vEmks4FW7qTT8WyZEcuZnSB8FLPems5Zr0KA+iZOI8wNisOcDNfMx5qZzGR4UBSgxfNLKnB3QvaCq
 LIzEgOxOqKrSsUcbZ4fS0hXPwWsgaL1tLqJdgzKX90RtUrpk6m/FCSPOossStIpEwbGgLKfiNuYu5
 wFJu6rj36k0DGHfm2EmURtqCJa/TYRBg8rTJ4ilCJb/A4f8PztmOMTv81MnenOB0CxeX9nWteD0tC
 61se7qZxSdtr/0WLkaXZtyeY3RkdfabmwPfPTQfa+jZDur0Q9AbsKu20Ol9JuSpNliS8MHaM5J072
 V0DixGPw==;
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYHF-009n0O-Ej
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 23:53:36 +0000
Received: by mail-qk1-x72c.google.com with SMTP id x11so30603333qkp.11
 for <linux-nvme@lists.infradead.org>; Fri, 16 Apr 2021 16:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=QyhvZCSvtA03X8xN6o/W0M+lSp8c9SWEUE8ZmCr9STo=;
 b=JsIEI4hnfM7XZkx0kTFWX29u6sKY++3HK8McTuBMTVIMLBa6jL+mSdtBeE+BE1z6+e
 AVHycaL0mhnCcrXLL/9YR9rVoEY8n4Ps1Ur+22FPY3X2J7jvjSjxYtE5Q6N4nfR8VCql
 y6blXYg3nrIsFQzLJzx0T3WfT2Gk9d8mmQleZ874dAgkIfBnK7VkfSdu2uhaoza8ceWv
 sjMXCEEhXTTrSsPda3lTABiS0I12Nhqpm/YJK7Mw1lYHh/Tyf4Smv/rGXd4MTNR8A4MD
 1h8yYplpqCSUNTz04c9B4bXbZ0OooekkrWyg0MxZKdDTOkAMplGpc980Bq59RCT4jZpW
 zIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=QyhvZCSvtA03X8xN6o/W0M+lSp8c9SWEUE8ZmCr9STo=;
 b=Vrle1B+oS9K7iQH+Hz9ODQ7sU8zPc2VE33vFoCAKEln7riUkAUOdkr/ZawXWZdQtt/
 9Vus38zy69RhGG/9Zb7hyRNzu378z8x6EypsSeJ0kZniDr77aV07Pm44xlUIx1YvklS6
 ZxSy0cV4DJNtm1iDZoiVe/3Z527Pt6OWzcjgQQO2UipUzh13BzrykYRygKdA0irB2hFB
 GR7JY7W2WTU27+ISyyGN1AB6amzO4jFTkc3fQ55lfuMq8vwxrZ3QU63u8nGkMblhCOxK
 qiSyW85denfdriDAM7K5hU7E1LyQxzMO8SyVsW5wH533zq4tcYfOqcGwNzKwii5msCNC
 s6YQ==
X-Gm-Message-State: AOAM532Kh2+yz3oR9+cYVL7RApFGxcKuSuGYJnW9sLP99wOTXKwuM7/r
 LkAdcoflNfYigTclPusf5vM=
X-Google-Smtp-Source: ABdhPJyxfAxWmx5hFRT5ylJQlPp9g7ESFqO4NhBYv63c6HS/QO0qUMBxMVRjxTlMTrV+x8HDbBMqNA==
X-Received: by 2002:a37:390:: with SMTP id 138mr406655qkd.136.1618617210999;
 Fri, 16 Apr 2021 16:53:30 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id 2sm5164675qko.134.2021.04.16.16.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 16:53:30 -0700 (PDT)
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v3 0/4] nvme: improve error handling and ana_state to work
 well with dm-multipath
Date: Fri, 16 Apr 2021 19:53:26 -0400
Message-Id: <20210416235329.49234-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_165333_517137_9945FAE8 
X-CRM114-Status: GOOD (  10.28  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This patchset reflects changes needed to make NVMe error handling and
ANA state updates work well with dm-multipath (which always sets
REQ_FAILFAST_TRANSPORT).

RHEL8 has been carrying an older ~5.9 based version of this patchset
(since RHEL8.3, August 2020).

RHEL9 is coming, would really prefer that these changes land upstream
rather than carry them within RHEL.

All review/feedback welcome.

Thanks,
Mike

v3 -> v4, less is more:
- folded REQ_FAILFAST_TRANSPORT local retry and FAILUP patches
- simplified nvme_failup_req(), removes needless blk_path_error() et al
- removed comment block in nvme_decide_disposition()

v2 -> v3:
- Added Reviewed-by tags to BLK_STS_DO_NOT_RETRY patch.
- Eliminated __nvme_end_req() and added code comment to
  nvme_failup_req() in FAILUP handling patch.

Mike Snitzer (3):
  nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set
  nvme: allow local retry and proper failover for REQ_FAILFAST_TRANSPORT
  nvme: decouple basic ANA log page re-read support from native
    multipathing

 drivers/nvme/host/core.c      | 22 +++++++++++++++++++---
 drivers/nvme/host/multipath.c | 16 +++++++++++-----
 drivers/nvme/host/nvme.h      |  4 ++++
 include/linux/blk_types.h     |  8 ++++++++
 4 files changed, 42 insertions(+), 8 deletions(-)

-- 
2.15.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
