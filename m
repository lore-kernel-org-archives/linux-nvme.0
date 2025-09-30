Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C57BCCA470
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 10:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pfEJXGGOjez9m3as9ie2g530+S/Tkj59HROsinohPWc=; b=OESOlKkAm61dUm5HAHg6exohcP
	R9o1j+IxalD7BzMkHW2EsAQZ7bZDK4ODg+OE1t95S1HbssmTRQdxao7GgRqDy4qyXFk1VDNjNzirT
	XH53B5Dbu7sqaI7139HBboRBPKA0bg+hKYco+Nw536AY0/qNr+zwOESAX5NJrN6S8EW5Y5RulaD6W
	DFiR5BB5dOIeseaAWPNptyWjyddv6f/0s8mrVewzr32Bey7IdT7l/LcnI7mC0hwGAnf0tH0JR4tuT
	Fer8XzjYeOIqNJibm+i1w95yABKyhGdFRg3hpsfeMR1ecI4f10dSJBWcXd8H/r/4pyQsOD1Aw04Bz
	/LSSxUJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3XOe-00000004ykM-1Rk3;
	Tue, 30 Sep 2025 10:15:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3XOb-00000004yiz-3PwC
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 10:15:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759227345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfEJXGGOjez9m3as9ie2g530+S/Tkj59HROsinohPWc=;
	b=SM4efpQ/QilEcGjAt+ikzLreg4haDQqXHbMGaQbsa6y0lGfWBIjdzI2NiA9YW4WAjVX/1V
	Rj1MooHVdhctP/TGetHQbrbFmQbvHzCKFkRcEAGXF71QnpxtOR56j2dVIbj4TKR+8U56EB
	QiA+xzJTfzDyAp4AP/XWc0eg45s4aWA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-iqqaXjR8P4Sz3R0JMDRhBQ-1; Tue,
 30 Sep 2025 06:15:41 -0400
X-MC-Unique: iqqaXjR8P4Sz3R0JMDRhBQ-1
X-Mimecast-MFC-AGG-ID: iqqaXjR8P4Sz3R0JMDRhBQ_1759227339
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B89A1956089;
	Tue, 30 Sep 2025 10:15:39 +0000 (UTC)
Received: from [10.44.33.194] (unknown [10.44.33.194])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B1BB19560B4;
	Tue, 30 Sep 2025 10:15:32 +0000 (UTC)
Message-ID: <6f021d24-280e-4b7c-b79f-36434ef99c0b@redhat.com>
Date: Tue, 30 Sep 2025 06:15:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/11] fc_els: use 'union fc_tlv_desc'
To: Justin Tee <justintee8345@gmail.com>
Cc: hare@suse.de, kbusch@kernel.org, martin.petersen@oracle.com,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 bgurney@redhat.com, axboe@kernel.dk, emilne@redhat.com,
 gustavoars@kernel.org, hch@lst.de, james.smart@broadcom.com,
 Justin Tee <justin.tee@broadcom.com>, kees@kernel.org,
 linux-hardening@vger.kernel.org, njavali@marvell.com, sagi@grimberg.me
References: <20250926000200.837025-1-jmeneghi@redhat.com>
 <20250926000200.837025-2-jmeneghi@redhat.com>
 <CABPRKS_AOnXmG7NAfgsEKLx2Er_WBcR48wCZwxbKLXnv7FPCZQ@mail.gmail.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <CABPRKS_AOnXmG7NAfgsEKLx2Er_WBcR48wCZwxbKLXnv7FPCZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_031545_978341_1D6D97E9 
X-CRM114-Status: UNSURE (   8.30  )
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

On 9/29/25 1:44 PM, Justin Tee wrote:> Hi John,
> 
> Which branch is this patch based on?  include/uapi/scsi/fc/fc_els.h
> does not apply cleanly on 6.18/scsi-queue.

It's in the patch cover letter.  I've re-based V11 onto nvme-6.18.
  
> Presumably, is this patch based on a branch without?
> 44b6169ada7f scsi: fc: Avoid -Wflex-array-member-not-at-end warnings

Yes
  
> Regards,
> Justin
> 


