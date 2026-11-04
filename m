Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946ED606A32C
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uxEaYX6f;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cQEg42Sw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sov9Lilx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cQEg42Sw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sov9Lilx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=pWFRm1JRWbte//jl3rMTHImEQFRyO76ZJABBnEtD4Qg=; b=uxEaYX6fJBzP0tB/b3Nn4ypD6K
	TG24dTetnrabckzE0bdZ8nW7iwYIA9+kjgRw8sr336V6Schk5mJtzjCoIALtyheu/x8co/HhFo2Vv
	vKdl/94YMMKXqDrXBfSZIUwpEAG/nr1uUrkUC7eGc3r9bN8e7jH/2/WfgL1GT/F7sApzWcDI2MxcU
	4UVfaJ6023pEi2+dOwbYdNw5vFag13UikavkhqmSvuCHPawhL9RypRnzosyYKdMDlUx3R2aRy68yx
	uOwKFI6u0DB6alldloU2hOoqDVJrpvBkuTdhfhLmHNnd6b0baB0N81Go4lKThVhgbqPpv2Q/6Z5q7
	FZkKKJ/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe6b-000000062FE-2i9E;
	Wed, 04 Nov 2026 16:44:57 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe6X-000000062DU-0zBc
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 16:44:56 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 107751F7DD;
	Wed,  4 Nov 2026 16:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pWFRm1JRWbte//jl3rMTHImEQFRyO76ZJABBnEtD4Qg=;
	b=cQEg42Sw8NolXWfqTx9b1Qcd0+oLte/UIXT6heBmDW9Wp74toOZFAos3Wq4BwnyVkT1Xsp
	v6+BhObqD4VoSIhSQWjYnZuFWhd7kUw8Oiq/XD+o7AvMnel54IddVXZNg9QvxnVupasuVt
	A5UqnUjcbbTKd6RCCVS0JHCsMJI8Et4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pWFRm1JRWbte//jl3rMTHImEQFRyO76ZJABBnEtD4Qg=;
	b=sov9LilxdqsJEXZoSeNnxrrwdUEqchdIT/mF9b2iXKdWFX/BTTXCY8gYR2gpN4MVbkxbXH
	Z0FDH8hMyMOP7ZBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cQEg42Sw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sov9Lilx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pWFRm1JRWbte//jl3rMTHImEQFRyO76ZJABBnEtD4Qg=;
	b=cQEg42Sw8NolXWfqTx9b1Qcd0+oLte/UIXT6heBmDW9Wp74toOZFAos3Wq4BwnyVkT1Xsp
	v6+BhObqD4VoSIhSQWjYnZuFWhd7kUw8Oiq/XD+o7AvMnel54IddVXZNg9QvxnVupasuVt
	A5UqnUjcbbTKd6RCCVS0JHCsMJI8Et4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pWFRm1JRWbte//jl3rMTHImEQFRyO76ZJABBnEtD4Qg=;
	b=sov9LilxdqsJEXZoSeNnxrrwdUEqchdIT/mF9b2iXKdWFX/BTTXCY8gYR2gpN4MVbkxbXH
	Z0FDH8hMyMOP7ZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAC061350A;
	Wed,  4 Nov 2026 16:44:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p5m7HQJh62o8fQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 16:44:50 +0000
From: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests 00/10] nvme: make NVME_TARGET_CONTROL work with
 remote targets
Date: Wed, 04 Nov 2026 17:44:39 +0100
Message-Id: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAwAf2Xk2UBbZTh/RXxYazajs5UkG8LYv
 1v18TjuVlASJoVTs4LQwsolV/C7BtKtzyMhXytDcKH13h0wL09C62Ukw1SySZlwcDHsO2qPMXR
 Qy5fQwO/f9QxxehipKVz+Rud4p2TfKWzbB1gKez6BAAAA
X-Change-ID: 20261104-nvme-target-control-f0b239e68b29
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 107751F7DD
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_084453_439534_81D75D5F 
X-CRM114-Status: GOOD (  19.10  )
X-Spam-Score: -4.4 (----)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Running the nvme fabrics tests against a remote target with
NVME_TARGET_CONTROL doesn't work in current upstream:

- contrib/nvme_target_control.py configures the target with nvmetcli
  through a REST API which only exists in an nvmetcli branch that was
  never merged, and its nvmetcli client crashes with configshell-fb 2.0.
  The target is never set up and the tests fail to connect.

- With a target set up by other means, the tests pass without testing
  anything: _nvme_ns_ready waits for the namespaces in the local nvmet
  configfs, which doesn't exist for a remote target. _nvme_connect_subsys
  returns an error after every connect, the tests skip their I/O and the
  disconnect, and the harness reports leftover controllers.

- The tests which use more than one port configure the ports in the
  local nvmet configfs, and add-ports is a stub. The authentication
  tests change the host keys there too.

Patch 1 makes common/nvme pass the controller key as --ctrlkey, the
option the script interface documents, instead of --ctrkey.

Patch 2 makes _nvme_ns_ready wait for the namespace the controller
reports when NVME_TARGET_CONTROL is set.

Patch 3 fixes the subsystem check of _nvmet_target_add_ports for the
local target.

Patch 4 skips nvme/038, nvme/051, nvme/058, nvme/060 and nvme/065 with a
remote target. They need the local nvmet target.

Patch 5 skips nvme/029 if its largest I/O exceeds the maximum transfer
size, e.g. with 4 KiB blocks and a 1 MiB MDTS.

