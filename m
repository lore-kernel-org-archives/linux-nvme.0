Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBDECD4F3C
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xG/69Jp5I3ufceWw4+S4Fo/It8aPbBbD9UGvG/3mKFY=; b=Va+QmXbuRpcTHVh39MFvD0mwXP
	9tsQiYWGyFIAq8WK/My4PAPXMoCOhiPJXFGSsfrZzJW+mESkY8FDBk6L+Zce8dzWaZGlG5PGXE+8u
	9r8+Mw41oz2hJJLsVl5O+doZa+uC9NTJFJqns3hA2y//piCqKbkBDgqNP55I+NTEsY3qequ8WkhYD
	PpBlXNDYAqdPNXNIUuQtpxjoRYKoDnZzuJYdVPgNGqAN5v8MzKpQBrpzaNklJ/tZD5QNueEVQuZ1E
	EV0707crdrQ3MrFlYXNEg95+6g4YnVvSMtQimSRiqevj2iufkaq8d6MIdlxWlDtkMdSsHEHqsxndn
	STna/h3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOu2D-0000000Ey5C-2R78;
	Mon, 18 May 2026 09:13:13 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOu2A-0000000Ey3X-3ZB4
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 09:13:12 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48e56c1bf5dso8922485e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 02:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779095589; x=1779700389; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xG/69Jp5I3ufceWw4+S4Fo/It8aPbBbD9UGvG/3mKFY=;
        b=Mqz+fB8Td/ej8mQSOe+mM8kIYNJoxOGBHSKeZAilojKS9jrS7fFssuJQzXFC+xq8YT
         mauC6MEXnI2DGsyx+QXzhB+tTH0NSR1jeEtqtf1bhYJI7JGJgL1VvyP6P1sU2FdLH41E
         tUZUdgcg/3FRdBWhx6J6rOFN7gAC4PZjMn2Dl/NFpkcZgN5KFzLs+YX4/beFE3hNdN5x
         apzMEFM+q3E4aatbZ7cH6BdElYlMxd5QYxMTH6TyxHbVkKGmNKSQQwfBmTvFv3tfYJdQ
         XnpA/qCrxEmeQ0saMWYuxJlMRCD7D0C+y+pURAd1y7YeviAR+vEffUUqQzGj4nhDWkOy
         DMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095589; x=1779700389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xG/69Jp5I3ufceWw4+S4Fo/It8aPbBbD9UGvG/3mKFY=;
        b=RWbjpSSszvjr9BVAZmaW49M3mzSV1NKv7s9oP/WPWMGIk08xHrXebJwWt+65YNSCK7
         fP56gQ4Vcn8MrzwnDEU8PjD8rXJ/79J7JGb1w1nTD1u1fLRSqw/im63VC/4c5BpLY7sz
         Htom4laVtAyt14UyWWzRWfMZzAfF8k4qdkLKfhrPQ0EiNaKEufGDgUP1cNEe7ygtg87U
         y0AEswwPfT0DX40NVqPIr6PJpsH3GSRTf17jq6jOIKCkz63bf5tunoizPSbnCBp/RjK2
         +YbSnFFTUAkWqjOJ8MA8RCZspz/dasXHVKT+aO8aSeIkgdQ0+uDez465eXgx+BdXPyFS
         nFVg==
X-Forwarded-Encrypted: i=1; AFNElJ8mR6lA45Gc95tp2TW/70leSNXnPfG1K7PryGed9qoK4j5GMdvHK5nrHxO9mH9xuDqeFfDmGuASYffo@lists.infradead.org
X-Gm-Message-State: AOJu0YyQiAP/nwCyeoT6hn4kwakn63U/ZNumjZh5IR/TpAgENle6YiBp
	m+q9yU1xP8Pd7lezoOW7ryJptzlwgXm2Z/Zo48uUlEboZWd0ciEp2VR9
X-Gm-Gg: Acq92OF9LF0XpglPJKNZzBEb6BtniLuf3ZdslfQQjPZ0f+YQ91l82P8iz4PpPsHG7yi
	kcYCz6ysQ5vZPK6gEZug0twN1tFL9BnhYoRpW7ZNIjVO+vPe0mgKE130/zvyKYuAdYFCW5HoTK0
	JurQhb4xIEGceBtSz+/fylybTTwhgsFSQ3fQ0oZePQMa/6/aFiNpE7ur4nki28POgM86RyUYLJU
	vMsSvLl5ql5SYHF3kTTRkdjpKGzrpUONY06fPgbk9iYRjU/eyFH5UQ0PFIjPds0GPf0D1dUiJJ7
	dTEFAc8iYjFecaEyij0mhZ4fZp4Sw/hQuErLT2t7Qe7+M3r1/R7tAaVrh1EXuYGJvanaLKGGp36
	OeL6PGEB7vFA4cq4rjr+T+BXoXkgDwvjQBhANqfMHPfVOA2TzC+dH3S6UlgeFj1aP659xm+yiuH
	eMlTdl/1LQO0G89iT8Zg8vd1ftK79usJFww8Uc1j/JqHpY8cqf9okgnz/3MUApAM8RntHQwhfwD
	87EzLDFouhK41E2E/RYUer4YWZNXt/Mj/ufCyJ1PpPnmDTmqeqOpB55sNk=
X-Received: by 2002:a05:600c:1d0d:b0:489:1ff1:74df with SMTP id 5b1f17b1804b1-48fe5fcdf50mr205316035e9.1.1779095588623;
        Mon, 18 May 2026 02:13:08 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:6e9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13a7sm36837416f8f.29.2026.05.18.02.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:13:07 -0700 (PDT)
Message-ID: <88576019-44fc-4614-9e89-a17478dbf340@gmail.com>
Date: Mon, 18 May 2026 10:13:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] block: forward create_dmabuf_token to drivers
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <559756c5e22dcfa183080a979de039910d1b896d.1777475843.git.asml.silence@gmail.com>
 <20260513082553.GB6461@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260513082553.GB6461@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_021310_990847_6E4747F7 
X-CRM114-Status: GOOD (  13.63  )
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

On 5/13/26 09:25, Christoph Hellwig wrote:
> On Wed, Apr 29, 2026 at 04:25:52PM +0100, Pavel Begunkov wrote:
>> Add a trivial implementation of the create_dmabuf_token call for
>> block devices that forwards the call to a new blk-mq callback if it's
>> available.
> 
> This should go into block_device_operations as there is nothing blk-mq
> specific about this.  I.e. even if this patchset doesn't handle stacking
> drivers yet, it should be easy enough to add them in the future.

Ok

-- 
Pavel Begunkov


