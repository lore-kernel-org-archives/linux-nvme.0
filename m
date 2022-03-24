Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FFAC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 00:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=44RShZxgn9paT7MjAHFRskXBhHC6HZN40UXAt/ajQ1Q=; b=3I/q0Zk/qQkPd4Q4iCEb1yc6li
	6TUNgWzuB9eKNWwn9nfuYwqDv7ctsxZHqOqpjN1+HBBRv/tyOrFDoDSXsncW72amgUM4KZ3cvfbsa
	qxg7xaEHEibhvxZtB5nM3M9xBh4oNUIe2P+m2Zp1smxEnwKXw3odODGX6mU63cGt+0xQ1Izvu+pZP
	y5FJ6IqParrkGstUbi8VD6vVVuVNW2s27CkayQIqvN7CIz7LhhSq76n/lHRc8o8LqLFXzQbE4nwqU
	+dy9IVkNKacUnI51xYhtotUac40OXKY2/JOjU901CZLWrXKadP2GlrwvItPkdFhGCLwB+s5c3yJqk
	QP0d1gYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXBNM-00FCfh-Bg; Thu, 24 Mar 2022 00:30:52 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXBNJ-00FCf2-KY
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 00:30:51 +0000
Received: by mail-wm1-x329.google.com with SMTP id
 r190-20020a1c2bc7000000b0038a1013241dso1778168wmr.1
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 17:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=44RShZxgn9paT7MjAHFRskXBhHC6HZN40UXAt/ajQ1Q=;
 b=iSPowEXl3w4KmwLi/csabCM1g97W/eq/w7SMOwu5oKT6qmKBDWGIxJ9YEgA3t60R7M
 as/iMI4aMW+1U4aYAytb4LtLG5wdmeD5anOnPP4HDo5a0xpRNBhHhKdfdgYfDc2RjsI0
 sDVSDSV0Ep6TJooNxXS2xpDUv2KJCISsdinex+owa0H3/6wqrDsqZpX9dT8Hg43eaDQm
 OUCXgbh9J5Z6PFmbEiyZqLf4FnuCC3HmnB72nKUx07lb7IMfmAgxD426Cgzxd+iHdE++
 7fGINNFhWLh3N8UuZh3drr9r5a84b8EgvJacdeRT7Zg41zZVOioUNivtJHyocpxXQs2e
 HjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=44RShZxgn9paT7MjAHFRskXBhHC6HZN40UXAt/ajQ1Q=;
 b=mVIhDtZpONB9JXIsqCVE15ATjbQOz4HEAOc4eUpovWmubxxuQn0MGFnLAm4j5W4RaS
 ZdbjpRTwhK/c/qmZ39LXAp7LBbT/PpTj8RkFoBkjCIZbpf0tG6ISCjV3NilvLWVn/b9P
 sXAb9Od4aJ4wyy0uAcU9snQsy0qi8cWT5OD7tSkgYX73RYBU5hyfO1jp3r+O0BJ2EqHj
 x4QK5Rrcw/T7HAIe/Q58v8w+jRzlvc0LSOBBSrnNEMyo5MCT+wOdykUjOdCGzKK9rxiB
 ygsjLaSeXF9b6ykakcQP/ThO8+AiiMv1ZfDBKy/KVzbDE92xfp5ZS4q/ZkVbjazrHfOI
 LaAg==
X-Gm-Message-State: AOAM531/h8mToLUb6WkeLvvY0hweLuaGVTN3deUs+m5mtEKFrVolMT7Z
 9jciwURa7ZatBbmJjUT2aWY/AuOHaVb8fg==
X-Google-Smtp-Source: ABdhPJy7PtC/s92cl/tSLH4pNBfS3pw3rvlOx0Y0dYSlZXpgylvbNSNtks3omYL70OGGxcWX7kO8qw==
X-Received: by 2002:a05:600c:35c1:b0:38c:9933:41bd with SMTP id
 r1-20020a05600c35c100b0038c993341bdmr12118119wmq.112.1648081847960; 
 Wed, 23 Mar 2022 17:30:47 -0700 (PDT)
Received: from localhost.localdomain (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87]) by smtp.googlemail.com with ESMTPSA id
 p30-20020a05600c1d9e00b0038cc9d6ff0bsm1716938wms.33.2022.03.23.17.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 17:30:47 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v2 0/2] Fix issues with nvme_mpath_update
Date: Wed, 23 Mar 2022 18:30:06 -0600
Message-Id: <20220324003008.1588225-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220323234355.1585346-1-anton@lightbitslabs.com>
References: <20220323234355.1585346-1-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_173049_723790_D940669A 
X-CRM114-Status: GOOD (  10.48  )
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

My recent commit d50c992edf10 
("nvme-multipath: fix hang when disk goes live over reconnect")
introduced two issues:
1) Build error with CONFIG_NVME_MULTIPATH=n
   - missing "static inline" for the nvme_mpath_update() stub.
2) Crash when CONFIG_NVME_MULTIPATH=y but
   either multipath is off or the ctrl is not ANA-enabled.

Fixing both - sorry for inconvenience.

Anton Eidelman (2):
  nvme: fix build error: nvme_mpath_update stub without static
  nvme/mpath: fix crash in nvme_mpath_update for non-ana ctrl

 drivers/nvme/host/multipath.c | 10 ++++++----
 drivers/nvme/host/nvme.h      |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.25.1


