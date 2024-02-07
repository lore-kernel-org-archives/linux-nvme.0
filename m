Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8385C4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 18:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uzhXO96uioYuw+s+CgtOuyqJZRewhrPzSOw58rzbztg=; b=Hg8K/Maka8NSSitfp9jNJFWhdi
	6yLLkuddIPFyue2+cwp2eG4uCbo7nrBt19uPJAcMw3CFRJe719G2kEwJ7SgnpKh8ad53G9AXd4lxZ
	RD8yDNkaik8PKSUyTN4bZDHzRTWl0zoYWVYTDjvAXAkYTpoFdB+5/h5JlwbB53KXxtlj2mMgRM2rv
	N4uEyY0wkNqHN1+jGqiJvWpETemZKNiQRIKh0e1wGRi/fU4sE7GfgYzDmyeiTcRiIHgmMTm/jqgh/
	GHCLV2QkTCxLDDYly0nXs0CjplntIrq0Ho1Pt0KpAopvheJp3TmaFeJ2SJoPtMQcAX5c0Ye6QrdZG
	VNeFzcpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXmti-0000000BVYE-1syE;
	Wed, 07 Feb 2024 18:43:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXmtf-0000000BVVc-1dsj
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 18:43:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707331425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uzhXO96uioYuw+s+CgtOuyqJZRewhrPzSOw58rzbztg=;
	b=XeUd5QRLhBW8lyyN4YSHreUstmdGXVjH5nfKxG3JKY3Ta90EYaQ/+pnq06RAy1lBPCOHuA
	G05YR3G5tL6QA6J+B94oG/2vnLG9Ei80TwBrxA9GqxGiKfUHYwWft0cTNIqnU+dFr5GF6X
	hicuAf1ZhSeIISpXi/ndFyyGfY88edA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-SOx90uyXOvy1n8fT4n9uqA-1; Wed,
 07 Feb 2024 13:42:13 -0500
X-MC-Unique: SOx90uyXOvy1n8fT4n9uqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3689A38212CF;
	Wed,  7 Feb 2024 18:42:13 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.32.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ADEB340C9444;
	Wed,  7 Feb 2024 18:42:12 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Jeffery <djeffery@redhat.com>
Subject: [RFC PATCH 0/6] async device shutdown support
Date: Wed,  7 Feb 2024 13:40:54 -0500
Message-ID: <20240207184100.18066-1-djeffery@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_104347_631085_0D11B23E 
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

This is another attempt to implement an acceptable implementation of async
device shutdown, inspired by a previous attempt by Tanjore Suresh. For
systems with many disks, async shutdown can greatly reduce shutdown times
from having slow operations run in parallel. The older patches were rejected,
with this new implementation attempting to fix my understanding of the flaws
in the older patches.

Using similar interfaces and building off the ideas of the older patches,
this patchset creates an async shutdown implementation which follows the
basic ordering of the shutdown list, ensuring the shutdown of any children
devices complete whether synchronous or asynchronous before performing
shutdown on a parent device.

In addition to an implementation for asynchronous pci nvme shutdown, this
patchset also adds support for async shutdown of sd devices for cache flush.
As an example of the effects of the patch, one system with a large amount of
disks went from over 30 seconds to shut down to less than 5.

The specific driver changes are the roughest part of this patchset. But the
acceptability of the core async functionality is critical. Any feedback on
flaws or improvements is appreciated.

David Jeffery (6):
  minimal async shutdown infrastructure
  Improve ability to perform async shutdown in parallel
  pci bus async shutdown support
  pci nvme async shutdown support
  scsi mid layer support for async command submit
  sd: async cache flush on shutdown

 drivers/base/base.h           |   1 +
 drivers/base/core.c           | 149 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/core.c      |  26 ++++--
 drivers/nvme/host/nvme.h      |   2 +
 drivers/nvme/host/pci.c       |  53 +++++++++++-
 drivers/pci/pci-driver.c      |  24 +++++-
 drivers/scsi/scsi_lib.c       | 138 ++++++++++++++++++++++++-------
 drivers/scsi/sd.c             |  66 +++++++++++++--
 drivers/scsi/sd.h             |   2 +
 include/linux/device/bus.h    |   8 +-
 include/linux/device/driver.h |   7 ++
 include/linux/pci.h           |   4 +
 include/scsi/scsi_device.h    |   8 ++
 13 files changed, 439 insertions(+), 49 deletions(-)

-- 
2.43.0


