Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5569C433E2
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 23:54:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A134A20797
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 23:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1+m/rZsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A134A20797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RavDWvM9xhSv6TzRzwMJxWvyhd6o6RW+aANBv0rN3N4=; b=1+m/rZsEht0PM6brUFN6FB2t6
	J0gD3F3l0Uw0R8B5Khb8UXk1AZREb5HnFVvBGRZyYuBwTWyu89srFpKWOLMQhRr1l0xcSQpCexDFz
	UFU8/uLnWC3N6Fi0PyAMYrsXZZf3YZLW5S4DPEoYzHP0/8pAU2W9o4gyum9oJihHv7Ct8FsM4awvi
	28a5r7DwQSzd/aRWfGcH2rTCkR8x1g5R7mdQqid8I+zNH9/Ywq/rHFpPcYxFev8vFPIeL9p7Df5tq
	cvi8M8vvi6pC0W8ilokOwLe8TRBAfaEDE3xLuSGbCaw0AmbtF92rIzAsaCaXYiaVbbVIAI5usuNr8
	bkG/RUEiQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDz3S-0001uZ-D4; Thu, 03 Sep 2020 23:54:10 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDz3O-0001sU-P5
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 23:54:07 +0000
Received: by mail-wm1-f50.google.com with SMTP id o21so4489398wmc.0
 for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2020 16:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ltrSPPPBq2iV3S6trqwPo1lDRT0G76ooyJTQrnxziqc=;
 b=XcdjpUVFYK1uCRUtSkgzcODMQ804/0KPPptg+WxJlGjt4dGqVUfWOKPqDDEpSICTh+
 plBBVdZjVb5HL8dpOSAj6BHAmyPRJ7A0+QiQCQaDcXAclllZQFTHz/kfd/igN97XfAwy
 A9GUsBVkQlmwVWX6yfBzxZVo9RLrm/zySbhvOHJLIjJR1zWeGy8DcvAyxP0lr/Ltj3Rr
 FLRNyB69YaRYmdv0mKqPHfD1stEh8yHkZd2JXHCYlVWRWHKz1bXvCnJ/QIgT4z9m4D5o
 HJEtvQg8OqzEd4BDZbwNCAOg3wOw8JW+DVMpVh6oSFd587A23tJWJb1bqq9+joYB9VhU
 R5sg==
X-Gm-Message-State: AOAM532ltoXL8JR4mxCJWBFn0JsY51GRtJFxQnSFl2ViFU6GFHQ7kv6W
 nx9ZFGbiNMIqgLrnwSsQfhk=
X-Google-Smtp-Source: ABdhPJw7v5uApg6WNJrp3X9k/6FVzz/5nWXQhmx8P+LLD2jwXHGIQXfpMI2sU8EKSHH3jyWD2nu7pw==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr4881341wmb.11.1599177245452; 
 Thu, 03 Sep 2020 16:54:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
 by smtp.gmail.com with ESMTPSA id u17sm7024992wmm.4.2020.09.03.16.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 16:54:05 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org,
	Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v7 7/7] nvme: support rdma transport type
Date: Thu,  3 Sep 2020 16:53:37 -0700
Message-Id: <20200903235337.527880-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903235337.527880-1-sagi@grimberg.me>
References: <20200903235337.527880-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_195406_829434_38817E57 
X-CRM114-Status: GOOD (  12.51  )
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
Cc: Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 8df00e7d15d0..4c5b2e8edf0d 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -5,6 +5,7 @@
 # Test specific to NVMe devices
 
 . common/rc
+. common/multipath-over-rdma
 
 def_traddr="127.0.0.1"
 def_adrfam="ipv4"
@@ -25,6 +26,12 @@ _nvme_requires() {
 		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
 		_have_configfs
 		;;
+	rdma)
+		_have_modules nvmet nvme-core nvme-rdma nvmet-rdma
+		_have_configfs
+		_have_program rdma
+		_have_modules rdma_rxe || _have_modules siw
+		;;
 	*)
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
 		return 1
@@ -115,6 +122,9 @@ _cleanup_nvmet() {
 		modprobe -r nvmet-"${nvme_trtype}" 2>/dev/null
 	fi
 	modprobe -r nvmet 2>/dev/null
+	if [[ "${nvme_trtype}" == "rdma" ]]; then
+		stop_soft_rdma
+	fi
 }
 
 _setup_nvmet() {
@@ -124,6 +134,16 @@ _setup_nvmet() {
 		modprobe nvmet-"${nvme_trtype}"
 	fi
 	modprobe nvme-"${nvme_trtype}"
+	if [[ "${nvme_trtype}" == "rdma" ]]; then
+		start_soft_rdma
+		for i in $(rdma_network_interfaces)
+		do
+			ipv4_addr=$(get_ipv4_addr "$i")
+			if [ -n "${ipv4_addr}" ]; then
+				def_traddr=${ipv4_addr}
+			fi
+		done
+	fi
 }
 
 _nvme_disconnect_ctrl() {
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
