Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F339DCD4F54
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 02:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U6Q8xj489RtrXIm3D1Cyqo7DlIfd9zKBGghkGDH9x+Q=; b=lQz8AzxNqMtdO9v3VZ7xWMqPwr
	WiYzQ9BPyaMcC/41dqu4vi+uFbqmWYdKNgV/gqqnOhEsTkx6BVqGoSMX9Whs5w3yab5oT09THuPon
	EECZvYMcu7Bk9nws+ArSf3p4Y8duFYEUp8iiQfxavX3vYMb8ifB7e2Mu5vmay6wlw9+nltmYMAUpo
	PYC5/BkNkgUWwmdD7nzTPhRIQUdTI/RWdqd5Caei1AoEi4JvmKFOfrX5rzBw69UIg6M1GVJbdad2l
	1bg0Ek7ELzyzhTxKn2SZR1bv8tVh2oxbHUBjYey9+R1ODiej09Kb7UNVQgqYD1jR8yJkfLPue/VK5
	kLPpeyug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPtKK-00000006Tyj-3lcy;
	Thu, 21 May 2026 02:40:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPtKD-00000006TyQ-3Y5Y
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 02:39:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 08FD460098;
	Thu, 21 May 2026 02:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17471F000E9;
	Thu, 21 May 2026 02:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779331192;
	bh=U6Q8xj489RtrXIm3D1Cyqo7DlIfd9zKBGghkGDH9x+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HiiwEuFgSSmUI/4Pl3sAqOvhcRfK40zCwLovVZP8NigLWeZaVdp/ufhFtBUbCscDg
	 UcZVp98KxeO8dTkHeoP2RmQKqyxqh601h28ivi6MVztBAMQYS5c0UTkMmjEPLakAf1
	 T97ehoHRGLyML9a+rS0ZCgh12PL/H7FmEJdIwx2voYGEGO/vLBxtgxH81y0qwGKPPN
	 4o2lne+PwZLCl3hmyB2Bogw3gBqvE+DZK+NpRDHvJkALLyz8Ev3uA0Wb+zE+5wt2V9
	 1uciGHwuNEbw1Mtdicfp/ScasmxtdX/OhA33fTBoa8TyAi0fhgRo5OKSnSNHfbHPmm
	 5mXYtx2q4c7hA==
Date: Wed, 20 May 2026 19:39:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Chris Mason <clm@meta.com>, Christian Brauner
 <brauner@kernel.org>, kernel-tls-handshake@lists.linux.dev,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, Chuck Lever
 <chuck.lever@oracle.com>
Subject: Re: [PATCH net 3/7] net/handshake: Pass negative errno through
 handshake_complete()
Message-ID: <20260520193946.0d56882b@kernel.org>
In-Reply-To: <20260518-handshake-file-pin-v1-3-4bbcb7e62fda@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
	<20260518-handshake-file-pin-v1-3-4bbcb7e62fda@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 18 May 2026 14:24:30 -0400 Chuck Lever wrote:
> -	if (info->attrs[HANDSHAKE_A_DONE_STATUS])
> -		status = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
> +	if (info->attrs[HANDSHAKE_A_DONE_STATUS]) {
> +		u32 val = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
> +
> +		/* Values above MAX_ERRNO would overflow on negation. */
> +		if (val <= MAX_ERRNO)
> +			status = -(int)val;
> +	}

Why not set a policy so that user space can't pass invalid stuff?

(note - sashiko has some more comments but AFAICT they are either
addressed throughout the series or false positives)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 95c3fade7a8d..1024297b3851 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -12,6 +12,12 @@ protocol: genetlink
 doc: Netlink protocol to request a transport layer security handshake.
 
 definitions:
+  -
+    type: const
+    name: max-errno
+    value: 4095
+    header: linux/err.h
+    scope: kernel
   -
     type: enum
     name: handler-class
@@ -80,6 +86,8 @@ doc: Netlink protocol to request a transport layer security handshake.
       -
         name: status
         type: u32
+        checks:
+          max: max-errno
       -
         name: sockfd
         type: s32
diff --git a/net/handshake/genl.h b/net/handshake/genl.h
index 8d3e18672daf..46b65f131669 100644
--- a/net/handshake/genl.h
+++ b/net/handshake/genl.h
@@ -11,6 +11,7 @@
 #include <net/genetlink.h>
 
 #include <uapi/linux/handshake.h>
+#include <linux/err.h>
 
 int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info);
 int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index 870612609491..4b20cd9cdd0e 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -10,6 +10,7 @@
 #include "genl.h"
 
 #include <uapi/linux/handshake.h>
+#include <linux/err.h>
 
 /* HANDSHAKE_CMD_ACCEPT - do */
 static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HANDLER_CLASS + 1] = {
@@ -18,7 +19,7 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 
 /* HANDSHAKE_CMD_DONE - do */
 static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
-	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
+	[HANDSHAKE_A_DONE_STATUS] = NLA_POLICY_MAX(NLA_U32, MAX_ERRNO),
 	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
 	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
 };

