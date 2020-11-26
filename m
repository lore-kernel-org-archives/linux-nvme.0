Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C15C56201
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:26:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E262075A
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xTlBCVJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E262075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qoorwMPZ7r+1H//aS4Y1jhPmTU51KKt5yFFpDNNkCjk=; b=xTlBCVJVcxA8Te6hM3jQnf//z
	R18S/AgGbkZrJpVmBBzkzhXlaulUENMHnvC02/zimYWDBDuIPnyy64HqHMjTAoylGUwnu7ZKBU1FD
	XuAVkKc9+4Y48NEVm3FuNCT0AAqUdFoBBYm0OV5MAH02xJajMcW0yrJrUiY+LxygY4HsqgC1eraDH
	nta+yAkZFlTmLXVtW07Q0jEMF6xVKguLI1LILbA37892y/YMnVlSpy2qWNQ6YtIWDBIW3y5fG96Af
	7b4FiqOHUgnnepTV2UK7nLBRiINXFgAwvh4F9Dc/HWA/agoChJIhNOH9HCc7JPmpj8Pum0GiQJaKG
	yyZl3k5WA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki63h-0008N8-Gr; Thu, 26 Nov 2020 01:26:53 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki63e-0008Me-NV
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 01:26:51 +0000
Received: by mail-wr1-f67.google.com with SMTP id s8so321431wrw.10
 for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2020 17:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CuLOJz3HYAgyzdtcjxvw2muBZU8LiW8bVYK/CrPFdWY=;
 b=c+mtuqKAmqgfV9WPa4fuMeULTNWyTOtnCC87ffO30AuDA86IIPhUb47ndgmKk4f1kq
 uXOYKlkAbZFNfa4d6MvU6Yy7ZMGWMKqjaCvEPQlu7NM8bxdOIi9xIcfRaW1ww3duvUTr
 GzAqNKzWWqoNVBUMx2mjG+EHnSWmc8ekrOhBYZJXsuEF800zbdW2Vy2thtnnGRSnufSn
 g/emlulPy3HSG6NzkW9UE10iUOM2/Y3AWdlyzhapnGgInh3+G7hGa94lS3hHr5lQq1Hm
 0wTL/Ry4+DPJzpRpCcxblxi2UXFV6ycAc4B9u64N5h5kN2LHzJoqUSChfAhrAsHNkptp
 cNUQ==
X-Gm-Message-State: AOAM531ycBRZCeHs1W12pmbF3kfhc74WLkgpWpsvD17ez/kxMCAzen8b
 ISLme2bL7qwLGU3iAZl8qiY=
X-Google-Smtp-Source: ABdhPJzJdqMXfSWz513Rz6K/RVs6VcYWoX8M10gYcjk79B/DDn9E5+l/THnBc4cCkevZuSK9RzmlbA==
X-Received: by 2002:adf:e88b:: with SMTP id d11mr746344wrm.4.1606354009539;
 Wed, 25 Nov 2020 17:26:49 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:5e57:3445:eb42:2ba5?
 ([2601:647:4802:9070:5e57:3445:eb42:2ba5])
 by smtp.gmail.com with ESMTPSA id q16sm6916583wrn.13.2020.11.25.17.26.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2020 17:26:49 -0800 (PST)
Subject: Re: [PATCH 0/7] RFC patch series - NVMeTCP Offload ULP
To: Shai Malin <smalin@marvell.com>, linux-nvme@lists.infradead.org,
 Erik.Smith@dell.com, Douglas.Farley@dell.com, liuw@vmware.com
References: <20201119142107.17429-1-smalin@marvell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <eb819457-aee9-e203-13d6-72b3afa4cfff@grimberg.me>
Date: Wed, 25 Nov 2020 17:26:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119142107.17429-1-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_202650_827483_8E7E592D 
X-CRM114-Status: UNSURE (   9.68  )
X-CRM114-Notice: Please train this message.
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
Cc: aelior@marvell.com, agershberg@marvell.com, mkalderon@marvell.com,
 nassa@marvell.com, dbalandin@marvell.com, malin1024@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

You should tag this set with RFC, this is not in consideration
for inclusion...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
