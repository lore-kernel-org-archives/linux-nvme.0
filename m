Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F293E9537A
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 10:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DYoDSSHN9bWYJYQs2fJHBzydV2bkb0VTteBtZ02CgAs=; b=VSr6FNxbyRpRgowQ7gb29iT1vz
	drRKd8611R3uZeCJQSLPks4sGfAZ7Vqolb0gIrtdxAIWdAjN4yHbp54Hz2guV/57wFAUgP1PR7nAG
	c8HwrFfTrpgsao/31BI6z/1TzwyaixvGT3NckL6QUfiIHvoR83pjx54XVLeQJa/sbEyA4j/eMwbvU
	UyZQp0V/w1rzLozFAqKJGTK9GZ5usjIaq679Iu/5ePqj+tIV2/Oomq2rRJOmxW1aI1R2RhPiBdEg4
	+V/zkGeNYKbJAqw6hhr9O0+/FFcvSYXL5vvWmi0Hd62YzZz+fkYnWhUSVq86sm4CyfRWgM1U5h4va
	JEejahuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnaYQ-00000008Jin-3ume;
	Wed, 04 Feb 2026 10:56:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnaYM-00000008Jhy-0H53
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 10:56:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770202567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DYoDSSHN9bWYJYQs2fJHBzydV2bkb0VTteBtZ02CgAs=;
	b=aAqEBdhzDRvSIkfhImjKNI8Io3f2Cn/CP8Zb6ovhRMOdg9YwIeDpwd3q/FJ6ESYZvziWH+
	4oyJyauSxp+qL7YqNZoU3z4bZwGUwQEfKglpNpUCHK7Q9FF3663G4oQGgJOm3Oxvy3KGRX
	uiPChDbg0TIXZBuCdHwumdaK6iowGyI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-4HdiBaAWOhuiJPDoSUpICg-1; Wed,
 04 Feb 2026 05:56:01 -0500
X-MC-Unique: 4HdiBaAWOhuiJPDoSUpICg-1
X-Mimecast-MFC-AGG-ID: 4HdiBaAWOhuiJPDoSUpICg_1770202560
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9682195608D;
	Wed,  4 Feb 2026 10:55:59 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.45.224.73])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A1B619560A3;
	Wed,  4 Feb 2026 10:55:56 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	hare@suse.de,
	jmeneghi@redhat.com,
	emilne@redhat.com,
	mlombard@bsdbackstore.eu
Subject: [PATCH V3 0/1] Enable/Disable NVMe quirks via module parameter
Date: Wed,  4 Feb 2026 11:55:54 +0100
Message-ID: <20260204105555.173661-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y2bEfrzOyOooGPjoqEZWunYWNP5JII4cPnT2fNZB4-w_1770202560
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_025610_199147_62912514 
X-CRM114-Status: UNSURE (   9.43  )
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

Recently, some of our customers were very vocal about wanting an
easy way to enable or disable specific nvme quirks.

I recall that during the ALPSS conference this topic has been briefly
discussed, and it was proposed to use the generic PCI sysfs "new_id" entry
to manipulate the quirks.

However, in some cases a quirk may prevent the system from properly booting,
the kernel may hang or fail to mount the root
filesystem before the system reaches a state where new_id can be written,
this makes this solution not exactly user-friendly for end users.

In particular, boot-time hangs have been reported involving the
bogus_nid quirk.

Therefore, I have been asked to re-propose this module parameter approach
with a few modifications suggested by Daniel Wagner.


# dmesg | grep nvme
[    0.000000] Command line: root=/dev/vda1 console=ttyS0,115200n8 nvme.quirks=1b36:0010:^bogus_nxid
[    6.732692] nvme: unrecognized quirk bogus_nxid

# cat /sys/devices/pci0000:00/0000:00:05.0/nvme/nvme1/quirks
bogus_nid
                                                                                                                                                                                                                         
# dmesg | grep nvme
[    0.000000] Command line: root=/dev/vda1 console=ttyS0,115200n8 nvme.quirks=1b36:0010:^bogus_nid,no_apst
                                                                                                                                                                                                                         
# cat /sys/devices/pci0000:00/0000:00:05.0/nvme/nvme0/quirks                                                                                                                                             
no_apst

Maurizio Lombardi (1):
  nvme: add support for dynamic quirk configuration via module parameter

 .../admin-guide/kernel-parameters.txt         |  13 ++
 drivers/nvme/host/pci.c                       | 162 ++++++++++++++++++
 2 files changed, 175 insertions(+)

-- 
2.52.0


