Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE35C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:34:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140F523435
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140F523435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+f5k5LSUFa4wG6yU6K2NzqPJ2iV4VGnaqzNsr4RKc0M=; b=bNfDzS0ELeic1n9oZ9eT3qEQU
	YkRiKc+3pV8SwCxMJgOF2R28da8LZcQQjjUuaT/rEsJbK0RXjuN2if+r3ubRM4l8kHkNvXvOoWlLJ
	x4jPJlVGXA73Bwk1b9vhSEQBdWmDkdiaSp9pRUgw5ZDF7W/cM2m3XkIXooaRarXfc59k0ET6PN+FB
	q/dJTJ5YPMC3LD35hQwEa74NzOi59xiiUKT273BtyfNgEs5kMybrGMfYnlTTmFqA2/O2WKDBuVpfk
	temZDl7mha6qNUcMi0HOFe3Vp6aFtdTjNXBvq7KBiW1rOzoNdYCSKZuBxXgEmCNOUKtLXkltt/3NK
	WwUARV9eg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzrWd-0006g4-Mg; Thu, 14 Jan 2021 01:34:11 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzrWa-0006f8-OP
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 01:34:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610588048; x=1642124048;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ynQdsrGGRUND0p/MEOjZs7t09Mz+4gXZKnIDR+Dmzh4=;
 b=Uuc4rdtoWliFVA9kAyl/Xo8KtvLwy3Ol1tv/9xicPS6MS180aBeDvVrV
 kJgglw1feR4JRht7KFYT5ZZkMdip5kQJ4iYK00iwsTmo6S7JUk+G8geTV
 zpt6rmbx6k9cmGzV61QocDV0Yw18SIiMoa1AkYFw59TiqIWAq6tWN3Mzl
 YWkG6JK7JVlfFafgfs+RmOQYE2JInBXb0nXTAQ537PQfJDRpMxFSeiTD7
 j53bMC4axl2l+mDFKnY3L/l5f0qA1tVg7YuembKWmhLNPUmQoJBHGDReI
 Djrs5ov2rlcyFpGJNAzl+rw1kwet+r5dLFfYTV5vBVMtF4YK9NGrNgtA4 w==;
IronPort-SDR: I4FKudyrtkCN2ZDZZ2xueDvkbmyjpPpKfF56bKORXwS7/QWZKKk1pBY9PBVgiFc6foqNYZplVd
 Z6fgKO/aoi9Tx3qZIjlK1vhzqfEVsGyxsI6QYP/4dGFMhiiEuuI3xUrhpNasA56WB89kA31m28
 OGvkV8qlfObrgynps4Kopx8u5fc1nrQ4/mJHvo0zPd4KhSD6jMo5lS4/nLnqnLNmj17w0LpDIo
 jw3loL9PIdg1+4XsfPdixq6Zzvpb7QkLYJ6Gr9olK2S4eH1rKHYyMK0ZxiqM4xJ1V3kYtvxQXJ
 C+U=
X-IronPort-AV: E=Sophos;i="5.79,345,1602518400"; d="scan'208";a="161817977"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2021 09:34:06 +0800
IronPort-SDR: KS/s7ZrX1gCqGMDQcMmvIcZ9qoGgFXVIGgFKylM+Bjd8rax2tcfIT2EKN4eXP2X4EMgBpDmmuI
 F2y5Glp332BvtUkhPnYliuMcB+c2X7jhyPxC9CXkbU4FQvZZn0zlz/+pL/brr+Z//BGdQ31dy/
 fpgMmF2KPjJBCbweqOwAujMZ2pmERsh1XHY3bBZcLB5JK4QZA1OPyAsOVCMCsYqcRjNu4+oKav
 4r75RHNWCl0eRqqAvomG9k+g1YZgaHiRbxLuad+sHrfU1PsSvHjJ4fohETn4gqO6PkwG1NGbMu
 gKNA2EC2jI+DTH1G+VJOU4nQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 17:18:49 -0800
IronPort-SDR: D+yFKsMUZeNNLvSyEddRtkykQSs2zY3Cw8E9yswQWhOdMELlbwD9X3aSeJqc90MscqaaUYKDYi
 gZTyvHQeLMojjQR1s9k4/8xcgJ1P55mZuWZTEj+Kt/9NXl3ZZw6ARhiPX8Kj6ZebQsT5B41z3W
 Y34AyPOKKz+mEEBHcEYoouNF6ib8Ybkfz3WtZPeZuhzwHhFB+0mB1b2ns29K5h8SoRMEkNc21J
 e1rPmM0jfHcgiLiaewyoXCPnf1doAl7dOnEr9kTcMZCA2H0GIX1ndqHQHV8d+BhljkNEc6MIN/
 Sv4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jan 2021 17:34:06 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 1/4] nvmet: set right status on error in id-ns handler
Date: Wed, 13 Jan 2021 17:33:51 -0800
Message-Id: <20210114013354.33946-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210114013354.33946-1-chaitanya.kulkarni@wdc.com>
References: <20210114013354.33946-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_203409_021104_AA782F7A 
X-CRM114-Status: GOOD (  14.86  )
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

The function nvmet_execute_identify_ns() doesn't set the status if call
to nvmet_find_namespace() fails. In that case we set the status of the
request to the value return by the nvmet_copy_sgl().

Set the status to NVME_SC_INVALID_NS and adjust the code such that
request will have the right status on nvmet_find_namespace() failure.

Without this patch :-
NVME Identify Namespace 3:
nsze    : 0
ncap    : 0
nuse    : 0
nsfeat  : 0
nlbaf   : 0
flbas   : 0
mc      : 0
dpc     : 0
dps     : 0
nmic    : 0
rescap  : 0
fpi     : 0
dlfeat  : 0
nawun   : 0
nawupf  : 0
nacwu   : 0
nabsn   : 0
nabo    : 0
nabspf  : 0
noiob   : 0
nvmcap  : 0
mssrl   : 0
mcl     : 0
msrc    : 0
nsattr	: 0
nvmsetid: 0
anagrpid: 0
endgid  : 0
nguid   : 00000000000000000000000000000000
eui64   : 0000000000000000
lbaf  0 : ms:0   lbads:0  rp:0 (in use)

With this patch-series :-
feb3b88b501e (HEAD -> nvme-5.11) nvmet: remove extra variable in identify ns
6302aa67210a nvmet: remove extra variable in id-desclist
ed57951da453 nvmet: remove extra variable in smart log nsid
be384b8c24dc nvmet: set right status on error in id-ns handler

NVMe status: INVALID_NS: The namespace or the format of that namespace is invalid(0xb)

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 8d90235e4fcc..dc1ea468b182 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -487,8 +487,10 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	/* return an all zeroed buffer if we can't find an active namespace */
 	ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
-	if (!ns)
+	if (!ns) {
+		status = NVME_SC_INVALID_NS;
 		goto done;
+	}
 
 	nvmet_ns_revalidate(ns);
 
@@ -541,7 +543,9 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		id->nsattr |= (1 << 0);
 	nvmet_put_namespace(ns);
 done:
-	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+	if (!status)
+		status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+
 	kfree(id);
 out:
 	nvmet_req_complete(req, status);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
