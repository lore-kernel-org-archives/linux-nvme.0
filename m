Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5868610775E6
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 16:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1g/QSOWMUDAkDML7DdsyKS4nG9HS0WdFD6bZtbSl7jQ=; b=DpWL8lXMeCoIZPScuS7aamAIb+
	6vMCEfmn3ZZyPqqfYdGuW+KqiRkN5tt3kLxQ50B/17NxyJph2QOqk+rtS3aISkmJdr5Dz+ld4El+d
	VgJ5ERjg1cfbvaUqA2b4rYiZmdI+HjLp7g2ZZJxa8Q4M2gIoyF7ZlG56qLItGPykSAGMc2QKL49oi
	pBqrLnUyaRhDU81cm/gn5DhidCg1EX+Lk8Uk70zxcOPFUgiWYlRtopNUDsxxG403+aVFY1tsCiqPK
	PKKMxx7bkDA50fZm9KYO1mYaK/i5Vodz1UGeJlDBv3ESp+EhTpqBKe3NBf+I3XVdsa/9H7QsMTFck
	U8mwjOqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2ti2-00000008v2p-1ygn;
	Wed, 18 Mar 2026 16:25:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2thz-00000008v2O-1pvh
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 16:25:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773851120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1g/QSOWMUDAkDML7DdsyKS4nG9HS0WdFD6bZtbSl7jQ=;
	b=Y84WhpmyRR17t1mm/URLDLe705828ZtghmXaFZ4mTaaMYGE9jKE9y1RuwUgBv6yL62fBjV
	OuIEQ3LksIJiyFPXjAvmjf3M6UA4teArj2hm6suUl7xILleWsiUUiAXrROtPZpvZNmk3Ne
	4k0FDtEIvDFPtw+B1QHFiYoJT7SSffQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-uW89ORASOEGH7b-R4QPRxQ-1; Wed,
 18 Mar 2026 12:25:16 -0400
X-MC-Unique: uW89ORASOEGH7b-R4QPRxQ-1
X-Mimecast-MFC-AGG-ID: uW89ORASOEGH7b-R4QPRxQ_1773851114
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0813718005B6;
	Wed, 18 Mar 2026 16:25:14 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.16.140])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AF1F61800576;
	Wed, 18 Mar 2026 16:25:10 +0000 (UTC)
Date: Wed, 18 Mar 2026 09:25:09 -0700
From: Chris Leech <cleech@redhat.com>
To: Christoph Hellwig <hch@lst.de>, alistair23@gmail.com, 
	yjshin0438@gmail.com
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>, Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Subject: Re: [PATCH v3] nvme-auth: Don't propose NVME_AUTH_DHGROUP_NULL with
 SC_C
Message-ID: <20260318-giveaway-lethargy-dbfa148ebbf0@redhat.com>
References: <20260318004658.3681991-1-alistair.francis@wdc.com>
 <20260318075655.GA25711@lst.de>
MIME-Version: 1.0
In-Reply-To: <20260318075655.GA25711@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: xfi05axkmDUvaq4fAdKxUG6kO4xYsjFarX_fxdPqLXs_1773851114
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_092523_545341_0573F965 
X-CRM114-Status: GOOD (  15.31  )
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

On Wed, Mar 18, 2026 at 08:56:55AM +0100, Christoph Hellwig wrote:
> On Wed, Mar 18, 2026 at 10:46:58AM +1000, alistair23@gmail.com wrote:
> >  
> > +#define DH_GID_LIST_OFFSET 30
> 
> Note that we have a target side patch ("nvmet: auth: validate dhchap id
> list lengths") also adding defines related to this, but in a different
> place and using different naming:
> 
> 
> +#define NVME_AUTH_DHCHAP_MAX_HASH_IDS 30
> +#define NVME_AUTH_DHCHAP_MAX_DH_IDS 30
> 
> Back in the day we usually did nvme.h patch separately to handle these
> kinds of conflicts a little better.
> 
> YunJe/Alistair, maybe whoever resends next should split this out,
> add all the required values and add a pointer to the spec?

Is there a good reason to keep a single idlist[60] in the struct
defintiion and need this offset at all? Or can we repalce it with
somthing like haidlist[30], dhidlist[30]?

NVMe base spec r2.3 section is 8.3.5.5.2, where these are seperate
fields named HashIDList and DHgIDList.

- Chris


