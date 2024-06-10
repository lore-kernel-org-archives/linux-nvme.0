Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05129C27C5E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 06:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9BY2lnviANQt5LFXardZ1Ja67QMdHaXFtOahZxl5GW0=; b=a56qqeJISLNYf4yM5TNKRqAD4F
	JBl0gPdAnKFAAFHoivefg4b2uRKGBm1CckqmJKgcb2tJkCtiUc/GLtdVuDCnx+yQXbJoKqqhZJnJo
	m1pVAmgexWGPax6StFFNpkOvTj3MgnvJRSPbAE0S37o0cYX+fPvwN49LeEGF7Qf9DkpIKlg7euL5s
	BOe9JsCZ8HLgQvHJxiqvV7X+BNHxIpZu9QFI8HsTBq+NENHirT3Jxv6SZQHxS4FQmdnjW+FKFSiLf
	OLMhLLZrl94PmQHmopCfyPy8ADZAFl3GUHYkA2WvIGwfpZRTAIj80f6bslkok/szYroPyA8sLWhpy
	xE8pDmAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGYvx-000000041hN-1ZLQ;
	Mon, 10 Jun 2024 06:55:13 +0000
Received: from mout.web.de ([217.72.192.78])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGYvt-000000041gK-0SkP
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 06:55:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718002495; x=1718607295; i=markus.elfring@web.de;
	bh=9BY2lnviANQt5LFXardZ1Ja67QMdHaXFtOahZxl5GW0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rDnh85qobaTZx5plf8ucIjiGjCwBja+3QWE/P01kWherzc1ghScWR40sacik7cuo
	 QWkmYPLX7trRudLGzykfNOOkmSDF74AYySu0qusN5wxcRgj8lYHnIrC/JDGxes+vr
	 SiuNkmS+gyyH1jgiUDO//rM0xeAlzwuIKKyTAddfwGfN3Puwp5bkQ2dkCaVe39iJ+
	 Yz8Qqo/2ga+EbYUKy8KpJDnwDEU59ufGlrn4lCRDbN/5vDtSLii5YbmUJd+XfV1qa
	 opV21U43yxswV4quw7p3xcEHfdLebcXoXUe0c8rvHVsGeUK7d+Fk73+9i21byOMEm
	 uF9i0RGJrLiRX9KOZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUCz3-1rpv7k26cd-00PHkN; Mon, 10
 Jun 2024 08:54:55 +0200
Message-ID: <2904522f-8981-459c-8f8a-5dfa6de40331@web.de>
Date: Mon, 10 Jun 2024 08:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexandr Sapozhnikov <alsp705@gmail.com>, linux-nvme@lists.infradead.org,
 lvc-project@linuxtesting.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240607134340.11-1-alsp705@gmail.com>
Subject: Re: [PATCH] drivers: nvme: target: core: deref after null
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240607134340.11-1-alsp705@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uMo2DT30EkJwd/lQVOYtidkkkXOcQVOo4S3SIygw+m8jw8Qz6qf
 FlIwe3QTsMUAzR8NhF3h6PVroXnYEvom0CN6NHcHtDZ6q4lvkplTX8VKM6UnKbWHN//WVyA
 LaTJ4IyaBYFw4TQSOB2suhWbQ+YzAuIq9wa+9pketoVZEQPUTe1EVsjS0kNpzyXAOM3B9eG
 XIyqIVVRl+FHZ72FLFULg==
UI-OutboundReport: notjunk:1;M01:P0:7gBCsE6Z9MA=;0ar/JH+9Rf2g0rpBzMwAVqrPfrU
 OK7Y3Oi/zo2W7Zlm+U5rL4+34TyqaMZtNrLBRkqQ/QplOsiV3zWt2DrKdH7qolwKmta/I6g19
 0S/DazL/MZz43fwwZK6nHFQeV3LKv+3Nn3opGb8CTp0yceg4RKMdQuuZ27uSiPGgmjpivtBw9
 qxFHQ9/5Ab7Ah8pLOnHgRtSaU+IjaeHV1bQxpPIGwEqV3ymg3tpBDbp607G7YV5xwJKeYGxiQ
 K1JOG/loEY+hpr1beWBgG5J+SRALwL4H5gfk5Q+a5ixZcNKTSIWHjraTZH4jfJDuMfFWiKTRS
 ZNkBniFP+GmR45l4+8AVBFP0W6I6+PZM6CTGz+Uo2cFdwJAhO5rMmjYabMA/dT+nft9EpG797
 9MRqj8TDJVJBoiEWFiOQmrjDWexc4CBzdtvnyTuzpFXjVFaM2WGTKxLd1Qr8B+sQ+gUXWLnK8
 dGsc6XHeICYsfMJWEwO3Ts1tzDRMWK+bv8NrJ+FB3KYlQpbnfurQpPyUtanZ7lf7eqh2oF4dx
 P7mdW852WmPQxVwPUXalSh7k3kXD4vLQBCisS4kAEXwdN1kVLhZz2AlZbVr6NEVjqVjg2sH5+
 jNeIcxCfvjCw/S0qo/uqHtd6+0Vbqas8IllgNtFZDbo7M87nCqMygXNfIY/OxfrNGehqeVDiH
 tmg2RRGkPco2wqvpe2mVxgp8KMmr5MC6Cz+ekfq1EL7DdvPDoswEmaJK+ylP9Tx8PT0b+Z04+
 WKxB3JefCSdChNUnrBsXS1As0/G1vJ8IrGtaentloABXrGY018RkYtXUWxEUeW9zJ7BILwsES
 oadLL8j5NQrJYFJ4kENn+ddBJTRahAq0vbLsfn3kl51c0=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240609_235509_538380_9224B512 
X-CRM114-Status: UNSURE (   5.28  )
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

> After having been compared to a NULL value at core.c:813,
> pointer '(**sq->ctrl).sqs' is dereferenced at core.c:838.

* Please choose another imperative wording for an improved change descript=
ion.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc2#n94

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?

* How do you think about to use the summary phrase =E2=80=9CAvoid null poi=
nter dereference
  in nvmet_sq_destroy()=E2=80=9D?

* Is the subsystem specification =E2=80=9Cnvmet=E2=80=9D more appropriate?


Regards,
Markus

