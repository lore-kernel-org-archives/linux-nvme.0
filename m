Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D9FEC110C
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 17:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j3KxNfXWqPsbPYfW5H16tMBj0BZINcZ15V0/vV0/Yj0=; b=FhLAW0jalzKqAAOrQWPdUYEWGv
	x/N/DxDJQBabumfwonup1SpffTWK0FpoZ8WEUHh7p9nPPtMSNyIj30GyOyqMcuMPhBno13P4OA+Bm
	9E+9sHI30IjnY5C+F6PIpIWewrEDdYl9u6RJn5T6zOLWbLnECL1AUMmYEuIgOhPGIX7lLj953MVUm
	bjG4uTbfL2DPsBgYumbP9xRRO/PbYqYtFvb/QbmuyLd2etShKDaXCrJaP/LdGlsYJLh1IQ18XryEJ
	AUQV8BoKqMVr0jPKlKFBEE0TwDD8O63GKqXXLXg3ZXA6nx7jDbFHgLH86+yDVc8FkZ37viPoMaBLa
	LUuZqmRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZsC-00000000nR4-1oXh;
	Mon, 23 Feb 2026 17:37:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZs9-00000000nQX-3bW8
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 17:37:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771868247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3KxNfXWqPsbPYfW5H16tMBj0BZINcZ15V0/vV0/Yj0=;
	b=hotq9DQFlhbD9CN02Ut3gWR4TgqC+eDQrJrb1jTd8oIGQXZbvoaA/xbEBLXO65GQl3tttP
	rn9P3AIKfnCKtvjhpQxsON6v2vYB6w7BGAZAwCFk6LzMIgeF2bl1FH1XRxuTSwlbnd7/hC
	1iww6bx6t/po+Xgaz8Q9K7MjUz+2QdQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-PY-tEW5ANEShFRDJ4_cdyA-1; Mon,
 23 Feb 2026 12:35:55 -0500
X-MC-Unique: PY-tEW5ANEShFRDJ4_cdyA-1
X-Mimecast-MFC-AGG-ID: PY-tEW5ANEShFRDJ4_cdyA_1771868154
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C935180025A;
	Mon, 23 Feb 2026 17:35:54 +0000 (UTC)
Received: from [10.22.65.209] (unknown [10.22.65.209])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4688F30001BB;
	Mon, 23 Feb 2026 17:35:52 +0000 (UTC)
Message-ID: <4b668a20-17c5-4d70-b384-4a41e49799c4@redhat.com>
Date: Mon, 23 Feb 2026 12:35:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Implementation of Cross-controller
 reset/Time-based recovery (CQT) in the linux nvme driver
To: Randy Jennings <randyj@purestorage.com>,
 lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org
References: <CAPpK+O03nHvHGESXsDDARz_kgbNkmeHmu-G3XWto7CqHtyVedQ@mail.gmail.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <CAPpK+O03nHvHGESXsDDARz_kgbNkmeHmu-G3XWto7CqHtyVedQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E4OuRZsCEiO_4nA7sxl8yOvcRZ9tulQjWjBZHYf3QxA_1771868154
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_093729_975262_6E6D5A45 
X-CRM114-Status: UNSURE (   9.18  )
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

On 2/13/26 8:09 PM, Randy Jennings wrote:
> I'd like to discuss the state of patchsets related to implementing
> Cross-controller Reset and Time-based recovery (CQT) in the linux nvme
> driver for fabrics transports.  I expect to present performance test
> results that show the impact on read, read/write, write workloads with
> packet drop and storage controller failover scenarios for different
> levels of implementation (none, CQT only, CCR+CQT, filtering some
> outstanding requests (probably just reads, maybe some admin
> requests)).
> 
> Current patchset is:
> https://lore.kernel.org/all/35ae10c9-808a-4882-86dc-311b23c821e5@grimberg.me/
> Although, I expect it will be updated shortly.

I'd like to come to LSF/MM this year and discuss this.

I've agreed to work with Randy as a co-presenter on this topic.

John A. Meneghini
Senior Principal Platform Storage Engineer
RHEL SST - Platform Storage Group
jmeneghi@redhat.com

> Sincerely,
> Randy Jennings
> 


