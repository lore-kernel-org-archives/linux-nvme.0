Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B6DC07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:10:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B35F610EA
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B35F610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Spssd7MGkyltkAlBhr41lnJJwu21y3xnoDw5Dkt7X8k=; b=AzH7NFQ/v3krnh
	GMdUOTVJXnLIH2qAbt/ono7nSqPzn0ONU0z+qX5Ex220EfnCF8JYVXQzM5j4E4+bIin1iqT3E4doP
	KZMQFAB0RlTiC1xDsLsQYJ3154pJm/YBtjSosUVVzdi7/Y/t7N89ChechUAN4kRUDIlee72foxGhy
	D16BLLMEf868uWabx2TJjXUifdN7xZEq9O2z6MLHQQ0jVW5s1V64jTKemjiMnHqc6npVD4MdwcXXn
	BmqpHwOCOXporXLF2o+hqalH+H6Rg3BqwiLvj3xLuQAW6+qIzTJsx6jgXFTvQFr3twV8tOOmwcGU1
	pZ4q7QxnnoU7x1NT+JPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0QFC-009I7P-5M; Mon, 05 Jul 2021 15:10:46 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0QF9-009I6D-FH
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 15:10:45 +0000
Received: by mail-pg1-x534.google.com with SMTP id 62so10467727pgf.1
 for <linux-nvme@lists.infradead.org>; Mon, 05 Jul 2021 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wLt72f07otkhuvObqt7yAKJBqXFchKJQUm0amSKfqd8=;
 b=Dhj8Y0/b+GpIHP398eFLhWOLm4QciAxci6tRrwSSRWO+Z4MnxG0RbpPGTM77W2VWb4
 nGs1WKsEdJqIMe+uk+IrbtYWtGPixmgPOML5eOSXjYN0s5yQw450dTJ+UOCpkiOI7G1D
 mFUgKq+xfhaJpLtGpBJXOxeXjsk1O1dHkSPWOlTL2QqWJlrcP9WvJGuWC9uxVZ4+nV5i
 ND/ioUSMduqAHVPdMtk1KLQanbKYmr96W93okjBe374Je7SjTM2Z6g+ZnR9FLAIumj0M
 5FJuSRAAKBf5XWAIxOsqhlyNmPTkjKQLJcQGq1lkQNhYru1+DuMlti3ndh7SMgpmPCZW
 AH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wLt72f07otkhuvObqt7yAKJBqXFchKJQUm0amSKfqd8=;
 b=bNo9zF8948oYC3/1dAA2iuHrQl2xvjiNmn83PpEhZOeJ43M/QHjINo2iEKuHok7fvp
 Kas9HytVBL8ZGi3cmhulx9AKBz7KfltVyRh5IqUSNNK6Dg6a+oVniDcFYzHUUed/sHsT
 7O24GVsRIvMHkyVWy3YWCU3NjVJ+/M/Sou8ELTFUejw1267MI+Yxr78fpHHp3h+0nhtI
 vV9w+hlXhKr3TKs10DoadvkBg59Bs1Y28lg3rYaIOt7D3MmW9HazMoBpF0RctWmk8qXv
 M5OOnqS1lp06Z3KEG4od3sWuNpiS7OcBTR8fJKYKbK6xiYCXs+VXPiMgPM5QzEcgRj1q
 PxaQ==
X-Gm-Message-State: AOAM533nlOIr6wL7vXYGjtu9hQfFQmsOc/ZKmXE9bz1E10gsDqur54pv
 F7HbQpB/N5b7RLnmnl/Vn6CTL2rMdj9A/KgI2Tw=
X-Google-Smtp-Source: ABdhPJxz1oTAvN7uNtBnAFTA8G351Kt1Cbp0lS8jyD+HmgzbfB0j4DXb57PaVqwXtrd4Q8j9afxm1YeIytbWlN/63Bk=
X-Received: by 2002:aa7:939b:0:b029:310:a1b0:5d8f with SMTP id
 t27-20020aa7939b0000b0290310a1b05d8fmr15665010pfe.50.1625497842647; Mon, 05
 Jul 2021 08:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210629124743.6898-1-pkushwaha@marvell.com>
 <20210629124743.6898-4-pkushwaha@marvell.com>
 <20210701133501.GC18548@lst.de>
In-Reply-To: <20210701133501.GC18548@lst.de>
From: Shai Malin <malin1024@gmail.com>
Date: Mon, 5 Jul 2021 18:10:31 +0300
Message-ID: <CAKKgK4w2UHRRUk5S0qSZJnbjwGRQnBorWjED8yWRmJcqsBX3dg@mail.gmail.com>
Subject: Re: [PATCH v4 03/20] nvme-fabrics: Expose nvmf_check_required_opts()
 globally
To: Christoph Hellwig <hch@lst.de>
Cc: Prabhakar Kushwaha <pkushwaha@marvell.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, axboe@fb.com, Keith Busch <kbusch@kernel.org>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Shai Malin <smalin@marvell.com>, 
 Ariel Elior <aelior@marvell.com>, Michal Kalderon <mkalderon@marvell.com>,
 okulkarni@marvell.com, prabhakar.pkin@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_081043_567361_643FE0BD 
X-CRM114-Status: UNSURE (   9.90  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 1 Jul 2021 at 16:35, Christoph Hellwig <hch@lst.de> wrote:
> This and the previous patch are pretty much two sides of the same coin
> and belong together.  But without the registration indirection they
> wouldn't even be needed.

Sure.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
