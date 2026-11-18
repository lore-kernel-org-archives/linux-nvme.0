Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78D606A32A
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Zgs1WMW6;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=W6QQNXpU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Z5bRc8opH3HG5rKZ//0Jdc3vZAolZILBYEaXnuHruvE=; b=Zgs1WMW64k/YFb
	ruP+AO/HG52LXXMPrc2y7s79atvdIQEzYn1GhqdQwkBq2lL0AFhseh12elbBMC0N8R2p6EdLwMuF/
	GwX/YpgKZ11X1GMwQwbOhTvCJV7PY7GVfJtMSnouHWgFxmGjd5OZPAJRZwL/+Qik2O6mFVdj2sSf7
	6UbtNEJOKpq/7c8vpCytnmCKPslEiNhiLUSzySiUax5Odz+UJxvH8azRMvxOwetnG4Jyj0gmqLxFg
	brQ6Ae5yB9KfTqjOp9TzjtCL8gBypZehFDOUEnaPUMMhpO/nem3Cz9nZmbTVsLq2Kq03cBYZso70B
	dxPgoKxK8W2k3uje2+tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbwR-00000008Lkj-18d6;
	Wed, 18 Nov 2026 09:26:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbwQ-00000008Lhw-0psB
	for linux-nvme@bombadil.infradead.org;
	Wed, 18 Nov 2026 09:26:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=Z5bRc8opH3HG5rKZ//0Jdc3vZAolZILBYEaXnuHruvE=; b=W6QQNXpUa0osSro+d2U+LfHoFm
	TAukDR6JsPGkRufTLUSPDb510KH8CDiNzqv7Q04Lh4RxdYqXePou2JFLIVbsr8gvP47bKmAnIKSBy
	3+36cIIIaRH7KOgGTYV1c82m/pAjo4LLDbaK/TGJgcAexNd/IwE5ifGzWu2V3qZICeBA7F9B3WTWi
	4DOHf2yKYbo5HaSLDCBEtP7CFppSUEB5tpd9cVqc8pw684NjAsxcdoYaTzUMmHd7XLJyL+4ZsIqik
	7afmUEQZZ5c5SOT2/mrRA2pGH/cSysHKevqOPt/nG0G3xULFDOr21zOH7MuLBiaMm9EAqVZg3Vm77
	uITquAwQ==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbwL-0000000FrOg-3tiR
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 09:26:56 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2C2B22229;
	Wed, 18 Nov 2026 09:26:51 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA3821334C;
	Wed, 18 Nov 2026 09:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pe95IFtv/WpHfgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 09:26:51 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 10:26:43 +0100
Subject: [PATCH blktests v2 5/9] contrib/nvme-target-control: list the
 DH-HMAC-CHAP algorithms
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-nvme-target-control-v2-5-d191bbbf5dd6@suse.de>
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
In-Reply-To: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: F2C2B22229
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_092654_056539_52F5BFF0 
X-CRM114-Status: GOOD (  13.70  )
X-Spam-Score: -0.0 (/)
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Not all targets support all DH-HMAC-CHAP hashes and DH groups, e.g.
ONTAP doesn't support SHA-384. List the ones a target supports as
features, e.g. dhchap-sha384 or dhchap-ffdhe2048, so that the tests can
check for them. The nvmet target lists all of them.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 contrib/nvme-target-control/README.md                  | 11 +++++++----
 .../nvme-target-control/nvme_target_control/target.py  | 18 ++++++++++++++++++
 .../nvme_target_control/targets/nvmet.py               | 12 +++++++++++-
 .../nvme-target-control/tests/test_target_control.py   |  4 +++-
 4 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/contrib/nvme-target-control/README.md b/contrib/nvme-target-control/README.md
index 9abd7f30932d..8afbfc0be322 100644
--- a/contrib/nvme-target-control/README.md
+++ b/contrib/nvme-target-control/README.md
@@ -118,10 +118,13 @@ channel is a subclass of `Channel` which returns the command running
 The port commands and `set-host` are optional. A target implements them
 by overriding `add_ports`, `add_port`, `remove_port`, `list_ports`,
 `show_port`, `set_ana` and `set_host`. `config --show-features` lists the
