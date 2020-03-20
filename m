Return-Path: <SRS0=dgXS=5F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D200C4332D
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 20:42:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290FC20775
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 20:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y1gs+6BI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMByM1Tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290FC20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MOwDJg65njPKDvkngoUEvLAfAfNIvoQFvhQ/ShcT6QU=; b=Y1gs+6BIIkbI19
	WGz+rp0kWzD7IHPEL7kiuFkKrtLFBm6EkrBJacofI5Gdy3mkCpnLbfnPwQfZJpZT2qpwxBSRw6G7I
	aVJwuEBROjmaZOay+iHrwxDpj4mk4P4rVDqLAxGkr7+RndMBtCdXamgpCxEob/yLzN9+tn9PCS1J2
	dSxMsNS74OgVJPf7shM1tR4MUHkw/i3/9RRIlZxVUYUztqWUeY37sma0T9diTfLE/n89LTtIuUxg6
	cM5K92ekOEoCguc5xrXdQWuqCjbESiM6H/CZTsuP6ESJPwGVFvBZ7B2XWPCwkyKBA8cA/fPFhqwaa
	vTH9+TyqDU0uUvLsL5mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFOSv-0007qz-He; Fri, 20 Mar 2020 20:42:01 +0000
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFOSc-0007QX-Go
 for linux-nvme@lists.infradead.org; Fri, 20 Mar 2020 20:41:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584736900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F5o7O3hHLwUkjwFdYrYb+q6Ej+C4pwfFZus5wp+3HUs=;
 b=EMByM1TvGWZfjSeArSmYQFvPIAExV+RmlE/nOO3MwTe7dcDGvydxwxVFxoR2KBwMT64h4A
 1WhZD95j6CglwFUvJAvBM7XGJ4fc9UMexnm8KhQDu4JP2U610PM0+EoGH64TY+/h8FJ5vE
 PYQTkdvfeWOnVE2j0SsWLdkrEdYBpoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-krRRAA4bP2Oiqs9gk2LaPg-1; Fri, 20 Mar 2020 16:39:50 -0400
X-MC-Unique: krRRAA4bP2Oiqs9gk2LaPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B232800D4E
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 20:39:48 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 088BB90817
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 20:39:47 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/6] nvmetcli: Misc. corrections
Date: Fri, 20 Mar 2020 15:39:40 -0500
Message-Id: <20200320203946.37338-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_134142_635845_783E5D60 
X-CRM114-Status: UNSURE (   6.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

While trying to experiment with nvmetcli I've run into
a few issues.  Some changes that I believe are beneficial.

Tony Asleson (6):
  README: Update URL for configshell-fb
  nvmetcli: Improve IOError handling on restore
  nvme.py: Explicit close is redundant
  nvme.py: Sync the containing directory
  nvme.py: Make modprobe work for kmod lib too
  test_nvmet.py: Use string.ascii_lowercase

 README              |  2 +-
 nvmet/nvme.py       | 17 +++++++++++++++--
 nvmet/test_nvmet.py |  2 +-
 nvmetcli            | 24 ++++++++++++++++++------
 4 files changed, 35 insertions(+), 10 deletions(-)

-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
