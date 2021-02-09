Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB3AC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 19:50:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B51664E7D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 19:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B51664E7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+vDAr5T10F5e+p0nyHfgrNHg16zaE0PB0k83FD1ReOc=; b=pnnRplEKU6uUqj5BaCEIa4Rfv
	uIoLM1YXXdGMIMXEwhAK1PpyIIBcOSzfmBXOXE0cFlBt3tp2hwHeLHE2yMERY/wOCRoN5tYhNhNfC
	Alz6FSQHUd8EjLelqbEPpCL4aoQj4wB8auS7E+vPnXIvsehp8k2tCUMe1SrwjcMdBBSMBUA8YWZyR
	V0FJORQIRW64X5bQRFA0HDUBgcHl++vB1VpCDjYoj/DxRxiJERKe3TP8TJHtrpxbL5ir1bCdGn6am
	VKVYKztesRQHefNzCMmiehVgAFUIuOykdFQC9WSWHo+JRnwV6/QCmVmkDcReQQxLrWtS178JVO0WY
	E69rT9+Rg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9Z1M-0000dZ-1B; Tue, 09 Feb 2021 19:50:00 +0000
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9Z1I-0000cc-Fp
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 19:49:57 +0000
Received: by mail-oi1-x235.google.com with SMTP id u66so18787169oig.9
 for <linux-nvme@lists.infradead.org>; Tue, 09 Feb 2021 11:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NgzDc0kNuzf06Hxn7V9rhAXM0YLGjx8dhHymSQgrgMs=;
 b=aPgHQWeq7S7g6zpwZuPZBdAo5mEaX4rgWJh9iYZ2UCHrAn39gG7xHt0q/lKZA/rqiz
 5D0Yj7lylUSXrB1XOd8QVvSNbqxQ8juLaFCTu+fpB9Kg/geLi/8uyw7IQ3kWQ9MJkM6w
 nnP88CS+S+4LapOkgAdBPMKLnvgKgcgEPNIT821Xu+/ZA75ojQNsUeoR1RzljXoPIOBi
 CLyTPbHyRCQpYAHpxfCaSjd/ZDhEJ3wRjtqzdpeGp4pBdkWAc3eXHqkpPXzIS4F4QS0X
 FNLcskTJEhoykYh7ytma7/rRQZKDCdawh4Lt7GY8f1QGJwfE2/4079zYjITFPVKLA/33
 lgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NgzDc0kNuzf06Hxn7V9rhAXM0YLGjx8dhHymSQgrgMs=;
 b=GF+/gWRkhr17aXGpx21o553FdLabpL+/ARXU0oGRpqylvOa0dHtYLrc9QSUA2WoRqH
 z2UJzY4PJlrnx+L5S1z/V9R2nfXWCj9Zxfj/Sf71UHT5GZvXAY2Tq3ffv5UJx6gGmtjU
 wZ9DFVy7WLDjkEowSoUTyEEKOeOJTgdSFP4+TlwiF08k04TssWEusct0eSWJYnAvlgFp
 bxae3BLdn9lZW3SrFLpNuTwL/tf6xCmvK+P/yWMdjB9/q7vZlph7AlqCVKloiM1Y5Gw3
 DhDqtrLL7oCYldnt6kQW5Z3VTdWK4KOZieKF5xHOb3C9aJ5UZ3RepK/s3peiK+0AwaQL
 T9Rw==
X-Gm-Message-State: AOAM531v93jVLc5VGtrJpPCIx6VyHKiWW0hFzqemUx7Omhw4Z4+0bCoS
 1aWRXkZhFYxqnqE2zb4K8R4Lo3aePaptLP2cjy5bJg==
X-Google-Smtp-Source: ABdhPJwpfdKffypmc946sN/rrdalCnQadGovpvCLJqk+wgm0R4o6oZTVVk3Vi/zVpQlVPUpdAnbJB/5+oJLRSk6Kfj8=
X-Received: by 2002:a05:6808:21a:: with SMTP id
 l26mr3500947oie.42.1612900192109; 
 Tue, 09 Feb 2021 11:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20210207160327.2955490-1-hch@lst.de>
 <20210209084156.GA32320@lst.de>
In-Reply-To: <20210209084156.GA32320@lst.de>
From: Jianxiong Gao <jxgao@google.com>
Date: Tue, 9 Feb 2021 11:49:40 -0800
Message-ID: <CAMGD6P2QiQba=49LMOsQNZ=U9+hmAjxYLwroZGAG_AXoatUYpg@mail.gmail.com>
Subject: Re: preserve DMA offsets when using swiotlb v2
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_144956_565402_C4471E76 
X-CRM114-Status: UNSURE (   9.34  )
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
Cc: Saravana Kannan <saravanak@google.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Orr <marcorr@google.com>,
 gregkh@linuxfoundation.org, linux-nvme@lists.infradead.org,
 iommu@lists.linux-foundation.org, Keith Busch <kbusch@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Sorry for being a little pushy, any chance we could get this reviewed
> in time for the 5.12 merge window?
>
Tested and it looks good. Thanks for clearing it up!

Gao

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
