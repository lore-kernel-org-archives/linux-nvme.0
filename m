Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB18DC83F17
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jul 2025 17:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UaEC+xJ9Cv5mIy68wy6HSwlzmlsITQQNBlmx29QdVBg=; b=DYwn9v3gT42xIhBod0OnWbmNSq
	W/TjurxFgvK2T6rSW2A0TU/QA+gbbsPcn9kzEtsEQX6Z0IrloO0gd+hrSzLJMdNeS15VNg57V72Zs
	ys6lnfdmWkBlqF/AMMMZYKVsUdQwt+78FhoZ2pGw18LyGak9Txm6qk/UR6gAXgQuTUV2KG+aT+LQl
	VZBEGB1BQ/Diy1mwTbRi5NdnzAgkEq1du2HGMbkiDAj+xQJUc5wQKRh6J9eOfxJ+9bvUTIjauiyzb
	3aLVoaH4i7Bbr47sksl8Nb+n0mNGbH9cJB11TheyBXlKD6utdI/84DK7CzfyRFb9pLDF+Ffy3GSPd
	5Z6yrimA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugREJ-0000000F3KV-0xYQ;
	Mon, 28 Jul 2025 17:01:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugQC4-0000000Etm9-3rHn
	for linux-nvme@lists.infradead.org;
	Mon, 28 Jul 2025 15:55:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753718115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UaEC+xJ9Cv5mIy68wy6HSwlzmlsITQQNBlmx29QdVBg=;
	b=D8hrGZSA/HsJn3AVCbzJLC7jU52XLRlRfE9xVP3xGoKNd83J+pNq2LehfPPB944QOHpX8b
	bZcq9kzcsj2YBvpU3HaVg4m2YSlskzQGKTGI7QjF1JOz4tYma1WFM4FWr93m95z5FaIwVX
	EaynSQ+kLSjB3m++9Li846GCY+eqgAI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-Z80sEif3NNuQ2XEHuX_tmg-1; Mon,
 28 Jul 2025 11:55:11 -0400
X-MC-Unique: Z80sEif3NNuQ2XEHuX_tmg-1
X-Mimecast-MFC-AGG-ID: Z80sEif3NNuQ2XEHuX_tmg_1753718110
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 707791956089;
	Mon, 28 Jul 2025 15:55:09 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76CF01800286;
	Mon, 28 Jul 2025 15:55:05 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: hch@lst.de
Cc: nilay@linux.ibm.com,
	hare@suse.de,
	sagi@grimberg.me,
	mlombard@bsdbackstore.eu,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvmetcli: allow running arbitrary commands non-interactively
Date: Mon, 28 Jul 2025 17:55:04 +0200
Message-ID: <20250728155504.403426-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qGMQ6hVBItt5RnwzBDPbeD-DOJ6BKcO45L6vtqwps6g_1753718110
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250728_085517_206883_63614A31 
X-CRM114-Status: GOOD (  13.92  )
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

This patch refactors the command-line argument handling
to allow for the execution of any valid shell command directly
from the system's command line, without entering the interactive mode.

Previously, only a limited, hardcoded set of
commands (`save`, `restore`, `clear`, `ls`) could be run
non-interactively.
This change removes the special case for the `ls` command and
introduces a generic mechanism that concatenates all command-line
arguments and executes them as a single command within the
`nvmetcli` shell.

This enhancement improves the scriptability of the tool.

For example, users can now run complex commands like:
$ nvmetcli /subsystems create nqn.2024-07.org.example:sub1
$ nvmetcli /ports ls

The usage information has been updated to reflect this new functionality.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 nvmetcli | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/nvmetcli b/nvmetcli
index d949891..044b24c 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -666,7 +666,8 @@ def usage():
     print("syntax: %s save [file_to_save_to]" % sys.argv[0])
     print("        %s restore [file_to_restore_from]" % sys.argv[0])
     print("        %s clear" % sys.argv[0])
-    print("        %s ls" % sys.argv[0])
+    print("        %s --help  (Print this information)" % sys.argv[0])
+    print("        %s <CMD>   (Run shell command and exit)" % sys.argv[0])
     sys.exit(-1)
 
 
@@ -703,14 +704,14 @@ def clear(unused):
     nvme.Root().clear_existing()
 
 
-def ls(unused):
+def execute_cmd(cmd):
     shell = configshell.shell.ConfigShell('~/.nvmetcli')
     UIRootNode(shell)
-    shell.run_cmdline("ls")
+    shell.run_cmdline(cmd)
     sys.exit(0)
 
 
-funcs = dict(save=save, restore=restore, clear=clear, ls=ls)
+funcs = dict(save=save, restore=restore, clear=clear)
 
 
 def main():
@@ -718,23 +719,23 @@ def main():
         print("%s: must run as root." % sys.argv[0], file=sys.stderr)
         sys.exit(-1)
 
-    if len(sys.argv) > 3:
-        usage()
-
-    if len(sys.argv) == 2 or len(sys.argv) == 3:
+    if len(sys.argv) > 1:
         if sys.argv[1] == "--help":
             usage()
 
-        if sys.argv[1] not in funcs.keys():
-            usage()
+        if sys.argv[1] in funcs.keys():
+            if len(sys.argv) > 3:
+                usage()
+            if len(sys.argv) == 3:
+                savefile = sys.argv[2]
+            else:
+                savefile = None
 
-        if len(sys.argv) == 3:
-            savefile = sys.argv[2]
+            funcs[sys.argv[1]](savefile)
+            return
         else:
-            savefile = None
-
-        funcs[sys.argv[1]](savefile)
-        return
+            concat_args = ' '.join(sys.argv[1:])
+            execute_cmd(concat_args)
 
     try:
         shell = configshell.shell.ConfigShell('~/.nvmetcli')
-- 
2.47.1


