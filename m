Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F32CC433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 18:21:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D602611EE
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 18:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D602611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1z8lP/NEjU4fm6psM5GDF5rf65OBu/6+ut9Op/SZKqw=; b=RRI7uRVUTZ5CCNSEOJnXibTGn
	hoQMB2AOitjudHTTi1x1XAyWjBZYqCz9iXc/fz9rj9prnXI5wP8iDD+nlWv67JIlVDAjM/LonzkwU
	90vpxL1GIP05flt0nxp+zuxSw9k04B2uXSjCyrxHNboAV2bwFstG2ojUoWAllAPYQFhmkMRVgw63L
	SOU/uFMm7fpTyToxoGsJQxK41K+ScUQ+PKUQwxjoGJj5goDX185xraKaIE3mMePx02VlQtiLuZfwX
	tJJSf1EHxO1jN1ParuhfeygSxYuGJvAuJdpbokdEuU7yXMfDv9tqPMs/eDCp3NNOWsajN1f+2yFdM
	8P1Ir4yLw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYYVy-00AQOi-Vn; Mon, 19 Apr 2021 18:20:55 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYYVx-00AQNo-60
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 18:20:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zXRcipxB0g/YkNP+zUJKHMJKNLy+Z2cSEPqRQaNlD0o=; b=Pm3R7hzyFkckGwGmMvwXlIRwgD
 OeF7JIEUVN2LRe4R1r8H4XrPLOA8RJV0AGgcZelBV34WDHf3gBe22NE8dhUEEtlhnVyKRRrDr+bjp
 5yN9oLEhVsEJCcu8utf6lF7pEfhN4JtjtqfIIIDXPkjarycEKd63EsKPG2UkcR0al7jwWuRp/PtmT
 L0Zn9Kmhc9l6KckRrULA5OwXJKMB8ZRc6kOQ7ICSiehaaiXUem29k6B+6nBMWvi2w1LROYv66+tup
 ZVwV/zsStg8fAoj+wkR4CmenUtrE+778Zppg5/0gpTmzthtIzaFjnqfme2WOCzEGsO2v8nwEi+pd9
 yucmS3Zg==;
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYYVu-00BaPY-6l
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 18:20:51 +0000
Received: by mail-ot1-x331.google.com with SMTP id
 f75-20020a9d03d10000b0290280def9ab76so28351963otf.12
 for <linux-nvme@lists.infradead.org>; Mon, 19 Apr 2021 11:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zXRcipxB0g/YkNP+zUJKHMJKNLy+Z2cSEPqRQaNlD0o=;
 b=WX2T8vXeEesLKvdJysC3KPGA0tjCwe1DMYOc+PqlJBBN3O+pqldLvIuATn4UIegM0/
 nXqj6b5v+WkM622NPydhWJ0RfVKxFta+RZm+L+tseRtTLLXmrzX1p3LdGkLmpo3qW9BR
 0RLs8QcgFoVE1FcfPjid/R+fI+7WDZtSn0s7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zXRcipxB0g/YkNP+zUJKHMJKNLy+Z2cSEPqRQaNlD0o=;
 b=fK9bA1NqUazTx04UuB5fcbdGN12WXyvUWvAVUR8eIRSdQztHXXV6+9flRTMPGsX7Ho
 /nglTKuU5awchmikyqiaq9bE3U0itvH4LLtBe3shT2MouuxIZpArYhpfVYkFrmXkNlyl
 YRR1VMOpCptoz6nK0wrc7jztYkaucPzc8wSaA5Qk8QHLZvWu2EXsKTRmBV++KzeW3Bcx
 3apOC0gFUf8be++FMqps6pwtokYs0Iy3dcSgQuG6ps8UEQulA7iRIA3LRo2fmk+vMJyh
 thgFMiR3+0NYce2bzjcUnVe1JjSbS+lZ+bzzAcfAPcgiPGp8GGsBae4BemQN1t6X1rzz
 16JA==
X-Gm-Message-State: AOAM532Qsy4QjtMUFawVVfC88pS7PkIU+26qkaUu7zLn1ZUUU4s4kIlp
 tW5dW8OYOnRkXz4tzUqZsdz21ulZK1iQzUFyYGFrJfpj9lc=
X-Google-Smtp-Source: ABdhPJyRvI19wiTwpBH09wdf8iIumYNu5PFfQCGk4jAyQyZoJ9fpX/fhd4owoBzG8SbHmVU2e34zWBY//YIdNnHKvvw=
X-Received: by 2002:a9d:7a53:: with SMTP id z19mr15247923otm.40.1618856449368; 
 Mon, 19 Apr 2021 11:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210416165353.3088547-1-kbusch@kernel.org>
 <20210416165353.3088547-2-kbusch@kernel.org>
 <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com>
 <20210416171735.GA32082@redsun51.ssa.fujisawa.hgst.com>
 <20210419071605.GA19658@lst.de>
 <20210419151437.GA12999@redsun51.ssa.fujisawa.hgst.com>
 <CA+AMecFXLCm3zsrfGdjT5hW4fvvgDxJxGEZvxOEA0bJT3X11wg@mail.gmail.com>
 <20210419174800.GA3130441@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210419174800.GA3130441@dhcp-10-100-145-180.wdc.com>
From: Yuanyuan Zhong <yzhong@purestorage.com>
Date: Mon, 19 Apr 2021 11:20:39 -0700
Message-ID: <CA+AMecF6CODiR3sze-PAjhJ37YsjEGzM4CdKSBHxVUCMi=KwvA@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, axboe@kernel.dk, linux-block@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_112050_354164_824ACC98 
X-CRM114-Status: GOOD (  11.60  )
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

On Mon, Apr 19, 2021 at 10:48 AM Keith Busch <kbusch@kernel.org> wrote:
>

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b57157106cac..a0fb9ad132af 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -949,6 +949,9 @@ static void nvme_end_sync_rq(struct request *rq, blk_status_t error)
>         struct completion *waiting = rq->end_io_data;
>
>         rq->end_io_data = NULL;
> +       if (error && !nvme_req(rq)->status)
Is setting nvme_req(rq)->status for each error return in ->queue_rq()
going to gradually roll out, and eventually skipping the fallback here?

> +               nvme_req(rq)->status = blk_status_to_errno(error);
Casting int negative errno to u16 will get 0xfff., meaning NVME_SC_DNR is set.
Is that always right?

--
Regards,
Yuanyuan Zhong

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
