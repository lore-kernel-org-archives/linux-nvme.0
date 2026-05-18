Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245DBCD4F4A
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 18:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IeaamTvsEOMtNe1yU5OIAKgroFpaVTgDK5FTZbHIybY=; b=yVKYCtFv7NkJwmN7QE3YQHtad/
	cL0fC7TJldjhfVbbrKI5BhGYv41722n+JtTUnF2OcJvuBSTuyU7GE+b+a/rxUPmQfrIKE5hgphzg5
	Z2R4qh8oQrAQaqMZLrsT/zCSGd7wd7YNelqeu0cYXM9PAAB+wpRBK94D/HDObG5k22JkQuzRynS6N
	OtPor2unqGwlYZLh7ktNL6+iKWRje+NmV7vAY+zrhCS8KZaLpl0tYh6PTBDKXFxNeA9mb1uO6wUom
	Us0HsWsqB70kVbDIFY4L1BOFSvLA1JZMsW130/CyFWVHqKPVX9/B7WsDye19po1NUyN3RGJrs5Usg
	i8ged47w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP2eH-0000000GYcU-1TmB;
	Mon, 18 May 2026 18:25:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP2eE-0000000GYZN-1f0J
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 18:25:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D4AFE601E7;
	Mon, 18 May 2026 18:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC56BC2BCC6;
	Mon, 18 May 2026 18:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128701;
	bh=qw9+M3MIeM5f8YHwlznUziNytSNKkjRFV/R2qseBh2g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a3hvs5khVYl3K8KRhqn3NcViKjBwOqdl/Hrj3wdjR9alzXcHFiSsTuZkfqK17tpTL
	 tysk4rhdrITAhQpPZ0YfJylBWXdwt5QJF+IfnBT2H9XRKS+C7KrPSBUj59sC7dFY22
	 Ii39l/WMPgmaozsilgl+E2WDld7QwL+1icffygXsMcCumf2JLBufj7l/OLohqfVGSc
	 A63+CmqDsWN73/nCgNCX3jdBkg04hEN+syFbNuRaFvMDYrqQlj3vhPS7uhRJITq/cj
	 qBvh8AqfqJ2M4cfM0arnwfJr+SrFmy0xjBYZ0BFJRxaxoqIZPQDAiqM1epXv29L8sf
	 IIFVX1dc8HOmA==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 18 May 2026 14:24:34 -0400
Subject: [PATCH net 7/7] net/handshake: Verify file-reference balance in
 submit paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-handshake-file-pin-v1-7-4bbcb7e62fda@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
In-Reply-To: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=7019;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=PEFq5HNyYLcLzwmMNOTvg2Ovws7QwB/EmrAjy+g+g1w=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqC1l1f3gnLtCZplPsiFQoEHVkke10t/Zt3LBu8
 MHt0zV2rBKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagtZdQAKCRAzarMzb2Z/
 l9wSD/0QBdfSC5SPvJZQOJwFI212POxHcfDDgCmO0aimcR+cNY+w2Elw1QN6gOjc4DD4MB7vUxQ
 OvsSFn6Ix4U01G3jkngbMA6bF9Hpf5Bs2BatUa0lpkhfHvPHaB5mICXPqyOoTXWycThyilfmRtV
 bDCIGCOkdDf+1XdA/BHnXb+W9W6zRO/GX7C7qfl1HtqgY48VSLhu+XjUO0PDaYJIugdyWMMBJA0
 K1A62QQxJnLq7M81Ws3PFtG26gWPWb330jjqS1dqJPPDORY9PgpEOEquvy2k9knWJYZwWuIKY3D
 u7KvYLTxJeE/NTszDiay/F3iN1rFG8WMuiRt/0gJAsKWJY9hl/22JF2gqhd9183TNIOkyO/cr99
 8Bk6Lw3sSXiO+CI0YS9siqwQxC8JM6MvTccW24ZgIxUJju1qy7QUEuLoQECrGbA/u2wOmFGvtNY
 7ks+euYPrqVmzKb7OXI6m43HQG2cg7N+khzI0xiR4gZm+A/Prfa64Tss0viq64yYUAsoWXpROG2
 AjhhMtyIrgNDx7fls/yniRD8EDKQys4WKdwDETSE2OIe0DQfwucz+A22+h3xEDSx+0qxKABCxcM
 2tNhGsO+trKGn2+0M2t3n14ErloVKJCoKqnM7A3BznI4M5oiidvAIhVHpgA0qwqRdmP9nIo1x2S
 Jndklf19fxj78gQ==
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

The new file-reference contract on struct handshake_req is silently
breakable: a missing get_file() at submit or a missing fput() on an
error path leaves the file leaked but does not crash the test, so
the existing absence-of-crash checks pass either way.

