Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4270C25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 17:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y82gHOSBDAaIbjj/OTmygzVjJRYdomrp2Yr813oI4eg=; b=twW+oTQjeKgDwvqrtH8R6gtboT
	fpP1yR+VpIu3WWv5hERXEXC1LUpC+DP7AXD2Cu3fcX0AJr1bzXav4A2+J/h3xwxJwuQxN0TWtiXOt
	IBAHKuD/X07kDq3SKw43jG8IEbciKVrLwE2mvsOsskzv6h/YQhgvNbCsijXgbyoMIdp1zGZSh03o9
	1vYFwOxheDJthglOD2FfcFCKm/bKHr3VGFM1xt1PesXjbvl4jiYcZfvMVJs3IohOA0HrsROrLyGE7
	D1rSrURi7G2qIYV3Hkvo8NUtlxKronPjNlOiI+AtnpWWABE5OpSw5lAN/hn9m2F0jxOv/Nq6FcYCN
	BwS3enPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9q5e-00000003hkZ-1Nxd;
	Wed, 22 May 2024 17:49:26 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9q5b-00000003hkD-0q9A
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 17:49:25 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VkzMN4FYyz6Cnk9W;
	Wed, 22 May 2024 17:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716400151; x=1718992152; bh=Y82gHOSBDAaIbjj/OTmygzVj
	JRYdomrp2Yr813oI4eg=; b=I8jCgEEs6RWhiaz3FOJ4qw6gwFlxnoo6V4I5ICCN
	B5iRUSrU9bDloP1vUs/ZZRT1c6mbr95AFTkXe93u3OnQUfIFrTz8PTmpidYdbu7S
	0Bg3sgdGkeJMtnBddXcOirP1nx1xBrwmSxOhJATHwYJv/cFB1VNg9FXMu8ZSUGq2
	ee9Oidgxj3+Es0TMkPh1+qnqp5rL4XfUlOwukJ/fgpJoJCS1yfDy2K5z4asOizgM
	NlJtvReL+/iJDMukLD0QK96UB3R+vdoRu/ncZFDz9DH/zX+r9h8Uu5q7ilNjr38V
	IHwEowjgHCSLcLltTrVv87ydDlAD/tm6VjB9NOXZFga0Tg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cGFB4tzVV1GF; Wed, 22 May 2024 17:49:11 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VkzM86DnRz6Cnk9V;
	Wed, 22 May 2024 17:49:08 +0000 (UTC)
Message-ID: <174d4908-b81c-4775-9b99-b0941451cb0e@acm.org>
Date: Wed, 22 May 2024 10:49:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
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
 <CGME20240520102830epcas5p27274901f3d0c2738c515709890b1dec4@epcas5p2.samsung.com>
 <20240520102033.9361-2-nj.shetty@samsung.com>
 <d47b55ac-b986-4bb0-84f4-e193479444e3@acm.org>
 <20240521142509.o7fu7gpxcvsrviav@green245>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240521142509.o7fu7gpxcvsrviav@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_104923_284067_6885359B 
X-CRM114-Status: UNSURE (   9.92  )
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

On 5/21/24 07:25, Nitesh Shetty wrote:
> On 20/05/24 03:42PM, Bart Van Assche wrote:
>> On 5/20/24 03:20, Nitesh Shetty wrote:
>>> +=C2=A0=C2=A0=C2=A0 if (max_copy_bytes & (queue_logical_block_size(q)=
 - 1))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>
>> Wouldn't it be more user-friendly if this check would be left out? Doe=
s any code
>> depend on max_copy_bytes being a multiple of the logical block size?
>>
> In block layer, we use max_copy_bytes to split larger copy into
> device supported copy size.
> Simple copy spec requires length to be logical block size aligned.
> Hence this check.

Will blkdev_copy_sanity_check() reject invalid copy requests even if this
check is left out?

Thanks,

Bart.

