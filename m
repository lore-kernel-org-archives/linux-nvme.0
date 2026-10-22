Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE7260A2613
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=K8mMy3Rs;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NacZRXvJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=7cc5rs2PtzGFHpoWnnvRux4DVgA7nFFkTqB4lwRugTc=; b=K8mMy3RsuPaxscoDZaVEykbfX3
	rN+buz1LUS1UOdOfeR8NW3pr7+8lTXjem7DsEXTNtkCZOJ/oTionJLDHR4WcI1ShaCbhmAXITbNwS
	62h+H5q/p5avqQKM9LT6U2STNuSoq3hKdOrRGYIplgy3TvMDBPFV+hSDqRaHRDBleQgCeFVGymOSX
	OGp4RWLRBjUpRuUrqKxtcaLfAaAxp0+7rWTHsAlOprdDw3byg0Ym+coLi3FSXnLwWhWOWr1sROcF6
	J9ubq/V6k+T+98M0d5aRUiOiZM7lh8nc/pM555q5PdIoR3BBpHyOroPmAl9Pz17RbSwY5zdts5Gzm
	gYCXo61w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsrf-0000000ECSV-42xj;
	Thu, 22 Oct 2026 13:29:51 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsrb-0000000ECQe-0EDN
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 13:29:51 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4a1e266fca2so13230685e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 06:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792675785; x=1793280585; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7cc5rs2PtzGFHpoWnnvRux4DVgA7nFFkTqB4lwRugTc=;
        b=NacZRXvJCWX49KP9IKALU6TtehpkY5GJLFmjem09DtzHAH1N2Gk4Pl6d2VCZmf5Acj
         0fW8qrRhGgbUBBomMwsVVxdo86fW5c4ZBFrllbEntm8fujp7x3faR+PFuhToudgCxYsr
         b1JxY7E/MXbRIR0ZBC7/gCrPVcweU8nR4DwVJQuLrxgJ9EaPoliaSZ3BHoseQtlSVjOs
         salG+FJuylA3e6JSu6eJzWZdSEdxPOcA58lzFKfwi35SboYzgnslqY/WT0alISFJXgS6
         3HPz9JfKuCudlObeVBxZ68H1mw1qNowbxeERn/1fWYDQba4t7CfzS3Oo+tZgY16gDoTo
         sMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792675785; x=1793280585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7cc5rs2PtzGFHpoWnnvRux4DVgA7nFFkTqB4lwRugTc=;
        b=ufe6AQ1zmQOHTqwLbKkDmVRVEhV/Hv3/ECpEJgnypv/0DJhd5757Ahnt/Iqh+nl4RW
         ot0Est6QfdTSVakIvqoy/szopuT9jOEe2L59HypBCNIRyh6H5xAVk5N2VrFg5opDcuiK
         8AqjycU4T+TZT6DxRTRMVROMlbGcaKJIUEgkMx+rkqN81oFRtsWXKCYmKnW9PFrplyMp
         Ia5Vukbh+tsgFZ7d69UfQTBTVrt9ScC1RCkVURTg5oDbkTVMgS6eET6j2jZBzAVu3C6H
         Df28isecai0UCgrmI+mmsWt1fSbWy9ktkycu9/k9zbr6koE2bWoqLe7S6KMPrhr6294x
         +e8w==
X-Forwarded-Encrypted: i=1; AKwUvByotMDKrbMBkF0h/7iGKsQ1LRoopVrNO3AkAddduuzQaTbEvoZGAJ/VeH2+KefdU2ZUX34qj0KglWLu@lists.infradead.org
X-Gm-Message-State: AFq9FYJUuPw8KS8BvoWD52YutOsLB4QjNyS1mL1lbHswUfdjQqpWU8r0
	zFM18yMrrd3scslAjN4ecBO5V2CAbc1stO0IRyzrtWhup24mmD+xU846
X-Gm-Gg: AYBFou3T6c4fRnGuoCwEwQiBn5rmWihKN4YWTybga7cxbY1XZONVMwFu9GBgEqLRJ80
	fgWYnV1FPAHPaPlwQX8IKN+6WWZPoK64y7bUFPPdz6R5FMAB7y2wjhhT9j+37Q5UnYfuxxQYINz
	VRM0QfPj3tMeNxhmT/IDr7KKnYqK7P7D56Pna13eBp3vMY1i8lIAhaeqEOAUup0YcBJ0o63RTph
	WmSX4V6CMjrhZnkOJ5o9PTBhrYo+RW78bIhmRJ5LFUD+ErVW7hBD7aF+P44Z8YuoOuEMOXP8a0T
	vrvxC3ij2EdM6tZ9DRadrjkSUcLMbFcStVIl+9gANrdhOP89WxHLVSibmqJ63j4S0YRBwl00yH8
	ZdO49mVSsqsl9PgNdZ2XDHZouGWXoZdgsmifr3o9d8CO8lTBwA4nsnVQi31iBIWWUPXN4zOQ6Li
	yaVsP5UmlDgNqjm16v6A1MxBZYLwAOC9OvXPlw4MK8IEpgk1RRYhRs6pF1REvwtn42zbXx+VB2Q
	GRP+xckVfavvWZBRd+vjWiyIJaP2opoBUuGZ580qdBZaRaDTk/WT3z4KN/7ot+71IpMDeIh8hWw
	m0m8rWWAZLalkQPYYg9teGqe
