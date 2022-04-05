Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC87CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 15:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=037kz7YUrLc1n0MobI+vhJmlnLffRq+GdkChuaN8n2I=; b=OYlboV42YbG2FBQilBsBMY84+E
	HBUeQEK74LmTiKdnapxu23KqmKdZg9nTrLZnuVSGotLEpUUsDuQw+U/uDifdrLp2jv15zd5qguNPt
	OnPzbpEuOKKI14bRwUzG+KrL0CEcFRm2WQd1ePjoYXfqjNh8iCxIuRaU06mkoFiv+FqtDYbW9E0Gz
	vSSO5RXhj2a4JjYeYnWLA6dmUlW9EvLFi+n6X2wRIRuSHnDzJ+6adFsolx6KHeVrkB6loqlsncQUV
	FhmGTNo9dv+T3O8lUKGbMi/JPy5gsRvtynEg6h8epUL9qwZGYURJj/zIX/C5Y7fg26juC44q4RzUv
	Ez22dCdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbkoo-001cVn-6o; Tue, 05 Apr 2022 15:10:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbkok-001cU0-A6
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 15:10:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649171401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=037kz7YUrLc1n0MobI+vhJmlnLffRq+GdkChuaN8n2I=;
 b=JFdtm7J/7CKj5EX5RY8sXYJ7e8kO1BQqYG0uD6iNkBEFjRA/IPvEXef4gKohJ1Ro+9FOwX
 BiW1rhseDe5ZTLZS0ltqVdHVX2SznHcJYer2F+9dnT/UxbUzwB+oOSxMaLJrx+hr7tRmqx
 Qfem6fhWl3YXUMOuX6pBpxE7FPsj5G8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49--IOQzNr-Mt-LrGTw8sokRQ-1; Tue, 05 Apr 2022 11:09:57 -0400
X-MC-Unique: -IOQzNr-Mt-LrGTw8sokRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8EC0899EC1;
 Tue,  5 Apr 2022 15:09:56 +0000 (UTC)
Received: from [10.22.18.217] (unknown [10.22.18.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCBCE40CF8E5;
 Tue,  5 Apr 2022 15:09:56 +0000 (UTC)
Message-ID: <ba2cce05-c7d5-b51a-a796-3223ef67aadc@redhat.com>
Date: Tue, 5 Apr 2022 11:09:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in discovery log
 page for unique discover controller
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-4-hare@suse.de> <20220405054601.GC23466@lst.de>
 <a129df40-6195-8b59-aa76-e3053e0960fd@suse.de>
 <20220405061941.GA24290@lst.de>
 <366e9acd-23c8-f8bf-2671-9187f3c0ce96@suse.de>
 <20220405073121.GA25524@lst.de>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20220405073121.GA25524@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_081002_679410_8711B4DA 
X-CRM114-Status: GOOD (  13.43  )
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

On 4/5/22 03:31, Christoph Hellwig wrote:
> 2) (optionally) make the well known discovery controller go away
> 
> Just renaming the subsystem will make the well known one go away,
> but while that can be useful for some use cases, I think making it
> always go away has the potential for breakage.  So maybe we need
> to not rename but be able to create an alias and have a way to
> disable the well known discovery controller if not used.

I agree. I think making the well known discovery controller "go away" will have huge problems in a multi-vendor fabric. We 
really can't touch the well known discovery controller because there are too many legacy and non-TP-8010 compliant NVMe hosts on 
the fabric.

We have to assume that both new and old implementations will coexist. And legacy hosts will NEVER look at the new, unique 
discovery NQN because they won't even recognize the new NVME_NQN_CURR log page entries.

/John


