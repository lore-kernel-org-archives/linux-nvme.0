Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3558606A889
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ocby+Son;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+v8axL5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=E0V3AyyWL6QZG90aiy2jEMAHEMmYHsBas5AW52wql4A=; b=ocby+SondzBgrE
	eeUJZrKQUmLiC4DzYnkCNwdFll/qpAdLo82VYVOIEomALJUIwsmCAVCPfCDPWOue8BuB44ZiBSAxQ
	NtVI2eQX890f+8tlr/ChUq6Mnb0h+HouFdC4W4tiJgCcL/0pMYP7En3OevDrh9LfYFQCKCUzOaGJl
	OsWWFwG8vpbUDbpxQ9x9dvxSK5MpgHwY9xLufCRd0H2pkfp7jMVhlztRanj0ZB1KdUDD6f1hLbOgv
	MefMC1wZ1PR05RM9nfxThxaihp7g6QUris9PNVMmqNGoV2Vv6HRefMlAR1NxLcaFtMkWHyzf2xsIk
	XxMvu5vyvcNHpA4SMobw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRwqm-0000000E9Sc-13sT;
	Fri, 13 Nov 2026 19:22:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRwqk-0000000E9Ry-2XeU
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 19:22:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0E7B345E43;
	Fri, 13 Nov 2026 19:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7451F000C6;
	Fri, 13 Nov 2026 19:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597733;
	bh=E0V3AyyWL6QZG90aiy2jEMAHEMmYHsBas5AW52wql4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A+v8axL5XJUbMExJtnlMGuVgQVClMVGfUnXz2K/6HqRWyxF+EgBq2nJr5P5rb44nw
	 uWjU+dOEPSE6oEQ+W2YYPYjvhZLYVk+BYw+7cZr8LGjEvEcomPWLq1qPpNw7Y7x/Ta
	 i4BeUPnsClhMGdFDfLHrIDXpGH8SIBgCQw4rfLihY0tAf8v4BZ/0DrUvsyAliUD4TV
	 urhc39QWqTzhJ7nAdWmcPeUkQVQVnnmMQxSlEL48vzx6KOOiolmZCWhTlc82f4nXe8
	 if7kJ3nhiheRr1lrXu+VMoTRKTrAGj25Pv0pRrqOBVaZ8r3Nr++JVrwlpKkQnDktOK
	 myIH1tAvLSz+Q==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 13 Nov 2026 14:21:59 -0500
Subject: [PATCH net-next v3 01/10] handshake: Add tags to "done" downcall
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-tls-session-tags-v3-1-91271964cdb0@kernel.org>
References: <20261113-tls-session-tags-v3-0-91271964cdb0@kernel.org>
In-Reply-To: <20261113-tls-session-tags-v3-0-91271964cdb0@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sabrina Dubroca <sd@queasysnail.net>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.17-dev-9c833
X-Developer-Signature: v=1; a=openpgp-sha256; l=4028; i=cel@kernel.org;
 h=from:subject:message-id; bh=rMFD/1BNRQW7ATk8syeRlVpVXC9iYUiuLZkECUvx0bk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBq92NfrdmxhlvPypvfugdPdrZBx6LIjKHYFTHZZ
 ZREgi0wsHuJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCavdjXwAKCRAzarMzb2Z/
 l9m1EACWbuppa6esWaDb3W/KxBerqeQmBDdYY3pzaQdimV7cknrXrPReYhKH4Sl+c1oVrHTRk9W
 JXjVNxVC1GjqpOqd1cO6hyfxH+PLiFt6cg0eff+VKyIPwwmFLJ1Ss5r9a8C1Da5D/WH+QybZ1lZ
 OI3xmEiR7EZHWY7FUDsyqYbTT8duAGWWK1KcIIg8/z/uXWqDHtmUWe8G1KP+enhuG1CmeEdqqdr
 AA2SZpJpK9+4/d+R57CHVeK8cUhY4NPZ2CbTh7iYORCeKrPcnFXyI79nIcaQinysiz26LoG8Vjj
 IulWFiMGk0dQ3wmvXTTfmI0arxlf7AUqarN4v1P5Hx1VnvEaPrLbY7hqsXAPKJXGz99T83v6wD+
 slFe16Kdr7GchwfyPJnktACh0TioFUEeSvARNSqaNOiDAMS7IVW6nrn6j3ucB8QnbD6hebLtFbq
 NOyv4jL5Uy+M7Rc3DfFgl15DXuXB7pKhM2EVBLdteBdn+a1AmnwbYBn9UhOdnyMdYSbZ/FoV9pN
 LrbhQ/fi6Mz/mqmNPV0XI2OP3JhdS0HY47CUbWVJBLN4QLgpci3pql2O6mcTDR0uBL8s6UnAxwC
 5zz+ida6X2vL5VN4YPrKPmUC3ORwg+lrCQ8ff3eQMUSFrh2bMqpoezRibsgkk2w/26ZDolRbvIg
 vS7R/3Mw1knukFQ==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tlshd has no way to report certificate characteristics to the
