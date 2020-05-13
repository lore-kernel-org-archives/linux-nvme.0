Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9AAC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 15:10:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40E6205ED
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 15:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ADOSmnzA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJ/RrQ55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40E6205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Qa97jVKoHyvuiQTvjsTPFYk3qLC6T1jjw1IXRrGefrY=; b=ADO
	SmnzAFmQHAJAKjqMIwfQN2Nvdvx2U0TkRsbHkWiF6VaMH4oY4qVeb4uuwjGM1c26VQ9K/XxZp1sZ9
	NDceIqjc+oBu5tWLO7PJ37LNKzXNywcaDkfio5rYnGgAVeRiQ9C5A3JFUVR5cmLUTXBG8v+QzITt3
	H03vyU/5THFKqBUj2TA+8QBlS2EafVQd2z6MsCRjRndEdnJF1reDW+KFm8qFb41ccZivmG2KdPco/
	qY7z4LFSf+pmhAJSfNWasG/zfOeLFpPWe7jd+Y7SfgaE2Qsv6xQDJu6Jftzb6nw8x4i1GPN/1pAhF
	mGX+0dqFHJMtVNphOCq1Jf8Uoxx8mLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYt1Y-00017u-Ky; Wed, 13 May 2020 15:10:20 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYt1U-00017E-DK
 for linux-nvme@lists.infradead.org; Wed, 13 May 2020 15:10:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589382613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=RgiE7pcdGzxqg9Eu5I4KQTdkZmrXnJSN0UZy8tXZ0FM=;
 b=bJ/RrQ55o6SSBwc+4mUmP1D1cdINW9WVWKhihN5Md+vMSBqcDnmpy5JNlnAvbJ7D7NF8yH
 Nfjst53+IsoXe/GdvpSif+hNlHdjsHHt5sGIkUb11GbwRU8Y2F5zuSJLybIOyYgDwHDYyV
 B2hctezWR5VvJTZQBOB5NFH8hARVtUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-s854XI8bNBCcY1_o6U6gJA-1; Wed, 13 May 2020 11:08:15 -0400
X-MC-Unique: s854XI8bNBCcY1_o6U6gJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2406801504;
 Wed, 13 May 2020 15:08:13 +0000 (UTC)
Received: from hpz440.redhat.com (ovpn-112-128.phx2.redhat.com [10.3.112.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C43E391;
 Wed, 13 May 2020 15:08:13 +0000 (UTC)
From: David Milburn <dmilburn@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: nvmet_async_events_process always free async event to
 avoid memleak
Date: Wed, 13 May 2020 10:08:12 -0500
Message-Id: <1589382492-9811-1-git-send-email-dmilburn@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_081016_929765_C8A777E7 
X-CRM114-Status: UNSURE (   8.83  )
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
Cc: hch@infradead.org, chaitanya.kulkarni@wdc.com, dwagner@suse.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvmet_async_event may not be freed yet while processing events.

$ cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff888c1af2c000 (size 32):
  comm "nvmetcli", pid 5164, jiffies 4295220864 (age 6829.924s)
  hex dump (first 32 bytes):
    28 01 82 3b 8b 88 ff ff 28 01 82 3b 8b 88 ff ff  (..;....(..;....
    02 00 04 65 76 65 6e 74 5f 66 69 6c 65 00 00 00  ...event_file...
  backtrace:
    [<00000000217ae580>] nvmet_add_async_event+0x57/0x290 [nvmet]
    [<0000000012aa2ea9>] nvmet_ns_changed+0x206/0x300 [nvmet]
    [<00000000bb3fd52e>] nvmet_ns_disable+0x367/0x4f0 [nvmet]
    [<00000000e91ca9ec>] nvmet_ns_free+0x15/0x180 [nvmet]
    [<00000000a15deb52>] config_item_release+0xf1/0x1c0
    [<000000007e148432>] configfs_rmdir+0x555/0x7c0
    [<00000000f4506ea6>] vfs_rmdir+0x142/0x3c0
    [<0000000000acaaf0>] do_rmdir+0x2b2/0x340
    [<0000000034d1aa52>] do_syscall_64+0xa5/0x4d0
    [<00000000211f13bc>] entry_SYSCALL_64_after_hwframe+0x6a/0xdf

Steps to Reproduce:

target:
1. nvmetcli restore rdma.json

client:
2. nvme connect -t rdma -a $IP -s 4420 -n testnqn

target:
3. nvmetcli clear
4. sleep 5 && nvmetcli restore rdma.json
5. cat /sys/kernel/debug/kmemleak after 5 minutes

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/nvme/target/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b685f99d56a1..8b78f42c1eb6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -139,6 +139,7 @@ static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
 		aen = list_first_entry_or_null(&ctrl->async_events,
 				struct nvmet_async_event, entry);
 		if (!aen || !ctrl->nr_async_event_cmds) {
+			kfree(aen);
 			mutex_unlock(&ctrl->lock);
 			break;
 		}
-- 
2.18.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
