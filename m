Return-Path: <SRS0=58/p=4Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297CEC3F2CD
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 18:45:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D2D24677
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 18:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oY9XmNr9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWNH2JBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D2D24677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FxHBjXzCpdm3/lQohfD+Itx5KTSfAEVKVahjqd5ceTA=; b=oY9XmNr9XyVzTx
	dgH7NN+Q8+eaYG+hsRIlS89ac5/WYpTY9REnk4brj8VHJAV/Osq8W05f9xdRHG6J3zwQ2wjMOeFfk
	SBhUT/uj2a6IyPbJcyIjDjp/gstQ0HODumWnYfP1DZl/rf+x+QctCyCqs25exhwkIVE+fMA37SF3K
	QM5gm8CceAF8WMsxuNAGiF5WvzdAuAGh5+UzJ+q631R9qyDn2U2HS2G8/An9mrqKmNdjNTiQ4TKj4
	XZAv5oBpboDc2sGWNicEObwm81E90cWnMN21ntLZJ5aJt0K1Qb/KMh056n5jRT2UOjOdoTQ0M9uqJ
	NH04yX381NPluGOwHtTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7kdc-0003U9-DX; Fri, 28 Feb 2020 18:45:28 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7kdY-0003Te-9i
 for linux-nvme@lists.infradead.org; Fri, 28 Feb 2020 18:45:25 +0000
Received: by mail-wm1-x342.google.com with SMTP id f15so4292581wml.3
 for <linux-nvme@lists.infradead.org>; Fri, 28 Feb 2020 10:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=FyK45DjQnht/q/10E6OWlDiPVugKRhmvRmdrOAQ4uMc=;
 b=QWNH2JByPLUf5LRLc0OVat87M/c2mDQezJnTh3eKfmBoKmrOLz1T5cJbjmHHtlKnO/
 w7Z571UQMcj4/XbAy889ZdP7/geRj+VzvnoeN0t+U01qkelUUs1NrR5BLd3sApe+37gC
 06RXqyzxv8YxYx6u6akJAOOYJ6zf/Y0ei8BVpOzdG/bgpEpBO+xMi4URPbFPKofdu+Qs
 ejIpA3xltSZKrW0wcYzvu1bfITDGL1Obw4ugaqkICvCE7NHKp7JATYE4vPoMkEPmpu1g
 zHWA6ssQwC8AG0eJPTmohTbPxbk4rGM9g/4Ip/6HGNleMh28vZb3IhFHZhePWlInX8YZ
 Yb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=FyK45DjQnht/q/10E6OWlDiPVugKRhmvRmdrOAQ4uMc=;
 b=OBN2wF5ioJAWyCPThbhqW1BazT/nu2hZyysCrVsm4KFWp2Fhi9XglINtpHr9AXmKVC
 MYFe26w39wKzM45KfcsdWvBS1uNtbX5l94NoXznh45tACX3svELkli7dTYto8z1kfaNX
 3hC6aWJpm006h0NYxguf0vc6mURoIixoZalT0XB8VzvC6iAx9z+SVjRhidQkLNJASYB8
 B3M1nojw6M2DfR+y0c8u3E9sojWRUy+AHbZwZeNpywmGZsEjHQWXvAkz9CmOTGo9v+VS
 fu7ewHAvrV2jQEptUDh/CdYGFy2PfcHNg2kbOtFynsaWZVl6jKCboP6jzDvk1U3ABp7n
 0nRA==
X-Gm-Message-State: APjAAAU4W2A8MVTTroN6ozhu6RBZAAadCSdPmPx+cnikUOOFD9rnK2km
 fuUEU9Qbw3thrEKb97H1dsCmhxo=
X-Google-Smtp-Source: APXvYqzPfli1SD8Xk4ml3v57LTn+bJQ12y41FrQMeC2q+Wf0UEgqEf8sgMw1imGNzVo9rA8t6XHy5g==
X-Received: by 2002:a1c:f71a:: with SMTP id v26mr6180524wmh.85.1582915522149; 
 Fri, 28 Feb 2020 10:45:22 -0800 (PST)
Received: from avx2 ([46.53.251.159])
 by smtp.gmail.com with ESMTPSA id b21sm3261291wmd.37.2020.02.28.10.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 10:45:21 -0800 (PST)
Date: Fri, 28 Feb 2020 21:45:19 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: [PATCH] nvme-pci: slimmer CQ head update
Message-ID: <20200228184519.GA2281@avx2>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200228_104524_340528_09D7941E 
X-CRM114-Status: UNSURE (   8.93  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Update CQ head with pre-increment operator. This saves subtraction of 1
and a few registers.

Also update phase with "^= 1". This generates only one RMW instruction.

	ffffffff815ba150 <nvme_update_cq_head>:
	ffffffff815ba150:       0f b7 47 70             movzx  eax,WORD PTR [rdi+0x70]
	ffffffff815ba154:       83 c0 01                add    eax,0x1
	ffffffff815ba157:       66 89 47 70             mov    WORD PTR [rdi+0x70],ax
	ffffffff815ba15b:       66 3b 47 68             cmp    ax,WORD PTR [rdi+0x68]
	ffffffff815ba15f:       74 01                   je     ffffffff815ba162 <nvme_update_cq_head+0x12>
	ffffffff815ba161:       c3                      ret
	ffffffff815ba162:       31 c0                   xor    eax,eax
	ffffffff815ba164:       80 77 74 01      ===>   xor    BYTE PTR [rdi+0x74],0x1
	ffffffff815ba168:       66 89 47 70             mov    WORD PTR [rdi+0x70],ax
	ffffffff815ba16c:       c3                      ret


	add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-119 (-119)
	Function                                     old     new   delta
	nvme_poll                                    690     678     -12
	nvme_dev_disable                            1230    1177     -53
	nvme_irq                                     613     559     -54

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/nvme/host/pci.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -982,11 +982,9 @@ static void nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end)
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 {
-	if (nvmeq->cq_head == nvmeq->q_depth - 1) {
+	if (++nvmeq->cq_head == nvmeq->q_depth) {
 		nvmeq->cq_head = 0;
-		nvmeq->cq_phase = !nvmeq->cq_phase;
-	} else {
-		nvmeq->cq_head++;
+		nvmeq->cq_phase ^= 1;
 	}
 }
 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
