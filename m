Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68261C48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 19:10:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3437A611EE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 19:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3437A611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cl4vZGwfxmbwNgZMmzKpHyYtpGSuezilW3J47XWlt98=; b=FXQ+S1BeYwmKB+
	C9kz/31F4+8GFtxWU4Uo58dYDDtZZzXsxie/pMmQslglu2h9O1hOyftzosBIQTNoalabiCyzFy6tw
	ChxMGIEDsqP5hfsi0O4M84iq3s9TRHWe1dZghqlWM/gw23a1Mn6NGfD76csYrzmMX33W4JAq6sKOD
	k4yTNGYQ6yD0w5gGaC+8inOVECMxPTl9dzMWWBfRGpDLTznT2Je0o760smyazOQ8uTiB17zs3EuZA
	IIfQQgX4oNbpWFLCzAv4VFlL+Fv1YMpf6MpIQnw9SOj7qpbn/HYhUpGhiJgmSPuL7sd7WvbJFAiQM
	GmEmM4abfHE326bdzf9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltERY-002L7S-VV; Tue, 15 Jun 2021 19:09:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9PS-000DwX-8r
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:47:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Ueg3kDxSiwqsOvbcS9kViZid1EQPKE0x5B5JsQfQ8v8=; b=HgPWVNJr5ZKxpX7YC7JnoYGzjl
 xA/wN1fnO4HxduxfNqVH7dzw7Sow6RzB6ci7LOoOX8t3F6vCQXFpSGAVxqxC+l+3c7gmTIOP6jUZM
 +cUlOfV1nKurU0jzpmDxAnAQIlqACQKWrRPfm/6U+Viq4n6OGEM9KIBUQCdypDlaqv90Et4BFw5MV
 P2za44yTuWON8WYISqI+qOn3NJ9Ncw8BnhYwllrBeBiWUq/2pVqWeSnGokYESx3mxuw7nbkMLiqi7
 8WkyF5BbDsMqRyde7TlGlMpbZrx8hKKpULRVt6AJhc157LSEpZcXN0hLn+qpEhXQO3YUfpxdxX1fJ
 V2ABsw+w==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsz66-007H9T-Pv
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 02:46:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623725206; x=1655261206;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4SdXQJvvZBHF6CtON5DSe7v7F9HKny9TeHzHIZSbSYw=;
 b=V+HdYpASsRVMv8iFXKJqPGt0FKezSLph/ouDZQrZai3ME28cJjv78jkc
 kmxnkMVJo/wnewsqZfe5CSs1/U93gB/hMPozQVYyL6ZegWg5P6eFDSezN
 tjda6PgXJSabrjPEtSgHcFFI14SN0/UWATPKhVA1XukPlawpTDsA8PLgb
 IQaqaLT65DdKgYpFr2WjjhHew5TJcPE+d2utwgnjVGVI5mrw0AwhQ7cTA
 FVtwlgh+Bu3/pUsyj8ZyBKttik8JZOGO7gGbhKmCizSf5PENG9amaJU3G
 qI6bsuZ1x6/kndVQ5uxSCC1iMph9GRzY7unmABqeyRV9hhG4ZMDjtgeSw A==;
IronPort-SDR: wBpFGbqmcwTyCh6Eh04EuHzHWikOaq8geHACmHMsJocY02qwBOLcU2LH/34CUE2hETjMbpfwkj
 fwJm317ADLg0AWxTHZO2u+A+FPlp++z20WucTlQ8Z/qYv9KG3VDskY5h+FrKNGtwhDi49EvuNW
 dI4J3LTOH1LUPOlGDtifz9zrhjD4GwBXkmdQpxo6u0ufJXCeBZZU3hj2MROHvxGcFY15V7f6iY
 pNek2r6esd1N1UezK8nAJ3z+R1hYymwb4rify/cS/udGaoID8K5viBCCc/cSe4OU4z0ezQSVeE
 00M=
X-IronPort-AV: E=Sophos;i="5.83,273,1616428800"; d="scan'208";a="172471600"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 10:46:43 +0800
IronPort-SDR: IW7svOUd3Eehmo2Qqfw+nQL7bim+AYwZnt/2uZ1sRNmic1DXMO2kMLkERQr3kTTNkiA3BvDAri
 P4uUP8dlLEMONqi2KzOUeVCqetPzzyPpFcg8wFCpzXT//EtPJMz5B4h+nPgixvV84ei7lu7R1L
 qmxVOouihFrc/uxdF6g0alxQnlpSLnyYtqAL9PSybsNBre9E2EkpP4BYPy/gkeM3iijvTnsGjw
 2mR01jXnpWbYh34TTy8ivPTcDzqpF+cJj5tf1yd6hlHxuFAHk2GMKVS1Az4UDyvZVtnyH5Li8v
 3ro+8mWHM3q8JrdS2b8jToSp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2021 19:25:38 -0700
IronPort-SDR: Pz0SjRuXFDjThWy/I8VF6BexQ9gqswK8FYRVBbz0cva3c5txZgaUKvYJl3B4++a1akcSgZsGME
 1YALKn4QAMY7vmDpysMXmm4QkwBi042DfKC9fILpi+Fdd1njHKs0Lq5AZ/21Zh6nuvQJspdq4S
 ibOJkohUul0WHPvSEFyCuBZ6NHope9IVYEbPKLWpgipbmDHxQ+zUoJRL6uEbrMbT2H/T7z3v7V
 4fv9e9dYhpi7K8KXHyrqfTAxXenx5fD7CnAnW2MbREKXcCfODKmGHLH7901fhwZC/QZmO+d08O
 70U=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Jun 2021 19:46:42 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 4/4] nvme-fabrics: remove memset in connect io q
Date: Mon, 14 Jun 2021 19:45:54 -0700
Message-Id: <20210615024554.42585-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210615024554.42585-1-chaitanya.kulkarni@wdc.com>
References: <20210615024554.42585-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_034646_572988_1E9F24BE 
X-CRM114-Status: GOOD (  12.56  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Declare and initialize structure variable to the zero values so that we
can get rid of the zeroout memset call.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/fabrics.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 86a1a05de71b..b13b42bf2074 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -421,12 +421,11 @@ EXPORT_SYMBOL_GPL(nvmf_connect_admin_queue);
  */
 int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid, bool poll)
 {
-	struct nvme_command cmd;
+	struct nvme_command cmd = { };
 	struct nvmf_connect_data *data;
 	union nvme_result res;
 	int ret;
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.connect.opcode = nvme_fabrics_command;
 	cmd.connect.fctype = nvme_fabrics_type_connect;
 	cmd.connect.qid = cpu_to_le16(qid);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
