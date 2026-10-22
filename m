Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E884E60A3827
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oAkOMQXp;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nsmFDp4V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bhcOKx3y9myNmTpXc9YX9Stk2q4QfYaHlPOapeiAi1c=; b=oAkOMQXpSIQ+1M
	MLD6f0sGMsZz5X6PbcIBlwYtYPJAmZdTqR5o/q+q4jYFb1gV1tVL8SNr1YradggLpVsua/d5hGeXP
	j9BK3B5Rr/gg96ZbJevjgn5lNaW9Os6iOIbXbzIGEbyGrGn9aerwUz1GK7CxCW+NLgiAWBWt4MYvF
	/12ikIJo6CkdTctGLlK4013nO1caYO7Eox224EZXTExlWKaAX5EffsuHrqVNF4H9hg9jZq8qyvqVU
	kuFNB0HfGJcJ3dEaqVcCiuBLhjLw074maPR+6YOtyPdk5BGUVw1hAM0g4WjTbwG169Q3gcWtHv5w7
	8HKgWVG8pOcR7EX3hXQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsrq-0000000ECcF-0cNR;
	Thu, 22 Oct 2026 13:30:02 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsrl-0000000ECWH-0PlV
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 13:29:58 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso23778115e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792675795; x=1793280595; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bhcOKx3y9myNmTpXc9YX9Stk2q4QfYaHlPOapeiAi1c=;
        b=nsmFDp4VjuHr9KyNO7oTDiRE9yisUVr+abnvoO7g5U9qMb5rzJfk2QFmYSWDWyTayW
         2K53KZHrbyaZbjjzCyH1jd8/hK1XpEhvBJwcnCWWVcXBY5T1UrkOyCm3UA4V3IsEZF+J
         zfi5Opmi0zx8f+1ZEyRT2nskpIEeVLIloi7I4B/mcT7ag5VgKVVX1HgSXO+RcHNP56Ea
         RbrTZPD/ANt5Y1mqTefusjgwGmO2fX+pTyjHVF52epj5r7RA0BQvkfWTala7uBL/Zaka
         Ulh22FnJ/emUpCaEjRjcn3tSVf2r/sCVK5HC+CnPwidZqZICn1RXTiEzA7j6QAqgEPCN
         aJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792675795; x=1793280595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bhcOKx3y9myNmTpXc9YX9Stk2q4QfYaHlPOapeiAi1c=;
        b=g5DHLtg15SY8lDyDMe/Y5bIlkbeNthVXLTYSgK5Q3ROIQ1Z0Y0XU5BD+SR4l+KX09e
         06ausUeBIrpQHMjs/5ShPEcHETePAMNAcB1t7Bc59m9GT8Z8btVKQe1O/STPXiAABWCW
         yPDiZPnr4s24nuIyara3pzBOw6FtimtTkpsvTVjRAsEZQqFXBHc0qDO4Wa25wJ1kyXOG
         U75ZLHFM2qrLmBUaS8NmY0A943aUQlespaTQeJW0ag6CNs3OlTvl0IdSKc2tIiDB8mtO
         oQCIUrRVoy6tLOg59W31rKFb2HW779Snu6fBB1wguySP654n8GCtjn25yi+wty4sQIXV
         yKOQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8L35cTVM7y27bQrWqTOYMY4Iwud0ixTZh/9vWpZPj24nRQjFexjX1AHwwStmFoJ4tkY6p6MFsthbL@lists.infradead.org
X-Gm-Message-State: AFq9FYIwsRjLe3cNBpZ46IlX2JHvGAJncOe9oaSCtMHLA5yr7JJ47cpI
	3Ty8ZUWCqaTB1DnTe5WfKcQuODRGA70zwiRfG5ulu58C8EnOT/dI+YNrnlDVrGTh
X-Gm-Gg: AYBFou2NhpX6DNWjfEIyrMaqKZJ20CxayNNczwWolu2Ss1Vb8WWDDfXN0UcYn8e5nl0
	AV7tdDDw20SiEoYDz6KcltlqhbYrsUMCUT3713uKSUckGFAhecEwQkorpDlWZU/Rz0CJlrb+uVk
	lWk1XKfLTlC7pfaFVWFv0KxnTkeOsAhP6RJp9sORpdBf7YTvmD5jsMNXqUebt86oGfgvX9qEgcP
	vgXhPuesY73Ko5CznxFgbjy2pAL0urGzUbEwTNfm8ryd1S+oFzPn4OAsvhqWiVCv9SBIAPC+CR/
	GVeorqxgIQWibgQpJV+4so8Ai5BKi316eaqpUQitFyLyNfWfHA9ka0XaxJbcs6sP8Pdg9KFVnRI
	kBwOEhjOoFq/2MOrOfEymTkgFdAyz74E2VxwpThaFuh/eeYGVFCZYjsSNqA1Fch2jgnvJVmn0ve
	yEZ7o7eSIzUtljIJMSd5dA7nf5/femHTzW7AM/GGQy8DKY4tNUlb0NlLZDXHRkwExz2ZglDRumc
	72g67OETPkddRWNau/5paF0U7whYUcypG+g6WzsW7nuJ/KVED3T0uM2ex23fD+wlvUr2g5ksdO9
	H17EQ6IsKyBIBvqiO9tV1Jm7AntTxoOLjloEgDZNkMf4NQ==
X-Received: by 2002:a05:600c:3b17:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a1fdd31aebmr113093645e9.16.1792675794933;
        Thu, 22 Oct 2026 06:29:54 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd629bbsm108832715e9.5.2026.10.22.06.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:29:53 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] nvmet: pci-epf: report transport errors in command completions
Date: Thu, 22 Oct 2026 15:29:32 +0200
Message-ID: <20261022132934.3592924-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022132934.3592924-1-parri.andrea@gmail.com>
References: <20261022132934.3592924-1-parri.andrea@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_062957_162499_4D285606 
X-CRM114-Status: GOOD (  13.55  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the PCI endpoint target fails a command itself, the host receives a
successful completion. This happens for a data length above MDTS,
malformed PRPs or SGLs, a buffer allocation failure, an SQ that is not
live, and a failed DMA of the command data. A write whose data cannot be
fetched from the host is thus reported as written, though nothing was
executed.

Each of these paths sets iod->status and calls
nvmet_pci_epf_complete_iod(), which then reloads iod->status from
iod->cqe.status. The nvmet core only fills that field when it completes
the request, which these paths never do, so it is still zero and
nvmet_pci_epf_cq_work() posts a success status to the host.

Drop the reload. Every path already sets iod->status before completion:
nvmet_pci_epf_queue_response() copies it from the request's CQE, and
the transport error paths set it themselves.

Found by code inspection.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/nvme/target/pci-epf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 9c28367435a59..099e8766f6d40 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1149,7 +1149,6 @@ static void nvmet_pci_epf_complete_iod(struct nvmet_pci_epf_iod *iod)
 	unsigned long flags;
 
 	/* Print an error message for failed commands, except AENs. */
-	iod->status = le16_to_cpu(iod->cqe.status) >> 1;
 	if (iod->status && iod->cmd.common.opcode != nvme_admin_async_event)
 		dev_err(iod->ctrl->dev,
 			"CQ[%d]: Command %s (0x%x) status 0x%0x\n",
-- 
2.53.0


