Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4CECAC5B9
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AcBv2gmBH1a2eQ2kJO64gswsAwDukKrga9nsThtCRik=; b=4FsLVUy+FkCgw3Dx6UwVGzW5w5
	wzWKK85YLqk7kGFuIllHHbryIbM0kKEsgpt0CK/MfLVRGeGXaPxSTq07oKP9ljpik/FJjYRiAtTeh
	adb8as+cq7jsEFKJ4yZax2OiWGGCDBfY7BRHa8sJ2IRn4gxWwRh6ITez0ws7XwkUxU2IJDdFcHqtG
	bsA+NCHhVK2qsrniuzFha2zAZyUEq+F0j7wjhySK7iwb0GM92/OncWeZ0kNsCfiBV/XOryGZjfj6r
	1bTMFeYWAjv3hMqQUhNYsbThNqDsBFSJZdM2q4P9A2Pr0XOzlTm8yFjc+nX097M7lFB7QCGoTv6fy
	rGcjHWTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Wlr-00000004paD-0aWw;
	Tue, 30 Sep 2025 09:35:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Wlo-00000004pYP-1QBJ
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 09:35:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759224939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcBv2gmBH1a2eQ2kJO64gswsAwDukKrga9nsThtCRik=;
	b=WVmCQrWIxcWest7lXllW7Vdupxmo2prfmKOwO6ZS92StioW3Q/Na+w/TOzGSbmRFkTWMXd
	2GhajsezGlT55YYCwrx434jIWWECNsLoVIBAw1+nJuBBhDoiLlE+4nP9g3tc9h/rj+R0mo
	83gTXaHTxkebPX84cSyMbQH36dLuw3A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-cxNHlLSWPOGhd6mPlEG8AA-1; Tue,
 30 Sep 2025 05:35:33 -0400
X-MC-Unique: cxNHlLSWPOGhd6mPlEG8AA-1
X-Mimecast-MFC-AGG-ID: cxNHlLSWPOGhd6mPlEG8AA_1759224931
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD79E19560B3;
	Tue, 30 Sep 2025 09:35:30 +0000 (UTC)
Received: from [10.44.33.194] (unknown [10.44.33.194])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 875301800452;
	Tue, 30 Sep 2025 09:35:24 +0000 (UTC)
Message-ID: <70657b10-32a3-4c4f-bb53-e95d88435d58@redhat.com>
Date: Tue, 30 Sep 2025 05:35:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "scsi: qla2xxx: Fix memcpy() field-spanning write
 issue"
To: martin.petersen@oracle.com
Cc: axboe@kernel.dk, emilne@redhat.com, gustavoars@kernel.org, hare@suse.de,
 hch@lst.de, james.smart@broadcom.com, kbusch@kernel.org, kees@kernel.org,
 linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, njavali@marvell.com, sagi@grimberg.me,
 gustavoars@kernel.org
References: <yq1zfajqpec.fsf@ca-mkp.ca.oracle.com>
 <20250925130729.776904-1-jmeneghi@redhat.com>
 <7b1342ce-0f30-4481-bf3b-ef3c92b9bcf8@embeddedor.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <7b1342ce-0f30-4481-bf3b-ef3c92b9bcf8@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_023540_460500_1EA4F5F6 
X-CRM114-Status: UNSURE (   9.98  )
X-CRM114-Notice: Please train this message.
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

Martin,

I don't see this patch in scsi/6.18/scsi-queue yet.

Are we going to revert this ?

/John

On 9/25/25 2:57 PM, Gustavo A. R. Silva wrote:
> 
> 
> On 9/25/25 15:07, John Meneghini wrote:
>> This reverts commit 6f4b10226b6b1e7d1ff3cdb006cf0f6da6eed71e.
>>
>> We've been testing this patch and it turns out there is a significant
>> bug here. This leaks memory and causes a driver hang.
>>
>> Link:
>> https://lore.kernel.org/linux-scsi/yq1zfajqpec.fsf@ca-mkp.ca.oracle.com/
>>
>> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> 
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks!
> -Gustavo
> 


