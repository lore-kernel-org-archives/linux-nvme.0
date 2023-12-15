Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA09C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 00:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5IU0zN3W+3kwULqxQV+6lpEfNpjR32EHUXbLbl5YqaM=; b=3PEwU1+5HIFgtUw/+jdOoT2aey
	xlpBSLXa07Ql0YNUwqAMeIs0n76XS2J3g1lhodnaQRd49wKmLOAbGMsHRR4W9P3LgHrdhzv7C988X
	p7rVRRj3YzXSAcZyvTYumruX0Bk40pTgtFgnD80xpEZlofYTeZ5H4xHdTu5PLVZN6ursTRiE3KZl/
	eS4vTTzugM3zgvWaflgRKJ3WExcgxocCFS9CM3i19oNVKXGb6u89oGmHyqUFuyeoNBj5Qy/FnaPbP
	Cwz66linpqk/VSYAxTbR6VA82iACwJlIScid8o1Egvv7prMYi6+BSxBTBlrOURUOzgKF9p2vVSRw3
	NznCv72Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDvgY-001bB6-1y;
	Fri, 15 Dec 2023 00:04:10 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDvgW-001bAU-0D
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 00:04:09 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cef5220d07so35702b3a.2
        for <linux-nvme@lists.infradead.org>; Thu, 14 Dec 2023 16:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1702598644; x=1703203444; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5IU0zN3W+3kwULqxQV+6lpEfNpjR32EHUXbLbl5YqaM=;
        b=ImXRVqzrZkaOmAA6MmGyeDDVYvgBI1iWAusseNxwvRm/4qrWz/Wc/pAHlfmfqgZCaM
         dTJTonQh518zZg0+pdCG+lu0YBGATg5mMiR1EDspSrOMQg1daVI/I3ALE0OSKzlhV5uz
         wf/1jqukcPjQCXDtm9Y4+fr6wVju/A7spg5GtyfehUFkRYGER0R8LzQTFVo2Zn/4mBCH
         lQm0MZ13+20ZJITz172N/V6FjVCOPiBBItTCQx5AcQzk6hT/jK6l6Cx93DITmtkhqj4x
         /gYZtCDWpDCVxYLTiZv6R5BPqKecHyG1fcNZ3QOmBdEio9NItuU7ecVk4E9lF7vGgYrV
         hNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702598644; x=1703203444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IU0zN3W+3kwULqxQV+6lpEfNpjR32EHUXbLbl5YqaM=;
        b=Lsj6I6hQMTx0kcxAC3zR6eZ+BZ3oFkCp//FkPnbyj89+h+lBF+oLSINaTt5UzeJAGF
         I38BGeH+ekyunsdiOQFM5AUFAC2egn6j9b7hUixpMXXLt5yREE7XoPtQ0w/qOivR+O2V
         nGdw2+sLRikoO9g6fFTiOu4ADjXKhuTf2XnEOVW/WF7wjCG6ygG7Ofg2zpqEeMaDqi+e
         3W8vljSyEy4Hz0+Ky929cyyR40sfwWG1guDLuJchgWpaqD4lFUjRGsrbiRqRynO4i3YN
         vCAFzDKOaTFpo4BE30NH6SuV/zrSeG/2fB5yKiqPnNNVWXkHiSZjdI95YWfS77D9gbhL
         aIdQ==
X-Gm-Message-State: AOJu0Yy540xxcffCqO477FTdtS8x9a7M+xGowHFiow3Aj52ejdyKNHgL
	WpwhUdq4ruEf7EfE6ZOHmX7+Zw==
X-Google-Smtp-Source: AGHT+IHtYdbVsP4evH++rOhQdVcTGyHEm0dd556rhX/ZfW5pTb37OcPyYM8f3xDFxddMI10tsFKzSQ==
X-Received: by 2002:a05:6a00:1749:b0:6ce:2732:1e07 with SMTP id j9-20020a056a00174900b006ce27321e07mr6199415pfc.65.1702598643653;
        Thu, 14 Dec 2023 16:04:03 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id c12-20020a62e80c000000b006ce7e497302sm12208524pfi.21.2023.12.14.16.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 16:04:03 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de
Cc: linux-nvme@lists.infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com
Subject: Make NVME shutdown async - version 2
Date: Thu, 14 Dec 2023 16:03:55 -0800
Message-Id: <20231215000358.1203338-1-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_160408_131462_AEF7D553 
X-CRM114-Status: UNSURE (   7.79  )
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

This is version 2 of a rebased update and resend of a patchset
originally written by Tanjore Suresh <tansuresh@google.com> to
make shutdown of nvme devices asynchronous. Minor changes
made to use an enum shutdown_type instead of an
integer flag.

Changes from version 1:

As requested by Sagi Grimberg <sagi@grimberg.me>, ensure
that shutdown_pre is only called if shutdown_post is
also defined.

-------------------------------------------------------------
Currently the Linux nvme driver shutdown code steps
through each connected drive, sets the NVME_CC_SHN_NORMAL
(normal shutdown) flag and then polls the given drive
waiting for the response NVME_CSTS_SHST_CMPLT flag
(shutdown complete).

Each drive is taking around 13 seconds to respond to this.

The customer has 20+ drives on the box so this time adds
up on shutdown when the nvme driver is being shut down.

This patchset changes shutdown to proceed in parallel,
so the NVME_CC_SHN_NORMAL (normal shutdown) flag is
sent to all drives first, and then it polls waiting
for the NVME_CSTS_SHST_CMPLT flag (shutdown complete)
for all drives.

In the specific customer case it reduces the NVME
shutdown time from over 300 seconds to around 15
seconds.
-------------------------------------------------------------

Thanks for your consideration,

Jeremy Allison.
CIQ / Samba Team.


