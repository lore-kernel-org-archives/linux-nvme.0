Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2929C35FF8
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=myKoYJwKhph0+d5geWp1jUvBTAGwJlgdSDAuAOQ2Auw=; b=v4RJPZZ3zgccPX
	P0y3PgYA5AVvalwBsnpca4r/rZuSlJt9xXC6Gfeks9i0CJZSJ6QVZh7AXizZqA326PyvTZ6KlIAYL
	n76/S9daRsdBBbYORSNLuFWEyxOINSQkt/iWHzuBX/L4KK/Zk+MrWVIhSkuesvKdt4lreWXorhL7o
	QjQp38RRvZ8gzS82TxjumS7aU4Fby7v7BoX403tJQJRErODqqsbX9WrFyzqghiFkigGQKERyketCF
	3Q7YDIYkdsNcS35eK6WqELloldNb7PdaElrTitnmuEvb2VgZVt+/l4UX7m+BaPR4tSdt+nS9gxm0L
	/kgPnt0IKSixrf5kkcPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMn-00000005XjE-0ZEF;
	Tue, 18 Mar 2025 10:40:13 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMe-00000005XgD-3uHp
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 528C5A48F37;
	Tue, 18 Mar 2025 10:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7EBC4CEDD;
	Tue, 18 Mar 2025 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294402;
	bh=x4ZfUJ1dTXVbzL8RRo44yqAIAd/xoE2IKgTqAylCCj0=;
	h=From:Subject:Date:To:Cc:From;
	b=kj+GWgVlWMqMXLT/pjvi+8+VJWBlOhy7Jp/yHtyHD3ED4evaustyMWDtjjXzevlH1
	 TRyLbBLTSH2GzT6ab5Z+PlersZaarxTzQNyoyS8IRYxq6BYfuaUZdv01UKyu5sjkCw
	 2tg8AHXlpBHPebQHHC/9bCUHgX0oc2gqfehhQWRwHj2+NrRiv22Kya2i8f0V8LGQkf
	 bibmmctSCkZmZR1yCHrzkiVl7fPNzSRH100zt1EuQTFtE0rm8BGCArbCo+5ts1IFj2
	 O31WoScsUVAHsJdA/RiYLlOhWQ1bz2D26u+0O3FILUDaa6yxDpZxjFGu5dKWM9+mSN
	 e3oq0ImBwWumA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v3 00/18] nvmet-fcloop: track resources via reference
 counting
Date: Tue, 18 Mar 2025 11:39:54 +0100
Message-Id: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHpN2WcC/13M3QqCMBjG8VuR97jFvprWUfcRHej2qiPbZJNRi
 PfelCDs8Hng/5shYrAY4VLMEDDZaL3LQxwK0H3tOiTW5A2c8hPlTBKXnjiRVg/ej6RW8lyKqil
 RIeRkDNja18bd7nn3Nk4+vDc9sfX9QlztocQIJZo2phJGClT19YHB4XD0oYNVSvxXC8b+ap7rV
 kuqGyXR4L5eluUD9GGuv+cAAAA=
X-Change-ID: 20250214-nvmet-fcloop-a649738b7e6e
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034005_110992_4842E622 
X-CRM114-Status: GOOD (  12.25  )
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

It turns out v2 had a memory leak, which sent me down the rabbit hole
once again. The obvious leak was easy to fix. I took one reference too
much on fcloop_lsreq.

The second one was a really tricky. The fcloop_lsreq object are allocated
by either host or target. So the lifetime of these object are tied to the
lifetime of the host or target. I tried several things to avoid UAFs but
everything failed. Eventually, I decided to allocated the fcloop_lsreqs
in fcloop directly. All got way simpler and the mem leak is gone and
there are no UAFs anymore or blocked processes.

Sometimes some blktests fail but these really look like existing problems
which got uncovered by this series.

With this series the fcloop and nvmet-fc should be in way better shape
and hopefully most of the UAFs should be history. This allows futher
refactoring/cleanup/improvements or more nasty blktests.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
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
Daniel Wagner (18):
      nvmet-fcloop: remove nport from list on last user
      nvmet-fcloop: replace kref with refcount
      nvmet-fcloop: add ref counting to lport
      nvmet-fcloop: refactor fcloop_nport_alloc
      nvmet-fcloop: track ref counts for nports
      nvmet-fcloop: sync targetport removal
      nvmet-fcloop: update refs on tfcp_req
      nvmet-fcloop: add missing fcloop_callback_host_done
      nvmet-fcloop: prevent double port deletion
      nvmet-fcloop: allocate/free fcloop_lsreq directly
      nvmet-fc: inline nvmet_fc_delete_assoc
      nvmet-fc: inline nvmet_fc_free_hostport
      nvmet-fc: update tgtport ref per assoc
      nvmet-fc: take tgtport reference only once
      nvmet-fc: free pending reqs on tgtport unregister
      nvmet-fc: take tgtport refs for portentry
      nvmet-fc: put ref when assoc->del_work is already scheduled
      nvme-fc: do not reference lsrsp after failure

 drivers/nvme/host/fc.c       |  13 +-
 drivers/nvme/target/fc.c     | 153 +++++++++------
 drivers/nvme/target/fcloop.c | 435 ++++++++++++++++++++++++++-----------------
 3 files changed, 376 insertions(+), 225 deletions(-)
---
base-commit: a149420f548dc8e2258461522f498252554c0bbd
change-id: 20250214-nvmet-fcloop-a649738b7e6e

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


