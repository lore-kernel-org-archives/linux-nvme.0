Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF15C001DB
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 09:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RiLrAjI/PW50HvWlrm+PJmGFw1sGaHe93CcjuVC440I=; b=sCkpRDfgsvzf0oGC/OZmDKGd9c
	r3jJOMpc6WNJvfIMSuKFDasa6qvvL7ZBP/RjHkYWk8y3SqwgI+fHSoLjtWS4I3uuOsa610fc5xGQs
	UiqS8yvbfMdzJkDP8FReGCvHukeCh791y6tV0mC4ESazx0y4N3MPYRW3Jzx6oEIH/yXpZ2xT6Fk0u
	y/EZaD5C2iaCXmRMzoUN5n38bVItFcW+BuxDsZQqF8Yo+jsoLnYxH2fghi2Y/UqXZMW0QmQ9nmGGa
	mbH952ELsGX33sf2lwwS4h2A9LTIqEskLoma3vWrOlzxzN78GLwxMeD93oMMnSjXowY5PvbDShlt/
	tAbimIrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUOZL-00A06y-14;
	Fri, 11 Aug 2023 09:36:31 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUOZI-00A05W-2K
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 09:36:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 87CED1F889;
	Fri, 11 Aug 2023 09:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691746587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiLrAjI/PW50HvWlrm+PJmGFw1sGaHe93CcjuVC440I=;
	b=oNqi5h5/zwJ1tvBsN0wv/SlP/ckB3ZsZQeRvjdmqQmV1LuGJy5Vt10BQT8dVNhusqUYI2K
	ZrhGewvKeqltHEfEBZarAhXgpYLCELx/YYHM3BzeDZaGFCIBY1K2fFLC7SHosNc7B4GQ7Q
	L+6JHtwq9/MUE6cw56JQM0C+0+nD2zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691746587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiLrAjI/PW50HvWlrm+PJmGFw1sGaHe93CcjuVC440I=;
	b=To25ejZnOeNxcNud8cyUIGi/7vGMfwzsD6lcY5HU33O0SqROpVN7qUjg9uqOcGY4OAmleD
	v5KXjZEQqhODwNDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76265138E2;
	Fri, 11 Aug 2023 09:36:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 91rlGxsB1mSrHwAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 11 Aug 2023 09:36:27 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart2021@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 03/13] nvme/043: Use hostnqn to generate DHCAP key
Date: Fri, 11 Aug 2023 11:36:04 +0200
Message-ID: <20230811093614.28005-4-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811093614.28005-1-dwagner@suse.de>
References: <20230811093614.28005-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_023628_907447_02234603 
X-CRM114-Status: GOOD (  11.28  )
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

The key is supposed to be derived from the hostnqn not fom the subsys
name.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/043 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/043 b/tests/nvme/043
index 4a37f91e50c3..b5cb8378681e 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -37,7 +37,7 @@ test() {
 
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
-	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	hostkey="$(nvme gen-dhchap-key -n ${hostnqn} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
 		echo "nvme gen-dhchap-key failed"
 		return 1
-- 
2.41.0


