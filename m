Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC88D58D66
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yxWF1Vf0E5u1IM/aYv89W71qdfhW3Dh8Ud7/oO9ov8s=; b=B6s99KysCV5Ab46tELdaJWbYkT
	nkSNRUfdqPF0rgMNOCrdMFZ+mYudq+R8sD5fyZVFe1AMx5kJjsvhUxhiDeBeu425/d3kOgcKn9aku
	X16hpVhM1Tm5ps0xu+dzXhmCojuLGRiYJjqMJtrvgaXUuQNgM+OHrkQNZ04YEbC+ZbDsn3pbXdW5y
	2ziZ1OV2JXNM3Sx6LLf78U3tG12OhKhnQn64KVW2nodP2+P0wlg9YNNCVsgtcI2eA3pAqMXBXAJ5y
	K1YSshneSM6a6ViY1ltNxCzLH1IflbJjwv2CYbztDOAqGYMA48/zNM3TapmNBXvdd5/D1L/y0PW2P
	Mgs/kKJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFbxr-00000008dhO-2WMf;
	Mon, 25 Nov 2024 16:29:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFbxn-00000008dfM-3Uxb
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 16:29:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732552164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yxWF1Vf0E5u1IM/aYv89W71qdfhW3Dh8Ud7/oO9ov8s=;
	b=HrDGq+E3Ki2WPZXSZoit56nnA7tdJsM2Uzc/jMk0RGimtfl+4FwlydfUoPcWY1hnPnTrcA
	516zAZ1l4BpKcb45qJEFbWk7L2t8eXAyPPBeU9cMLCcD1vIwV218eA9+12jtfxG7F6sdEx
	3em25Ba8b6I7kZHaIHxE0eSlPw/F+KM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-v8PC728oOSWQ9K-8mRh0kg-1; Mon,
 25 Nov 2024 11:29:21 -0500
X-MC-Unique: v8PC728oOSWQ9K-8mRh0kg-1
X-Mimecast-MFC-AGG-ID: v8PC728oOSWQ9K-8mRh0kg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6E871955F77;
	Mon, 25 Nov 2024 16:29:20 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.22.66.67])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E54930000DF;
	Mon, 25 Nov 2024 16:29:19 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: shinichiro.kawasaki@wdc.com,
	linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com,
	Bryan Gurney <bgurney@redhat.com>
Subject: [PATCH blktests] nvme/039: check for sector size of test device
Date: Mon, 25 Nov 2024 11:29:04 -0500
Message-ID: <20241125162904.7326-1-bgurney@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XDgcywEFrtC56jia0y8x5NjH6-68L6keVPV0QmHeHjw_1732552161
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_082927_943734_06F781B3 
X-CRM114-Status: GOOD (  11.66  )
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

This test has hard-coded 512 byte values for the dd commands, which
will fail on 4096-byte block devices.  Create a SECT_SZ global
variable that is populated with the result of the command
"blockdev --getss <dev>", and use that result for the block size
of the write commands.

Also use this variable for the "--data-len" command of the "nvme
admin-passthru" and "nvme io-passthru" tests.  (On a test with a
4096-byte namespace, leaving these with the hardcoded values still
passed, but update them for the sake of consistency.)

Signed-off-by: Bryan Gurney <bgurney@redhat.com>
---
 tests/nvme/039 | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tests/nvme/039 b/tests/nvme/039
index e8020a7..f1abf8b 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -37,7 +37,7 @@ inject_unrec_read_on_read()
 	# Inject a 'Unrecovered Read Error' (0x281) status error on a READ
 	_nvme_enable_err_inject "$1" 0 100 1 0x281 1
 
-	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
+	dd if=/dev/"$1" of=/dev/null bs="${SECT_SZ}" count=1 iflag=direct \
 	    2> /dev/null 1>&2
 
 	_nvme_disable_err_inject "$1"
@@ -57,7 +57,7 @@ inject_invalid_status_on_read()
 	# Inject an invalid status (0x375) on a READ
 	_nvme_enable_err_inject "$1" 0 100 1 0x375 1
 
-	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
+	dd if=/dev/"$1" of=/dev/null bs="${SECT_SZ}" count=1 iflag=direct \
 	    2> /dev/null 1>&2
 
 	_nvme_disable_err_inject "$1"
@@ -77,7 +77,7 @@ inject_write_fault_on_write()
 	# Inject a 'Write Fault' 0x280 status error on a WRITE
 	_nvme_enable_err_inject "$1" 0 100 1 0x280 1
 
-	dd if=/dev/zero of=/dev/"$1" bs=512 count=1 oflag=direct \
+	dd if=/dev/zero of=/dev/"$1" bs="${SECT_SZ}" count=1 oflag=direct \
 	    2> /dev/null 1>&2
 
 	_nvme_disable_err_inject "$1"
@@ -119,7 +119,7 @@ inject_invalid_admin_cmd()
 	# Inject a 'Invalid Command Opcode' (0x1) on an invalid command (0x96)
 	 _nvme_enable_err_inject "$1" 0 100 1 0x1 1
 
-	nvme admin-passthru /dev/"$1" --opcode=0x96 --data-len=4096 \
+	nvme admin-passthru /dev/"$1" --opcode=0x96 --data-len="${SECT_SZ}" \
 	    --cdw10=1 -r 2> /dev/null 1>&2
 
 	_nvme_disable_err_inject "$1"
@@ -145,7 +145,7 @@ inject_invalid_io_cmd_passthru()
 	_nvme_enable_err_inject "$ns_dev" 0 100 1 0x1 1
 
 	nvme io-passthru /dev/"$1" --opcode=0x02 --namespace-id="$ns" \
-		--data-len=512 --read --cdw10=0 --cdw11=0 --cdw12="$2" 2> /dev/null 1>&2
+		--data-len="${SECT_SZ}" --read --cdw10=0 --cdw11=0 --cdw12="$2" 2> /dev/null 1>&2
 
 	_nvme_disable_err_inject "$1"
 	if ${nvme_verbose_errors}; then
@@ -174,6 +174,8 @@ test_device() {
 	ns_dev=${TEST_DEV##*/}
 	ctrl_dev=${ns_dev%n*}
 
+	SECT_SZ=$(blockdev --getss "${TEST_DEV}")
+
 	_nvme_err_inject_setup "${ns_dev}" "${ctrl_dev}"
 
 	# wait DEFAULT_RATELIMIT_INTERVAL=5 seconds to ensure errors are printed
-- 
2.47.0


