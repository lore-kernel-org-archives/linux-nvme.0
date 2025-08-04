Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F329C87FCB
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Aug 2025 11:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4qRmdIdgNuUm9Bq8rirCdszyfoGb2uHGtSY0BXXi/h0=; b=sY6nS86XwyavPSJ1fj1SGpVcNf
	/UL8pkXsJ1OsINu03P6oHa08XPooLlzqlyD6VDkEnEYnZH8fvIQMBdt6rDlQHnEmDkOORqQrPeh1z
	UWnpJTeE3ODNXA6sCv8cAzNfJ42uHb6JAliFTcR+He7k2as6lFb5oSSwB9WyqpiNLJ2K8z0MTmO41
	wfJtSPEaVwmNdSuvCWjYvHVXdaRXktj+UW9mqmrjuZd8ChIFp+YqFzTDu/1O/MFIjRlGs28lMVuoB
	5HLuTVqAtaDaMvEHRY0bFI2dvCx0s0LQg6DQ+22/vmZcT9O+pVWMLubU/eCmqt6L37JrVekfhMcK4
	26hRZxsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uitc2-0000000AJ63-1IW5;
	Mon, 04 Aug 2025 11:44:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uitbt-0000000AJ55-1ZLk
	for linux-nvme@lists.infradead.org;
	Mon, 04 Aug 2025 11:44:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754307846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4qRmdIdgNuUm9Bq8rirCdszyfoGb2uHGtSY0BXXi/h0=;
	b=bcXrDL/zZRQKcWhV7PwzerSSv+U5YQk++2GvECsudBAaVttRmG339fGDZg0oANT/Hrg6p/
	3OX6B6XggCRNyVXJOpj9XoOfEryjBRehgvNXQdBEIWmm63UpP2gVVhsN/5/842IU9L4laA
	q/tpo4TRzwseuTSdyApw5fy9YFJ+vM4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-bLBVzV6MPvOMGp5EfEQHYg-1; Mon,
 04 Aug 2025 07:44:03 -0400
X-MC-Unique: bLBVzV6MPvOMGp5EfEQHYg-1
X-Mimecast-MFC-AGG-ID: bLBVzV6MPvOMGp5EfEQHYg_1754307842
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46ACF1956046;
	Mon,  4 Aug 2025 11:44:01 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.15])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C075630002C5;
	Mon,  4 Aug 2025 11:43:57 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	mlombard@bsdbackstore.eu,
	linux-nvme@lists.infradead.org
Subject: [PATCH RFC 0/1] Ensure ordered namespace registration during async scan
Date: Mon,  4 Aug 2025 13:43:54 +0200
Message-ID: <20250804114355.30212-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K1kiUeo0Twg_rmr3-DumwDEXQfPLdMcvKqPEjn9GM84_1754307842
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250804_044409_659262_9E714DF9 
X-CRM114-Status: GOOD (  11.69  )
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

Hello,

The fully asynchronous namespace scanning, introduced in
commit 4e893ca81170 ("nvme-core: scan namespaces asynchronously"),
significantly improved discovery times.
However, it also introduced non-deterministic ordering for namespace registration.

While I am perfectly aware that kernel device names
like /dev/nvmeXnY are not guaranteed to be stable across reboots,
the unpredictable ordering has caused user confusion and
has been perceived as a regression. This has led to bug reports from customers,
and as a result, the asynchronous scanning feature was reverted in RHEL.

I was thinking about a solution to enforce sequential registration while
preserving the performance benefits of the asynchronous scan approach.

This one uses a dependency chain built from a linked list of
asynchronous tasks.
Each task waits for the completion of the previous one before it proceeds to
allocate its namespace, thus guaranteeing that namespaces
are registered sequentially, following the NSID list order, exactly as it
worked before commit 4e893ca81170.

This method is inspired by a very similar mechanism used in the SCSI
subsystem for asynchronous scanning (see drivers/scsi/scsi_scan.c).

Original code:

$ nvme list
Node                  Generic               Namespace
--------------------- --------------------- ----------
/dev/nvme0n1          /dev/ng0n1            0x2
/dev/nvme0n2          /dev/ng0n2            0x1
/dev/nvme0n3          /dev/ng0n3            0x5
/dev/nvme0n4          /dev/ng0n4            0x3
/dev/nvme0n5          /dev/ng0n5            0x4
[...]
/dev/nvme0n10         /dev/ng0n10           0xa
/dev/nvme0n11         /dev/ng0n11           0x8
/dev/nvme0n12         /dev/ng0n12           0x12
/dev/nvme0n13         /dev/ng0n13           0x17
/dev/nvme0n14         /dev/ng0n14           0xc
/dev/nvme0n15         /dev/ng0n15           0x11
/dev/nvme0n16         /dev/ng0n16           0x14
/dev/nvme0n17         /dev/ng0n17           0x13
/dev/nvme0n18         /dev/ng0n18           0xe
/dev/nvme0n19         /dev/ng0n19           0xf


With this patch:

$ nvme list
Node                  Generic               Namespace
--------------------- --------------------- ----------
/dev/nvme0n1          /dev/ng0n1            0x1
/dev/nvme0n2          /dev/ng0n2            0x2
/dev/nvme0n3          /dev/ng0n3            0x3
/dev/nvme0n4          /dev/ng0n4            0x4
/dev/nvme0n5          /dev/ng0n5            0x5
/dev/nvme0n6          /dev/ng0n6            0x6
[...]
/dev/nvme0n10         /dev/ng0n10           0xa
/dev/nvme0n11         /dev/ng0n11           0xb
/dev/nvme0n12         /dev/ng0n12           0xc
/dev/nvme0n13         /dev/ng0n13           0xd
/dev/nvme0n14         /dev/ng0n14           0xe
/dev/nvme0n15         /dev/ng0n15           0xf
/dev/nvme0n16         /dev/ng0n16           0x10
/dev/nvme0n17         /dev/ng0n17           0x11
/dev/nvme0n18         /dev/ng0n18           0x12
/dev/nvme0n19         /dev/ng0n19           0x13

Maurizio Lombardi (1):
  nvme-core: register namespaces in order during async scan

 drivers/nvme/host/core.c | 145 ++++++++++++++++++++++++++++-----------
 drivers/nvme/host/nvme.h |   2 +
 2 files changed, 108 insertions(+), 39 deletions(-)

-- 
2.47.3


