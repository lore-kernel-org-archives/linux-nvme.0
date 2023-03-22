Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9637BC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 13:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6bcMdqrDTpV7GQZYoqohGEjM2vNgmi5vHWqlOFfnZpI=; b=c+xn/zt9VSrLiAmv5hLJEP89aJ
	X+5uwQU6BMjPozHW6P8H0aLHoPZ3dxdQz/DXC/Xk3vy9X5UCKw1MDfgrTPxCEPFC94tV0NC1kAj4z
	m92ujqRXWkabPs3IGwqYzdg4npB7zPY6I470FeqDSnTqN7n/7+Igw+9DPzU65BJODnVD1kVlVuDUE
	LV2vju9BJoQompLJaHc1JDDI/0FpnUeb79cH1WOCwGApNfE6tQFeXU2tPsY33uufNreR0ls1lUJPe
	h3faf4M1GOTax3Mm+Fm1xfw6OMq78A+No0AJezcuNNe/Jb7hqM5XawQCPlmiv+XvXmAz5l/40H0F3
	ahtvYURw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peyrH-00GBAH-2d;
	Wed, 22 Mar 2023 13:50:31 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peyrB-00GB4J-0j
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 13:50:30 +0000
Received: by mail-qt1-x82b.google.com with SMTP id c10so11396020qtj.10
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679493023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bcMdqrDTpV7GQZYoqohGEjM2vNgmi5vHWqlOFfnZpI=;
        b=dfhl2VGKLqCwhC0ttLb8Wuc1TfP3XEfsEx4DS4tWjMKzEdsef0/40Iw20bzsxUTGoB
         Uc377nAaWbzkSFLwcS75f56Xgay32nTjcFyNoN86htj7htsF9hh22OWb8pqnBbaN3416
         Y5vrMmVM+mlmzrFnbocrqzxmixjmIJZHdMAk+Fbji1YrkYBoy35TWvLW+I1Vn3yz2b7L
         dP2lS1YHH7q1KvOdKYQPst09wXNV9sshjO3o04g/MY7+KJYQ3OrsW6A++P7luorGWvOc
         6atugU3tCj3swuVpwOo6hIec1r2DFWLuxmsr/lKgP0NYpc4RzxqdVogq9C+1Ik2/wtu2
         iWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bcMdqrDTpV7GQZYoqohGEjM2vNgmi5vHWqlOFfnZpI=;
        b=EjT34XtItgwcBeQouVj7+BKakctBQ6Ajx6Bj8mZFzby0/6Ui0VIr3u+uDtdBcSiE/k
         fo5WOopoL8uHce2hwdUp6A3B82ELx2rOKq6SnwBg0cYLD0+uYh3SJuW61+Mu3bFsORXc
         u+fuE001R4OoalXu8xomNinSEO3VYfCvP0clpzvN5hBKXnTpeADUCY1LHXwQDK3HMZKH
         5c3aoeBYWY3iHYnI0Um6CxOPnM9qgwUOrQyfmo8B04cln6S3XQHHuGTDtVwms9j14+N7
         5grUhBRABpfj2jYxRdQe8k6qk5GITvwVyKqArP2nEgoSsrM4f2FaaPvaMZN1UG8wMpJd
         F24w==
X-Gm-Message-State: AO0yUKUHAnoHP4aQJff70Uc1jqEXLSNcsU1TGCekiuBMJYYIKKekap8c
	yHY88VNM6DWKTXJ+0mjHFEDq9w==
X-Google-Smtp-Source: AK7set9HaqgA+mB5FLvP7fffXukwDbftHJGzBXepOVRzCPehSGRFi7DTK75viPzlJj+TGqowV41iBg==
X-Received: by 2002:a05:622a:1744:b0:3b8:6788:bf25 with SMTP id l4-20020a05622a174400b003b86788bf25mr6466186qtk.23.1679493023634;
        Wed, 22 Mar 2023 06:50:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id d140-20020a376892000000b007467a4d8691sm7488138qkc.47.2023.03.22.06.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:50:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1peyr8-000nYT-Gw;
	Wed, 22 Mar 2023 10:50:22 -0300
Date: Wed, 22 Mar 2023 10:50:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Message-ID: <ZBsHnq6FlpO0p10A@ziepe.ca>
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
 <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_065025_261673_65C811AB 
X-CRM114-Status: GOOD (  13.81  )
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

On Wed, Mar 22, 2023 at 03:00:08PM +0200, Sagi Grimberg wrote:
> 
> > > No rdma device exposes its irq vectors affinity today. So the only
> > > mapping that we have left, is the default blk_mq_map_queues, which
> > > we fallback to anyways. Also fixup the only consumer of this helper
> > > (nvme-rdma).
> > 
> > This was the only caller of ib_get_vector_affinity() so please delete
> > op get_vector_affinity and ib_get_vector_affinity() from verbs as well
> 
> Yep, no problem.
> 
> Given that nvme-rdma was the only consumer, do you prefer this goes from
> the nvme tree?

Sure, it is probably fine

Jason

