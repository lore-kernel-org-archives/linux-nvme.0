Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3128C433E9
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 15:52:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DA164E02
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 15:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DA164E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2usjATfaxzUEjWjLnifaPyM3FCnNXxOhNPXlnA7Havo=; b=UkiWDCgR7OM/5JKsSjca6lzOk
	UBahsu41Dvcnzd1/I7vy7K6iyHC7699n5/4W/je0DhSKlGdD5r/j6O1hyBWv+SRSaiFEHsh78TwVP
	QFXBdAcF3Y9md8VRukaGrQ5bkCzarF4cAXh7F0Z5sZ3aB3MjqiU5ePQgiH1Xj775pqLUXJotkFHko
	7BakunVHfL/HHOtIJ9zlKvBFBu6XknGkXwkR3V2FpFmgxJAZaUBI2gy7yxUUIxNY18OUXcEIV8jLm
	bu8swkHg1EQq3vXnkBMmb0SAfG/X1d+VFTcFl2/qkJ0JwkHOo+9pjFQ9Md/UDztAXyBEqFiJWcyYm
	huCi39nTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAakU-000734-1G; Fri, 12 Feb 2021 15:52:50 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAakH-0006yP-Nh
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 15:52:41 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B8B03AC90;
 Fri, 12 Feb 2021 15:52:36 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] nvmetadm: add JSON-RPC client for remote configuration
Date: Fri, 12 Feb 2021 16:52:29 +0100
Message-Id: <20210212155229.98816-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210212155229.98816-1-hare@suse.de>
References: <20210212155229.98816-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_105238_116748_03CB0126 
X-CRM114-Status: GOOD (  19.10  )
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

Add a JSON-RPC client for remote configuration of an NVMe-over-Fabrics
target.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 nvmetadm | 259 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 setup.py |   2 +-
 2 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100755 nvmetadm

