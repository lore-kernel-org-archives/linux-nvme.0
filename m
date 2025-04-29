Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF1EC369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 12:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fspc3DFcSox1gyyee1r9hEoJNZDYkCPhN2qCzyuWCLE=; b=rCFvf8a1J21Ipf2SzoZDFGdmZG
	E3gr3ADyGNL1i/uk72HkS76RyQMibwZZDuLGZVS2oAtZOXAkGqJ5fjNpMUhO618yciPgyavOnSVsy
	Nj3gFnvRoQoVMO9DcpHvM8r362NrPFc5ruS6s/uQYsyExHy+b55GNO0bak4cw2hGRbHm0eLbx1iOk
	RKRldFmjL27nF51iOX4mp2Qe9qin6sznuCkiDpvBA0asJCl3w0lBKVc4R1hhoTkWhQ5fYczk7WtEY
	NXFbXpKtHF1okDTJTm23TP3yOaSMflsy8i+mLEwY11HZDSXN95JaW4OJcU/XX1sSHWj1R/j7BCSpM
	vgCOsxDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9k6k-00000009ebQ-0jGe;
	Tue, 29 Apr 2025 12:30:42 +0000
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9k62-00000009eS6-2kGQ
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 12:29:59 +0000
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6f2b04a6169so65724546d6.1
        for <linux-nvme@lists.infradead.org>; Tue, 29 Apr 2025 05:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745929797; x=1746534597; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fspc3DFcSox1gyyee1r9hEoJNZDYkCPhN2qCzyuWCLE=;
        b=DmS2Ay1jpmAjNlcKMjFx45pM1ZPa66vy4fppfc5ZpxjE5G1GDZPENUP4rX4XBo9wa2
         r/9UEgSczG2JWynrZAPci5XlIxx0T1/KEFr5+YFHh4T54+IiL3YpC9kOFToKo4qGFmBB
         Miag9nY2W4Z0Xs8JWINVFRXGWwE8lop9iLjU1/hcvTeFqSgCTuxCFdf5bu7XwJz1oZtG
         kR1HvaunBGusFhzXSJ1RotD6sZFnXNa+eHQ+xurbH13qwoeQCdoznoaj572jVgEO0qEl
         dDsFrEfrqhhOegsV7GII0P+YXNVRb9f5r/Oo5tB+nmp9Ssa39g+3TipQOhHaJnvufzpY
         LjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745929797; x=1746534597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fspc3DFcSox1gyyee1r9hEoJNZDYkCPhN2qCzyuWCLE=;
        b=I8LsPHHaOPLWj5GSQNeeIlmlJHUDs8CSdaN2iXCRj1S1/H7NUSOhLazuLE99ntkzWZ
         Bh0mNPlBHMrt1/xdDnYOwFz1VMX5eNgC3QJUuEp+EapDdTr+EvX9iNRpcoji7vNlNwPC
         ozbHtY3NFSdZvS+YufkJc4VCYLBQMELXXIklrCM5XK3+0/zMmXDbG4enui9878/SDZYI
         vjz+xeBZDdvQeFlzrlP6L2HF+omb6/Disps7kS/FNS3PdGS4JFXIeYLA7Spr1TBENZMM
         bOS0fLSIq3HlTazGSBKt96onPpHRL4p/uGVa1908R4u6otxuu/+149w4bFxLPKO8TmUs
         XyEA==
X-Forwarded-Encrypted: i=1; AJvYcCWNqqShVdrDaSxm1Yg8TVAIwutpA0AA5xwkdzoO8UZ8rZotnArAVlE46P23iBXI2OBUGDaSqFPod/zL@lists.infradead.org
X-Gm-Message-State: AOJu0YxoXJWRGktaC7q/OT2NFBI27+nwL88FrFjBDSBo8ptsWPiiapUP
	6buggX6vC1g73oo08kA0l/u/vuurVGO2TkE7j1T1cHB9is7zHsi6v7lQVTUMz8o=
X-Gm-Gg: ASbGncs+y9PLQlNb9HKIx8Z/3+3KwCSx3FEDWuSzUAaU1+fyDK8o+j+au2hz/CN2/Ir
	8uOdCjc9HZm5zIKOV8HY4ez/i2ckYtMdEtPyva7q+2JojscHQPaTQ3JAbYD0Bb75tKUIgAL2lFh
	scEFNO6F5c7q46h2IHg187Zfbyr3o50wOtPFlpy4dzbfpb//z8SqldNm2MMKkUa4YC+AvgTxY21
	S7xytyzSK49LgpVQMKKm/nnGt3WZ5lHcfXrZ2bdVnBo0isnO0dpjY6Cq88cfMwaqlJfMhjYjdF3
	J+BvMOKwt31Y6MqzFH8WlnKusdPDz4g/Me+Go1qoOzLDplUHYyzHXFzY20Gb7eRvkPcos4cDdJv
	upWRuzkaGFeq3DNYARIg=
X-Google-Smtp-Source: AGHT+IEgx9EB53XUdGV7vC29k/JxBvqJ89luumOzPRGbpdqAFnmUSowtG6tg8X/s0U1VWu7lyHl1sQ==
X-Received: by 2002:a05:6214:d6d:b0:6f2:d45c:4a1d with SMTP id 6a1803df08f44-6f4d1f9d772mr228245476d6.38.1745929797482;
        Tue, 29 Apr 2025 05:29:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0aae68csm71890226d6.97.2025.04.29.05.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 05:29:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u9k60-0000000A4cD-1RSJ;
	Tue, 29 Apr 2025 09:29:56 -0300
Date: Tue, 29 Apr 2025 09:29:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: jane.chu@oracle.com
Cc: logane@deltatee.com, hch@lst.de, gregkh@linuxfoundation.org,
	willy@infradead.org, kch@nvidia.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: Report: Performance regression from ib_umem_get on zone device
 pages
Message-ID: <20250429122956.GB2260621@ziepe.ca>
References: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
 <20250423232828.GV1213339@ziepe.ca>
 <84867704-1b25-422a-8c56-6422a2ef50a9@oracle.com>
 <20250424120143.GX1213339@ziepe.ca>
 <bab1c156-ed5a-4c1d-8f0a-dd1e39e17c99@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bab1c156-ed5a-4c1d-8f0a-dd1e39e17c99@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_052958_693234_25E68AB7 
X-CRM114-Status: UNSURE (   8.78  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 28, 2025 at 12:11:40PM -0700, jane.chu@oracle.com wrote:

> 6.15-rc3 is orders of magnitude better.
> Agreed that device-dax's using folio are likely the heros. I've yet to check
> the code and bisect, maybe pin_user_page_fast() adds folios to page_list[]
> instead of 4K pages?

It does not.

I think a bisection would be interesting information

Jason

