Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB6DD3A678
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 17:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hXDe+tdRwT/FF9z8Lg1MKoXdRHtft5T0vnCZA5690oA=; b=B0i+VKImzKqBq7vpYQ6cbrUCEu
	hvRXlBRsfI74me5lBDZa+LJsgf4dtp2Y1ILauOfTcHQ6pGN23DI1u15BiJQ70wjorQSLkS3CnaPPy
	tXflpUzABw7ANDRT+jRxQIyUtthQVxdUHp5zL3cdhV03r8bskffs1HIxuwNeCLnOGYDIduLTc79m0
	6tPNupC6PN4ugilzDo2X+xOzSirWr1z8N59gGV7dPsGWgiXjckMHqOixZCEs/RN6zwroVuH9xf4Wg
	zawTH0ztazpcJsDTrMKosvr0hB7tFZ2uHFL3slH80a5EoYBo6P3Ttgexjin/bp3+e649ErS4QndNY
	q0inOMpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5qQA-0000000FP2U-31yg;
	Tue, 29 Oct 2024 17:54:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5py8-0000000FFLl-34iu
	for linux-nvme@bombadil.infradead.org;
	Tue, 29 Oct 2024 17:25:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=hXDe+tdRwT/FF9z8Lg1MKoXdRHtft5T0vnCZA5690oA=; b=fgATpafNE1DHSFREJI4c6SViVM
	fc41Gg7ehJvW3S9dwRrYWxbrc+6LxId/Cw5Vw8cXGAM+bWAwe0+tE5c1ql/cHHmm6wKyjhHWA/sCy
	G5uidqXh8WrV1/99OJBa0C2sdnokYZYa4MYe27byjVzjFcNislno8GOYaGN37Hlf1wYak78bAXcz4
	WV8gMTP+0i7aIbch2m1YpC0VoiZQUZhZNf4aDmXXKlExbmAUzIBcL8soyV5FqJL59PTsWTt1FVzUV
	XybYEuFAW2AIO4gBkuQDfFm7K69oTv0JX96IrGAWoZ/Jt0eSck64I6guQp6qliwBcsCph8+0cyvpR
	LmL77cbw==;
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5py5-00000009xs0-2qzv
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 17:25:23 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XdHFq01vdz6CmQwQ;
	Tue, 29 Oct 2024 17:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730222715; x=1732814716; bh=hXDe+tdRwT/FF9z8Lg1MKoXd
	RHtft5T0vnCZA5690oA=; b=P1foUjoLaYTOdPwbnT8wjp0jVgHHgT7aFqFr8aUL
	lZek+KvMCYfO161JiFBa3dExIzCo7Otdl5Wcnq5j61p/OFoOUgUWwu+AHtTI+fQk
	uTaj7s0rgi2A9FfoZFCmyOTJrTuLghUOPQR1c9iRTK2gkmQI69bVmL7ChEdfd4hH
	95+hqxaF7GevIzW6bWOgFRcXyASV69WG5f28U0M8h10We/+pMhjSGFZNJXjMD9xJ
	/mmkLQ7efYsaV+HVJkXnedBsczWVDC//u6NIUIov+aUrvdG0524N6kzJT2Sfs3xD
	CvV+zaHKwT2QX9oyDLgfitvJJPWw62ReU54EkOfhee4tYQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5G4_p2--gGG8; Tue, 29 Oct 2024 17:25:15 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XdHFj2LCXz6CmQwN;
	Tue, 29 Oct 2024 17:25:12 +0000 (UTC)
Message-ID: <a1ff3560-4072-4ecf-8501-e353b1c98bf0@acm.org>
Date: Tue, 29 Oct 2024 10:25:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 4/9] block: allow ability to limit partition write
 hints
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
 javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-5-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241029151922.459139-5-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_172522_054899_688E0CEF 
X-CRM114-Status: UNSURE (   8.85  )
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

On 10/29/24 8:19 AM, Keith Busch wrote:
> +static ssize_t part_write_hint_mask_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t count)
> +{
> +	struct block_device *bdev = dev_to_bdev(dev);
> +	unsigned short max_write_hints = bdev_max_write_hints(bdev);
> +	unsigned long *new_mask;
> +
> +	if (!max_write_hints)
> +		return count;
> +
> +	new_mask = bitmap_alloc(max_write_hints, GFP_KERNEL);
> +	if (!new_mask)
> +		return -ENOMEM;
> +
> +	bitmap_parse(buf, count, new_mask, max_write_hints);
> +	bitmap_copy(bdev->write_hint_mask, new_mask, max_write_hints);
> +	bitmap_free(new_mask);
> +
> +	return count;
> +}

bitmap_copy() is not atomic. Shouldn't the bitmap_copy() call be
serialized against the code that tests bits in bdev->write_hint_mask?

Thanks,

Bart.


