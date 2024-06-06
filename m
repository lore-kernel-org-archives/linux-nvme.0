Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C0BC27C5E
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 23:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u6KkShH+LBPBDtFL/J7+56MEKPg8eU6ralQnJ1U5rNo=; b=b14lEWb4lTctJvJIWRQqJOFXp+
	WHZ9vVgfiiBW0WRICfnWR4M71kFs5+97+B8iimPNl3O02/ZXLTBGztrwyKwVTeelK+8/pFG0sZFDm
	oSFwLEQj5YtsYXNXIbOjw4hwOcoMPQWmBoUYgYSoqgtkyCJnQWYNiCwPxEL+FC3UYa9mOidYjDF59
	ZBkq/C70d/TwCNpSOj+TR9Z7Kkeqvx7i9a1p4zxaxa5pBjilRQrH3qCqhFe8o6cRGcqV3wDdflAUn
	awATbObxxkTurbZBXQuWnOc7vq7/rtB9pA2r0pl81KQGKkeRSRjLkUsVGFhQz5ZiX33QJ5LFmy+qj
	rAxtFdmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFMoq-0000000BkIm-2SND;
	Thu, 06 Jun 2024 23:46:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFMok-0000000BkH1-2j0q
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 23:46:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717717609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6KkShH+LBPBDtFL/J7+56MEKPg8eU6ralQnJ1U5rNo=;
	b=DPULfInrvO4Ui/3lu/QusP1N425/0KVGP8kbHMrw6RZ/Z7kXUODA81LsDyVxN+UUnDPTkQ
	8C5yfCvEv/xpiUwPOO5rmD2bEOFcWMx/Ry4daZuE36ZQrzJi0k3+ApUWSR/SsyZGtkXxSr
	UAwCXCn2BfE87FMy0g2kWBK/YkQOoT4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-HAhIOT2zNmKofTm7DiPH8g-1; Thu,
 06 Jun 2024 19:46:43 -0400
X-MC-Unique: HAhIOT2zNmKofTm7DiPH8g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E5371944D3B;
	Thu,  6 Jun 2024 23:46:40 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CE101955F14;
	Thu,  6 Jun 2024 23:46:32 +0000 (UTC)
Date: Fri, 7 Jun 2024 07:46:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: yebin <yebin@huaweicloud.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ye Bin <yebin10@huawei.com>, Zhang Yi <yizhan@redhat.com>,
	"Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
Message-ID: <ZmJKU9mMDg1+mO3i@fedora>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
 <ZmFatW3BEzTPgR7S@infradead.org>
 <66619EB6.4040002@huaweicloud.com>
 <ZmHH7mW0M80RaPlj@fedora>
 <ZmHNQ56C6Ee01Kcv@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmHNQ56C6Ee01Kcv@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_164650_785022_E636ECE6 
X-CRM114-Status: GOOD (  19.29  )
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

On Thu, Jun 06, 2024 at 07:52:51AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 06, 2024 at 10:30:06PM +0800, Ming Lei wrote:
> > Yeah, that is one area queue freezing can't cover logical block size
> > change, but I'd suggest to put the logical bs check into submit_bio() or
> > slow path of __bio_queue_enter() at least.
> 
> We really need an alignment check in submit_bio anyway, so doing it
> under the freeze protection would also help with this.
> 
> > My concern is that nvme format is started without draining IO, and
> > IO can be submitted to hardware when nvme FW is handling formatting.
> > I am not sure if nvme FW can deal with this situation correctly.
> > Ewan suggested to run 'nvme format' with exclusive nvme disk open, which
> > needs nvme-cli change.
> 
> .. and doesn't protect against someone using a different tool anyway.
> 
> That beeing said, nvme_passthru_start actually freezes all queues
> based on the commands supported an affects log, and
> nvme_init_known_nvm_effects should force this even for controllers
> not supporting the log or reporting bogus information.  So in general
> the queue should be frozen during the actual format.

That is something I missed, thanks for sharing the story.


Thanks,
Ming


