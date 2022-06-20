Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6EEC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 04:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZwqahDHThWPbCSkd04LkEiVlXEdscZb913LydHKUXuk=; b=LgVO5RCJoMM64R/WqaR9W9kVds
	ut56Yef7rZJX+IHGb8GFBvWaC6bOycL3HXV8kg+LDbtFL4u9Q6DpnRgFYMeIQo+LVbWubNl4Z5PZ1
	fKaT9zijMqMNlvyjMx6cTPcH4jJvchxDMoDRf+9wUxSH54GIuoWYY2LEr2YDdTJtQgRHVUeHfc8G/
	Ne0UZqoYAlJLWqY2I75mLo5njWioyusyt8FrJy5QxOZiijKXofJtjbWqCeTVhgHyr2PcdctMtLzOA
	wmvRLlKfxmpDkYLStBZRDUHgH+pB+uo+yMJvaZrvjccxeQ1PZIm0MQuQGcox9yMOy7J85MH89bmjh
	Usq6SE8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o397m-00G9gn-HJ; Mon, 20 Jun 2022 04:34:54 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o397j-00G9fq-Ds
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 04:34:52 +0000
Received: by mail-pj1-x1032.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so5604762pjr.0
        for <linux-nvme@lists.infradead.org>; Sun, 19 Jun 2022 21:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZwqahDHThWPbCSkd04LkEiVlXEdscZb913LydHKUXuk=;
        b=Y4b8o/SvbiJj5yXOw/uFM2KaEq4hLSLtkrgNsAUTmWf3BqPAm3TfIppnQFfZemf+zF
         IMh7SaiMY0+2s7YvwjCDLR80REUPFfFoWiZnHbeb1pHc1QIi3pyrKElWuR4mwXheaEmO
         dHWZ5TadCHmCE/Pa72NIX12Z8VzpqdAi3VLPlnZzN8YZCnmugqs2ysNLce6WnMf9Tn8n
         BAzSG7OSwg41Jzr8tIYPKJqLFaqSiBwnvG5TnXAWGqMgiSXxVaBU/UOlYiVWi1Xyw0ab
         DW8CQyrgIfwIEaEksnxUO2FUNFyCu7knFQY0e4oREQ4lZI/XtIQju0YafC0qGf8qcuG0
         9LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZwqahDHThWPbCSkd04LkEiVlXEdscZb913LydHKUXuk=;
        b=SAOOp5tzQoG/GV0MMfP89mNQhCYo6y/hfzyYfSL7xEr+70l1Wf/ix/8EDwh5foyIf6
         gOoN6JPFSuB+5eZQLs/E2JQk7OAhDYkpDDdldlI55L4c+rm1o/HiuSu6o1+s23zChAIx
         /bpYwh6K9w2Fbz2K7mW2j8jlQim5J4ZqLCqWu0ADLu0CSqNxKQCqlqrpW+NRg1CVPLRe
         dUTBJtUnjSsCixKzylnwhstsgQEOid/to0O+GFKGKY5uZz8xsGfl6lV2+Wd0qMQyWYnr
         VapW58dAXfaEfRtgFyHEqsDWzagBa8m1kuSuV/D23gUeKYQoyogPEgeVT5NydW6sAGnc
         L9Bg==
X-Gm-Message-State: AJIora83VRUZjK1gQkyhV+v2rKwz1pD0rptId5ieGE5rLotU5Vhdgh0N
	h+POD4nq/mfcz0t2YQdOK7o=
X-Google-Smtp-Source: AGRyM1sLOJK4GdbtT38Rxr8D9tca0o+Up1SX9oAhXVi9naycP0yEUoILLaD1ayt/I1XJfpH1QBc7ZQ==
X-Received: by 2002:a17:902:f707:b0:16a:176b:d75f with SMTP id h7-20020a170902f70700b0016a176bd75fmr7888495plo.158.1655699686944;
        Sun, 19 Jun 2022 21:34:46 -0700 (PDT)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id p9-20020a62b809000000b00522cae827f6sm3541984pfe.197.2022.06.19.21.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 21:34:46 -0700 (PDT)
From: SungHwan Jung <onenowy@gmail.com>
To: hch@lst.de
Cc: Jason@zx2c4.com,
	abhijeet.rao@intel.com,
	alan.adamson@oracle.com,
	axboe@fb.com,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	monish.kumar.r@intel.com,
	pankydev8@gmail.com,
	sagi@grimberg.me,
	yi.zhang@redhat.com
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR observed during blktests]
Date: Mon, 20 Jun 2022 13:34:02 +0900
Message-Id: <20220620043402.13202-1-onenowy@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615113106.GA10697@lst.de>
References: <20220615113106.GA10697@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220619_213451_519937_C1660BAF 
X-CRM114-Status: UNSURE (   8.69  )
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

Hi again,
I'm sorry to send mail again.

I think it would be to confirm that subsystem-ids for all X5 model and these ids are not used for other ssd by contact with samsung.

But I have no idea how to contant with them, please fowards this to them or if you already have these information, please tests the patch in previous mail.

