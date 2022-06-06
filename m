Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE64BC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QqBjm6ExFDKoZI2vuwecpvsMHNF+qI+tR4Y3go9GTYQ=; b=Iu8S1I9mZRn/bq9sZFhug8Yu/5
	7TCPyBowbXPmkbKyQY5u5RtQkJ7uEsnDWH8a6uGHPaG4hgjwC3w6zKtuTnmBAc2AF6exuERiI1+fH
	flrxQIT1+Kfbh/jPKN51B64qG7+IyAmRUZB+ow/ZjjWldCiywDuJwHv2CBDF+Zg6zGaT4R9bDLSpV
	dlT/aCUGLCgtfYDGW/qW3gR4ZHDJpmpZpuczv3/FQVjAiTuPI7Npdm8QiCMkrzMneJ2ypF5JpbMyE
	MVim58qbnrGO+N9oGP6OTRZhKLuU62pfmB8VGvqO8m5elqxprpJGKQi2x7VlCyt8TQljskz2x2dqe
	K9ZuP7Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyFTX-0020fe-Qx; Mon, 06 Jun 2022 16:21:07 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyFTU-0020eB-IL
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 16:21:06 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id bc11so3134549qvb.3
        for <linux-nvme@lists.infradead.org>; Mon, 06 Jun 2022 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QqBjm6ExFDKoZI2vuwecpvsMHNF+qI+tR4Y3go9GTYQ=;
        b=MqKTNhkIrqgeKlshPnEt9mnekrzy5nY4sojkQp88ViEAn4jgcrViFfxWT+ZMDZ1a4x
         FU0ET05r68ad44m3NmD1uWT2M3Cfpw0E9TLnK7H+TnucOQo+drC2LJPocQus3Or6/MdW
         fnFJ7FcOhX27wi7oqlQmouDpoEk54spzYrbdjPRSXh9j2tdWA25tgrCyqa79EcJuhs6C
         OwPQxEmMQir60q+ULrSEwoPH0VFyCtQgreDZo90gNHqtM/TxLiuYSxQuRbk45i/qL045
         kBTxWy0XUG3XBkLHSHaJhKDrmtYo2xurejpYgLZ768vWuqCnvLeyOkhmpQ2jrKDPrGPz
         L+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QqBjm6ExFDKoZI2vuwecpvsMHNF+qI+tR4Y3go9GTYQ=;
        b=PZJWb7pCg6p08NZEYOhE3QJOc33UZY6s7svXu6MxtAnBYrw8+eZfGeSBuFm+H+jV0c
         CT76vCW64qJO2UilJrTnKnk5zvM3VI9ZPcGeM2V85nhcz3uZCn/zZjWKwGpZhSIE2pH0
         rQKiRHAMQuNNdwoukLCmDjy3p3hE4WUaJI7NTRbGvGDKn+Fmv4O/iCWspKxNgJQSoDe1
         k+NGCmWTf36gYa0mIm/IZjyE8RYZeRpzOvcAM1X4wygzE6tOYZA7wUXHJZCAbhSXhEZF
         kdM1VHJH54uc/OKbJkYXpB0cXq5zjNeRmbOsvv9lmAlvwNhq3c7mQMEjHXtjnLAon8qg
         A6mw==
X-Gm-Message-State: AOAM530eaywFsiLA72Q1yrDDdOVMlI74T6Tneyfqz9mu+bueQ0JcsB+5
	QrwkbpRL7Le2cBYMuM9wqyr51w==
X-Google-Smtp-Source: ABdhPJy41fQ9qZtPSyZLpy4jJpFiemjkZjeNOCmn8JnuAyqwUluHdgvFQhBtxzwwTORdIRANvNLPRA==
X-Received: by 2002:ad4:5ecd:0:b0:467:d600:7709 with SMTP id jm13-20020ad45ecd000000b00467d6007709mr15012890qvb.7.1654532462510;
        Mon, 06 Jun 2022 09:21:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a15-20020ac8434f000000b00304df6f73f0sm5666476qtn.0.2022.06.06.09.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 09:21:01 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
	(envelope-from <jgg@ziepe.ca>)
	id 1nyFTR-002igF-5S; Mon, 06 Jun 2022 13:21:01 -0300
Date: Mon, 6 Jun 2022 13:21:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Message-ID: <20220606162101.GA3932382@ziepe.ca>
References: <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
 <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
 <20220531123544.GH2960187@ziepe.ca>
 <355f1926-9a0d-f65e-d604-6b452fa987e9@acm.org>
 <20220601124556.GI2960187@ziepe.ca>
 <109ac246-5cc0-8d5a-ac0a-2937d86fbe06@acm.org>
 <20220601173005.GJ2960187@ziepe.ca>
 <53951a52-dc77-f4c9-a1dc-d6ac015be1a4@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53951a52-dc77-f4c9-a1dc-d6ac015be1a4@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_092105_000413_A811B51A 
X-CRM114-Status: GOOD (  10.60  )
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

On Thu, Jun 02, 2022 at 10:13:25PM -0700, Bart Van Assche wrote:
> On 6/1/22 10:30, Jason Gunthorpe wrote:
> > That is just the keys, not the graph arcs. lockdep records an arc
> > between every key that establishes a locking relationship and
> > minimizing the number of keys also de-duplicates those arcs.
> 
> Do you agree that this overhead is acceptable since lockdep is only
> used to debug kernel code?

I don't know lockdep well enough to know - if you bloat the graph too
much it may become excessively slow when searching for
cycles/edges. Debug workloads with CM may trigger creating of 1000's
of keys and we still want the testing to be workable.

IMHO it was not designed to have one key per instance.

Jason

