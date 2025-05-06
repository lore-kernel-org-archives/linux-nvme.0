Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DD3C3ABB6
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 03:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KfwuFNjnwYq742pTkVlD5AwqxHpW+jmv6Vu1r1qh30g=; b=L2g/561IouIKPJ6DjPu7n/b8MO
	GtoZyKM4Awm0ECNimVOZ6c7VFKTnQ8Wfk3p6Hned3n7oCc5+og50in05S796ujl3Xzaa4e/tg9c2T
	tGe+DFIT9Om9/LTPGWQyuCm2R6Tf//4fwD89mLPx+LtNHKnjAXaGlv0KsbXuYqG3qF8VKQVAQdHO9
	s/OJEs7zT0ktRDO9yPVLFIr+yxzPyGFE6XhFdF8A7vib0FEJqlYb7B/O9l+nD4HDkv3mTCGlYOQtO
	HUFyLaj7IxYmoKmW1RrmGL/lgxwF4MXw9ZW5RHVT/HQYHBPMSXzPUfT8Ksv+4buioXjtqY3qAFCpx
	+KbfRntQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCVjw-0000000E786-1U9A;
	Wed, 07 May 2025 03:46:36 +0000
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCQDb-0000000DUB7-1R45
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 21:52:52 +0000
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-e755cd8c333so4863204276.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 14:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746568369; x=1747173169; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfwuFNjnwYq742pTkVlD5AwqxHpW+jmv6Vu1r1qh30g=;
        b=nc5Kqfgo4MLqUOap8fzj2XM7r6Y4AR4u6jfSiItv1NIEJynYkN1F3EtBPgO8tR8qsY
         /F5cjvVQOrwg5uf5LSfhfFGtnLc78GDtLIXfo+rZGfWuu2pFyQF5rDmxb7Hs5G6k5Bne
         kewSAP+lzG5Jmy6CDPjUx/kY3CumPkS7f2xlkThl/6qhwMPsDhh6QWVu6xHWeFtiD9Z5
         BKKOdFDev3ZG1Ux4pyNQcUjVdCV3GqoHGVPhpMqNygFXldfkryg6CW8Bc/3TX6diwNVe
         UB32pO0xqyft8OW+6VpnIfXJUlqEtwRaqP1IVddMAnArcTezLWWgRfdMKLks0TBoqRSD
         UT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746568369; x=1747173169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfwuFNjnwYq742pTkVlD5AwqxHpW+jmv6Vu1r1qh30g=;
        b=iF3Y6d7mqhrPARPIlu6s2cdGCJgnh4himPblmJlrZk/heSwQRFlOwwZRHLM4VMPFWf
         WaSDyADAv3kVSB0gSmyonlpTfG4n/4orLtfjUWKSV4c/U7PEtexmprpbAEvi5036/jDT
         YApzvcbixx8krDYK96SpnUNUerr0XQCpdTK34O28syZmcmgstETD5SOQMsVHmgaMsbq/
         uiesXnAlzyV19RIOpT9gw+LcArAdhl41pIE6Nx76uama39E1z5PzUdNUMdwfMMExFm5v
         QZ+iMswF87RnARaYLs+P3DIFMxoHN62gkWW9TdLHrCrY0sgTTWmpZXkDUL5/M50Z2qlu
         9Z+g==
X-Forwarded-Encrypted: i=1; AJvYcCXb/7lFZt/+VrzUyaYSBOhvKxIde5MoskCNDhRNwRon8E1GWShBC1xSoHDIOV57+2NaBvruW3WUkFXo@lists.infradead.org
X-Gm-Message-State: AOJu0YyWvRYIWWKkiSYZFo+/FMrmOH5g96NYpuXcOaSI4IWgS2rrljbJ
	ffELaTdjSwSvFHv2q2NJ3E4DDkpN2+y7GIiEd9eBomMPaL9H6aPBQt1pJF0dPYSbMrvBgKP4HTq
	XK9rFlaVg594FWnIKHva+GhgJoxsjLZSp
X-Gm-Gg: ASbGnctirczf64nUHGHgtB0mw5ZTghCBpeLLbBsgGuyzcipdzo21ZZCUO2ujtCEJ97L
	h3zfVuzK+z1rTmCIUEBeniyyBq5QHnJ9qdGAkeFyK42megiGYCYdsKipAmB6MsYfmxrlE3bvZRy
	S88yDEe3Y4wgQ2MNOM642Dzy0=
X-Google-Smtp-Source: AGHT+IGPwZFY4JCmDdrqeRTyjkJySiSolJse3LJ1tjw2nijvhsdXSnCKRfpjXdouce11y23o0SrfOsowLaZAzJe/P5s=
X-Received: by 2002:a05:6902:1009:b0:e74:2b67:51cf with SMTP id
 3f1490d57ef6-e78804bbafemr1296780276.10.1746568369090; Tue, 06 May 2025
 14:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250506153507.83094-1-hare@kernel.org> <20250506153507.83094-5-hare@kernel.org>
In-Reply-To: <20250506153507.83094-5-hare@kernel.org>
From: Justin Tee <justintee8345@gmail.com>
Date: Tue, 6 May 2025 14:50:50 -0700
X-Gm-Features: ATxdqUHZLcaHtfODKGbYOjZfipABcZqFZ3ISCdrXXic_UsJhRuB0Ne-uSIDJQSs
Message-ID: <CABPRKS-ns8r6vQW1a3cpyQYXO0FszKyngY6CJ6aHhHofpB0Ejg@mail.gmail.com>
Subject: Re: [PATCH 4/5] lpfc: enable FPIN notification for NVMe
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, Justin Tee <justin.tee@broadcom.com>, 
	James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_145251_378528_1EEB7F2F 
X-CRM114-Status: UNSURE (   8.84  )
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

Maybe the last tidbit from my previous email got lost.  May we also
exclude lpfc driver=E2=80=99s target mode from calling nvme_fc_fpin_rcv?

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 396ed1a05bc9..09713cc57e94 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -10253,7 +10253,8 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport,
void *p, u32 fpin_length)
                        fc_host_fpin_rcv(lpfc_shost_from_vport(vport),
                                         fpin_length, (char *)fpin, 0);
 #if (IS_ENABLED(CONFIG_NVME_FC))
-                       if (vport->cfg_enable_fc4_type & LPFC_ENABLE_NVME)
+                       if (vport->cfg_enable_fc4_type & LPFC_ENABLE_NVME &=
&
+                           !phba->nvmet_support)
                                nvme_fc_fpin_rcv(vport->localport,
                                                 fpin_length, (char *)fpin)=
;
 #endif

Regards,
Justin