diff --git a/nvmetadm b/nvmetadm
new file mode 100755
index 0000000..74479ff
--- /dev/null
+++ b/nvmetadm
@@ -0,0 +1,259 @@
+#!/usr/bin/python3
+
+import sys
+import argparse
+import requests
+import json
+
+class rpc_client():
+    def bdev_file_create(self, args):
+        self.parser.add_argument('--filename', required=True)
+        self.parser.add_argument('--size', required=True)
+        self.parser.add_argument('--pool')
+        a = self.parser.parse_args(args)
+        s = a.size.lower().rfind('g')
+        if s != -1:
+            size = int(a.size.lower()[:-s]) * 1024 * 1024 * 1024
+        else:
+            s = a.size.lower().rfind('m')
+            if s != -1:
+                size = int(a.size.lower()[:-s]) * 1024 * 1024
+            else:
+                s = a.size.lower().rfind('k')
+                if s != -1:
+                    size = int(a.size.lower()[:-s]) * 1024
+                else:
+                    size = int(a.size)
+        params = {'file_name': a.filename, 'size': size}
+        if a.pool:
+            params['pool'] = a.pool
+        return params
+
+    def bdev_file_delete(self, args):
+        self.parser.add_argument('--filename', required=True)
+        self.parser.add_argument('--pool')
+        a = self.parser.parse_args(args)
+        params = {'filename': a.filename }
+        if a.pool:
+            params['pool'] = a.pool
+        return params
+
+    def nvmf_set_config(self, args):
+        self.parser.add_argument('--cfg-file', required=True)
+        a = self.parser.parse_args(args)
+        try:
+            cfg = open(a.cfg_file, "r")
+        except OSError:
+            sys.exit(1)
+        params = json.load(cfg)
+        cfg.close()
+        return params
+
+    def nvmf_create_transport(self, args):
+        self.parser.add_argument('--trtype', required=True)
+        a = self.parser.parse_args(args)
+        if not a.trtype:
+            return None
+        return {"trtype": a.trtype}
+
+    def nvmf_create_subsystem(self, args):
+        self.parser.add_argument('--nqn')
+        a = self.parser.parse_args(args)
+        params = None
+        if not a.nqn:
+            return None
+        return {"nqn": a.nqn}
+
+    def nvmf_delete_subsystem(self, args):
+        self.parser.add_argument('--nqn', required=True)
+        a = self.parser.parse_args(args)
+        return {"nqn": a.nqn}
+
+    def nvmf_subsystem_add_ns(self, args):
+        self.parser.add_argument('--nqn', required=True)
+        self.parser.add_argument('--bdev-name', required=True)
+        self.parser.add_argument('--nsid')
+        self.parser.add_argument('--nguid')
+        self.parser.add_argument('--eui64')
+        self.parser.add_argument('--uuid')
+        a = self.parser.parse_args(args)
+        ns = { 'bdev_name': a.bdev_name }
+        if a.nsid:
+            ns['nsid'] = a.nsid
+        if a.nguid:
+            ns['nguid'] = a.nguid
+        if a.eui64:
+            ns['eui64'] = a.eui64
+        if a.uuid:
+            ns['uuid'] = a.uuid
+        return {"nqn": a.nqn, 'namespace': ns}
+
+    def nvmf_subsystem_remove_ns(self, args):
+        self.parser.add_argument('--nqn', required=True)
+        self.parser.add_argument('--nsid', required=True, type=int)
+        a = self.parser.parse_args(args)
+        return {'nqn': a.nqn, 'nsid': a.nsid }
+
+    def nvmf_subsystem_port(self, args):
+        self.parser.add_argument('--nqn', required=True)
+        self.parser.add_argument('--portid', type=int)
+        self.parser.add_argument('--trtype', required=True)
+        self.parser.add_argument('--traddr', required=True)
+        self.parser.add_argument('--adrfam')
+        self.parser.add_argument('--trscvid')
+        self.parser.add_argument('--host-traddr')
+        a = self.parser.parse_args(args)
+        port = { 'trtype': a.trtype, 'traddr': a.traddr }
+        if a.portid:
+            port['portid'] = a.portid
+        if a.adrfam:
+            port['adrfam'] = a.adrfam
+        if a.trscvid:
+            port['trsvcid'] = a.trscvid
+        if a.host_traddr:
+            port['host_traddr'] = a.host_traddr
+        return {"nqn": a.nqn, 'port': port}
+
+    def nvmf_subsystem_host(self, args):
+        self.parser.add_argument('--nqn', required=True)
+        self.parser.add_argument('--host', required=True)
+        a = self.parser.parse_args(args)
+        return {'nqn': a.nqn, 'host': a.host }
+
+    def nvmf_port_ana(self, args):
+        self.parser.add_argument('--portid', required=True)
+        self.parser.add_argument('--grpid')
+        self.parser.add_argument('--ana_state')
+        a = self.parser.parse_args(args)
+        params = { 'portid': a.portid }
+        if a.grpid:
+            params['grpid'] = a.grpid
+        if a.ana_state:
+            params['ana_state'] = a.ana_state
+        return params
+
+    def method_no_param(self, args = None):
+        a = self.parser.parse_args(args)
+        return
+
+    _rpc_methods = dict(bdev_file_list_pools=method_no_param,
+                        bdev_file_create=bdev_file_create,
+                        bdev_file_delete=bdev_file_delete,
+                        nvmf_get_config=method_no_param,
+                        nvmf_set_config=nvmf_set_config,
+                        nvmf_get_interfaces=method_no_param,
+                        nvmf_create_transport=nvmf_create_transport,
+                        nvmf_get_transports=method_no_param,
+                        nvmf_create_subsystem=nvmf_create_subsystem,
+                        nvmf_delete_subsystem=nvmf_delete_subsystem,
+                        nvmf_subsystem_add_ns= nvmf_subsystem_add_ns,
+                        nvmf_subsystem_remove_ns=nvmf_subsystem_remove_ns,
+                        nvmf_subsystem_add_port=nvmf_subsystem_port,
+                        nvmf_subsystem_remove_port=nvmf_subsystem_port,
+                        nvmf_subsystem_add_host=nvmf_subsystem_host,
+                        nvmf_subsystem_remove_host=nvmf_subsystem_host,
+                        nvmf_port_add_ana=nvmf_port_ana,
+                        nvmf_port_set_ana=nvmf_port_ana,
+                        nvmf_port_remove_ana=nvmf_port_ana,
+                        nvmf_get_subsystems=method_no_param)
+
+    def __init__(self, method):
+        if method not in self._rpc_methods:
+            print("Invalid rpc method '%s'; must be one of" % method)
+            print(", ".join([x for x in list(self._rpc_methods)]))
+            sys.exit(1)
+                
+        self.parser = argparse.ArgumentParser(prog="nvmetadm %s" % method)
+        self._method = self._rpc_methods[method]
+
+    def _error(self, err):
+        data = None
+        if 'code' not in err:
+            code = -32000
+            message = "Server error"
+            data = []
+            data.append("Invalid JSON RPC response")
+        else:
+            code = err['code']
+        if 'message' in err:
+            message = err['message']
+        else:
+            if code == -32700:
+                message = "Parse error"
+            elif code == -32600:
+                message = "Invalid Request"
+            elif code == -32601:
+                message = "Method not found"
+            elif code == -32602:
+                message = "Invalid params"
+            elif code == -32603:
+                message = "Internal error"
+            elif code <= -32000 and code > -32100:
+                message = "Server error"
+            else:
+                data = []
+                data.append("Invalid JSON RPC error code %d" & code)
+                code = -32001
+                message = "Server error"
+        if 'data' in err:
+            data = err['data']
+        return (code, message, data)
+
+    def call(self, args):
+        return self._method(self, args)
+
+    def response(self, response):
+        if 'error' in response:
+            (code, message, data) = self._error(response['error'])
+            if data:
+                sys.exit("JSON RPC error %d: %s\n%s" % (code, message, json.dumps(data)))
+            else:
+                sys.exit("JSON RPC error %d: %s" % (code, message))
+        elif 'result' not in response:
+            sys.exit("JSON RPC error: Not a valid response\n%s", response)
+        elif response['result']:
+            return response['result']
+
+def main():
+    parser = argparse.ArgumentParser()
+    parser.add_argument('-H', '--host', help='Hostname to connect to',
+                        required=True)
+    parser.add_argument('-p', '--port', type=int, default=4260,
+                        help='Port number for the connection')
+    parser.add_argument('-U', '--username')
+    parser.add_argument('-P', '--password')
+    parser.add_argument('-u', '--uri', default='nvmet',
+                        help='URI of the JSON-RPC namespace')
+    (a, args) = parser.parse_known_args()
+    if a.username:
+        if not a.password:
+            sys.exit("Need to specify both username and password")
+        auth = (a.username, a.password)
+    elif not a.password:
+        auth = None
+    else:
+        sys.exit("Need to specify both username and password")
+    url = "http://%s:%d/%s" % (a.host, a.port, a.uri)
+
+    if not args or not len(args):
+        sys.exit("No method given")
+
+    method = args.pop(0)
+    payload = {
+        "method": method,
+        "jsonrpc": "2.0",
+        "id": 0,
+    }
+    rpc = rpc_client(method)
+    params = rpc.call(args)
+    if params:
+        payload['params'] = params
+    response = requests.post(url, auth=auth,json=payload)
+    response.raise_for_status()
+    msg = rpc.response(response.json())
+    if msg:
+        print("%s" % json.dumps(msg, indent=2))
+
+
+if __name__ == "__main__":
+    main()
diff --git a/setup.py b/setup.py
index f15e5b0..998ff78 100755
--- a/setup.py
+++ b/setup.py
@@ -27,5 +27,5 @@ setup(
     maintainer_email = 'hch@lst.de',
     test_suite='nose2.collector.collector',
     packages = ['nvmet'],
-    scripts=['nvmetcli', 'nvmetproxy']
+    scripts=['nvmetcli', 'nvmetproxy', 'nvmetadm']
     )
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
