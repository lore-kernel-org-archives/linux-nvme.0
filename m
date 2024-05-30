Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5E0C25B7E
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 17:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ul8tShPV3DUMrLj4E7kNdLyBZmST2o57Jd5aN0FDWYg=; b=rL/hdhHsMWACeKHTYzWPM2I49Z
	mNQRhk2Sn1PXCstzKHh7/gL4Kyiq9zF78OIVVS82SWmor1R8SJfBzmMwtK3M27RF3YsJJ+ChdxqO7
	TIFKvg6MAs/vSd/neU1yw6YHgAxp0YDyG1+h02+jq+zwfw9Zkh+per4XTHd7Eed0bTpSphkUNHH9i
	E3E0r65iE1HWzvOmE0+JgNiZUUKQk9DxV0VBVqRkP6tlaVsn+NYYxG/LF70w6dsWWrhJPsJy4xT+W
	gHyuKiJ4gIdZxdhl4jyGuCXSbpTzmhEpN/UITaoSCBCYseXjfLotyowV/qiZnghXeSH9DIK1YmKvk
	oOP92D4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCjJO-00000007wzo-3PTm;
	Thu, 30 May 2024 17:11:34 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCjJK-00000007wxz-3dh1
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 17:11:33 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vqt812W1wz6Cnk9F;
	Thu, 30 May 2024 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717089079; x=1719681080; bh=Ul8tShPV3DUMrLj4E7kNdLyB
	ZmST2o57Jd5aN0FDWYg=; b=pDdrsLN3JZPbFaUtLRbj37cnYuTv29wYsaoWbWPX
	0jAfS4sWOekodOat3cJMbqn2RuFn9uq1dvv60rD84RsGZNOhy608uxLLU+fhbyly
	eKTbCc9wykATpOsmXQs1/utBwypcCkWl3KNU2MCRI5q96GhEKAOJtbitLN7/YNmG
	3Mn9taXV/EfZN1zWvkxJYjfq7QJgcsxlE8NwOH4KI1q7OAQMt6CrARV53oLIJ5CE
	jigej7/3tFmHOi5xt9zZPOhIruRk26PiBfPzT3bdqB0Juw5GHorv14poLk5Hg7m/
	4sx7azLGVHPrQJdDegiabUIRkEKLqqQMji0NKTMLKSNjWA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id T0Ifl3ssZIoq; Thu, 30 May 2024 17:11:19 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Vqt7l6w1zz6Cnk97;
	Thu, 30 May 2024 17:11:15 +0000 (UTC)
Message-ID: <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org>
Date: Thu, 30 May 2024 10:11:15 -0700
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_101130_954036_7CB6F54C 
X-CRM114-Status: GOOD (  11.25  )
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

On 5/30/24 00:16, Nitesh Shetty wrote:
> +static inline bool blk_copy_offload_attempt_combine(struct request_que=
ue *q,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
struct bio *bio)
> +{
> +=C2=A0=C2=A0=C2=A0 struct blk_plug *plug =3D current->plug;
> +=C2=A0=C2=A0=C2=A0 struct request *rq;
> +
> +=C2=A0=C2=A0=C2=A0 if (!plug || rq_list_empty(plug->mq_list))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> +
> +=C2=A0=C2=A0=C2=A0 rq_list_for_each(&plug->mq_list, rq) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rq->q =3D=3D q) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(!blk_copy_offload_combine(rq, bio))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return true;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Only keep iterating=
 plug list for combines if we have multiple
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * queues
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!plug->multiple_queues)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 return false;
> +}

This new approach has the following two disadvantages:
* Without plug, REQ_OP_COPY_SRC and REQ_OP_COPY_DST are not combined. The=
se two
   operation types are the only operation types for which not using a plu=
g causes
   an I/O failure.
* A loop is required to combine the REQ_OP_COPY_SRC and REQ_OP_COPY_DST o=
perations.

Please switch to the approach Hannes suggested, namely bio chaining. Chai=
ning
REQ_OP_COPY_SRC and REQ_OP_COPY_DST bios before these are submitted elimi=
nates the
two disadvantages mentioned above.

Thanks,

Bart.

