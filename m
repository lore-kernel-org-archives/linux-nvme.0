Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367A5C77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 08:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NEnZ644JL7BzqvU0sxbGAoBWYjk3iv5CXkJiuBwPN/c=; b=bWkApE4YyVis9KRWsIoin4xQpM
	ttO8//6TkgKGWkI9+qR7wjbVRSyqq159FWDCZXsdRucIYTJLJR3RZlmJgWj24PLQLjrbNey4ps1Zd
	7Zyy1YR9pUVPNh7HffwhLXUe2cVGya+q9USZ34MfqkkFW3BiUyblsfGO4FlTieU7es/XN1fiVFVm1
	s47mvND7DtJdJuQrM4SfXDTlqvEkR7s2jhoabMiOiJefiRjf0ASN3o0DetgJg7ABBBq/j18EIRlON
	J6Bc39n3E4dCMXdC09rDWUI1pfh9PCtVs8P2uRaW57ucFjlFUQoNJRhFD3TXLAeRfZmZK+z43q1KB
	K2+nhSDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp3U3-004ddS-0E;
	Wed, 19 Apr 2023 08:48:11 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp3Tz-004dZn-1w
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 08:48:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 203E321908;
	Wed, 19 Apr 2023 08:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681894083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEnZ644JL7BzqvU0sxbGAoBWYjk3iv5CXkJiuBwPN/c=;
	b=M8tPaWGNuTcM0+4I5u+VLunpNCH8/cK5wAYTEPICSez2IJ173pcGHxIEgnWuXF/lZE2ZIS
	3TyNEuKQ+TzkG6vjv5A5Gn/d+vsINCs4VC6Y8mnBxfCoUfRq5wOewasrdEfwpvrVCeBe+V
	FJMcsL7No4pmM/LALJEENsiuc1prKSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681894083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEnZ644JL7BzqvU0sxbGAoBWYjk3iv5CXkJiuBwPN/c=;
	b=FHGWW/rllpupFShePGQj1O4dUlE0IMPgumOX32O9iG61oeSYDLecrcR+QYrvAf3mtcmTuO
	HF8gZr+O13sZBjBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 118961390E;
	Wed, 19 Apr 2023 08:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id yasgBMOqP2S7dQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Apr 2023 08:48:03 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before module unloading
Date: Wed, 19 Apr 2023 10:47:57 +0200
Message-Id: <20230419084757.24846-3-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230419084757.24846-1-dwagner@suse.de>
References: <20230419084757.24846-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_014807_935227_988EEC4E 
X-CRM114-Status: GOOD (  11.53  )
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

Before we unload the module we should cleanup the fc resources first,
basically reorder the shutdown sequence to be in reverse order of the
setup path.

Also unload the nvme-fcloop after usage.

While at it also update the rdma stop_soft_rdma before the module
unloading for the same reasoning.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index ec0cc2d8d8cc..41f196b037d6 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -260,18 +260,20 @@ _cleanup_nvmet() {
 	shopt -u nullglob
 	trap SIGINT
 
-	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
-	if [[ "${nvme_trtype}" != "loop" ]]; then
-		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
-	fi
-	modprobe -rq nvmet 2>/dev/null
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		stop_soft_rdma
 	fi
 	if [[ "${nvme_trtype}" == "fc" ]]; then
 		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
 			        "${def_remote_wwnn}" "${def_remote_wwpn}"
+		modprobe -rq nvme-fcloop
 	fi
+
+	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
+	if [[ "${nvme_trtype}" != "loop" ]]; then
+		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
+	fi
+	modprobe -rq nvmet 2>/dev/null
 }
 
 _setup_nvmet() {
-- 
2.40.0


