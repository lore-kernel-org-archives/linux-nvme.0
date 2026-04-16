Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247CFF8E4A7
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 04:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4wHjoL5bgW6OaCvqxEnCcQc9CZYqGIAVWFc6AfVy0os=; b=agF1vK4jTnGcZPmGH3aACmnzYk
	Sl9wCexHWfq6jeNtzDcIVEMGcGqY1XG04/wQ77n7PPjW/+j29dPeP71/yfJ3++x72qIJ94Beu3Sf5
	3rWxjAgo1cCLenME0p4kW1++n17u+MPmWmfT56L2Lchf5+4lwy4CB0j/Cr/5GqjdZ788Tovg2uq6+
	tpBFRRNFn0KVSh3J6CPHcXfFW5bEQ2Uf2Nsi1Vzfvf17dLC5QStaFLSXbYXNHkCcFGETSa8OxXgEO
	XeAh+QOzSZEaRHPjMCYR8e8w2QKC2tR5+tXeUHrM8uAc1KPbkwSqheyjqYR7X+5ynHDFiHtpDaZha
	lu9lF6ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDb1m-00000003QY7-2lkk;
	Fri, 17 Apr 2026 04:42:02 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDAuY-00000001pFB-2zZK
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 00:48:52 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-43cfac48bc7so5156330f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 15 Apr 2026 17:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776300529; x=1776905329; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wHjoL5bgW6OaCvqxEnCcQc9CZYqGIAVWFc6AfVy0os=;
        b=ReyMua6/Ht6HpJMK8vmUTa4f4o7YVhwWT2p+U8/QpSZnvTVaIR2h32rEqdLJZERwIw
         oksQ5F1YhGpqAyuIdUHJzTYL8L8J+FENl+Y9uzNPBZrf8DOowNq8uU2Yw0we+xMalgo5
         2bUYJyTa1y1rQEwvCo02h0W+GSnoXTUvirFQl0K/JZD4osvBI80rkPjNStrTsUbOweGq
         rVFiwQlGFM6dj7Q58S3HxEYaMBgq4QTKLAJCB9z/J/xvBltA6DSEGeSzL8zYqMYrXMME
         e8zTyiwTTV2wSwpLYjMADdUnRbLyGVUo11/InzwDkTcghopnxKKlLVbJgi+wSN8LBo3q
         v/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776300529; x=1776905329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wHjoL5bgW6OaCvqxEnCcQc9CZYqGIAVWFc6AfVy0os=;
        b=Mp41q7DVeyZb+ipZJ0II2p2uh1chWya2IqN6XLtkIcQS6ORHF09CE7Ikq0duKtWJzD
         2bayE1eQlDwwtm0wL+/1OFo59ODV5dr6lPmLpiU0ImUveMSzf9WqsTgBn7HetUKQbxwt
         yfa13xGdwdlEGme+ANvtgD8Qee7TEbOQAZgz6BmmZ+aIKVJlmaMfFTZugqLgHOIStlNN
         44bTNLp048j8THl1PtoHYsKsIRR6BDGoAn5WDOHSQ2O9oTF575ODmXGbz5p4tBgejIh+
         m7B3ETv08ztVbaexLD8UlBCWGxpFA3LcfXbxAr/sWZs+DOuYlxH20+VIgU92VZbwy7Ze
         3ASA==
X-Forwarded-Encrypted: i=1; AFNElJ9sb5h0VPYdhHNqpxG2Gt0E/YVQ8llFS5MfCh12h14nHlemTyAV2rZthd9XVV+xZF+++lUrvKFWOdfO@lists.infradead.org
X-Gm-Message-State: AOJu0YyP8h6ZyHZruZMV3zUFQti8Zk6SC1Vr2/QLyUhayh6oNXKdLZZ4
	zghoxP0hxiJMcRjVocKb+vwzJL6nPXd77X6XBr4aALeAmCczsJnZk0Mg
