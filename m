Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99CFC7618A
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 17:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pMD9ixsux8xFtQAIy1+dhWw9Gg9wlOPj7SLDCfeELp0=; b=Vy5ibtMeyFu+NO2AYhbBz0eHwk
	M1zziSnrDHiZw/xQspGzhT7z3GQAnf6VIfOtTNlJtZhjsTbvg/9VY05fcu9z/hOkelbRRpxn6U/hI
	C2DAHtHvGJbywlgXkfqNhZvEgmPneaPIkmg0IvWIsi3cmSK0haoj40Xv2XqOnum0Pauis90gMIPOA
	BB8J9p3hzy03nvTY3c2U31Qh5X4SdFNtxc54198CMcNDwGHKicz8jcJWIEomxc9TBhhShtCjZX4jY
	76R8IgkNnFBP/FYOG278Jq11TW9nj3UW1a6lN1/WZKv4QaMi9eT0NPU/Rjg1Mdj8WpSr/zvPU7LTt
	fV4JcFkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peJSi-00A0DG-1y;
	Mon, 20 Mar 2023 17:38:24 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peJSf-00A0Bt-1n
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 17:38:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E66C8219FB;
	Mon, 20 Mar 2023 17:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679333897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMD9ixsux8xFtQAIy1+dhWw9Gg9wlOPj7SLDCfeELp0=;
	b=CzE3HNm28KzEdIuxADFzZFAlgcUvfi09ajKwMN/2IHplN4dO3l9VXGLWPSN4lipytKU3sr
	zNoJy7ajAMxxVL+jnq7DJzCj1rRc+oUKCPZrRib++J2S9Y/42tEyi5VB7QbP/fsS7zOZ44
	KDdhxgeqlS9ConWINWTAuMCE2IWk1X8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679333897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMD9ixsux8xFtQAIy1+dhWw9Gg9wlOPj7SLDCfeELp0=;
	b=If3vRFapnKJ0my+1R3d0R5zMTa/Hw0L0rt6PlH3WxYtWEZi2WmTdYlW+coLoP6lOSDmmT/
	bG4JkRbxPcABqTBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6FDD13A00;
	Mon, 20 Mar 2023 17:38:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 1n1ENAmaGGSsEQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 20 Mar 2023 17:38:17 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 1/2] nvme/rc: Parse optional arguments in _nvme_connect_subsys()
Date: Mon, 20 Mar 2023 18:38:05 +0100
Message-Id: <20230320173806.12784-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230320173806.12784-1-dwagner@suse.de>
References: <20230320152204.g27a6jqbb65xmb6r@carbon.lan>
 <20230320173806.12784-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_103821_738872_5FDFCF3D 
X-CRM114-Status: UNSURE (   9.92  )
X-CRM114-Notice: Please train this message.
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

Extend the nvme_connect_subsys() function to parse optional arguments.
This avoids that all test have to pass in always all arguments.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 210a82aea384..8f4b4601c44e 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -316,6 +316,42 @@ _nvme_disconnect_subsys() {
 }
 
 _nvme_connect_subsys() {
+	local positional_args=()
+
+	local nr_io_queues=""
+	local nr_write_queues=""
+	local nr_poll_queues=""
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			-i|--nr-io-queues)
+				nr_io_queues="$2"
+				shift
+				shift
+				;;
+			-W|--nr-write-queues)
+				nr_write_queues="$2"
+				shift
+				shift
+				;;
+			-P|--nr-poll-queues)
+				nr_poll_queues="$2"
+				shift
+				shift
+				;;
+			-*|--*)
+				echo "Unknown option $1"
+				exit 1
+				;;
+			*)
+				positional_args+=("$1")
+				shift
+				;;
+		esac
+	done
+
+	set -- "${positional_args[@]}"
+
 	local trtype="$1"
 	local subsysnqn="$2"
 	local traddr="${3:-$def_traddr}"
@@ -344,6 +380,16 @@ _nvme_connect_subsys() {
 	if [[ -n "${ctrlkey}" ]]; then
 		ARGS+=(--dhchap-ctrl-secret="${ctrlkey}")
 	fi
+	if [[ -n "${nr_io_queues}" ]]; then
+		ARGS+=(--nr-io-queues="${nr_io_queues}")
+	fi
+	if [[ -n "${nr_write_queues}" ]]; then
+		ARGS+=(--nr-write-queues="${nr_write_queues}")
+	fi
+	if [[ -n "${nr_poll_queues}" ]]; then
+		ARGS+=(--nr-poll-queues="${nr_poll_queues}")
+	fi
+
 	nvme connect "${ARGS[@]}" 2> /dev/null
 }
 
-- 
2.40.0


