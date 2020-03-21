Return-Path: <SRS0=c63/=5G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32280C4332B
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2020 01:15:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5EC2072D
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2020 01:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BUF10RhX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2IRvBaPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5EC2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o7SShKxaLBd2xpWO6BNwEQiAZ0F77xlibNFvj4OV7DY=; b=BUF10RhXCKdCbI
	xIESULIFrqfqtXi5VZSaPWFVxhY0XIdcujCxUUDSORm6gtOTUmov5ak/SN/FSMxfhdyHtOP1qRj/G
	Y/6MgEG4BVTE95TQIPsKM/VKmP90aceUOnerw5pmU1lt1y4/KFWu0T0DCyTy0fylzC07ksHTYXq0l
	iBPD1UH+MFyB9N4Dt5N5ljPiWxBHWO38AceKK43CwsjcvB/wpPh6Q3NAX8XGEjrzhKG4Qe//1XBxx
	5X+DWXaaNl5yrlSff2HhkqaeObLDJqZpJ4/sOnaD8eYWEpoSEfKWa4Pa4UnlZUCW+357EhWXpkxUw
	pxhejOD3r8h1ONsTD66g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFSj7-0002UP-MT; Sat, 21 Mar 2020 01:15:01 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFSj4-0002TL-1R
 for linux-nvme@lists.infradead.org; Sat, 21 Mar 2020 01:14:59 +0000
Received: by mail-pg1-x52e.google.com with SMTP id h8so3926297pgs.9
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 18:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VBomDpdx/r0fitEc1KkIhvhmlIkWC23w/fn5JIwmCYs=;
 b=2IRvBaPE2bbicH54q0oyTmsxYA3MC8N9op10r9hNCVVPX5KGRa7b5/mEWTphcT278H
 OEkYOfU7ieqkmfSmsMudIkSsxgZehN6z7YxEtLVyQZT1Tm8NtiOidnt5dZlO/kg+SBPy
 BObZ+KZ+wOZOxRbgSQ9YPXnmOs2f1PFfe+Zdz1DirgxRhqfjSp1RAtmSBF6RXvzA7V1U
 F72USdLXG9PSdyFimv8umGB8zN6zBFGYbKmbx4O2J/dVe/rIgIY7guslF/Hmap5SxSh6
 xKk9Tm0H1pi2eIbXXkkoFELqTKW9dl2AdtmVfcNul2Y1pqRiNGUZEvyEvmP62JNy+4OD
 4xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VBomDpdx/r0fitEc1KkIhvhmlIkWC23w/fn5JIwmCYs=;
 b=jE5y8rgPNBo9uKN/y9pmXl6NyiCOlkCI8HsQDjU19RrvMJZla+LW+HfUtD5D5J9m7C
 u8C3TOcvY0Ll5k6okyRqwxFHax2uJ9jjFBYCdPqDYZp8eAEyJRHWeIeAGNrGcLefT4Ui
 IAnlZUJUVvk8K6V4u7M6JvsXxA2FUrffs95tClMON/zrzp2b6nrTQjl40gELr9QdfmjF
 wbPBM/8zpX6kAGPutNUElCb9wQ6544E9ErP31QlID89LAAlTuhGgifNZVTWG6EmGGx0G
 mT+zdqSWyx6z9r0sgJBqcXZnaXZrXeOdCB35qod57/MSE153giJTXclGHhv7yJGzYGSy
 U08Q==
X-Gm-Message-State: ANhLgQ2Ane0Q6zYd54PGPJxOp85x8Vex4IaYEU9J6dKTo8/Sm0DQukBQ
 s4LtS28KmT454yZOiMXRnRAB2OsHpoAi9Q==
X-Google-Smtp-Source: ADFU+vsLxrMGpFZRfLGQo9iqGZMLa5d/js5IEPhrpnRAEPr9UgDH/vTRpy3qRyJPbdmdqLCU2SlTMA==
X-Received: by 2002:a62:76d1:: with SMTP id
 r200mr12888517pfc.298.1584753295352; 
 Fri, 20 Mar 2020 18:14:55 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
 by smtp.gmail.com with ESMTPSA id k24sm6509327pgm.61.2020.03.20.18.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 18:14:54 -0700 (PDT)
Subject: Re: [GIT PULL] linux-nvme 5.6rc
To: Keith Busch <kbusch@kernel.org>
References: <20200320234344.GA20291@redsun51.ssa.fujisawa.hgst.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5e39d86a-d023-792e-6efd-13752ddc00d8@kernel.dk>
Date: Fri, 20 Mar 2020 19:14:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320234344.GA20291@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_181458_139547_14813C54 
X-CRM114-Status: UNSURE (   8.82  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/20/20 5:43 PM, Keith Busch wrote:
> Two late nvme fabrics fixes for 5.6: a double free with the rdma
> transport, and a regression fix for tcp; please pull.

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
