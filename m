Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36202C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jan 2022 02:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dFifp4IhOFibmidbxdWOtwDyLOsL6LxbTa27pTNK8Nk=; b=Te70wANnFey6Lh2q1BjEMAnk5c
	I38q25m00B6EpJmaWeC0vax2fh8UJF0ZVFh5FlD+x5phgVR+gOzeMbMPBZwMrrN6Q35WoR6X0P+r0
	hbXAqJncWwe/toTqNWEdjLMUMurXzGFk/aC6zwgbwTBaEV7FxntOBv5JaxtS+uxu0108lDTC72dbF
	krWIUPX3LnG8nyQaJ8Ck7M815JuCU76RyCovCIRFkol/8Lvb7nAxMTm3aceyOW0VbTb/D3s9Bl/LF
	jLjIaniNcm0steS8LmkPZvk4NL31S/Jt6UTR/C4fTqbmBC7lBCSbxRxvM43zWKnB0cW4hifnhVsIV
	Emka6A5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n5euX-001vZK-J4; Fri, 07 Jan 2022 02:23:21 +0000
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n5euR-001vY3-5b
 for linux-nvme@lists.infradead.org; Fri, 07 Jan 2022 02:23:16 +0000
Received: by mail-qv1-xf2f.google.com with SMTP id hu2so4182655qvb.8
 for <linux-nvme@lists.infradead.org>; Thu, 06 Jan 2022 18:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dFifp4IhOFibmidbxdWOtwDyLOsL6LxbTa27pTNK8Nk=;
 b=pPyr/dIuKq4QiCp1BtRqwAxXMqf7zUjwgKGFiN7eXE/emsKEpDtIPdUXicWnetHw1n
 bo700UQrZGPRbWMxhGJw2HezQiy2om+ZkPe5TEM2tsY9bIIzvxiMaUqKCkv1Td2YdZfw
 hEVOl+XLVnGybqZjvpWk3mdDx/JxLfl/Xnx9ytXO87F1sJ3ZCPKDThROcBX9qvGiqv+x
 6P1H4jckjJXIuwO+UiQtvMjDyTnmwwWphMvgAk8+lsiXRXwDDmrT7ZJ5xoRz2s9oQCJi
 2XwUrlMfsdp/ge6pD50UdBK22Edh3MLBZBo0rBGACVl4Mq4j634+5erffDYO+moW/ijT
 s6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dFifp4IhOFibmidbxdWOtwDyLOsL6LxbTa27pTNK8Nk=;
 b=ieYdUE+E4WASlk2svAIFD5xghOLkJNn8x/YonCed/MxkdatzuOpu4jdQdFBTkk2/yF
 lrwQERI9VHys1zZFmRUzfn5MJK9kL3cM/uXnItTZjeTAcslHx8h/0HBZQIywLEaKIcf2
 UhTu+09IDsor7zUbkN9N2eubyOtrdlibqh1ZaSaYOEtCinrHH0UxReR7ndpHI1qx4oY9
 SU/dKXJr2e7MVU+VyOX0F6KuXQcYGIukMwXy3wLXK690B1Q/kwgqSq7YQ+J2nrD5GP+T
 XP7IY2befD1Wl61vSP392WhsSUwax++PRrDG79x9PFFWgxAljWeFrpIoZBlRIr2colYb
 gQxg==
X-Gm-Message-State: AOAM5330SZ78DcVmydOJtGmXIUfdSM3tVJohlDiKRo5P6fvujMftMGpM
 qLo4/2sCTpnYaS6eGERtRdY=
X-Google-Smtp-Source: ABdhPJx05b+2PR+Ea1MqSU7lA8zHdT3RQG2PnuCl2Ds80cRnsOvNuPrbeYoAwMY0rtlBMg7w7n4BUw==
X-Received: by 2002:a05:6214:21ce:: with SMTP id
 d14mr56783406qvh.73.1641522193157; 
 Thu, 06 Jan 2022 18:23:13 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
 by smtp.gmail.com with ESMTPSA id h3sm2619617qko.78.2022.01.06.18.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jan 2022 18:23:12 -0800 (PST)
From: cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To: kbusch@kernel.org
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Changcheng Deng <deng.changcheng@zte.com.cn>,
 Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] nvme-fabrics: remove unneeded variable
Date: Fri,  7 Jan 2022 02:23:06 +0000
Message-Id: <20220107022306.622222-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220106_182315_249371_80EE0181 
X-CRM114-Status: GOOD (  10.70  )
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

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/nvme/host/fabrics.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 7ae041e2b3fb..f79a66d4e22c 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1092,7 +1092,6 @@ static void __nvmf_concat_opt_tokens(struct seq_file *seq_file)
 static int nvmf_dev_show(struct seq_file *seq_file, void *private)
 {
 	struct nvme_ctrl *ctrl;
-	int ret = 0;
 
 	mutex_lock(&nvmf_dev_mutex);
 	ctrl = seq_file->private;
@@ -1106,7 +1105,7 @@ static int nvmf_dev_show(struct seq_file *seq_file, void *private)
 
 out_unlock:
 	mutex_unlock(&nvmf_dev_mutex);
-	return ret;
+	return 0;
 }
 
 static int nvmf_dev_open(struct inode *inode, struct file *file)
-- 
2.25.1


