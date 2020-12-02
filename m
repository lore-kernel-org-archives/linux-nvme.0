Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DA5C64E7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 10:06:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DCCE206E3
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 10:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCCE206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BfI9SUm4UniFaYhDR+aNabWM/paM7GMe2+OCvShzT9c=; b=aKyU19y/1mz84o5VijNX7KQWc
	eEjBDFK74NWgnomw17lQECLGvv62HsU3wKMaEP7Ov5uLvSLt7PwdD9ldoOuWjqrmzwvz6qN4r9O6W
	AjVf4QNUMauQNxW8knLftfMCO3mJPkch9VXml87EvCZ5OdMVGtN6ItoKoL41q0BGmnHO/Q+5EQQUF
	SzfUC/4+OX4AMHTMhZ3JwjiRdTv/GkP1WBqMHMgDbBooeyB4qFXlmRiYZflw3accAC8WFjIR+3HGa
	WwFVLUigZ+FE8+9z0o4yegt6mLnBeKWRMc75i7UXHx3+0GWp8cWlaaAsf09kh8i++WBtS3/rQKZYX
	SMRovCsnQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkP1s-0007uJ-2o; Wed, 02 Dec 2020 10:06:32 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkP1o-0007tx-UA
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 10:06:29 +0000
Received: by mail-pf1-x444.google.com with SMTP id x24so925624pfn.6
 for <linux-nvme@lists.infradead.org>; Wed, 02 Dec 2020 02:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=q08lUdYigEAJeLRgm81mphr0kvzIIwFBUxsy7YBUVyY=;
 b=PLz6Mt6EiOyYhVKC1KmK2K2DiVTnw0LctAehzXAF8K7p1VcXvIjCRNy+GFrvN0mRvq
 dpDapVR/xf+aiVOy98v+YWg2E0gXk+2Ctnq63a+Ygyybzhjs7GSxUUWU7I0cSKSoACid
 BFJ/u55zpfc4NSzj78i9tCz3XQf+y0oBFM7vE0bf5BGzuelyWkol883zTtzZoBExKtn7
 gD+yhzfjJ+gSC8FPeJIyyKpQXTviLmKpOD7QNLORxprNHm865X4ZfjuXC5C61ZtBGlb7
 E/Cn0qJNRVtAjtuWzW/WBCFlumatjbe/SBny180273IeCOsz6028nTp+IDwkoogwLsxW
 iZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=q08lUdYigEAJeLRgm81mphr0kvzIIwFBUxsy7YBUVyY=;
 b=uUPIqVWjNXJs8VkFll4Mv6YK6yPI9gXEMsqJkL7geik5vmWGAVeYBdFp/02EBVaKaa
 VTQb90Hm7U6927aR0jteknLY0ELokxH/VpjCXe7qwWL6T6+IXpc7owK25hMcrakE+f79
 +7J8Qt4yQ3VynH0rUWriBQzFm0rpZLeEXORbEONGivwvUIQBMJ2Bc4eTlxb6UwundAhu
 /P2HLVkT+IVez1NW18BnvH6qhgzwJzGUV24wMTEwFS+CsIFpgaK3q3PLWscY9+bJ/ivs
 DTOqlDyipUfGsKfeUpehIZPencjFWCuh+ArYBpnHU7o24DuJNG5kiawFWR+Bj550IuC+
 v+ZA==
X-Gm-Message-State: AOAM532ShxzJ/W0cTeTQd4KbjLA7PKCvM2yeN/gGqJKlW79Y7MujlnSw
 NgCy3ZaghBhNssVeJ+t71C8=
X-Google-Smtp-Source: ABdhPJyoJ+jnd3I7W/HYlA/c9vDhyh/xEKvZbSMd3MuXAqkFxmmRD8LwwXuuL+Iey2dTeofUsdbyOA==
X-Received: by 2002:aa7:8f3c:0:b029:197:d067:4e53 with SMTP id
 y28-20020aa78f3c0000b0290197d0674e53mr1836140pfr.24.1606903586337; 
 Wed, 02 Dec 2020 02:06:26 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id q6sm1818174pfu.23.2020.12.02.02.06.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 02 Dec 2020 02:06:25 -0800 (PST)
Date: Wed, 2 Dec 2020 19:06:23 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] nvme: Improve warnings for scan_work
Message-ID: <20201202100623.GA6427@localhost.localdomain>
References: <20201130124747.14725-1-minwoo.im.dev@gmail.com>
 <20201201192338.GB2149@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201201192338.GB2149@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_050629_020612_86679E4C 
X-CRM114-Status: GOOD (  11.89  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

On 20-12-01 20:23:38, Christoph Hellwig wrote:
> Thanks,
> 
> applied to nvme-5.11.

Thank you Christoph to update commit descriptions wordings.  I will keep
that in mind not to use abbreivation for things like commands.

Thanks,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
