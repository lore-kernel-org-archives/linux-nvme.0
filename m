Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2E2C369D5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 00:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eXiERkLA7yuiD/WWQ5j7ldoL76oti+3ntnUwAl7rlLU=; b=QEo0UOUwioU0o853LghISn+mTK
	tAXPIXNeNLOYVh/NfuJaM+0NMNkDDZHlCtMMCaZV0eDQk1pLZs5725fiws5zDmCoD50bWQUcy+TO+
	HlDGxyEVSiF6fcPp3qvIySxt9Gt4GbBwGl6jD2Y5PxR1mqNVuiHp6QGT++PCM/TzUhu8HutWGkwq3
	JNLnSEJJKioFwkEn6mw0KHC1S8cwvuRDfvFKwKF+08Hj+8ZIjbrvp4s3pdb7HSgBNmyqFbGU+I3QH
	+KUYzZ7HtpHeDKe/9HtxY3ZiOCCEqxYZoq9xNaJyNc8KWRvrzQrGiE50zP4M95Pw6YewnovRAMDIr
	+8Suda9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Yu8-00000007toD-0xFu;
	Tue, 29 Apr 2025 00:32:56 +0000
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Yu4-00000007tna-46ee
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 00:32:54 +0000
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-6feab7c5f96so49191127b3.3
        for <linux-nvme@lists.infradead.org>; Mon, 28 Apr 2025 17:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745886771; x=1746491571; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eXiERkLA7yuiD/WWQ5j7ldoL76oti+3ntnUwAl7rlLU=;
        b=dXxPxFavSY9S7R4Ns3Mfe0Bdu+KsrKC3gkKQOmDkADvZ6ILB2UI0CCtez2lK3iRSb8
         g/vGh0COVXbzvNGSynNcQ8zKFX8Ra+KEhKoOLMV5VPzVFouiIFBVy3ilftDfLHOGBOvk
         2HKfQY2jhVh/vCJZ8IfI+/4DKruPxob4aYZ8LWTTgfppBfZSifVeXe5uQ3srX4+u8bYE
         a8SsTV4mLNNL20IMI/hnZ8bK7n9wsNcoQT+kA8q4NaPlOOEoRElAW8K2PW5v2kyCkmU0
         5JreNrHIHGcpBNWAyr0sCW/36WyX3itXpYUvDmrUs/0IDWdaFSNJuFFLka+04E2sDbGl
         b7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745886771; x=1746491571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXiERkLA7yuiD/WWQ5j7ldoL76oti+3ntnUwAl7rlLU=;
        b=mW1JUrwE+fDuuFc43QGs1zWC98471X8n3mkoCET7VsMLy35WoZV3dfCQSDnk/e5GvX
         lY31GBTy0+nofpf09Qc85DrLcPaar/rVEUJF53EwvKJHpQs5loQ6pJKOBGJFJBoX07ph
         I9RnWpC1pd7Yc3IYHavcuw/J3IYTOte63dymxvFpYSgXc6WWLXPdJ/AEHmyBS9ding7f
         G5noc+WFT+faehBnJlsHJkKZSlyYspDM9s+B468/8xgvzukSXz2Kpwcpvc/PhvD3EhSA
         c9feXURxYnTLY8m9FjVJjYR30dRumaYhnKheGKKfeuPS3GuzmLRRj8lU3mVmfzW/w585
         D1Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXVrfetxV4NTMVIrY5H40H9ZY0ht/FnwD35erpJ4xZeagJBEM96Vvqu3+e/BirU/A7/WEX1KBpHxRB8@lists.infradead.org
X-Gm-Message-State: AOJu0YxuMxo+ifo6PaXqLkOkquV2wv4lXFWJBuz6gs9VC/yiXJsR8sI8
	qmnwMT1O56s/RKU7vow5EB9RqonJaUz3wUWgKHWasDrV8HfVlVuaFaNIemdDZDF4ha2pBOEYFZ5
	uOaisSi6iarbup1fMT/rFahzsViI=
X-Gm-Gg: ASbGnctO87vwAc1PwyW+7N9KKk3M1wB1v+Ntm3ncbRjD3im6okXCBrSAoilLNkrqdQn
	TYDMJxjrm7ilw0nvjIWLYAWshZzEYdjIbl4C79WzpIw+uHXSsGbukJpYy+RxAxfCGDC5Bqzw3Fn
	s9iTAlaF5F0MmyNNLWQbcVxCY=
X-Google-Smtp-Source: AGHT+IFg4M2EgSbzb3qG4MF8cx0ULesbJGSXGkun8LRVe+Zaz4awkpImlKHQxNm3nsUjjkmN1YFI561/qWnYk1bMx/U=
X-Received: by 2002:a05:690c:6f8c:b0:6ef:761e:cfc with SMTP id
 00721157ae682-7085f23732emr147006977b3.25.1745886771428; Mon, 28 Apr 2025
 17:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250428063635.125879-1-hare@kernel.org> <20250428063635.125879-4-hare@kernel.org>
In-Reply-To: <20250428063635.125879-4-hare@kernel.org>
From: Justin Tee <justintee8345@gmail.com>
Date: Mon, 28 Apr 2025 17:30:57 -0700
X-Gm-Features: ATxdqUHIGy0T4NGOQRb64lNlldbMWLYy1gZf40lApfT5WJfC5OEb__lGQEHepRE
Message-ID: <CABPRKS9yTExMW+PdJHnXiftck8dQQcF-RxVUt75M=P2bTnfmHA@mail.gmail.com>
Subject: Re: [PATCH 3/4] lpfc: enable FPIN notification for NVMe
To: hare@kernel.org
Cc: Justin Tee <justin.tee@broadcom.com>, James Smart <jsmart2021@gmail.com>, 
	Dick Kennedy <dick.kennedy@broadcom.com>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_173253_013923_7DF5A221 
X-CRM114-Status: UNSURE (   8.80  )
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

Hi Hannes,

May we qualify the call to nvme_fc_fpin_rcv with something like this?

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index cf1fbfb15c5d..ea76b4550e30 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -10251,8 +10251,11 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport,
void *p, u32 fpin_length)
                if (deliver) {
                        fc_host_fpin_rcv(lpfc_shost_from_vport(vport),
                                         fpin_length, (char *)fpin, 0);
-                       nvme_fc_fpin_rcv(vport->localport,
-                                        fpin_length, (char *)fpin);
+#if (IS_ENABLED(CONFIG_NVME_FC))
+                       if (vport->cfg_enable_fc4_type == LPFC_ENABLE_BOTH)
+                               nvme_fc_fpin_rcv(vport->localport,
+                                                fpin_length, (char *)fpin);
+#endif
                }
                desc_cnt++;
        }

Regards,
Justin