X-Received: by 2002:a05:600c:5308:b0:4a2:47:b79c with SMTP id 5b1f17b1804b1-4a20047b7bemr81252445e9.32.1792675784917;
        Thu, 22 Oct 2026 06:29:44 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd629bbsm108832715e9.5.2026.10.22.06.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:29:43 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Justin Tee <justintee8345@gmail.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	James Smart <jsmart833426@gmail.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] nvmet: fix read data, status and length checks in fc, zns and pci-epf
Date: Thu, 22 Oct 2026 15:29:29 +0200
Message-ID: <20261022132934.3592924-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_062947_128706_11503C21 
X-CRM114-Status: GOOD (  17.85  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A connected host can currently receive stale target memory through two
nvmet transports, and ZNS answers a Zone Management Receive whose NUMD
byte count wraps.

The FC transport sends a read buffer even when the command completes with
an error.  Some errors occur before the command handler initializes that
buffer, so the host receives data left in the allocation.

The PCI endpoint transport allocates each read segment at the length of
the host's SGL data descriptor and sends every segment in full, even when
the descriptors describe more than the command transfers.  The excess
reaches the host uninitialized, on any successful read.

Patch 1 makes the FC transport send read data only for successful
commands, matching the TCP and RDMA transports.  Patch 2 rejects NUMD
values whose byte count wraps the u32 length calculation instead of
accepting the wrapped request.

Patch 3 fixes a related PCI endpoint bug that patch 4 depends on.  The
transport reports every error it detects itself as a successful
completion, because nvmet_pci_epf_complete_iod() reloads the status from
a CQE that only the nvmet core fills in, so even a write whose data
could not be fetched is reported as written.  Patch 4 then makes the
transport reject SGLs whose data descriptors do not add up to the
command's data length.

Patches 1 and 2 were tested on top of nvme-7.4 over the loop, tcp, rdma
(rdma_rxe) and fc (fcloop) transports, with a zoned null_blk namespace
for patch 2.  Without them, a failed Identify over fc returns data and a
wrapping NUMD is accepted; with them, neither occurs on any of the four
transports.

blktests nvme/072 and nvme/074 cover patches 1 and 2:
https://lore.kernel.org/r/20261022130927.3583166-1-parri.andrea@gmail.com

Their results in virtme-ng VMs, on v7.3-rc4-108-g551c722f4080 without
the fixes and on nvme-7.4 with this series applied:

                   loop  tcp   rdma  fc
  unpatched  072   pass  pass  pass  FAIL  failed Identify transferred
                                           4096 bytes
             074   FAIL  FAIL  FAIL  FAIL  NUMD 0x4000000f not rejected
  patched    both  pass  pass  pass  pass

Niklas Cassel tested patches 3 and 4 on PCI endpoint hardware with fio
over SGLs, with no change in performance; that exercises the normal
paths, not the new error paths.  The pci-epf side of patch 2 is
build-tested only.

An LLM found the bugs fixed here and wrote the fixes.  Following commit
1e035297ffda ("docs: remove Assisted-by references"), this is noted here
rather than in Assisted-by trailers.

Changes since v1:
- Dropped commit 31b8a6af19b7 ("nvmet: zns: don't leak stale memory in
  zone management receive"), applied to nvme-7.4.
- Patch 2: check NUMD at the start of
  nvmet_bdev_execute_zone_mgmt_recv() and in nvmet_io_cmd_transfer_len(),
  before any (numd + 1) << 2 is computed, and drop the over-long comment
  line (Christoph).
- Patches 3 and 4: add Niklas's Tested-by.
- Patches 1, 3 and 4: no code changes.
- All patches: drop the Assisted-by trailers; LLM use is noted above.
- Rebased on nvme-7.4.

v1: https://lore.kernel.org/r/20261012141239.156408-1-parri.andrea@gmail.com

Andrea Parri (4):
  nvmet-fc: only send read data for successful commands
  nvmet: zns: reject a NUMD whose byte count wraps
  nvmet: pci-epf: report transport errors in command completions
  nvmet: pci-epf: require SGLs to match the command data length

 drivers/nvme/target/core.c    |  3 +++
 drivers/nvme/target/fc.c      |  8 ++++----
 drivers/nvme/target/pci-epf.c | 30 +++++++++++++++++++++++++++---
 drivers/nvme/target/zns.c     | 12 ++++++++++--
 4 files changed, 44 insertions(+), 9 deletions(-)


base-commit: 2e8e30b3cf9f165e1a1d079331543cb7f2ad0e0c
-- 
2.53.0


