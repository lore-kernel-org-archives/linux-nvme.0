Return-Path: <SRS0=BJyz=JK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA45C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 10:21:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776186024A
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 10:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776186024A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/ILv2WHgG95PCIqHk6k8SBkcbgo0qq7+eRJCUIiP830=; b=K7Mw0T5066Fq39w0+MgZv4aQQN
	MGk+8cRxIeRgPylWgc7GvpgklIcVuPjchA9WpUQWmVYnytv4I8q5/9A3KNed2K+nL0xv4MfQMUBs7
	2HvzSftP6+8co9QgaPBM7b2qS3Hf9kNklFN858cOtG1sYTPGM0Dd21jCI1EpnzFsekSfIXcDlfqh4
	pKoz8D1fzTAaG72+t0syBtj5jzaynsFw9mww9R0v0IMEWE/eJEnP/pnp7CUmSs3j7SEtjr2aGXbyH
	qV3/SjDnnKxSYSRTUWZkF+eljcHKBvt9oifbKSV7svdPHEDw0JCYxJxoWO3V5zQNRqZfjUIAELK3v
	uTO0vWyg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWGAK-008rXg-2B; Tue, 13 Apr 2021 10:21:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWGAF-008rWr-Nb
 for linux-nvme@desiato.infradead.org; Tue, 13 Apr 2021 10:21:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:
 Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:Content-ID:Content-Description:In-Reply-To:References;
 bh=XE1bG7B/d1adTgTbstxVqrMzAhETXrUzXf2K7caOfpI=; b=XXaCD7zCHJeTboY6FImHGyp934
 F1aztmd59E4pNBkCtzzktZd1IufkvRUT118l/y4VnMaNcIvpVjnteKE9LBF6yC7ZsoAhTt8UEo6WL
 ypfW7xCMTdmSbKB0sRQywGwz8qJOGybYI/yn36bHo1WEQiDy3jWo8tvPuO7Tx69+IHdj9JYw3HlSN
 okf4RMfHetNc2Z4JRewmd+6Y1TeizvYFDXmIELaWt4xHeC6H4hNz4aMe3bFvs/Nkdh5jqQcOymq4t
 Ea6jty2SD+td8ydkFm/pvGVjywLGP9OWXbsWfcYrSWixKun0MYChC9N1RY1FBi/7qqWkAe57Upe/p
 OTu+oj6w==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWGAC-006vHI-Tn
 for linux-nvme@lists.infradead.org; Tue, 13 Apr 2021 10:20:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618309255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XE1bG7B/d1adTgTbstxVqrMzAhETXrUzXf2K7caOfpI=;
 b=aY/XON7ZLCrFDSnuSy9jAuVrrC129ZX8pduABIECKWTh3lwkHMaq0o1m5fK1c4ykNjH9Mx
 rWs3w6QwlhhdtBW3jqXfKmdshtVHHA1tZjLkYBG+c6XsQkslaNeSPFBYFo8MsWf8Q+KhFa
 C+zW/z1LaHXzqauZfruieDAsI84WbtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-dVcrnu_ZNMWjPyN1djybBw-1; Tue, 13 Apr 2021 06:20:51 -0400
X-MC-Unique: dVcrnu_ZNMWjPyN1djybBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3EBC87504E;
 Tue, 13 Apr 2021 10:20:50 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7995F17A70;
 Tue, 13 Apr 2021 10:20:49 +0000 (UTC)
From: Gopal Tiwari <gtiwari@redhat.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org
Cc: gtiwari@redhat.com
Subject: [PATCH] Fix NULL ptr deref in nvme_ctrl_fast_io_fail_tmo_store
Date: Tue, 13 Apr 2021 15:50:46 +0530
Message-Id: <20210413102046.544959-1-gtiwari@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gtiwari@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_032057_052695_D8253F06 
X-CRM114-Status: GOOD (  11.66  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When trying to set fast_io_fail_tmo from /sys hit kernel crash

[ 1749.892646] RIP: 0010:nvme_ctrl_fast_io_fail_tmo_store+0x55/0x80 [nvme_core]
[ 1749.918344] RSP: 0018:ffffb52541d53e78 EFLAGS: 00010206
[ 1749.923550] RAX: 000000000000001e RBX: 0000000000000003 RCX: 0000000000000000
[ 1749.930653] RDX: 000000000000001e RSI: 000000000000000a RDI: ffff98e75e774d42
[ 1749.937760] RBP: 0000000000000000 R08: 000000000000001e R09: 0000000000000002
[ 1749.944862] R10: 000000000000000a R11: f000000000000000 R12: 0000000000000003
[ 1749.951968] R13: fffffffffffffff2 R14: ffffb52541d53f08 R15: ffff98e74fc240e0
[ 1749.959072] FS:  00007fc551327740(0000) GS:ffff98e79dc40000(0000) knlGS:000000
00000000000
[ 1749.967127] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1749.972852] CR2: 0000000000000064 CR3: 000000043f53c005 CR4: 00000000003706e0
[ 1749.979956] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1749.987062] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[66824.400512] IPv6: ADDRCONF(NETDEV_UP): wlp0s20f3: link is not ready
[ 1749.996612]  kernfs_fop_write+0x116/0x190
[ 1750.000610]  vfs_write+0xa5/0x1a0
[ 1750.003918]  ksys_write+0x4f/0xb0

Fixed by checking opts for NULL.

Fixes: 09fbed636382 (nvme: export fast_io_fail_tmo to sysfs)

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 39b8fbe87adb..d26eddf2bde4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3764,6 +3764,9 @@ static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
 	struct nvmf_ctrl_options *opts = ctrl->opts;
 	int fast_io_fail_tmo, err;
 
+	if (!opts)
+		return -EINVAL;
+
 	err = kstrtoint(buf, 10, &fast_io_fail_tmo);
 	if (err)
 		return -EINVAL;
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
