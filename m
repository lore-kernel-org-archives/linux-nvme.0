Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C80C25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 23:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zkochTf1pJt/Am6auJvVyeUO0m/clb0l/O7D9nMG788=; b=a/BMCJyYSv6BA8S6UmyJs1uAtu
	CkxA8cqCgYxr73fszkoNFBhLmYQFwSW7ofpJKXKEWEOVrthD7UjhGL98KB+dNmKLMsX8ZB9W2g6fC
	QTZ7n5ZyYtvtchZgtBKjQVm0Z4r9v2aVvw/nu6fRSjadjiiYWjnGX4mq8tDzqt0kxLb78HD43pLsn
	0HcPD/sT1oaXTLc866mpyliZHsQOTyM2z5AgH1FONcEMu97t5IpuTsWaf8BArcovUcMfJBJo6+7qH
	7asRVL2yzrzznRKYQst0SLMhEDriK5wEiUXpaZr0H4MioKHzMyupgCxl+udofwa4zeO7WkkNmyAWw
	7PokNZZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDBw3-0000000BhZK-3kie;
	Fri, 31 May 2024 23:45:23 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDBvy-0000000BhYt-1sGR
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 23:45:21 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vrfqw2d4jzlgMVh;
	Fri, 31 May 2024 23:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717199108; x=1719791109; bh=zkochTf1pJt/Am6auJvVyeUO
	0m/clb0l/O7D9nMG788=; b=ZklNmP1YJ5I6wZoLhUGC2GqLb9lFFx6n2ktRI1Kx
	Nl7eRqzK72L7iylss28HRyQRn55MXa33iQtDbhVYdGuOsrbsfxQUH0MQI/q/83NC
	naGlUr7nOXCs+ynUYr7Us7SG/yw/CDkSBGpU6kffWxO+L13RE1xW0d+wScKyYd5C
	8UbYw7VREWul20bnYqKuPoFAWHgcTgTfaYNDtti/zlVZ3sPgIwaaIQqSPOY35Vzl
	fKeYl7k4q3U2Af6xUuNuWM+ySy4ooBHWAZubP7KHqeU/R9xLQ8aENAiol+5dzy2y
	j20Zy90y6kCex0Hcv++PGtzTMByipGkBfQjmyB2khsUy+Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ho3liOON33iq; Fri, 31 May 2024 23:45:08 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vrfqk2qcnzlgMVf;
	Fri, 31 May 2024 23:45:06 +0000 (UTC)
Message-ID: <967ec49b-3298-4db2-8f59-c5cd8abf366b@acm.org>
Date: Fri, 31 May 2024 16:45:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
 <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
 <20240529061736.rubnzwkkavgsgmie@nj.shetty@samsung.com>
 <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
 <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org>
 <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com>
 <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org>
 <6659b691.630a0220.90195.d0ebSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6659b691.630a0220.90195.d0ebSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_164518_624184_58F270D2 
X-CRM114-Status: GOOD (  11.49  )
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

On 5/31/24 03:17, Nitesh Shetty wrote:
> I see the following challenges with bio-chained approach.
> 1. partitioned device:
>  =C2=A0=C2=A0=C2=A0=C2=A0We need to add the code which iterates over al=
l bios and adjusts
>  =C2=A0=C2=A0=C2=A0=C2=A0the sectors offsets.
> 2. dm/stacked device:
>  =C2=A0=C2=A0=C2=A0=C2=A0We need to make major changes in dm, such as a=
llocating cloned
>  =C2=A0=C2=A0=C2=A0=C2=A0bios, IO splits, IO offset mappings. All of wh=
ich need to
>  =C2=A0=C2=A0=C2=A0=C2=A0iterate over chained BIOs.
>=20
> Overall with chained BIOs we need to add a special handling only for co=
py
> to iterate over chained BIOs and do the same thing which is being done
> for single BIO at present.
> Or am I missing something here ?

Hmm ... aren't chained bios submitted individually? See e.g.
bio_chain_and_submit(). In other words, it shouldn't be necessary to
add any code that iterates over bio chains.

Thanks,

Bart.


