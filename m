Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE4CCD4F3D
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jcBSvMmhKqByd6rTFVbp4/utBAQpEX6HqXoqYICylh0=; b=dLBqndCWCY3xKQc2Y3kjvoUYxK
	cCQMqBYksox7FIYGEWGGMNSeHzCwcfV3jwLSOjbEo0daSKZ9LI/4KbRRmdwUPYlEAN+jVGqZtaI5I
	/F15tzqB485Yl1YHS3QrL7rIJYsoQh5yV2YAZ1yGwyy0cIcnQjSNz8LdnLeGM4/Ee6zN2tA+2dJD4
	3QtT6trJebcrrwgkA6Rx10MyLDkTMe6fodZmbRRcEEBnbteIVtHL/CiBw7lL6m91+Ot6D9iCtBSSS
	bDdROi750MtaZh286mHtu1ZN2LbwfGLPDc5/G1bEgCwuaMTuMgYpn5eLVfdJUtxNA9Nfdqm5OROEi
	8rDsEHiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4gK-0000000883O-22nI;
	Thu, 21 May 2026 14:47:28 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4gF-0000000880z-30KN
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 14:47:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6F95440BD8;
	Thu, 21 May 2026 14:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656DA1F00A3C;
	Thu, 21 May 2026 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374843;
	bh=jcBSvMmhKqByd6rTFVbp4/utBAQpEX6HqXoqYICylh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gSh9zcW8UGwQMveO3icAHjKwXSagr+BDJnmYzpfV1y/Zswq73CicRXMEklnxcLo1i
	 1YXp8MvL2AvNM8UhhNermb6U4HO+Xl23Vko6IuiBXm1YeQllLFUmpPtQn0KAsiYBtx
	 llaO3LrWxBUIHGwLEfKAvUP992T0bezTesad0UeUZTsgdnS/KvSUXIR0jk1M5V8RII
	 3hqlyu/qlPuwt5qVqOjTPh4kkdp6sl+17v1Jcr6pbzFeMEwkiKUdOGfW9LIgCRhyP/
	 vUxvl8rwJECHmntuOcfKj+ackSKih6fWgk0utMWo+TY3SVgROBr85h2koG0bfZfhrk
	 AfDDf9C7pINzg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 21 May 2026 10:47:08 -0400
Subject: [PATCH net v2 2/7] nvme-tcp: store negative errno in
 queue->tls_err
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-handshake-file-pin-v2-2-b9dadc472840@oracle.com>
References: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
In-Reply-To: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@kernel.org>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=JOW7aetVzePh6U/0P0auy5nRsOk/ShMS6Cie+5IgQes=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDxr360IXtq7cac2x/J3JoHCrUKmoh3409kCvC
 tFwgrfzX4GJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCag8a9wAKCRAzarMzb2Z/
 l3KRD/sHIs5nYdl9+HMxJ6EX98DJuFt5lj4BwZEunvJeR7vo5faZue6oCHMLwHZqbbrhwBqWQjg
 54GrUkgPs1n/TGNnX4a6VgPus+vOYYiW2tzy9cM1u39N3K5MrNbqwTuMFNYg8NNjhNeTOBUxSTd
 FmTC1m6eoou/12dBMseJJd4k84BF70Wp7Wuj3IDotMExbRG2c40STqoaok51mcZhOxIcc/iDS6P
 Ye7re7jOidPkyyw130DalpSN7qIXXhA1uo3hAdTeIDtUxnFzdJejCuLt3qzJVVOW1vAETDTlljx
 nnDeLOokWI9pq96WurukS7h+pLMyqPAC1XC6Prbixdqr3LPVD4IHxJVP0BQ/h0H25tGrq96KR0V
 pCkN/R+whpgT9wsphhxohtr9hzhOKQpjEsQOxhC4aXkogFJg0fFri146EU0lMOpBuwkr3wilAZE
 ZCBZSefLlPMSEg/O25ckIstnSiqY6Vhd7RQ7now0cEcaoM1iRNr+heABbBnxduGtghDmWGa9gVG
 IFvASG+x/EMqunDr0xH9Mo12OgC9A4jUmLSRhr6vfwgxM5Fm6Oxzl/UrvbEuM16Fpwh9sz3ptdf
 dybHoOvD4CfaGa4gbthtm9UEbbrDQYCZgIoGupep6wXVBIOUwfnWm3QIUm4E6CqaExJ3Km62yk2
 ///UGrnkuNxHWbw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_074723_805555_19175A18 
X-CRM114-Status: GOOD (  10.88  )
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

nvme_tcp_tls_done() assigns queue->tls_err in three branches.  The
ENOKEY lookup failure and the EOPNOTSUPP initializer both store
negative errnos.  The third branch, reached when the handshake
layer reports a non-zero status, stores -status.

The handshake layer delivers status to the consumer callback as a
negative errno; the other in-tree consumers --
xs_tls_handshake_done() and the nvmet target callback -- treat
their status argument that way.  The extra negation in
nvme_tcp_tls_done() flips the sign, leaving tls_err as a positive
value (for instance, +EIO), which nvme_tcp_start_tls() then
returns to its caller.

Drop the extra negation so queue->tls_err uniformly carries a
negative errno on failure.

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 15d36d6a728e..68a1d7640494 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1702,7 +1702,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 		qid, pskid, status);
 
 	if (status) {
-		queue->tls_err = -status;
+		queue->tls_err = status;
 		goto out_complete;
 	}
 

-- 
2.54.0


