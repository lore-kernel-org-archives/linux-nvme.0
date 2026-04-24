Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E50EFE51FE
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 11:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FcKOOGZGlCkHZs0ABCI96/rznmqE3Xrs3vExeHWaV9k=; b=NM4RRRrDy9P2p3
	Akrp8F/7p6507m6HcKUQHwWv9H4dkGgc9WG9mP1RdvfeaBbsVi/uZQNUSWu23BLbWCPIJB2Guhs/y
	XPtLFiJ9ajQARhUQd97ywnVrjhRoQUkLe6Xayc4a0ryll5xhnglFgLNL6qzh8+0ju3vkJXAzaX+Sf
	FomZ6+KcxbG/AZWhyvuV7hjNJHj6itswzUxmrdBVhEoLHA4Rg0qJ4RUj8+Y2FKbE8qviOI2WFmmnV
	FGCO30w8fytdYErZ4n0u9T5+Jif7KlTQjjwZVdD7o0bDUaffvqP7Mtfh0Zes7kVHgC6w5nGtPtDOH
	GLEQdRMBJyfxIurlBlXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGEs1-0000000D8Ug-2uws;
	Fri, 24 Apr 2026 11:38:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGEs0-0000000D8UP-1tr7
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 11:38:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D8187600AE;
	Fri, 24 Apr 2026 11:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89512C19425;
	Fri, 24 Apr 2026 11:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777030701;
	bh=5BZxNLbiDIZ0F/6EQCU38sByageab1eGWbVMCZM9NBo=;
	h=From:Subject:Date:To:Cc:From;
	b=As3JEGpH0bYUSzwevabEljZDvEWUB73XEtok+kU6i6ssP6QyifvJFz7KWaW/9Illl
	 Q5zKebzD4g6EdVFbVVJ4bqzfhp8X4KqQlKDt1E02irRQ+ay7D3h8+q/M8uDr3Bg9yT
	 k7g7ajf8s7dPdbyVfIW6Ww2Cc2ZXo6XYMCbi4NvBTTOWR64Tzi03Pz2NFrJTqmxndp
	 oNzKXwLbkpTF65Us3ouhuLaiOPwSJOCTt1IInO9TAzvdEM3Lweyrnbn2Kv7EyQCc34
	 Q3dK6F1+MFYPRP8V2VacXFPSAY87pChfyKsF3DRk9XoklRpWYFOKIXd0cGOL8evw5d
	 5JsX0/s2R/JPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3A8FE51FE;
	Fri, 24 Apr 2026 11:38:21 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH RFC 0/5] nvme: Controller Data Queue (CDQ) support
Date: Fri, 24 Apr 2026 13:37:50 +0200
Message-Id: <20260424-jag-cdq-lkml-v1-0-d773343a717c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA5W62kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyMT3azEdN3klELdnOzcHCDDMsk82dzS0sI4RQmopaAoNS2zAmxctFK
 Qm7NSbG0tAPqlo51jAAAA
X-Change-ID: 20260424-jag-cdq-lkml-cd9b7c79983d
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2969;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=5BZxNLbiDIZ0F/6EQCU38sByageab1eGWbVMCZM9NBo=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGnrVij8iqILmh2mISbfp+H+chXX/y9dxWhft
 vhOvJ/zok/t1YkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJp61YoAAoJELqXzVK3
 lkFPfUAL/RHLj4INt7ay2zjkNviCcQAUDSVHKvKv9+DHD4lxKDjhAaOz0KPnKmbLGBBU613vkHW
 P3V5ZEQF77EeXy4tgJwuZmshh7eX9OG1/EeLBo43QAkrBQ5PhV3q9RNbFO1Uds3O+DYhu+RTj7s
 g+UuQVlpxU0JKpf9iRPSGZq3oWR8LRk0EsXrqY0lTZ7+wizod4DHHwiBWfmqTt5LwOKq8VN5pKo
 H7rJhRtSlIQ22/8j62wC1ggLmsjHImP+9qYtoJPNtQRKoSGGxxzwnlzvJZ2kHB/Zov+Xy59CR/A
 t+idOBvGWR/7qYheGvVBjN2JwxYralYkoboppYOtsxQq8ki3jAMByaFrUJnPK69ZCBHOYutt8qh
 VOljR0xW3jJJW06jeBG8L9eFOQrhc8gm41xc3fmni6NU3LVcFY2zApTr1LZ05sryFevMIzAiq8A
 8Evq5JDbh5GgHE11EpHcaT/jeqlwT3OMzcvzx85expGulXuWEsIOTH9UyCAYq4dMlqQNo12ijM7
 Fk=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
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

This RFC implements Controller Data Queue (CDQ) support in the NVMe
driver, a variation of my original RFC sent last July [2]. It exposes an
ioctl interface for userspace to create, configure, and delete CDQs
backed by DMA-mapped user memory with eventfd notification. In this
version I explore how the CDQ protocol logic might live outside the
kernel; the ioctl serves as a testing tool but is not necessarily the
final interface.

This RFC exists within a broader goal, which is to enable NVMe namespace
migration. The timing feels right as hardware with CDQ capability
exists, NVMe fully specifies the feature and there is growing interest
in Live Migration which by extension includes CDQ.

There is however, no clear consensus on how NVMe Live Migration should
land in the Linux kernel. The 2022 discussion [1] explored a VFIO-based
approach but reached no conclusion, likely because the specification was
not yet mature.

To move CDQ forward, I would like to understand where the LM logic belongs. I
currently see two options (of which I have no particular preference):

1. VFIO: Implement NVMe LM following the VFIO state machine, similar to what
   was proposed in 2022.
2. VM manager interface: Bypass VFIO and implement LM logic in the interface
   between the VM manager (e.g., QEMU) and the NVMe driver.

One aspect that has not received much attention in previous discussions
is namespace migration as prior work focused on migrating state and not
the actual data. Migrating potential terabytes is IMO a distinct use
case worth considering. LSF/MM/BPF is in a week. I hope this series
encourages folks to revisit their positions, give their opinions and set
the stage for face2face discussions.

Best

PS: I'm including the regular NVMe contacts and the folks that seemed to
have strong opinions in [2]. I always find it difficult to decide who to
include in these so let me know if you want to be removed in the future
or if I have missed someone.

[1] https://lore.kernel.org/20221206055816.292304-1-lei.rao@intel.com
[2] https://lore.kernel.org/20250714-jag-cdq-v1-0-01e027d256d5@kernel.org

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Joel Granados (5):
      nvme: Add CDQ data structures to nvme spec header
      nvme: Add CDQ data structures to host driver
      nvme: Add NVME_AER_ONE_SHOT callback handler
      nvme: Implement CDQ core functionality
      nvme: Add CDQ ioctl interface

 drivers/nvme/host/core.c        | 312 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/ioctl.c       |  53 ++++++-
 drivers/nvme/host/nvme.h        |  20 +++
 include/linux/nvme.h            |  50 ++++++-
 include/uapi/linux/nvme_ioctl.h |  29 ++++
 5 files changed, 462 insertions(+), 2 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260424-jag-cdq-lkml-cd9b7c79983d

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



