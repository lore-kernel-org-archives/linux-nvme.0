Return-Path: <SRS0=Cbe1=EO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092C6C4742C
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 15:15:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B61206F4
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 15:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f+WEPa3T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REGghAwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B61206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7/uyEcKYlGm/ZFq0Qra/CMq2O/lLdvKhW+ampK4HuRA=; b=f+WEPa3TeAFWi/mYotB1ZxzwO
	LthLJEKNDzFS0KoXQ8b/c3wLRl11kILL7IjEbMJRpt9PJM3vJ4Sl9XuCWjwY/ySXgSqW8YxTb0hL5
	r3RR2XXr7SGOyFwrCRuvTu3/DR6QZZg+PZwE+2PgEt85GqrJHPZ1iU3p7BjZxGQIvdQxAVXgK8AHR
	MiR5Qzf+KkitVOKapG9zwiy9YuSOagScuI/cVSFXNmNmawY/yS4zFEz1grkZNnO89ih5H9OJmAayd
	4O6lu8fCTYAtzp+2lOmuvlc/USMwKJ7eDPjViGTyYG2hFGmtAG039lGwj/irqjmQZkJWQXT1VkM4j
	qrygb7xzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbmPT-00051w-AN; Sun, 08 Nov 2020 15:15:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbmPP-000519-PT
 for linux-nvme@lists.infradead.org; Sun, 08 Nov 2020 15:15:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604848510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xCiEM7AQz5QZ2RvY5C0nr85g19BsqN3bEHGGJWjun8g=;
 b=REGghAwvDG700XxvFoEua2gT/PxE7PR+OMgmuToJtos0TbUsFc02pLoUFyg5u9TQ6GTd0A
 n2qVLz8dMOc4QT5AipGmGCRZLazwmkyyRNOI5YOh3w3XFNLLFv4FhPz+BkhcnUxXhI8aJz
 0KdtWMnG4Kk3tZ5ava30mnW7p3HOdPk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-sWMGT8i0ND2tLZ17AplHeQ-1; Sun, 08 Nov 2020 10:15:09 -0500
X-MC-Unique: sWMGT8i0ND2tLZ17AplHeQ-1
Received: by mail-wr1-f70.google.com with SMTP id i1so3054621wrb.18
 for <linux-nvme@lists.infradead.org>; Sun, 08 Nov 2020 07:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xCiEM7AQz5QZ2RvY5C0nr85g19BsqN3bEHGGJWjun8g=;
 b=Ga3+lEHwAbRWS96Q5r2XeNipc1POuz+txYQF1ilNkFg5RVnmUCkkQSs4XJ4hd/3cvA
 QeQcfMxVG5BVbXciBahpVmb2joQZgQCzL5REK48sLA6LXRCD8rP6vMYBPR/T6h6zG94L
 TX8CsuLzNX3CxNW8HOoek1DhrJghmFk98qMgLe/mCfUCzqkXMhwnmyF26s/kMmF83pZH
 L2ZaRnFuJFjNKaQfkoUOGlTqyZ0y1kwrqZgW7brOlkakg7tLqVnm+ZKMs7fOiwepIsFF
 YRHTzC8aTBNTVbzGVxiF1OcK/e6EQpMyg5SGwQY9XcIoseYlFdr53FXdRLRYYCZCGKJ9
 TOtQ==
X-Gm-Message-State: AOAM531Bo63LcipSbPjvTrK8vSHCAFrcm/WmvOUbl+z98vwwTmOJZ4M4
 sFrwlUBwS0TZ9wCDvw1yq2rW3i8qrjG11DOXp0KmK7Lh/rGGcKNKGdxyP2GvXg9HSMX0EErBS2t
 ErTUVFUp6dmIAUynyx42CC23rLWc=
X-Received: by 2002:a1c:80d3:: with SMTP id
 b202mr10142600wmd.139.1604848507853; 
 Sun, 08 Nov 2020 07:15:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBz6wtcRAgwxrEGiAL8ElHcOzDdD7qQjz/7QuIFGOGrDkKJazoMrCqH8844xWODBZg8NNGyg==
X-Received: by 2002:a1c:80d3:: with SMTP id
 b202mr10142589wmd.139.1604848507695; 
 Sun, 08 Nov 2020 07:15:07 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id l3sm11508325wmg.32.2020.11.08.07.15.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 07:15:06 -0800 (PST)
Subject: Re: [PATCH 23/24] virtio-blk: remove a spurious call to
 revalidate_disk_size
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201106190337.1973127-1-hch@lst.de>
 <20201106190337.1973127-24-hch@lst.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d23bd50a-7555-438b-9e3b-131414b2d1a5@redhat.com>
Date: Sun, 8 Nov 2020 16:15:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106190337.1973127-24-hch@lst.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201108_101512_002743_86D75FF8 
X-CRM114-Status: GOOD (  12.95  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 06/11/20 20:03, Christoph Hellwig wrote:
> revalidate_disk_size just updates the block device size from the disk 
> size. Thus calling it from revalidate_disk_size doesn't actually do 

s/revalidate_disk_size/virtblk_update_cache_mode/

> anything.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
