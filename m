Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6332C5CFDB
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 08:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FsK82zLoihOzNzCCzhnE18GOgCUk0CsnxHxsOwJz4To=; b=EGSlEZv0ID2Ec+JRu+JD/SVnNO
	VLvyy+zxLyBc+SGYttQ1QZk+ek/25JbMgnGe9MiD8d3T7Rl/u1ONrBgAQuJu9tsckiOz4knKYtq6/
	0oyvHdiqA12kW+8kivExr+OQCRpjpGyTRcVlSQMLyc6eXMqnZUxYzP3O7ptlf7H9Xn6q9uEId9xxj
	CSNqgvSDG7WLgBYQUg2flTQ2A+ObO0+bmFPLrZb9TR4IWBDdZrLenYeH5I+nxy+RvqwG5S6eD5ddF
	cErF69Ih5p9wOstxIsxzoCK54ClWc8EV1S3kb47NTfUpUXJMFc94fcS/kf/lfWLcv2M4Ih/K1jwBG
	FH5k+Z8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuQrA-000000008xC-3DvA;
	Thu, 13 Aug 2026 08:32:08 +0000
Received: from smtpbguseast3.qq.com ([54.243.244.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuQr7-000000008uU-2nZP
	for linux-nvme@lists.infradead.org;
	Thu, 13 Aug 2026 08:32:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786609878;
	bh=FsK82zLoihOzNzCCzhnE18GOgCUk0CsnxHxsOwJz4To=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GqKm6EEpWuoEAOVTqYVtQ8K2XPp6oUROFLOHwhTKzwBDPZsw26YsTQZ0LScJo/TlM
	 oKdjbRNYJUI9rKQp/wRe060pdrdmqq7lsYdIu0OlwoXtOJQvBsRUkyieqOJLIJKKZ7
	 5jlnOIJdP2bFhk/utTUVtioxDQk45BsLKRfuh9LI=
X-QQ-mid: zesmtpsz9t1786609872t1c992285
X-QQ-Originating-IP: qYLxKK4Z842EZ2046ZmAwKA+dtehy34NMw2WWW86RUE=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Aug 2026 16:31:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8233363820908336347
EX-QQ-RecipientCnt: 8
From: raoxu <raoxu@uniontech.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] nvme-fabrics: fix DHCHAP secret leak on parse failure
Date: Thu, 13 Aug 2026 16:31:07 +0800
Message-ID: <66356C8F993780EC+20260813083107.2078333-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mw6VipVQapeuSjZLBmmPX3Ay9v6K25LxTp8baBgnZijwCJrqD2oZbnAg
	VjeocnKd9VkN1Kx1D+ox4aIX8gjfu2WaFfiaRrJGD9k3lUZ32YdEWBGUPcvmZ2XWt0oj8tM
	LNRynidjV/a9Ksqm3A+/XfcbpylDm99n9Ljkv7NaZlkGBCjMM1i2dVgoILmD8SMjAYYfP/K
	+5GChtynw4Vn+Fub6Q4AKH6LYGE3reRxZAD9UsGweAryHERUNC/GeR0oQqMk2JzQ4xamn7w
	MDbDVjaUbnblOHv6r0W4e0fdQWYr+A3FWL7BUKuAlXRDuukXndASnF4RqAh4E1p4Sc1NPn9
	i4+daQTxKmJpzlMA/RPzEsqwHeKnOZcw/Gv1yQz23lb6w1VpEQtkBLn7mNrlnu2AXTICnBr
	c8krQj5H+FAzk2XFHCYm6XZVJ5diPVPthTUyl/SrMTpDhsQlA7jkf/UA3eEMkNSNtxqahNn
	WAu+7zWwLW3AKGII5jD8cqidxIb79jJJn00WiWfOxA82WFoDZdCbZhv73ZDo6us5IooZjcD
	sOx4q5BEkmkyAZnwQDTv8cMAbJ7o0a3+pLKFo8VFt98bUmlkUmVItP63LEN7J2fsdK/AKHt
	nKHpIECVgvzzekDe4O50KmhGTd8AQDPPluqYHQpFmYERmEleghsaPtlad0DJQKVY02n0WeF
	xRpY0UFXGXedt1Z/lew1LVx9bVZLQ+iDz/qkkzAw9kMtpDLZiRb4RAQPVLOmK/rcd4M8JGP
	o8mIDNJljjK42iHgFR9uPiqfuk4hm+N1X/r2i3qnr3LUKCrj9PmP8UWU9I/jm8eka7bhnwp
	iMtcxHA0CaD0ALoZiSmF3ByWDpHH9FpjebVXJug3yRFLf69tfIdmoJdCG+9lUSh/dmSsRfV
	3jcvXD+ptXnSFM9IyiTWv9Q91G+AbV1yo/JI8uVkk/eYiTgocsCtkX8/clg5i7XxEJJm/04
	99T08kRTUn+ik+9DasNzo/QWHvl+yaV7XX6iI+4m6GOdJwinntNxZxeAHD+izsw12PhmFZB
	gGKMVpDFJ/C0E5yEmSjZUWRXHMYtZqWqim+eJZeMzQcYpegDs+
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_013206_190529_EC3ACADD 
X-CRM114-Status: UNSURE (   8.76  )
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

From: Xu Rao <raoxu@uniontech.com>

nvmf_parse_options() duplicates dhchap_secret and dhchap_ctrl_secret
with match_strdup() before validating the DHHC-1: representation.

If validation fails, the parser returns -EINVAL before the temporary
string in p is assigned to opts->dhchap_secret or
opts->dhchap_ctrl_secret. nvmf_create_ctrl() subsequently frees opts,
but nvmf_free_options() cannot release the unassigned temporary string.
Each rejected option therefore leaks one allocation.

This is easy to miss because valid secrets transfer ownership to opts
and are freed normally, while the malformed-secret path still returns
the expected -EINVAL to userspace.

With CONFIG_NVME_HOST_AUTH enabled, the leak is reachable before the
required-option checks and transport lookup. No NVMe-oF target or
working transport connection is required; for example, repeatedly
writing

	dhchap_secret=BAD

or

	dhchap_ctrl_secret=BAD

to /dev/nvme-fabrics deterministically takes the leaking parse path.

Free the temporary string before leaving both validation error paths.
Use kfree_sensitive() because the copied option may contain secret
material even when its representation is rejected, matching the
sensitive cleanup used for stored DHCHAP secrets.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/nvme/host/fabrics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ac3d4f400601..736570b5fb34 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1028,6 +1028,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
 				pr_err("Invalid DH-CHAP secret %s\n", p);
+				kfree_sensitive(p);
 				ret = -EINVAL;
 				goto out;
 			}
@@ -1042,6 +1043,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
 				pr_err("Invalid DH-CHAP secret %s\n", p);
+				kfree_sensitive(p);
 				ret = -EINVAL;
 				goto out;
 			}
--
2.50.1


