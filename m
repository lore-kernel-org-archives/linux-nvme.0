Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DB2C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 12:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qi/E7dADW2axBeKtE9GBeuHyuoF8yi5svA/zc/3sOIQ=; b=HNwI1Q46kYsTSC
	cKIu6kjILsTg89y0grn2oFnfypSIRSy+qpPmQtdonx8+Cxfnp2wexfSkl8DOUAJL4wNWdnHI7ZC7I
	a1IUsD/bMEkjWBkkYpLTtR5F5m+c/FRMDvUymft5VTdrP8qaBf5aKDcLq5DNZWqDRi6uW/rXPyL56
	O2NQuzWFKmbdCUrioxjDAtF4NiWy1M7SLIcHn2UXTaq/4Bk+ZlefQDmTvhNDBGwPUk+ZHi8Yb+ymU
	6aqkfPnbfTUwsd2SiAf1L3xfNCHLwietmPqojYon7fV/BntTDHLcr5eDv/GLbIWAzRTegXZJXzvqn
	cwWMfV4o6l6felONA0zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdnl-0000000FMm4-3qpL;
	Wed, 07 May 2025 12:23:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdnj-0000000FMky-2PUT
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 12:23:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 82CB74A171;
	Wed,  7 May 2025 12:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D1DC4CEE7;
	Wed,  7 May 2025 12:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746620582;
	bh=PTePx/tbSwUMSUcdhzkd1zsfWx4z1VfNP7TIanK5+SM=;
	h=From:Subject:Date:To:Cc:From;
	b=DyMgeiwy9dQcX98K3g4aW/54zNKWxLQ3A7zEN+XEzypf3o7lW/hIwrCVbLEPOfnVD
	 U0kdBIHafEAdujP8NfOeuZvhufFhu7qJfjVxuVUMmQXr57TIhRncUgJqKROYYZ6elp
	 6/uZNsFz1UMgQ3TZnX9zI3HkazMJley3KhbN4MClp/nCrmx0RfAnnLvJ+uU5YGEezg
	 X0L3NnbifJYFDHXB6iRjlNZiV8cWeyI7F8mUj8O6vKI1iHnu6WdoZZIcElcGZwKP64
	 xlz3chaV7xipc1qtMqBle45KOEzWEXqVSZyiE7gfG8hDzjHnHYclzJn6ozEVpXfHHx
	 USpmsuLplwJvg==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v6 00/14] nvmet-fcloop: track resources via reference
 counting
Date: Wed, 07 May 2025 14:22:56 +0200
Message-Id: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKBQG2gC/2XRzW4CIRSG4VsxrEsDh1+78j5MFwMclGgHy0xJG
 zP3XvxJ1JnlR/K8i8OZDFgSDuRjdSYFaxpS7tvQbyvi912/Q5pC2wQYKAZc0r5+4UijP+Z8op2
 WayOsM6iRNHIqGNPvNbf9bHufhjGXv2u98svrPQT6NVQ5ZdQzF6wIUqDuNgcsPR7fc9mRS6nCQ
 wvOZxqajl4y77TEgEstnrWdadE0UxE9i55B1AstH1pyNtOyaYPKS3DGgXcLrZ40iJlWTYtg4lp
 bA7ZTL3q6nbTg90/7mPF+12n6BwYcNiG2AQAA
X-Change-ID: 20250214-nvmet-fcloop-a649738b7e6e
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_052303_655130_C1AAD91E 
X-CRM114-Status: GOOD (  10.99  )
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

Rebased on nvme/nvme-6.16 and addressed Hannes feedback.

The blktests nvme/030 is likely to fail if in the background udev is
triggering a 'nvme discover'. In the meantime I collected some more
patches but hold them back until this here is done.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v6:
- rebased on nvme/nvme-6.16
- made the slab cache static, reported by kernel test robot <lkp@intel.com>
- fixed inverted logic when testing if the port should be deleted
- Link to v5: https://patch.msgid.link/20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org

Changes in v5:
- rebased to nvme/nvme-6.15
- Link to v4: https://patch.msgid.link/20250410-nvmet-fcloop-v4-0-7e5c42b7b2cb@kernel.org

Changes in v4:
- reordered patches so that they pass the tests each on of its own
- addressed feedback from Christop, Hannes and James.
- hold lock while looking up nport and insert nport operation in fcloop_nport_alloc
- dropped patches from 20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org
- Link to v3: https://lore.kernel.org/r/20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org

Changes in v3:
- fixed memory leaks
- allocates fcloop_lsreq in fcloop directly
- prevent double free due to unregister race
- collected tags
- Link to v2: https://lore.kernel.org/r/20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org

Changes in v2:
- drop tport and rport ref counting, use implicit synchronisation
- a bunch of additional fixes in existing ref countig
- replaced kref with refcount
- Link to v1: https://lore.kernel.org/r/20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org

---
Daniel Wagner (14):
      nvmet-fcloop: track ref counts for nports
      nvmet-fcloop: remove nport from list on last user
      nvmet-fcloop: refactor fcloop_nport_alloc and track lport
      nvmet-fcloop: refactor fcloop_delete_local_port
      nvmet-fcloop: update refs on tfcp_req
      nvmet-fcloop: add missing fcloop_callback_host_done
      nvmet-fcloop: access fcpreq only when holding reqlock
      nvmet-fcloop: prevent double port deletion
      nvmet-fcloop: allocate/free fcloop_lsreq directly
      nvmet-fcloop: don't wait for lport cleanup
      nvmet-fcloop: drop response if targetport is gone
      nvmet-fc: free pending reqs on tgtport unregister
      nvmet-fc: take tgtport refs for portentry
      nvme-fc: do not reference lsrsp after failure

 drivers/nvme/host/fc.c       |  13 +-
 drivers/nvme/target/fc.c     |  85 +++++++--
 drivers/nvme/target/fcloop.c | 437 +++++++++++++++++++++++++++----------------
 3 files changed, 362 insertions(+), 173 deletions(-)
---
base-commit: 0ea9b1f7aabb8af08649048d04fa3cee44dac4ab
change-id: 20250214-nvmet-fcloop-a649738b7e6e

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


