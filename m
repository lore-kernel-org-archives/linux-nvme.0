Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CD0C02182
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jan 2025 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QQ79eO4Nzro+vgOQ7a1ZeIU2WrCCRW1qKDrAzpN6xgY=; b=MqptneD1hTGNB0dEzXCWCN/w2I
	cU8+svagXYARKXmf9kOtecndxF62zNlqPjxPu4gA0DCcRL2SJB/49QV6NHyQbUykwbTn02Me7AXsH
	kLZIt/tM9e008MEbyS78Iwiy+jsVC5DXRQ9J+b1uu7uB31KllrfTsRs0qgF6QuspTxVvdbnd+CV7m
	1HjaoxO5ODojouTGpelYEk7cW4YGqwPILclYtTtPxnH/i4Ia9nt/UH6II8pf0aRh012NDqFM4mwoa
	XkyiDyF3RAJytBiDcpkI5to/aeacIEdeD0wx5s3T58lXEOorkL3lDHUeajqF87pyeu1q0uhJ60OMn
	WBdKZ9aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taGfp-00000008I7s-3gsE;
	Tue, 21 Jan 2025 16:00:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taGfG-00000008Hwx-13my
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jan 2025 15:59:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737475181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QQ79eO4Nzro+vgOQ7a1ZeIU2WrCCRW1qKDrAzpN6xgY=;
	b=FyXwAbuTDfydGL+OP8ISsRn+PeqbDy1Jv2VS8ldcuYcioy2Ip2FHBOU5MtIXTCQ7rCpr79
	+uhcr93Ww6xxpnkI3Tw2skC6sFaG4B9YRaBozadKWn1GP0TMVQInF70x9BSAxVkI3ttA+U
	+fOIznx0buTXV43hoYZYL6kyyamZ0rw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-R7AMJWmUPH-0NaP9xnV3Qw-1; Tue,
 21 Jan 2025 10:59:39 -0500
X-MC-Unique: R7AMJWmUPH-0NaP9xnV3Qw-1
X-Mimecast-MFC-AGG-ID: R7AMJWmUPH-0NaP9xnV3Qw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0D091955F79;
	Tue, 21 Jan 2025 15:59:37 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.155])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6753A3003E7F;
	Tue, 21 Jan 2025 15:59:34 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	hare@suse.de
Subject: [PATCH RFC] nvmetcli: execute shell commands as arguments
Date: Tue, 21 Jan 2025 16:59:32 +0100
Message-ID: <20250121155932.1293912-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WYMrTboFk6FCrb1jdF6jrQza4wDqlSNK_PV03fJa55g_1737475178
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250121_075942_358498_878901A9 
X-CRM114-Status: GOOD (  12.73  )
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

Hello,

A few days ago I was trying to create a target with
tens of subsystems and I found out that, AFACT, there
is no straightforward way to do that with nvmetcli.

It's iSCSI counterpart, targetcli, accepts shell commands
as arguments and althought it's terribly slow, a similar
feature for nvmetcli would allow the user to create simple
scripts like the following one:

nvmetcli ports/ create portid=1
nvmetcli ports/1/ set addr adrfam=ipv4 traddr=10.8.2.212 trtype=tcp trsvcid=4420

for i in $(seq 1 100); do
    nvmetcli subsystems/ create nqn=test-nqn$i
    nvmetcli subsystems/test-nqn$i/ set attr allow_any_host=1
    nvmetcli subsystems/test-nqn$i/namespaces create nsid=1
    nvmetcli subsystems/test-nqn$i/namespaces/1 set device path=/root/storage$i.img
    nvmetcli ports/1/subsystems/ create test-nqn$i
    nvmetcli subsystems/test-nqn$i/namespaces/1 enable
done

Should there be any interest, I can submit a formal patch.

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
2.43.5


