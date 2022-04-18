Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F167C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Cc:To:From:Subject:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5q7OQ2X2+zaBQxm2FNetvB+VXhsbm2/2JA52mtDVVLM=; b=GQ3l3qMA69xaZZT3lhjfPzwV1y
	BeV7X7WOem2EJKkabAN5/HUdxTQrPZzkSX1CDaWk7QaM4+yoJzPq+I4ZOc3lklAGOunEyOpAZLOs7
	HFLwa7FHIXoHntOpCjqx3dM5mHve+XUSzhn6HePxzjNnJlulI6jwdsFfkd9Cb3y27YQRSPHzHx2Yf
	anZ9FMV9CrWdXdFm0aZ5Ft/Qd5GTafp5mbjnGubUNXKAGGrrQUaGstDapwMcMyr5YESrPC4nLb3Tu
	/MCx3wkmoS3HQutYJT9+AWBUK3FGvS2bnYpzQRsHfRdQZf7vCrcNwivk6M2ufIgZ7tTGQeY5e9/0u
	GDvtx9Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngUap-00089d-5N; Mon, 18 Apr 2022 16:51:15 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngUaj-00084d-83
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 16:51:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D2CCF612FE;
 Mon, 18 Apr 2022 16:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5068C385A7;
 Mon, 18 Apr 2022 16:51:07 +0000 (UTC)
Subject: [PATCH RFC 00/15] Prototype implementation of RPC-with-TLS
From: Chuck Lever <chuck.lever@oracle.com>
To: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
Date: Mon, 18 Apr 2022 12:51:06 -0400
Message-ID: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_095109_413855_083B95D7 
X-CRM114-Status: GOOD (  11.93  )
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

This series implements RPC-with-TLS in the Linux kernel:

https://datatracker.ietf.org/doc/draft-ietf-nfsv4-rpc-tls/

This prototype is based on the previously posted mechanism for
providing a TLS handshake facility to in-kernel TLS consumers.

For the purpose of demonstration, the Linux NFS client is modified
to add a new mount option: xprtsec = [ none|auto|tls ] . Updates
to the nfs(5) man page are being developed separately.

The new mount option enables client administrators to require in-
transit encryption for their NFS traffic, protecting the weak
security of AUTH_SYS. An x.509 certificate is not required on the
client for this protection.

This prototype has been tested against prototype TLS-capable NFS
servers. The Linux NFS server itself does not yet have support for
RPC-with-TLS, but it is planned.

At a later time, the Linux NFS client will also get support for
x.509 authentication (for which a certificate will be required on
the client) and PSK. For this demonstration, only authentication-
less TLS (encryption-only) is supported.

---

Chuck Lever (15):
      SUNRPC: Replace dprintk() call site in xs_data_ready
      SUNRPC: Ignore data_ready callbacks during TLS handshakes
      SUNRPC: Capture cmsg metadata on client-side receive
      SUNRPC: Fail faster on bad verifier
      SUNRPC: Widen rpc_task::tk_flags
      SUNRPC: Add RPC client support for the RPC_AUTH_TLS authentication flavor
      SUNRPC: Refactor rpc_call_null_helper()
      SUNRPC: Add RPC_TASK_CORK flag
      SUNRPC: Add a cl_xprtsec_policy field
      SUNRPC: Expose TLS policy via the rpc_create() API
      SUNRPC: Add infrastructure for async RPC_AUTH_TLS probe
      SUNRPC: Add FSM machinery to handle RPC_AUTH_TLS on reconnect
      NFS: Replace fs_context-related dprintk() call sites with tracepoints
      NFS: Have struct nfs_client carry a TLS policy field
      NFS: Add an "xprtsec=" NFS mount option


 fs/nfs/client.c                 |  22 ++++
 fs/nfs/fs_context.c             |  70 ++++++++--
 fs/nfs/internal.h               |   2 +
 fs/nfs/nfs3client.c             |   1 +
 fs/nfs/nfs4client.c             |  16 ++-
 fs/nfs/nfstrace.h               |  77 +++++++++++
 fs/nfs/super.c                  |  10 ++
 include/linux/nfs_fs_sb.h       |   7 +-
 include/linux/sunrpc/auth.h     |   1 +
 include/linux/sunrpc/clnt.h     |  14 +-
 include/linux/sunrpc/sched.h    |  36 +++---
 include/linux/sunrpc/xprt.h     |  14 ++
 include/linux/sunrpc/xprtsock.h |   2 +
 include/net/tls.h               |   2 +
 include/trace/events/sunrpc.h   | 157 ++++++++++++++++++++--
 net/sunrpc/Makefile             |   2 +-
 net/sunrpc/auth.c               |   2 +
 net/sunrpc/auth_tls.c           | 117 +++++++++++++++++
 net/sunrpc/clnt.c               | 222 +++++++++++++++++++++++++++++---
 net/sunrpc/debugfs.c            |   2 +-
 net/sunrpc/xprt.c               |   3 +
 net/sunrpc/xprtsock.c           | 211 +++++++++++++++++++++++++++++-
 22 files changed, 920 insertions(+), 70 deletions(-)
 create mode 100644 net/sunrpc/auth_tls.c

--
Chuck Lever


