Return-Path: <SRS0=s2cI=ZF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9626C432C3
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 21:59:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DDC206E5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 21:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FefaXPc3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GpU0LYo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DDC206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=89oEFK1ZxJouW7R46+yPEjRryTOarkXCLhwEUECJiZ4=; b=FefaXPc3l5a57e
	IgiFbMd7569Z27qvH1LfXbf6JkEwpwZoeDi9ice8ZsCSSernL/equcUh/zsqwaPFO3WI145yAMPLj
	F5ZuUYb4UJYxGCjZApf3gXSEl7jGriecBwFL8cPeLipk0QpKj5j6R2/MO/SsbgOkkC7PDIGItZTBY
	BNCo/YPDDkG1RSl808w9WgBFc71x6KxFiIF/mp6rX2xw4F5Wlyhqro1IR7SY6hXJu7/UjYh6Z7gvA
	uStoi1rJoAv0D4zu0od8Q39cWTlpddOgiIhREXirBNdej1tS+mnSfUWRpWluEi9+sAQ9A8EayRvvA
	FuXHCKIag07vkbRNRVhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iV0fB-0003B8-Vy; Wed, 13 Nov 2019 21:58:57 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iV0f8-00038A-59
 for linux-nvme@lists.infradead.org; Wed, 13 Nov 2019 21:58:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573682334; x=1605218334;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e/mKAf5FtlMYam3mgqT2h/puJ4/SYbQuoC7fBSzXvjY=;
 b=GpU0LYo1VElAbbaXxNipNWZZXVJnHzJWkal1I0K2GPk7h8wPsauHRcBo
 bNelg6nG9Y5ScKdr1bg9fMbik+3FS51z6GvAQI95YicU8sVeLHYVWrzN6
 iTMmHBU1Jc1OG5D7b/pZVUfDSzCsueOBYzRlyYwAotMKgn/o1p6w1N/aQ
 51mqtmeqCe3DxXqIgOizdmRHJMbNGu1vbnyT4C5xxkxOZSRNhBXlMRF+q
 z2dHoPz1SCGYVhBV2fGYVJsgnxNl4BzpOK5sw3RGeVx0GFUxyyZRKbS7j
 gQ6VQQnO3Sg7KMSKAgNZdlbTK8RNGu8s4cTTvS2v3gmZL+Rgb4BZn591J Q==;
IronPort-SDR: h8RLaCpacpzvD37JEcLu+z2w/NiprOZQs+zc9a2+dMGus7hzK8wHhU3vJFvEJAjhDk2+lssQKF
 maGzhvPkh9vbW8cVTSuUwM8YiB4Ag16z2SBPzSEc96KclMnhGow+O1LUIDMbN2qzH7BVPlJjV3
 Wt2SrJuf2M3375CoszcbHw32FdwhYmu3KCo1DX9fx2I9MBuc0K2VSEQRk3RFiBD9O45nXU9xBI
 DFSxJdYodbtQUGFdj5G8ZkUoopmboz5U/yGFzR9V8VziOObEZf4zszugKHobreQ41rNxsa7hI0
 S4M=
X-IronPort-AV: E=Sophos;i="5.68,302,1569254400"; d="scan'208";a="124555175"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2019 05:58:49 +0800
IronPort-SDR: EM1RDBNqqIGBijdllsvxWP1UyRuD2iboHYZByf3Ev5bDCC28X/ZfVZrYhTD9qXVL7jQElDrVWx
 VCGnjz8auuqQf5KiCML8fe5zAgbmfQQ1sRQxaxyjE/l9WF1eOamtTb5K/oWM86+K8NsviE2u53
 famCGUTWdO3hOdAmW5/eKRib/0J9OJ5L7H3OaBh7bjFGDjllhMJJSCd9gaMvcxJEkygdHVBZH7
 2AqwhGOFrhglxqYEU2w7LiQW6Gm7KOQP8xPvwBWFKn3TFBx5wftq5ItTC8Z2GZ340kLIlGSQLi
 nE6lz4ikyIm1UrM4kdQMGBvh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2019 13:53:49 -0800
IronPort-SDR: QgCFc6Me5G8xgTJiey9bSinW6opdY+qQFYj3HvSSxhabWIDlXtB7Ce+Z1xqnAbM8i5Xn/yHnoF
 6UxdPxDNy7JzJ5vhdh7cnKLkW1HURuJs+jthTtpVgia1Il/M8u2B9QPHUw9OkePd/N2FYZ0Nuv
 5CuCZnHRl/gypgeWa6hjrD4Z5hUROEFrz8WO4xDAAFmMLKak45CG2gsbRncqG9IUr5SISOm3br
 OvGYK2q1hzCzOokjTxqUTn28Ex1A6/06/2PBICC5qZruDvoHHCd3tzmPu3uDrFBhRXcq5dnulN
 Z5I=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 13 Nov 2019 13:58:50 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmetcli: allow setting of the subsystem model
