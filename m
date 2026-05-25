Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C53CD5BD5
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 16:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q2GXgcs5VCI7s/Fca53d1j4isQu7TSTLPIQKDC1hYuA=; b=Hn32bCj7cjzRTNVt0BdfStcXeo
	2m0YqTjDWXGhxcFTd0QT7flGVs5PF6hG1keJ0LzCnFyeYlECcyHH8m/OHSJuWyZWisS5/3E0mfYqe
	XMbEOzeYNmtmfHIUULLZ1mO+7iuQwQEtZI3XDeNfE5MUgX8vcDmOjKAJP2HiR70MRBRSnb/kRDD/N
	I+c1/rDILVScAh/tmRxLec6EReK0iKcxIw+2M6l3GIEvILvZpquQaEOHwQgs13Mr7NkZYTw+RsnrZ
	Z7W2R27IjN52OBA0S+S05cGtdG86VYpo9TmA4AYiLgZHxK0zB/XKtESL5Hij5mvapn6XhrQVeUOB+
	NBLNuI1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYWe-0000000048p-41JG;
	Mon, 25 May 2026 16:51:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYWd-0000000046y-2i8P
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 16:51:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 18F1760121;
	Mon, 25 May 2026 16:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4361F00A3A;
	Mon, 25 May 2026 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727894;
	bh=q2GXgcs5VCI7s/Fca53d1j4isQu7TSTLPIQKDC1hYuA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gmiUphiFs7vXnrIA2UZ2nEPwyT4lbZNq3EoSgmSx6qRzlnDSEmMHKDoVLxgd+xguT
	 OBPpwfbwJqAkjE2g0FeHy64oPal9clPsM1xqgQar2NVMNSqs/V/c188zJDhO+EhSe1
	 awzUAeqCqtol90OST/O1IEQIgFsBSdNGx7x24i6oXUNk8snJiBtZCfOy/vbn+dORYn
	 mRwa1r7z5KGWx86eF9JbKFHKhozOBOPdUxxVZhdBhSHUhq59yQoLmIhvEKLuUfgcao
	 vzc/rqi7jd0WUEtAbCqp9EVu8q8HccMJkncs68IZbWKjUl4pL6Ny1DjPemdCX7/weP
	 jGHm69pWg8IYg==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 25 May 2026 12:51:17 -0400
Subject: [PATCH net v3 3/8] net/handshake: Pass negative errno through
 handshake_complete()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-handshake-file-pin-v3-3-66c616906ead@oracle.com>
References: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
In-Reply-To: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=7743;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=5Fg6n2WNOSSwnAKLcjWieZji+TiqPP9mlv9bwTOhe9s=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFH4SJMoUFyOLT/Sj7jctH8PxawIJg4kwOMXRs
 bGtgcYIK6CJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahR+EgAKCRAzarMzb2Z/
 l5O1D/9ih+lq/qicnPTuLe8XZOyQZsFk0qaPDXf98BYs4v5I7giUM1tdoPdo9QFuC6wNW/mhJWt
 eak56pLujIyP28zVOmCv4JiihKezoaG7CydukndtgqyoI2X7zAdazLo0i/bPL3M428Va3H+NC/4
 CtmfTWDg1UWuR26yVGi4TeCIj5FwDV7vSd5fwQddAevICTYmg08mGQ3dCo+WC+Hyp9mu5YfAnj1
 MIM/+IJ9IddDB46/zsJrEbtfnWiDnRjqt+paXzS3Qa4oTCri2194VcaqE+eD2n7WshNu/5YHbfN
 hthDmUpXZ1e0L4BIHBlV+u8Zgllc5vVEwYlzi+42baRmpGKVNr4jUlmJSuC+MTVUB3t7BnlEsQQ
 NTKS7/I0lRHGMBwOSx29IteXi+NBvBu4sjextQ1YrXoh1BXgZa1U7HSJyxB/cLJgOp0aOJOo4YZ
 IvrK+6/6uC/ePTSRdENsNTAIU/7N+mAm86L9+j+E6IfuPUt7lemEfVUDNoLK7JoYn16CmFYlYW0
 /iW8eHBu7aRwL2hDCUmMkIy5deFgxkGGZJxMnHejbQ1ACm9N9ZO9sZvQIcnPut33b9hCgRpZIpQ
 TsvxsWFIPBXgpNQIbWaMUk4k+DAi4iODlslyWYnm4ce0wuBSS0oIb61EiR6AuCm4jWU4hQ61jrb
 LbWSfKNB7enzAyg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
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

From: Chuck Lever <chuck.lever@oracle.com>

