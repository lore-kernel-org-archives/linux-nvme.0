Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E3DC43458
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 08:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/C+qUv40pk1VHTflrf+0DcieAhP+qHMo/j0ubeC/If8=; b=OhM5SaineI7oKdQNr14JdGiQJN
	wd6PkBjZNf4bVbTfK5tTiAxPnwiQA9BTAllsvz/tffkv/IQLh9mB5hxFrJNef/IxG9Uyn+Km7eqpV
	tAG2ivn8bd+TYWZL46JEJsGGOeZPhgphkXimY7mNFsVhEBqZgxUTKyFEjqlPCeImAiZ3depLfxQ7f
	w+9ZdV2vKaMpsmAd/nVLUMu8dzzKMcRTrd2D/bgX5PXNOf+nvwXsZ9NZEdP4uXH2xJtbniCQeIH7L
	zfiC9m+t3+TN7Yx7RRpVOBKUjzmOlepSdA46kyIwVi9MQGry3xHTpVqKmSMu1R8LISuKSY8IouOlC
	AeeHFnsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfD2q-00000003uT0-2MuK;
	Thu, 02 Jul 2026 08:45:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfD2p-00000003uSP-3gt7
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 08:45:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 265CA60121;
	Thu,  2 Jul 2026 08:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9369C2BCC6;
	Thu,  2 Jul 2026 08:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782981914;
	bh=V+8f3ptSv2O+Qemrg2hzcV6cjLZhcbQCDVQTRQvbZ0U=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZX36vPVkRtocwE1PpMhmHcxTnUss9t4PXVXKT0NZh1WOBOibiaSqZ4bhsB4wDbHQA
	 HO19SlHXO2q/AJ4oFkKf8z52hG2cExoH75hu6rg6fOuvsSGKrTpOPKNE5bPRmRJIzS
	 rh+kGBqOA57+XkU2t9WSgDA7v4aWcVs1KMqhYr0FbkrIBHpJp6Q97VCwka9MwxeTwG
	 8q6MDEiBnR6aPOT2fZWNlxFhOZ6j9Zn8ZW0xRKJ2Jcp1VzgD5eHQAUH2KZMkli0/ml
	 3OpZSneLLjeiqPqSnVJM1CeE9FXrEZmPZH1tmm6Ab9sYmR5F1XOy9hSecOtY/4Bfsb
	 Def+88ffySf6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A75C43458;
	Thu,  2 Jul 2026 08:45:14 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Thu, 02 Jul 2026 03:45:14 -0500
Subject: [PATCH] nvmet-auth: zero the AUTH_RECEIVE response buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-disp-127414cf-v1-1-e5395cc0f9ae@proton.me>
X-B4-Tracking: v=1; b=H4sIABklRmoC/x3MQQqAIBBA0avIrBvQwRK6SrQwHWs2JQoRSHdPW
 r7F/w0qF+EKs2pQ+JYq19lhBgXh8OfOKLEbSNOknSbcLEapGQ05a2xImAxHm7wbw0TQs1w4yfM
 vl/V9P1/+7O1iAAAA
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782981913; l=2253;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=gU5/fAZL43wPsT3d3TYzN8Tsh+FEfVV3hZS/y7sZgpQ=;
 b=uw6EkKIKIlzqvaFwO5ewHmz5r35ITG6phVPelJvCLGHpSNPv84yy8qs20an4v+tPvTMVH39Va
 rft5ALE4Va/BTb4Ru8ZX+/UVwsGw/JucLaw6OBst4JPdSoz6TKIXIl1
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
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
Reply-To: hexlabsecurity@proton.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Bryam Vargas <hexlabsecurity@proton.me>

nvmet_execute_auth_receive() allocates the response buffer with kmalloc()
sized by the host-supplied AUTH_RECEIVE allocation length, but the
DH-HMAC-CHAP builders write only a fixed-size message into it. The full
allocation length is then copied to the wire by nvmet_copy_to_sgl(), so a
remote initiator receives the bytes past the built message -- up to nearly
a page of uninitialized slab -- during the pre-authentication handshake.

Allocate the buffer with kzalloc() so the unwritten tail is zeroed before
it is sent; conforming responses are unaffected.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Found by inspection and reproduced with KMSAN. The handler runs during the
DH-HMAC-CHAP exchange before authentication completes; that reachability is
by inspection. The leak itself was reproduced with a litmus of the
alloc/fill/copy path -- kmalloc(al), an 8-byte builder write, then copy the
full al to a userspace sink (the copy_to_sgl-to-wire analog). KASAN is silent
because the read is in-bounds of the allocation, so KMSAN is the witness.

Before, al=4096:

  BUG: KMSAN: kernel-infoleak in _copy_to_user+0x44/0x90
   _copy_to_user
   full_proxy_read
   vfs_read
  Uninit was created at:
   __kmalloc_noprof
  Bytes 8-4095 of 4096 are uninitialized

After: no report.

Builds with CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y already zero the tail; kzalloc
closes it for the rest.
---
 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 45820a12750d..2b617d3b8bba 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -557,7 +557,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 		return;
 	}
 
-	d = kmalloc(al, GFP_KERNEL);
+	d = kzalloc(al, GFP_KERNEL);
 	if (!d) {
 		status = NVME_SC_INTERNAL;
 		goto done;

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260702-b4-disp-127414cf-f1ed4fa75c62

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>



