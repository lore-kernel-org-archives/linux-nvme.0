Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBD6E7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 22:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IQKVDEMj0TrHltVURdtOup6IIRHQAQ4lIbXGduLnT6I=; b=Ugqe9VV5tDQ1npdA5Q/K9+Wxqc
	6WbHNrz+wd9/Hz8AFeVEXccEDKvgI0ST7h3Enm70vm8VJVecE0Lo847O4hlHP0+IzkX34RN3TGTfk
	E5l2xfn59C2Hbfgbebj1F9g5XM0uyAI+WBTzTLiCcaxdqdaL/GofsfT459KZxY+x7enbQDIRieRw/
	qiuCt0PxOB+n6qNFQTr9CTMGXNzfYX6Uo8LqajDbLTCs70yH3wa3d+fFSLJux3Kd5rVJHnnYAlaG4
	vSz06CNqMlmfJiLktGpto7H6PRprMFUbgGmjH2Hjkv+a/K6J5Yc5JPDeYlAmecQ07Grg/XAB+DJTy
	8jvcadIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKm15-00000009Otx-1hj1;
	Mon, 09 Dec 2024 22:14:11 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKm11-00000009Oop-28u9
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 22:14:09 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Y6bjv2dDszlfflB;
	Mon,  9 Dec 2024 22:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1733782429; x=1736374430; bh=IQKVDEMj0TrHltVURdtOup6I
	IRHQAQ4lIbXGduLnT6I=; b=jDq10gFK/44haFYNLdurY4fNR+uBNg0nU4knZqPa
	ibGTnIO0Rl5EA+MPlZ4I5pCwvbTrPvQCB0DiYqmkZrE3zzRRmiECLY4uOJmZeKv7
	OvGmexAE5Z2hai0js6fM7Rxwg9PbyphTBqFEKalOQQwR3nhHwRigEY0paW1OxGug
	M4l/G846p7QRGdNb/z3j99331bgyzQ4FIDPiarmykDUolWZSB4WwgRcPCZmftVms
	Djmn6GlTt3+3AMAUhRq8HUJHiFM0NdmTdZ3XvlxPqfEGKY9Aqo41s+CwgyysZ5v1
	fcIIUCBF06cRgzg2HVDqMe/aiIe8MCu1CPv879TXpzViqQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jToVKEuMeHKC; Mon,  9 Dec 2024 22:13:49 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Y6bjf55d1zlfflY;
	Mon,  9 Dec 2024 22:13:41 +0000 (UTC)
Message-ID: <c639f90f-bdd1-4808-aeb7-e9b667822413@acm.org>
Date: Mon, 9 Dec 2024 14:13:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
To: Nitesh Shetty <nj.shetty@samsung.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Javier Gonzalez <javier.gonz@samsung.com>,
 Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>
References: <d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local>
 <2b5a365a-215a-48de-acb1-b846a4f24680@acm.org>
 <20241111093154.zbsp42gfiv2enb5a@ArmHalley.local>
 <a7ebd158-692c-494c-8cc0-a82f9adf4db0@acm.org>
 <20241112135233.2iwgwe443rnuivyb@ubuntu>
 <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com>
 <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org>
 <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com>
 <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org>
 <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
 <CGME20241205081138epcas5p2a47090e70c3cf19e562f63cd9fc495d1@epcas5p2.samsung.com>
 <20241205080342.7gccjmyqydt2hb7z@ubuntu>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241205080342.7gccjmyqydt2hb7z@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_141407_553522_AD3AB35D 
X-CRM114-Status: GOOD (  14.19  )
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

On 12/5/24 12:03 AM, Nitesh Shetty wrote:
> But where do we store the read sector info before sending write.
> I see 2 approaches here,
> 1. Should it be part of a payload along with write ?
>  =C2=A0=C2=A0=C2=A0=C2=A0We did something similar in previous series wh=
ich was not liked
>  =C2=A0=C2=A0=C2=A0=C2=A0by Christoph and Bart.
> 2. Or driver should store it as part of an internal list inside
> namespace/ctrl data structure ?
>  =C2=A0=C2=A0=C2=A0=C2=A0As Bart pointed out, here we might need to sen=
d one more fail
>  =C2=A0=C2=A0=C2=A0=C2=A0request later if copy_write fails to land in s=
ame driver.

Hi Nitesh,

Consider the following example: dm-linear is used to concatenate two
block devices. An NVMe device (LBA 0..999) and a SCSI device (LBA
1000..1999). Suppose that a copy operation is submitted to the dm-linear
device to copy LBAs 1..998 to LBAs 2..1998. If the copy operation is
submitted as two separate operations (REQ_OP_COPY_SRC and
REQ_OP_COPY_DST) then the NVMe device will receive the REQ_OP_COPY_SRC
operation and the SCSI device will receive the REQ_OP_COPY_DST
operation. The NVMe and SCSI device drivers should fail the copy=20
operations after a timeout because they only received half of the copy
operation. After the timeout the block layer core can switch from
offloading to emulating a copy operation. Waiting for a timeout is
necessary because requests may be reordered.

I think this is a strong argument in favor of representing copy
operations as a single operation. This will allow stacking drivers
as dm-linear to deal in an elegant way with copy offload requests
where source and destination LBA ranges map onto different block
devices and potentially different block drivers.

Thanks,

Bart.

