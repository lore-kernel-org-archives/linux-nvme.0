Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECDAC27C79
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jun 2024 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qdy5LyMULWck3Md4+bBBURmMFZ9PSYp6XgffXBG2oTQ=; b=u43hUX3430V6xteP+EnN8I13xG
	Xgb2w+qGTzzB+YDysW4sdIROKBg9+pMcVJ4No+iaqFLQs89EPkhXlb3tSR/hLkhEK2l571NZdqLai
	vpwrgEuYKhcp6gY/qrnKmL0u7SYekHegFTXdXFk7ZQiQ5zc532DOutF3I9Nmhbawx9c768Bzk1ErW
	4vZvhSasQagK9lK8tOhMtiluGhkGNFJn8FLka8QcGU88vGfhz52YDvpi+eXD1cB4ptsY+THW3DJcY
	ybga2Q7NU3vCFQPeAE7dN2yxNjIkk8kgcrQgHC748HZrIl3q0wLtdp7PG8oftseUX0k/7VB+XS7yW
	EVU4BioA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKIym-00000005VDY-0vFz;
	Thu, 20 Jun 2024 14:41:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKIyj-00000005VBR-0yfa
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 14:41:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718894492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdy5LyMULWck3Md4+bBBURmMFZ9PSYp6XgffXBG2oTQ=;
	b=gIIVemqYKdPvDtEvOQrGzEieT7BQ0IJBS6keYLldMdsZ+X2Nj01ByI8ExwRR3Nu4UG+pvE
	ek3SoHRZ821KdmX4fV5fWAwAkvky1DdL3t8uDdSLDOQxd1juJObh+daFz9Ro5JqDeicLAk
	AviG5AnOkezwqHcdMdCWmpRTR2eL/1A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-O9W2lsr3PiOgMXTtj8IMaA-1; Thu,
 20 Jun 2024 10:41:27 -0400
X-MC-Unique: O9W2lsr3PiOgMXTtj8IMaA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76958195608C;
	Thu, 20 Jun 2024 14:41:25 +0000 (UTC)
Received: from [10.22.34.111] (unknown [10.22.34.111])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 314DA19560AE;
	Thu, 20 Jun 2024 14:41:22 +0000 (UTC)
Message-ID: <b09f3db4-df3a-4dce-a490-32b38e97231a@redhat.com>
Date: Thu, 20 Jun 2024 10:41:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvme-multipath: implement "queue-depth" iopolicy
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, emilne@redhat.com, jrani@purestorage.com,
 randyj@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org
References: <20240619163503.500844-1-jmeneghi@redhat.com>
 <20240619163503.500844-2-jmeneghi@redhat.com> <20240620065641.GA22113@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240620065641.GA22113@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_074133_438282_90216F5E 
X-CRM114-Status: GOOD (  10.37  )
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

On 6/20/24 02:56, Christoph Hellwig wrote:
>> +		WARN_ON_ONCE((atomic_dec_if_positive(&ns->ctrl->nr_active)) < 0);
> Overly long line.
> 
> But I don't understand why you need the WARN_ON anyway.  If the value
> must always be positive there is no point in atomic_dec_if_positive.
> If misaccounting is fine there WARN_ON is counterproductive.

Agreed. I wanted this here for testing purposes.  In all of my hours of running tests I never saw this warning go off, so I 
agree it should be removed.

/John


