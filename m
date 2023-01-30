Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29B7C38142
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 06:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q0USauUwqY1SaOU2GvOVYD8aiTVQVkxSRI7nFSgwMtU=; b=XgeQOavLE2YP9A0Th5s0fwjapP
	LVRstS4WtvNqloyzU9RhT3dNc68P0gneTd2V/MpwkC8ZyChkL3KWIzehg4zRoFO+47fTJAf+qTEHL
	EhzonHjulUStWmNC/jKiVI1TssHM1JTIONC7ECjI86defXHxS9f9773422uOzYGgQ2hPZWRqvXk0z
	dhX9BFLGv17s0BVEbtbX9u+B8ntPdpJwyGljS8x6eG2nRnm8zjYixuiScricRSpEIIcDD1RUFpcFH
	9sDuqCc/MT0LMzwlzAonv3qJjC2JvFm7TYarHXxCi5k03GY14aqSpssGccLTwwZnKc6WZhP26H21T
	6E0iNxiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMjk3-006NXF-4a; Tue, 31 Jan 2023 06:03:39 +0000
Received: from mail-pj1-f44.google.com ([209.85.216.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMZlm-005CGH-PM; Mon, 30 Jan 2023 19:24:48 +0000
Received: by mail-pj1-f44.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so12107908pjb.5;
        Mon, 30 Jan 2023 11:24:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0USauUwqY1SaOU2GvOVYD8aiTVQVkxSRI7nFSgwMtU=;
        b=tuvKMuR7OIw12JPASeIkv/hMWqnlDA4Lh+sWgCeEKV06IuLrsMItiEHAk3mMxf/2/6
         YZMyAFa5MV5eo5ai6W3AjhJTPdRWaPHmZ6JZ0d7anBTehnhAhpqBodp68I/hMBYU2GHT
         P4P/WVIHxQjNc3no+rBA+PEmnTiSoUFN5QiDzJKFW/8XNzPRLxdACFYgU7sNQed5umwj
         O0u4CyjNbCIrM3fOw13EL7FTH7gQsDYzxnntebJPyzjCDd8FiglzIfDA7wiAqwKLC9/q
         pD7W3fdaPe5t6IgZiqrCWipF8vEs1DuTWJWBQCbm76srdCsUzdxoq+mqlelwyoidTfVU
         yMbg==
X-Gm-Message-State: AO0yUKX6ZGeYLhGkfHYjb4iFzigRXskcHeTMrE4N1Wl7QuSJuKJ7RNyq
	uCghXfDnb9PQZ7XahOV7TLY=
X-Google-Smtp-Source: AK7set/rGKHetFHi+kM9ZonjZUNA4n9BoD4xsf4KlNV/nZP1isOdo/PYXU7cRl9F9xNCOZ6lx4KGGg==
X-Received: by 2002:a05:6a20:54a3:b0:be:a177:af43 with SMTP id i35-20020a056a2054a300b000bea177af43mr2872944pzk.24.1675106684718;
        Mon, 30 Jan 2023 11:24:44 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:5016:3bcd:59fe:334b? ([2620:15c:211:201:5016:3bcd:59fe:334b])
        by smtp.gmail.com with ESMTPSA id 69-20020a630248000000b0045ff216a0casm7117730pgc.3.2023.01.30.11.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 11:24:43 -0800 (PST)
Message-ID: <0a7739db-13e2-efac-2c1a-872d7f2fa7aa@acm.org>
Date: Mon, 30 Jan 2023 11:24:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 01/23] block: factor out a bvec_set_page helper
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
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
 <2bab7050-dec7-3af8-b643-31b414b8c4b4@acm.org>
In-Reply-To: <2bab7050-dec7-3af8-b643-31b414b8c4b4@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_112446_846773_99EA4DCD 
X-CRM114-Status: GOOD (  15.40  )
X-Mailman-Approved-At: Mon, 30 Jan 2023 22:03:19 -0800
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

On 1/30/23 09:09, Bart Van Assche wrote:
> On 1/30/23 01:21, Christoph Hellwig wrote:
>> Add a helper to initialize a bvec based of a page pointer.  This will 
>> help
>> removing various open code bvec initializations.
> 
> Why do you want to remove the open-coded bvec initializations? What is 
> wrong with open-coding bvec initialization? This patch series modifies a 
> lot of code but does not improve code readability. Anyone who encounters 
> code that uses the new function bvec_set_page() has to look up the 
> definition of that function to figure out what it does.

Please ignore the above question - I just noticed that this question has 
been answered in the cover letter.

Bart.


