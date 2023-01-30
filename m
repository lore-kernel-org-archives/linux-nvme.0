Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B918EC54EAA
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 18:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VcAkkG+7EQ87q1yuQfzrNQ/CVfL1BPFACyrSB5AzC9E=; b=Czs7J9vrAeIb556pqCaoB1KDLy
	0+VbXXhqNt5hPGp8Jh/NkpVaJN+o8FbxTsukHFIHRSbM1yZh+STsnHDaYoWsoCkEqDtXolrP12z5+
	EQkZGPWqZv1slKDzxmV/fDDHbwcjY/Tl5V6pB7/8LIgws4Nu/wiTonzWrL40GPOiH0aZW9rTIfFus
	rg3DRUySZlA4+SgyRa1aO/ACm4fNXUA+PH2GVtpbpry9ELwWpV1CXT7n+jMchq5D8s/xLzwaU+auC
	H0O8yNwuyZlmOmH30GD6EoJOncikWJJ7JvDvN5iXBLEUAahCVJDMooRtprqVpKC1oEOvwQ/tcEQcE
	/cMl0dpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMYRh-004n5n-NA; Mon, 30 Jan 2023 17:59:57 +0000
Received: from mail-pj1-f53.google.com ([209.85.216.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMXet-004Pi7-Ii; Mon, 30 Jan 2023 17:09:32 +0000
Received: by mail-pj1-f53.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso16136598pjj.1;
        Mon, 30 Jan 2023 09:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcAkkG+7EQ87q1yuQfzrNQ/CVfL1BPFACyrSB5AzC9E=;
        b=l/yQ+5sV6QfhIM12mq2V81hOCmrQMVOjKe5zcz8NY6GMEtGVBzqp5ctyoUm4sOTq8O
         Eex6AiepKj6VjYz7TpFwnxUzUOnzW/LM0YuV2WMVIHxvSFuKWNClSIyTjDN4lPOjsWJd
         MtTGrXMZVennzWYNnBl3u0bpK+vemM/jLGBpZbt1H3cP+Zdsir8CURVz1BILZC7RkP2C
         TDV9XgqBbQkKoWkq8rsQ8rkUtP+1oG+fbt2IQlfpF7EZMzBF2hMFL8cTn1B6EeaiPu2W
         kBI2ZKQnW9ly0eDW1v8fIjTaiq9ctBOXAxvRLsne+1N/8t61+YQEFGqI/1wHgbDn8GUV
         BBQQ==
X-Gm-Message-State: AFqh2kotMz3qjjotRMoDByjn8Z6jEU1irzBcwIwXhdZcV9FK8SOSrcsf
	L01InGy9qDHt3NsxFgi9JJU=
X-Google-Smtp-Source: AMrXdXsoThEeXwb5X9zNdrMM/dBzAwAKgsQUh4DVjXEWAVyR5f6ZoR++CGV0u6k+ufH+Ks5WBdnq6g==
X-Received: by 2002:a17:902:f646:b0:194:46e0:1b61 with SMTP id m6-20020a170902f64600b0019446e01b61mr52496709plg.63.1675098568615;
        Mon, 30 Jan 2023 09:09:28 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:5016:3bcd:59fe:334b? ([2620:15c:211:201:5016:3bcd:59fe:334b])
        by smtp.gmail.com with ESMTPSA id y16-20020a170902b49000b0019602263feesm8042186plr.90.2023.01.30.09.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 09:09:27 -0800 (PST)
Message-ID: <2bab7050-dec7-3af8-b643-31b414b8c4b4@acm.org>
Date: Mon, 30 Jan 2023 09:09:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 01/23] block: factor out a bvec_set_page helper
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ilya Dryomov <idryomov@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 Xiubo Li <xiubli@redhat.com>, Steve French <sfrench@samba.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Mike Marshall <hubcap@omnibond.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>, linux-block@vger.kernel.org,
 ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
 io-uring@vger.kernel.org, linux-mm@kvack.org
References: <20230130092157.1759539-1-hch@lst.de>
 <20230130092157.1759539-2-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230130092157.1759539-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_090931_672156_CA4EDBCD 
X-CRM114-Status: GOOD (  14.20  )
X-Mailman-Approved-At: Mon, 30 Jan 2023 09:59:55 -0800
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

On 1/30/23 01:21, Christoph Hellwig wrote:
> Add a helper to initialize a bvec based of a page pointer.  This will help
> removing various open code bvec initializations.

Why do you want to remove the open-coded bvec initializations? What is 
wrong with open-coding bvec initialization? This patch series modifies a 
lot of code but does not improve code readability. Anyone who encounters 
code that uses the new function bvec_set_page() has to look up the 
definition of that function to figure out what it does.

> -	iv = bip->bip_vec + bip->bip_vcnt;
> -
>   	if (bip->bip_vcnt &&
>   	    bvec_gap_to_prev(&bdev_get_queue(bio->bi_bdev)->limits,
>   			     &bip->bip_vec[bip->bip_vcnt - 1], offset))
>   		return 0;
>   
> -	iv->bv_page = page;
> -	iv->bv_len = len;
> -	iv->bv_offset = offset;
> +	bvec_set_page(&bip->bip_vec[bip->bip_vcnt], page, len, offset);
>   	bip->bip_vcnt++;

Has it been considered to use structure assignment instead of 
introducing bvec_set_page(), e.g. as follows?

bip->bip_vec[bip->bip_vcnt] = (struct bio_vec) {
       .bv_page = page, .bv_len = len, .bv_offset = offset };

Thanks,

Bart.

