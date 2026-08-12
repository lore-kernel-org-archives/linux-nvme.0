Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412BBC5CFDB
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZEyXLqcxbr/SLsSUNviv8nzjhBE4ozvJHxIITTWu9ww=; b=TuHyM8hhSi08s5OhxvSFxkCv3M
	oy/QvCwB5S7reG5yjyE4BAzpvqQECDfU1dsI2mov2NZPIaUYbyiNKk6meRB1ROoIEVSEHwHpRD2um
	329sTp0ccfdGf62+mdwpOGP1jrFhJ91lQZuU4gDIRQQR329Dt0FdBMfDtOdlYUWzm4uf4dHqAIAMc
	gujY0RgJfS2j44ip2l6xQo6FB8IbGSQGiOFpQy6kb+KJ5njI0EVR36lgUcuduH36aVXQPwr/tHMZy
	IkLRPYYQG7eke2PxFIjSZLNRcqGPrJ2VbfOJ/jhXJ77pjJSI+8MfM7oDkCKN1o7+TmGSJnkaypJGs
	64H3BEcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6cG-0000000FyYB-35ty;
	Wed, 12 Aug 2026 10:55:24 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6c9-0000000FyVi-2SEJ
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 10:55:23 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1962684b3a.1
        for <linux-nvme@lists.infradead.org>; Wed, 12 Aug 2026 03:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786532117; x=1787136917; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZEyXLqcxbr/SLsSUNviv8nzjhBE4ozvJHxIITTWu9ww=;
        b=KV/684JIBjOV7MQ1veyy3TN2OBY8bywaAv2IyDVq8Lx3PqfDkq1NDqEDYZTjMU9YlQ
         pasVJB69eHw8KdtDoW9YXMIbAC6N77TCn26vw5TUnAHFwznRaKltAuNYNvWrpUGqOMO5
         yL4l0SZANmQt44G2hu7KQVCzZ3260NqBKRw0jDlUddaxl71PwD6VfHvG0zQbPNkykYEk
         aszHw2UJ9H4W1/5HQ466PIwXE3iKYskkHDyqnxU4ZyyJnEBugsMmjHhEmadYUppGjfjp
         nEtJt8t5EWRUfp1u16jLT9A9nr5FRrK0QGZ2sL6Wt+RbBZFplZ5Uqe87QwV8l5vJlKhX
         fMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786532117; x=1787136917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZEyXLqcxbr/SLsSUNviv8nzjhBE4ozvJHxIITTWu9ww=;
        b=leaDPJ4urZWNoFIXmdxep5xFeFtvbYKt+MmG9RdnX6wV6mkBegRmBrMRhl2yF+Nj5t
         KOT42QMSdiwRcwFC3J8QYEJRHcVujKzi4a4grKpoqweEI6IC04J0dGYQvXXzfJKwjpAh
         caPZ+m1yi5k+iqw8DPj3rfbddKK+X4vlgihNLkTk0yG/TERNTLpnvga0kf8sM72G4F9E
         qCkBLktHi1QbwWmus2Osx8L3oaSeS3l8QdOmlxvUD7KFkPfdLclpvIEbzuAAfHK0XRGS
         ul/fWbiBHTGewgcUzQPFrqLa58VKY6ANta8Er3Zb/w86vzyGZuFvO8AJTaF9ziOJvL37
         Jpsw==
X-Forwarded-Encrypted: i=1; AHgh+Roh6GhaHtRRd+lfKxveP8X65JeAiwbakHjqP8GRIzCdxSSWVT4RdsfT++u6UfUnkAiqfqZUxwGQOMsn@lists.infradead.org
X-Gm-Message-State: AOJu0YxjshbsNSNDZRbvItSPJ2yaHkLuzrqPpz2vWYgKa2XMH9mu61b+
	cvPjeVx6gF5TnD3gSt5ShlBDmp4sC0FpLk2D1/V3/3RaDfXgNm+Xb3ag
X-Gm-Gg: AR+sD12QB+15tL23C1rbaQ2fVBN7pINVnKIXmSZnuxdXFa5oDiy7FKeEZiBZljF+v7E
	D568eEBLfFe7sfvCawM4Hj7VbMnhPnnEv3Y5MAqtUJFCvwzCsJVXDMcmfkge1muRvhEgFfpcHsc
	KxsSeCOSLyQ2AVcEk8zyc7Vkq3pm/gHuc+6r/b7Gkp/fe3fDDcImbq6x+h+DB3FOFywPFiVEEeM
	FswnFexmFOP0GClhhRSly69MKO5/6xKEOxDG4Rxvb7YMi0QqjTcDLOezsbp5zMRQkrzGiCP0Dvr
	UMGEPvc2R1TxWe03C0+lpsIL2RuFAQSGXnaeycfpX4KpFRkIYIDP9ZlWJhGIaaurXofXSbD1rIe
	9C38MbzwiQbOwea1ESWDqqhlmdX4qQVEIx0RQkiGldPL8hABJbv+1v2eVD/I+yWu/87p8Nbf9tv
	wV08l0xRq32UsaUoinKfvR/iSVmPAGpggap1DFNMC7orZD1IL9aKrFBanUfBTngd61o1I80WG4
X-Received: by 2002:a05:6a00:1c8f:b0:842:3838:cb03 with SMTP id d2e1a72fcca58-84fb6b3621emr3798390b3a.11.1786532116612;
        Wed, 12 Aug 2026 03:55:16 -0700 (PDT)
Received: from ubuntu.. ([219.241.133.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1f6743dsm811658b3a.52.2026.08.12.03.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:55:16 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: cassel@kernel.org
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when nvme_add_ctrl() fails
Date: Wed, 12 Aug 2026 19:55:10 +0900
Message-ID: <20260812105510.53766-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ansfMnm1WntoQRi_@ryzen>
References: <ansfMnm1WntoQRi_@ryzen>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_035520_485500_CD1ED50B 
X-CRM114-Status: GOOD (  12.54  )
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

Hello,

Thanks for the suggestion.

> Wouldn't a nicer fix be to change nvme_fc_ctrl_free() to look more like
> nvme_tcp_ctrl_free(), i.e. something like:
>
> +       if (list_empty(&ctrl->ctrl_list))
> +               goto free_ctrl;

I am not sure whether that would work, and I may well be missing
something.  From what I could tell, nvme_tcp_create_ctrl() does its
list_add_tail() last, while nvme_fc_init_ctrl() does it before the
nvme_change_ctrl_state() and queue_delayed_work() checks, so on those two
failure paths the controller is already on the list and opts would end up
freed twice again.  The early goto would also skip the ida_free(),
put_device() and nvme_fc_rport_put() for what nvme_fc_alloc_ctrl() takes
before the list_add.

I am not familiar with this driver either, so please correct me if I have
misread it.

Keith suggested moving the existing clear from fail_ctrl: down to
out_put_ctrl: instead, so I will send that as v2.

Thanks,
Rihyeon

