Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CB6C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 16:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/BzemWBtc0TeP34laM8MtrN8mHgGRvRTcRB7Cd5shEM=; b=05bF1+Nnv7Cc6iwff4afTcP6Ak
	jyFoQ0A0glqNLVvHiRS5Szno9UX+Yun/5zJB4bW1fMXRH8teqy83zKyO+UTjwcmz3Hf9Tuvc3+O5Z
	twP7/+mfkq2iseiYB1/Fg55e0f/0XkvGLnJazG3Sy3HBJwZrlFwTQ9D0NQfouCxBcCm2BH0gKE2eF
	Y8guV9SyYUfG4fYH7VE5nMYRcFJL23/YmLRMbxdOPsBlTsSvzeKFTiy3R46fiW81DeUIrrL+8S4SQ
	DEYfHJtHyjKDLo8K9DH1p3YGydD/fXhSRtQYFvDCrk2cHTOva0qj1lMWHyzH/XxSoM2gAeAuz+nbE
	atbiKUyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0lt9-004Lvx-2a;
	Wed, 08 Nov 2023 16:58:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0lt6-004Lux-2J
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 16:58:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699462721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BzemWBtc0TeP34laM8MtrN8mHgGRvRTcRB7Cd5shEM=;
	b=OsOoywt0hjfZRt+RdUYNr5jByVyldkwQgEhA+L8XGAN4wrtouz1XaBXGQ5AjI7ZAZYdGsk
	w+EZ27VUzliy2N5OL0S+p09s2EsQZ37B9iCd5TZVlTbPXPW5fk9DF65j59xXF8CmiKNo/i
	GSMWMBP/glTPoFSLGKyh3aFrSUU446w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-C_Q0W_bVMS-yOXLFW9kZvA-1; Wed, 08 Nov 2023 11:58:39 -0500
X-MC-Unique: C_Q0W_bVMS-yOXLFW9kZvA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35AFC185A781
	for <linux-nvme@lists.infradead.org>; Wed,  8 Nov 2023 16:58:39 +0000 (UTC)
Received: from [10.22.10.156] (unknown [10.22.10.156])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 134C41C060AE;
	Wed,  8 Nov 2023 16:58:39 +0000 (UTC)
Message-ID: <86d4f9cb-f041-4e1a-9294-f410ab094fa1@redhat.com>
Date: Wed, 8 Nov 2023 11:58:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme: multipath: only update ctrl->nr_active when
 using queue-depth iopolicy
To: linux-nvme@lists.infradead.org
References: <20231107212331.9413-1-emilne@redhat.com>
 <20231107212331.9413-2-emilne@redhat.com>
 <ZUqx7JoyPG1QxYeY@kbusch-mbp.dhcp.thefacebook.com>
 <ZUtCPeDYRaGszXnE@infradead.org>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <ZUtCPeDYRaGszXnE@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231108_085844_830681_BB494B72 
X-CRM114-Status: GOOD (  11.59  )
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

On 11/8/23 03:09, Christoph Hellwig wrote:
> But I'm also pretty deeply unhappy with the whole thing. This is a controller-wise atomic taken for every I/O. How slow are the 
> subsystems people want to use it for?

This would never be useful with PCIe subsystems which all have latency/response times in the 10s of microseconds range.

This is really only useful with Fibre channel and TCP attached subsystems. We have several enterprise class storage arrays here 
in our lab at Red Hat - all with multiple 32GB FC and 100Gbps TCP connections. Based on our own private performance analysis of 
these devices they have latency/response times in 10s of milliseconds range... at best... and the performance bottle necks are 
in the storage arrays, not in the fabrics. Even some of the RDMA attached storage arrays are slow. These devices have trouble 
scaling up performance... so they they scale-out instead, adding more and more paths and controllers to different domains in 
their subsystems.

I am not concerned about the addition of one atomic counter with these use cases. In a grand scheme of things, when using an 
nvme-of attached storage array, the trade offs are worth it.  Besides, if you've dived into the TCP socket layer you'll see 
there are plenty of atomic counters in the data path already.  This is the main use case which needs QD scheduling - nvme/tcp - 
where latency can build up in the connection as well as in the storage array.

/John


