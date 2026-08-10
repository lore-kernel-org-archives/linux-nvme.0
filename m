Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D67C5AD7B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 15:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BNodjtQH7IlveO3WSomvbpCtk9E9m0/5G10f1oMrYyA=; b=hhvjdjRSKn3GyuYtLO30Wg/Yna
	tmlohpz45SXgaD1NoZPSdQjrqBqpMtgAw4aNjy24XFSOab+01BDOi1XgYBLUYCQ32m2W0k9C/pUHu
	ynwMvojQxPLz57TGDlHmV8+k38voqCVzneeI4PWD5Z/TTFU4jV18xeCKH6OFgmoS8hOpHpUSF+pwZ
	fHH8SyGvRSNGIqW1rd55NeLaHIcj3+BIfEJSLjg+fECHHWzUHI9VsEH3Op0320i+joGsTEKXniDkR
	jz+hw9AjmkyANR2f//Ic4WbMBkoSXtJ5bYHidwxWLVB4rbknyyz3Geq/N08xpVFDzTWahLXp6Z7Fg
	oZ7TMeuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtSNk-0000000CJzQ-22uC;
	Mon, 10 Aug 2026 15:57:44 +0000
Received: from oss.cyber.gouv.fr ([51.159.188.251])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtSNh-0000000CJt4-2nAk
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 15:57:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BNodjtQH7IlveO3WSomvbpCtk9E9m0/5G10f1oMrYyA=; b=cG83vF4u0AROlOz7+89wosLB+U
	h7DV7vxjKYDZdgTvQuZE1YFuVFORjozgGlexDirSpgiwQDNoQcxfPVZMeRmzpT8xmpt7qqvc9vc5Z
	QqiCpLp8h7QuoIY/nykACk9L147iH6FhQSg0YtS9YKVQQqS9W8Vke1Lo6OUDhru2f+Jf5lO6EnLZ6
	sxh/LECMdM+xjmzwq34Qx89hPzx34+uFkWyRfMVToHLQavgTawqHlbOdAxn73aIpec7bo9ESejeFr
	BXNiSPl2TvStYv2AoezY27SCbHlNEM5yyI29RBiXBJYCSCwX9Rgv6/8Q8hz0qr9amm4lEhZ0Y/XAn
	MrHHgM/A==;
Received: from [151.115.150.205] (port=47312 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wtSMx-0000000F8nT-24hW;
	Mon, 10 Aug 2026 17:56:55 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-auth: reject overlong negotiate identifier lists
Date: Mon, 10 Aug 2026 15:56:15 +0000
Message-ID: <20260810155615.3269409-1-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_085741_843851_64E1AFB6 
X-CRM114-Status: UNSURE (   6.26  )
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

The DH-HMAC-CHAP NEGOTIATE descriptor carries separate lengths for the
hash and DH identifier lists, but each list occupies a fixed 30-byte half
of idlist[]. nvmet_auth_negotiate() uses halen and dhlen from the wire as
loop bounds without validating them, so a remote initiator can make the
target read past the 72-byte request buffer. KASAN reports a 
slab-out-of-bounds read in nvmet_execute_auth_send().

Reject list lengths above the protocol maxima before either loop
indexes idlist[].

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 45820a12750d..8679d5db4f86 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -71,6 +71,12 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 	    NVME_AUTH_DHCHAP_AUTH_ID)
 		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 
+	if (data->auth_protocol[0].dhchap.halen >
+	    NVME_AUTH_DHCHAP_MAX_HASH_IDS ||
+	    data->auth_protocol[0].dhchap.dhlen >
+	    NVME_AUTH_DHCHAP_MAX_DH_IDS)
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
 	for (i = 0; i < data->auth_protocol[0].dhchap.halen; i++) {
 		u8 host_hmac_id = data->auth_protocol[0].dhchap.idlist[i];
 
-- 
2.47.3


