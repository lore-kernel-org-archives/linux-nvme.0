Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A5BC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 13:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=afci6CJ76Zp6xoepc357nE1IL04qiOxBOsa2LoqZWNY=; b=RiR6UNzYI1kvrPGvZR8zdTuAnX
	6mNuf4cKDArszegtb49/Fkp5B3F91ptUJNqhLlzZOwIT5pdAAFM382HsxOgkZNrDLG/7GYKQMY/wI
	aG9vdqDI6vq4YfdcfdNQiGBCmVtu7mVJERg+fbHbNgLi+/xUU6TtwnTbQCQOolQgn0zE9E/7zL4os
	bqo9QwTEeatzScnH7rTtOJhTo0YDc49o7s5chiQVzjQFJvgel46IpVoL2264I8/twjFrAnjMKtS6/
	uXN+gFO98qu1aqaI0feorr3yQWEvMftxcb6w8DTT+7uGODvZBDVZCauXWhEF7+EWqKegeuxWl4hsQ
	i/v1rHAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA8iV-00000006OoQ-2yIt;
	Thu, 23 May 2024 13:42:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA8iT-00000006Onx-2DSo
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 13:42:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716471763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afci6CJ76Zp6xoepc357nE1IL04qiOxBOsa2LoqZWNY=;
	b=d/uPAAe8doUvWK2E13JDk8cmBssbX3AFNZ2OpzopemxpZ4Ccu8XY/XqxhO8LyWjUyhEAwN
	nsmYYLN3hQvVVAVY/To5AXFJT9DUF0T8dNGN+LeUmKSLXLO3c/kb2fQQzGHpm71k3FYh/K
	QYDO3RqsWD5uysbHZQ61a7goSy3vuLs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157--11Nvb4yOCmLIs3x9nbQrw-1; Thu, 23 May 2024 09:42:40 -0400
X-MC-Unique: -11Nvb4yOCmLIs3x9nbQrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD12A101A54F;
	Thu, 23 May 2024 13:42:39 +0000 (UTC)
Received: from [10.18.25.182] (unknown [10.18.25.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6531828E2;
	Thu, 23 May 2024 13:42:39 +0000 (UTC)
Message-ID: <4d90d565-c156-4e4c-8a16-f32aa73fc809@redhat.com>
Date: Thu, 23 May 2024 09:42:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>, "emilne@redhat.com" <emilne@redhat.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jrani@purestorage.com" <jrani@purestorage.com>,
 "randyj@purestorage.com" <randyj@purestorage.com>,
 "hare@kernel.org" <hare@kernel.org>
References: <20240522165406.702362-1-jmeneghi@redhat.com>
 <935f7e10-ccb4-4891-8f29-84909c061e7a@nvidia.com>
 <60758e4d-4bdc-4a99-a151-a9009a8a460f@suse.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <60758e4d-4bdc-4a99-a151-a9009a8a460f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_064245_664411_A5699051 
X-CRM114-Status: UNSURE (   7.70  )
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


On 5/23/24 02:28, Hannes Reinecke wrote:
> As presented at LSF by Daniel; ALUA support (and, with that, multipath 
> support) is one of the topics to be implemented for blktests.
> And without that we can't have a meaningful QD test.

So as a part of this patch you want a blktest that verifies queue-depth multipathing?

Or are your just tying acceptance of this patch to a blktest that tests multipath testing over all?

Seems to me you have a patch designed to do that...

https://github.com/osandov/blktests/pull/114

/John


