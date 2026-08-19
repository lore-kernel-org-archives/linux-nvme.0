Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50174C5DF85
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 20:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IARjiBP/HesLaf/M73N36h/GTjovCKkTmivEOztlIIc=; b=lGhiMw/VFBCt8PxwAbIdKoBNHe
	fGUytF1xpoD0AuY9deUPG9TFuFOanbUZUUlv3p2k3S876p3Arr73qTpkSWN5ccyEGIB8ubzeoy9vC
	WudN43cyOLu84IGFyURiIBe+WdnQUQyNxSyLyBh6LwZC9cYmVpepkoFr7goWzBxVHo6r1D9HVY+bS
	eshOn35cY1QEa+X4v1MzKV2NwZgo7KDHaXzbLWKGuFhRliVhVtppShw1oJawnxp+TQWn/NzyDtz+/
	gbGoK7jDsp3PqatlwLcrCuVplTGe2n5C+TQoVB7OMqyh0XTruuyxL3uji0ZM2+g1pLZnsjkI2nU2T
	y22B83Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwmWh-0000000AUnu-3OQY;
	Wed, 19 Aug 2026 20:04:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwmWe-0000000AUn6-3ZDI
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 20:04:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787169880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IARjiBP/HesLaf/M73N36h/GTjovCKkTmivEOztlIIc=;
	b=N7LmpHlRmppSaf8Fpu5ctUkNoYWW/bF9sqONXPB6Mp4uunXmAboroQoPpszAKCNq2CBxOi
	gTSR0q+A2+gsbQmo/+3gTua+Gea48gPp5+LHqmCgUCKAjX0vuHIjHqJVflBg2i11oprsmf
	GBZ7KGPgcxDPF3ZfBse71tyqO6XrsZE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-xbWcBtjCOnicHS6lRgetfA-1; Wed,
 19 Aug 2026 16:04:33 -0400
X-MC-Unique: xbWcBtjCOnicHS6lRgetfA-1
X-Mimecast-MFC-AGG-ID: xbWcBtjCOnicHS6lRgetfA_1787169871
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED04B195609F;
	Wed, 19 Aug 2026 20:04:30 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.17.17.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90EDE1800347;
	Wed, 19 Aug 2026 20:04:29 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [PATCH v2 1/2] nvme: Add _setup_nvmet_port_marginal
Date: Wed, 19 Aug 2026 16:04:24 -0400
Message-ID: <20260819200425.194743-2-jtaubepe@redhat.com>
In-Reply-To: <20260819200425.194743-1-jtaubepe@redhat.com>
References: <20260819200425.194743-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: JGWLRhyW2QwpE5Bgv3OMCNi7_OTgpuW1Y55ZDJyFfvE_1787169871
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_130440_963023_FDBB26FE 
X-CRM114-Status: GOOD (  11.99  )
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


