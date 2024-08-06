Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2753C49EA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Da27AApIHCmREbL3F0FCZ+1oP8ihlsnaa1F9fgrccaw=; b=CC+moh1ZpjTO3/NgYwhLDjWWnt
	soa+HBXmb/a5x2LqGiuwIU+OLvEFOyF/Feqtmb5JQnnt5j5mJZ3sQqOMBi+TOw0d9G5iCfvZ31Bz3
	c40yQsE4aYw+WHJ1w+Me6eK6k4dGP3yqfKqQcplrV381McoPSbtS6jKTHlc/WnQetBALQEHTxS4Nc
	HRWkAmMmewIgYgp9GGBYgrSY/8P8sRRlQgapcPMrVMoykiNM1dFCjzHSLgBbrx/J9X51b9+9ioXhU
	6v1gXNYQNcvQabAlj3CcNcQHspD5C04oxPIpJE4LHR7td9ExjYu8arfG96SU/I0XThqQf44YODRI7
	8k3b4S5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbLXh-000000023Dq-1KbX;
	Tue, 06 Aug 2024 14:52:05 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIyS-00000001R2Z-3RMW
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 12:07:34 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D371DAE1E;
	Tue,  6 Aug 2024 14:07:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1722946050; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Da27AApIHCmREbL3F0FCZ+1oP8ihlsnaa1F9fgrccaw=;
	b=p7iY69/bJJXFtotZvjZBtrSM+GmEiKE449uaYkdFqaek4eNU7XBLty3NVL8BO/PnByYyO1
	bd5fZ47jjUCnPnScikX/WqWy5N/WSb6iBPrFrnNja2YLGJMv5fAMrpLXjMdLiDXp7/XsSA
	vKriLqtXVZ8fYwf9pUT/x/19tNsYETy8oSq5cQ1eiqReqoOEAhQuXzWlS9Vx1GbQQq9O4U
	6Fa6KLhEiOXnRHgiqZJK6SE7xh/V/AYklPmIWAvPgJFv4JkmXF6bW8+vDHWIH5ETCj0hvz
	8UlLLCM4YncXPIL9McUpI5vgCMt4SXdgLDAk07Bz3T+dL7/DjMYqBdeNn9TAPw==
From: Daniel Wagner <dwagner@suse.de>
Date: Tue, 06 Aug 2024 14:06:41 +0200
Subject: [PATCH v3 09/15] docs: add io_queue as isolcpus options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-isolcpus-io-queues-v3-9-da0eecfeaf8b@suse.de>
References: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
In-Reply-To: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
 Christoph Hellwig <hch@lst.de>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 John Garry <john.g.garry@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Kashyap Desai <kashyap.desai@broadcom.com>, 
 Sumit Saxena <sumit.saxena@broadcom.com>, 
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, 
 Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, 
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, 
 Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, 
 Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
 virtualization@lists.linux.dev, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-doc@vger.kernel.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_050733_067658_AE440ECD 
X-CRM114-Status: UNSURE (   8.23  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 06 Aug 2024 07:51:53 -0700
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

isolcpus learned a new io_queue options. Explain what it does.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1384c7b59c9..a416cc969e97 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2446,6 +2446,15 @@
 			  housekeeping CPUs has no influence on those
 			  queues.
 
+			io_queue
+			  Isolate CPUs from IO queue placement by
+			  multiqueue drivers. Multiqueue drivers are
+			  allocating and distributing IO queues on all
+			  CPUs. When this option is set, the drivers will
+			  allocated only IO queues on the housekeeping
+			  CPUs. This option can't be used toghether with
+			  managed_irq, use one or the other.
+
 			The format of <cpu-list> is described above.
 
 	iucv=		[HW,NET]

-- 
2.46.0


