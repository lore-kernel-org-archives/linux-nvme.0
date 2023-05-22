Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FEDC77B73
	for <linux-nvme@archiver.kernel.org>; Mon, 22 May 2023 21:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eVyn9ISFy0CI6L6vAfRlCzzyScxuVhiNG3wDYJjYpcw=; b=BmZofJho9FSFAJdc3Z5C4DLRYX
	ezopntHHngHvYrj0qWkiFR9AqUy+JKvq/sO1oNGBehg5UtevCpeL0IFmcZC70B+gsF/hNe60KaEv5
	SBOz+sQtQ3ntYSchkQv598ij7N1AiV80m89BL+yyfdjxqscCMI13FE4b8Kfn+3txNaCXbNZFojCWO
	VaxSAvGK3y1Wjwos85k5W4drnGbHJBPfydUpwmCgM1qqHENGYuAx4YH3wsn7M8gxDp7u5wqmbc39a
	30CDPPwKEO0Y9OxGQYp9YmbV1QPdKvahKb35QYlrvllmP4ij+5KTuadAL5Nynrzic7oBUOFviLZSD
	BfV3Hl7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1DVe-0089wZ-15;
	Mon, 22 May 2023 21:56:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1DVc-0089vn-0B
	for linux-nvme@lists.infradead.org;
	Mon, 22 May 2023 21:56:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684792561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eVyn9ISFy0CI6L6vAfRlCzzyScxuVhiNG3wDYJjYpcw=;
	b=fLYUCXEtcC8pAg9UrhOycrunDAD7w2V2L7gxFGSzn4B+lqfn4YzDkFXWdFotSDArAZEUrG
	hXswqfU2xxVKEl6qYZxOisW4sy7/JBsGud4dVixOzuTpONadK3C5D1zy+tz1fyPm1eNYBb
	uorJ9k/p4JOOaR7uFsGkk9hyqGchyrc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-iqpS2zWDPVensZl27AmW9Q-1; Mon, 22 May 2023 17:53:57 -0400
X-MC-Unique: iqpS2zWDPVensZl27AmW9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F68A85A5AA;
	Mon, 22 May 2023 21:53:57 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.2.16.139])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB2BD40CFD45;
	Mon, 22 May 2023 21:53:56 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/1] nvme: fix dhchap secret memleaks in auth code
Date: Mon, 22 May 2023 14:53:47 -0700
Message-Id: <20230522215347.2031483-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_145604_184570_4EA3F257 
X-CRM114-Status: GOOD (  13.21  )
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

Re-authentication through the sysfs interface without changing the PSK
will result in a memory leak. This was tested with blktests nvme/045.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/nvme/host/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1f0cbb77b249..9aff76ced4f8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3828,8 +3828,10 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		int ret;
 
 		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret)
+		if (ret) {
+			kfree(dhchap_secret);
 			return ret;
+		}
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
 		host_key = ctrl->host_key;
@@ -3837,6 +3839,8 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		ctrl->host_key = key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		nvme_auth_free_key(host_key);
+	} else {
+		kfree(dhchap_secret);
 	}
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
@@ -3882,8 +3886,10 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		int ret;
 
 		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret)
+		if (ret) {
+			kfree(dhchap_secret);
 			return ret;
+		}
 		kfree(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
 		ctrl_key = ctrl->ctrl_key;
@@ -3891,6 +3897,8 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		ctrl->ctrl_key = key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		nvme_auth_free_key(ctrl_key);
+	} else {
+		kfree(dhchap_secret);
 	}
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
-- 
2.40.1


