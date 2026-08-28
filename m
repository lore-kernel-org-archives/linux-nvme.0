Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4952BC61DE1
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lx1CAIf6tsyVUQzXCCizsxM8XuTzINorxK0ajxMJa58=; b=sfgMzl9lzrs96GY/U8uF39hWZv
	oQjZ2O0KhRegtoZU2BZoIl7WMHinR8bzB7bV2YPT80lHaFqODlJVrRUJGrMdDmOX6nBdEcbvCKlAr
	6zaS0ewatHeMENjg4eeq+bEmd/CPFVBiLOSQBtVTh6/cCPQPwJepfhhHIprYNYqTlif/QFCUOK7mJ
	gW9Wq92M6gzjyewENMXBPsg3ixvbC5lJWQFH0DFsIVzeGvFlvq/j5LEwzfOwgqbFzI5+SDZPQFOBV
	sj9P9leAMybXD7PLcY1+yL6ALnmx5HYMCYfVfxY8oGe6qof97YcFs/lIBDkjUWXYS72ZMqsS2zY3j
	D3I6NcnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0hDZ-00000007pbX-0R53;
	Sun, 30 Aug 2026 15:13:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzyXT-0000000669U-0xOS
	for linux-nvme@lists.infradead.org;
	Fri, 28 Aug 2026 15:30:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787931040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lx1CAIf6tsyVUQzXCCizsxM8XuTzINorxK0ajxMJa58=;
	b=GG+2rtZUo44WmQsBJIxNu3+GWPrYx6MFUFHUL33WZdyp80MI6GHK2be2HeCcmoigZCeh9R
	PikkfLicY4kRFAMC+CipeqJ0ictYSbpBQ7V1LRFBUCxZBG33JfvFBihLlSH+G3dmRBSz4f
	tZ3BX66TKouHiNSqPDG2Zt3cFYHq9P0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-3_h1g1a-Mla4clDmgM90iQ-1; Fri,
 28 Aug 2026 11:30:36 -0400
X-MC-Unique: 3_h1g1a-Mla4clDmgM90iQ-1
X-Mimecast-MFC-AGG-ID: 3_h1g1a-Mla4clDmgM90iQ_1787931035
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD02619774EB;
	Fri, 28 Aug 2026 15:30:35 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.80.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C7B018005B2;
	Fri, 28 Aug 2026 15:30:34 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [blktests v3 1/2] nvme: Add _setup_nvmet_port_marginal
Date: Fri, 28 Aug 2026 11:30:28 -0400
Message-ID: <20260828153029.853768-2-jtaubepe@redhat.com>
In-Reply-To: <20260828153029.853768-1-jtaubepe@redhat.com>
References: <20260828153029.853768-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: TtKJ7gXGBDW1PiBPeIc9syDzT4Vhhrto-gYMhVUl_rE_1787931035
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_083043_339211_4DCF8D25 
X-CRM114-Status: GOOD (  11.51  )
X-Mailman-Approved-At: Sun, 30 Aug 2026 08:13:08 -0700
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

Adds functionality to set up a NVME port in marginal state.
This is useful for testing the behavior of the NVME driver when a port
is in a marginal state.

Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>
---
V1 -> V2:
 - Added john's review and test-by tags
 - Use != instead of ! ==
 - Wrap lines over 80col
V2 -> V3:
 - No change
---
 common/nvme | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/common/nvme b/common/nvme
index f399937..a6d6b28 100644
--- a/common/nvme
+++ b/common/nvme
@@ -153,6 +153,16 @@ _nvme_fcloop_add_tport() {
 	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_target_port
 }
 
+_nvme_fcloop_set_rport_marginal() {
+	local wwnn="$1"
+	local wwpn="$2"
+	local marginal="$3"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${wwnn},wwpn=${wwpn},marginal=${marginal}" \
+	     > ${loopctl}/set_marginal_rport
+}
+
 _nvme_fcloop_del_rport() {
 	local local_wwnn="$1"
 	local local_wwpn="$2"
@@ -763,6 +773,27 @@ _create_nvmet_port() {
 	echo "${port}"
 }
 
+_setup_nvmet_port_marginal() {
+	local -i port="$1"
+	local state="${2}"
+
+	if [[ "${nvme_trtype}" != "fc" ]]; then
+		echo "FAIL _setup_nvmet_port_marginal() only supports fc transport"
+		exit 1
+	fi
+
+	if [[ "${state}" == "live" ]]; then
+		_nvme_fcloop_set_rport_marginal "$(_remote_wwnn $port)" \
+					"$(_remote_wwpn $port)" 0
+	elif [[ "${state}" == "marginal" ]]; then
+		_nvme_fcloop_set_rport_marginal "$(_remote_wwnn $port)" \
+					"$(_remote_wwpn $port)" 1
+	else
+		echo "FAIL _setup_nvmet_port_marginal() invalid state: ${state}"
+		exit 1
+	fi
+}
+
 _setup_nvmet_port_ana() {
 	local port="$1"
 	local anagrpid="${2:-$def_anagrpid}"
-- 
2.54.0


