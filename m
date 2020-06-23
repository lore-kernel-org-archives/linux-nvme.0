Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72981C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 17:43:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43CDA206D4
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 17:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LTbZHjOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CDA206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QhJhyChmR6SvST61aXfyiO9VzyBfVYSdyNCZXYnjX78=; b=LTbZHjOjgN+CEp+azFjBEobxq
	NryvRt2omZl9ywLpwnJDkKUWZQ3sKFQUz15bGvg3Dewxk9Aq2DpF74prau9uVS+TJl3v7w0n0Xi9y
	3Mk0gAgfLmUcU/1KpFFoYEVFBNQLp6j+snigNtTJr7qF9k6fLGMAyYkyJuklHblIW/ZaAC4sNW/NI
	aOnIEZXbZjc7t/0VRLnDo9ANhi3mcjhChOsFYPTVkoEQxRogeHZyZQ0BNKvOHMSLF7xXbF12qE8a7
	o05gQlt/J9/WtRgE4ZxHKNfPnqjZw1F84A1DRYO3HdspA1iEuMPkRRkQb1hZ8gmkBvYGzmIQHMVgz
	96IYtct4Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnmx5-0006gB-FU; Tue, 23 Jun 2020 17:43:19 +0000
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnmwy-0006e1-19
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 17:43:12 +0000
Received: by mail-pf1-f170.google.com with SMTP id p11so1739047pff.11
 for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2020 10:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ckiUV8HeIYQ/rsOxCbMNm/VjxU8EUESI63njQcctYnQ=;
 b=OtqxBzW5pTgHApp/ABZMre4fafFrMlKWErq9fKl3Jxb8B7K/74atsc9x3etjkoolfe
 PsIAF3Pf2EdgyEYyZbom++1RMLGx+Nt2Mo+Lkc+tOzAJUheyuV9lxOZ6caWEwb7RC/nH
 DBYgU9Ka1AevPDW7RJ/o3jGw4+J4xR2yEDvb9AmurfNbBfBpRTd9VWSB+R1YGYSAUPkd
 T5OBLakCmbmdh6nYVmpoh889ix4tvRGxWqmyQwaF4OrfVDL8uAAYP9JpU//FDnL7wsBI
 5qjcciJnbrLI96TXueiaPOD6O5iv4DmsiBUufU0VjHlPGHrxLaYYVn8jKciWPLSUTjMF
 GqRQ==
X-Gm-Message-State: AOAM531X5ie6ZqeEXLMCaKoxJIFQwypyIxL+FLwfIKeHCZ4T2IM+fZ4j
 KMlpNagLL6n0hAAo1n0Gjpw=
X-Google-Smtp-Source: ABdhPJzvOrvwr2DLTVVIde67x/c775RYVIHNXY8NHcSVpga+reIuikFYQrsLZ8mW0Kxoq9kCLhz+EQ==
X-Received: by 2002:a65:6846:: with SMTP id q6mr17025054pgt.397.1592934191009; 
 Tue, 23 Jun 2020 10:43:11 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:acd7:a900:b9f:8b8b?
 ([2601:647:4802:9070:acd7:a900:b9f:8b8b])
 by smtp.gmail.com with ESMTPSA id c9sm17759079pfp.100.2020.06.23.10.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 10:43:10 -0700 (PDT)
Subject: Re: [PATCHv3 4/5] nvme: support for multi-command set effects
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 hch@lst.de, linux-block@vger.kernel.org, axboe@kernel.dk
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-5-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f78451a9-0df4-58c9-2398-bcec40dcddab@grimberg.me>
Date: Tue, 23 Jun 2020 10:43:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622162530.1287650-5-kbusch@kernel.org>
Content-Language: en-US
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
Cc: Keith Busch <keith.busch@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Daniel Wagner <dwagner@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
