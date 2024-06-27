Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AA3C2BD09
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 10:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qdNnnSsFhE9unNcw0uopU92Hb2Gg60Wf+EpSaGvpwD0=; b=Y2c6M+mgtvgnwc0DO39gCl0nhu
	NZOHX5fWzl8A0fWfs2PJyH/jcR5OiDxx8i6Fb/y3MvZR65fgL2koteSQNB9V7/yzc6VEcBiQA7Qi1
	v2PBW3kWsfXsY/4JjTllGkgbwffKQOa39ih0DfZdsfTHElDTJlnF00xzlaQTmGtXVohBD03kVehAb
	BmPBahOjFSJrrxeJjuKUsdUzUzRP9EWMQ2WGJtnqyQuopU1GTismZeO2/NhZJR9ZUIIelWgtiDBqD
	c2oMjRPCMx8MN6WdhlJFMTw7SIAtfcU2NVuv4+v2Ynfn/qtnhox7KQAPSorc6niAaHSmhwJhnEvuj
	1vbzaH6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMmbQ-0000000A1R7-48GN;
	Thu, 27 Jun 2024 10:43:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMmbL-0000000A1Q7-2oeH
	for linux-nvme@bombadil.infradead.org;
	Thu, 27 Jun 2024 10:43:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=qdNnnSsFhE9unNcw0uopU92Hb2Gg60Wf+EpSaGvpwD0=; b=keAAUUWdWo8Lh8y4qi9A+IwwzO
	SyOF276Lf6g6pjHWWCCTIPMxveMS2mqFe9NG7YxhyIJza6tycaIHB6Cw2uRKaElZC2IcL5g+BKezy
	rFpr8btqOd0tu0nXNrbBLvzkA4xqpCV81V1kVX7SK6WdCCMSoG3pw274/9I4UivKEaunQqfIjUSEf
	OP4esEZP6ngYahDgTlcfOESY0kuXQ4Jw7KeJ0Flos0vWjIXrqKdTcw5qqJ1BKNvM4YU1kxaSZvvwU
	AhUSyAs9ySWku6jmkcSMSUSpIZyMCoy2VY+rkzMwvpVh+CG3WTwjVc6DBc3ekWr2RnMBuYFneh5bL
	iQ4QGBEg==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMl9M-00000008mXV-2k2h
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 09:10:47 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CEC7A1FBB3;
	Thu, 27 Jun 2024 09:10:32 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C02851384C;
	Thu, 27 Jun 2024 09:10:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DZjxLYgsfWbCFgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 27 Jun 2024 09:10:32 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 3/3] contrib: add remote target setup/cleanup script
Date: Thu, 27 Jun 2024 11:10:16 +0200
Message-ID: <20240627091016.12752-4-dwagner@suse.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627091016.12752-1-dwagner@suse.de>
References: <20240627091016.12752-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: CEC7A1FBB3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240627_101042_149713_B2A4E639 
X-CRM114-Status: GOOD (  16.63  )
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
 contrib/nvme_target_control.py | 181 +++++++++++++++++++++++++++++++++
 contrib/nvmet-subsys.jinja2    |  71 +++++++++++++
 2 files changed, 252 insertions(+)
 create mode 100755 contrib/nvme_target_control.py
 create mode 100644 contrib/nvmet-subsys.jinja2

diff --git a/contrib/nvme_target_control.py b/contrib/nvme_target_control.py
new file mode 100755
index 000000000000..0a34a5a85a66
--- /dev/null
+++ b/contrib/nvme_target_control.py
@@ -0,0 +1,181 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-3.0+
+
+# blktests calls this script to setup/teardown remote targets. blktests passes
+# all relevant information via the command line, e.g. --hostnqn.
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
+# skip_setup_cleanup=false
+# nvmetcli='/usr/bin/nvmetcli'
+# remote='http://nvmet.local:5000'
+#
+# [host]
+# blkdev_type='device'
+# trtype='tcp'
+# hostnqn='nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349'
+# hostid='0f01fb42-9f7f-4856-b0b3-51e60b8de349'
+# host_traddr='192.168.154.187'
+#
+# [subsys_0]
+# traddr='192.168.19.189'
+# trsvid='4420'
+# subsysnqn='blktests-subsystem-1'
+# subsys_uuid='91fdba0d-f87b-4c25-b80f-db7be1418b9e'
+#
+# This expects nvmetcli with the restapi service running on target.
+#
+# Alternatively, you can skip the the target setup/cleanup completely
+# (skip_setup_cleanup) and run against a previously configured target.
+#
+# [main]
+# skip_setup_cleanup=true
+# nvmetcli='/usr/bin/nvmetcli'
+# remote='http://nvmet.local:5000'
+#
+# [host]
+# blkdev_type='device'
+# trtype='tcp'
+# hostnqn='nqn.2014-08.org.nvmexpress:uuid:1a9e23dd-466e-45ca-9f43-a29aaf47cb21'
+# hostid='1a9e23dd-466e-45ca-9f43-a29aaf47cb21'
+# host_traddr='10.161.16.48'
+#
+# [subsys_0]
+# traddr='10.162.198.45'
+# trsvid='4420'
+# subsysnqn='nqn.1988-11.com.dell:powerstore:00:f03028e73ef7D032D81E'
+# subsys_uuid='3a5c104c-ee41-38a1-8ccf-0968003d54e7'
+#
+# nvmetcli uses JSON configuration, thus this script creates a JSON configuration
+# using a jinja2 template. After this step we simple have to set the blktests
+# variable correctly and start blktests.
+#
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
+    basepath = os.path.dirname(__file__)
+    environment = Environment(loader=FileSystemLoader(basepath))
+    template = environment.get_template('nvmet-subsys.jinja2')
+    filename = f'{conf["subsysnqn"]}.json'
+    content = template.render(conf)
+    with open(filename, mode='w', encoding='utf-8') as outfile:
+        outfile.write(content)
+
+
+def target_setup(args):
+    if config['main']['skip_setup_cleanup']:
+        return
+
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
+    if config['main']['skip_setup_cleanup']:
+        return
+
+    subprocess.call(['python3', nvmetcli, '--remote=' + remote,
+                     'clear', args.subsysnqn + '.json'])
+
+
+def target_config(args):
+	if args.show_blkdev_type:
+		print(config['host']['blkdev_type'])
+	elif args.show_trtype:
+		print(config['host']['trtype'])
+	elif args.show_hostnqn:
+		print(config['host']['hostnqn'])
+	elif args.show_hostid:
+		print(config['host']['hostid'])
+	elif args.show_host_traddr:
+		print(config['host']['host_traddr'])
+	elif args.show_traddr:
+		print(config['subsys_0']['traddr'])
+	elif args.show_trsvid:
+		print(config['subsys_0']['trsvid'])
+	elif args.show_subsysnqn:
+		print(config['subsys_0']['subsysnqn'])
+	elif args.show_subsys_uuid:
+		print(config['subsys_0']['subsys_uuid'])
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
+    config = sub.add_parser('config')
+    config.add_argument('--show-blkdev-type', action='store_true')
+    config.add_argument('--show-trtype', action='store_true')
+    config.add_argument('--show-hostnqn', action='store_true')
+    config.add_argument('--show-hostid', action='store_true')
+    config.add_argument('--show-host-traddr', action='store_true')
+    config.add_argument('--show-traddr', action='store_true')
+    config.add_argument('--show-trsvid', action='store_true')
+    config.add_argument('--show-subsys-uuid', action='store_true')
+    config.add_argument('--show-subsysnqn', action='store_true')
+    config.set_defaults(func=target_config)
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


