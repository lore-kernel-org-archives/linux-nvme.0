Return-Path: <SRS0=THed=NL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B519C4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 11:12:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316A56103B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 11:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 316A56103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2W6FIH6kb/4V8+FGgpqK85bnj2AlPpddN+p/VFBT0ms=; b=AE6S78hG7Nicpt
	AjUV2yYb16rFo1HfG/GE7ihuTgK/q4pxhoXCgpf9exLe+504XjnwsD2P9rAe3IRAPEvet12878gr1
	52uiU+LEXgnEbVK43vIzju8zFFqI3EpL+dxRQc/q/Y0mv9FjJB2n5rNHYADf+Qa5aFBFp9vLlAba+
	VHu9AdyJVvWZ6tryRg5MWUjpj0AB+R1HzdPnx52V3z6zfk6Z5wi3wZTKj+lC2faEhSsFo49AadwDK
	MyWyrIFR4ng5jrn7Xv+sykuUqnwqfjK+eVuBy43asIx9ZuB5jSrwl/YyZu66WBgDfwC71J0F759NB
	3KD8io3P51MkEZarj+cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mH2R7-00AlU8-Vq; Fri, 20 Aug 2021 11:11:46 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mH2R5-00AlSz-9i
 for linux-nvme@lists.infradead.org; Fri, 20 Aug 2021 11:11:44 +0000
Received: by mail-wr1-x431.google.com with SMTP id n5so1343322wro.12
 for <linux-nvme@lists.infradead.org>; Fri, 20 Aug 2021 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XTV41ORucx8ryF7oB1eYwysBWiCN8gKMFeTRn1Zj7AM=;
 b=MYvcDMXR87iOi7JK63t8cj54EEq9i8ZzrMq9tTqiUnWhDTDpZ+z4a4GCYAjq653LTa
 I0zDS4sQg1eW6rUqQCv1JNBNE6zrArt6rTFvGCFeg0Dbin816j8YZy9tgx6PsYbcoTGo
 pRvXznFW67AYmCqrOL/h4QHkXw0BeMbcThfam8AJkm+2c4RjnYPossT/rYuEPniF4uUP
 lgU4P6t/RauHcpJ985qi72+0T/B06GHTCsAkiEiv0WJP3v8HUf+Y+HDJVlu8p0kLKiGO
 1NAaZJYEaqA0vmmOG6yNGc7LwnVlknJMuXwP7kGJLpVCuwHngy0M5vjxVKd3AAzIoPHD
 6J+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XTV41ORucx8ryF7oB1eYwysBWiCN8gKMFeTRn1Zj7AM=;
 b=hQ/wmMyl+GqxjitB+eUkqpZ4d9s/vtKdcbstfEZc/m2F8KjPIrNmKJAXZ8YIqjXxZH
 1aRMp+OEEmMDR7yWyBKTw7ejwrVYhgVehsIEcOrVHhv/qMjpf1JLSyIf1QEKnD36jCsy
 OIX2PEm62lXr5TNcFQ5DddA7CFuh+UZMVDKe7X5bypjNs/qmNeWyJt3RMfJLKGYXZmZ9
 QP/as46wz/krN+4UECRT7rE6w9qMXwi+TLmltpBxQvT726xwdaWGHc1wG6I1Wv1SBN71
 0Sj1xdNCvNIsSLhByOKEGSj8wY4MWVwHyPbCr5ft/qFvndpG0NPPTmkxpWPIFgj3iLqz
 JLHA==
X-Gm-Message-State: AOAM530uGeGFxC5+xj0soBeVgbCFRA5E+pd1AB3gPd4U4LdMHnSmcZEr
 Y4dzcWlMyh0X42TqLZqlBsn6VVV6N1ZqO0+aSYg=
X-Google-Smtp-Source: ABdhPJyHLBn4cAqZhoblha8bwzOCJdvxUWt4EpC0AJmYcZ2sxKZSuvBjXl3YiZg/qrMlyWLl4b6/2Ts3GXLe812W024=
X-Received: by 2002:a5d:6991:: with SMTP id g17mr9619476wru.253.1629457901314; 
 Fri, 20 Aug 2021 04:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
 <20210817101423.12367-4-selvakuma.s1@samsung.com>
 <yq1sfz6loh9.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1sfz6loh9.fsf@ca-mkp.ca.oracle.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 20 Aug 2021 16:41:15 +0530
Message-ID: <CA+1E3rKmS6LSPDb9C8S7Ap-b40TB9dfogC-PYm7ehLeBTn+Ukw@mail.gmail.com>
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: SelvaKumar S <selvakuma.s1@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, 
 Damien Le Moal <damien.lemoal@wdc.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <willy@infradead.org>, kch@kernel.org, mpatocka@redhat.com, 
 bvanassche@acm.org, djwong@kernel.org, snitzer@redhat.com, agk@redhat.com, 
 Selva Jove <selvajove@gmail.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 nitheshshetty@gmail.com, 
 KANCHAN JOSHI <joshi.k@samsung.com>, Javier Gonzalez <javier.gonz@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210820_041143_370157_2B8284E4 
X-CRM114-Status: GOOD (  20.75  )
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

On Thu, Aug 19, 2021 at 12:05 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> > Native copy offload is not supported for stacked devices.
>
> One of the main reasons that the historic attempts at supporting copy
> offload did not get merged was that the ubiquitous deployment scenario,
> stacked block devices, was not handled well.
>
> Pitfalls surrounding stacking has been brought up several times in
> response to your series. It is critically important that both kernel
> plumbing and user-facing interfaces are defined in a way that works for
> the most common use cases. This includes copying between block devices
> and handling block device stacking. Stacking being one of the most
> fundamental operating principles of the Linux block layer!
>
> Proposing a brand new interface that out of the gate is incompatible
> with both stacking and the copy offload capability widely implemented in
> shipping hardware makes little sense. While NVMe currently only supports
> copy operations inside a single namespace, it is surely only a matter of
> time before that restriction is lifted.
>
> Changing existing interfaces is painful, especially when these are
> exposed to userland. We obviously can't predict every field or feature
> that may be needed in the future. But we should at the very least build
> the infrastructure around what already exists. And that's where the
> proposed design falls short...
>
Certainly, on user-space interface. We've got few cracks to be filled
there, missing the future viability.
But on stacking, can that be additive. Could you please take a look at
the other response (comment from Bart) for the trade-offs.


-- 
Joshi

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
