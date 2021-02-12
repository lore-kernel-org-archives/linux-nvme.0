Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3314CC433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 15:52:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8DB564E02
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 15:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DB564E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YWagluDF/jqeZJwFXeuao/X9VRfxlo5R5bRgbJ7W1mg=; b=uQV7wM5kORz2Z3nLIaqP5RQV/
	SbOvPdlHdXs4/ZVw/4XSd/r4yvoHHYIfsz2dR5cbnRX25pDevYxLemAoG++QDEtCXaRkFKo7lyCW8
	9a+VUOQ3f2rNBjHBVzThansrJurL2iVIHq1xPAQ8aGq3c635nJQkhwRvxFxsWrkWV+kLMz5VmqQQ/
	Oud04+rEoIS5pGxJs4gYUesSDnCsEMt78r0INeuK1BSspKw8ydvaIxvKo0uDUDnBrzvelWZ3y40AJ
	QDINe3gQb+Hx8XJiJGQFPUM8wXD2Srb0GQKw+9o9rf9ifXXuc7/q9llamXf2fkBdKn3kBrVLzqmmK
	fYuTiX6Xg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAakW-00074B-C3; Fri, 12 Feb 2021 15:52:52 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAakH-0006yT-T8
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 15:52:44 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B8F33B767;
 Fri, 12 Feb 2021 15:52:36 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] nvmetproxy: add a JSON-RPC proxy daemon
