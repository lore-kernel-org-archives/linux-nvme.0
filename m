Return-Path: <SRS0=CCYl=OH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73467C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Sep 2021 03:10:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D15460F26
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Sep 2021 03:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D15460F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HlOzMKdJBNipQZO9SGEaMe5a5DAm3DBFjMZJ5KAQ52w=; b=zlaT6wQcC6/Z+3
	ODXzL12GaAuE4WhMIRTpyVpGF+P4lYhUcePn/FdlMPGDzih9XpNFGvcEWqErp7NSC/j3Jw3O0JgmI
	O8OpmTuC7MvzoQAfd+JrQrBwbWUirkIbm/73enpCYxYaikHxWCxyxOpT1Q13jS/yWugypdxZEqOuB
	pE9W6Dm5f2K1wAkGcFXUdVp5zxdjmO0jIi10obuOafWKyk+rLR2q1z4fLQuZmJSxaH2C+6U5Q3hS2
	fPW/wrBzuBqesAyvuNTTGb+bVuL0INLKObJL+FPruKXuVqzX/5aUvcHzYn9A/WMlaOnareQ1Ds9YK
	+s6YgZUVLTocTa1whgsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mR4GH-00D7RJ-Nw; Fri, 17 Sep 2021 03:10:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mR4GE-00D7Qj-0B
 for linux-nvme@lists.infradead.org; Fri, 17 Sep 2021 03:09:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631848195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=n9ORYpjzpwp6Ym/dMpPDG+8FjhqIkwMtITEMI6byja0=;
 b=hxtR0YR3eGHDMlmUHMPVXExJC8tE/mDmSIzZL8GmIHg1ljmdB3an3iKOOqb8v9IwaSWmYz
 eWMRRLJETmrRqre7UmsK8TS+xq0WVniqscWu4ToRac+P61xj9WrP0Yq3h7iSMd78DbthbM
 T9eSoJKt6osRQiR0l0/M2+WkmuzBAac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-XDDPBJQaO7SluvD-owoirA-1; Thu, 16 Sep 2021 23:09:53 -0400
X-MC-Unique: XDDPBJQaO7SluvD-owoirA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79749824FA6;
 Fri, 17 Sep 2021 03:09:32 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D090510013D7;
 Fri, 17 Sep 2021 03:09:30 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: bvanassche@acm.org,
	osandov@osandov.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 blktests] nvmeof-mp/001: fix failure when CONFIG_NVME_HWMON
 enabled
Date: Fri, 17 Sep 2021 11:09:11 +0800
Message-Id: <20210917030911.25646-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210916_200958_164544_B644E9E0 
X-CRM114-Status: UNSURE (   9.21  )
X-CRM114-Notice: Please train this message.
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

skip checking ng0n1/hwmon5 in count_devices

$ use_siw=1  ./check nvmeof-mp/001
nvmeof-mp/001 (Log in and log out)                           [failed]
    runtime  3.695s  ...  4.002s
    --- tests/nvmeof-mp/001.out	2021-09-12 05:35:17.866892187 -0400
    +++ /root/blktests/results/nodev/nvmeof-mp/001.out.bad	2021-09-12 06:49:25.621880616 -0400
    @@ -1,3 +1,3 @@
     Configured NVMe target driver
    -count_devices(): 1 <> 1
    +count_devices(): 3 <> 1
     Passed
$ ls -l /sys/class/nvme-fabrics/ctl/*/*/device
lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/hwmon5/device -> ../../nvme0
lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/ng0n1/device -> ../../nvme0
lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/nvme0n1/device -> ../../nvme0

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
V2: update regex to hwmon[0-9]+|ng[0-9]+n[0-9]+

---
 tests/nvmeof-mp/001 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/nvmeof-mp/001 b/tests/nvmeof-mp/001
index 69f1e24..f3e6394 100755
--- a/tests/nvmeof-mp/001
+++ b/tests/nvmeof-mp/001
@@ -11,6 +11,7 @@ count_devices() {
 	local d devs=0
 
 	for d in /sys/class/nvme-fabrics/ctl/*/*/device; do
+		[[ "$d" =~ hwmon[0-9]+|ng[0-9]+n[0-9]+ ]] && continue
 		[ -d "$d" ] && ((devs++))
 	done
 	echo "$devs"
-- 
2.21.3


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
