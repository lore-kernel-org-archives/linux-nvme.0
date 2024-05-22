Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357CAC25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 17:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aA3DKznaBT1BfNeUkAE6FwQ0W4IHdJ7XzpJGKtXI/6s=; b=wVsMgVUjrt6fIPQODvoc6TO6pw
	8Csjkl3MiPtCQ2B854puZ/k3VuQ3kB/aJdFjx+V5ZVTGHu2M4gmoIflDUQmAfKlJMBZinr8OwB3QL
	8e0i1WDR8OTh4S3pGoQufxH9xybs7doCMcaCsnMKQrMUUpPEU2gqz+WfPLB2FgKvaiTMZduZ+mPfQ
	QIASe0VsrL2tNDrUMYaxfIlupPvKE8gzZaXG/sssvISqp0dvVi1XmGTjsL0EdW5yq/DjNJsEBQs+S
	pdZlWPs6OjrtmR3oqk9908qIN8kK3oIPUDSfXITgVZ/WKRQ1sD6f7OdRN+pb4JgKHunvIo2P0oSaI
	YzGaSNog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9q8b-00000003iOB-0Mj1;
	Wed, 22 May 2024 17:52:29 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9q8Y-00000003iNZ-2eaQ
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 17:52:27 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VkzQy08jwz6Cnk9V;
	Wed, 22 May 2024 17:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716400336; x=1718992337; bh=aA3DKznaBT1BfNeUkAE6FwQ0
	W4IHdJ7XzpJGKtXI/6s=; b=p2pHGKlTGN1n79gxy2b/GyEl+HkP0bgyc2UeYFM/
	GXSzKzNN1hhVyWYWt36+Lp/wge77YnUp3UTBQCCs5mnMacRLMOcgij5X6fN65Wej
	8KE9Kc0EFuDdd4BXiOu3B/ASQKyk8frkif00MA86DIrCWQvv4TL86jA6U4fYWUZo
	pAeT3gs6lohVfoM8VXD757F87uEZlLe8RGe3dO6Y619fpHFuOke+evLOcDOq98DH
	RTyPuQLqHjXoK/xBROHDvP9Iy+XKZ1Mj4yQ1DKWMguuVjseOFLaV2CCHYGnIZaV4
	Lgjk/nUaA+7ZTeyoDv8HIjuDr+QSK8ehLX5M3WFoaFZOXA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SYpxkEZJmixc; Wed, 22 May 2024 17:52:16 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VkzQg1dXmz6Cnk9X;
	Wed, 22 May 2024 17:52:11 +0000 (UTC)
Message-ID: <631c55b9-8b0a-4ac0-81bd-acf82c4a7602@acm.org>
Date: Wed, 22 May 2024 10:52:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 12/12] null_blk: add support for copy offload
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, martin.petersen@oracle.com, david@fromorbit.com,
 hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
 Vincent Fu <vincent.fu@samsung.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520103039epcas5p4373f7234162a32222ac225b976ae30ce@epcas5p4.samsung.com>
 <20240520102033.9361-13-nj.shetty@samsung.com>
 <2433bc0d-3867-475d-b472-0f6725f9a296@acm.org>
 <20240521144629.reyeiktaj72p4lzd@green245>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240521144629.reyeiktaj72p4lzd@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_105226_712349_6C21BFEB 
X-CRM114-Status: GOOD (  11.66  )
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

On 5/21/24 07:46, Nitesh Shetty wrote:
> On 20/05/24 04:42PM, Bart Van Assche wrote:
>> On 5/20/24 03:20, Nitesh Shetty wrote:
>>> +=C2=A0=C2=A0=C2=A0 __rq_for_each_bio(bio, req) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (seg =3D=3D blk_rq_nr_=
phys_segments(req)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
ector_in =3D bio->bi_iter.bi_sector;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (rem !=3D bio->bi_iter.bi_size)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return status;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
ector_out =3D bio->bi_iter.bi_sector;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
em =3D bio->bi_iter.bi_size;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seg++;
>>> +=C2=A0=C2=A0=C2=A0 }
>>
>> _rq_for_each_bio() iterates over the bios in a request. Does a copy
>> offload request always have two bios - one copy destination bio and
>> one copy source bio? If so, is 'seg' a bio counter? Why is that bio
>> counter compared with the number of physical segments in the request?
>>
> Yes, your observation is right. We are treating first bio as dst and
> second as src. If not for that comparision, we might need to store the
> index in a temporary variable and parse based on index value.

I'm still wondering why 'seg' is compared with blk_rq_nr_phys_segments(re=
q).

Thanks,

Bart.