-ones it overrides, followed by the class attribute `extra_features`, e.g.
-`tls`. blktests skips the tests which need a feature the target doesn't
-list. Without `list-ports` and `show-port`, blktests connects to `traddr`
-and `trsvid`.
+ones it overrides, followed by the class attribute `extra_features`: the
+DH-HMAC-CHAP hashes and DH groups the target supports, e.g.
+`dhchap-sha256` or `dhchap-ffdhe2048` (`dhchap_features()` builds them),
+and `tls` if it sets up TLS. blktests skips the tests which need a
+feature the target doesn't list, and the steps of nvme/042 and nvme/043
+which use an algorithm the target doesn't list. Without `list-ports` and
+`show-port`, blktests connects to `traddr` and `trsvid`.
 
 ## Development
 
diff --git a/contrib/nvme-target-control/nvme_target_control/target.py b/contrib/nvme-target-control/nvme_target_control/target.py
index d648826e0386..1b3576bffbbf 100644
--- a/contrib/nvme-target-control/nvme_target_control/target.py
+++ b/contrib/nvme-target-control/nvme_target_control/target.py
@@ -11,6 +11,7 @@ API, can be added as 'package.module:Class' in the [target] 'type' option.
 
 import socket
 from abc import ABC, abstractmethod
+from collections.abc import Iterable
 from dataclasses import dataclass
 from pathlib import Path
 from typing import Any, ClassVar
@@ -23,6 +24,23 @@ DEF_SUBSYSNQN = 'blktests-subsystem-1'
 DEF_SUBSYS_UUID = '91fdba0d-f87b-4c25-b80f-db7be1418b9e'
 DEF_TRSVCID = '4420'
 
+# The DH-HMAC-CHAP hashes and DH groups, named as in the nvmet configfs
+# without hmac() around the hash
+DHCHAP_HASHES = ('sha256', 'sha384', 'sha512')
+DHCHAP_DHGROUPS = (
+    'null',
+    'ffdhe2048',
+    'ffdhe3072',
+    'ffdhe4096',
+    'ffdhe6144',
+    'ffdhe8192',
+)
+
+
+def dhchap_features(algorithms: Iterable[str]) -> tuple[str, ...]:
+    """Return the features for the DH-HMAC-CHAP hashes and DH groups."""
+    return tuple(f'dhchap-{alg}' for alg in algorithms)
+
 
 @dataclass(frozen=True)
 class Subsystem:
diff --git a/contrib/nvme-target-control/nvme_target_control/targets/nvmet.py b/contrib/nvme-target-control/nvme_target_control/targets/nvmet.py
index f5f2e8cc2a62..468417f2ca7e 100644
--- a/contrib/nvme-target-control/nvme_target_control/targets/nvmet.py
+++ b/contrib/nvme-target-control/nvme_target_control/targets/nvmet.py
@@ -24,7 +24,15 @@ from pathlib import Path
 from typing import Any
 
 from .. import channel
-from ..target import Port, Subsystem, Target, resolve
+from ..target import (
+    DHCHAP_DHGROUPS,
+    DHCHAP_HASHES,
+    Port,
+    Subsystem,
+    Target,
+    dhchap_features,
+    resolve,
+)
 
 SCRIPT = Path(__file__).resolve().parent / 'nvmet.sh'
 
@@ -40,6 +48,8 @@ HOST_ATTRS = {
 class NvmetTarget(Target):
     """Linux nvmet target."""
 
+    extra_features = dhchap_features(DHCHAP_HASHES + DHCHAP_DHGROUPS)
+
     def __init__(self, config: dict[str, Any]) -> None:
         super().__init__(config)
         self.channel = channel.create(config)
diff --git a/contrib/nvme-target-control/tests/test_target_control.py b/contrib/nvme-target-control/tests/test_target_control.py
index 730d6c8a9b69..c6d8933b6212 100644
--- a/contrib/nvme-target-control/tests/test_target_control.py
+++ b/contrib/nvme-target-control/tests/test_target_control.py
@@ -160,7 +160,9 @@ type = "fake_array:RecordingTarget"
         self.assertEqual(
             self.show('features'),
             'add-ports add-port remove-port list-ports show-port set-ana '
-            'set-host',
+            'set-host dhchap-sha256 dhchap-sha384 dhchap-sha512 dhchap-null '
+            'dhchap-ffdhe2048 dhchap-ffdhe3072 dhchap-ffdhe4096 '
+            'dhchap-ffdhe6144 dhchap-ffdhe8192',
         )
         self.config.write_text(PLUGIN)
         self.assertEqual(self.show('features'), '')

-- 
2.56.1


