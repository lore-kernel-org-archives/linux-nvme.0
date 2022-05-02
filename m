Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC31DC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  2 May 2022 20:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4vFcTp0vFu7L25etk2ZSKAiN6qOQ/9fmDly29SPkq5c=; b=aPVhAHBrh+dPSH6qRAcFW7+vq4
	BII4vi8CsVV+BWiyVn6KgDXqnyJzR/O/2C11vG5AZ0mDqQ8PnA7pHJhoQQW1Fr/NBtzWss8k/d/2A
	ekHBGOlOLS81FW/akZz9eTwu1VihNqsJisBVrS0mHFEQGzvF8ucsxTv1ToHcvdfGXjHZJkK44BrEQ
	c0h0p7SGWkvKo/YFTXRd2kEPcufHzn1aTsrK9L0/s8i35XucUlMxLXYbfM8AIMK0sQMCAJYNzRNRB
	i/Pte4vh4gDe0q8qPCX+gNZVpAa0HJfeee4tmulImLUA9auI1W+ZvntSuXXjVBNDg6+703oHEzxbh
	Zc2PTpFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlcyk-002hDg-Gl; Mon, 02 May 2022 20:49:10 +0000
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlcyd-002hBT-Gm
 for linux-nvme@lists.infradead.org; Mon, 02 May 2022 20:49:09 +0000
Received: by mail-ot1-x329.google.com with SMTP id
 k25-20020a056830169900b00605f215e55dso7136724otr.13
 for <linux-nvme@lists.infradead.org>; Mon, 02 May 2022 13:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=4vFcTp0vFu7L25etk2ZSKAiN6qOQ/9fmDly29SPkq5c=;
 b=WAv1upXnenVsNjDN8G1GfvUP41AprjYax9793cG2l0l/8gk/bcGSGrW6TmTrXYwJkT
 uyrIFxqxonpGfEttbOSiy27ZpmmFr+xuZZcuFa8oaCQ4hV1X3wiWlZq99A5VYK9efytr
 V03WaQiITza8XQ3j4bAGpJOs0Aujp/ZpNKgOC/7gSFvk5eH1RGrUMWAR1R14MnyTTU+u
 0ea3ib0+0UVEPz2OoKZftMCeW6nOmHv0hLgD5VY16CUpOds2uGadLlylMAVhTy1bt+Y2
 rt+yzWFnQ7heag38DPm8WSs+1AhyQyfPqcy2f9SueiccWevzF4IMKvYVUqZtngPZGYbt
 Rx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4vFcTp0vFu7L25etk2ZSKAiN6qOQ/9fmDly29SPkq5c=;
 b=nMKedenlUgMBZUu7KVwyZWOoxUD0jwTWQsvGlnA2G95bEUFVfEltWOYbKY8mstDWpI
 d/+lnF/D/4yIPICLHMGzXMKffxatsWPoxMxO0mxOppr0QEmMHHvvC9WcoUQosuX9C0e5
 gxRnm9Fubvor3ramNQAsdfv/wWZarSGzAOZo8uwMXn3wMQetz8RDKVhKEraScUI1bFcK
 vduNEnfahxCc5MHI24ySrZl7IOIh+3+c7AugN1VtMpkHuWaThTH1mr+KBlnd14OJ+KYS
 EBG78A9g0iw/QWBStz9xAzrNcLh6xMW+ZjJBfAE8PISyjq6PwFLaREaKTZC8E5PYRNn1
 WHKg==
X-Gm-Message-State: AOAM530gU13G6/icx8AsSUt+KdLfCjMX2zo2Hy5ZxfeVV6vCgIboxSqW
 N1O/Uu27qexJhv88/0vn8MV1rA==
X-Google-Smtp-Source: ABdhPJy68EQKziCbbVWvDyvqmfyIqovw7jyP2Lx8dYgaTFAZeelMxmdN+jaVcHYYsFwK5S7y1yS7hw==
X-Received: by 2002:a05:6830:4114:b0:606:ea9:394c with SMTP id
 w20-20020a056830411400b006060ea9394cmr3387727ott.68.1651524540901; 
 Mon, 02 May 2022 13:49:00 -0700 (PDT)
Received: from relinquished.localdomain ([8.34.116.185])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a4add8b000000b0035eb4e5a6ccsm4250306oov.34.2022.05.02.13.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 May 2022 13:49:00 -0700 (PDT)
Date: Mon, 2 May 2022 13:48:58 -0700
From: Omar Sandoval <osandov@osandov.com>
To: John Meneghini <jmeneghi@redhat.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ewan Milne <emilne@redhat.com>, Chris Leech <cleech@redhat.com>,
 James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 "Knight, Frederick" <frederick.knight@netapp.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Kanchan Joshi <joshi.k@samsung.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: LSF/MM: IO Track Topics
Message-ID: <YnBDul1cxKvHudRj@relinquished.localdomain>
References: <d43a7624-0e9a-4cd9-05b5-caf3b8ea3065@redhat.com>
 <0d76d989-7f38-9235-14ee-c9cdca693692@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d76d989-7f38-9235-14ee-c9cdca693692@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220502_134903_824553_73F93824 
X-CRM114-Status: GOOD (  20.80  )
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

On Mon, May 02, 2022 at 12:47:47PM -0400, John Meneghini wrote:
> [re-directing this to the linux-nvme mailing list]
> 
> Since we have no lsf/mailman list this year please add people to the cc list of this email.
> 
> One topic I'd like to discuss which I don't see on the IO Track agenda this
> year is NVMe-oF Discovery Services. I'd like to understand what Linux wants
> to do with all of the Discovery related TPs that are coming out of
> NVMexpress.org right now.
> 
> TP-8010 - Centralized Discovery Controller
> TP-8009 - mDNS Discovery
> TP-8013 - Unique Dsicovery NQN
> TP-8014 - Discovery Controller
> 
> When we combine all of these with the security TPs (TP-8006 In Band
> Authenticate and TP-8011 TLS 1.3 Profile) we start to see proposals like the
> attached picture.
> 
> There are additional NVMe-oF proposals coming from FMDS which will impact
> Discovery and there is even a proposal at IETF for a new project for a
> Distributed NVMe-oF Discovery Server.
> 
> https://www.ietf.org/id/draft-nof-requirement-00.html
> https://www.ietf.org/id/draft-nof-framework-00.html
> 
> IMHO NVMe-oF Discovery is turning into a giant mess. I'd like to talk about
> this at LSF/MM and understand how Linux plans to support the increasingly
> complex and convoluted landscape of NVMe-oF discovery; especially at it
> relates to multi-vendor and multi-fabric environments that support NVMe/TCP.
> 
> See my comments about this at:
> 
> http://lists.infradead.org/pipermail/linux-nvme/2022-March/030847.html
> 
> /John

John, does the 1PM slot tomorrow work for you for this topic?

