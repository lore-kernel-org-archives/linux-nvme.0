Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B48AC54F51
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 15:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3aN3udKBcENjBD5UHxw3XhgPgHCGso1JhkYTFHwhTGI=; b=UnZX2Hpvv20STvq7qPYywQg0Tm
	60+NZXyVr0vcoLVow18yVY0lUF9Bnbx5rCbp+HByYKWjtZ3hxsQRm+LAEG644A97DHI4BamAswvpO
	KlVx5jqq3uVzCx2Ts49H4iCzT42JLDxWW1aAPpd0o03c4fktZXQFCQxXxOdXecb28KEpAZSGTszOY
	6unxyc6Us/UMuMc0YzBRz6T29xjjwx1wzZZJ7+moRRfgklYC5poSYBpfoAQQTLZukVpMMxCkScOHH
	8os6sWPcYy22fpihuE0dNJfEx0/YR1WAL2f0lE1/Ky1uoMkzdN2pAadfOmCPbfOljTNEYFfMgLw4b
	Hs88qEyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5mP-00000008KRf-3XnI;
	Wed, 29 Jul 2026 15:01:09 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp4V7-000000088nB-3Op2
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 13:39:14 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-c16794450aeso122642866b.2
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 06:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785332352; x=1785937152; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3aN3udKBcENjBD5UHxw3XhgPgHCGso1JhkYTFHwhTGI=;
        b=Yq2NqCRvMfMWxYdMRhkP9EhtAUtPzPP6TVyXRaZinV2H73evC0qkOl34ZsX2xGwS9g
         yz9WeFNMP41pPEqL4WtPNrCCcXZ1gKJSqp5OHhtqGtHgizVR+eI1iMOSPhMG2UAFSo9k
         48CjeEue4hDukILwGDaCDTh5VoE3uIXnv/fHZDrgAN8RFbYA+llYEqiYtjFp0pDxNpkS
         Ya/AwremFRyRBw+WDhU2oqZ1vu/eCaKjIhc22hLhRMif6pzNLft75NwIFgZoKtIqwdgh
         wTVKGowPXGVDqD5r8HnjL0e0MDLzBZr8gfrsXZno0WExKp3ZAmy/yKmc2dDyiNc2OWu9
         Eqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332352; x=1785937152;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3aN3udKBcENjBD5UHxw3XhgPgHCGso1JhkYTFHwhTGI=;
        b=Ees2n7LOthD4YkaLTbw4u4++rV8huBXxGmwVN4ohSJ1C1LSehAzMR7qNgWP22BCKdW
         gB2EhrF45+NTMh/du5QDYHE7ms9EeGj05ly51ltlUDeXqcARPqPSEEoikAN6eeh9EWzx
         OQvX/EuFKQHl3TKD7jMdYvz9Ay9ObCSnmvO3mjIbunpeu2ApcNS442zaWRNd0ijgrvzD
         Tyruv/9XJ+Hn6I1M/IhP9FrMinm6LYkC4P+4+pw8uuIHmFOi36Q2pgfXLzz+M68J7tEp
         lUFclnqT5/VRnl5URqwyTR6zpWE1IRlgmxOQqa0pQATmxdONCwST6taljn1A8N11k1ka
         5biQ==
X-Forwarded-Encrypted: i=1; AHgh+RpiJHyEk28jjg+Z4Hl+FGhao+6ltAty0LQ+X8IsKSGJ9YFeO6vXZjU/+xK5F8/05KTCNPlPA6EstaDM@lists.infradead.org
X-Gm-Message-State: AOJu0YywPvZkl9HUE4hGNIBTIJOsKdhXwiJghpoBH6B0J5UC/+fcKfuV
	X+NapADutUOAgEDVHvmrtOcynz7unIdJI/1yMCD/wMrc8z5bpDj9KKN9
X-Gm-Gg: AR+sD12AvLZthsUBqprPj4tyX5chy6UlSMSzceC+Q9kQQq1DmyrG/zoGhzI4HP35k8x
	vRgnhOQy6/zVr4whAfIW458Xy4ZKVmUpLWBTw+Xcz+L8ZyGLcyaWRuweIUO5rFRfwZ3If16ViI8
	WWWxfk+/uArSetJfbdL/ngWqruacPBP7nubTcrYzJEr+mgabyGvktWOoLnKq6HekQ42u6BMs3wD
	6dA3XhPysdC6nhXjobv9CAr89RUBnjR+V3Plr8WcNjenKVsxXI8piHVSii+dz6ohP9/W3UvfuF4
	80alpm6n4FsCewqTWDaPJEJvY71kDexXLQjh/RZV4bb8RTXmv2SIwKS6bm19MwXDZg7eP0CIu01
	JaTfPIl6pjcDjADwEhfFtp0SIBouTEHkbIxkO40UfWPvkF9T2wSVTwSygih7F2uovGr4mBw9SxA
	hhVTfOA4c2kKm5eJRygoMtcLt3WQZEVld3T71AsuJcwZjJsCibkqPkDX5CTt2IZRKGf87llgoCE
	019ltDzRCAFGrIokTdWiyR3+KXCHFgBJ5to9q5x7LA2xVbN7EPceUyxDbW2zT6cTZhEzxmCyGDa
	mSX6ZNWq8gXBBiGbHh8=
X-Received: by 2002:a17:906:f598:b0:c16:7b66:4932 with SMTP id a640c23a62f3a-c1f721bf58emr374209166b.64.1785332351629;
        Wed, 29 Jul 2026 06:39:11 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83f4de5bsm118685466b.29.2026.07.29.06.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 06:39:10 -0700 (PDT)
Message-ID: <dc72d46b-7b45-4beb-8e36-d810d2a94c28@gmail.com>
Date: Wed, 29 Jul 2026 14:39:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/14] io_uring/rsrc: extend buffer update
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <CGME20260728213008epcas5p418dfc10b7ef786e162ade86d14430475@epcas5p4.samsung.com>
 <633d33d8e278999f55126794fce948343403494a.1785274111.git.asml.silence@gmail.com>
 <73317bf9-f7df-43f9-abc2-daa25a675485@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <73317bf9-f7df-43f9-abc2-daa25a675485@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_063913_866140_3F2A8CAC 
X-CRM114-Status: GOOD (  10.38  )
X-Mailman-Approved-At: Wed, 29 Jul 2026 08:01:06 -0700
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

On 7/29/26 14:31, Anuj Gupta/Anuj Gupta wrote:
> On 7/29/2026 2:59 AM, Pavel Begunkov wrote:
>> @@ -882,8 +894,13 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
>>    	struct io_imu_folio_data data;
>>    	bool coalesced = false;
>>    
>> -	if (!uaddr) {
>> -		if (size)
>> +	if (desc->type >= __IO_REGBUF_TYPE_MAX)
>> +		return ERR_PTR(-EINVAL);
>> +	if (!mem_is_zero(&desc->__resv, sizeof(desc->__resv)))
>> +		return ERR_PTR(-EINVAL);
> 
> desc->flags  isn't validated here, unlike __resv. nonzero flags should
> be rejected too?

good catch

-- 
Pavel Begunkov


