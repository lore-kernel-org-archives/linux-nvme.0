Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BD9C41513
	for <linux-nvme@archiver.kernel.org>; Thu,  9 May 2024 20:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FddXm199VtUfPB6J9EsjicQftuZ1DGKMjcorbhxjq/s=; b=0zBt71IrQKOp2MyaYaoolzeE6x
	aM4ptLs5p0ADDQb+/mmdxoyJKLgov2PPKtvbxc71X8eD/KSucmRzsgj20gneBbk5QE5lC1sloni3v
	Z7ETAxcVPpQmvtlBOxkI2fWGGzuuuA0kE0bOxMcb/YG4zU5wFZEf5NRdzWpuIiEwQ+Oz/+LlZqLWh
	9aayYS6tneyRzbO+TgT93T4czPantiaowmxTcQ2834xpGmYIbvOpwVjYHsUHmZ/aUzM6k4K3rYpwU
	uZdKpSgyDudA/4tWMPAAIH2sQZhgVlgI3kaxZEnl+km0QCH/hsOYyYfuhYYzeCPy2ULDwq0dahNVv
	Cj1zSQWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5AOi-00000002lsv-10nU;
	Thu, 09 May 2024 20:29:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5AOd-00000002loh-3hhd
	for linux-nvme@lists.infradead.org;
	Thu, 09 May 2024 20:29:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715286577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FddXm199VtUfPB6J9EsjicQftuZ1DGKMjcorbhxjq/s=;
	b=UIgbaJ6UZR1Pogn5iXTvXxhKR1IgqCDuRz6CYwxL0Dmi00RaCe9VEEdN3ocaSsvyHcAJny
	lPlfeXaOqn6+EMQD9MMhgE7cBJEsRr8PZ1lSugAXedxcHK3nmMIoDMqdCASgsPmRMGx/53
	LfySLg3i+lmVULoTfQ7/SwdDoF9/6/0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-CRnDHCYCOvq7x3XNpCOBEA-1; Thu, 09 May 2024 16:29:33 -0400
X-MC-Unique: CRnDHCYCOvq7x3XNpCOBEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE4C3185A78E;
	Thu,  9 May 2024 20:29:32 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5B76920C5674;
	Thu,  9 May 2024 20:29:32 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	hare@kernel.org,
	constg@il.ibm.com,
	aviv.coro@ibm.com
Subject: [PATCH v2 0/3] nvme: queue-depth multipath iopolicy
Date: Thu,  9 May 2024 16:29:26 -0400
Message-Id: <20240509202929.831680-1-jmeneghi@redhat.com>
In-Reply-To: <20231107212331.9413-1-emilne@redhat.com>
References: <20231107212331.9413-1-emilne@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240509_132944_097640_9068E09B 
X-CRM114-Status: GOOD (  11.04  )
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

I'm re-issuing Ewan's queue-depth patches in preparation for LSFMM

These patches were first show at ALPSS 2023 where I shared the following
graphs which measure the IO distribution across 4 active-optimized
controllers using the round-robin verses queue-depth iopolicy.

 https://people.redhat.com/jmeneghi/ALPSS_2023/NVMe_QD_Multipathing.pdf

Since that time we have continued testing these patches with a number of
different nvme-of storage arrays and test bed configurations, and I've codified
the tests and methods we use to measure IO distribution 

All of my test results, together with the scripts I used to generate these
graphs, are available at:

 https://github.com/johnmeneghini/iopolicy

Please use the scripts in this repository to do your own testing.

These patches are based on nvme-v6.9

Ewan D. Milne (3):
  nvme: multipath: Implemented new iopolicy "queue-depth"
  nvme: multipath: only update ctrl->nr_active when using queue-depth
    iopolicy
  nvme: multipath: Invalidate current_path when changing iopolicy

 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 77 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  8 ++++
 3 files changed, 82 insertions(+), 5 deletions(-)

-- 
2.39.3


