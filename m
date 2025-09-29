Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9E7CAC5B9
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Sep 2025 17:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2iq1xGli16J7nUmjOGkf2lv1qlOI+tiFZeMK2lYQ+jc=; b=Vi9gWcNNSC3EhyWh18rxZRX8Iu
	sRaC7BLrS2/jfqlVfsZCN3W3dCJZzx6eoV8p2g7qCAver1DGFW+nCmb4oswNxo+mzGNI1TEQhWzEf
	Cu1JNhnJsz92EV55QJD18WTBZ1Mg4CA4qoxPqQUH6v47fT6m9thfAFfCrHHeLw/p0nP1n+SNXatun
	OB4E2X3xf8JasL+aRFHFlaY8Xp7fcge4hJflerHUABOAiJ69rE65+FGMqD7EZtg/a4eXd6MzHii9B
	p2W1cKR9wKMXVLrMC/d5TxojSDFJWv8Nq3GgvN5LtYilZxbG0xSeV6GIG/6BdDf44A/4inOFiWcJ1
	OvK5syRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3HvP-000000039ka-1INN;
	Mon, 29 Sep 2025 17:44:35 +0000
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3HvD-000000039fH-41eh
	for linux-nvme@lists.infradead.org;
	Mon, 29 Sep 2025 17:44:25 +0000
Received: by mail-yx1-xb12e.google.com with SMTP id 956f58d0204a3-63497c2a27dso5189875d50.1
        for <linux-nvme@lists.infradead.org>; Mon, 29 Sep 2025 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759167861; x=1759772661; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2iq1xGli16J7nUmjOGkf2lv1qlOI+tiFZeMK2lYQ+jc=;
        b=VUZ2rdzQOjXM9QD1XAsXivvhMZSMaewgGNu6Klaeq30zHsqgZPfjDSPnxhp/83D7g2
         pqXsD46RXoVvnvIXUX5FXUtJNU0++VQdBUs5Kf/nwhqrLHUfRjsZlbHAJHzdoCFFn8Q2
         7zJVvZ48GFsyztwoZtiwibi56AJMb73AMA1kpUj56fv92G26rmue8BHmsinaWrpoxdZZ
         wqQi3uGRRnSxXlJaMv43S3qLjMwrFGCn/Mh3d7fy2ZJAcO2oC3HjJ0hXWR2hQyyepHpb
         /fCbRgYO4XvVDtf0m/EHFXrCWElFfLLmQEnHfcBgDbtpwAhazXpWQf0valGV8Ql8J59z
         yAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759167861; x=1759772661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iq1xGli16J7nUmjOGkf2lv1qlOI+tiFZeMK2lYQ+jc=;
        b=D8z/MHuIrWpjalL+UluEvioPTJfWGdx7MnYOh5eJFVTkLfu1h0qr2YHFTDTRMeBzPa
         Uau+sfwLWFKJ5PATpCoxKO9z8CWnco1+aRhfVx9JLwDPVSZeoNy1AwCkU3So52SfLQ+4
         vllwfTk49QWbIxzbaEd6cUXJa23qWOEdG3ZJD2gRy2bUh/qE1sq5IevbERwiryNdplXJ
         Wjh1E0Wh5Qc9nsKUpGaycyQGK2UVVdQFa1tX0PZ3cecpWpl1Ws/nwE96FBZo+qcaR0aN
         YTKJli+Yjzhx2KjD8j7pm4zEBg90vAAXrp8M/4EmZvrT9Uh8bbkR4z6rZrDsF6Yrl3JT
         eNJw==
X-Forwarded-Encrypted: i=1; AJvYcCU+6jPUZaUDr4jdfX3sAFXeRyzkkXnAAoPF51h067/7EtNLNSHGrjMisbUKn6/2Kz51IdWjvgmB6Y+J@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1EKZ0PT5HCFOyEn56lkdrHnMLXz275TcAJvyUEEJXMgqytQ59
	DcPtK/f6DQQZyJ60xIu8xfoLvEE8yGjz5tkMbB9ilkV3CSxVr616m7cOd75mjp7lzs3h0+9s8WO
	eLhLb1tbPaBSwFW86HWpAJ36PEFlmY8Q=
X-Gm-Gg: ASbGnctg0MLLoAB1Ni8c8kpl9bLakb7pNCVhUTrvfxMMqde2HK5I8qTwXBxsum9Ji8k
	RMg51BvubTddTkBrWag38w9FCaw3NE6ztJkY4E80zc4nS//j28Pa8mMfmoie+Xva+IG5t0acue1
	bibYTSObL05REsaSdVwM17tQzGXn1ZtcarYAzb9lHKjAjND8awsANrOjA9l0L0jXTUSDSVUec/+
	r8Wd8A3
X-Google-Smtp-Source: AGHT+IHD+fud1cqNFyL89ZYpolBKRgySAYj8na2dCzjfyjGhO2C4PNGwPCYLf3yuYC3SlrkRYNBF+8yYs1tNJabNujg=
X-Received: by 2002:a05:690e:1548:20b0:639:2794:341e with SMTP id
 956f58d0204a3-639279435b7mr4583288d50.3.1759167861254; Mon, 29 Sep 2025
 10:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250926000200.837025-1-jmeneghi@redhat.com> <20250926000200.837025-2-jmeneghi@redhat.com>
In-Reply-To: <20250926000200.837025-2-jmeneghi@redhat.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Mon, 29 Sep 2025 10:44:06 -0700
X-Gm-Features: AS18NWBdrQ2OubyJNBy1xJM3AAOOxCFmeRS_MY6SKBbtmZUo0BgYs_yjSiVtfKo
Message-ID: <CABPRKS_AOnXmG7NAfgsEKLx2Er_WBcR48wCZwxbKLXnv7FPCZQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/11] fc_els: use 'union fc_tlv_desc'
To: John Meneghini <jmeneghi@redhat.com>
Cc: hare@suse.de, kbusch@kernel.org, martin.petersen@oracle.com, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	bgurney@redhat.com, axboe@kernel.dk, emilne@redhat.com, gustavoars@kernel.org, 
	hch@lst.de, james.smart@broadcom.com, Justin Tee <justin.tee@broadcom.com>, 
	kees@kernel.org, linux-hardening@vger.kernel.org, njavali@marvell.com, 
	sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_104424_015794_07FD3D1B 
X-CRM114-Status: UNSURE (   5.85  )
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

Hi John,

Which branch is this patch based on?  include/uapi/scsi/fc/fc_els.h
does not apply cleanly on 6.18/scsi-queue.

Presumably, is this patch based on a branch without?
44b6169ada7f scsi: fc: Avoid -Wflex-array-member-not-at-end warnings

Regards,
Justin

