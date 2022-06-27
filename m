Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1122AC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 11:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r24a/WtFP4+qP+RfIM4becT+F+UWj3fzztTUVKoGkYI=; b=ohuAbo5l+d0zLLU8+771kqQ4zw
	33lg6dXlPI/Wub4ly85L6AzhbL9mCH4c2GSPFrocr0+eRNeE/hMm9+dk68JQTomFKRc1z9bJk5j7G
	4QAbTKk8DH/oUQTnOKzvN08wNtQrTgvkCJkCxWkMalOto/ynDvt56VKZguQ0BVNcXmfixL7EdX99m
	V8B2uMCVRCGKXkY7FhnRorEdKUnRXyQVy/KuRm0PG5op0eqKUS5Zz9nktcpktMtSxr177m//5tufM
	ArqZvT4XC9t19A2zWRBeRZmfkmi4TRzEd09jviYd8k9lPLuReyY7kCndiMRPmkkLC8zmpwdt8tQz8
	K0k5UhCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5myP-000Wni-Db; Mon, 27 Jun 2022 11:32:09 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5myN-000Wip-Gb
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 11:32:08 +0000
Received: by mail-wm1-f49.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so2902035wmi.0
        for <linux-nvme@lists.infradead.org>; Mon, 27 Jun 2022 04:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r24a/WtFP4+qP+RfIM4becT+F+UWj3fzztTUVKoGkYI=;
        b=NrKOOJg1GL2w7pdXCJrKVIa0WISwvTXqRMj9Q48XYpzQiB45VFvCIq2njumIdH/L5h
         1DomVc9C3BD37hmsae3i8FLPQUILd0Tj6neBFs3pIzo1wExD3kt9+lXCk+J/yb6pvJAT
         alYTeJIyIEyXx3NlFoMiq2u7/RwcnSv33Y+9923hxfWXQUyYrLCuxHhRpQxO576Rs3wY
         VTGP6XC7mg0OepXpT4zHEmYTQ+W0lmE8op1141nwbFFzobKYRFz7KYEUsTCNXhe6ZBio
         O2RXUR+uEx26RxcvKwc2di3rEMWVV3yPWAdrr9qjocDvyKA0afv3TcALf6FSE5xe0Jrc
         erTQ==
X-Gm-Message-State: AJIora8AIV5QLlCRvmLMi2Aqt6qcraGxDhK3boAcIMv63++N/j6rbewF
	RjV8pMmA2roTE9YFmBycmJo=
X-Google-Smtp-Source: AGRyM1u7uBD4tdKh2WfwFB45pTnzq6NfV2tebzNFglE2jLgRF7J4diZHazm5eGxJDluzEtqull384w==
X-Received: by 2002:a05:600c:4149:b0:3a0:4728:60e7 with SMTP id h9-20020a05600c414900b003a0472860e7mr8602985wmm.10.1656329522479;
        Mon, 27 Jun 2022 04:32:02 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a2-20020adfbc42000000b0021ba1b6186csm11022282wrh.40.2022.06.27.04.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:32:02 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2] nvme: add optional ipv6 test flavor
Date: Mon, 27 Jun 2022 14:32:00 +0300
Message-Id: <20220627113200.121100-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_043207_567224_C970A780 
X-CRM114-Status: GOOD (  13.82  )
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

Allow Setting nvme_adrfam=[ipv4|ipv6] and running tests on either
address family. Ignored for non IP transports.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- fix shellcheck
- prefer double brackets
- fix 80-char long line

 common/multipath-over-rdma | 10 ++++++++++
 tests/nvme/rc              | 32 +++++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index f9d7b9a236ce..661eabd56548 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -74,6 +74,16 @@ get_ipv6_addr() {
 		sed -n 's/.*[[:blank:]]inet6[[:blank:]]*\([^[:blank:]/]*\).*/\1/p'
 }
 
+# grab only the link local address
+get_ipv6_ll_addr() {
+	if [[ ! -e "/sys/class/net/$1" ]]; then
+		echo "get_ipv6_addr(): $1 is not a network interface" 1>&2
+	fi
+	ll_addr=$(ip -6 -o addr show dev "$1" | grep "scope link" |
+		sed -n 's/.*[[:blank:]]inet6[[:blank:]]*\([^[:blank:]/]*\).*/\1/p')
+	echo "$ll_addr%$1"
+}
+
 # Whether or not $1 is a number.
 is_number() {
 	[ "$1" -eq "0$1" ] 2>/dev/null
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 998b18164306..4bebbc762cbb 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -38,6 +38,25 @@ _nvme_requires() {
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
 		return 1
 	esac
+
+	if [[ -n ${nvme_adrfam} ]]; then
+		case ${nvme_adrfam} in
+		ipv6)
+			def_traddr="::1"
+			def_adrfam="ipv6"
+			;;
+		ipv4)
+			;; # was already set
+		*)
+			# ignore for non ip transports
+			if [[ "${nvme_trtype}" == "tcp" ||
+			      "${nvme_trtype}" == "rdma" ]]; then
+				SKIP_REASON="unsupported nvme_adrfam=${nvme_adrfam}"
+				return 1
+			fi
+		esac
+	fi
+
 	return 0
 }
 
@@ -148,9 +167,16 @@ _setup_nvmet() {
 		start_soft_rdma
 		for i in $(rdma_network_interfaces)
 		do
-			ipv4_addr=$(get_ipv4_addr "$i")
-			if [ -n "${ipv4_addr}" ]; then
-				def_traddr=${ipv4_addr}
+			if [[ "${nvme_adrfam}" == "ipv6" ]]; then
+				ipv6_addr=$(get_ipv6_ll_addr "$i")
+				if [[ -n "${ipv6_addr}" ]]; then
+					def_traddr=${ipv6_addr}
+				fi
+			else
+				ipv4_addr=$(get_ipv4_addr "$i")
+				if [[ -n "${ipv4_addr}" ]]; then
+					def_traddr=${ipv4_addr}
+				fi
 			fi
 		done
 	fi
-- 
2.34.1


