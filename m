Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FD2D68B38
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uCl2BZ11vNdK4BSvhzgpyWsQe6+TxyyUP/YQKxpwnUk=; b=1fVNOiLpWfob68bD+6ksZ9R6eh
	Cwq8kuMDkl6V+qIuY5mm/uIXrK7TgI6uqJNPPouwX+MVHIu/ARwMK31GlaoG9FXar4dLL8+UW+qDv
	LmZqMj6h9ayC3QDWF2WBYLnMEClOwDlzZeVBWVFn6shKpD9RpzPXTOLHfAgnmNxBGYx/EVgtAaSgS
	isQfIo0nYHnndH0NPTPsX73a4ajNkSEEh2sUJQRNHGIrLFAktlU7X7mP4BFyYEmiWSxmbG65BYTVL
	A9pHjRpgmBdTHi9pQl8b3OP3eoSu2I+zaHQr4rHDxucooBflFRK9O+DIVQymfZ2eQbccKHHGRQshQ
	UU/Tzlcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBcvx-00000000B2s-1j4m;
	Thu, 14 Nov 2024 16:43:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBcsJ-00000000APP-0WG7
	for linux-nvme@bombadil.infradead.org;
	Thu, 14 Nov 2024 16:39:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=uCl2BZ11vNdK4BSvhzgpyWsQe6+TxyyUP/YQKxpwnUk=; b=MsphaBtl1tEHB96Vy/o9/nqAsC
	IL5aguPO0KWU9MwSiarcZ2dym4doR9cHUdcRFuB/b3JyIb4FRENjbn1Lj1lcvMS9YyyBI3q5Oypfg
	1UdjyzibGGvFbiRVBMjVyFUSJIIP60p+12xbzHkhnAdfw4uFUSNIqT4qcS09tNY3iQ5GxEO0JZBFi
	ix99BfkaXSSCO5HHNzRixjb+wH6znB5AFsSIm6rj5VIdXEcKoZQOpOplThZxD/M4OoWODysnrhYSF
	AGKEAPYcoLSigivBBclyz0vArlE97LGow6lcOrFYDT1ScfK5OV0wZk+Qq9FdEKZTMTEB3StT7z0tR
	OMdOjEXA==;
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBbZx-000000004BY-1Xu3
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 15:16:19 +0000
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-71a6bfcb836so476506a34.0
        for <linux-nvme@lists.infradead.org>; Thu, 14 Nov 2024 07:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731597254; x=1732202054; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCl2BZ11vNdK4BSvhzgpyWsQe6+TxyyUP/YQKxpwnUk=;
        b=Tvi3cfE16or4M4UX0FHwHW3dOF2zxLKyyx1ZTweB4cAF+sqOXb6GEYNsFJgoFhnRWs
         fvN7TfE7zba+DQANhowol3MTW8XdkobSRBku2/odwzEbH7aBg50sL+rab3iUDOjjixgA
         IS4Q9JYd5q1di7OAXVnKKspyLu0OrAh9rzAqP17CDl8EH5BdbBXkc9Ecp1OQANUhgOaI
         IDeUpOaSh+zOjXL7l9B5InSnPL5t5lI9ZwxzX/blJhErXxxba9zkD7zUwseG4Qr6V3lp
         g5eCGkuJWmtsz4Q6hjBcB8iHg6hRotuMoV/+H0s/L3nnWSvecB8/nTn2Tv9dvRIhsGoX
         MZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731597254; x=1732202054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCl2BZ11vNdK4BSvhzgpyWsQe6+TxyyUP/YQKxpwnUk=;
        b=wubfyVNV3XjcYwG1NBB3hDJNNTM6EfcQYexWv94yPHIfyV/gnP2vZOXaTtCzEQLCfm
         ANaPj2Vt/kXGbdDUTvEbTDp9FhK3RvrOvpubkKQ108WUrzmKqhUogAd69x5AtwjjIuL+
         P/57sN/N+PCtSG/FQ8WUw/CCVMyhKKVgoG/1VYLwk49N9NmspvYLZIN2MGerOdw3G3xQ
         X8rpz7KYXv5dP+r3pFVRDyckuIryk5b64b2840QBJdkpCuu7myeodKsLfQ4OF5YOX5Db
         4skTc8TvyDB8gIbuwfs+3/MR0LXrWV51ALEAeMLvfb0Jp6mHGEjTla/0zpLmN+NsD+Aw
         JaeA==
X-Forwarded-Encrypted: i=1; AJvYcCV7iUMQUTP3UPJwt8rf+DbHbfzZcCRnhaH9vIAsh7Agje7N4T9CJMyG4Vn8A8iXhsxe0DShGT+n5Gry@lists.infradead.org
X-Gm-Message-State: AOJu0Yxw1xnyRXDlRX3U6rM+2jrQ7iyHhpnzuPcYu+T5x44AUOqoLcln
	hc2/0bj4G/zdlKFkgC3l6QlDNkXBts26ZAGjrE/lNyck/KYv2a5H9YSzmjOse/c=
X-Google-Smtp-Source: AGHT+IHNdCNa9fduW+ReDmhoxPJTTc4XLsVRba132OXrM8wujEioBQ6IKE0m5EgBdKU01FI9D7cHPA==
X-Received: by 2002:a05:6830:3591:b0:717:f7b9:e167 with SMTP id 46e09a7af769-71a6aed5f10mr2644003a34.15.1731597253478;
        Thu, 14 Nov 2024 07:14:13 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a6eb73b60sm413694a34.68.2024.11.14.07.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 07:14:12 -0800 (PST)
Message-ID: <0236980b-b892-460c-802e-a87a79b7ac0b@kernel.dk>
Date: Thu, 14 Nov 2024 08:14:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: don't reorder requests passed to ->queue_rqs
To: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Pavel Begunkov <asml.silence@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
References: <20241113152050.157179-1-hch@lst.de>
 <eb2faaba-c261-48de-8316-c8e34fdb516c@nvidia.com>
 <2f7fa13a-71d9-4a8d-b8f4-5f657fdaab60@kernel.dk>
 <20241114041603.GA8971@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241114041603.GA8971@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_151617_496929_B089FA3B 
X-CRM114-Status: GOOD (  18.87  )
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

On 11/13/24 9:16 PM, Christoph Hellwig wrote:
> On Wed, Nov 13, 2024 at 01:51:48PM -0700, Jens Axboe wrote:
>> Thanks for testing, but you can't verify any kind of perf change with
>> that kind of setup. I'll be willing to bet that it'll be 1-2% drop at
>> higher rates, which is substantial. But the reordering is a problem, not
>> just for zoned devices, which is why I chose to merge this.
> 
> So I did not see any variation, but I also don't have access to a really
> beefy setup right now.  If there is a degradation it probably is that
> touching rq_next for each request actually has an effect if the list is
> big enough and they aren't cache hot any more.  I can cook up a patch

Exactly.

> that goes back to the scheme currently used upstream in nvme and virtio
> that just cuts of the list at a hctx change instead of moving the
> requests one by one now that the block layer doesn't mess up the order.

I think that would be useful. I can test.

-- 
Jens Axboe


