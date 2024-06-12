Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C80BC27C7B
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 11:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xmpOIK+pg0ncAZr27wblc5prJ7wNCFLAgD6NifKyPnk=; b=0cZYx8cxrsYWt5IUPn8jmmXF3V
	0d2pWvqaAgs3PAGz6a+kGslubeci+rO7a7cr/11uZVlVTOf5A+979jt1pdeseS8k9Q5VukLvrDtDu
	m57Lwsp14SuO+a+NSkDwhhOKgUYZ2GVwkhK20uatUZBGCHBv8b29kuyWkFv2Y0weudmRwVUVQ80VX
	z/vqfFQcmrFgXt/QsGMxv5aFF7scBa35tt8z1s/Cg4AZqk9DAwraEC1sq7g7djmb6gUO31cBWnYNH
	S3yl4ZYBoon1bwaJXh+fcpZR9rbqhWEFujkZqe6R8uFE3KWADuHFnGGqDeQZ1FOUOw3Gx/jVEIYh6
	6VdZhcKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHLml-0000000CNcB-3tsY;
	Wed, 12 Jun 2024 11:04:59 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHLmd-0000000CNZE-3omW
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 11:04:57 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 11F705C0F5;
	Wed, 12 Jun 2024 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718190290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmpOIK+pg0ncAZr27wblc5prJ7wNCFLAgD6NifKyPnk=;
	b=x38winlzIFDyQuqq2IemBdTafMIRToSNxbliLMxGDLPdRdflM90KbXIdSFkDqbcI1JYSYH
	j5JJDdn892J2eNKuAS7s+ek8UnM9k/jTEBSTAy4b7w9QHf6vGyPFiaZ1lVR/QhKlzVg5F6
	AHD9+8kE34HXD97cMBw70gyDp2gBQR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718190290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmpOIK+pg0ncAZr27wblc5prJ7wNCFLAgD6NifKyPnk=;
	b=oQTM+JZPT8441Y75oSXv3q1kdJC1tzsiUxm2ESvVOYNTeTbxlBw9MsrUbof63Ve4t09NBT
	nSPRPWxKl4h7QWBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718190290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmpOIK+pg0ncAZr27wblc5prJ7wNCFLAgD6NifKyPnk=;
	b=x38winlzIFDyQuqq2IemBdTafMIRToSNxbliLMxGDLPdRdflM90KbXIdSFkDqbcI1JYSYH
	j5JJDdn892J2eNKuAS7s+ek8UnM9k/jTEBSTAy4b7w9QHf6vGyPFiaZ1lVR/QhKlzVg5F6
	AHD9+8kE34HXD97cMBw70gyDp2gBQR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718190290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmpOIK+pg0ncAZr27wblc5prJ7wNCFLAgD6NifKyPnk=;
	b=oQTM+JZPT8441Y75oSXv3q1kdJC1tzsiUxm2ESvVOYNTeTbxlBw9MsrUbof63Ve4t09NBT
	nSPRPWxKl4h7QWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03FA8137DF;
	Wed, 12 Jun 2024 11:04:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5df4ANKAaWacDQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 12 Jun 2024 11:04:50 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v2 3/3] contrib: add remote target setup/cleanup script
Date: Wed, 12 Jun 2024 13:04:44 +0200
Message-ID: <20240612110444.4507-4-dwagner@suse.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612110444.4507-1-dwagner@suse.de>
References: <20240612110444.4507-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_040452_157097_F92A4BD5 
X-CRM114-Status: GOOD (  16.48  )
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

Use nvmetcli to setup/cleanup a remote soft target.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 contrib/nvme_target_control.py | 110 +++++++++++++++++++++++++++++++++
 contrib/nvmet-subsys.jinja2    |  71 +++++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100755 contrib/nvme_target_control.py
 create mode 100644 contrib/nvmet-subsys.jinja2

