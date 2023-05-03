Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D759EC7EE25
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 08:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=blxJG8cSb9nAOdVRY3eSjODYe9Zj/GUTrxASYKRPMLY=; b=JvPmCPMI9+F+8DffeRswbuAiNj
	XLSZrHi+j/GDciYQt1hpM81tFe+OdKlcV/NvQQwIyBlib+7LfVeSuegS0rJ0SGhNLWmG3Jqn5tKmI
	/jNWomZoCy4iq5mNSWq062i+aKVqVLrI64brhSftVfTIVbDtftNsnrU4SAt8zF9NqpLYdQPJmgHaI
	OINHu+h4rQaTwbFKvjwrxLx9zpbnljSlG0lgi0LW2nANwNaCyJsLDqXr0GiK3OHYWvHIRqMyLatEw
	U1Ah/kBLoLbEDiknIsRXUQD3w2bIEr104rNsuf+X1BUD+D5kZXdv9+lCO5LTUlvQkjbgouuroBq7Y
	SN36JO1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SJ-003kGE-2U;
	Wed, 03 May 2023 08:03:19 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SD-003k9G-16
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 08:03:15 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24D9D2233B;
	Wed,  3 May 2023 08:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683100992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blxJG8cSb9nAOdVRY3eSjODYe9Zj/GUTrxASYKRPMLY=;
	b=bqoL0PAsnBVoBT+vIpTrr9Jset9nzF3lrBJXsVMbuSoNhTG2zu6/wtaluV7O2LU2DutVGG
	Z9v54fs4JRFGFQmHGwyaMDvWYnvoTpU5kBfvkFUgS/BKHxPUb6Z0o4PS8oW1YWJFBDe3hx
	TM2dAwYZQVVesKKsft+iGmk7pS+MWxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683100992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blxJG8cSb9nAOdVRY3eSjODYe9Zj/GUTrxASYKRPMLY=;
	b=8KqA9O/ZNgmjUTpiONgED2mK5EzNsj5MZmjAK3nxMQFj4gGQ9Hl/a/HixnskEhFE4P+HAW
	63To15r+HFiOQ7BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1696A1331F;
	Wed,  3 May 2023 08:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8VA0BUAVUmQzYgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:12 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 04/12] common/xfs: Limit fio size job to fit into xfs fs
Date: Wed,  3 May 2023 10:02:50 +0200
Message-Id: <20230503080258.14525-5-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503080258.14525-1-dwagner@suse.de>
References: <20230503080258.14525-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_010313_525979_5F567F7A 
X-CRM114-Status: GOOD (  10.89  )
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

The usable capacity of the filesystem is less than the raw
partition/device size due to the additional meta/log data.

Ensure that the job size for fio is not exceeding the limits.

Because we have hard coded the path where we mount the filesystem
and don't want to expose this, we just update max size inside
_xfs_run_fio_verify_io(). No need to leak this into the caller.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/xfs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/xfs b/common/xfs
index 413c2820ffaf..37ce85878df2 100644
--- a/common/xfs
+++ b/common/xfs
@@ -37,6 +37,9 @@ _xfs_run_fio_verify_io() {
 		sz_mb="${avail_mb}"
 	else
 		sz_mb="$(convert_to_mb "${sz}")"
+		if [[ "${sz_mb}" -gt "${avail_mb}" ]]; then
+			sz_mb="${avail_mb}"
+		fi
 	fi
 
 	_run_fio_verify_io --size="${sz_mb}m" --directory="${mount_dir}/"
-- 
2.40.0