Date: Wed, 13 Nov 2019 13:58:46 -0800
Message-Id: <20191113215846.22399-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191113215846.22399-1-chaitanya.kulkarni@wdc.com>
References: <20191113215846.22399-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191113_135854_230741_D67B6C13 
X-CRM114-Status: GOOD (  11.53  )
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
Cc: MRuijter@onestopsystems.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Mark Ruijter <MRuijter@onestopsystems.com>

This patch allows users to set the subsystem's model.

Signed-off-by: Mark Ruijter <MRuijter@onestopsystems.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
In case anyone is intrested here is the test report:-

1. Try input empty string to model attr, should get Linux in nvme list and
   in nvmetcli :-

1.1 # nvme list | tr -s ' ' ' ' | grep -v "\-\-"
 Node SN Model Namespace Usage Format FW Rev 
 /dev/nvme0n1 foo QEMU NVMe Ctrl 1 2.10 MB / 2.10 MB 1 B + 9 B 1.0 
 /dev/nvme1n1 8c2f4de7cc2d177b Linux 1 524.29 MB / 524.29 MB 1 B + 9 B 5.4.0-rc
 nvmetcli should show Linux as default model :-

1.2 # ./nvmetcli/nvmetcli 
/subsystems/fs> ls
o- fs ................................ [version=1.3, allow_any=1, \
                                        serial=a222fc0cd4e5859a, model=Linux]

2, Try and set the model, change from default, new value should reflect
   in nvme list and nvmetcli :-

2.1 # echo "testmodel" > /sys/kernel/config/nvmet/subsystems/fs/attr_model 

2.2# nvme list | tr -s ' ' ' ' | grep -v "\-\-"
Node SN Model Namespace Usage Format FW Rev 
/dev/nvme0n1 foo QEMU NVMe Ctrl 1 2.10 MB / 2.10 MB 1 B + 9 B 1.0 
/dev/nvme1n1 8c2f4de7cc2d177b testmodel 1 524.29 MB / 524.29 MB 1 B + 9 B 5.4.0-rc

2.3. # ./nvmetcli/nvmetcli 
/subsystems/fs> ls
o- fs ............................ [version=1.3, allow_any=1, \
                                    serial=a222fc0cd4e5859a, model=testmodel]

3. Change model value from nvmetcli and check nvme list should be the same :-

3.1 # ./nvmetcli 
/subsystems/fs> set attr model=cool~model
Parameter model is now 'cool~model'.

3.2# nvme list | tr -s ' ' ' ' | grep -v "\-\-"
Node SN Model Namespace Usage Format FW Rev 
/dev/nvme0n1 foo QEMU NVMe Ctrl 1 2.10 MB / 2.10 MB 1 B + 9 B 1.0 
/dev/nvme1n1 9a85e5d40cfc22a2 cool~model 1 524.29 MB / 524.29 MB 1 B + 9 B 5.4.0-rc

4. Initialize subsys with model name bdefore we link the subsys to port,
   nvmecli and nvmetcli should display new model name and not the default :-

4.1 # nvme list | tr -s ' ' ' ' | grep -v "\-\-"
Node SN Model Namespace Usage Format FW Rev 
/dev/nvme0n1 foo QEMU NVMe Ctrl 1 2.10 MB / 2.10 MB 1 B + 9 B 1.0 
/dev/nvme1n1 5033aba0a518cf48 new-model 1 524.29 MB / 524.29 MB 1 B + 9 B 5.4.0-rc

4.2 # ./nvmetcli/nvmetcli 
/subsystems/fs> get attr model 
model=new-model 

---
 nvmetcli | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/nvmetcli b/nvmetcli
index 3d8c16e..7347fbb 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -155,6 +155,7 @@ class UISubsystemNode(UINode):
     ui_desc_attr = {
         'allow_any_host': ('string', 'Allow access by any host if set to 1'),
         'serial': ('string', 'Export serial number to hosts'),
+        'model': ('string', 'Set a model description'),
         'version': ('string', 'Export version number to hosts'),
     }
 
@@ -172,6 +173,7 @@ class UISubsystemNode(UINode):
         info.append("allow_any=" +
                     self.cfnode.get_attr("attr", "allow_any_host"))
         info.append("serial=" + self.cfnode.get_attr("attr", "serial"))
+        info.append("model=" + self.cfnode.get_attr("attr", "model"))
         return (", ".join(info), True)
 
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
