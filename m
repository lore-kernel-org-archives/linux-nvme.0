Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE08C5DF88
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 06:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Og0KyKIRcwcNWzL7sgxkQgCGnoXn4SlRvqhOs0v5iM=; b=byH62hlSSdmeA7jQMsidLZ2Er4
	FstWW8e5wrrf1a8wMqAUM/z5ebVRv/eY+C944CbkyILpfNMpQsJOAPdY55QHf5syuBbS6I+HmdsXx
	hFkIjSzzqOJp1lhlZkVkem0bZAIQNLu7Tu6euyKZwi87pOywaFyE1qgedhUSP/cdRDMZ6nO67PY2j
	YxA1S8gE5FQbCGjYQ4wtBV8xSWwIyKSLSDvG9DVmRLxdW264eQni6CbdEFxeCtXy3Sa8kqn82V0Kc
	P+bUrBlBwfkBZC/5KkkVHvdI3HJMNtAjYu12/kKThv0odIQAJRLcPcj8zBRgglcEhTra0xponI86X
	1gU9grrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxIhf-0000000Cbcq-3d9w;
	Fri, 21 Aug 2026 06:26:11 +0000
Received: from smtpbg151.qq.com ([18.169.211.239])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxIhd-0000000CbcK-1LXG
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 06:26:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787293518;
	bh=2Og0KyKIRcwcNWzL7sgxkQgCGnoXn4SlRvqhOs0v5iM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qUTfUQh9y+rxAjwZBz1Q6YNNKIdKdsu/jqwbiTPf6p/tiLRZcNvk22A0GUwKQwMJx
	 aBqQaW/wkgB2dlyddRhXiWTtT7+ExWhdGtaCpgcFd+5z2v8iees9RieMTN3ikgjcyc
	 t27+DoRBrymr0sM8zqStANQNn/Kzoy45QeLBHdwA=
X-QQ-mid: esmtpsz17t1787293501taaa2b643
X-QQ-Originating-IP: x6gQ2AWWWCoMIIX1SqhM5VE9JlsgiE9nPNywn4B4ONw=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 21 Aug 2026 14:24:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12837760092603042325
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: raoxu@uniontech.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH nvme-7.3 1/4] nvme-fabrics: separate option tokenizer pointer
Date: Fri, 21 Aug 2026 14:24:57 +0800
Message-ID: <646894DADB73C91B+20260821062457.1936240-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <29BB44C32FF06823+20260821062142.1932160-1-raoxu@uniontech.com>
References: <29BB44C32FF06823+20260821062142.1932160-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NY6OurWw+pG/6qFfGLuI/RXFs62eJn5XVz9UnMN0/wXnOhHD95P2Tfbu
	g1Z5gCedOvcQw1Q3BLka7R53wsV/nd9AjByiHawexro4SmXPwSz/os/BzNXFLEis8P1GELU
	DGrcgdJsq1Zuz7Kg99Cy2r80nCHekMZeSry2L99t6dslcLeMHzUesETNARjmB4/iyegAE/M
	UZjRz/xvworYZLZEcuEEY5PFmGTSckZhXfTLu+IUFN+x+fex5RN7udjUzbNy9+d4xfTqCVB
	Zg7oHO0O5bNzDuVYuBVNHUTnABQvxDxQ/9Ufyl2X0+e+xsvXU+9BlmtEPck7il0EgWpjEEW
	cBPF5T5hyb+KQQRQaSaixNv+CzbX8vDS25JHTReVlncGkIIZ1Dps4EUqkfiG0HFU1l7PtjD
	Nf6YY77gGLUnmBQfxFBJyth0ra0jRpZm7O5VML2fgqDB3oPsRr5IFvDemWSHkyOE9fZbJUg
	Usa/mxNuvOR5oY95vULPWXh2tNUkMdE4xwkDfpESFt278a19xhUz8NxRxSGr9fYT1A5cyCz
	NLa9dBVh510e1vAajuR+GaVM41QD+FxDrvt+vI/BVqdMk9GCVCYCuO0y4zxM77Ieq41Ppje
	HivdUaiKV6DMchSOChbHHmj8POg8wUOzPiBqYJ+DM+uUSmfyZjjh7xGbXH7pR99522sgU/n
	rCj/N3lb79h5wX6Ynv9hMRBPCxC2XCCYBq0yEHawHcGieWGg1hr2ZqN9Tc4ePjYuK8WtjqY
	rZAHpt06mMBM3Is6pa0aMdKKeRrCVwf2KQFEaIpmfszMoDu2m///JApLzMWDYZNjUXkYzdp
	s6LZPe4qUyi+idgnKOzPvai+S+BxEDC1t6u+Va21eTrmoJhToynLuimIKX1D3210ehQRKfy
	lNJ4eRzd3YAwHjpC/tOMvXBXLdVG1SskO7ZlwBK8/iXjxOTj5aAkbzuGq1qeiiwXW/AnWuu
	CTur47/cZJ8/iRgeQWcAjPDt02KNuyV/7cmZSGk1Q1l5WXbQWDSLqxixSopQmIB2rUwszSW
	S0j+zJjLA7o72fGemHH4ZxUocQ9BnFzvUFVhPZfQgMoIHE9CmJTgHD8ojPT7uWZXcqoth9u
	qGB2gFgWTCHddLf487ns0c=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_232609_835217_744FEAD3 
X-CRM114-Status: GOOD (  13.86  )
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

From: Xu Rao <raoxu@uniontech.com>

nvmf_parse_options() currently uses p both for the option returned by
strsep() and for strings allocated by match_strdup().  The former points
into the temporary options buffer while the latter owns a separate
allocation, so the same variable represents two different lifetimes.

Introduce option for the current string token passed to match_token().
The existing p variable is then used only for the duplicated string values
in this intermediate step and is removed as those allocations move into
helpers in the following patches.

The name option is intentional: options remains the backing buffer for the
full request, option is one comma/newline-delimited entry, and token names
the integer result returned by match_token().

This is a mechanical preparation with no functional change.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/nvme/host/fabrics.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 59f823dfbbcc..1ec6da49167d 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -716,7 +716,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		const char *buf)
 {
 	substring_t args[MAX_OPT_ARGS];
-	char *options, *o, *p;
+	char *options, *o, *option, *p;
 	int token, ret = 0;
 	size_t nqnlen  = 0;
 	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
@@ -747,11 +747,11 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	uuid_copy(&hostid, &nvmf_default_host->id);
 	strscpy(hostnqn, nvmf_default_host->nqn, NVMF_NQN_SIZE);
 
-	while ((p = strsep(&o, ",\n")) != NULL) {
-		if (!*p)
+	while ((option = strsep(&o, ",\n")) != NULL) {
+		if (!*option)
 			continue;
 
-		token = match_token(p, opt_tokens, args);
+		token = match_token(option, opt_tokens, args);
 		opts->mask |= token;
 		switch (token) {
 		case NVMF_OPT_TRANSPORT:
@@ -1068,7 +1068,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
-				p);
+				option);
 			ret = -EINVAL;
 			goto out;
 		}
-- 
2.50.1


