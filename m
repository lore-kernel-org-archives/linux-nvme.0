Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57473C3ABA5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HG98OKRKV7KQ7Zt3pam/rRWORZSyCPBdGUM9BZPIIoA=; b=eWlL79LahWdidlsLQUn8eIrfTf
	IfoI/Dgkoso48m9HNK4dAQIokw2XjSymq10iFAwvXijMBkrTSYkSJFwJAg0YpRJOTjnlo8QcTmee9
	N+eAYnywQ7uMXh67B9ZeWwTUCdHPlc5/xc7is0XMdMpSspQrfty1t7qjI3AaIrbSB04YeQE/mTvhn
	XXIAyuEXxu2FyWyaiJU8QcmwVVII+rhLyV0KQRq7t1QinH6ZXw/UlNp19YrXLCCw8g/ibaTHjXS7d
	W/4cRy89JWZ1/Wt493u4Nls6JXL+f6/T+7Q4TasUfjgPqXNoLhIdk9GsJi93QbI8KeBn8n0uLTlvM
	IW/mt12w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9sX5-0000000ArNF-1h1c;
	Tue, 29 Apr 2025 21:30:27 +0000
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9sX3-0000000ArMd-0lqH
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 21:30:26 +0000
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-7081165a238so50424377b3.1
        for <linux-nvme@lists.infradead.org>; Tue, 29 Apr 2025 14:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745962224; x=1746567024; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HG98OKRKV7KQ7Zt3pam/rRWORZSyCPBdGUM9BZPIIoA=;
        b=PYo4aKhzIq+w53uvnLzmZEv3j7krwrxlClHooWiLlHZniCkFFQy97ytdt/lcFYCW72
         hoqZ+ukI3dx4Hm2GyPpBnKdkIISlMy2ck0S35qD8L0PfJQaDWmDseFrxg6/68Zztg1V7
         4y9V/o5yJcjx1awiPvZBkBFSb31ndtgoZXOubvTWqXNWhh0tIfo7TXduSLVXXMSi1RYk
         5Nc9hcu+LsP28+cGkmujhDV703TLsJPFj40Z7B4GAbOf97mO5++s21B6dIjHfgn4PGf0
         HR8DzBWUtqyIH2beUcj91HqYYGdbARdHVFztJ/JNyG4+P0yw53GVMfIB9naLLl+3yugh
         Tsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745962224; x=1746567024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HG98OKRKV7KQ7Zt3pam/rRWORZSyCPBdGUM9BZPIIoA=;
        b=jQwEU1NNpmLH2ICbh33x9HAYrGSSjmyC+5FJlWepmv4FmBRWzy4BxrJ6sJipnjNbWU
         NdDSw8KGJeaXAeQDt7XXuOJnxk+dIGSmGim8KYFXVSccYyptjPHKuvgkY56017ga5XPq
         NfSZQHRmHVi8ZtowIREFA+GwSwNeOL12NaZkYkw9cLEOym4TMUXCboOA/AzyxHizoL4Z
         R6AqMynreYNNGZ8AG9hSik2+abBGHvEX+TXJXHn37bHJv6sTpHYfCie5apiwDOF4ofYc
         6wKhFYeVdbU/KMFqJmV5IezCTAh5MtLO7g4qqDu54H/MuTUglx6O7QMIE9tXf7nI0ABC
         surQ==
X-Forwarded-Encrypted: i=1; AJvYcCWskXfYkCKRjvRdlV3cVsjOJZQshDPWkeB9qMLEq8jg7ov6ixI0gIQPOb4iD3zcl+mO+3xBdw6h0qJ0@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3JVNTZIUWdnEyr9f30cOAQf1gx69cO9IVAIZAOSjLdeHrhnAi
	Pb0nL23pPecAH8Alhqd9eb8BtSdDJZQDUwEYF71hTgQVO7oFbiuqmkGzTSOY69o0hnjnxyK/IA2
	Ft2sgL/uMjIO9qI3N4dS7+VYGH8o=
X-Gm-Gg: ASbGncs0sRYIKVu6XqrOzQdVaBHqufGRfH/MOX1q/j0eXVwFzSMGGaZPs83uNna+Lwc
	xZTQRVM34jNzldrPUL/voP4uf87RmB3XXe11xM36wSt+XMnPkTmoe6AGIEV+NN2ro+DA2eqr8pb
	1HpysDPsFN8BJ6SuQb1Gwe8zE=
X-Google-Smtp-Source: AGHT+IFyyr+P/CpAR/MEAHuZ1TSUK50iFPwQwrd4EpLBGQbPsavyznqcfWO3lI7u1wPplNBVysrvoTNsIvaylMCdieo=
X-Received: by 2002:a05:690c:6113:b0:6f9:7b99:8a29 with SMTP id
 00721157ae682-708abe33e9emr15525087b3.34.1745962223989; Tue, 29 Apr 2025
 14:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250428063635.125879-1-hare@kernel.org> <20250428063635.125879-4-hare@kernel.org>
 <CABPRKS9yTExMW+PdJHnXiftck8dQQcF-RxVUt75M=P2bTnfmHA@mail.gmail.com> <301c144b-b3e1-4dfb-8f11-9aafd56ef993@suse.de>
In-Reply-To: <301c144b-b3e1-4dfb-8f11-9aafd56ef993@suse.de>
From: Justin Tee <justintee8345@gmail.com>
Date: Tue, 29 Apr 2025 14:28:28 -0700
X-Gm-Features: ATxdqUGxQPnl6gunnh17ACRvTyi3XSbM3bissdr5unB9H7GAAvKULrUh3dz_bHs
Message-ID: <CABPRKS9JyUQxPMUDhUQgvVfDhMexKrNGc1zLFTHkd9FD4Y_V_Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] lpfc: enable FPIN notification for NVMe
To: Hannes Reinecke <hare@suse.de>
Cc: hare@kernel.org, Justin Tee <justin.tee@broadcom.com>, 
	James Smart <jsmart2021@gmail.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_143025_228980_1670A204 
X-CRM114-Status: UNSURE (   9.67  )
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

> That should rather be a 'cfg_enable_fc4_type & LPFC_ENABLE_NVME', right?
Yes, please (:

But also, something like this to ensure our NVME target driver mode is excluded:

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index cf1fbfb15c5d..fdf4568e171e 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -10251,8 +10251,12 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport,
void *p, u32 fpin_length)
                if (deliver) {
                        fc_host_fpin_rcv(lpfc_shost_from_vport(vport),
                                         fpin_length, (char *)fpin, 0);
-                       nvme_fc_fpin_rcv(vport->localport,
-                                        fpin_length, (char *)fpin);
+#if (IS_ENABLED(CONFIG_NVME_FC))
+                       if (vport->cfg_enable_fc4_type & LPFC_ENABLE_NVME &&
+                           !phba->nvmet_support)
+                               nvme_fc_fpin_rcv(vport->localport,
+                                                fpin_length, (char *)fpin);
+#endif
                }
                desc_cnt++;
        }

Regards,
Justin

