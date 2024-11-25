Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F0BD59D60
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 19:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PsywVt61WPkO/lklxJEezuNpDlA0ghXkWHmR4C/FHn0=; b=2kOIHwiHT3LPkdom1VoWPMwGBT
	efn3Qwl1UvY9tVygvVYeXUxudaFl71abcMO9be2SNcuNabXz5XoyOZ40pxYzZw8qvriRyEFt1Jm0L
	f3ta0w/bBcpPYwP60j1Hrni2/Yi8HjIUpDTn++y7g9IYJ8G1xz6W7gWZWAuN4Ad5qY+2fnN28YkCJ
	ejeJW+xDqUEl/f0iksoTDsNARU6qSK9JZloK5aknAoK/LekG7KKVK/IAlw4oDgWUynu65tvg+ZMUd
	/00J6zvaCn2ZqB90L4p/UKpoMFpxrer92wThsrWFqeBOOI3fr1z4zknsq0sCZO4CgqiRushcqrAs1
	6opUINXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFew4-00000008ymT-1OjP;
	Mon, 25 Nov 2024 19:39:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFew0-00000008ylv-1PJ7
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 19:39:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732563584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PsywVt61WPkO/lklxJEezuNpDlA0ghXkWHmR4C/FHn0=;
	b=gJdKgejmYcgnN5B5PbRG6SH3J2iBvEgt5Em5AQivJzi0qzYDXz3shFBmoy0HmHXQ64FyyV
	Ood9i67/zkVpoW+Nn7SjIDxBaRSpfgBw5DmKOtz/PimnKpcEYmz8sSIw+DaHkO7EefVmxG
	kyQ4lRb1EJPUugLfKuwT5nVzPLXNfjo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-xgPFjCKNN9uyQKs34J8mGA-1; Mon,
 25 Nov 2024 14:39:40 -0500
X-MC-Unique: xgPFjCKNN9uyQKs34J8mGA-1
X-Mimecast-MFC-AGG-ID: xgPFjCKNN9uyQKs34J8mGA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 885E119560AD;
	Mon, 25 Nov 2024 19:39:39 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.22.66.67])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02CB41956086;
	Mon, 25 Nov 2024 19:39:37 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: shinichiro.kawasaki@wdc.com,
	linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com,
	bvanassche@acm.org,
	Bryan Gurney <bgurney@redhat.com>
Subject: [PATCH blktests v2] nvme/039: check for logical block size of test device
Date: Mon, 25 Nov 2024 14:39:33 -0500
Message-ID: <20241125193933.22017-1-bgurney@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HT5gUL3iMOBy-f0bDjOSDRCXt8D7gkH1T2DYVqiJBpk_1732563579
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_113948_441904_AC76E76F 
X-CRM114-Status: GOOD (  11.23  )
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
will fail on 4096-byte block devices.  Create an LB_SZ global
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
index e8020a7..eca8ba3 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -37,7 +37,7 @@ inject_unrec_read_on_read()
 	# Inject a 'Unrecovered Read Error' (0x281) status error on a READ
 	_nvme_enable_err_inject "$1" 0 100 1 0x281 1
 
-	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
+	dd if=/dev/"$1" of=/dev/null bs="${LB_SZ}" count=1 iflag=direct \
 	    2> /dev/null 1>&2
 
 	_nvme_disable_err_inject "$1"
@@ -57,7 +57,7 @@ inject_invalid_status_on_read()
 	# Inject an invalid status (0x375) on a READ
 	_nvme_enable_err_inject "$1" 0 100 1 0x375 1
 
-	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
+	dd if=/dev/"$1" of=/dev/null bs="${LB_SZ}" count=1 iflag=direct \
 	    2> /dev/null 1>&2
 
 	_nvme_disable_err_inject "$1"
@@ -77,7 +77,7 @@ inject_write_fault_on_write()
 	# Inject a 'Write Fault' 0x280 status error on a WRITE
 	_nvme_enable_err_inject "$1" 0 100 1 0x280 1
 
-	dd if=/dev/zero of=/dev/"$1" bs=512 count=1 oflag=direct \
+	dd if=/dev/zero of=/dev/"$1" bs="${LB_SZ}" count=1 oflag=direct \
 	    2> /dev/null 1>&2
 
 	_nvme_disable_err_inject "$1"
@@ -119,7 +119,7 @@ inject_invalid_admin_cmd()
 	# Inject a 'Invalid Command Opcode' (0x1) on an invalid command (0x96)
 	 _nvme_enable_err_inject "$1" 0 100 1 0x1 1
 
-	nvme admin-passthru /dev/"$1" --opcode=0x96 --data-len=4096 \
+	nvme admin-passthru /dev/"$1" --opcode=0x96 --data-len="${LB_SZ}" \
 	    --cdw10=1 -r 2> /dev/null 1>&2
 
 	_nvme_disable_err_inject "$1"
@@ -145,7 +145,7 @@ inject_invalid_io_cmd_passthru()
 	_nvme_enable_err_inject "$ns_dev" 0 100 1 0x1 1
 
 	nvme io-passthru /dev/"$1" --opcode=0x02 --namespace-id="$ns" \
-		--data-len=512 --read --cdw10=0 --cdw11=0 --cdw12="$2" 2> /dev/null 1>&2
+		--data-len="${LB_SZ}" --read --cdw10=0 --cdw11=0 --cdw12="$2" 2> /dev/null 1>&2
 
 	_nvme_disable_err_inject "$1"
 	if ${nvme_verbose_errors}; then
@@ -174,6 +174,8 @@ test_device() {
 	ns_dev=${TEST_DEV##*/}
 	ctrl_dev=${ns_dev%n*}
 
+	LB_SZ=$(blockdev --getss "${TEST_DEV}")
+
 	_nvme_err_inject_setup "${ns_dev}" "${ctrl_dev}"
 
 	# wait DEFAULT_RATELIMIT_INTERVAL=5 seconds to ensure errors are printed
-- 
2.47.0


