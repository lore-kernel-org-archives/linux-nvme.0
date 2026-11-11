Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54667606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=w7pIbfeR;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=mjjkD3F1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=54mq7rceR4bRAPcOzDhK/ppo00nvMUUWR7fqyhiK9qk=; b=w7pIbfeRNXEiU1
	cjdDuqC2nPiaAoU34Ms+X5L75Q84UMg4jIGfvNF6QDZojISbufzUO9LI371PHYFglBn/c5b6lEdyV
	+9RF5Qk44jc71ZCKxj68ebiq3TWnEmhSIbMIKA6fU0BbJiJnCoru5PTtckDfnHZ0NsnxzUjcjnZnR
	gc4GpsxRTXSvwEYYULxuFiPqxMA7xRnS4vrPreiIStSGG/g9N7uhIFqcV0Cx6LH/nwSlRhFVOQIso
	HYe70EGpQ9+DK/P9XJ0H7hwPqWz4LKBGiNZqsKT9rHJC/ADQQt3L/P7E3uLO68E6xVkhrRhnimXFM
	8h2EO1EDcQZ2JnXG+rHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRCd5-00000007MPR-1E2t;
	Wed, 11 Nov 2026 18:01:03 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRCd1-00000007MNG-3rVu
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 18:01:02 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jPrt129gyz1XM6Hv;
	Wed, 11 Nov 2026 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794420054; x=1797012055; bh=54mq7rceR4bRAPcOzDhK/ppo
	00nvMUUWR7fqyhiK9qk=; b=mjjkD3F1qfyZ2z3XijfuyBUHgM6o5njJoxFYeZkc
	9tZTHVT35Woh6RnPikDcVC3tYDEVL1449BXpsyZI5Pe74S0Jz0exG/cwHQxUIlcc
	V7mNjRtxZR7BrLbp8b4CJt17oiUPsnx5FlcQnZ97IGPN9kvWmVrv3rHJWC/Uj586
	HD5JXoci26NPlr/Z0eA8RMq56AwEjul+MGC9dVKQVx4t6aGfcn2U/ugJn1tcGRn7
	4hbPW9QLNzGNv/oflTm8Oxb42e7Be0I2T5+FngUDPniRrOpWt0wx5xgGkawSkQzJ
	8/JnoBcrr7FuFUT1LT1tVt0c2q89Et8ZngsXszWkuC/Tpw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DTRaocpgHXJs; Wed, 11 Nov 2026 18:00:54 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jPrsx458kz1XM0nv;
	Wed, 11 Nov 2026 18:00:53 +0000 (UTC)
Message-ID: <849733b4-9790-49fd-9585-25b137eeebf4@acm.org>
Date: Wed, 11 Nov 2026 10:00:52 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] nvmet: add context annotation for nvmet_ns::bdev
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-26-nilay@linux.ibm.com>
 <8beba915-07a5-4eae-b8a4-3ec7330c90f7@acm.org>
 <e9f42390-9115-40b2-b0a5-df17c53ce38b@linux.ibm.com>
 <6708de12-ed0d-4101-9328-d08864e677a5@acm.org>
 <e31029f5-c022-4fc9-be94-d1faadfb327e@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e31029f5-c022-4fc9-be94-d1faadfb327e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_100100_538596_E2F6365D 
X-CRM114-Status: UNSURE (   6.24  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 11:25 PM, Nilay Shroff wrote:
> Attached the complete patch for your reference. Even after making
> this change, clang still complains about locking violation:
>=20
> drivers/nvme/target/nvmet.h:255:13: error: reading variable 'bdev'=20
> requires holding mutex 'ns->subsys->lock' [-Werror,-Wthread-safety-prec=
ise]
>  =C2=A0 255 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ns=
->bdev ? disk_to_dev(ns->bdev->bd_disk) : NULL;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^
> drivers/nvme/target/nvmet.h:255:13: note: found near match 'subsys->loc=
k'

This can be solved by adding a lockdep_assert_held(&ms->bdev->bd_disk)
statement, isn't it?

Thanks,

Bart.

