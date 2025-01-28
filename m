Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5014FC0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rOx1AeHGHGKJp6lInih8lKjGbwDwIlliH+FhRXZzSjE=; b=rp8DAQ+eytV6M/
	b2ucH6CFTi0FNrFvEhN9YzYIRgw18bXb2ij/5Rs/zt0zKpP2P3wGbmuA2IR/UUKsUI34kMXS4V996
	3oLWaLXGM8nkiBnMIhydWc41lAT178uFSyFpZgQCHp1K2GgSLHr3HsW/luHgHTsclURfAOTi9Wgyh
	boJBhJ9/1z27ybTF5oQmei6i+cJcs+qPyRIUsLA4wVH+71G6WcdTfKfBPrcQNJ8wiEBkyfmO+mF/v
	zac/VDisDPWT9qa49vjGlYRnTBlIgQvLs9AgzfXZPv9RDNPcCwwDEix74ySompaiB99uQ8m3m8ypD
	hT/vYodYmL0MS1Nh3XbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcof9-00000005MMH-2V6z;
	Tue, 28 Jan 2025 16:42:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcoYO-00000005LPA-1d9f
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 16:35:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7E6555C5F0D;
	Tue, 28 Jan 2025 16:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E27C4CED3;
	Tue, 28 Jan 2025 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738082107;
	bh=+i4tg6wE02L6FB7dQQmetQJ529MBj4JsPPL5ArjcfAY=;
	h=From:Subject:Date:To:Cc:From;
	b=eAZnRNUzLBhTkcwUtzf/2S3oCvllOy3LSenFgcMWE/wrQeaesOAKayxCfp0izNXZf
	 hlNgDNbLJj8pTwdRmMY2lp01W0LXvElaj9Ppb4HsQgkI+ql0LwsmXKpzDt4ALy99oB
	 royjcDwmuFjjYfcqtYJ5sULcmdicMRHbYlZgTaO5o4IJU0cVFiMEI+BF3NASV9A+vx
	 vmvSjG9exCw2vCkJEbAdbxuafSu/Vr0FPqEXhLjTMJiNwXFdxQZjEktc22HJYix4z9
	 kKH0jiiEMWAi/67LoK9SNMxvaiJAZW1CPGzoHPEVNwXa+/3gZq6CgBvMDGewqbJ1lP
	 DMWILvugELCdA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH 0/3] misc nvme related fixes
Date: Tue, 28 Jan 2025 17:34:45 +0100
Message-Id: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACUHmWcC/x3LQQqAIBBA0avErBtQIZOuEi3CmWoWWjgQQXj3p
 OXj819QLsIKU/dC4VtUztxg+w7iseadUagZnHGDsS5gvhNjEo24ycOKZuRAK3nrI0G7rsJ/aNO
 81PoBU5XAV2EAAAA=
X-Change-ID: 20250128-nvme-misc-fixes-07e8dad616cd
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_083508_478397_46AF7EAF 
X-CRM114-Status: GOOD (  15.71  )
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

While working on a patchset for TP4129 (kato corrections and
clarifications) I run into a bunch small issues:

- nvme-tcp was spamming the kernel messages, thus I think it makes sense
to rate limit those messages. I observed this with my changes, so it
might not happen that often in mainline right now but still I think it
makes sense to rate limit them.

- nvme-fc should use the nvme state accossor to ensure it always sees
the current state.

- blk_mq_tagset_wait_completed_request was hanging on ctrl deletion path
and after a bit of head scratching I figured
blk_mq_tagset_wait_completed_request does not do what it claims. After
this fix, the shutdown path works fine and I think this could go in
without my other pending stuff I am working on. As the only user of this
function is the nvme subsytem, I included in this mini series.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Daniel Wagner (3):
      nvme-tcp: rate limit error message in send path
      nvme-fc: use ctrl state getter
      blk-mq: fix wait condition for tagset wait completed check

 block/blk-mq-tag.c      | 6 +++---
 drivers/nvme/host/fc.c  | 9 ++++++---
 drivers/nvme/host/tcp.c | 4 ++--
 3 files changed, 11 insertions(+), 8 deletions(-)
---
base-commit: fd6102e646a888931ad6ab21843c6ee4355e7525
change-id: 20250128-nvme-misc-fixes-07e8dad616cd

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


