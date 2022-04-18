Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27253C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 16:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1kqIkMsKOz5gDnt5amPrhTOaqfnUwcgiPUUbtzqYXoE=; b=r8ieLAiQv4UaExCTMeuYIYZurK
	LvsVf/lPSUT+NIbJofo7TxuZXsr5PzoTrnUT080hl7zaUBrj8HKnqzx8atCFqLLXxQ+Bo7y/zmdrg
	Y15hu99uB735Yu+19U2IdA+4h7wO7r5BhIYZUOPoe4NOX+6CS1P474/NG9z/Xv6cbqCKDQS92+e0t
	Z1CDdBiC9GgVYqW+wMAw7LhXJtI6EZkTOByIG0o3Nm0vMf5f7OchrN8R5KQjcUoxkbrC/9vJr44zI
	/nfB4whVpYV5QX0e+Eg0zcpb8U7BgV93YLA7NeHW/6Nie8UvB5XIBK4u4E/vPZlVKBA//oWALKjSh
	raFwsDag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngUZR-0007Mf-D7; Mon, 18 Apr 2022 16:49:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngUZN-0007KG-Su
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 16:49:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6DFB5612D4;
 Mon, 18 Apr 2022 16:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B34C385AA;
 Mon, 18 Apr 2022 16:49:44 +0000 (UTC)
Subject: [PATCH RFC 3/5] net/tls: Add an AF_TLSH address family
From: Chuck Lever <chuck.lever@oracle.com>
To: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
Date: Mon, 18 Apr 2022 12:49:43 -0400
Message-ID: <165030058340.5073.5461321687798728373.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_094946_043361_35977366 
X-CRM114-Status: GOOD (  14.58  )
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

Add definitions for an AF_TLSH address family. The next patch
explains its purpose and operation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/socket.h                         |    4 +++-
 net/core/sock.c                                |    2 +-
 net/socket.c                                   |    1 +
 security/selinux/hooks.c                       |    4 +++-
 security/selinux/include/classmap.h            |    4 +++-
 tools/perf/trace/beauty/include/linux/socket.h |    4 +++-
 6 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 6f85f5d957ef..fc28c68e6b5f 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -226,8 +226,9 @@ struct ucred {
 #define AF_MCTP		45	/* Management component
 				 * transport protocol
 				 */
+#define AF_TLSH		46	/* TLS handshake request */
 
-#define AF_MAX		46	/* For now.. */
+#define AF_MAX		47	/* For now.. */
 
 /* Protocol families, same as address families. */
 #define PF_UNSPEC	AF_UNSPEC
@@ -278,6 +279,7 @@ struct ucred {
 #define PF_SMC		AF_SMC
 #define PF_XDP		AF_XDP
 #define PF_MCTP		AF_MCTP
+#define PF_TLSH		AF_TLSH
 #define PF_MAX		AF_MAX
 
 /* Maximum queue length specifiable by listen.  */
diff --git a/net/core/sock.c b/net/core/sock.c
index 1180a0cb0110..81bc14b67468 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -224,7 +224,7 @@ static struct lock_class_key af_family_kern_slock_keys[AF_MAX];
   x "AF_IEEE802154",	x "AF_CAIF"	,	x "AF_ALG"      , \
   x "AF_NFC"   ,	x "AF_VSOCK"    ,	x "AF_KCM"      , \
   x "AF_QIPCRTR",	x "AF_SMC"	,	x "AF_XDP"	, \
-  x "AF_MCTP"  , \
+  x "AF_MCTP"  ,	x "AF_TLSH"	, \
   x "AF_MAX"
 
 static const char *const af_family_key_strings[AF_MAX+1] = {
diff --git a/net/socket.c b/net/socket.c
index 6887840682bb..fc43ebd5ad66 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -214,6 +214,7 @@ static const char * const pf_family_names[] = {
 	[PF_SMC]	= "PF_SMC",
 	[PF_XDP]	= "PF_XDP",
 	[PF_MCTP]	= "PF_MCTP",
+	[PF_TLSH]	= "PF_TLSH",
 };
 
 /*
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e9e959343de9..734e284eb06a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1259,7 +1259,9 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
 			return SECCLASS_XDP_SOCKET;
 		case PF_MCTP:
 			return SECCLASS_MCTP_SOCKET;
-#if PF_MAX > 46
+		case PF_TLSH:
+			return SECCLASS_TLSH_SOCKET;
+#if PF_MAX > 47
 #error New address family defined, please update this function.
 #endif
 		}
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 35aac62a662e..673b51f8281d 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -237,6 +237,8 @@ struct security_class_mapping secclass_map[] = {
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "smc_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
+	{ "tlsh_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
 	{ "infiniband_pkey",
 	  { "access", NULL } },
 	{ "infiniband_endport",
@@ -257,6 +259,6 @@ struct security_class_mapping secclass_map[] = {
 	{ NULL }
   };
 
-#if PF_MAX > 46
+#if PF_MAX > 47
 #error New address family defined, please update secclass_map.
 #endif
diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index 6f85f5d957ef..fc28c68e6b5f 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -226,8 +226,9 @@ struct ucred {
 #define AF_MCTP		45	/* Management component
 				 * transport protocol
 				 */
+#define AF_TLSH		46	/* TLS handshake request */
 
-#define AF_MAX		46	/* For now.. */
+#define AF_MAX		47	/* For now.. */
 
 /* Protocol families, same as address families. */
 #define PF_UNSPEC	AF_UNSPEC
@@ -278,6 +279,7 @@ struct ucred {
 #define PF_SMC		AF_SMC
 #define PF_XDP		AF_XDP
 #define PF_MCTP		AF_MCTP
+#define PF_TLSH		AF_TLSH
 #define PF_MAX		AF_MAX
 
 /* Maximum queue length specifiable by listen.  */



