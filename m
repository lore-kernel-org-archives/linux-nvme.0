Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A474E7DF19
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 17:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vis51cACZNawZPMqhEqrF2odfgXrlh20ENxIY8SU74Q=; b=uwzNeVThUf4VH0ztQEtoD5/Gpo
	Sz+HJKnRwNMDKTPRS5CyzCs9EgTuvfLTF0RKo5H4zWHIKBagiTWy88bRq1Mn+s3aZ/rsAE99GOuLP
	d/wQMTYc3QpV5M7atTNpclAM++rzl+T7JqlvCJtO43jJhARXcNEAa4DDXP3VoZy8lXL+trd+txyPg
	gj8W4xeryvBZWTNE5Ba+uh2q09jZBf02X67eFct7ddGtt80ccTgulnoIDTL12sM0rqHTxa5kiFiIM
	7skGCxKhCG5gD2GZd+sfPQbA1u9F8SXGUgFdi23uf43krAxrprBMZmW5lxZtI1IAYNZoktMdekWVw
	Jg98YCXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxtM-00000005N5H-3ZbA;
	Mon, 02 Feb 2026 17:39:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxtJ-00000005N3o-0hFA
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 17:39:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770053950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vis51cACZNawZPMqhEqrF2odfgXrlh20ENxIY8SU74Q=;
	b=W794TDTnIa48mCAgBgkfH2IUcfzKkMjzXt32N6i8dGTd868UkCHaXR2P5Np2nzcp3dPi6J
	stgsFRartdLy8pCy/LtfnH3d5/PGje9u55izFL8iPGoTiTU7GXeT1SxAoCGr7bVoKm9ug3
	M+vcP5sl+2F4U0vPGmpNlhjjnuHl1VY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-jca8nuuSOLu8opE2ZdYWcQ-1; Mon,
 02 Feb 2026 12:39:05 -0500
X-MC-Unique: jca8nuuSOLu8opE2ZdYWcQ-1
X-Mimecast-MFC-AGG-ID: jca8nuuSOLu8opE2ZdYWcQ_1770053944
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48CDE1800615;
	Mon,  2 Feb 2026 17:39:03 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.196])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B164E19560B2;
	Mon,  2 Feb 2026 17:38:59 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	hare@suse.de,
	jmeneghi@redhat.com,
	emilne@redhat.com,
	mlombard@bsdbackstore.eu
Subject: [PATCH V2 0/1] Enable/Disable NVMe quirks via module parameter
Date: Mon,  2 Feb 2026 18:38:56 +0100
Message-ID: <20260202173857.759565-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kjwofZ203s0Bc638orpVHP_zCbxSDPbRWn6oNSJFXtM_1770053944
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_093913_270693_800D5F1E 
X-CRM114-Status: UNSURE (   9.65  )
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
 drivers/nvme/host/pci.c                       | 164 ++++++++++++++++++
 2 files changed, 177 insertions(+)

-- 
2.52.0


