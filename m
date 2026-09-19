Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D588AC982DE
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Sep 2026 03:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5fzJtigo/7t3PwS7P5np8F8Yh6nRyXPfgoaV8isKaaE=; b=YNc1GlpArBKvatMS4fKMKEr5Yk
	y7Oub8ypuXvhAOHgx/pOovOXouBwxiVolUgmtqOxOEhj34AtGoMyjiZPADhkTbsk0Rh82OTmT1NSg
	53Jkbjm1S2aKJZnM1D+ZqjHykpvtCRprhumtiRvJrvD8ARcNcHaDmailprPU3svv/YOWM8tX2lDC9
	sFPbWl3ILks9r/N1tJcRgwFPHCOKgk9NtTA8MTZRk/gSQeZpG37+Eso+fKXWgImKHzAzTQaTCfDDU
	ggbe+IK3TFda8LhyJWOpnYv83XKE0kbjssW86iTzjYBpAyZmT6njmi0O5cjqJJUqJmzScfq+sgZjM
	E8yTim9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7lLZ-0000000Fu52-0fdL;
	Sat, 19 Sep 2026 03:02:37 +0000
Received: from mail-vs2-f41.google.com ([74.125.227.41])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7lLX-0000000Fu4X-1XiA
	for linux-nvme@lists.infradead.org;
	Sat, 19 Sep 2026 03:02:36 +0000
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-78ffc0e2f23so511034137.0
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 20:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789786954; x=1790391754;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5fzJtigo/7t3PwS7P5np8F8Yh6nRyXPfgoaV8isKaaE=;
        b=tZKw5YmYafcnPaFbtZtU7uAitvIqQ1LzcApYMczG3AgXnPTPBhVAnVY3pM55pMLC+x
         Scl8YhP/vVr3ZH+9CkgI419IWCblV2bCGeH2yWTNv08wC33MvCppitte+h2LSB534dgG
         rPXBQ6S4NuYlfznIcayI4j9VI0SfRB0fCdOLhCly1pLlKltHiVT5I+c/04XTEkT6/BYm
         19VWnWVixM7UVFKL5t0odsNkQ/423eJY82et/P8cVUVEdXBhh/0OGHylqOSgTqDVPtez
         1lDNFPpHUbW5QTXL2mmpGoZl1S8WJzZgJQtX7r2/r7diMRlhJ/ZQG35lW24LPMJe95p4
         q48A==
X-Gm-Message-State: AFuF++nIY+PRBcCrmDk53NhBby6iYoeWp1U+4owDECP0k013YSMBEdza
	9if1Exm8QAxe6oEXA0jtATNig7VcuwnoFUqVLWoY/dHPAwR2Qm9fqdSvuR7OCKZq9jc=
X-Gm-Gg: AYBFou3Fdnk7iMYcdPHiUqXCRnARY7rIgc1u2kDBVqvddD1ItDc+WBrow/+8CZ6f5EF
	ltCNOBac+I/oJE+pDrDcLEVzw0qZOSLSS+JubNtDVkpyfGJ4irlnl08AJovYiUV5eOJfnPJrDKR
	R5dFokTvLCUSYeH/B4LhB/C2AkR9H+hbuyS7KW7nk8u3v+/TIXzCD1C6nyRBNuRhOUGXDYyFpTO
	1I+LgRC9qyXEiBowMG/7Yn8ttlALfcXKztkntu33KkCjS0MXi0gsktG4ensbgq8461Yh36NzUEh
	YN1T1FbnO0TEJ59CCf1L9u3JDpmW9/bXn2A55VwF0QVrpDsA+43EWFyoiPEHi4+zZ7/hlyORWy5
	OXTjMKeVdmJsRdAIINwAMutKVStwfUEgyBQXxol3W/id/z5Na8SIGkAryxMzuUSOGiLUEG6Pvs5
	FIXQHim6NTUIUaitkYz0UN/OmQQV797FfjjlJp8U/vXsmzc2h2WFk04ahadJSqqUWnLu/c7LPm7
	Rvjyk9ibu7wTcc6skYoRj5Isr7e3KfFoK1puaII3fXShQzSXUQMx9E=
X-Received: by 2002:a05:6102:419f:b0:7a7:198a:c2c6 with SMTP id ada2fe7eead31-7a7198ad3f4mr32603137.36.1789786954039;
        Fri, 18 Sep 2026 20:02:34 -0700 (PDT)
Received: from [100.96.0.25] (corp-190-12-36-222.uio.puntonet.ec. [190.12.36.222])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a6aa41d7e6sm1385924137.1.2026.09.18.20.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 20:02:33 -0700 (PDT)
From: Ing. Alfonso Kuen Arroyo <gerencia@idkmanager.com>
To: hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 mlombard@arkamax.eu
Subject: [PATCH] nvmet-tcp: fix stale comment on NVMET_TCP_MAXH2CDATA
Date: Fri, 18 Sep 2026 22:02:33 -0500
Message-ID: <178978695312.43804.1554581215424967584@idkmanager.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_200235_412001_8EFE71B1 
X-CRM114-Status: GOOD (  11.66  )
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

The constant is 0x400000, 4 MiB, but the comment next to it still says
16M. Noticed by Maurizio Lombardi while reviewing "nvmet-tcp: report a
bounded MDTS instead of "no limit"".

Signed-off-by: Alfonso Kuen <gerencia@idkmanager.com>
---
 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e598101..726e05b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -23,7 +23,7 @@
 #include "nvmet.h"
 
 #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
-#define NVMET_TCP_MAXH2CDATA		0x400000 /* 16M arbitrary limit */
+#define NVMET_TCP_MAXH2CDATA		0x400000 /* 4M arbitrary limit */
 #define NVMET_TCP_BACKLOG 128
 
 static int param_store_val(const char *str, int *val, int min, int max)
--
2.53.0

