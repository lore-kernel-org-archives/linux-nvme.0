Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914C7C77B7C
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Apr 2023 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ptUzMMKvss1eDTyC9aZgGkjQmQNtNcQfNUYC+zcmgXw=; b=XC8A/5e5z7JnrRwqBpfgW+T8Jn
	D3/7/scNMtlYSThh6EMqJTufg0QmOSf2wF+TsxZrRr06MCsS/eS12wyxHIQ6SDgZcl/SDfw7nbB1W
	Ko8r/+gVWia3rbujEfCz3TbdTHdUbiSXw+zKDY/6DoA9+ebtYUkPvt3SNZq4QK/jMrjvRiA3G3J2v
	xDY147P0kOdHBjkxlKB5kRHNGoXWUauYf2JwyFRlMnadw/0viQYK2OKowgU1yWbol6RH4TOI+wh+f
	8ZhfWodyUm/vyfySiOQ7uldGrrq3UJaMm+XT68WItKBCfA8W9yDF4IJwwVfv/RHSNfeSVXa+SgqSF
	bxwRjTHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prQ4L-002EPq-1x;
	Tue, 25 Apr 2023 21:19:25 +0000
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prQ4J-002EP8-1w
	for linux-nvme@lists.infradead.org;
	Tue, 25 Apr 2023 21:19:24 +0000
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-541b5cfa9d8so3678524eaf.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Apr 2023 14:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682457561; x=1685049561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ptUzMMKvss1eDTyC9aZgGkjQmQNtNcQfNUYC+zcmgXw=;
        b=B/mn8ZJ6G56q9YyUDKXUdew3ypEi2xp+FyS89MzdEAo+CWYnOmt8R7zDNhJoFGCrXU
         OxsACGNfmmKlW9872s4KWgVDMb1jS5UDe80l7COi4uZP9ywK5nuw2AIZu1aF9KZv1OUl
         jiKjTDA6+JNjRCiqd/DKp8tzhP6aHK96u8a/wlPaD88HCmDNAkOTAqGdPqF3BFqf644P
         Xiolp5v7LLKXaWRlqK1Qz+rjzqFLUWqF5Et1lDAx4Cv4vXHI5WqMk2lG55zicBq7Q/Ll
         i+U21yFWZnQA68HR+eh1O8XVvjlFVcHX8Jyq3I+s8HNfW73I5Yi/j6v4+bS2mBvBZhAn
         AybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682457561; x=1685049561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptUzMMKvss1eDTyC9aZgGkjQmQNtNcQfNUYC+zcmgXw=;
        b=AKVLIAUaP8SDJr7z9BWNWZH8Iyrf0GDDazq8JxseIM4WoL2bJlxGfzQJfp/c7ARoMm
         R5ptaVFm7R7tTAsQk/5/H0rDue+qvy0WJpbqSqjjx60suncRdKMIRlBtnkfVihukPcEn
         8GgajR0TpwSwW3ZlEXJkfspArxBYkpd3iIvHH4bKNLFs4kzPVMgacRETlqPew19eX0Xk
         ME8MtCcMsZnwGTyjqeddcAiHmqZRRfBPH2MrhT2APGRWOCA8TmBJbHzsBPCZULjJ8vA3
         etqGWhB/lvPevSUI10YiX3sDObPiIih4R7qcbFZTxUV4c/M1Lu6DFH1w2kA5crONfWNw
         aAmA==
X-Gm-Message-State: AAQBX9cw/OHu+YryBNjwoJ3TbKzYI84FOO7YjP68CZWULe9LdcpFks9L
	4hJqsUCSonQkk9n/KnHKPgOJnUOV8AJYXeag
X-Google-Smtp-Source: AKy350Zb7PiZGGLN6S9ozktT3hTsetoP6fgUHnFA9gT45UihywW5IoNeLmGoE+wjrXnt5DfDD1ptjg==
X-Received: by 2002:a05:6820:20d:b0:545:85e9:27f5 with SMTP id bw13-20020a056820020d00b0054585e927f5mr7161152oob.9.1682457561672;
        Tue, 25 Apr 2023 14:19:21 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.195.153.187])
        by smtp.gmail.com with ESMTPSA id u2-20020a05687036c200b00177c314a358sm5945357oak.22.2023.04.25.14.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 14:19:21 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH 0/3] Adjusting deref count in nvme_init_ctrl
Date: Tue, 25 Apr 2023 18:18:33 -0300
Message-Id: <20230425211836.14283-1-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_141923_638459_188AF9AE 
X-CRM114-Status: UNSURE (   8.96  )
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

The following three patches aim to solve the following issues:

-In case the teardown path of nvme_init_ctrl is triggered the driver
 exits with a non-zero ref count on the controller. 

-Teardown paths and the ctrl's release method perform similar tasks
 leading to double-freeing issues.

In details:

-The first patch is just a ceanup of nvme_init_ctrl teardown logic.

-The second patch adds an nvme_put_ctrl at the end of nvme_init_ctrl's
teardown path to ensure the controller releases all references upon exit.

-The third one addresses the double-freeing issues 

Irvin Cote (3):
  nvme-core: nvme_init_ctrl cleanup
  nvme-pci: Adjusting ctrl deref count
  nvme-core: preventing double freeing in ctrl release

 drivers/nvme/host/core.c | 20 ++++++++++----------
 drivers/nvme/host/pci.c  |  9 +++++++--
 2 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.39.2


