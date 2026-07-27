Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E9AC531D0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 20:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wgULkT/0QEhLC7JJzVigtPu4uZ9cypSWR2LIyrTDAfg=; b=LrBihYB2RSwX3WHmO7qCcB7VlD
	APCv6adN0CRVqjXYm4GNreQp8m4L6911HksuOPzXgKO7j/YgMQM32gamS2/ZQWugal2gcQD6DUr24
	806SA3qd1QLq7rRWjTYbMqoPJqsEMCArCITwxiFiIpPD15C86thtxZVnDrPr3fdFpnbxFMTqNlFZW
	tmTwGpGDM/D/snUBO3vssoS7DkKmOkgrSKLtBJoh1yQfM/VXj0moIgtOeWXodp/Ejp/kLORfWitQf
	8LyJxAE1Vs08ciW4wtHxSA4HpyxxQ8sRyoGzKElyr/oWNi4qEyFJcfB+05+fn7vM2OBLmZSvC7z1i
	ieckwC+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woRYB-00000003ns3-1nut;
	Mon, 27 Jul 2026 20:03:47 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woRYA-00000003nrx-0QaQ
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 20:03:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1021A60008;
	Mon, 27 Jul 2026 20:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B4B1F000E9;
	Mon, 27 Jul 2026 20:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785182624;
	bh=wgULkT/0QEhLC7JJzVigtPu4uZ9cypSWR2LIyrTDAfg=;
	h=From:Date:Subject:To:Cc;
	b=WgtTHNSfsFSshfrrVDi4GdI8QQXd64F2WwnHu3HMVl9lBWUYCO5mhexltNTLgKXUh
	 9t9NY9pX7byNOOtNHM6Hlq5u3NG14GqviW4IG+0EOHHhullc/onxmjbgISms2OCEKk
	 t4dp6Zp9C+poyIGb8tU0vPk3HK1dwPSBMli4NZ14=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 27 Jul 2026 22:03:31 +0200
Subject: [PATCH] nvmet-tcp: Do not WARN on remotely-controlled oversized
 SGL allocations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-nvme-tcp-v1-1-61c0e36763eb@linuxfoundation.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBTG8VfRubaaiZVXkQs7Do4ya0NqeXfD5
 a/+3xchkGcK0GQRPJ0ceLMJRZ4Bzr2dSPCQDEqqWmqlhT1XEjs6USGSHHVpJCKk3Hka+fqu2u5
 3OMxCuL97uO8HOIh7iWwAAAA=
X-Change-ID: 20260727-nvme-tcp-5cce0f73b0cc
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable <stable@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=fXuDlQj6YFbtZKzoRbu1BeZPvoNDU0BFV/CFrZNp9do=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFnpO6c81350uOvVV/Gs7YccFi6xZXRL1L56u1myOWirY
 TO/B8+sjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiI0X2GBaeKpMrYNOS9+KeH
 SYSduVl75bvtdoYFS+WaV+bHmxZomW1mdH/28d90q4peAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
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

When fuzzing the nvme target code, I tripped a kernel warning in
nvmet_tcp_map_data() because the length passed into the allocator is
controlled by the remote initiator.

A remote initiator that sends a command with an SGL claiming a huge
number, can create a scatterlist and iovec allocation of over 1 million
entries, which causes the backing kmalloc call to exceed MAX_PAGE_ORDER
and then the page allocator will trip on a WARN_ON_ONCE_GFP() message:

  WARNING: mm/page_alloc.c:5280 __alloc_frozen_pages_noprof
  Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
  ...
  sgl_alloc_order
  nvmet_tcp_map_data
  nvmet_tcp_try_recv_pdu

As it's never good to trip a kernel warning remotely due to many systems
having panic-on-warn enabled, let's silence it by just add GFP_NOWARN to
the allocation flags.

Assisted-by: gkh_clanker_2000
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/target/tcp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 75a276d73be3..d61622ed8dd8 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -433,13 +433,14 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	}
 	cmd->req.transfer_len += len;
 
-	cmd->req.sg = sgl_alloc(len, GFP_KERNEL, &cmd->req.sg_cnt);
+	cmd->req.sg = sgl_alloc(len, GFP_KERNEL | __GFP_NOWARN, &cmd->req.sg_cnt);
 	if (!cmd->req.sg)
 		return NVME_SC_INTERNAL;
 	cmd->cur_sg = cmd->req.sg;
 
 	if (nvmet_tcp_has_data_in(cmd)) {
-		cmd->iov = kmalloc_objs(*cmd->iov, cmd->req.sg_cnt);
+		cmd->iov = kmalloc_objs(*cmd->iov, cmd->req.sg_cnt,
+					GFP_KERNEL | __GFP_NOWARN);
 		if (!cmd->iov)
 			goto err;
 	}

---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260727-nvme-tcp-5cce0f73b0cc

Best regards,
--  
Greg Kroah-Hartman <gregkh@linuxfoundation.org>


