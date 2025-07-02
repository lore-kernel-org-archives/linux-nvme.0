Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101D7C8303F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 12:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tBnrOP39/YHMg379iuhBknpPNdTzhB6R9BXWq9gnkkM=; b=YB9ctq3X5EfGDGgs8r4k4io7hz
	zn/naoFEnEP7Jn8962jxfNIdIy5bw0cuk2d3zVomNM/WI8c58SEBFDAsZQZSG0i3/I9oApRTn7H8L
	/mXygSIhuy6EIhEmsG4LTwQtXEj+uNnUIPulv0hqKAR3s1c+w41D/2Cs2iI6FFO+EdQ7yQsWYxkWH
	quHoMYO59zDLZUR6XBma7kE5Af1J8bK5pIAhlmMvrZ/bZjqPbBiVeei1h3xVTLhEkputPoomvjRqn
	svEaHeyGa3GPElb7VwLnmmXCR6gZJCogZU9ibjOl8rttr7j+eK58DeQmpSINIw+B0+4V3ESyN/vjC
	Mz4Rd5zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWwqT-00000008LaR-11ZT;
	Wed, 02 Jul 2025 12:45:49 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWwVA-00000008Igd-0g4O
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 12:23:50 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 06ca3d98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Jul 2025 14:23:43 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Jul 2025 14:23:43 +0200
Message-Id: <DB1KENKTV6W2.JFTZUV550YNB@bsdbackstore.eu>
Cc: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-tcp: log TLS handshake failures at error level
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Hannes Reinecke" <hare@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <linux-nvme@lists.infradead.org>
X-Mailer: aerc
References: <20250624163930.104848-1-mlombard@redhat.com>
 <cbe6682c-345b-4807-acd0-5f83ea7df0b7@suse.de>
In-Reply-To: <cbe6682c-345b-4807-acd0-5f83ea7df0b7@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_052348_549114_86D0B0C0 
X-CRM114-Status: GOOD (  12.78  )
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

On Wed Jul 2, 2025 at 1:34 PM CEST, Hannes Reinecke wrote:
> On 6/24/25 18:39, Maurizio Lombardi wrote:
>> Update the nvme_tcp_start_tls() function to use dev_err()
>> instead of dev_dbg() when a TLS error is detected.
>> This ensures that handshake failures are visible by default,
>> aiding in debugging.
>>=20
>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
>> ---
>>   drivers/nvme/host/tcp.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index d924008c3949..26d26823a0c5 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1745,9 +1745,11 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *n=
ctrl,
>>   			qid, ret);
>>   		tls_handshake_cancel(queue->sock->sk);
>>   	} else {
>> -		dev_dbg(nctrl->device,
>> -			"queue %d: TLS handshake complete, error %d\n",
>> -			qid, queue->tls_err);
>> +		if (queue->tls_err) {
>> +			dev_err(nctrl->device,
>> +				"queue %d: TLS handshake complete, error %d\n",
>> +				qid, queue->tls_err);
>> +		}
>>   		ret =3D queue->tls_err;
>>   	}
>>   	return ret;
>
> There still is a value in knowing that tlshd is complete, so maybe
> something like


Ok thanks, will submit a V2.

Maurizio


