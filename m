Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23B9C27C4F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 20:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tlJw5rf8c+UeyDHI423DRfM/KCdfFJVNEn11zW0ysao=; b=v1m8v6SaUu3hRoRfwv6AakfDKa
	WSlHlD15Dm+Q+7Q8epIJjaau522gDlEpYyW4NiiencjdknwoNXNoglTqyYjAAF6qMZxNz9+3GKe9+
	y+8ldI5KK0jXpsAbsSySWsOoZ2txe2yICw6onEVoI/i43inmsiS4um2XjRnK369KOyLF17I/YxVpn
	czAqxTWcMcm0pSSWvC0hwvGgE0pW5iq9yyfAuthA+PhCDfI8AU3qkjQvi3nh0CfOb3MFTZXEf1aut
	wtRjDTg8WKWDwMaiitsl8bsmQfc+bdNQx2OnHysSROKN7/PX85O0z/SdD7jt6Un687EA/oJh8lMJW
	5Jol6NaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJfm9-0000000GYp6-12P2;
	Tue, 18 Jun 2024 20:49:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJfm5-0000000GYnR-0w8b
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 20:49:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7427161B4D;
	Tue, 18 Jun 2024 20:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B61C3277B;
	Tue, 18 Jun 2024 20:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718743792;
	bh=CkxYcZq8lMhZtQeh+gh2bGRvtFYZZWl5V5Oif5kfgr0=;
	h=From:To:Cc:Subject:Date:From;
	b=NtTtFPkWR9PN9rl/hh7cLp2Bgo45qAe0Nd1YSQPZdlmWSzsqsruf3WYzecSPgbeqI
	 zO32c+un6WskSZ75Lo9tW8AaOVmXwSyBux6basDs2x51R+Q4mYbUmptS7JUkmeyx51
	 V/71Fc8GI5+izP9hWVpUWwSzyhcVtGJruI0Z/klP/E4tKetTkIZv5YzbKUXv5y75X3
	 M01MhSGJzQVrN1hxlCo0rh+RcgdyF6Q4n+1VLscMPXjlP03CJ/hA7CS47b/319r4QF
	 frOM8AR10Zd467TmvaoLrn1BgM83WMvLeb1Z2L63H0W9CVcH+VmeFEjzzYETHlNGUV
	 9oqrc8q+QMIvg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Thomas Crider <gloriouseggroll@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-nvme@lists.infradead.org,
	regressions@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v9 0/2] PCI: Disable AER & DPC on suspend
Date: Tue, 18 Jun 2024 15:49:44 -0500
Message-Id: <20240618204946.1271042-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_134953_427994_704F551A 
X-CRM114-Status: GOOD (  10.69  )
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

From: Bjorn Helgaas <bhelgaas@google.com>

This is an old series from Kai-Heng that I didn't handle soon enough.  The
intent is to fix several suspend/resume issues:

  - Spurious wakeup from s2idle
    (https://bugzilla.kernel.org/show_bug.cgi?id=216295)

  - Steam Deck doesn't resume after suspend
    (https://bugzilla.kernel.org/show_bug.cgi?id=218090)

  - Unexpected ACS error and DPC event when resuming after suspend
    (https://bugzilla.kernel.org/show_bug.cgi?id=209149)

It seems that a glitch when the link is powered down during suspend causes
errors to be logged by AER.  When AER is enabled, this causes an AER
interrupt, and if that IRQ is shared with PME, it may cause a spurious
wakeup.

Also, errors logged during link power-down and power-up seem to cause
unwanted error reporting during resume.

This series disables AER interrupts, DPC triggering, and DPC interrupts
during suspend.  On resume, it clears AER and DPC error status before
re-enabling their interrupts.

I added a couple cosmetic changes for the v9, but this is essentially all
Kai-Heng's work.  I'm just posting it as a v9 because I failed to act on
this earlier.

Bjorn

v9:
 - Drop pci_ancestor_pr3_present() and pm_suspend_via_firmware; do it
   unconditionally
 - Clear DPC status before re-enabling DPC interrupt

v8: https://lore.kernel.org/r/20240416043225.1462548-1-kai.heng.feng@canonical.com
 - Wording.
 - Add more bug reports.

v7:
 - Wording.
 - Disable AER completely (again) if power will be turned off
 - Disable DPC completely (again) if power will be turned off

v6: https://lore.kernel.org/r/20230512000014.118942-1-kai.heng.feng@canonical.com

v5: https://lore.kernel.org/r/20230511133610.99759-1-kai.heng.feng@canonical.com
 - Wording.

v4: https://lore.kernel.org/r/20230424055249.460381-1-kai.heng.feng@canonical.com
v3: https://lore.kernel.org/r/20230420125941.333675-1-kai.heng.feng@canonical.com
 - Correct subject.

v2: https://lore.kernel.org/r/20230420015830.309845-1-kai.heng.feng@canonical.com
 - Only disable AER IRQ.
 - No more AER check on PME IRQ#.
 - Use AER helper.
 - Only disable DPC IRQ.
 - No more DPC check on PME IRQ#.

v1: https://lore.kernel.org/r/20220727013255.269815-1-kai.heng.feng@canonical.com

Kai-Heng Feng (2):
  PCI/AER: Disable AER service on suspend
  PCI/DPC: Disable DPC service on suspend

 drivers/pci/pcie/aer.c | 18 +++++++++++++
 drivers/pci/pcie/dpc.c | 60 +++++++++++++++++++++++++++++++++---------
 2 files changed, 66 insertions(+), 12 deletions(-)

-- 
2.34.1


