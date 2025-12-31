Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D447DEE6441
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Dec 2025 21:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pu5O4wGD2CxgAlBW269ASkhF2D9fpRa+WcSdjEAu7xA=; b=uZRnY574TDeTy53v1WXsu657Ct
	BtaW20ZmNnVSBJqf6QSATchkPtZ57Xymd3e1SNpsQ3u3uMJSqXeL2+01XpVEeeLqT/2azGKgP7ObK
	Hwp+ogvit0xXZjSAvzbEYQz9ILPDXL2P774J3v2cmK4Emb7XsdZ6hTrrsyXyDOZG7xokCiyrTSPc3
	NYunF3aKRuLYDshA8sideg0+bVHOoYDS+i2oG3dbcUlU8vKhcgM+XJ0kguhui7dSbHxRv70n6TwlE
	9WmWDFnpLg9j47PepvZ7NtZvhrqrgZRfoXwtF+VCwG6lY8HgLSLbcu8YHBB7DQl5280k6YSioG228
	krBDMmqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb3Wl-00000006LEA-3J77;
	Wed, 31 Dec 2025 21:14:43 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb3Wj-00000006LD2-0wPr
	for linux-nvme@lists.infradead.org;
	Wed, 31 Dec 2025 21:14:42 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2a2ea96930cso127141515ad.2
        for <linux-nvme@lists.infradead.org>; Wed, 31 Dec 2025 13:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767215680; x=1767820480; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pu5O4wGD2CxgAlBW269ASkhF2D9fpRa+WcSdjEAu7xA=;
        b=csk0D5F34N3UvNfnUB8qtLRa6my/fYeE9qBSTiy+e1C7mp7kmBO0L23cgikwCXbIeD
         Tiy+TFFT57cO4otBbYJwncRF3gWQD0iRSTK4x4CpjfdG9cjmti5VkcKEEnmXyRZZ1zx7
         nbTyMov+lYi2Sw8r9otWLsviLoTttuBY3iuQ6jZpV8D4Pc4zvGHVogiCfFnyjh9LptHi
         RQf7NXsjeSH7r0NQvVHxjfc0DpQe+bE+HBT5myoTelIAVQ0ntlukmbzZxQZZHqMdpybD
         KJcDdbmXqQfgti+kd3xQol50tK6KnMlqzYAs4P6jl/K5JXkLd2WhJMngGHFPZi6jgjA2
         7e2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767215680; x=1767820480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu5O4wGD2CxgAlBW269ASkhF2D9fpRa+WcSdjEAu7xA=;
        b=PMFlufuu4NpEFyYnVW2FvA0clPHxEWwB5D4u9p8ZcfizfByQ/Bf0WPQHVUSnt/THBr
         RCU21kl6AlavWBfooU7xZD5sgZSAy8VJ6k+CUnHf0cVwc1XD/+isKARaBQiUDFFl2lVP
         4TXNFQfEgTvb+jxpAYJ6KdnJlNsKqIeGt9218I31IaASdk2G3jknX4nAnTcLaH4jJ1Qy
         s+ioRU3YTqU4lW79hb6svj3gIdtqoHs7CMBOyDWZMjJHNqqZ/rFlEkgM/x27qIl4lSG/
         SzqA+a8FwE3PcCSB7aejbasmMcUH7GMM+xmkyfD10gOBtAJkEOprLfRn6mkWqBEpuU7A
         LXUg==
X-Forwarded-Encrypted: i=1; AJvYcCWRVA8q7T+VEm6UgOQIyUpc9+8Ws5vwcrmwLCfvqSWy7TlbqjP9EgTBCTbrPrAoUlS2wltph7eoNkwR@lists.infradead.org
X-Gm-Message-State: AOJu0YxFnNiMKaNSFUbbQKBrByJlx6zvVOsj/tyJ0BYLhwopXgYwGT38
	At1syRXrSvGfQnFEdDytTbBll0308uOZvWS3T7+S+hYCB+2uOmCU3eQQAgO+pbj7fDM=
X-Gm-Gg: AY/fxX4ZYAQC4yYzRZYMqWvgOVoq+YMvf5fwAjwm+cIkwpo8vmr/wU+c3DFAoJ+QZEC
	fWVukMvJafoGAl1AtYliCS7sO20+k+U37V+FVsMEDFQY8HWS+fNHYNyDLqAXrFEpCNDhX37T9S3
	eSYfTrA7vNhocWH4sSqIN+J0NEJUBCffy9+zeuhrHrKGKOQm7qsb9bnoUtLqBi1jMSWI223naB3
	7/dBu/KnEyy0eUismhfT5oaSEfsbEy/6ZFaH/nk4prI1xogeLc5NC1rxXC3j6nzSkmySWN95QLq
	PKMzcbh2JEo8OXM1e5zYwl7WmSU0KIy5b8CUACz5aEQ9J9q84GPP2VFR7m7B75+qgz+lMlHMAPd
	g2/ynj74DGw9Zb/HcCDQet32vOC8TXloR7/VdAi9JC6pnjAGp8gmZABxNKvt4IAC0zqmvOuW/HX
	JwnX4F+PA7eUPHoxs32S5mS2IiaCiC2P8=
X-Google-Smtp-Source: AGHT+IHc0maiCgm2VUEpos9ZGYv2SGV7wmwC6Avb1+4FL3CCDpBIFrYDwa2O4M5UTpVjNi+kJmB8sg==
X-Received: by 2002:a05:7300:1351:b0:2ae:6146:37a8 with SMTP id 5a478bee46e88-2b05ebd8b1emr35979019eec.2.1767215679476;
        Wed, 31 Dec 2025 13:14:39 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2b06a046e99sm96264111eec.6.2025.12.31.13.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 13:14:39 -0800 (PST)
Date: Wed, 31 Dec 2025 13:14:38 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Randy Jennings <randyj@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Aaron Dailey <adailey@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/14] nvmet: Implement CCR nvme command
Message-ID: <20251231211438.GI3864520-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-4-mkhalfella@purestorage.com>
 <CAPpK+O1iXmt-HeK=ftSrPJn5jXAB9GaEf0sMY4VT0Wj_DXfxJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpK+O1iXmt-HeK=ftSrPJn5jXAB9GaEf0sMY4VT0Wj_DXfxJA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_131441_298629_06F6A010 
X-CRM114-Status: GOOD (  10.90  )
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

On Mon 2025-12-15 19:01:30 -0800, Randy Jennings wrote:
> On Tue, Nov 25, 2025 at 6:13 PM Mohamed Khalfella
> <mkhalfella@purestorage.com> wrote:
> >
> > Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
> > Reset) command is an nvme command the is issued to source controller by
> > initiator to reset impacted controller. Implement CCR command for linux
> > nvme target.
> Remove extraneous "the is" in second line.

Removed.

> 
> >
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> Reviewed-by: Randy Jennings <randyj@purestorage.com>