kernel. An Upper Layer Protocol (such as NFS) therefore cannot
authorize access based on what a client's certificate contains.

For example, an export might be restricted to clients that present
certificates whose issuer DN contains "O=Oracle". tlshd can parse
incoming certificates, and add an "oraclegroup" tag to handshakes
where a client presents a certificate with "O=Oracle" somewhere in
its Issuer field. NFSD can then be configured to look for that tag
and permit access only when it is present. NFSD needs no knowledge
of x.509 certificates.

Plumb in the netlink protocol elements for tlshd to return a list
of tags to the kernel when a handshake succeeds. Subsequent patches
add tag extraction and storage in the handshake layer.

Signed-off-by: Chuck Lever <cel@kernel.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 Documentation/netlink/specs/handshake.yaml | 15 +++++++++++++++
 include/uapi/linux/handshake.h             |  3 +++
 net/handshake/genl.c                       |  5 +++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 0498ada2dd97..17521b159e89 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -18,6 +18,10 @@ definitions:
     value: 4095
     header: linux/err.h
     scope: kernel
+  -
+    name: session-tag-max-len
+    type: const
+    value: 255
   -
     type: enum
     name: handler-class
@@ -96,6 +100,16 @@ attribute-sets:
         name: remote-auth
         type: s32
         multi-attr: true
+      -
+        name: tag
+        type: string
+        doc: >-
+          A tag the handshake agent assigns to this handshake. The
+          payload may omit the trailing NUL. An embedded NUL is
+          rejected.
+        checks:
+          max-len: session-tag-max-len
+        multi-attr: true
 
 operations:
   list:
@@ -133,6 +147,7 @@ operations:
             - status
             - sockfd
             - remote-auth
+            - tag
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index f907aa082520..bbb9ea2fa4fb 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -10,6 +10,8 @@
 #define HANDSHAKE_FAMILY_NAME		"handshake"
 #define HANDSHAKE_FAMILY_VERSION	1
 
+#define HANDSHAKE_SESSION_TAG_MAX_LEN	255
+
 enum handshake_handler_class {
 	HANDSHAKE_HANDLER_CLASS_NONE,
 	HANDSHAKE_HANDLER_CLASS_TLSHD,
@@ -59,6 +61,7 @@ enum {
 	HANDSHAKE_A_DONE_STATUS = 1,
 	HANDSHAKE_A_DONE_SOCKFD,
 	HANDSHAKE_A_DONE_REMOTE_AUTH,
+	HANDSHAKE_A_DONE_TAG,
 
 	__HANDSHAKE_A_DONE_MAX,
 	HANDSHAKE_A_DONE_MAX = (__HANDSHAKE_A_DONE_MAX - 1)
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index 26e3efec64ca..7150b32a54c4 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -18,10 +18,11 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 };
 
 /* HANDSHAKE_CMD_DONE - do */
-static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
+static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_TAG + 1] = {
 	[HANDSHAKE_A_DONE_STATUS] = NLA_POLICY_MAX(NLA_U32, MAX_ERRNO),
 	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
 	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_S32, },
+	[HANDSHAKE_A_DONE_TAG] = { .type = NLA_STRING, .len = HANDSHAKE_SESSION_TAG_MAX_LEN, },
 };
 
 /* Ops table for handshake */
@@ -37,7 +38,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
 		.cmd		= HANDSHAKE_CMD_DONE,
 		.doit		= handshake_nl_done_doit,
 		.policy		= handshake_done_nl_policy,
-		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
+		.maxattr	= HANDSHAKE_A_DONE_TAG,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };

-- 
2.56.0


