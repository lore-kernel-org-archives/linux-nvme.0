Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C39AC761AF
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Apr 2023 16:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KQWWvyVOMNwg10qqrGRlHZ3xI6T1/nnXbHNP0F4OczA=; b=HBSowICAdXlwZV25JIvgAwaj1F
	tRUNr/rdM1c61aQ1y8G9DU7RQpV12iScSxzAk/XWX5b6ZikPAG6B3xPOLOc8YcJMI8q7OP9rwz6Qn
	9Wlb9dSIsRTkYvfiK8JHYJUieAdZRaS5UH7HIzLdqaJoAjKVgJUCVvBb9GjU0sKa7T1Cryv13EbSk
	76pLpHYAx8n0BP9su3esUi1222VsKTyznOE4lpR7IQfJwDWR2FNl51WeO/oQN+pk1dq497ZOhJWUy
	XXkACynH618vVNwg4bBX4L4LWic3v4gu5sBLc2kZC0PXC7fKGIngzRSm/3mpme/cMokAsIvzlerfw
	SvsusLJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pk6HE-0059e3-2Y;
	Wed, 05 Apr 2023 16:46:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pk6HE-0059dE-0B
	for linux-nvme@bombadil.infradead.org;
	Wed, 05 Apr 2023 16:46:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=KQWWvyVOMNwg10qqrGRlHZ3xI6T1/nnXbHNP0F4OczA=; b=kaAZTvurcpZzJAybD+adFVFdwx
	xnUU3VL30DgbbZuGnwgidP2ywvL+Nk6zpvmMpzsoWVkFzEKl5laeUW7ByCoqP/cHsTVlf8qT3CXKL
	qGAGw6pvzqyYy412gFx/3aYSIlWdL/dDG8V6kS13IiJ+6qkwfed9M4tkRiYeNqiJ2+utspHj4OUe7
	f/1jD24vdB/S3GCGyRG5iSi7IEkl5cswULeW/+fOzCN5lh3Rr+/6nonw4XM4u7Re1VZf5kXioFTQV
	X+IZh2ldoc0F6XoDQFZ2HZnVGm78Zle3g8ZPbq7fVxh16pgcN+4dVQM49+E03keog/7nuFcQjPC3U
	ZyBBYrtg==;
Received: from smtp-out2.suse.de ([195.135.220.29])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pk5LK-009zh5-2A
	for linux-nvme@lists.infradead.org;
	Wed, 05 Apr 2023 15:46:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A47EA1FD64;
	Wed,  5 Apr 2023 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680709595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQWWvyVOMNwg10qqrGRlHZ3xI6T1/nnXbHNP0F4OczA=;
	b=he8paOLy12grTI42eoR4LxgQ4eciguZHWMo+4M+xpoV2HRqjd1rz80539nibOfw09JsjmS
	JhV7QLcYqU23WW9l751NrmfqhgJLguIi99Q5NCdYfxSYyxaUXuhbQf8bfl6dy/S7i6DGd0
	tPzn0/Ktyq/CKyFNlWso5s/7wAe6SNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680709595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQWWvyVOMNwg10qqrGRlHZ3xI6T1/nnXbHNP0F4OczA=;
	b=dypq+NkheZxu3UIuQaAWUJoE1BcJzHM0SFkJO3Y5nKLUIMoS2Txw5N0hjtMSNbZgXnHlHT
	/fUdeAluOJwn++Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9510913A10;
	Wed,  5 Apr 2023 15:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 5E9jJNuXLWTaNgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 05 Apr 2023 15:46:35 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v5 1/4] nvme/rc: Add setter for attr_qid_max
Date: Wed,  5 Apr 2023 17:46:27 +0200
Message-Id: <20230405154630.16298-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405154630.16298-1-dwagner@suse.de>
References: <20230405154630.16298-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_164638_839378_C0DD8B05 
X-CRM114-Status: UNSURE (   8.57  )
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

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index a3c9b42d91e6..ec7678dbe09e 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -617,6 +617,16 @@ _set_nvmet_dhgroup() {
 	     "${cfs_path}/dhchap_dhgroup"
 }
 
+_set_nvmet_attr_qid_max() {
+	local nvmet_subsystem="$1"
+	local qid_max="$2"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	if [[ -f "${cfs_path}/attr_qid_max" ]]; then
+		echo $qid_max > "${cfs_path}/attr_qid_max"
+	fi
+}
+
 _find_nvme_dev() {
 	local subsys=$1
 	local subsysnqn
-- 
2.40.0