handshake_complete() declares status as unsigned int and
tls_handshake_done() negates that value (-status) before handing
it to the TLS consumer. Consumers match on negative errno
constants -- xs_tls_handshake_done() has

	switch (status) {
	case 0:
	case -EACCES:
	case -ETIMEDOUT:
		lower_transport->xprt_err = status;
		break;
	default:
		lower_transport->xprt_err = -EACCES;
	}

so the API as designed expects callers to pass positive errno
values that the tlshd shim then negates.

Three internal callers in handshake_nl_accept_doit(), the
net-exit drain, and a kunit test follow kernel convention and
pass negative errnos -- -EIO, -ETIMEDOUT, -ETIMEDOUT. The
implicit conversion to unsigned int turns -ETIMEDOUT into
0xFFFFFF92; the subsequent -status in tls_handshake_done()
wraps back to 110, the consumer's switch falls through, and
the xprt reports -EACCES on what should be -ETIMEDOUT or -EIO.

Fix the API rather than the call sites. The natural kernel
convention is negative errno in, negative errno out. Change
handshake_complete() and hp_done to take int status, drop the
negation in tls_handshake_done(), and negate once in
handshake_nl_done_doit() where status arrives from the wire
as an unsigned netlink attribute. The three internal callers
were already correct under that convention and need no change.

At the same wire boundary, declare MAX_ERRNO as the netlink
policy upper bound for HANDSHAKE_A_DONE_STATUS. Attribute
validation rejects out-of-range values before
handshake_nl_done_doit() runs, and negating a bounded u32 there
stays within int range -- closing the UBSAN-visible signed-
integer overflow that an unconstrained u32 would invoke.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 Documentation/netlink/specs/handshake.yaml | 8 ++++++++
 net/handshake/genl.c                       | 3 ++-
 net/handshake/genl.h                       | 1 +
 net/handshake/handshake-test.c             | 2 +-
 net/handshake/handshake.h                  | 4 ++--
 net/handshake/netlink.c                    | 2 +-
 net/handshake/request.c                    | 2 +-
 net/handshake/tlshd.c                      | 4 ++--
 8 files changed, 18 insertions(+), 8 deletions(-)

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
@@ -80,6 +86,8 @@ attribute-sets:
       -
         name: status
         type: u32
+        checks:
+          max: max-errno
       -
         name: sockfd
         type: s32
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
diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 55442b2f518a..df3948e807a0 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -25,7 +25,7 @@ static int test_accept_func(struct handshake_req *req, struct genl_info *info,
 	return 0;
 }
 
-static void test_done_func(struct handshake_req *req, unsigned int status,
+static void test_done_func(struct handshake_req *req, int status,
 			   struct genl_info *info)
 {
 }
diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index a48163765a7a..2289b0e274f4 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -57,7 +57,7 @@ struct handshake_proto {
 	int			(*hp_accept)(struct handshake_req *req,
 					     struct genl_info *info, int fd);
 	void			(*hp_done)(struct handshake_req *req,
-					   unsigned int status,
+					   int status,
 					   struct genl_info *info);
 	void			(*hp_destroy)(struct handshake_req *req);
 };
@@ -86,7 +86,7 @@ struct handshake_req *handshake_req_hash_lookup(struct sock *sk);
 struct handshake_req *handshake_req_next(struct handshake_net *hn, int class);
 int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags);
-void handshake_complete(struct handshake_req *req, unsigned int status,
+void handshake_complete(struct handshake_req *req, int status,
 			struct genl_info *info);
 bool handshake_req_cancel(struct sock *sk);
 
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 97114ec8027a..039344979de9 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -160,7 +160,7 @@ int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
 
 	status = -EIO;
 	if (info->attrs[HANDSHAKE_A_DONE_STATUS])
-		status = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
+		status = -(int)nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
 
 	handshake_complete(req, status, info);
 	sockfd_put(sock);
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 5d4a17f902d2..97f9f8239949 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -284,7 +284,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 }
 EXPORT_SYMBOL(handshake_req_submit);
 
-void handshake_complete(struct handshake_req *req, unsigned int status,
+void handshake_complete(struct handshake_req *req, int status,
 			struct genl_info *info)
 {
 	struct sock *sk = req->hr_sk;
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index af294c6cc717..7567150c2a4f 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -93,7 +93,7 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
  *
  */
 static void tls_handshake_done(struct handshake_req *req,
-			       unsigned int status, struct genl_info *info)
+			       int status, struct genl_info *info)
 {
 	struct tls_handshake_req *treq = handshake_req_private(req);
 
@@ -104,7 +104,7 @@ static void tls_handshake_done(struct handshake_req *req,
 	if (!status)
 		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
 
-	treq->th_consumer_done(treq->th_consumer_data, -status,
+	treq->th_consumer_done(treq->th_consumer_data, status,
 			       treq->th_peerid[0]);
 }
 

-- 
2.54.0