X-Gm-Gg: AeBDietKZAv0AxFfgYQUJMMLMKE3V/aIj2UAyJT1HKzZ8gU99bTvWZiBlKEuqyp9bTw
	F9nd7EDZZifWUwnwyUuWM6KBt9z674eCWdLUDye6fixPfbXvVRg4YQOpbJVvK/GMArJrH8xLudF
	orvEx9+miEjs7gSoVahDLwWWZ0vCMGr+4vDsGWBjV8BcQQ+xR5ZKpOGYihQGNRSd18ggC8bV8Gk
	4Kq1yVWo/SRDO5EgMGinLaGwHud85N1GOB1ApyG4BJTsSh9DkyrwxFZas+Xko/AbPKgP7sBGuMR
	T/VSXE5A5lo/1IiL6vaufl8/emLGKDvdz6D6cw3LOxBqoOqaQimD2TR+hlEUP7Eo/lt4l6XlfEi
	f9pplnrKEVpmhM0Juv/kd5GWuyIECFhek0n94WoyTbPJF10ir5el4si057IaDo7BGXGjuPSjgiN
	zfgCNRo9ZOKRboGWA3EWYFL620q3fVcQPSXvr3MNnXbacCN+/80KQS
X-Received: by 2002:a05:6000:1a89:b0:43d:7b51:5178 with SMTP id ffacd0b85a97d-43d7b515250mr19740589f8f.5.1776300528339;
        Wed, 15 Apr 2026 17:48:48 -0700 (PDT)
Received: from fedora ([2001:250:3c1e:503:ffff:ffff:74aa:4903])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3dfff3sm8344319f8f.26.2026.04.15.17.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:48:47 -0700 (PDT)
Date: Thu, 16 Apr 2026 08:48:26 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org,
	frederic@kernel.org, longman@redhat.com, chenridong@huawei.com,
	hare@suse.de, kch@nvidia.com, steve@abita.co, sean@ashe.io,
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v10 13/13] docs: add io_queue flag to isolcpus
Message-ID: <aeAx2g-nJQO2yyS4@fedora>
References: <adMoon3Zf6gO-UbA@fedora>
 <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
 <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
 <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>
 <adhj_w11cpMfeEgN@fedora>
 <dzpxscrhibmi5okkozf5jfull4dcajgpctldvdyfcjgmpeetk5@tkeyqouyabzy>
 <adpD8M8cNu3IZzEL@fedora>
 <6glgsbk2djsz4cqtbp2ht4274dw4rveq6fojlnpnuvx6zmpjxw@i43jo2l4qlz4>
 <ad0Hk48y5JEeMlFk@fedora>
 <fouvg7qn7g4yah7jsvzkdmweesbp4aqmhx37gf3ow5medzvuyk@5n3ddkijosr6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fouvg7qn7g4yah7jsvzkdmweesbp4aqmhx37gf3ow5medzvuyk@5n3ddkijosr6>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_174850_802366_5CF23316 
X-CRM114-Status: GOOD (  14.50  )
X-Mailman-Approved-At: Thu, 16 Apr 2026 21:42:01 -0700
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

On Wed, Apr 15, 2026 at 10:56:37AM -0400, Aaron Tomlin wrote:
> On Mon, Apr 13, 2026 at 11:11:15PM +0800, Ming Lei wrote:
> > But typical applications aren't supposed to submit IOs from these
> > isolated CPUs, so in reality, it isn't a big deal.
> 
> Hi Ming,
> 
> While that may be true for general-purpose workloads, it is a fundamentally
> incorrect assumption for the highly specialised environments that actually
> rely on strict CPU isolation, such as High-Frequency Trading (HFT).
> 
> The requirement in these strict environments is not that the isolated CPU
> performs zero I/O. Rather, the requirement is that the isolated CPU must be
> shielded from the unpredictable latency of the hardware completion
> interrupt.

Again it is just your opinion, not a bug report, may not be a fact, right?
Which kind of HFT application submits IO from isolated CPU?

However, as I mentioned, I don't object this patchset, but you have to fix all
wrong comment & document & bug found in review first.


Thanks, 
Ming

