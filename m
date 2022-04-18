Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC06C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 16:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eTUFO0q1DZwkvrhnkdwR8Xhpn6ikFYNpDZ3tw7smwsg=; b=X7jSAx8FliONqBU/F7+oJknNnB
	8Fb47dFeZ2R/YJ50m15p1eGpZSv+OIw/28pTAlFo11/d4y8dxI3b6QrGdv4QxPMdCU2+EqR0oTOO1
	2srOXeuO0Hl7MZXpmDIvXvNCCq8p8+QAMkUbDk5/xRgXYeot4RRXqQ+/LUnZspcygvRvCHJpQMTI3
	xQ899sWtsk5+Jr1C8a7YnI4NExZ9v7m/oyeYE6zFYM5orpgx2c9uYmDS51vqZf5vDThOBItnDMXaS
	/9RvGwE8Kkt/uFigFkQ7nVu/Ipfpfy3b40dJyo053V7ec2nEPFt79tCscrkd3Vb6nw4uwYPoc622f
	UFBv/qGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngUhr-000Bot-8D; Mon, 18 Apr 2022 16:58:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngUcO-0008zB-KD
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 16:52:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 24714612F1;
 Mon, 18 Apr 2022 16:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF479C385A1;
 Mon, 18 Apr 2022 16:52:50 +0000 (UTC)
Subject: [PATCH RFC 15/15] NFS: Add an "xprtsec=" NFS mount option
From: Chuck Lever <chuck.lever@oracle.com>
To: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
Date: Mon, 18 Apr 2022 12:52:49 -0400
Message-ID: <165030076974.5246.10497494368440536472.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
References: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_095252_812783_2C857765 
X-CRM114-Status: GOOD (  20.65  )
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

After some discussion, we decided that controlling the user authen-
tication flavor should be separate from the setting for transport
layer security policy. To accomplish this, add a new NFS mount
option to select a transport layer security policy for RPC
operations associated with the mount point.

  xprtsec=none     - Transport layer security is disabled.

  xprtsec=auto     - Try to establish a TLS session, but proceed
                     with no transport layer security if that fails.

  xprtsec=tls      - Establish an encryption-only TLS session. If
                     the initial handshake fails, the mount fails.
                     If TLS is not available on a reconnect, drop
                     the connection and try again.

The default is xprtsec=auto.

An update to nfs(5) will be sent under separate cover.

To support client peer authentication, the plan is to add another
xprtsec= choice called "mtls" which will require a second mount
option that specifies the pathname of a directory containing the
private key and an x.509 certificate.

Similarly, pre-shared key authentication can be supported by adding
support for "xprtsec=psk" along with a second mount option that
specifies the name of a file containing the key.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/client.c     |   18 +++++++++++++++++-
 fs/nfs/fs_context.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/internal.h   |    1 +
 fs/nfs/nfs4client.c |    2 +-
 fs/nfs/super.c      |   10 ++++++++++
 5 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 0896e4f047d1..edb2cfd7262e 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -530,11 +530,27 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 	if (test_bit(NFS_CS_REUSEPORT, &clp->cl_flags))
 		args.flags |= RPC_CLNT_CREATE_REUSEPORT;
 
+	switch (clp->cl_xprtsec) {
+	case NFS_CS_XPRTSEC_AUTO:
+	case NFS_CS_XPRTSEC_TLS:
+		args.xprtsec_policy = RPC_XPRTSEC_TLS;
+		break;
+	default:
+		args.xprtsec_policy = RPC_XPRTSEC_NONE;
+	}
+
 	if (!IS_ERR(clp->cl_rpcclient))
 		return 0;
 