diff --git a/contrib/nvme_target_control.py b/contrib/nvme_target_control.py
new file mode 100755
index 000000000000..97ed1c600dd2
--- /dev/null
+++ b/contrib/nvme_target_control.py
@@ -0,0 +1,110 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-3.0+
+
+# blktests calls this script to setup/teardown remote targets. blktests passes
+# all relevant information via the command line, e.g. --hostnqn. The interface
+# between blktests and this script is 'documentent' here in build_parser
+# function.
+#
+# This script uses nvmetcli to setup the remote target (it depends on the REST
+# API feature [1]). There is not technical need for nvmetcli to use but it makes
+# it simple to setup a remote Linux box. If you want to setup someting else
+# you should to replace this part.
+#
+# There are couple of global configuration options which need to be set.
+# Add ~/.config/blktests/nvme_target_control.toml file with something like:
+#
+# [main]
+# nvmetcli='/usr/bin/nvmetcli'
+# remote='http://nvmet.local:5000'
+#
+# And then start the nvmetcli server on the remote host.
+#
+# nvmetcli uses JSON configuration, thus this script creates a JSON configuration
+# using a jinja2 template. After this step we simple have to set the blktests
+# variable correctly and start blktests.
+#
+# $ host_ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
+# $ NVME_TRTYPE=tcp NVME_NVMET=nvmet.local NVME_HOST_TRADDR=${host_ip4} \
+#   NVME_TARGET_CONTROL=~/blktests/contrib/nvme_target_control.py ./check nvme
+#
+# [1] https://github.com/hreinecke/nvmetcli/tree/restapi
+
+import os
+import tomllib
+import argparse
+import subprocess
+from jinja2 import Environment, FileSystemLoader
+
+
+XDG_CONFIG_HOME = os.environ.get("XDG_CONFIG_HOME")
+if not XDG_CONFIG_HOME:
+    XDG_CONFIG_HOME = os.environ.get('HOME') + '/.config'
+
+
+with open(f'{XDG_CONFIG_HOME}/blktests/nvme_target_control.toml', 'rb') as f:
+    config = tomllib.load(f)
+    nvmetcli = config['main']['nvmetcli']
+    remote = config['main']['remote']
+
+
+def gen_conf(conf):
+    environment = Environment(loader=FileSystemLoader('.'))
+    template = environment.get_template('nvmet-subsys.jinja2')
+    filename = f'{conf["subsysnqn"]}.json'
+    content = template.render(conf)
+    with open(filename, mode='w', encoding='utf-8') as outfile:
+        outfile.write(content)
+
+
+def target_setup(args):
+    conf = {
+        'subsysnqn': args.subsysnqn,
+        'subsys_uuid': args.subsys_uuid,
+        'hostnqn': args.hostnqn,
+        'allowed_hosts': args.hostnqn,
+        'ctrlkey': args.ctrlkey,
+        'hostkey': args.hostkey,
+        'blkdev': '/dev/vdc'
+    }
+
+    gen_conf(conf)
+
+    subprocess.call(['python3', nvmetcli, '--remote=' + remote,
+                     'restore', args.subsysnqn + '.json'])
+
+
+def target_cleanup(args):
+    subprocess.call(['python3', nvmetcli, '--remote=' + remote,
+                     'clear', args.subsysnqn + '.json'])
+
+
+def build_parser():
+    parser = argparse.ArgumentParser()
+    sub = parser.add_subparsers(required=True)
+
+    setup = sub.add_parser('setup')
+    setup.add_argument('--subsysnqn', required=True)
+    setup.add_argument('--subsys-uuid', required=True)
+    setup.add_argument('--hostnqn', required=True)
+    setup.add_argument('--ctrlkey', default='')
+    setup.add_argument('--hostkey', default='')
+    setup.set_defaults(func=target_setup)
+
+    cleanup = sub.add_parser('cleanup')
+    cleanup.add_argument('--subsysnqn', required=True)
+    cleanup.set_defaults(func=target_cleanup)
+
+    return parser
+
+
+def main():
+    import sys
+
+    parser = build_parser()
+    args = parser.parse_args()
+    args.func(args)
+
+
+if __name__ == '__main__':
+    main()
diff --git a/contrib/nvmet-subsys.jinja2 b/contrib/nvmet-subsys.jinja2
new file mode 100644
index 000000000000..a446fbd9b784
--- /dev/null
+++ b/contrib/nvmet-subsys.jinja2
@@ -0,0 +1,71 @@
+{
+  "hosts": [
+    {
+      "nqn": "{{ hostnqn }}"
+    }
+  ],
+  "ports": [
+    {
+      "addr": {
+        "adrfam": "ipv4",
+        "traddr": "0.0.0.0",
+        "treq": "not specified",
+        "trsvcid": "4420",
+        "trtype": "tcp",
+        "tsas": "none"
+      },
+      "ana_groups": [
+        {
+          "ana": {
+            "state": "optimized"
+          },
+          "grpid": 1
+        }
+      ],
+      "param": {
+        "inline_data_size": "16384",
+        "pi_enable": "0"
+      },
+      "portid": 0,
+      "referrals": [],
+      "subsystems": [
+        "{{ subsysnqn }}"
+      ]
+    }
+  ],
+  "subsystems": [
+    {
+      "allowed_hosts": [
+        "{{ allowed_hosts }}"
+      ],
+      "attr": {
+        "allow_any_host": "0",
+        "cntlid_max": "65519",
+        "cntlid_min": "1",
+        "firmware": "yada",
+        "ieee_oui": "0x000000",
+        "model": "Linux",
+        "pi_enable": "0",
+        "qid_max": "128",
+        "serial": "0c74361069d9db6c65ef",
+        "version": "1.3"
+      },
+      "namespaces": [
+        {
+          "ana": {
+            "grpid": "1"
+          },
+          "ana_grpid": 1,
+          "device": {
+            "nguid": "00000000-0000-0000-0000-000000000000",
+            "path": "{{ blkdev }}",
+            "uuid": "{{ subsys_uuid }}"
+          },
+          "enable": 1,
+          "nsid": 1
+        }
+      ],
+      "nqn": "{{ subsysnqn }}"
+    }
+  ]
+}
-- 
2.45.2


