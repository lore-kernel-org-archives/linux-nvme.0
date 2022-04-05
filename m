Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCDFC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jvRrnqhBMA3YRHJ5fCx+BILS/+sa4pypHGR3I/MBaJk=; b=Z9cBDzEpNhrfjFaZl6Pd3RvYS0
	7fYAM2kIJipIqhFKKs8DXkvunr+nNn+D9A/V7MqgOoFEl99rPunpOeqkePepRqh6UCVBLNu/EK11E
	RCNj8WPQqPA6gDdKJuERF99HtZdJP7hbCuI1sYJ90/kCh+ya1i+OvGQl9gxdMxF+s8XGQfwFvoJrZ
	VegGF6BbhoBkKkhjEaoNS3+VJYDxdu3FBVPMrQO6F5vWBXGY19SK+A4yvcuKcY7s0l/gWNT53mXzl
	MrFr90UHgRcwgiKGGSVeJ40/Me33oA7AsbLzP5YhXn3X2+icjS7Uz2+nW1AEKt+6uQQZRkXTt+RbJ
	RMhMiejQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbj27-0016Wm-6e; Tue, 05 Apr 2022 13:15:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbj23-0016Tt-Kn
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 13:15:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649164538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jvRrnqhBMA3YRHJ5fCx+BILS/+sa4pypHGR3I/MBaJk=;
 b=Oc1oKHKyXWTnE0qnusnEunSBPOQO3GwV3n5w1Ra8g8UsXHwlKhOJWnki7DUdBzo+qUZ40k
 35hXjutGGbFGlN66WKzjzpau03hej/yoP3X3OOBwqITuAPFwXMfU5mlmNJnV3G5VT4Xq0w
 IJ3rhX/QcNJRxXewl59JzpJ2V36gQV8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-V21GoWxWPAOyBT9AwHOL3g-1; Tue, 05 Apr 2022 09:15:35 -0400
X-MC-Unique: V21GoWxWPAOyBT9AwHOL3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF8E31C01E81;
 Tue,  5 Apr 2022 13:15:34 +0000 (UTC)
Received: from [10.22.18.217] (unknown [10.22.18.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F03A111CB8E;
 Tue,  5 Apr 2022 13:15:34 +0000 (UTC)
Message-ID: <8e4b4209-4134-c4cb-95c0-21f0b7fde0d3@redhat.com>
Date: Tue, 5 Apr 2022 09:15:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/3] nvmet: make the subsystem type configurable
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-3-hare@suse.de> <20220405054740.GD23466@lst.de>
 <3d773039-ce36-277f-34c5-e0530567c4d3@suse.de>
 <20220405060946.GB24073@lst.de>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20220405060946.GB24073@lst.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_061539_778218_EDD28F52 
X-CRM114-Status: GOOD (  11.43  )
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

On 4/5/22 02:09, Christoph Hellwig wrote:
> 
> I don't think we need to remove the well known discovery subsystem. But
> we can allow removing all entries from it and thus reporting an empty
> log.
> 

I agree. This was exactly my vision for how things should work with TP-8013 and TP-8014

/John


