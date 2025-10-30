Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC48CCF9E3
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 22:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O8nng/o7TemTjcJv19bbJKh3cyQwt5n4WNif/kXxBHY=; b=c3T7SQ14IpD+jmj1x6eaq2jp0E
	ot7LQ/xE2Tomx2Z8pd/YfVmCZeb3WkcOw2SWPWjo1awGT/MlkoiEZY/0sMRksTW2CWTabIO1SKOM/
	EsiHfp/eG00NhoPzHWTTPAvez8AnV5Jfl7sSy24YD8eSyyGw3VoxFtnZiewQLXbUP4wZLFgRt65Dk
	+hXnbQHJ4awqrjAYdozBxl17wls6u6nIHrp4iqFYWeynBjEbiaMf0F7o/2bAgSOZeVszNCZs44Cjg
	94gY9uLS44E/fuciwCpmzR0lpQnst0PGdMODlkYatSJLgOevykrcIhTKSgXPcFSqn/7BiAzG1fkoh
	sh2ISiSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEajF-0000000515l-3INs;
	Thu, 30 Oct 2025 22:02:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEajE-00000005154-3OD2
	for linux-nvme@bombadil.infradead.org;
	Thu, 30 Oct 2025 22:02:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O8nng/o7TemTjcJv19bbJKh3cyQwt5n4WNif/kXxBHY=; b=hFa+BDIe+e9opZxAOpRzmBFMX1
	aB2l43mOZf9LGrRoMVVHaXMrUgcHFXTENAxCCL0+F/nMMWHrUa/oBT8EkJ1vT6Z8FE13CWPm5xELU
	Hel4lYqwJa0vWEKOaEAkrTY1TmMdOng2wzYdnqDnBm1QFxxJO6jC8p7JC7vKGs3td+3ZrZX1B9trq
	QQKzRO4XCUM1Mf1sUY3IaiKyqPkXyeUpK42rmaHACPKk4f1CQs1NptSB0Z6JbcZ29zoZdQ8yivmGU
	KAeX4UPrcnIZLFQ/LAuX6WwrFr5yRV5VAB9h6jIQbrede/xADBiXxsS+lPB97y1/eZEIL5ncjZKY4
	v2xQXk7A==;
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEZrR-0000000A5cQ-3bYg
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 21:07:11 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-785f96ae837so18340387b3.3
        for <linux-nvme@lists.infradead.org>; Thu, 30 Oct 2025 15:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761861757; x=1762466557; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O8nng/o7TemTjcJv19bbJKh3cyQwt5n4WNif/kXxBHY=;
        b=aLgvVZe48L+Ws8N+M6Qy9vHH7//935g2+9bW/6P+s6MOTh1LbRn3N4cdK+khoaLvyd
         P0q48zfCUT4zj/tCcskn0IQZoWTHfLc7Zg404FZQ/BWEI3RRBw7ajDtObrSdssOk7d8+
         AppGyRfuUzd0oXzLqaVQdDwG+oG0l6qBG5aRwD2y9cXyObe4ZlGzM+Kw0lsD/GUyblXz
         f1wHYg7YLiWkhGkiV9quobTyvHV9L33ueMMqGCKOwJe1txMNWoGpiC0+H73uV1SzGfbg
         ZvLjfHVIYKAu5MO0EGtDWKZa+ohhc63HC8Zi2ora51FnJGAACmf/ne5THKqcnpe9cmO2
         IrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861757; x=1762466557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8nng/o7TemTjcJv19bbJKh3cyQwt5n4WNif/kXxBHY=;
        b=w1gUcGEboeORcepIKgaFulSlIIPm3WU5jmGNLx/MPP19Cly59qIwa0tlT7WRdn0QRG
         4yMjbPed2PF3hVdIyAJXtfNHqy1tsoYu5N4qy0U4UQrwYvlK5KjPuZyO05elLKk3iCQ6
         YtWRQzWRuBrpdSm4GgtQO9Jvf1m/j53zwdDSN0B9xX/6jwIsgsrljfapADrO0QVcZA+I
         KFCHNysSaQmblu6bJWaDlmFAfNdz0Q5f1qoD3H5yK5dRWxKQinr2aRVPi6Nv7Wsg+R2A
         5CMRN4PMEJJAUBnn0JkeZW56G/6fgGt/MDdkWr/7xk8h8GMrr16DsffWzPMOgoCunZfK
         ltuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdLy44B82S7iF2EDNpweghyIczB5uXBAeVp3cc64ZlcTICMa1jkK6LJcvmw4Hmn4YVdrXEs3AjAEAB@lists.infradead.org
