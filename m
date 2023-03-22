Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B3CC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 12:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F9v4u5dsmD7IdPDedAw7yl5GKCx002rE2DFuzXEhabA=; b=TM6DTEAxIr8T2sY8b1PDW84sSk
	gV5CrvMys3zRfNWsoMIvGVZd3Lm7SiOzG0dP3NH0aPhhIr7QIk5m4U2LEinr/GZ1Iod1wwIhujo56
	gJyEdlKikZzl7qVPr+3B+AlmWOgQwy8oBzFemtM7uHz/6OI9qESDjQZ51fZexHCZXmXVqtnvMXUH7
	92du2YS2jxdQrIqn8QGa3FGwtuZta268pqjDOKIbpw3JLr7Ak/6C+Ctovyqn+283AAkvsSGplHfJv
	Ql70hS5hTgPDk3PHjqIj7XquSlJVD/r+796xSNtlwfOS8kWFHVX+XrKSFzA8IvbIz9HfV4Ox5UUxy
	s5HWYEmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pexzJ-00G1db-2e;
	Wed, 22 Mar 2023 12:54:45 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pexzH-00G1cU-15
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 12:54:44 +0000
Received: by mail-qt1-x82d.google.com with SMTP id x1so22364718qtr.7
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 05:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679489681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F9v4u5dsmD7IdPDedAw7yl5GKCx002rE2DFuzXEhabA=;
        b=oseP/IlFp1j6s51mg5FR8BiD6pOuhlK2sA/PlZwS/47aFuK75h2plqVR7N7hDpcFa9
         RNPKysEMUcAGmfNzJFQjff8MPwtzdEDzgXasGPPvcWoLZRxVPcs0do46FVyGzpIx9O9f
         FgsKFh5qQ8h7ho1bSmqDMyyTzD9X+IKIEneS507MEDL3prFqV3lx0yiRMRFF8RpcWnLD
         y2HeeLXMMjA65EWEnQpwhRbYW5wkS0WxrYqbmrXRxpcXw54Ksy4fYNzuP6ahgYd10Qw0
         Qy4dGtMucvoCfJFJYxp/OlFfph19hl6TG3+gX53Gm423poeYD12x9UMuxq7X9L/RkxaM
         KD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9v4u5dsmD7IdPDedAw7yl5GKCx002rE2DFuzXEhabA=;
        b=LLxxVcdGR9RSfk/UA2lPifp+buyPYQSoeRMCyXVRutoinUh4SBr5JyiKP8y7jibFIR
         3VR/b11F16wNyZ9yhWEmJD+DngfXdiNnSyXE8eqChoNfNQxb2+AHW/wi+IxaCo8F/mCh
         tRa7PTWWB0h75bgbuDUVG7hElTbBhGSfL239pMuOy5IXUXGtASnejDSeAnUkxsYc20Ow
         tCaSc+xz+GFfMEspJG+wZB7M6B5k29FWi+eCaiuoqsyjAxm3dWZxFv1hjMgNxImgcyB4
         +x/SNh6LX7kol6czZPA2q0AMsHn71A8Hn/HJvHRXTXftwjwGZTSAq3T+plRK5g8J2z66
         zm1g==
X-Gm-Message-State: AO0yUKULMPGFJuZsrS3Bp0u+W/2Kb/NOmHd6cKFhMufOI9A3bEIJGa3G
	GZB6t4SEnadJX3e7PuI8SGBWI1i4N/csYiIL1Kw=
X-Google-Smtp-Source: AK7set84B/dAzc/qRKnsrbryejsxkR+kgL8Ft54Ca1aeV7djrv80URDlXYzzFfBac/AL/7y8+qjk8Q==
X-Received: by 2002:ac8:5c93:0:b0:3e0:3187:faf3 with SMTP id r19-20020ac85c93000000b003e03187faf3mr6264695qta.13.1679489681268;
        Wed, 22 Mar 2023 05:54:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id k10-20020ac8604a000000b003d3a34d2eb2sm10168725qtm.41.2023.03.22.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:54:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pexzE-000msK-9E;
	Wed, 22 Mar 2023 09:54:40 -0300
Date: Wed, 22 Mar 2023 09:54:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Message-ID: <ZBr6kNVoa5RbNzSa@ziepe.ca>
References: <20230322123703.485544-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322123703.485544-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_055443_632650_FB9680C5 
X-CRM114-Status: GOOD (  10.06  )
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

On Wed, Mar 22, 2023 at 02:37:03PM +0200, Sagi Grimberg wrote:
> No rdma device exposes its irq vectors affinity today. So the only
> mapping that we have left, is the default blk_mq_map_queues, which
> we fallback to anyways. Also fixup the only consumer of this helper
> (nvme-rdma).

This was the only caller of ib_get_vector_affinity() so please delete 
op get_vector_affinity and ib_get_vector_affinity() from verbs as well

Jason

