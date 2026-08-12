Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B3DC5CFCF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 17:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9tEF4L6SnHGaX7oaEjxmSWJe/E9kfPYeASDInCk8Coo=; b=sj1dc2uUZGdskKA473La5fbfh1
	UdRIvfihYNcTeLLcHSoZXE8SChqiroC+Reku7uFvi2keovKZpYk9YCIZXzbknGFs8plRkDWxJv0fC
	71/l8UUDyCKdCDlfIC3Ha/8yHcTWcZ3SNoV9GQGoWWd+Out1In7clmqMevsQbp9qu8GQxneiO6ITb
	fVCOS36dStV6BnIhiWvSF0sjatvWd2SZyh607KqeQoYOCiHEqhZ0Qdja/NMeUWSjCcgNyU9i0BVhB
	WAqXoZ8yIWhml0ik//FtFTfD69OFu3aqnqFdHxj03TRnnVKFSnksfObyYWcepiIRfev+XkyO1MtGA
	GM9w97Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuD13-0000000GieD-2TB4;
	Wed, 12 Aug 2026 17:45:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuD0x-0000000Gic3-3yW7
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 17:45:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786556719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tEF4L6SnHGaX7oaEjxmSWJe/E9kfPYeASDInCk8Coo=;
	b=YCUG75U8vhFEfJCOGPLTAuBbKEvXswFH8R+QjYO201DDLepH9BpdNJar1mIMmtNVOfzcXg
	8evja9seSj+QyDNomTtubZF7xZbD45MYoJPH8FtPtPhtdBbeGuLxZ1cPVofGspnbS8ko5B
	4XzcuI2kxSrg1SD5snxQbE3YKLYmToA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-e0l0m0ZJO222yHhViJ66Sw-1; Wed,
 12 Aug 2026 13:45:12 -0400
X-MC-Unique: e0l0m0ZJO222yHhViJ66Sw-1
X-Mimecast-MFC-AGG-ID: e0l0m0ZJO222yHhViJ66Sw_1786556711
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCE64180075E;
	Wed, 12 Aug 2026 17:45:10 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.88.181])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF813195DF9E;
	Wed, 12 Aug 2026 17:45:08 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [PATCH blktests 1/2] nvme: Add _setup_nvmet_port_marginal
Date: Wed, 12 Aug 2026 13:45:02 -0400
Message-ID: <20260812174503.3705830-2-jtaubepe@redhat.com>
In-Reply-To: <20260812174503.3705830-1-jtaubepe@redhat.com>
References: <20260812174503.3705830-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: up1sI6uaxQf6EaRjGWSwsfu_v-bulmTe-FUwdb4D0ps_1786556711
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_104520_058696_02366C5C 
X-CRM114-Status: GOOD (  10.83  )
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
---
 common/nvme | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/common/nvme b/common/nvme
index f399937..d389e18 100644
--- a/common/nvme
+++ b/common/nvme
@@ -153,6 +153,15 @@ _nvme_fcloop_add_tport() {
 	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_target_port
 }
 
+_nvme_fcloop_set_rport_marginal() {
+	local wwnn="$1"
+	local wwpn="$2"
+	local marginal="$3"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${wwnn},wwpn=${wwpn},marginal=${marginal}" > ${loopctl}/set_marginal_rport
+}
+
 _nvme_fcloop_del_rport() {
 	local local_wwnn="$1"
 	local local_wwpn="$2"
@@ -763,6 +772,27 @@ _create_nvmet_port() {
 	echo "${port}"
 }
 
+_setup_nvmet_port_marginal() {
+	local -i port="$1"
+	local state="${2}"
+
+	if [[ ! "${nvme_trtype}" == "fc" ]]; then
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