X-Gm-Message-State: AOJu0YzqW1FBVEUHHDgPyMi8cJBe5pKQsqBNlR3pnRCJOwMqldNoGvfA
	BZm/HF3b0WzagnRg23FuaS1b+Qs3JMq2zlst2Kw5x17gp5S6Qf1jVfcxOzz/t8qjYnIknRISusc
	sXlypyXRxIF0px7a53m1e13Il1byADkUTU99I1W0=
X-Gm-Gg: ASbGncsOf3/6VQO5LlakMwa6T+MlIcjiJI1XIIYj67bTwBWgsr1Ir+4RMWXOTPO2h4z
	AHwcHXS8FNLJpIY8u6lyUHg44Un4Vj9jr1zUnHGh1QUaXArcMN0SRPov9Ra/s5mkpBECpSeBq3j
	UjcNAhSWqw2mTA+XPo4dWWFkfBMIAwQ2nJG+qv7KSQUcvS/1nwrRFld7cLesaaBDRry/yZR2PaW
	e2lnLuwjS1UvMXSOGujMNLq1FeBRjAIKXZ93ddrN5YMo8OP+bIeagZ28Ut4X5Mm1B9/BJNm
X-Google-Smtp-Source: AGHT+IHYqGsWXdG1hjFBIPSMjozWYVAmeen3VtzVdRTwar1VHBzAUDvza59snllaBPPxi1yO7EYscCMwHM2FMMPXutM=
X-Received: by 2002:a05:690c:e0b:b0:786:24c1:9da4 with SMTP id
 00721157ae682-7864842bc63mr10442767b3.18.1761861757479; Thu, 30 Oct 2025
 15:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <CABPRKS9GGS2mQ46UMmM3G_NnamCsYj7zBaa_c4rQfO1h=59wrQ@mail.gmail.com>
 <84d028aa-31dd-4f8f-8370-3db4667d0dc7@flourine.local>
In-Reply-To: <84d028aa-31dd-4f8f-8370-3db4667d0dc7@flourine.local>
From: Justin Tee <justintee8345@gmail.com>
Date: Thu, 30 Oct 2025 15:02:08 -0700
X-Gm-Features: AWmQ_blrFKkGxwx84crAfwu2XHZpjpNwsFvpyVhlBY_WgnEMRx3u8t6S7gnD5ng
Message-ID: <CABPRKS-s-32fzdpyE8_7jf8r=qdzxug5xq8jqoVwcEawOgqdUw@mail.gmail.com>
Subject: Re: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-nvme@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
	Justin Tee <justin.tee@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_210710_004728_3FAD7798 
X-CRM114-Status: GOOD (  12.72  )
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

> I've dropped the nvme_fc_rport_get because it's not necessary, a ref is
> taken in nvme_fc_rcv_ls_req, so the port is not going away until the
> disconnect LS is processed.
Yes, correct, and the put would be in
nvme_fc_xmt_ls_rsp_done->nvme_fc_xmt_ls_rsp_free.  Thank you for
checking.

> All tests seems to work fine except one, nvme/58 (test rapid namespace
> remapping). But this one also fails for the other trasnport, e.g TCP:
Okay, sure, we can try to address this in a different patch set.

Regards,
Justin

