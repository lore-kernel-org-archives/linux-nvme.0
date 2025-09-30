Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177CFCCA471
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 09:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lTOxxV9OlZarUjt5LRTMrnxi0pIE/jk4h9AJiGhL9Sc=; b=Gd8Z2Rsw+ixw+NUmtTC+iOE5MQ
	jC/CovREas2i+1YOGrZsF0TPzlI0/EMg7Q9GbW+a1T2CbEuI8vwgAf2AE5rLehI7H+h5IB6uQCyNK
	TfoT3+pPk4pGdhjQGysM+shc1uhivhy10P/4218lyswiMLBBQVrWYI63QAjp/qyQSs4VVjfq3ksFc
	1NDlFyXKLsUVb+AGvps9MmBgit9J1xEaHSz/hxDykm2pqjnfSfZQMj6xUbhqBNOhVOugZtu/vRS9e
	5G7ZTiMSe5+xOSGLhlI/Eu03URKEFgwnHSE4ezpNU+41sAYb7tz2k5ItOJV9MUOB9OvyShS7QEuTM
	9jsy8ZEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Wpy-00000004s54-1ytk;
	Tue, 30 Sep 2025 09:39:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Wov-00000004r73-2deK
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 09:38:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759225132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTOxxV9OlZarUjt5LRTMrnxi0pIE/jk4h9AJiGhL9Sc=;
	b=RLZgrbgYygS487GQxvkp5M41s3dIOxo7/9XRtjO4AGrqSuQSPFkYfpCwzYqCkTHNQeJbTD
	PDLQFwMW9+cq6YVyXg12MFlVhX1r50okdX76VjTWwj7miuCYBpSZ0vOnm22r3d/2NFeoKL
	pAOZ71mj2VY8JNzYU/FtBaeOZgjQnWQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-OPv1_Ec0OQ-x6hQwUceWRA-1; Tue,
 30 Sep 2025 05:38:45 -0400
X-MC-Unique: OPv1_Ec0OQ-x6hQwUceWRA-1
X-Mimecast-MFC-AGG-ID: OPv1_Ec0OQ-x6hQwUceWRA_1759225123
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEB35180028D;
	Tue, 30 Sep 2025 09:38:42 +0000 (UTC)
Received: from [10.44.33.194] (unknown [10.44.33.194])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DEF3230002C5;
	Tue, 30 Sep 2025 09:38:36 +0000 (UTC)
Message-ID: <1b17fc45-ba6e-4fb3-9352-a6ec0ae913f2@redhat.com>
Date: Tue, 30 Sep 2025 05:38:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 11/11] scsi: qla2xxx: Fix 2 memcpy field-spanning
 write issue
To: Hannes Reinecke <hare@suse.de>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>, kbusch@kernel.org,
 martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Cc: bgurney@redhat.com, axboe@kernel.dk, emilne@redhat.com,
 gustavoars@kernel.org, hch@lst.de, james.smart@broadcom.com,
 kees@kernel.org, linux-hardening@vger.kernel.org, njavali@marvell.com,
 sagi@grimberg.me
References: <20250926000200.837025-1-jmeneghi@redhat.com>
 <20250926000200.837025-12-jmeneghi@redhat.com>
 <0af9cbc4-a410-44f3-affc-a09e5c41ccd4@embeddedor.com>
 <49b31606-29fc-43ea-973b-b317c53161db@suse.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <49b31606-29fc-43ea-973b-b317c53161db@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_023854_208054_57CEAE91 
X-CRM114-Status: GOOD (  15.11  )
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

On 9/26/25 5:29 AM, Hannes Reinecke wrote:
> On 9/26/25 11:00, Gustavo A. R. Silva wrote:
>> Hi,
>>
>> Shouldn't this patch be removed from this series, since it's going to be
>> reverted anyways?
>>
> yes. To my understanding the FPIN patch series has been queued in
> scsi-queue anyway, so it would be better to just send an incremental
> patch on top of that.
> Especially as Martin has already indicated that he will _not_ rebase
> his tree.

This V10 patch series is based on nvme-v18.

I don't see the revert in scsi/6.18/scsi-queue yet

> Best to just send this patch as a stand-alone patch, and then rebase
> any not-yet-upstreamed patchsets on top of that.

I'd prefer to merge this patch with the FPIN-LI patch series.  There is to good way to test this field-spanning write fix w/out the FPIN_LI patches,
and the last time we cherry-picked and merged this fix it only led to confusion.

I think we should keep these together.  I will add Gustavo's new fix to my V11 patch series.

/John

> Cheers,
> 
> Hannes


