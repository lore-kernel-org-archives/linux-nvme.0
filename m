Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A965BC021A0
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 17:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0guEuJNvlGkwonkHXf3ZKU0sySDKrB2+MAVSsNCun0o=; b=US7pKoy7Sq2ba6H8mrivLAWZwA
	DD2Ifr5DvcLtIELghk4Gp69eiJTv18vDhjpq43/B9LkQMqDtnEf/b/Rpwvb0wQyd55e/6SC7SaOH4
	QC7N5zZX49D7ij0LtcyLGoNnog5QkBN7KTGdPxvqfGL7pYprkwr4xN/+zOytWJCCCvkYFNJWRiHA5
	6wx9QJhWpUOWuQS/cTxaVJbDLAHgRhzzOS+piyJqa47Y138djVOt3mGJwX06pDzZXbf/6wmho9HBs
	pwKyrObXtTPle0WKOQmAEexg4iT9lCPLoGrsoCXe4iWjOZ0nwQfrXlu+XMmgz9d4iQeaSZXwcOclP
	6zKr7/Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tidQ8-0000000C5nT-1d9x;
	Thu, 13 Feb 2025 17:54:40 +0000
Received: from mail-pl1-x664.google.com ([2607:f8b0:4864:20::664])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ticeb-0000000BwNl-09DH
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 17:05:34 +0000
Received: by mail-pl1-x664.google.com with SMTP id d9443c01a7336-21f6fb68502so2849545ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 13 Feb 2025 09:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739466332; x=1740071132; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0guEuJNvlGkwonkHXf3ZKU0sySDKrB2+MAVSsNCun0o=;
        b=WjBGfgcI+HBrj5P42WGKM2WKDakSgRENSlYnV+iWkQT6iLSG+EmtI3UuZP6FRTB6zz
         9AV0szei9REki7OeOr9iMW5v/n1PN/TKtlxX95w+iHUjAlg7b4hGLVAAru5yEw3hYItG
         UQtcheVOX4OM+dYRtjRbxX7ZyshPhTXO1J0J7FlVqo8A8vRCjDZVpbNt+p+DMd6K1MPV
         Ok4x248bpK1ALms3UnKqqaAOJoJ/igjxhthk054pba+eZRFycKI2HCyMz46Qn37LjeM3
         EqE9duxEtsioZmBxCdBEQJHMf8krfg6OGwcruR6x5crUi5u5g35DAKk1gnW/j4BuhjMs
         JxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466332; x=1740071132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0guEuJNvlGkwonkHXf3ZKU0sySDKrB2+MAVSsNCun0o=;
        b=fB44lsHy1ZLZ2E8IDdizVfYpgdeGHgep2yW4IYCw28yXzHl+Gt0x249C6iQTPUG9yy
         GCp6zPaBMp5DXVC1x7QEKaIklOPcRGMIiETstNQ4ImsYKziiRIpemht1bd72aWJvvk4N
         ywh+54abqbtqpyDc1HB8Qon0WnusvN83t+Yq7YJplWJ1XiloI7P1Dqs6ZnBM/Y0FXCD4
         SYCIxCHPpGX0N3UFyzYNbx1p582o6nTJCC4l4g5bNf8UAgV6rnrrwnv7ryLhJ6GNOksj
         AZNOKWXijn889x32N2eTqQLDFWY/OeK5iSEdu1Z3E3ua22udpHI+vL34uBiijPVSzDeG
         jOFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0BdYaeB7iBE04QP4T/1w8ztKoH8kQxoq7GgqMY+5FTt8g/q7cX4POx8gj8X3wwmppeWWvwhBegPj@lists.infradead.org
X-Gm-Message-State: AOJu0YzhOQlc6X5HynHzT3Cj4+hmCtFmBfsHDZvjctImVZ/MAlH2vz2x
	huegsg1UbnDGN5CIo1cxRUO4Kwd6ys50jIkDqZlUMTnVCf1mWwO3cWwZ/JzijAuBZOBsy24fSLr
	fJyxs/jY46pu6zCk96qfRoFqIe80bFy1i
X-Gm-Gg: ASbGncvlJ5ffe+ovlpn9I+c+8CV+DLow7uUmGVh9cVtfd+9k8Bzou/B6mxB8gzSIcm3
	28y0gSgQNN0eEn3Q8+RbzXd+nBlnjcy2pcohpseNtdoriJ8PtRCzhuAMwWnMQHCO5eCVMgjJHC1
	VHKI+siDzsgkhCzj1/qnlNiQouqpiK08MRdQZXXSbghPSQ0yJkuoB7uzP0KU4pU51ZoI+88t0X7
	KOS1ovSqNVwF0A4x0f0d+3T8wwP7BhqvB1Dw7l3tv9+UKcb8fXBB/hZQ7c0cwwlwMYeerNImiUD
	Gm6z3GnieGYuvWL0HtTsj336n6Weuzbaib2ckQ==
X-Google-Smtp-Source: AGHT+IHURWcUxjpQh1hRezwaV451EcRATWFvIcuc8EXv7EdaGhXS1xW89EtTfCobKSrnGs0I1/3+UwR9EHZz
X-Received: by 2002:a17:902:ea01:b0:20c:5da8:47b8 with SMTP id d9443c01a7336-220bbf3284amr50146265ad.5.1739466332019;
        Thu, 13 Feb 2025 09:05:32 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-2faa5d0caa1sm63457a91.1.2025.02.13.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:05:32 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 633E934022D;
	Thu, 13 Feb 2025 10:05:31 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 57A64E416E5; Thu, 13 Feb 2025 10:05:31 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme/ioctl: add missing space in err message
Date: Thu, 13 Feb 2025 10:05:14 -0700
Message-ID: <20250213170515.4027908-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250213_090533_125688_C96D598B 
X-CRM114-Status: GOOD (  12.42  )
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

nvme_validate_passthru_nsid() logs an err message whose format string is
split over 2 lines. There is a missing space between the two pieces,
resulting in log lines like "... does not match nsid (1)of namespace".
Add the missing space between ")" and "of". Also combine the format
string pieces onto a single line to make the err message easier to grep.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: e7d4b5493a2d ("nvme: factor out a nvme_validate_passthru_nsid helper")
---
v2: combine format string onto one line

 drivers/nvme/host/ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index e8930146847a..b1b46c2713e1 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -281,12 +281,11 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 					struct nvme_ns *ns, __u32 nsid)
 {
 	if (ns && nsid != ns->head->ns_id) {
 		dev_err(ctrl->device,
-			"%s: nsid (%u) in cmd does not match nsid (%u)"
-			"of namespace\n",
+			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
 			current->comm, nsid, ns->head->ns_id);
 		return false;
 	}
 
 	return true;
-- 
2.45.2


