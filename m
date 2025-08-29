Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA90CA0FF9
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Aug 2025 00:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fQ+WptBmbpOgbB6cWP3t1+giMauIlYaOJn057WrrkKk=; b=BrEICzv6twj9mc
	5ckoCxBDY/xvPgm8qmFvWXguhrut7fkXBXJVOxFTPCzKNItW6QVdyDCg+v8OroE5d3m03343CiFDP
	dCpWUb18bkPJ1MTjm1OGCQsAWgKfkUuycM13uo1rzbuPH68IkuTS9e6NCrFb20lAZhxGh+oCr3hih
	z7jsQg36vqD8YPtkMMnozmx5Op1gX9qDgBsWhA0yAJVWYirGaYVxpDT1pPVesktXX5poBCA3BaKO0
	6QNPFyT39suSaZ3afEtLpdkpweP1lqFdxClUCLB11s2/B+3cK4CuanYBtUXAm1Z2Vuf64tykTEAxh
	iwGSPNAGAWAfWAA+D5vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us9jS-0000000789t-2zgh;
	Sat, 30 Aug 2025 00:46:14 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us1Fu-00000006FAz-3yzK
	for linux-nvme@lists.infradead.org;
	Fri, 29 Aug 2025 15:43:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5E37A44D46;
	Fri, 29 Aug 2025 15:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3765C4CEF0;
	Fri, 29 Aug 2025 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482190;
	bh=OL18MnykJgKNptxGVWsFWM5heT58JL3lUDx8FWl25rc=;
	h=From:Subject:Date:To:Cc:From;
	b=sr8wIUjJf5pnJ2M2UJIj5RBjHAPHeklz7zEL6AsA73nkxTTVQwJ0yYIj9PWNeRRy0
	 bEAzoPrUtlkJNZxpSYY+Oy7XaUK4hpmRZNgW1MZDM4EJLgUG8J8mYuvegsHfOwWRwN
	 +QwiHBU0gi6YIs4lLMcLznjyUZ0eoPQcpNKheUVzHIjy050cagWyxX90rQmHcHWi/I
	 9qe0mqPQKgXN5V7M3mcKt7AFOBWnKF1leOv1eOfafzS3IQONSkanK+O2DbwsPg5rg4
	 wowcN+GvtsxXBOl1omY/eK7sMtBZtAJLpEo4CS+iRcDXp8/Ix6Bamk1hZCezz3fmnV
	 0xJmiHg55LYzg==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v2 0/2] nvmet-fc: fixes for blktests tests
Date: Fri, 29 Aug 2025 17:42:59 +0200
Message-Id: <20250829-fix-nvmet-fc-v2-0-26620e2742c7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIPKsWgC/3WMQQ6CMBBFr0Jm7RimVNO68h6GRQNTaNRipqTRk
 N7dyt7l+z/vbZBYAie4NBsI55DCEiuoQwPD7OLEGMbKoFp1ao0i9OGNMT95RT8gOW+NtaSV8VC
 Vl3D999ytrzyHtC7y2euZfuufUCYk7DptR6e9pjNf7yyRH8dFJuhLKV9VnIFXqQAAAA==
X-Change-ID: 20250821-fix-nvmet-fc-1af98991428f
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_084311_014669_FA15B54F 
X-CRM114-Status: UNSURE (   8.06  )
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

A couple of fixes for bug reports from blktests.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v2:
- rebased
- added "nvmet-fc: avoid scheduling association deletion twice"
- Link to v1: https://patch.msgid.link/20250821-fix-nvmet-fc-v1-1-3349da4f416e@kernel.org

---
Daniel Wagner (2):
      nvmet-fc: move lsop put work to nvmet_fc_ls_req_op
      nvmet-fc: avoid scheduling association deletion twice

 drivers/nvme/target/fc.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250821-fix-nvmet-fc-1af98991428f

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


