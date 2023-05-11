Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9139EC7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=blxJG8cSb9nAOdVRY3eSjODYe9Zj/GUTrxASYKRPMLY=; b=UWaXH0Mv/58vkDtQTonYtnT0yf
	9+4ShUIl8qzbJDN4nawQYUDdyw8P7rv8dR/cP05OAZsR2ebJs22s+V7uaFhByc8XvG3ONQ5zyoT9X
	iUm6me2kXUIjY5rfOYbh5VqkcUPAoD0/9VSy8jKHRXUeUz1dNQ14VZaTHxv2FHnI6DqteFCc6u04y
	URnPFsjuQ3YQrWFxKUMnsG8Gsv9db9dYcluQxvijegVP4rRQeGMqn8FmAONZu20tTDKK3XDIfpl0K
	+EpWD0mUCYEEvIdf4eJPS3E+E1kD/liMfv3RVIRA8YvQPgaqh8RgM/B8InH2edguHDSA79A6r3igR
	4Cvq8G6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px6zi-008ydT-2x;
	Thu, 11 May 2023 14:10:10 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px6zg-008ybc-1v
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 14:10:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 653321FEFE;
	Thu, 11 May 2023 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683814207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blxJG8cSb9nAOdVRY3eSjODYe9Zj/GUTrxASYKRPMLY=;
	b=dM/I2q/UQK2R07M7bunrP2cK3vtkIrs3oRdNXboTpYtETDyKfFgXL8EWz+ewSS4++IGBXL
	0/8urNH58ilhIB1tMKcWoHES04VrZEGp6Xb7Fmg+Y03kJzDA2jzPsZUJi41gDaKW4cj+A/
	amtCufaH8rrMzg6geF7AWM/DFWqXgNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683814207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blxJG8cSb9nAOdVRY3eSjODYe9Zj/GUTrxASYKRPMLY=;
	b=5bHvKi+hhm7I9XfJQuEYd+NonkyMvnbkfieEJaqHqajxVhwsQXH8Pq6tyb1jziOf6WUxsf
	9pwSIGxPcqUirdDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15AB4134B2;
	Thu, 11 May 2023 14:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id kVEqOD73XGRmPwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 11 May 2023 14:10:06 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 04/11] common/xfs: Limit fio size job to fit into xfs fs
Date: Thu, 11 May 2023 16:09:46 +0200
Message-Id: <20230511140953.17609-5-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511140953.17609-1-dwagner@suse.de>
References: <20230511140953.17609-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_071008_780202_0966BA3A 
X-CRM114-Status: GOOD (  10.49  )
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


