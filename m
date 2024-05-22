Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36101C25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 17:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/fUnCyL4rXX2AQtUspHQvGeVSI9WBvUN5ojnjLO8HQA=; b=OpON4TA2RgeMDsm+0IcNtMG87N
	GkiUqGEQbk4I2R6bdn5GqEh8fVHHPg0vOcCU7ZQSDhZY7NQT90VUGZMA4DEmqykhUazGwYAddRBlZ
	xdl36peJRqHI0YadUTrsIQsfNz1GcDf1XIPdA7+vGvR8U7gRKOK24dkCRR0zQv5X5+iC1DvnVPXY6
	sc/1va0gjry+PxxBOmeRSiEIQQZRMhn02zysPLrfNQYpXYyUVS7kABv1Hok9bE0jOVfl+JDYjJPCi
	AYIz9SLJ3yy6Wb70pjMCzm0Dr2ZbLObuKofdyNWvf3iiWoivr6Itf37tnI63dmzJCEEQ6Gdjj1egZ
	hcu3OG6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9qEl-00000003j9r-2sRB;
	Wed, 22 May 2024 17:58:51 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9qEj-00000003j7y-0rIU
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 17:58:50 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VkzZF3LmfzlgMVN;
	Wed, 22 May 2024 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716400717; x=1718992718; bh=/fUnCyL4rXX2AQtUspHQvGeV
	SI9WBvUN5ojnjLO8HQA=; b=2NXb5bWGOG3VkvoOW/1AJ/knPpCcKds88i+1padz
	gFfE5fJ7PzdLZoQbo81PtZWYvVj1Q2FaHh1UQLiTDNI2ukoCNAbJ+Nl4g0u0NxC1
	VFMGvH9ZW6chjnwY+pnV3bx1kPOLj3pBNscI2CIVjtcFel083RWJglTIwGpbB4pJ
	bJhkKlRV4JZQ+dsHgKmxqRXb6ji4hq4XRfi27/mhn23bow5S9+pZ6h5Fg3QEfT+b
	2LzHrguzq2mNP2MJ9Y2iMxIvL5pwEWYwp0kdwPm7JldrbYn5lI2FL0SSqRhARbEU
	uLSMvifOyC0AND8nUQGjb/uPQ0TgHhjqr9UemL6WR7fA0Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9NZjL2GE8PQb; Wed, 22 May 2024 17:58:37 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VkzZ21dlYzlgMVL;
	Wed, 22 May 2024 17:58:33 +0000 (UTC)
Message-ID: <53b30f65-6b0f-4c05-8372-023e5e61a035@acm.org>
Date: Wed, 22 May 2024 10:58:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
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
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
 <086804a4-daa4-48a3-a7db-1d38385df0c1@acm.org>
 <20240521111756.w4xckwbecfyjtez7@green245>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240521111756.w4xckwbecfyjtez7@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_105849_366088_4ED843C5 
X-CRM114-Status: UNSURE (   8.45  )
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

On 5/21/24 04:17, Nitesh Shetty wrote:
> On 20/05/24 04:00PM, Bart Van Assche wrote:
>> On 5/20/24 03:20, Nitesh Shetty wrote:
>>> +static inline bool blk_copy_offload_mergable(struct request *req,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 struct bio *bio)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return (req_op(req) =3D=3D REQ_OP_COPY_DST &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio_op(bio) =3D=3D REQ_OP=
_COPY_SRC);
>>> +}
>>
>> bios with different operation types must not be merged. Please rename =
this function.
>>
> As far as function renaming, we followed discard's naming. But open to
> any suggestion.

req_attempt_discard_merge() checks whether two REQ_OP_DISCARD bios can be=
 merged.
The above function checks something else, namely whether REQ_OP_COPY_DST =
and
REQ_OP_COPY_SRC can be combined into a copy offload operation. Hence my r=
equest
not to use the verb "merge" for combining REQ_OP_COPY_SRC and REQ_OP_COPY=
_DST
operations.

Thanks,

Bart.

