Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F61C54FB9
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Nov 2023 12:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FvikrfSP7KyI3MddKvYF8CTdBrKXvMYvbbpZ1Q4JQmg=; b=cxqeyAxeuzCagKFCrhbmu8ixYR
	0upaJc23R35hq09qmyTPjjZXByP+V5YsIXQRVMPxQi/8kb3eX+iKmokK9SbM61O9nUz+nxFtWjGqL
	c5GEUSRSq3YfcfHT3T8NB+DOjau8j51NEcMIIjlCtQo1lEIgkf8CcPoZZ1PV1Gjsv1GMXd0oPJibK
	VIatEuaOJIewQoP9jIVhDTZYRX460cGaQLo9uxDX3EnEwqmtBIIkX8txBkyyrFbIz+XQZaMaJJoO5
	Y97FQ+uMotwLdnfQx5s+bb+VkBVmXjLefi7wiV29dq4PkSA+pepirnllL53Uc8d2vs88ZpVVxJxip
	PXmBcKBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3bGg-003SIL-2c;
	Thu, 16 Nov 2023 12:14:46 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3bGe-003SHb-1C
	for linux-nvme@lists.infradead.org;
	Thu, 16 Nov 2023 12:14:45 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 4BE6022947;
	Thu, 16 Nov 2023 12:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700136880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FvikrfSP7KyI3MddKvYF8CTdBrKXvMYvbbpZ1Q4JQmg=;
	b=mSeO/XPIEmXkE7TmrxmC0pPj5TC1BwT5NLOQhn6B7ktjc4UAT2MDoa0I6/8lucKXuLKWii
	0P3+dMc5c3hV8FAaVxpG8DPMaBeyh+Nx4YTX5kRYq/ULnEFBqNis6tkz8/EZzhlLnWrg6x
	MRgPfBKpSbFGOEAChaPMO5IHJbpWllA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700136880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FvikrfSP7KyI3MddKvYF8CTdBrKXvMYvbbpZ1Q4JQmg=;
	b=CLscRgV6eJsLvP1xq9NnxVbqy2Pvs1TzF4LLTop3EhEYDgcGpLp/G1nammE4A0VfeiTmG4
	N/Py+rpXq7PPU5BA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 2FCE52D2AC;
	Thu, 16 Nov 2023 12:14:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 2FCD751ED477; Thu, 16 Nov 2023 13:14:40 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCHv2] nvme: blank out authentication fabrics options if not configured
Date: Thu, 16 Nov 2023 13:14:35 +0100
Message-Id: <20231116121435.17340-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [18.79 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Queue-Id: 4BE6022947
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231116_041444_552866_A8CE8F4E 
X-CRM114-Status: UNSURE (   9.48  )
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

If the config option NVME_HOST_AUTH is not selected we should not
accept the corresponding fabrics options. This allows userspace
to detect if NVMe authentication has been enabled for the kernel.

Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fabrics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 4673ead69c5f..aa88606a44c4 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -667,8 +667,10 @@ static const match_table_t opt_tokens = {
 #endif
 	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
 	{ NVMF_OPT_DISCOVERY,		"discovery"		},
+#ifdef CONFIG_NVME_HOST_AUTH
 	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
 	{ NVMF_OPT_DHCHAP_CTRL_SECRET,	"dhchap_ctrl_secret=%s"	},
+#endif
 #ifdef CONFIG_NVME_TCP_TLS
 	{ NVMF_OPT_TLS,			"tls"			},
 #endif
-- 
2.35.3


