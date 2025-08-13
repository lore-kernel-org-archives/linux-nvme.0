Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F398BCA0EE0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 21:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NANpq5j0QRDeFcPPjmiwwML+SQhgqErHhixAlpANfGI=; b=1t9TzwlmVgR6DUw7mMFWlWrGep
	vrFOMovt+MaeinPMDPx28lppSWjjVKz7zEd4e36No/Rz6etDqJqCvGUwQva358bazC5RB/Hke/yPA
	J+ryrpL8SDPpGwxN78f5NP7jagvqPypWgPgQsW6k6RQycJ4I5ms2EMl/z9hcGyPmscOcufTU/CmHx
	8gAQ8PbfggAZAQQTUiOSyaCvOoiTURkPAhASfdsost21PAh4aJ3S+woI4Wgau5xejzW1we/cASyOT
	zc9OOkTqEjNWpxriyo/rflySa4gDhF8vLret6g50GVTOoKH71ilZ26069NAoLo05fNn3axf0JiDa/
	MYzjmqzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umIpf-0000000Ezel-3hR2;
	Wed, 13 Aug 2025 21:16:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umHng-0000000EvHO-1FlZ
	for linux-nvme@bombadil.infradead.org;
	Wed, 13 Aug 2025 20:10:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=NANpq5j0QRDeFcPPjmiwwML+SQhgqErHhixAlpANfGI=; b=PidlZIHaz81B8kLvlfYOc74oIm
	/PjjoirHNVeddPLZdj75mUaTMPtphEc2LHK/+cob6NiNRDR4GQQC7O1vbnrDLLsX+5volyfsUwPcG
	V1SDjhwyjzXCoPD2O6FWWTZPOzZRoa67XQUUf3nS+LbivFJigfchFP/cXUnPPZOXAeb3LUrD1pK+k
	K+2FWriyi+WBQfcr3Qod5oez0Q3AvSqM79XpH5cNxDc61jp/2BT73/th1a68LkCBeUprzIQC+B6nR
	hYwx86JwCr6tpwC7rMU1TsogNOyVgOQwG13tCK6mcYBMYTMMWW84OY3QGe9nO8K4uVfwePNgLUnHW
	Xnou4HKA==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umHnc-0000000GBLX-2WPj
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 20:10:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755115815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NANpq5j0QRDeFcPPjmiwwML+SQhgqErHhixAlpANfGI=;
	b=Bg0oJxCRX5+lBc6roL8tcuL6RY4mrpgeMKbYD9ScGHkSm0Dk4paFjfbNOsoLRH+cbJZloK
	BUJVwC78QRtW4JlFKNX7+9AwkyTxKiUK3zmxCKOV6LVg8bUA0meHFfU0Yyzp6QKPI/Eqrl
	SUWxxAEXooieuJbBn4/eJcDyHoXfYRY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755115815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NANpq5j0QRDeFcPPjmiwwML+SQhgqErHhixAlpANfGI=;
	b=Bg0oJxCRX5+lBc6roL8tcuL6RY4mrpgeMKbYD9ScGHkSm0Dk4paFjfbNOsoLRH+cbJZloK
	BUJVwC78QRtW4JlFKNX7+9AwkyTxKiUK3zmxCKOV6LVg8bUA0meHFfU0Yyzp6QKPI/Eqrl
	SUWxxAEXooieuJbBn4/eJcDyHoXfYRY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-8slgemYANWa90JYFwSvOBg-1; Wed,
 13 Aug 2025 16:08:50 -0400
X-MC-Unique: 8slgemYANWa90JYFwSvOBg-1
X-Mimecast-MFC-AGG-ID: 8slgemYANWa90JYFwSvOBg_1755115728
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AEF31800248;
	Wed, 13 Aug 2025 20:08:48 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.44.32.39])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 736B618003FC;
	Wed, 13 Aug 2025 20:08:42 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: james.smart@broadcom.com,
	njavali@marvell.com,
	linux-scsi@vger.kernel.org,
	hare@suse.de,
	linux-hardening@vger.kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	bgurney@redhat.com,
	jmeneghi@redhat.com,
	emilne@redhat.com
Subject: [PATCH v9 7/9] nvme: sysfs: emit the marginal path state in show_state()
Date: Wed, 13 Aug 2025 16:07:42 -0400
Message-ID: <20250813200744.17975-8-bgurney@redhat.com>
In-Reply-To: <20250813200744.17975-1-bgurney@redhat.com>
References: <20250813200744.17975-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_211017_241358_D302BCD5 
X-CRM114-Status: GOOD (  11.90  )
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

If a controller has received a link integrity or congestion event, and
has the NVME_CTRL_MARGINAL flag set, emit "marginal" in the state
instead of "live", to identify the marginal paths.

Co-developed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Muneendra Kumar <muneendra.kumar@broadcom.com>
Signed-off-by: Bryan Gurney <bgurney@redhat.com>
---
 drivers/nvme/host/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..4a6135c2f9cb 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -430,7 +430,9 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 	};
 
 	if (state < ARRAY_SIZE(state_name) && state_name[state])
-		return sysfs_emit(buf, "%s\n", state_name[state]);
+		return sysfs_emit(buf, "%s\n",
+			(nvme_ctrl_is_marginal(ctrl)) ? "marginal" :
+			state_name[state]);
 
 	return sysfs_emit(buf, "unknown state\n");
 }
-- 
2.50.1


