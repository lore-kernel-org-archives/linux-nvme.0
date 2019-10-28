Return-Path: <SRS0=TJkX=YV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C75CA9EC0
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 20:27:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2806D21721
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 20:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mb9ZFTeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2806D21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VGqcTdOIRl7k+1nHB+YA7o49dYX5Ign5OjBAuPM10fM=; b=mb9ZFTeS+vMwebrV3/w6AnT2v
	JDGH7S0uF38oDQGaMwNKrvKe8vhPEt6vM8Mil4WON3EYF1KD5E4+Zztf2uiVvr4k/7iU/B1sldK02
	iX2OgNopsDoVj0DOejK2pFEkAopd1gLjwJYePc8Kx+zYjGsc7anlcqA6VnMIjQPLnH5WfMAmUKJid
	XJ2vTj7GU0il587DXn4vA+DCs/BBP9labeFPQCJEUM+Pa3+xGGOvcm5on84/9MH2F3zwkh7tb+9Rk
	ehVijEmA16HzeN5MiC+iGoIt793oBpZOwlh4mhmg0a9/PP9/50NkPqSdsh94D2OfYqGFMTRRtbzze
	7cQ2Ek/xQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPBbP-0008FN-OI; Mon, 28 Oct 2019 20:26:59 +0000
Received: from mail-oi1-f171.google.com ([209.85.167.171])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPBbN-0008F0-En
 for linux-nvme@lists.infradead.org; Mon, 28 Oct 2019 20:26:58 +0000
Received: by mail-oi1-f171.google.com with SMTP id n16so4801734oig.2
 for <linux-nvme@lists.infradead.org>; Mon, 28 Oct 2019 13:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KSwf6YKQuOuNajmGdQ7gKEV71+gjIPpE/B9qE1+kGwM=;
 b=nLwsNcbjMwWC0juPq7PEd24xZW46bImKdOPArVLwvEq3oyXje2AkQIjSnoefdQyIVy
 pn0+dbgCC+xVUw/btxO8PnLuDDCGCyJKFPt22yXtPvjWXS4OWBGlktHDYTqAXq7uaHFQ
 OHsCm80DS0v6ZZCMh6G0N0bzP7Ma/lLLMfLviU2/o52+o+p9ki8q7wQax9JO1eDi9IGR
 g8qNkbokMaABMQl3skuytOHP1aixNNOowga8ro9xzmPgMhBGvnIuqAQ+BXLywgau4rP4
 y4Lcm3Vcx+vUr69cJMRIYPJv5CBu0G+zIuV0M2hDzVt1LUhzurSp4Bf1i/hXDC3VhF35
 33AA==
X-Gm-Message-State: APjAAAU0srvBic2AAkdAkgyADGcmumkSTKWPNz269SNq9Z0Yi2uIJ38U
 om2MONNsosiHwvpEhbQUg04=
X-Google-Smtp-Source: APXvYqxIu/vGRDTQCNJc6cHAEkPRN55/CGvMMtEODugO0V+///zaXVnA8Tr8I8Yf50CmNNaSc9O53g==
X-Received: by 2002:aca:d19:: with SMTP id 25mr882507oin.64.1572294415851;
 Mon, 28 Oct 2019 13:26:55 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id w4sm59717otp.22.2019.10.28.13.26.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Oct 2019 13:26:55 -0700 (PDT)
Subject: Re: [PATCH] nvmet: add plugging for read/write when ns is bdev
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20191028182326.14311-1-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4fef7f91-67ce-548e-ae0d-6f43fe1d1bfd@grimberg.me>
Date: Mon, 28 Oct 2019 13:26:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028182326.14311-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191028_132657_495629_C5DE0068 
X-CRM114-Status: UNSURE (   9.81  )
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
Cc: kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good!

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