Date: Fri, 12 Feb 2021 16:52:28 +0100
Message-Id: <20210212155229.98816-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210212155229.98816-1-hare@suse.de>
References: <20210212155229.98816-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_105238_364461_DD69AD37 
X-CRM114-Status: GOOD (  23.83  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Daniel Wagner <dwagner@suse.de>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Enzo Matsumiya <ematsumiya@suse.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a JSON-RPC proxy daemon to allow for remote configuration
of the NVMe-over-Fabrics target.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 Documentation/Makefile       |  24 +-
 Documentation/nvmetproxy.txt | 111 ++++++++
 nvmet/__init__.py            |   4 +-
 nvmet/bdev.py                |  72 +++++
 nvmet/rpc.py                 | 495 +++++++++++++++++++++++++++++++++++
 nvmetproxy                   | 197 ++++++++++++++
 setup.py                     |   2 +-
 7 files changed, 891 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/nvmetproxy.txt
 create mode 100644 nvmet/bdev.py
 create mode 100644 nvmet/rpc.py
 create mode 100755 nvmetproxy

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 8e0281c..2778429 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,31 +1,31 @@
 PKGNAME = nvmetcli
-MANPAGE = ${PKGNAME}.8
-HTMLFILE = ${PKGNAME}.html
-XMLFILE = ${PKGNAME}.xml
 INSTALL ?= install
 PREFIX := /usr
 
 ASCIIDOC = asciidoc
 XMLTO = xmlto --skip-validation
 
-DOCDATA = ${XMLFILE} ${HTMLFILE}
- 
-${MANPAGE}: ${DOCDATA}
+DOCFILES = ${PKGNAME}.txt nvmetproxy.txt
+MANPAGES = ${DOCFILES:.txt=.8}
+HTMLFILES = ${DOCFILES:.txt=.html}
+XMLFILES = ${DOCFILES:.txt=.xml}
+
+%.8: %.xml
 	${XMLTO} man $<
- 
+
 %.xml: %.txt
 	${ASCIIDOC} -b docbook -d manpage -o $@ $<
- 
+
 %.html: %.txt
 	${ASCIIDOC} -a toc -o $@ $<
- 
+
 installdoc: man8
 
-man8:
-	${INSTALL} -m 644 ${MANPAGE} ${PREFIX}/share/man/man8
+man8: ${MANPAGES}
+	${INSTALL} -m 644 $< ${PREFIX}/share/man/man8
 
 uninstalldoc:
 	-rm -f ${PREFIX}/share/man/man8/${MANPAGE}
 
 clean:
-	-rm -f ${MANPAGE} ${HTMLFILE} ${XMLFILE}
+	-rm -f ${MANPAGES} ${HTMLFILES} ${XMLFILES}
diff --git a/Documentation/nvmetproxy.txt b/Documentation/nvmetproxy.txt
new file mode 100644
index 0000000..b273f5b
--- /dev/null
+++ b/Documentation/nvmetproxy.txt
@@ -0,0 +1,111 @@
+nvmetproxy(8)
+===========
+
+NAME
+----
+nvmetproxy - JSON-RPC proxy server to configure NVMe-over-Fabrics Target.
+
+USAGE
+------
+[verse]
+'nvmetproxy'
+	[--socket=<socket> | -s <socket>]
+	[--host=<hostname> | -H <hostname>]
+	[--port=<port>     | -p <port>]
+	[--user=<username> | -U <username> ]
+	[--password=<password> | -P <password> ]
+	[--cert=<certfile>     | -c <certfile> ]
+	[--url=<url>           | -u <url>      ]
+
+DESCRIPTION
+-----------
+*nvmetproxy* is JSON-RPC proxy for viewing, editing, saving,
+and starting a Linux kernel NVMe Target, used for an NVMe-over-Fabrics
+network configuration.  It allows an administrator to export
+a storage resource (such as block devices, files, and volumes)
+to a local NVMe block device or expose them to remote systems
+based on the NVMe-over-Fabrics specification from http://www.nvmexpress.org.
+
+The JSON-RPC commands are compatible with the JSON-RPC commands
+the from SPDK.
+
+Connection to the daemon can be via a socket (as specified --socket)
+or via HTTP if the --host option is present.
+
+OPTIONS
+-------
+-s <socket>::
+--socket=<socket>::
+	Socket to listen on, default is /var/tmp/nvmet.sock
+
+-H <hostname>::
+--host=<hostname>::
+	Hostname to listen for HTTP requests. If specified the HTTP
+	server will started and the --socket option is ignored.
+
+-p <port>::
+--port=<port>::
+	Port number to listen for HTTP requests. Default is 4260
+
+-U <username>::
+--user=<username>::
+	Username to use for HTTP Basic Authentication. If not present
+	the HTTP server will not require authentication.
+
+-P <password>::
+--password=<password>::
+	Password to use for HTTP Basic Authentication. Must be specified
+	together with --user
+
+-c <cert>::
+--cert=<cert>::
+	SSL Server certificate to use for HTTP server. If specified the
+	HTTP server will only accept encrypted connections (https).
+
+-u <url>::
+--url=<url>::
+	URL directory to use for the configuration. Defaults to '/nvmet'
+
+
+JSON-RPC commands
+-----------------
+The proxy is compatible with the command set from the JSON-RPC calls from SPDK.
+Currently the following methods are implemented:
+
+	bdev_file_list_pools
+	bdev_file_create
+	bdev_file_delete
+	bdev_file_snapshot
+	bdev_file_clone
+	nvmf_get_interfaces
+	nvmf_create_transport
+	nvmf_get_transports
+	nvmf_create_subsystem
+	nvmf_delete_subsystem
+	nvmf_subsystem_add_ns
+	nvmf_subsystem_remove_ns
+	nvmf_subsystem_add_port
+	nvmf_subsystem_remove_port
+	nvmf_subsystem_add_host
+	nvmf_subsystem_remove_host
+	nvmf_get_subsystems
+	nvmf_port_add_ana
+	nvmf_port_set_ana
+	nvmf_port_remove_ana
+	nvmf_get_config
+	nvmf_set_config
+
+AUTHORS
+-------
+nvmetproxy was written by mailto:hare@suse.de[Hannes Reinecke]
+
+REPORTING BUGS & DEVELOPMENT
+-----------------------------
+Please send patches and bug reports to linux-nvme@lists.infradead.org
+for review and acceptance.
+
+LICENSE
+-------
+nvmetproxy is licensed under the *Apache License, Version 2.0*. Software
+distributed under this license is distributed on an "AS IS" BASIS, WITHOUT
+WARRANTIES OR CONDITIONS OF ANY KIND, either expressed or implied.
diff --git a/nvmet/__init__.py b/nvmet/__init__.py
index cf172bd..730393b 100644
--- a/nvmet/__init__.py
+++ b/nvmet/__init__.py
@@ -1,2 +1,4 @@
-from .nvme import Root, Subsystem, Namespace, Port, Host, Referral, ANAGroup,\
+from .bdev import BackingFile
+from .rpc import JsonRPC
+from .nvme import CFSError, Root, Subsystem, Namespace, Port, Host, Referral, ANAGroup,\
     DEFAULT_SAVE_FILE
diff --git a/nvmet/bdev.py b/nvmet/bdev.py
new file mode 100644
index 0000000..41735f5
--- /dev/null
+++ b/nvmet/bdev.py
@@ -0,0 +1,72 @@
+#!/usr/bin/python
+
+'''
+BackingFile JSON-RPC handling functions
+
+Copyright (c) 2021 by Hannes Reinecke, SUSE Linux LLC
+
+Licensed under the Apache License, Version 2.0 (the "License"); you may
+not use this file except in compliance with the License. You may obtain
+a copy of the License at
+
+    http://www.apache.org/licenses/LICENSE-2.0
+
+Unless required by applicable law or agreed to in writing, software
+distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
+WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
+License for the specific language governing permissions and limitations
+under the License.
+'''
+
+from __future__ import print_function
+
+import os
+
+class BackingFile:
+    def __init__(self, pools, name, pool = None, mode = 'lookup'):
+        self.name = name
+        if mode != 'lookup' and not pool:
+            for pool in pools:
+                break
+        if pool and pool not in pools:
+            raise NameError("Invalid pool '%s'" % pool)
+        if mode == 'lookup':
+            if not pool:
+                for pool in pools:
+                    self.prefix = pools[pool]
+                    path = self.prefix + '/' + name
+                    if os.path.exists(path):
+                        self.file_path = path
+                        break
+                if not self.file_path:
+                    raise NameError("backing file '%s' not found" % name)
+            else:
+                self.prefix = pools[pool]
+                path = self.prefix + '/' + name
+                if not os.path.exists(path):
+                    raise NameError("%s: backing file '%s' not found" % (pool, name))
+                self.file_path = path
+        elif mode == 'create':
+            self.prefix = pools[pool]
+            path = self.prefix + '/' + name
+            if os.path.exists(path):
+                raise NameError("%s: backing file '%s' already exists" % (pool, path))
+            try:
+                fd = open(path, 'x')
+            except:
+                raise NameError("%s: Cannot create backing file '%s'" % (pool, name))
+            fd.close()
+            self.file_path = path
+
+    def delete(self):
+        try:
+            os.remove(self.file_path)
+        except FileNotFoundError:
+            return RuntimeError("%s: cannot delete backing file '%s'" % (pool, name))
+
+    def set_size(self, file_size):
+        self.file_size = file_size
+        try:
+            os.truncate(self.file_path, self.file_size)
+        except:
+            raise RuntimeError("Failed to truncate %s" % self.file_path)
diff --git a/nvmet/rpc.py b/nvmet/rpc.py
new file mode 100644
index 0000000..4ec7d75
--- /dev/null
+++ b/nvmet/rpc.py
@@ -0,0 +1,495 @@
+'''
+Implements JSON-RPC handlers for the NVMe target configfs hierarchy
+
+Copyright (c) 2021 Hannes Reinecke, SUSE LLC
+
+Licensed under the Apache License, Version 2.0 (the "License"); you may
+not use this file except in compliance with the License. You may obtain
+a copy of the License at
+
+    http://www.apache.org/licenses/LICENSE-2.0
+
+Unless required by applicable law or agreed to in writing, software
+distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
+WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
+License for the specific language governing permissions and limitations
+under the License.
+'''
+
+import os
+import stat
+import json
+import nvmet as nvme
+import netifaces
+from pathlib import Path
+
+class JsonRPC:
+    def _get_subsystems(self, params = None):
+        return [s.dump() for s in self.cfg.subsystems]
+
+    def _get_transports(self, params = None):
+        km = kmod.Kmod()
+        ml = []
+        for m in km.loaded():
+            if m.name.startswith("nvmet_"):
+                ml.append(m.name[len("nvmet_"):])
+            elif m.name == "nvme_loop":
+                ml.append(m.name[len("nvme_"):])
+        return ml
+
+    def _create_transport(self, params):
+        if not params or 'trtype' not in params:
+            raise NameError("Parameter 'trtype' missing")
+        trtype = params['trtype']
+        if trtype.lower() == 'loop':
+            prefix = "nvme_"
+        else:
+            prefix = "nvmet_"
+        try:
+            self.cfg._modprobe(prefix + trtype.lower())
+        except:
+            raise NameError("Module %s%s not found" % (prefix, trtype.lower()))
+
+    def _create_subsystem(self, params):
+        if not params or 'nqn' not in params:
+            nqn = None
+        else:
+            nqn = params['nqn']
+        try:
+            subsys = nvme.Subsystem(nqn, mode='create')
+        except:
+            raise RuntimeError("Failed to create subsystem %s" % nqn)
+        if not params:
+            return subsys.nqn
+        if 'model_number' in params:
+            model = params['model_number']
+            if (len(model) > 40):
+                subsys.delete()
+                raise NameError("Model number longer than 40 characters")
+            try:
+                subsys.set_attr("attr", "model", model)
+            except:
+                subsys.delete()
+                raise RuntimeError("Failed to set model %s" % model)
+        if 'serial_number' in params:
+            serial = params['serial_number']
+            if len(serial) > 20:
+                subsys.delete()
+                raise NameError("Serial number longer than 20 characters")
+            try:
+                subsys.set_attr("attr", "serial", serial)
+            except:
+                subsys.delete()
+                raise RuntimeError("Failed to set serial %s" % serial)
+        if 'allow_any_host' in params:
+            subsys.set_attr("attr", "allow_any_host", "1")
+        return subsys.nqn
+
+    def _delete_subsystem(self, params):
+        if not params and 'nqn' not in params:
+            raise NameError("Parameter 'nqn' missing")
+        nqn = params['nqn']
+        try:
+            subsys = nvme.Subsystem(nqn, mode='lookup');
+        except nvme.CFSError:
+            raise NameError("Subsystem %s not found" % nqn)
+        try:
+            subsys.delete()
+        except:
+            raise RuntimeError("Failed to delete subsystem %s" % nqn)
+
+    def _add_ns(self, params):
+        if not params or 'nqn' not in params:
+            raise NameError("Parameter 'nqn' missing")
+        nqn = params['nqn']
+        if 'namespace' not in params:
+            raise NameError("Parameter 'namespace' missing")
+        ns_params = params['namespace']
+        if 'bdev_name' not in ns_params:
+            raise NameError("Parameter 'namespace:bdev_name' missing")
+        bdev_name = ns_params['bdev_name']
+        try:
+            bdev = nvme.BackingFile(self.pools, bdev_name)
+        except:
+            raise NameError("bdev %s not found" % bdev_name)
+        try:
+            subsys = nvme.Subsystem(nqn, mode='lookup')
+        except nvme.CFSError:
+            raise NameError("Subsystem %s not found" % nqn)
+
+        if 'nsid' in ns_params:
+            nsid = ns_params['nsid']
+        else:
+            nsid = None
+
+        try:
+            ns = nvme.Namespace(subsys, nsid, mode='create')
+        except:
+            raise NameError("Namespace %s already exists" % nsid)
+        nsid = ns.nsid
+        if 'uuid' in ns_params:
+            try:
+                ns.set_attr("device", "uuid", ns_params['uuid'])
+            except:
+                ns.delete()
+                raise RuntimeError("Failed to set uuid %s on ns %s" % (ns_params['uuid'], nsid))
+        if 'nguid' in ns_params:
+            try:
+                ns.set_attr("device", "nguid", ns_params['nguid'])
+            except:
+                ns.delete()
+                raise RuntimeError("Failed to set nguid %s on ns %s" % (ns_params['nguid'], nsid))
+        try:
+            ns.set_attr("device", "path", bdev.file_path)
+        except:
+            ns.delete()
+            raise RuntimeError("Failed to set path on ns %s" % nsid)
+        try:
+            ns.set_enable(1)
+        except:
+            raise RuntimeError("Failed to enable ns %s" % nsid)
+        return nsid
+
+    def _remove_ns(self, params):
+        if not params and 'nqn' not in params:
+            raise NameError("Parameter 'nqn' missing")
+        nqn = params['nqn']
+        if 'nsid' not in params:
+            raise NameError("Parameter 'nsid' missing")
+        nsid = params['nsid']
+        try:
+            subsys = nvme.Subsystem(nqn, mode='lookup')
+        except nvme.CFSError:
+            raise NameError("Subsystem %s not found" % nqn)
+        try:
+            ns = nvme.Namespace(subsys, nsid, mode='lookup')
+        except nvme.CFSError:
+            raise NameError("Namespace %d not found" % nsid)
+        ns.delete()
+
+    def _add_port(self, params):
+        if not params or 'nqn' not in params:
+            raise NameError("Parameter 'nqn' missing")
+        if 'listen_address' in params:
+            port_params = params['listen_address']
+        elif 'port' in params:
+            port_params = params['port']
+        else:
+            raise NameError("Parameter 'listen_address' missing")
+        if 'portid' not in port_params:
+            ids = [port.portid for port in self.cfg.ports]
+            if len(ids):
+                portid = max(ids)
+            else:
+                portid = 0
+            portid = portid + 1
+        else:
+            portid = int(port_params['portid'])
+        try:
+            port = nvme.Port(portid, mode='create')
+        except:
+            raise RuntimeError("Port %d already exists" % portid)
+        for p in ('trtype', 'adrfam', 'traddr', 'trsvcid'):
+            if p not in port_params:
+                if p != 'trsvcid':
+                    port.delete()
+                    raise NameError("Invalid listen_address parameter %s" % p)
+                else:
+                    v = 4420
+            else:
+                v = port_params[p]
+            if p == 'adrfam':
+                v = port_params[p].lower()
+            try:
+                port.set_attr("addr", p, v)
+            except:
+                port.delete()
+                raise RuntimeError("Failed to set %s to %s" % (p, v))
+        nqn = params['nqn']
+        try:
+            port.add_subsystem(nqn)
+        except:
+            port.delete()
+            raise NameError("subsystem %s not found" % nqn)
+        return port.portid
+
+    def _remove_port(self, params):
+        if not params or 'nqn' not in params:
+            raise NameError("Parameter 'nqn' missing")
+        if 'listen_address' in params:
+            port_params = params['listen_address']
+        elif 'port' in params:
+            port_params = params['port']
+        else:
+            raise NameError("Parameter 'listen_address' missing")
+        nqn = params['nqn']
+        for port in self.cfg.ports:
+            for p in ('trtype', 'adrfam', 'traddr', 'trsvcid'):
+                if p not in port_params:
+                    continue
+                if port.get_attr("addr", p) != port_params[p]:
+                    continue
+            for s in port.subsystems:
+                if s != nqn:
+                    continue
+                port.remove_subsystem(nqn)
+                if not len(port.subsystems):
+                    port.delete()
+
+    def _add_host(self, params):
+        if not params or 'nqn' not in params:
+            raise NameError("Parameter 'nqn' missing")
+        if 'host' not in params:
+            raise NameError("Parameter 'host' missing")
+        nqn = params['nqn']
+        try:
+            subsys = nvme.Subsystem(nqn, mode='lookup')
+        except nvme.CFSError:
+            raise NameError("Subsystem %s not found" % nqn)
+        host = nvme.Host(params['host'])
+        try:
+            subsys.add_allowed_host(host.nqn)
+        except nvme.CFSError:
+            raise RuntimeError("Could not add host %s to subsys %s" % (host, nqn))
+
+    def _remove_host(self, params):
+        if not params or 'nqn' not in params:
+            raise NameError("Parameter 'nqn' missing")
+        if 'host' not in params:
+            raise NameError("Parameter 'host' missing")
+        nqn = params['nqn']
+        try:
+            subsys = nvme.Subsystem(nqn, mode='lookup')
+        except nvme.CFSError:
+            raise NameError("Subsystem %s not found" % nqn)
+        try:
+            host = nvme.Host(params['host'], mode='lookup')
+        except nvme.CFSError:
+            raise NameError("Host %s not found" % params['host'])
+        try:
+            subsys.remove_allowed_host(host.nqn)
+        except nvme.CFSError:
+            raise RuntimeError("Failed to remove host %s from subsys %s" %
+                               (nqn,  host.nqn))
+        found = 0
+        for subsys in self.cfg.subsystems:
+            for h in subsys.allowed_hosts:
+                if h.nqn == host.nqn:
+                    found = found + 1
+        if found == 0:
+            host.delete()
+
+    def _add_ana(self, params):
+        if not params or 'portid' not in params:
+            raise NameError("Parameter 'portid' missing")
+        portid = params['portid']
+        if 'grpid' in params:
+            grpid = params['grpid']
+        else:
+            grpid = None
+        try:
+            port = nvme.Port(portid, mode='lookup')
+        except:
+            raise RuntimeError("Port %s not present" % portid)
+        try:
+            a = nvme.ANAGroup(port, grpid)
+        except nvme.CFSError:
+            raise RuntimeError("Port %s ANA Group %s already present" %
+                               (portid, grpid))
+        if 'ana_state' in params:
+            try:
+                a.set_attr("ana", "state", params['ana_state'])
+            except nvme.CFSError:
+                raise RuntimeError("Failed to set ANA state on group %s to %s"
+                                   % (grpid, params['ana_state']))
+        return a.get_attr("ana", "state")
+
+    def _set_ana(self, params):
+        if not params or 'portid' not in params:
+            raise NameError("Parameter 'portid' missing")
+        portid = params['portid']
+        if 'grpid' not in params:
+            raise NameError("Parameter 'grpid' missing")
+        grpid = params['grpid']
+        if 'ana_state' not in params:
+            raise NameError("Parameter 'ana_state' missing")
+        try:
+            port = nvme.Port(portid, mode='lookup')
+        except:
+            raise RuntimeError("Port %s not found" % portid)
+        for ana in port.ana_groups:
+            if ana.grpid == int(grpid):
+                try:
+                    ana.set_attr("ana", "state", params['ana_state'])
+                    return
+                except nvme.CFSError:
+                    raise RuntimeError("Failed to set ANA state to %s" % params['ana_state'])
+        raise RuntimeError("ANA group %s not found" % grpid)
+
+    def _remove_ana(self, params):
+        if not params or 'portid' not in params:
+            raise NameError("Parameter 'portid' missing")
+        if 'grpid' not in params:
+            raise NameError("Parameter 'grpid' missing")
+        grpid = params['grpid']
+        try:
+            port = nvme.Port(params['portid'], mode='lookup')
+        except:
+            raise RuntimeError("Port %s not found" % params['portid'])
+        grpids = [n.grpid for n in port.ana_groups]
+        if int(grpid) not in grpids:
+            raise RuntimeError("ANA group %s not found" % grpid)
+        for ana in port.ana_groups:
+            if ana.grpid == grpid:
+                ana.delete()
+
+    def _get_config(self, params):
+        return self.cfg.dump()
+
+    def _set_config(self, params):
+        if not params:
+            raise RuntimeError("Invalid configuration")
+        try:
+            self.cfg.restore(params, merge=True)
+        except nvme.CFSError:
+            raise RuntimeError("Failed to apply configuration")
+
+    def _get_interfaces(self, params):
+        ifnames = {}
+        for i in netifaces.interfaces():
+            if i == 'lo':
+                continue;
+            iflist = {}
+            ifaddrs = netifaces.ifaddresses(i)
+            try:
+                a = ifaddrs[netifaces.AF_INET]
+            except:
+                pass
+            else:
+                addrlist = []
+                for n in a:
+                    addrlist.append(n['addr'])
+                iflist['ipv4'] = addrlist
+            try:
+                a = ifaddrs[netifaces.AF_INET6]
+            except:
+                pass
+            else:
+                addrlist = []
+                for n in a:
+                    addrlist.append(n['addr'])
+                iflist['ipv6'] = addrlist
+            ifnames[i] = iflist
+        return ifnames
+
+    def _create_file(self, params):
+        if not params or 'file_name' not in params:
+            raise NameError("parameter 'file_name' missing")
+        file_name = params['file_name']
+        if 'size' not in params:
+            raise NameError("parameter 'size' missing")
+        file_size = params['size']
+        if 'pool' in params:
+            file_pool = params['pool']
+        else:
+            file_pool = None
+        bfile = nvme.BackingFile(self.pools, file_name, file_pool,
+                                mode='create')
+        bfile.set_size(int(file_size))
+        return bfile.name
+
+    def _delete_file(self, params):
+        if not params or 'file_name' not in params:
+            raise NameError("parameter 'file_name' missing")
+        file_name = params['file_name']
+        bfile = nvme.BackingFile(self.pools, file_name)
+        bfile.delete()
+
+    def _snapshot_file(self, params):
+        if not params or 'file_name' not in params:
+            raise NameError("parameter 'file_name' missing")
+        file_name = params['file_name']
+        snap = params['snapshot_name']
+        bfile = nvme.BackingFile(self.pools, file_name)
+        return bfile.snapshot(snap)
+
+    def _clone_file(self, params):
+        if not params or 'snapshot_name' not in params:
+            raise NameError("parameter 'snapshot_name' missing")
+        snap = params['snapshot_name']
+        clone = params['clone_name']
+        bfile = nvme.BackingFile(self.pools, snap)
+        return bfile.snapshot(clone)
+
+    def _get_pools(self, params):
+        r = []
+        for p in self.pools:
+            path = Path(self.pools[p])
+            filelist = []
+            for f in path.iterdir():
+                if f.is_file():
+                    filelist.append(f.name)
+            st = os.statvfs(self.pools[p])
+            a = dict(name=p, cluster_size=st.f_frsize,
+                     free_clusters=st.f_bavail,
+                     total_data_clusters=st.f_blocks,
+                     files=filelist)
+            r.append(a)
+        return r
+
+    _rpc_methods = dict(bdev_file_list_pools=_get_pools,
+                        bdev_file_create=_create_file,
+                        bdev_file_delete=_delete_file,
+                        bdev_file_snapshot=_snapshot_file,
+                        bdev_file_clone=_clone_file,
+                        nvmf_get_interfaces=_get_interfaces,
+                        nvmf_create_transport=_create_transport,
+                        nvmf_get_transports=_get_transports,
+                        nvmf_create_subsystem=_create_subsystem,
+                        nvmf_delete_subsystem=_delete_subsystem,
+                        nvmf_subsystem_add_ns=_add_ns,
+                        nvmf_subsystem_remove_ns=_remove_ns,
+                        nvmf_subsystem_add_port=_add_port,
+                        nvmf_subsystem_remove_port=_remove_port,
+                        nvmf_subsystem_add_host=_add_host,
+                        nvmf_subsystem_remove_host=_remove_host,
+                        nvmf_get_subsystems=_get_subsystems,
+                        nvmf_port_add_ana=_add_ana,
+                        nvmf_port_set_ana=_set_ana,
+                        nvmf_port_remove_ana=_remove_ana,
+                        nvmf_get_config=_get_config,
+                        nvmf_set_config=_set_config)
+
+    def __init__(self, pools = None):
+        self.cfg = nvme.Root()
+        self.pools = pools
+
+    def rpc_call(self, req):
+        print ("%s" % req)
+        if 'method' in req:
+            method = req['method']
+        else:
+            method = None
+        if 'params' in req:
+            params = req['params']
+        else:
+            params = None
+        resp = dict(jsonrpc='2.0')
+        if 'id' in req:
+            resp['id'] = req['id']
+        if method not in self._rpc_methods:
+            error = dict(code=-32601,message='Method not found')
+            resp['error'] = error;
+        else:
+            try:
+                result = self._rpc_methods[method](self, params)
+                resp['result'] = result
+            except NameError as n:
+                error = dict(code=-32602, message='Invalid params', data=n.args)
+                resp['error'] = error
+            except RuntimeError as err:
+                error = dict(code=-32000, message=err.args)
+                resp['error'] = error
+            print ("%s" % json.dumps(resp))
+        return json.dumps(resp)
+
diff --git a/nvmetproxy b/nvmetproxy
new file mode 100755
index 0000000..9c644d5
--- /dev/null
+++ b/nvmetproxy
@@ -0,0 +1,197 @@
+#!/usr/bin/python
+
+'''
+Simple json-rpc proxy daemon, based on the SPDK JSON RPC methods
+
+Copyright (c) 2021 by Hannes Reinecke, SUSE Linux LLC
+
+Licensed under the Apache License, Version 2.0 (the "License"); you may
+not use this file except in compliance with the License. You may obtain
+a copy of the License at
+
+    http://www.apache.org/licenses/LICENSE-2.0
+
+Unless required by applicable law or agreed to in writing, software
+distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
+WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
+License for the specific language governing permissions and limitations
+under the License.
+'''
+
+from __future__ import print_function
+
+import os
+import sys
+import json
+import socket
+import argparse
+import base64
+import uuid as UUID
+import nvmet as nvme
+try:
+    from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler
+except ImportError:
+    from http.server import HTTPServer
+    from http.server import BaseHTTPRequestHandler
+
+nvmet_sock = '/var/tmp/nvmet.sock'
+nvmet_url = '/nvmet'
+
+class SocketHandler:
+    def __init__(self, sockname):
+        self.sockname = sockname
+        self.sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+        self.sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
+        try:
+            self.sock.bind(self.sockname)
+        except OSError:
+            print("cannot bind to %s" % self.sockname)
+            return None
+        self.sock.listen(10)
+
+    def __enter__(self):
+        return self
+
+    def rpc_server(self):
+        while True:
+            buf = ''
+            closed = False
+            response = None
+            (client, address) = self.sock.accept()
+            while not closed:
+                newdata = client.recv(1024)
+                if (newdata == b''):
+                    closed = True
+                buf += newdata.decode('ascii')
+                try:
+                    req = json.loads(buf)
+                except ValueError:
+                    continue
+                rpc = nvme.JsonRPC(self.pool)
+                response = rpc.rpc_call(req)
+                client.sendall(response.encode('ascii'))
+                client.close()
+                closed = True
+
+    def rpc_shutdown(self):
+        self.sock.close()
+
+    def __exit__(self, exc_type, exc_value, traceback):
+        os.remove(self.sockname)
+
+class ServerHandler(BaseHTTPRequestHandler):
+    key = ""
+    pool = None
+
+    def do_HEAD(self):
+        self.send_response(200)
+        self.send_header('Content-type', 'application/json')
+        self.end_headers()
+
+    def do_AUTHHEAD(self):
+        self.send_response(401)
+        self.send_header('WWW-Authenticate', 'text/html')
+        self.send_header('Content-type', 'text/html')
+        self.end_headers()
+
+    def do_INTERNALERROR(self):
+        self.send_error(500, message='Internal Server Error',
+                        explain='Failed to parse JSON RPC request')
+
+    def do_NOTFOUND(self):
+        self.send_error(404)
+
+    def do_GET(self):
+        self.send_error(501, message="Unsupported method ('%s')" % self.command)
+
+    def do_PUT(self):
+        self.send_error(501, message="Unsupported method ('%s')" % self.command)
+
+    def do_POST(self):
+        if self.path != self.directory:
+            self.do_NOTFOUND()
+            return
+        if self.key and self.headers['Authorization'] != 'Basic ' + self.key:
+            self.do_AUTHHEAD()
+        else:
+            data_string = self.rfile.read(int(self.headers['Content-Length']))
+            try:
+                req = json.loads(data_string)
+            except ValueError:
+                self.do_INTERNALERROR()
+                return
+            rpc = nvme.JsonRPC(self.pool)
+            response = rpc.rpc_call(req)
+            self.do_HEAD()
+            self.wfile.write(bytes(response.encode(encoding='ascii')))
+
+def main():
+    pool = []
+
+    parser = argparse.ArgumentParser(description='JSON RPC proxy for nvmet')
+    parser.add_argument('-s', '--socket', dest='sock', default=nvmet_sock,
+                        help="Socket to listen on, default is " + nvmet_sock)
+    parser.add_argument('-H', '--host', dest='host', help='Host address')
+    parser.add_argument('-p', '--port', dest='port', type=int, default=4260,
+                        help='Port number')
+    parser.add_argument('-U', '--user', dest='user',
+                        help='user name for authentication')
+    parser.add_argument('-P', '--password', dest='password',
+                        help='password for authentication')
+    parser.add_argument('-c', '--cert', dest='cert',
+                        help='SSL certificate')
+    parser.add_argument('-u', '--url', dest='url', default=nvmet_url,
+                        help="URL path to serve, default is " + nvmet_url)
+    parser.add_argument('-d', '--filepool', dest='filepool', action='append',
+                        help="Directory for backing files")
+    args = parser.parse_args()
+    if args.user and not args.password:
+        sys.exit("No password specified for username %s" % args.user)
+    if args.password and not args.user:
+        sys.exit("No username specified")
+    if args.user:
+        if not args.host:
+            sys.exit("Username and password are only valid for HTTP server")
+        key = base64.b64encode(bytes('%s:%s' % (args.user, args.password), 'utf-8')).decode('ascii')
+        ServerHandler.key = key
+
+    if args.url:
+        ServerHandler.directory = args.url
+
+    if args.filepool:
+        for i in args.filepool:
+            if not os.path.isdir(args.filepool[i]):
+                sys.exit("'%s' is not a directory" % args.filepool[i])
+            pool["pool%d" % i] = args.filepool[i]
+
+    ServerHandler.pool = pool
+    SocketHandler.pool = pool
+
+    if os.geteuid() != 0:
+       print("%s: must run as root." % sys.argv[0], file=sys.stderr)
+       sys.exit(-1)
+
+
+    if args.host:
+        with HTTPServer((args.host, args.port), ServerHandler) as httpd:
+            try:
+                if args.cert is not None:
+                    http.socket = ssl.wrap_socket(httpd.socket,
+                                                  certfile=args.cert,
+                                                  server_side=True)
+                print("Started JSON RPC http proxy server on %s:%d" % (args.host, args.port))
+                httpd.serve_forever()
+            except KeyboardInterrupt:
+                print("Shutting down server")
+                httpd.socket.close()
+    else:
+        with SocketHandler(args.sock) as s:
+            try:
+                print("Started JSON RPC proxy server on %s" % args.sock)
+                s.rpc_server()
+            except KeyboardInterrupt:
+                print('Shutting down server')
+                s.rpc_shutdown()
+
+if __name__ == '__main__':
+    main()
diff --git a/setup.py b/setup.py
index 1956d95..f15e5b0 100755
--- a/setup.py
+++ b/setup.py
@@ -27,5 +27,5 @@ setup(
     maintainer_email = 'hch@lst.de',
     test_suite='nose2.collector.collector',
     packages = ['nvmet'],
-    scripts=['nvmetcli']
+    scripts=['nvmetcli', 'nvmetproxy']
     )
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
