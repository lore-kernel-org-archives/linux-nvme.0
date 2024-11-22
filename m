Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3906E69185
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 17:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RstFT4v1FTwGEZ6DtgUQEagwPEudbwO0pMDPcVbX3L4=; b=YIOJ7SH7m+7LBSMp3G2qlKAK+3
	MnMWz4/bGen484/h8hwJo7JLqzZGW8+6cLPmU9/iJxIRk97M/uD+3AFbR2pEhf/8j+Ym/7VdCvlyT
	XXlLIU1ggqaXdb1CLWxdNLMpf+o37OoBIJwviaITO8Rm9n7VGXmzSnLLz7147gOZ1zkHWKF914o3e
	+c8iFO7Zpo/uPtD6uwqQsACPIawBZceYvwCsEFfmuaHM2Oo0pon+wRTcFobilyPTsufzFxS9GQLUF
	bF+Zjw+0ZswnDEcIjblhEmYkuvPYiNDpuaF+bwerJnXF8QT28Udr//mBA/61oOq5B+UyYx4Ny6E3z
	d4v1c9XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEXq6-000000032Mv-0yL5;
	Fri, 22 Nov 2024 17:53:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEXq3-000000032MZ-2oJt
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 17:53:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732297982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RstFT4v1FTwGEZ6DtgUQEagwPEudbwO0pMDPcVbX3L4=;
	b=BPG1w3soi25IVBR7HJNavRnrA0O3ER8Tj+X4LKeHTmVzC6yvqk90txWuyHnTyv7ET7Uzy6
	9TXnJWLRl0i/09H3HAya8UnLLhChKX9S+is9RFYR4q5/VIWoh5R5+e5AaNWz26awGWP5AE
	POQ+BSnMwSczKwwTbTX4SxpWxWaS/j4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-RztWJB03Ok2WATAY3rE3eQ-1; Fri,
 22 Nov 2024 12:52:58 -0500
X-MC-Unique: RztWJB03Ok2WATAY3rE3eQ-1
X-Mimecast-MFC-AGG-ID: RztWJB03Ok2WATAY3rE3eQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3596019560AF;
	Fri, 22 Nov 2024 17:52:55 +0000 (UTC)
Received: from [10.22.81.129] (unknown [10.22.81.129])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1195119560A3;
	Fri, 22 Nov 2024 17:52:51 +0000 (UTC)
Message-ID: <4bd8f843-6dfa-4c66-9e42-cf4245166844@redhat.com>
Date: Fri, 22 Nov 2024 12:52:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: always enable multipath
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Bryan Gurney <bgurney@redhat.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@kernel.dk,
 mpe@ellerman.id.au, naveen@kernel.org, maddy@linux.ibm.com,
 kernel@xen0n.name, bmarzins@redhat.com
References: <20241121220321.40616-1-bgurney@redhat.com>
 <20241122120925.GA25817@lst.de>
 <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_095303_780301_9E7ACFD0 
X-CRM114-Status: UNSURE (   7.72  )
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

On 11/22/24 10:39, Keith Busch wrote:
> Anyway, we only use the one physical function, so they're certainly not
> multipath devices here. We disable the CONFIG option because while the
> nvme multipath IO overhead is low, it's not zero.

Do we know what the performance impact is?  Has anybody measured the difference?

/John


