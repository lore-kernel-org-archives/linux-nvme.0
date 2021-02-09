Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460BEC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE92264EB1
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE92264EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W+ntytpr78mI89g55p1+vgzDvLRw8ZJ5asbLjO15jP0=; b=pl+hToAYiBCW7QZwLJKltJl7X
	VUSUO8FN6szma+y8D6eHijVqOlDlmCoEZ13S41rbOFk3H87bor5+sdts2YdiN1LQaIxhzbpPFrE5P
	eRw4mYuQ5J82h8fzENNTTdJwEQzzO76huO7pZpAJadFs3wOJIBUZkn+86D3/rXySxp7/brghr3B08
	C/OEbi0+Egl1vk+ZBXgnViJSD/rRwT1SlmDlQXTqrrXAwhZDmV01hnor6NufY+lnNImkcXLV/1SAh
	xL1XCDQOQ9oH3uvBB4lY5zD0+EmUz2Lj2vZVJoRAvk0FCuSsZgn2WipUdqNVQ7IyZsDTSRWdu3Dis
	v8Tjkhjzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9KKb-0002tl-Je; Tue, 09 Feb 2021 04:08:53 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9KKX-0002sC-0U
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 04:08:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612843729; x=1644379729;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8HgtY4dj92AVnU2+p/DDCbUgzRAJ8cIO9IyKaVbUV1s=;
 b=LIn3d7XXEEl4LBqUjirQbJzsjWgSL1oO+yL2n+vUwfSdn/q4AgwyJl0x
 3ZPu3VrRwEXeAr/tZ73YFT0vD8USVsWBJZ2QCd5Nuzed+Nx/iQZi1Bsk4
 l52Eq2FVGZ+DdHAKi1kIiM9MgNjmunSfkvPTgwzHHeCqcUUvchj5yLgUA
 xF4nVTYizjFFIAV7O796EjCP4jYHxMBEXGwantgPXGkz8gS0p/BXAn/mA
 Kb/6RHu/ZQASphdktKvpGa9z7JT1RqYvdFx/JBaX3+0niyWULnwNPeZwN
 leLdPWuNWQmUlhHqh8akb/lATCYdofskzyZaMcKjDvLsKwMncZ2T4ssmX A==;
IronPort-SDR: NU2nAL1iVIZ33c4wF+qMYAs0YI7H2XndXm9Ym5LrX9nNJzfwR4t/0n7R1UqXEyVIimcp/S+0KB
 5pu7i1fXk0fzadYuFf9SoiJTqrjLsdDrci/ep3NRw1DFaBMDqRSCjTJXePseBssHwF57YZRDO0
 UjXfids3znhjqMKekNVsJGJbOTswDkP8NUwn/MaRfafmOSlCwAyhKdRJQhj5f7E8HCDg6gIf9C
 nWhOTw+b31UX4zApWhLClozm6dC6Ie/xarSWqABx/OKqXx3kvgyU/XBP9UTcNRZ+fqR1MXFN69
 Pb4=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; d="scan'208";a="269970516"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 12:08:48 +0800
IronPort-SDR: g4+jNvep3ov4ckUM/90bSgdNGCEGSMjvDRTETFyaNPD/rbvgrI6Y73sogk+hpp/OvLwU251Px6
 9tNWDdlhLpAceQSZVYbz0YYdw2TZHEVm+9jR1iFDiFqsTOYKSBjIchXON1C4LYhkw7nNLFilS5
 Q4nPJERV2ufF9g8nnb7TtAqi8DAx6WGGbL4ksbs/cpjEE9xfls0wOHZ21pZmRWZ5CuSfngIQkZ
 dw6AcVcfXhoLCrGBo7ZcZsbDLeexdN0crcotwdLB2MnfdydcI2C4/9c7RU7RvPb+RZv47XJ5TA
 3xVOR3NphPv+dLeVkf0x8hTQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 19:50:42 -0800
IronPort-SDR: frSYzLuFBNbDjQ4RK80ARGBrxu1d7qkNZh3pWsDLnQ9EiW/1ai5doYM7dTB8SOZnUzyBZnP5ST
 tnp8EqjRM8DiFm1kAzZJJ+mL8GAPwXtTplE50RLdLg8PxZrIQwWSECBHoWlRJJq+LgPd1S9Jvt
 QBFENR9mZzOT5B1zRMwSXna756geo9wqCSKjl7WPR5bwFsDB2ei3PgdVAfEeu29Fv7ng9TtPyw
 Xu4kqXmTmEc9AvvgC46ynznsplNio94gX2XFTV3fgt6j28QyAirMWPAhzShG5oAEsBmT+Spz9R
 21w=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2021 20:08:49 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 02/11] nvmet: return uniform error for invalid ns
Date: Mon,  8 Feb 2021 20:08:34 -0800
Message-Id: <20210209040843.45572-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
References: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_230849_210423_47FD8D7D 
X-CRM114-Status: GOOD (  13.51  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For nvmet_find_namespace() error case we have inconsistent error code
mapping in the function nvmet_get_smart_log_nsid() and
nvmet_set_feat_write_protect().

There is no point in retrying for the invalid namesapce from the host
side. Set the error code to the NVME_SC_INVALID_NS | NVME_SC_DNR which
matches what we have in nvmet_execute_identify_desclist().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index fa9a83541d51..d6a3ecf66262 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -82,7 +82,7 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		pr_err("Could not find namespace id : %d\n",
 				le32_to_cpu(req->cmd->get_log_page.nsid));
 		req->error_loc = offsetof(struct nvme_rw_command, nsid);
-		return NVME_SC_INVALID_NS;
+		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 	}
 
 	/* we don't have the right data for file backed ns */
@@ -704,7 +704,7 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->rw.nsid);
 	if (unlikely(!req->ns)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		return status;
+		return status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 	}
 
 	mutex_lock(&subsys->lock);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
