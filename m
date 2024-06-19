Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5138FC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 16:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r2m/DNJOhv4IL+ZQkVkshtKTjE43+QNp6sZzmfrX6oc=; b=PW8OyDNCR2X+nHC16BDm/Xktv6
	4sgxnOpDdr2kQTh1SCXUWccUXCoo16Ryi4a7qIUflqVyUtrxVO9Jthf7ED8mIIOzjStDn3PZJtPn+
	2joMR6ya2gVZhxug1vj5gbN1e3Q+hWWA7jjuHt2DJWcuhBIO417yE75vpSsSWnVGYKd8ZIyBgX/8C
	VOy/06BDrAfSaHTPBaAqMigBeJdA+rrtYfagXYER37afbN9Pf0Ru+mh+e48mhvQ3Fp9Jq1pHc0B2C
	gCkpHcOyUW5LGsKaUnLYUCVLoYlsh6kN5Xc1HYpFza5qlwMsZAgG7u1MvfvEmy//C2W6wbrCY0jGk
	ld0WyXKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJyHG-000000023E5-3gSH;
	Wed, 19 Jun 2024 16:35:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJyHD-000000023BN-3eyb
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 16:35:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718814914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r2m/DNJOhv4IL+ZQkVkshtKTjE43+QNp6sZzmfrX6oc=;
	b=NfC5iFd9LBlcNvS4mpZ3oWxa+56B4qFUmUIExCA4E7Todyn48/gxNAJQKjU8K4ZX5w+pXg
	eKDfN3uOjc370Q96Hn6E2z8Hh0roomhNv2jt6et7OTA2WhyH2JsszEukEg0v1cFxYKpUUd
	E+VXzC8vFonTRvDItNvOe5JngZJz+aw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-Y4Ypdd7fNY6RCLwWE0LHJg-1; Wed,
 19 Jun 2024 12:35:11 -0400
X-MC-Unique: Y4Ypdd7fNY6RCLwWE0LHJg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C43071956089;
	Wed, 19 Jun 2024 16:35:09 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.33.177])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C87A19560AF;
	Wed, 19 Jun 2024 16:35:07 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	chaitanyak@nvidia.com,
	hare@kernel.org
Subject: [PATCH v7 0/1] nvme: queue-depth multipath iopolicy
Date: Wed, 19 Jun 2024 12:35:02 -0400
Message-ID: <20240619163503.500844-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_093516_265105_C1E03AE7 
X-CRM114-Status: GOOD (  14.02  )
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

I've addressed Chaitanya's and Hannes's review comments 
and retested everything. Test results can be seen at:

https://github.com/johnmeneghini/iopolicy/tree/sample3

Please add this to nvme-6.11.

Changes since V6:

Cleanup tab formatting in nvme.h and removed extra white lines.  Removed the
results variable from nvme_mpath_end_request(). 

Changes since V5:

Refactored nvme_find_path() to reduce the spaghetti code.
Cleaned up all comments and reduced the total size of the 
diff, and fixed the commit message. Thomas Song now 
gets credit as the first author.

Changes since V4:

Removed atomic_set() from and return if (old_iopolicy == iopolicy)
At the beginning of nvme_subsys_iopolicy_update().

Changes since V3:

Addresssed all review comments, fixed the commit log, and moved
nr_counter initialization from nvme_mpath_init_ctlr() to
nvme_mpath_init_identify().

Changes since V2:

Add the NVME_MPATH_CNT_ACTIVE flag to eliminate a READ_ONCE in the
completion path and increment/decrement the active_nr count on all mpath
IOs - including passthru commands.

Send a pr_notice when ever the iopolicy on a subsystem is changed. This
is important for support reasons. It is fully expected that users will
be changing the iopolicy with active IO in progress.

Squashed everything and rebased to nvme-v6.10

Changes since V1:

I'm re-issuing Ewan's queue-depth patches in preparation for LSFMM

These patches were first show at ALPSS 2023 where I shared the following
graphs which measure the IO distribution across 4 active-optimized
controllers using the round-robin verses queue-depth iopolicy.

 https://people.redhat.com/jmeneghi/ALPSS_2023/NVMe_QD_Multipathing.pdf

Since that time we have continued testing these patches with a number of
different nvme-of storage arrays and test bed configurations, and I've
codified the tests and methods we use to measure IO distribution

All of my test results, together with the scripts I used to generate these
graphs, are available at:

 https://github.com/johnmeneghini/iopolicy

Please use the scripts in this repository to do your own testing.

These patches are based on nvme-v6.9

Thomas Song (1):
  nvme-multipath: implement "queue-depth" iopolicy

 drivers/nvme/host/core.c      |   2 +-
 drivers/nvme/host/multipath.c | 103 +++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      |   5 ++
 3 files changed, 101 insertions(+), 9 deletions(-)

-- 
2.45.1


