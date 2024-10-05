Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB82CFB43F
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2024 22:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mmSl7eqWiha0nfA3hTlH5zkdKkX4dm03HscfrHTMGhI=; b=V/YwDDLotnzZY37SJbVqY4KnJN
	evJyZP+7rBux/ufWbaJG+UDqtYDJPQMIa/Lph0cEfL0/iFbtUVuFI5x694N+L38tTpG9mfzCA+AaS
	P4LLfWKDPeukrRaKISnTjuw/SOPPRgRuR9KNVEDgsH7a7mVqrDTSiNUXxaknziYiCclKxop0/gMEP
	Pf2/KjXKWV3yX2vgOwJBtrudq8+1D/NIePD3/HEBr22Q25wKI6pVYtqgcpa/StHPtw8/IKh8vqA3n
	fK5EO2xyxtyA2GoUg3jx3aluHd6T3W8Z5EgRimpeq8oJajeddhqldP8bX8JlC9CoeHKSShUXmx1XS
	NFvMhjXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxDYR-0000000G46S-3s6c;
	Sat, 05 Oct 2024 22:47:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxCSK-0000000G028-3UcV
	for linux-nvme@bombadil.infradead.org;
	Sat, 05 Oct 2024 21:36:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=mmSl7eqWiha0nfA3hTlH5zkdKkX4dm03HscfrHTMGhI=; b=V1kngOKWrD4Fm5dXtVgtsrfhK+
	MoKpfo1Ciccl64n3ldRCOYVkTPkx4SifUGYS+pBSzL0lw8HvlJZPWxCUlLbcFQoDa2G+HvsEya0CP
	sC4JDMnCgJNY2PxfxkH9niSMOZxJ7p+CVZ4w6VV8FncewOCr71H/hmApGRjy52WqXLluvwE/0PY1t
	zUWoVIu9BHFxDatrIbjyycL9tne2mbvi5oJE59TMjmszWnBbZZpv8LBRyiSohrrKG0MArpRCnR7lr
	tZPQsB3UwykbV05YNk4BWMZhI1g/nMZgkAPE8VUTYx3DLONHaq24AZ9vEjn4WhTOud1Snvi5zlqPK
	deG27GSQ==;
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxCSH-0000000485C-091k
	for linux-nvme@lists.infradead.org;
	Sat, 05 Oct 2024 21:36:51 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XLdym6QG9zlgT1M;
	Sat,  5 Oct 2024 21:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1728164190; x=1730756191; bh=mmSl7eqWiha0nfA3hTlH5zkd
	KkX4dm03HscfrHTMGhI=; b=HojL8L1qLnNowfZUVh7eJ8b0Fgy9LFPPki3RMiiq
	5PeiLvy74j0A6qnTPUvVxeTjBNt6xSIP9ezBNwGrp3uoMgQHIQVwPmkctw0RCkOa
	AAHIOoR+l9Daj2VOm+b7tSWzHJFpZQzbQpI5Lu1SHUDqYNAOj4xqFBuf2Z2yBiwQ
	wOWH92oz9UDJEhI7K7RnuSvA+Vx5j2hUNGdi0XyAOOP8O4lmfKsrmPADwV8XcKJL
	gOnIYZgNrYS/M7BjbZXobIcNmf8gV9TTFDwYy3UzEoXFyNgeRYfjh2ZV2vprNlb5
	MJ0n3nHuV6dUsoYQ299TDpgLD5AjiVNknOgJoLRSjIVLJQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8jru5-91P3G7; Sat,  5 Oct 2024 21:36:30 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XLdyh70ZyzlgTWQ;
	Sat,  5 Oct 2024 21:36:28 +0000 (UTC)
Message-ID: <d5fe08b6-68df-4d67-8870-dd7ae391973e@acm.org>
Date: Sat, 5 Oct 2024 14:36:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.12-rc1 kernel
To: Jens Axboe <axboe@kernel.dk>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
 <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
 <dvpmtffxeydtpid3gigfmmc2jtp2dws6tx4bc27hqo4dp2adhv@x4oqoa2qzl2l>
 <5cff6598-21f3-4e85-9a06-f3a28380585b@linux.dev>
 <9fe72efb-46b8-4a72-b29c-c60a8c64f88c@acm.org>
 <b60fa0ab-591b-41e8-9fca-399b6a25b6d9@linux.dev>
 <c5c3c7d7-2db9-44fe-a316-b0b5bab30f1e@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c5c3c7d7-2db9-44fe-a316-b0b5bab30f1e@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241005_223649_540671_F1048D58 
X-CRM114-Status: UNSURE (   6.97  )
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

On 10/4/24 6:41 PM, Jens Axboe wrote:
> That seems over-engineered. Seems to me that either these things should
> share a slab cache (why do they need one each, if they are the same
> sized object?!).

The size of two of the three slab caches is variable.

> And if they really do need one, surely something ala:
> 
> static atomic_long_t slab_index;
> 
> sprintf(slab_name, "foo-%ld", atomic_inc_return(&slab_index));
> 
> would be all you need.

A 32-bit counter wraps around after about 4 billion iterations, isn't
it?

Thanks,

Bart.



