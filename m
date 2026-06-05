Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE9BCD6E7B
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jun 2026 17:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l0e2I4tkaafPAjonkJxsN6/NkvKVwejZuO/gjLANoso=; b=4brKkLVcmyorxoXzvz9MwFj+AA
	EIg7lXx5jmU3OW0Pxeh0aj4WSKDZGyc+5YevOdbk0PLOKFoHKHJkF3Jyt/lss/1T/HcDYgAIeEL7l
	22iUjWRH5Ey5uqqYXGkFTcj8hEV996ZVvbNqFDRTqAk2lIKJkjkTaEFsuXlOfdzxQKHqzrHUbkvoa
	KnlUZAZ/Gl8HEjMlzUbP17efseqpFXT/uOmv3TF3ImdiDZ6ZsQJ0/x0v4cZcu6ZB5sYcHi0Ny8yEF
	XuEEHx+/KQcf0Uikp0n0/Z1yquFQ/mRXPsKOfWeo13wITK1d2z/EIf04w2OZlJ5RMRZkVptjQ33Ly
	7UO1mtow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVYRZ-00000000yjh-2uYB;
	Fri, 05 Jun 2026 17:34:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVYRX-00000000yjC-2pqy
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jun 2026 17:34:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E3F4E601F6;
	Fri,  5 Jun 2026 17:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC81E1F00898;
	Fri,  5 Jun 2026 17:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680890;
	bh=l0e2I4tkaafPAjonkJxsN6/NkvKVwejZuO/gjLANoso=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IGlgUUspO0HkcQCR8RpKHrm5IDBTU7rc9jWEa7i8gQQiwKbg/gFfwCGe4WnbX08FK
	 o3nkOGL1L+Y11p8WD9tvn0yKzE+FJ9Pw5hMoN2v5452HrHU6V07mgbiT/YN2jGRNJt
	 4ubwWEPu9F7PUfVFhmonLdbhC8pbP6hN/2zbRgHNP3L6SSxHcGfbKnlB9RhAs83V+h
	 THZ4GF7oBEMjegqPYeEJZZXZgZ2HvAoIZutd6nP0tyiNyGwoqBRmZ1N6v1FNtoftw6
	 3NxS8xrRc9KTEFL8ZJTnb9YXVJybd0+w2agQynmqwTo9aL9GIFkPXS8rYe6a8DmT2H
	 gssu1hloaby4w==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 05 Jun 2026 13:34:35 -0400
Subject: [PATCH 1/9] handshake: Require admin permission for DONE command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-tls-session-tags-v1-1-47bd1d94d552@oracle.com>
References: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
In-Reply-To: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sabrina Dubroca <sd@queasysnail.net>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=DNAMIdDfV+uLF7PeWYf87UtTJOGIrmRsnmjy9i973y8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIwi4Az2KTdoVCyPvGZ4ycXQh/Il93XVV9ycmF
 jvrHR5hMRKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiMIuAAKCRAzarMzb2Z/
 l/O+D/wOb3gZ0A1U3RE3xEbfWf2GRVFyXrkpcW9z3P0lQgdbZq4G+ZNuu3V/vekhR89gUSRq6+D
 XFobOpJJO0I70xO9wv3Sqto0S8kl3PnyEHVjYa07G8LjHaAPHGiYHoqP3WKOrXPoUeywnXIz+fZ
 Ths6SLB1lwVgRBLM3wj7qDwq5qSS8qu/6W/E1LO1NJDCT6JoKMssFjqDRWpc7mAVyN+bJk7TAEt
 OjkX+eDaDYUgbQUyOIlbe9tKgF9GSJfpDppY4Q/Sh2uxyEuByjCNzN1f0Sp3N8Vo18uGx3ljUhi
 oINRYZ4JbRBBDsl71tfdbeE52pX73GVugi8txVqWPNcIkVG1ZFevCWII0fDuPX2H44rnbTkIeCe
 bXYpf7hi8o6DWP3Bpgt8QJKEoAq71u9/b7PdHMiVkHrFgRJp6vZAAAlTDqZ+UlPUH0Miqgjb4Mo
 W8xAQdEUTP+tLyPLhHcLuVBrSLrmcwcseceO95hLqiNeYKd5hklAdvjLD12Li+XQ1IQvKWVJE/J
 lU9FxFNtKlUw8XttBExjVK+0CPOhPCkJXPdNpz4xxPsM6I4q/ZkwxMpZKDYxYX9Z1A+Nj27hORo
 XcLn4iajMiQDF/2kkR1KRANMx9iXx0BBCM9tGWGe9XLSbNwcf1R7o1H76sSaBWBpZXpgFazkxbk
 thKgTu21rljSEIg==
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

ACCEPT and DONE are the two downcalls of the handshake genl
family, both intended for use by the trusted handshake agent
(tlshd). ACCEPT already requires GENL_ADMIN_PERM; DONE has
no privilege check at all.

The fd-lookup in handshake_nl_done_doit() only confirms that
some pending handshake request exists for the supplied sockfd;
it does not authenticate the sender. An unprivileged process
that guesses or observes a valid sockfd can therefore submit
a DONE with HANDSHAKE_A_DONE_STATUS == 0, leaving the kernel
consumer to proceed as if the handshake succeeded. A non-zero
status on a forged DONE tears down a legitimate in-flight
handshake before tlshd can report its real result.

A subsequent patch teaches the DONE handler to carry session
tags consumed for access control. That work makes closing the
existing gap a prerequisite, but the gap itself predates tags.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/handshake.yaml | 1 +
 net/handshake/genl.c                       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 95c3fade7a8d..24f5a0ac5920 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -117,6 +117,7 @@ operations:
       name: done
       doc: Handler reports handshake completion
       attribute-set: done
+      flags: [admin-perm]
       do:
         request:
           attributes:
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index 870612609491..791c45671cd6 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -37,7 +37,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
 		.doit		= handshake_nl_done_doit,
 		.policy		= handshake_done_nl_policy,
 		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
-		.flags		= GENL_CMD_CAP_DO,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };
 

-- 
2.54.0


