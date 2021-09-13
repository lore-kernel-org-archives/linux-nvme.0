Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB09FC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 17:06:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FB36108B
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 17:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3FB36108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RdMDTfKtlKoJp/NFsh7lU52hQn32n8llZ8i6AKoiqXA=; b=rhUCCv1ACgiDCh
	hWZCFyXjaam3zli4DPHExLhu9ugnUE1puTWEq0W6e/R2nCUk7Tg9DN26huDnmENdKL0c3I1ijQhzS
	cqmGDYM/ZL+mrnDdessvgjr2skJCphMj14EMVz9P/eoWUEO0QFxB9AAyXVczHpjFPojcayO5Movq+
	AghNeMfZgd6G1BAS+RtyChsijcAqD50Zc3VT8CJvOpuA92chk6s8fOd0ocvKcIzO7+5vtzpNVJtpb
	JUTjf1DtQo2U9oNTYDxvYBginQyMf7e+x9PMu+Iwkp+j2n/tu2PY21rL+x5LhC9esf+RuT156cWpz
	RVMOIROyDjlJ/FBsDwBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPpPR-002alE-KW; Mon, 13 Sep 2021 17:06:21 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPp6U-002Ucq-IB
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 16:46:47 +0000
Received: by mail-wm1-x332.google.com with SMTP id
 196-20020a1c04cd000000b002fa489ffe1fso7493174wme.4
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=IKGVZeP8M2ege/TNN5CM51TCUqtdD7LwnNiTrtYlgvs=;
 b=GzUb3YsanI/gGjRe5uyWSxqKsB+XUGNSN4Gka3EObJqg+/nf/keTFtmWnaX5bDACQ1
 uArdTSnVg1AdmjpMWI6XoTBy9nPN4+ullYo6b/FKofW9hoBdxm3i6mgaZOa8UHd58NRC
 IR0kIn6sFUVVSDPEUL8aT0dJJrsZMi1pwukuGP+snYEsHV03Gr7+KKlZBmw6b9/TozUF
 lU12sIqRTgJ+Eh9TAZkpPcQeBSBanFfTGH3SwcLwq0AMgpgEkuccVvAaefBfamZWt1Lf
 SyDFn2LvAgj+iXjiLjfacbj9e7QvVtrc3jahw+taZJmr0OhqcXDjRXYVhwZoF670557F
 CFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IKGVZeP8M2ege/TNN5CM51TCUqtdD7LwnNiTrtYlgvs=;
 b=1JxipAsf1QI79bCXmINqcxCzBMRm29HYapnK5vcpTHS3gGQOgMTOBtSfItIujAgt1B
 hSk06OX+QdK6ilVgrYo+4G9kNDT304w6jY7tN4AnnW09+okWdk4iGDoX2JrAY2WvRrFT
 h1Ib3YgimFRHdZwOK7bv6SrBralN4E2DAY9mdQfUjs3i4CbpjW6jkDDP3DWU3RQYwoay
 AR74S0V/PEPVN943P/4RBHKFYlu/aPxkqiYlVwypd5eVAqpgTGckT3iD/dSbCvhazohI
 qWQtf0WIf/ljTQj4lhvvnf+V26cy1pC+d3COvZTfzTs+M4wzRrpR2BtjZ8e5ZZiflINp
 6ZMw==
X-Gm-Message-State: AOAM532Yz+SOUyB4znMytQGkYMFvZOVoitZzuy4MvO2+lHgX43wHF5ka
 fmQ41bC9tlSTkeKQNfizw5xp5InbbFWxAA==
X-Google-Smtp-Source: ABdhPJzbRcAGAE5sFj+WZiIspFfx670luulvZzID0+qx9aLsD+g+8PojhpYpy6duQn86qX+tsOvszA==
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr12101146wmr.168.1631551604499; 
 Mon, 13 Sep 2021 09:46:44 -0700 (PDT)
Received: from anton-latitude (c-76-23-2-87.hsd1.ut.comcast.net. [76.23.2.87])
 by smtp.gmail.com with ESMTPSA id
 d8sm8445420wrv.20.2021.09.13.09.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 09:46:44 -0700 (PDT)
Date: Mon, 13 Sep 2021 10:46:40 -0600
From: Anton Eidelman <anton.eidelman@gmail.com>
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Subject: Re: [PATCH v2 3/3] nvme/multipath: fix stale ana state for
 namespaces just added by scan work
Message-ID: <20210913164640.GB74604@anton-latitude>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-4-anton@lightbitslabs.com>
 <20210913160756.GB3283786@dhcp-10-100-145-180.wdc.com>
 <20210913161104.GA7634@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913161104.GA7634@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_094646_674365_B5C6313A 
X-CRM114-Status: GOOD (  16.46  )
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

On Mon, Sep 13, 2021 at 06:11:04PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 13, 2021 at 09:07:56AM -0700, Keith Busch wrote:
> > I guess this works for the structures we have in place, but I think we
> > should replace the sorted list and with xarray. Then you can get
> > something simpler to follow like:
> 
> I guess that's fine for the short term.  It mean we'll have to walk
> the list for every namespace in the decriptor, but I've not actually
> seen deployments with crazy numbers of namespaces yet.

This is definitely a short term solution that does not require
us to change the data structures or address sorting at the end of scan_work.

I believe the impact of re-scanning desc->nsids will be minimal because
- It only happens when ana_work catches the namespaces list in a
  transient state with a few new namespaces appended
- The number of desc->nsids (one ANA group) should be much smaller
  than the total number of namespaces.

Thanks,
Anton

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
