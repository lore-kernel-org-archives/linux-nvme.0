Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4598EC71136
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 19:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o/kCCEam7x/8zUbez+utqgmB4o0YyAg/VynA3QdbuUk=; b=SYEIhR7rtezOOUcxk9MCFGmw8n
	5HsUv3RyDvFDL1h30T4W0FnD/nj96j073vOoIu7JrB8EMlqfj/mfQ70g2UASOgmPMlBkn2CQxAJko
	TrhPUU3vvzatJ5s1Q8pxxOpHbZgrBZ8oJO/a8hrQb4diI1AGteROusAmmm7UIgBQlNFaXZwguFhD9
	00ffE+U9W5ErsNHB2j9JfWRUmN/TG7ME7AxiqmErqPWXkbHcTJqLwDnp6fJlMCJbUONfwFF7I/VEJ
	8GrSPwurEWZj1/QtRyJ6TrQcrAUUcxOqG1vzzNRHNcOQKypAhdqRam+0YkhNG9Yd6QGct/gwSlpnv
	hKdkOvYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPRXW-0000000B2qu-2GjN;
	Wed, 11 Jun 2025 19:55:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPNKN-0000000ANex-05rg
	for linux-nvme@bombadil.infradead.org;
	Wed, 11 Jun 2025 15:25:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=o/kCCEam7x/8zUbez+utqgmB4o0YyAg/VynA3QdbuUk=; b=g98N187zA2qIjDGp8WsoBoXmr1
	PubX53DMnWOgpb3ocZkkIFQjBqZRx8U75K9JMbtayKP35VvtiD6e1WBA2M0N4imPmMi26mJarMEd1
	5VlI44p5okI+F3r8MzpYN7wIvV50tAyH8Mt01YkFIRwtQCtrU2jvO7oGYRTrjQ1kVop79yCqgv1jE
	Ppr6LPOAHHQhDnPENzWFRwDhP6nhFTygRxg43C+A7PGVMnZR2bna6IQlyKWnSS1UBsYF6As9SmLkR
	wwXMeJP1fM4vVp//vXoCBG5bBOkd6nMzJDnbitpLmFovDhv+BWKIU1NY6dQPWgk1MNMMZNJrNXNpm
	TEvePVBw==;
Received: from 003.mia.mailroute.net ([199.89.3.6])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPNKK-00000002QPb-0ojh
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 15:25:22 +0000
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bHTxD0shbzlgqVW;
	Wed, 11 Jun 2025 15:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1749655500; x=1752247501; bh=o/kCCEam7x/8zUbez+utqgmB
	4o0YyAg/VynA3QdbuUk=; b=jLvq96ouC1EYZUeID7YXt/1M0bRSdf8h86uWKZ15
	XLti0O5Fi53JDfmOUKcG0jpc5nKew3nwtrGwMuQZolHZkXs6c/XuC/8YwyedvObZ
	rKLY/4gXm47PKauc+uXhsGCwOuMNz/170pJ6OM8I84plJujAeYmsjgNcWU0MZc4i
	5zaIuuBTYbmuihbtMv+BA5Hs3TyJ5G1mh3A10pCBeXZ7MFjehJlWKGc0FxCLUK75
	uvEpjEyZeNZPgFLkVHHSbkxFBDHRmubEG+mOYjAeZAS/oP8qfhfE57CMaE/MVxPq
	FOvF86oNvMS03kM3Teuk/6CeJiVNFxN+injUXQAsLedjmw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4NXAhfY5d2U5; Wed, 11 Jun 2025 15:25:00 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bHTwv59NczlgqVK;
	Wed, 11 Jun 2025 15:24:46 +0000 (UTC)
Message-ID: <79d40bb9-ec40-415d-80eb-4ae8ab150737@acm.org>
Date: Wed, 11 Jun 2025 08:24:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "block: don't reorder requests in
 blk_add_rq_to_plug"
To: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Cc: stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Hagar Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>,
 Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20250611121626.7252-1-abuehaze@amazon.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250611121626.7252-1-abuehaze@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_162520_680671_CEEFBD58 
X-CRM114-Status: UNSURE (   7.59  )
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

On 6/11/25 5:14 AM, Hazem Mohamed Abuelfotoh wrote:
> Given that moving plug list to a single linked list was mainly for
> performance reason then let's revert commit <e70c301faece> ("block: don't
> reorder requests in blk_add_rq_to_plug") for now to mitigate the
> reported performance regression.

Reverting that commit would break zoned storage support and hence is not
an option.

Bart.

