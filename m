Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CEDC47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 15:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=brkDArji8Mg4BJnLwGQ8PB5AsSX+mftPJdznB/wGr1c=; b=nUKUHRaiEKGuqFKVLj0TfZg73z
	5GVkEjQbrJ1wPCd8w4PNoKD+OoAE2R5H35ah6rRiDSeUDT4BI7eOUfJr6AcIoqApOPaGtZdMEmPt8
	eUalhZc9IIKiOwbd6mqgFrr3Z2CFkSXKrFhk+C6SfDAykb1QipeyOMB1zVjHo4TYG4+tEfDAPt60D
	rYLpoQFuWPP0TxPtICDRUcVYQ3CyZnZaDFLCyaaqsj6HSm5/mB5Vwi2Huqx0OSzRR8hRl55eTZNbW
	Fh2roz30zJn+YM/QvhPg3MCZ8GzpLmR1i9F/CkEzvt0cU5mwIwsNjl2zm2ftlFUDLra3sugBCqifn
	Jvr0E6lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUTdZ-0000000DIPW-0vHS;
	Mon, 29 Jan 2024 15:33:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUTdV-0000000DIMg-2Yr8
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 15:33:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706542404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brkDArji8Mg4BJnLwGQ8PB5AsSX+mftPJdznB/wGr1c=;
	b=CiZ2dpTEnwl/lDz7kG1aXME4ng90ES82nmnHJahmWZKVROdZw6Q9ekVfItEwB4Oxqzos1o
	5+iMbv0lkiZP0Y0Rt5j/sTuOLquoOerZdljZbj7FKmKSusiueVcZomGIrBNWFmInmJAm2B
	4jLw5nvcaHxiq3YYnAm/aV9pTHwwJ6A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-wSTzq_awPSO5w0Gr_c2zyg-1; Mon,
 29 Jan 2024 10:31:26 -0500
X-MC-Unique: wSTzq_awPSO5w0Gr_c2zyg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7507E38143A9;
	Mon, 29 Jan 2024 15:31:26 +0000 (UTC)
Received: from [10.22.16.145] (unknown [10.22.16.145])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E637040C122E;
	Mon, 29 Jan 2024 15:31:25 +0000 (UTC)
Message-ID: <b579db5a-bc4d-49e3-a467-a3a32fa5d2a0@redhat.com>
Date: Mon, 29 Jan 2024 10:31:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/3] nvme-tcp: show hostnqn when connecting to tcp
 target
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: "Nitin U. Yewale" <nyewale@redhat.com>, chaitanyak@nvidia.com,
 linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
 loberman@redhat.com
References: <20240129110639.45542-1-nyewale@redhat.com>
 <501724df-de9a-4b74-bdee-eea7c3507f51@grimberg.me>
 <Zbe__KROwAeKO6oO@kbusch-mbp>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Zbe__KROwAeKO6oO@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_073326_021248_67DA5E75 
X-CRM114-Status: GOOD (  10.26  )
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


On 1/29/24 10:10, Keith Busch wrote:
> On Mon, Jan 29, 2024 at 04:18:14PM +0200, Sagi Grimberg wrote:
>>
>>> Log hostnqn when connecting to nvme target.
>>> As hostnqn could be changed, logging this information
>>> in syslog at appropriate time may help in troubleshooting.
>>
>> hostnqn is available via sysfs, why do we need to log it?
> 
> I personally haven't encountered an issue where these patches would have
> helped, but sometimes a dmesg is all you get with a bug report.

Yes, exactly. dmesg is the first place people look and often times it's the only thing available.

Reviewed-by: John Meneghini <jmeneghi@redhat.com>


