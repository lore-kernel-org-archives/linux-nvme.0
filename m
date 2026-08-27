Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D133BC61DC6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 13:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5K8HiGpe4pTl4e3/3UO5i3J1pMJi2AYfK6GebpRCy2g=; b=Xf76eMoYWIq2q3/s2B7pUozKCt
	+ppWTF3V/H/n/5VrvpL+/0rqKEXF0NduHNvjeR5I2hLBOm0ZpxSnHfNLjyAN8uuGA7gMwcw8brcqh
	j0wcD0qQeBJUDD+UyxYi9w0VWx6veoUKy7o10weAXdec1XcaSewgMp2EyYOguhDEqdjITZUdR0h0S
	NpC9WxZ9fJTOcJ7I3SzxpIznvieU0H1MRGlW+AwNsYnas+a0qjPLDxquPXWV/Cbm0z/m6sYhlC+6h
	2nQjIINuP5x6tdAtDI9vK1QJKyK9QJfaqHLmlDSKP5WMKMyEAfz1VKR2Rff2wuPWg8v9/GU9iRHQ2
	M6c/sG/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzZmt-000000041MR-0PKL;
	Thu, 27 Aug 2026 13:04:59 +0000
Received: from smtpbgeu2.qq.com ([18.194.254.142])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzZmm-000000041FN-0q0L
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 13:04:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787835852;
	bh=5K8HiGpe4pTl4e3/3UO5i3J1pMJi2AYfK6GebpRCy2g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=TyIGP7Bn5JvjlJSv9KJEuCXBJDqOOmb/ifICdKiPVZKmEE8baquWhbUE+tnIvyBu7
	 REngFbGFtlSLQLsigpRXaBLdSHmidrQe1jad87MR+sZrPiUBS5ZzcJNm6Gh04ZpzmL
	 jqYreiPVFB9Ddpo5NIvzJGCsksF40bFbVsXXtJ3g=
X-QQ-mid: esmtpgz15t1787835837te8da011d
X-QQ-Originating-IP: 5NWuQc8cQ++sHC19BBODe+OXEnWDkVuSNy8qkIGmp1I=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 21:03:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8434123566750053300
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: raoxu@uniontech.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH nvme-7.3 v2 3/4] nvme-fabrics: reuse string helper for subsystem NQN
Date: Thu, 27 Aug 2026 21:03:53 +0800
Message-ID: <2480D624F1D8ABC8+20260827130353.1390863-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <0D24A9A3F19DBCF9+20260827125710.1381672-1-raoxu@uniontech.com>
References: <0D24A9A3F19DBCF9+20260827125710.1381672-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OXWhkXa0b/rw9ftOf5B9qskYclDcj3ibk9fb+k1xV2jjEGFk0QaVM6ho
	zMTicCu1OLCZLW6GC2Glwte25aDEIBg4uBfFHqSUqWsT1cgV4r1mopcyeCq65wH8eW5YlRH
	lG/EesTLAzeTSQ/vGEkcdnNa0V28Lc0qTNxZoeeH/+jrf73sGccFXL3Ce+QQJKvegRy3NR2
	DgYs33f1qNJz3r705hUQPrBbFpSkEVrk4WRVPXRxefhXWmDSW9b3u1KCaoxlPfk8RpTbLGN
	Bxl9exa8ZfdaB3lM9nBLLM9+ZJ94Kl4+HCTexJg8HrohGuwGTEVZgiCxHhVgCT89aAJBItw
	vNifRWfuvl4ysuNPlbHuQgJSPUSUBWsHhdSGztgIMxk9tPengNpaJn+Ss7SNqsqagDRETGm
	uSHNucXbHpKijKQcyBx/XNw6632JkV/C5OuhWc1wJNOdC4GHVMoI9Dby/yap/mkDep/vaDw
	/JdWTN+FxoxPMSjCcqgYaP+7g38cD7F8nX7jmJeeUlJ+EzqJIkF+EEH1CHOgPLun0b6HPck
	gGUgxwHOPdJuNpkf2TbtFAZTUR5OTBb+Mi1F2lPXIXO97+oRPOAJs/PWfYe07zkVvEKlyov
	icEYfujhdHj9c/A4FyLKehUD9v7cZI6+8GTE/KS7dqp20FUNPlwOLYRJYSr0QY5h/B2Bd77
	BQDY2GbLOzq70CfNoiDNQPPKJWD35p0ZLppiXsXrImPJLAlOXWRBMkd49EgQB04fbScTzkg
	MyV0unpmEikok8EMIxKL9GSIoWuz+VKKvR1FA/UTe75+VXnt1Cl94QOrhKHqTr9CseyVb2T
	nJJyYu/Tc0VrnZmqgMQU34Xo07HTQrurna+hb6/Wu5xag9D3zPYwTCpVTCSPuKT+HckvwWX
	V6jEYFHD1rRhNKQ+7oTL6BT1JeiJMM3bUww0xyJCun47jO0TX4PmpJUI0pexpS/luLzBlMA
	drCrtswElq1ztDoz5pHACGubp21mPOHE15ZjRG42LaS/c+VpO0G+isIx0NO77t93IZ+88d6
	p6TjmTArfnCRzdHTk2WA02HoyPZZ/x+QbWQIPojwcUw4KzPjnq5o9LxF0Vb30Ze4eaHL2KI
	oVb4gEClT/W
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_060452_705290_C18B8F50 
X-CRM114-Status: GOOD (  11.49  )
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

The subsystem NQN starts with the same owned-string replacement sequence
as the direct string options handled by nvmf_parse_string_option():
duplicate the matched value, free the previously stored string, and
transfer ownership of the new allocation.

Reuse nvmf_parse_string_option() for that replacement only.  Leave the
existing NQN length validation and discovery-NQN update unchanged.  The
hostnqn and hostid parsing paths are also left untouched.

This removes another copy of the match_strdup(), free and
ownership-transfer sequence without introducing a dedicated helper or
changing option-specific logic.

No functional change is intended.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/nvme/host/fabrics.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index aab3fd279d0e..24385e777307 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -773,13 +773,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				goto out;
 			break;
 		case NVMF_OPT_NQN:
-			p = match_strdup(args);
-			if (!p) {
-				ret = -ENOMEM;
+			ret = nvmf_parse_string_option(args, &opts->subsysnqn);
+			if (ret)
 				goto out;
-			}
-			kfree(opts->subsysnqn);
-			opts->subsysnqn = p;
 			nqnlen = strlen(opts->subsysnqn);
 			if (nqnlen >= NVMF_NQN_SIZE) {
 				pr_err("%s needs to be < %d bytes\n",
-- 
2.50.1


