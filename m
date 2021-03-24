Return-Path: <SRS0=XXBd=IW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB3AC433C1
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Mar 2021 17:22:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF00619FC
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Mar 2021 17:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF00619FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O31oZvQFQ97EcDh7SQfAK0nsckkOnQ9tz6/7VwvVlns=; b=puPVreU5mlxmlrBcOBfDNUfjs
	JfqpwuDiQp30BrXXZawAJi6i5xlVPrNCflRf4WcUwXlDPZtYJ0hsoRVaQvk8/N9x1jpfr9WJ3IISV
	AACYjo4l1FNm5NAlPX6IEWw0VGjMlJk/GQnzlnbgxxoiOq0BnLI2UeKJOkp/Bgw6J/WrpgBcxMf96
	0ATZp8QG6GpuEkKZqJ/qYFLeQxRxBnM1YDzUx791n0vJHjOnDOMH3HOJGEb6ejbFmqQUunQuFduyH
	hjjGVd9UxHT0weW7piYAcZvUk28Bq9B/6xnWXoYkIOQyVhd91/+dSdS0mC63Vx7kVOpyUYchT00mQ
	O2zmp28Bg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lP7Cp-00HVYX-Me; Wed, 24 Mar 2021 17:22:07 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lP7Ck-00HVX9-1E
 for linux-nvme@lists.infradead.org; Wed, 24 Mar 2021 17:22:04 +0000
Received: by mail-qt1-x82e.google.com with SMTP id j7so18123504qtx.5
 for <linux-nvme@lists.infradead.org>; Wed, 24 Mar 2021 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SrdP9ZidSNfCaSucoColh3TxPDb0AtWOwMrzkk0oHMo=;
 b=VqmHlOv5pk7Z6wF8FHX+TfDJjfjh921rYi4eN41NcDt/fq0DBDJOU7rhGSKU6ufyTm
 xgryyJiAucS8WZzz2ViVbQUPuCpXfg7uEEhpPzzprqcXGMGkBwD6G1BUvjJVBTwjUNRd
 pCXxJXPAOu8fNVQE1dmK+28ONbnNOcRwtDtStbIduQNJhqkB9Esrou8G0LfcvJrhW4fe
 ULycH1dWEtxvx55GhkyZoQPGnapSxw7VUycFCKDpkG8+3sa5snIG53zjQV6wfo7BiGMJ
 HJ9PrsuAPOJka52Tqjh77gZ/r2aV/d7R2K1zypTuv24H1EMPdKj6/CNzp7+bL0NdEvhW
 NVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SrdP9ZidSNfCaSucoColh3TxPDb0AtWOwMrzkk0oHMo=;
 b=EutjfQkvAPs/Si/qOt1uh3LQucqfNGWy3EQQYqi7stwG5/DRD7lTf4SDEjcfcftnlk
 ES/RGM4HzLHnd94dx9lLKHlDpn6V+wq9OdjyjTTJ89lQT1VowNRDJxKdUb5Iq+BLoY6G
 D226GWABXaln4xED6ZHGr0goLnPycIUOnUxVgvsg94/dYRMum40nEdkQ5Wrcu0Kwm4Lv
 /BR/AWjAvk/tZY74AfTHocCviyl/FQobEDoJgXTsUC4lS7FrZ/IL/l8EcUZvqxoX4gSb
 c+k74v0sU+NXnVIVb0KqaPKzK2yx0yMK/EYWqX8y1nvhkRUDOAaWJa4HUssPwov7FIc/
 66FA==
X-Gm-Message-State: AOAM532HZ6zxUrCB20uiiqqxiwwKbz3ZgjHzHCytQktbNOyZg1Hpv8cB
 ZAPv5tDAAbVCTeHizDkmhVzOAQ==
X-Google-Smtp-Source: ABdhPJyneQA4gaMEWYTu19JnLqKtUSbn29vkpMblQHBkTJsjZw2ELWdLSZfb1xoPTIiUK6qAC7wT3Q==
X-Received: by 2002:ac8:4d02:: with SMTP id w2mr3864955qtv.126.1616606519694; 
 Wed, 24 Mar 2021 10:21:59 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id q125sm2144133qkf.68.2021.03.24.10.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Mar 2021 10:21:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lP7Cf-0025Yq-Vy; Wed, 24 Mar 2021 14:21:58 -0300
Date: Wed, 24 Mar 2021 14:21:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Ira Weiny <iweiny@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 04/11] PCI/P2PDMA: Introduce
 pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
Message-ID: <20210324172157.GH2710221@ziepe.ca>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-5-logang@deltatee.com>
 <20210313013856.GA3402637@iweiny-DESK2.sc.intel.com>
 <7509243d-b605-953b-6941-72876a60d527@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7509243d-b605-953b-6941-72876a60d527@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210324_172202_742569_B188B60F 
X-CRM114-Status: GOOD (  12.89  )
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

On Mon, Mar 15, 2021 at 10:27:08AM -0600, Logan Gunthorpe wrote:

> In this case the WARN_ON is just to guard against misuse of the
> function. It should never happen unless a developer changes the code in
> a way that is incorrect. So I think that's the correct use of WARN_ON.
> Though I might change it to WARN and return, that seems safer.

Right, WARN_ON and return is the right pattern for an assertion that
must never happen:

  if (WARN_ON(foo))
      return -1

Linus wants assertions like this to be able to recover. People runing
the 'panic on warn' mode want the kernel to stop if it detects an
internal malfunction.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
