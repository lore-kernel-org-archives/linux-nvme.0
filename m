Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A05C76196
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qZR6cbXQdwB5nUHvEEH2VeiB5R9CC8hRiYSzmgcjAyg=; b=MGe9d0LgIyB9en52G74T8zK1YB
	DHtwI4DZ6ujM5wQJYHC0KbpLvYNGG8Yj31LcJRu3nZ3Hc6IJkckzsfMYD74XSbAeSjBn4B4ARGBb1
	MYHs2PptLZIkwEfeTgdQtMSMXvUxYRl8RtE69yHxPQzhAZOcznGjEOA8zLn4LR0DRbHafojXxyMG3
	YXZT3FEHOYZelPv+VcYdvzUULGI6iRPI/H4TC1RDKrxWh5u01GMf1PgWzkKk6RqhabmT7xAAgfX/+
	tqtLSXDpNPPDwDzCbyxhmxEJI9Hk81e15QBqjfLV7CoBA5CnNr698RnkO9uaWn0SmMMbUHP5DYMnU
	7vvVxwFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phCQ2-00FAUm-2L;
	Tue, 28 Mar 2023 16:43:34 +0000
Received: from mail-oa1-f54.google.com ([209.85.160.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phCPz-00FATZ-25
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 16:43:32 +0000
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-17ec8963db8so13316895fac.8
        for <linux-nvme@lists.infradead.org>; Tue, 28 Mar 2023 09:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680021809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZR6cbXQdwB5nUHvEEH2VeiB5R9CC8hRiYSzmgcjAyg=;
        b=5XgFBKGK1jTDz3jFA9oLGM/wthKKQHcGFi0og+TTHCE18rBqFKAR1sM4XwDwfCIR26
         5Gq3pYWCbpPYaO1/xZZ1x2DvTJcamMR+imNxqkVoRpwFuCdgnKUCXEPF7eZLjiu3cCuQ
         gnxgqTF6ucSrWHjWcTH+wJu4LO8aXzuqtc2LO74U0rCAauvaz/PpmQAGfsCgICtIHKRh
         zioxMUpqyxeO8D0cPeJXklwCHOaDdzWzVgKQkdp/PMk7rxehaAskUtmikY1IKGmxDyZD
         h8BPBdBBAvzd+ajcSSFHh9EiMF+wK2JNwHbNxFPEfflgXizi3wXUirdUcAxFM1zoyIZB
         C7rg==
X-Gm-Message-State: AAQBX9dXwHqdBK1eR+KoMGFsMFP7BrIFYi/c5YZI4oxHFTFlWnCdZQGN
	u3pPU0mYH/noS9VXzrZjzeJ5EJ8G3ZSKS5FwFHO6
X-Google-Smtp-Source: AK7set8/4ablYvt1w3rWWxBu5RP3Per1gtZi0bV85eHN9m6lD3okcPGkDhxHJ2UAhi56YjYdObx6pQ==
X-Received: by 2002:ac8:7d46:0:b0:3e3:95fb:8771 with SMTP id h6-20020ac87d46000000b003e395fb8771mr28046888qtb.31.1680021371021;
        Tue, 28 Mar 2023 09:36:11 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id t23-20020ac865d7000000b003b635a5d56csm15765739qto.30.2023.03.28.09.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 09:36:10 -0700 (PDT)
Date: Tue, 28 Mar 2023 12:36:09 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
	kbusch@kernel.org, target-devel@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v5 01/18] block: Add PR callouts for read keys and
 reservation
Message-ID: <ZCMXecSrJ97oCD+s@redhat.com>
References: <20230324181741.13908-1-michael.christie@oracle.com>
 <20230324181741.13908-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324181741.13908-2-michael.christie@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_094331_682330_3BB74B1E 
X-CRM114-Status: GOOD (  11.25  )
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

On Fri, Mar 24 2023 at  2:17P -0400,
Mike Christie <michael.christie@oracle.com> wrote:

> Add callouts for reading keys and reservations. This allows LIO to support
> the READ_KEYS and READ_RESERVATION commands and will allow dm-multipath
> to optimize it's error handling so it can check if it's getting an error
> because there's an existing reservation or if we need to retry different
> paths.

Not seeing anything in DM's path selectors that adds these
optimizations. Is there accompanying multipath-tools callouts to get
at this data to optimize path selection (via DM table reloads)?

Mike

