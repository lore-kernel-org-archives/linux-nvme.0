Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3CDC43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 18:08:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E42620714
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 18:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hTTfdokq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UY51cQuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E42620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dNzo1InvCuM0jqZzkrwQ6bu2PJJ6SsPGSu8rSMzzJM4=; b=hTTfdokqLB15+s
	Uj0rmmnok9RKzdyUg+wReGKtKshGB58SFAgXiKYrm9gPCu+X/tyXLyGPrtUwziLv8i2hDIh78qmRT
	Xo3HGomQyjptc9VY9p+TyhMG4ub4bt/BaFZyW4jKxF2M6PBi9PEkbrPsfJ9AFumfrBaFVBuN7VgwL
	qXW3+wQ3+4vaeJXDGCa+WDumzy7ee8ZCJoeeRy54s6ZG1clyCXji6Db6W3MH4gOAtV8J4MLNEYx87
	Y0p42WSvaSkNUmi/ivoAQT8JiGZ+HoNx4tEoUrNMXz+rpB1txhzCZowJ2RRCbuQmsFU7cfrVKcNBz
	SM5o8BC4PrylIXcstJCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHWvF-0006gy-8n; Thu, 26 Mar 2020 18:08:05 +0000
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHWvC-0006et-MX
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 18:08:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585246080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vZTqWRC2XYLQnXwJCM5pucMrYmDFZ/taIqtJLeHKNg4=;
 b=UY51cQuGvtqqzwmJoectFOW+kFrLibhf8rMGmFrjIvBEyRYZV6meDeEEXwKWWfd/ctS66H
 uMslJ3+kau+0W5+o1k/uPrlBYHkH7AkHS+qnR2X7bsan/lKzXiJINB2URkMyU3ZQuBl09X
 Y2y7hVcZiQOzJ3Moe9gjzv/sMmLexTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-P-UMd2apOze-LYZlwFsjEg-1; Thu, 26 Mar 2020 14:07:53 -0400
X-MC-Unique: P-UMd2apOze-LYZlwFsjEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F367800D48
 for <linux-nvme@lists.infradead.org>; Thu, 26 Mar 2020 18:07:52 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0825C19C69
 for <linux-nvme@lists.infradead.org>; Thu, 26 Mar 2020 18:07:51 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/7] Misc. corrections
Date: Thu, 26 Mar 2020 13:07:43 -0500
Message-Id: <20200326180750.469346-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_110802_819153_D81A29CD 
X-CRM114-Status: UNSURE (   6.71  )
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

v2:
* Updated commit msg for README
* nvmetcli: Revert to exiting non-zero for 'errors' present
* Updated commit msg for test_nvmet.py change
* Added new commit for reporting restore file name correctly

Tony Asleson (7):
  README: Update URL for configshell-fb
  nvmetcli: Improve IOError handling on restore
  nvme.py: Explicit close is redundant
  nvme.py: Sync the containing directory
  nvme.py: Make modprobe work for kmod lib too
  test_nvmet.py: test_invalid_input fails for py3
  nvmetcli: Report save name correctly

 README              |  2 +-
 nvmet/__init__.py   |  3 ++-
 nvmet/nvme.py       | 17 +++++++++++++++--
 nvmet/test_nvmet.py |  2 +-
 nvmetcli            | 22 ++++++++++++++++++----
 5 files changed, 37 insertions(+), 9 deletions(-)

-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