Snapshot file_count(filp) before each handshake_req_submit() in
the submit-success, EAGAIN, EBUSY, and cancel tests, and assert
the expected balance after submit and again after cancel. The
already-completed cancel test also asserts the post-complete
balance, which pins down that handshake_complete() drops the
reference and that the subsequent cancel does not double-fput.
The destroy test gets the same treatment before __fput_sync(),
which double-checks that cancel's fput() ran and the only
remaining reference is the one sock_alloc_file() established.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/handshake/handshake-test.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 9cc7a95f4120..3dd507470d5f 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -208,6 +208,7 @@ static void handshake_req_submit_test3(struct kunit *test)
 static void handshake_req_submit_test4(struct kunit *test)
 {
 	struct handshake_req *req, *result;
+	unsigned long fcount_before;
 	struct socket *sock;
 	struct file *filp;
 	int err;
@@ -224,8 +225,10 @@ static void handshake_req_submit_test4(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, sock->sk);
 	sock->file = filp;
 
+	fcount_before = file_count(filp);
 	err = handshake_req_submit(sock, req, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before + 1);
 
 	/* Act */
 	result = handshake_req_hash_lookup(sock->sk);
@@ -235,11 +238,13 @@ static void handshake_req_submit_test4(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, req, result);
 
 	handshake_req_cancel(sock->sk);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 	fput(filp);
 }
 
 static void handshake_req_submit_test5(struct kunit *test)
 {
+	unsigned long fcount_before;
 	struct handshake_req *req;
 	struct handshake_net *hn;
 	struct socket *sock;
@@ -265,12 +270,14 @@ static void handshake_req_submit_test5(struct kunit *test)
 
 	saved = hn->hn_pending;
 	hn->hn_pending = hn->hn_pending_max + 1;
+	fcount_before = file_count(filp);
 
 	/* Act */
 	err = handshake_req_submit(sock, req, GFP_KERNEL);
 
 	/* Assert */
 	KUNIT_EXPECT_EQ(test, err, -EAGAIN);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 
 	fput(filp);
 	hn->hn_pending = saved;
@@ -279,6 +286,7 @@ static void handshake_req_submit_test5(struct kunit *test)
 static void handshake_req_submit_test6(struct kunit *test)
 {
 	struct handshake_req *req1, *req2;
+	unsigned long fcount_before;
 	struct socket *sock;
 	struct file *filp;
 	int err;
@@ -296,21 +304,26 @@ static void handshake_req_submit_test6(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
 	KUNIT_ASSERT_NOT_NULL(test, sock->sk);
 	sock->file = filp;
+	fcount_before = file_count(filp);
 
 	/* Act */
 	err = handshake_req_submit(sock, req1, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before + 1);
 	err = handshake_req_submit(sock, req2, GFP_KERNEL);
 
 	/* Assert */
 	KUNIT_EXPECT_EQ(test, err, -EBUSY);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before + 1);
 
 	handshake_req_cancel(sock->sk);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 	fput(filp);
 }
 
 static void handshake_req_cancel_test1(struct kunit *test)
 {
+	unsigned long fcount_before;
 	struct handshake_req *req;
 	struct socket *sock;
 	struct file *filp;
@@ -329,8 +342,10 @@ static void handshake_req_cancel_test1(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
 	sock->file = filp;
 
+	fcount_before = file_count(filp);
 	err = handshake_req_submit(sock, req, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before + 1);
 
 	/* NB: handshake_req hasn't been accepted */
 
@@ -339,12 +354,14 @@ static void handshake_req_cancel_test1(struct kunit *test)
 
 	/* Assert */
 	KUNIT_EXPECT_TRUE(test, result);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 
 	fput(filp);
 }
 
 static void handshake_req_cancel_test2(struct kunit *test)
 {
+	unsigned long fcount_before;
 	struct handshake_req *req, *next;
 	struct handshake_net *hn;
 	struct socket *sock;
@@ -365,8 +382,10 @@ static void handshake_req_cancel_test2(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
 	sock->file = filp;
 
+	fcount_before = file_count(filp);
 	err = handshake_req_submit(sock, req, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before + 1);
 
 	net = sock_net(sock->sk);
 	hn = handshake_pernet(net);
@@ -385,12 +404,14 @@ static void handshake_req_cancel_test2(struct kunit *test)
 
 	/* Assert */
 	KUNIT_EXPECT_TRUE(test, result);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 
 	fput(filp);
 }
 
 static void handshake_req_cancel_test3(struct kunit *test)
 {
+	unsigned long fcount_before;
 	struct handshake_req *req, *next;
 	struct handshake_net *hn;
 	struct socket *sock;
@@ -411,8 +432,10 @@ static void handshake_req_cancel_test3(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
 	sock->file = filp;
 
+	fcount_before = file_count(filp);
 	err = handshake_req_submit(sock, req, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before + 1);
 
 	net = sock_net(sock->sk);
 	hn = handshake_pernet(net);
@@ -428,12 +451,14 @@ static void handshake_req_cancel_test3(struct kunit *test)
 
 	/* Pretend to complete this request */
 	handshake_complete(next, -ETIMEDOUT, NULL);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 
 	/* Act */
 	result = handshake_req_cancel(sock->sk);
 
 	/* Assert */
 	KUNIT_EXPECT_FALSE(test, result);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 
 	fput(filp);
 }
@@ -454,6 +479,7 @@ static struct handshake_proto handshake_req_alloc_proto_destroy = {
 
 static void handshake_req_destroy_test1(struct kunit *test)
 {
+	unsigned long fcount_before;
 	struct handshake_req *req;
 	struct socket *sock;
 	struct file *filp;
@@ -473,10 +499,12 @@ static void handshake_req_destroy_test1(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
 	sock->file = filp;
 
+	fcount_before = file_count(filp);
 	err = handshake_req_submit(sock, req, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 
 	handshake_req_cancel(sock->sk);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 
 	/* Act */
 	/* Ensure the close/release/put process has run to

-- 
2.54.0


