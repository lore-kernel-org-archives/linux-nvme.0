Return-Path: <SRS0=0ID+=5Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F47C2BA2B
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 16:09:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B41BB208FE
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 16:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HMZSZPqv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL/oT+8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41BB208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=l1aGz3OMdCll2ALGcftdy1tOZ7XSeJlGvY26aj5ylNk=; b=HMZSZPqv0USiZZ
	JGGc/mqQ1bLhew9vh9xO9k8IbeQk2QEMsoWjkS7cTA6bo0IONlS+QNcud/whXEiGebvB6vG5fXln1
	ldDkOjVU4p6zu12Ic1H3usgfAJnIandsd//ERn8kVWt/ZDkOLRg1CdRAJ2RRyt2RpZb39B3oxeL2K
	w1hl+XF0TjnYPe7/bp2C5bcZIWScYOywGh0g5Ivkh8kPTjfcTOinZ5htLZPd4/xErxXHkuJE6cdof
	SuaYRiXS5TyXlI5XYFXelpNJ00yfh5YfnUOgg/uACvcZNGRvdBs857AE94PQyRy6PiWLRCcXbBxic
	IVo43on5EEtXSxxhvNng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMZju-0001S2-0g; Thu, 09 Apr 2020 16:09:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMZjq-0001Pj-Bn
 for linux-nvme@lists.infradead.org; Thu, 09 Apr 2020 16:09:12 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 78B9D20771;
 Thu,  9 Apr 2020 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586448549;
 bh=iKWof8b0exp4bjgAolQIwP9IWPfjfT6BA8MFz7/71rA=;
 h=From:To:Cc:Subject:Date:From;
 b=FL/oT+8lRe7FSHAuoBY0OKE4ix838+pLeYYp0asJi+qmJW6zI4N4wi3kaWYjrYGP2
 bXc2/WNAZK23st819dnQSbtuzOAzyWD38VjR3HVMKt5K4s7Vv4sAV6XlRTN+HVVGxd
 xpCWBdmxlj+Tu4h8p7BG8r/vqAr8bmawZwBjVe6s=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 00/10] namespace settings updates
Date: Thu,  9 Apr 2020 09:08:58 -0700
Message-Id: <20200409160908.1889471-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200409_090910_419714_FDF2497E 
X-CRM114-Status: UNSURE (   6.93  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A collection of fixes and rearrangments to setting up namespaces.

Keith Busch (10):
  nvme: unlink head after removing last namespace
  nvme: release namespace head reference on error
  nvme: always search for namespace head
  nvme: save namespace head shared property
  nvme: don't directly update multipath queue settings
  nvme-multipath: set bdi capabilities once
  nvme: revalidate after verifying identifiers
  nvme: consolidate chunk_sectors settings
  nvme: revalidate namespace stream parameters
  nvme: consolodate io settings

 drivers/nvme/host/core.c      | 116 +++++++++++++++++-----------------
 drivers/nvme/host/multipath.c |   8 +++
 drivers/nvme/host/nvme.h      |   2 +-
 3 files changed, 67 insertions(+), 59 deletions(-)

-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