Patch 6 replaces the script with contrib/nvme-target-control, a
standalone project in the style of nvme-cli's scripts/fuzz. It keeps the
command line blktests calls. The configuration only says how to reach
the target:

  [target]
  remote = "root@10.0.0.1"

The values blktests reads with config --show-* are worked out on the
host, each can be overridden. The target is a plugin: the built-in nvmet
target writes to configfs over ssh and backs the namespace with a loop
device it creates and removes. Other targets, e.g. a storage array with a
management API, and other channels than ssh can be added without
changing the project. The nvmet target also creates, removes and lists
ports, sets their ANA state and changes the DH-CHAP attributes of the
host.

Patch 7 makes the port helpers of common/nvme use the port commands with
a remote target.

Patch 8 makes the host key helpers of tests/nvme/rc use the set-host
command with a remote target.

Patch 9 lets the tests skip if the remote target lacks a feature they
need. config --show-features lists the optional commands the target
implements, e.g. a storage array with fixed ports and ANA states managed
by the array lists neither add-port nor set-ana.

Patch 10 adds such a target: a NetApp ONTAP storage virtual machine,
configured through the ONTAP REST API. It shows how the parts work
together with a target which can do less than nvmet: it implements
list-ports, show-port and set-host, and the tests which need more skip.

Tested with two QEMU VMs, the host running the nvme group against
nvmet (Debian 6.12 kernel) in the target VM over tcp:

- passed: 003-006, 008, 010, 012, 014, 018, 019, 021-023, 025-029, 031,
  040-045, 047, 057 (ANA failover over four ports), 061, 068, 069, 075,
  and 076, 079 and 080 of the isolcpus series
- failed: 070, the regression test for Identify CNS 07h; the 6.12
  target fails the command
- not run: tests for loop or fc only, tests which need the kernel
  target, local nvmet features (attr_qid_max, reservations), tlshd or
  ULP_DDP

nvme/029, nvme/038, nvme/051, nvme/058, nvme/060 and nvme/065 still pass
with the local target.

With the ontap target of patch 10, NVMe/TCP over the four LIFs of an
SVM and the host on SLES 15 SP7, 003-006, 008, 010, 012, 014, 018, 019,
021-023, 025-028, 040, 041, 044, 045 and 047 pass, and nvme/029, nvme/031,
nvme/057, nvme/062 and nvme/063 skip on the missing features. nvme/042
and nvme/043 fail only on SHA-384, which ONTAP doesn't support.

Unit tests, ruff, mypy and shellcheck are clean.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Daniel Wagner (10):
      common/nvme: pass --ctrlkey to the target control script
      common/nvme: wait for the namespace of a remote target
      common/nvme: check the subsystem in _nvmet_target_add_ports
      nvme: skip the tests which need the kernel target with a remote target
      nvme/029: skip if the I/O exceeds the maximum transfer size
      contrib: make nvme-target-control a standalone project
      common/nvme: support the ports of a remote target
      nvme/rc: change the host keys on a remote target
      nvme: skip the tests which need a feature the remote target lacks
      contrib/nvme-target-control: add a NetApp ONTAP target

 Documentation/running-tests.md                     |  48 +++
 common/nvme                                        |  83 ++++-
 contrib/nvme-target-control/.gitignore             |   1 +
 contrib/nvme-target-control/README.md              | 177 ++++++++++
 contrib/nvme-target-control/nvme-target-control    |  19 +
 .../nvme_target_control/__init__.py                |   3 +
 .../nvme_target_control/channel.py                 | 113 ++++++
 .../nvme-target-control/nvme_target_control/cli.py | 205 +++++++++++
 .../nvme_target_control/plugin.py                  |  35 ++
 .../nvme_target_control/target.py                  | 222 ++++++++++++
 .../nvme_target_control/targets/__init__.py        |   3 +
 .../nvme_target_control/targets/nvmet.py           | 107 ++++++
 .../nvme_target_control/targets/nvmet.sh           | 246 +++++++++++++
 .../nvme_target_control/targets/ontap.py           | 392 +++++++++++++++++++++
 contrib/nvme-target-control/pyproject.toml         |  42 +++
 contrib/nvme-target-control/tests/test_ontap.py    | 340 ++++++++++++++++++
 .../tests/test_target_control.py                   | 380 ++++++++++++++++++++
 contrib/nvme_target_control.py                     | 204 -----------
 contrib/nvmet-subsys.jinja2                        |  71 ----
 tests/nvme/029                                     |  15 +-
 tests/nvme/031                                     |   1 +
 tests/nvme/038                                     |   1 +
 tests/nvme/042                                     |   1 +
 tests/nvme/043                                     |   1 +
 tests/nvme/044                                     |   1 +
 tests/nvme/045                                     |   1 +
 tests/nvme/051                                     |   1 +
 tests/nvme/057                                     |   1 +
 tests/nvme/058                                     |   1 +
 tests/nvme/060                                     |   1 +
 tests/nvme/062                                     |   1 +
 tests/nvme/063                                     |   1 +
 tests/nvme/065                                     |   1 +
 tests/nvme/rc                                      |  38 ++
 34 files changed, 2466 insertions(+), 291 deletions(-)
---
base-commit: a65cf6bdca19cf98e80ba379bffbf3a67f86fba3
change-id: 20261104-nvme-target-control-f0b239e68b29

Best regards,
--  
Daniel Wagner <dwagner@suse.de>


