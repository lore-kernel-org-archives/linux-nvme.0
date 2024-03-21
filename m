Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692D1C54E68
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 11:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qESwvGMvANqaY3Icr9sfur8OsYwyqrb2vJVNIQj9xio=; b=a4Y9erbmUzMZLY5jm/i+3VSzCA
	t6+pqYaFZQaq18pd3QhBUKRVlcCL1rQJigkYXigZfEeFaitmV7nnBxY4FLgCIyhBApZG7gkx/S7pZ
	u248Vf/VTuXg1n0pLaedShq9eQpFv25xp0IM5o4iS/+l1IlrFzNFIJdCbVbyaxbHIs+yJUstMaRtl
	DcLMb5953/BXHN99dmsw+edeLILR2rHqoaMOy2yJEBoYDufttlW3qSpkyVi2jBTaTHeOXxTL1sa8L
	7soapf0mAMvM6jeou9qCa/+cQyxBZumn3UXhwlwJIrRWuY+LeCFAf4GkIJLtgpNDA/gj6QRS+CyBL
	7SsPGBRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnGC1-00000002i4p-0fV7;
	Thu, 21 Mar 2024 11:02:41 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnF1Z-00000002WqE-3XY6
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 09:48:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EA9F5CBC7;
	Thu, 21 Mar 2024 09:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qESwvGMvANqaY3Icr9sfur8OsYwyqrb2vJVNIQj9xio=;
	b=y6I8OlI3eiohxtV9+4OabLjUsNVYQFPtcY/cZSM0fE93nI1JGa7KGXmjEH7h3kycPbQ4K+
	DdD1OAOf8EbkpvDXWeM/jwPNUnmBhWEDP1hikf+kdhvn0h9lkMFOsc1MOixO4vaovbmWUN
	iDAbe80TQRCDqvn6PPEmkv4XMsSh0II=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qESwvGMvANqaY3Icr9sfur8OsYwyqrb2vJVNIQj9xio=;
	b=4SzaR9+i/cqhcvNAYXzw7L6HWU0TvFTHlcBAKYkHycl+bWZo9j14ubjQV95/MFBx6JBSI/
	tkUfK693sAvnG6Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qESwvGMvANqaY3Icr9sfur8OsYwyqrb2vJVNIQj9xio=;
	b=y6I8OlI3eiohxtV9+4OabLjUsNVYQFPtcY/cZSM0fE93nI1JGa7KGXmjEH7h3kycPbQ4K+
	DdD1OAOf8EbkpvDXWeM/jwPNUnmBhWEDP1hikf+kdhvn0h9lkMFOsc1MOixO4vaovbmWUN
	iDAbe80TQRCDqvn6PPEmkv4XMsSh0II=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qESwvGMvANqaY3Icr9sfur8OsYwyqrb2vJVNIQj9xio=;
	b=4SzaR9+i/cqhcvNAYXzw7L6HWU0TvFTHlcBAKYkHycl+bWZo9j14ubjQV95/MFBx6JBSI/
	tkUfK693sAvnG6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C9C113976;
	Thu, 21 Mar 2024 09:47:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XNGuATkC/GXbDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:37 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 11/18] nvme/rc: remove correct port from target
Date: Thu, 21 Mar 2024 10:47:20 +0100
Message-ID: <20240321094727.6503-12-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321094727.6503-1-dwagner@suse.de>
References: <20240321094727.6503-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.68 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLm9s6cmri9k4spo5w97m8fq33)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.11%]
Authentication-Results: smtp-out2.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_024750_249162_5AD38CE7 
X-CRM114-Status: UNSURE (   9.99  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Remove the port from the subsystem the test wants to remove.

Fixes: a12281b8320f ("nvme: introduce nvmet_target_{setup/cleanup} common code")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index ba83f32febb8..d74a5418557d 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -869,7 +869,7 @@ _nvmet_target_cleanup() {
 		esac
 	done
 
-	_get_nvmet_ports "${def_subsysnqn}" ports
+	_get_nvmet_ports "${subsysnqn}" ports
 
 	for port in "${ports[@]}"; do
 		_remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
-- 
2.44.0