+retry:
 	clnt = rpc_create(&args);
 	if (IS_ERR(clnt)) {
+		if (clp->cl_xprtsec == NFS_CS_XPRTSEC_AUTO &&
+		    args.xprtsec_policy == RPC_XPRTSEC_TLS) {
+			args.xprtsec_policy = RPC_XPRTSEC_NONE;
+			goto retry;
+		}
+
 		dprintk("%s: cannot create RPC client. Error = %ld\n",
 				__func__, PTR_ERR(clnt));
 		return PTR_ERR(clnt);
@@ -680,7 +696,7 @@ static int nfs_init_server(struct nfs_server *server,
 		.cred = server->cred,
 		.nconnect = ctx->nfs_server.nconnect,
 		.init_flags = (1UL << NFS_CS_REUSEPORT),
-		.xprtsec_policy = NFS_CS_XPRTSEC_NONE,
+		.xprtsec_policy = ctx->xprtsec_policy,
 	};
 	struct nfs_client *clp;
 	int error;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index b52362735d12..bfc31ac9af65 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -88,6 +88,7 @@ enum nfs_param {
 	Opt_vers,
 	Opt_wsize,
 	Opt_write,
+	Opt_xprtsec,
 };
 
 enum {
@@ -194,6 +195,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_string("vers",		Opt_vers),
 	fsparam_enum  ("write",		Opt_write, nfs_param_enums_write),
 	fsparam_u32   ("wsize",		Opt_wsize),
+	fsparam_string("xprtsec",	Opt_xprtsec),
 	{}
 };
 
@@ -267,6 +269,20 @@ static const struct constant_table nfs_secflavor_tokens[] = {
 	{}
 };
 
+enum {
+	Opt_xprtsec_none,
+	Opt_xprtsec_auto,
+	Opt_xprtsec_tls,
+	nr__Opt_xprtsec
+};
+
+static const struct constant_table nfs_xprtsec_policies[] = {
+	{ "none",	Opt_xprtsec_none },
+	{ "auto",	Opt_xprtsec_auto },
+	{ "tls",	Opt_xprtsec_tls },
+	{}
+};
+
 /*
  * Sanity-check a server address provided by the mount command.
  *
@@ -431,6 +447,29 @@ static int nfs_parse_security_flavors(struct fs_context *fc,
 	return 0;
 }
 
+static int nfs_parse_xprtsec_policy(struct fs_context *fc,
+				    struct fs_parameter *param)
+{
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+
+	trace_nfs_mount_assign(param->key, param->string);
+
+	switch (lookup_constant(nfs_xprtsec_policies, param->string, -1)) {
+	case Opt_xprtsec_none:
+		ctx->xprtsec_policy = NFS_CS_XPRTSEC_NONE;
+		break;
+	case Opt_xprtsec_auto:
+		ctx->xprtsec_policy = NFS_CS_XPRTSEC_AUTO;
+		break;
+	case Opt_xprtsec_tls:
+		ctx->xprtsec_policy = NFS_CS_XPRTSEC_TLS;
+		break;
+	default:
+		return nfs_invalf(fc, "NFS: Unrecognized transport security policy");
+	}
+	return 0;
+}
+
 static int nfs_parse_version_string(struct fs_context *fc,
 				    const char *string)
 {
@@ -695,6 +734,11 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		if (ret < 0)
 			return ret;
 		break;
+	case Opt_xprtsec:
+		ret = nfs_parse_xprtsec_policy(fc, param);
+		if (ret < 0)
+			return ret;
+		break;
 
 	case Opt_proto:
 		trace_nfs_mount_assign(param->key, param->string);
@@ -1564,6 +1608,7 @@ static int nfs_init_fs_context(struct fs_context *fc)
 		ctx->selected_flavor	= RPC_AUTH_MAXFLAVOR;
 		ctx->minorversion	= 0;
 		ctx->need_mount		= true;
+		ctx->xprtsec_policy	= NFS_CS_XPRTSEC_AUTO;
 
 		fc->s_iflags		|= SB_I_STABLE_WRITES;
 	}
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 0a3512c39376..bc60a556ad92 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -102,6 +102,7 @@ struct nfs_fs_context {
 	unsigned int		bsize;
 	struct nfs_auth_info	auth_info;
 	rpc_authflavor_t	selected_flavor;
+	unsigned int		xprtsec_policy;
 	char			*client_address;
 	unsigned int		version;
 	unsigned int		minorversion;
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 682d47e5977b..8dbdb00859fe 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1159,7 +1159,7 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 				ctx->nfs_server.nconnect,
 				ctx->nfs_server.max_connect,
 				fc->net_ns,
-				NFS_CS_XPRTSEC_NONE);
+				ctx->xprtsec_policy);
 	if (error < 0)
 		return error;
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 6ab5eeb000dc..0c2371bbf21d 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -491,6 +491,16 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	seq_printf(m, ",timeo=%lu", 10U * nfss->client->cl_timeout->to_initval / HZ);
 	seq_printf(m, ",retrans=%u", nfss->client->cl_timeout->to_retries);
 	seq_printf(m, ",sec=%s", nfs_pseudoflavour_to_name(nfss->client->cl_auth->au_flavor));
+	switch (clp->cl_xprtsec) {
+	case NFS_CS_XPRTSEC_AUTO:
+		seq_printf(m, ",xprtsec=auto");
+		break;
+	case NFS_CS_XPRTSEC_TLS:
+		seq_printf(m, ",xprtsec=tls");
+		break;
+	default:
+		break;
+	}
 
 	if (version != 4)
 		nfs_show_mountd_options(m, nfss, showdefaults);



