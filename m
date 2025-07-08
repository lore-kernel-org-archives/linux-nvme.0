Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B698FC83030
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 01:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bxRWAschZwxjZ/NDyPK1WTeZlS6Oh3VBdv4rI2QJkPY=; b=vhZbmYCH1DDuPKrPdF6CDJ5gs0
	gNqCFOJ5a6JqSjJIipaqCy3sKLYpEJHZQpu4sRcsyh+VMSZe3XRlu1Rrtk++2NCu1xQIZlJtdpW8u
	YtNCvTLXuKApFkuaGu7mpzy5/PMy9uZHjPfH1UggAkpBIM0TYF9C1iSSY1xuSkATt4J/ShV74N4E5
	jZCIBi7YVcio+F56tkSnHAwhcuDeIeS0vmeWefvLVM7er60GDqnHJ8H7LmN9s2yyCqyysgUuSk+n/
	mCg98VwoKJ5jF0v3xUsg3v6fSWN1g3/I+cRaZ0CEolor7bEOnfA7lYcaCXY7SjyupDajpMGCL9ecF
	vaSNztTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYx7K-00000003y66-0gO4;
	Tue, 08 Jul 2025 01:27:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYx7E-00000003y2d-3kSc
	for linux-nvme@lists.infradead.org;
	Tue, 08 Jul 2025 01:27:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751938043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bxRWAschZwxjZ/NDyPK1WTeZlS6Oh3VBdv4rI2QJkPY=;
	b=NDG2YE4mr+xrE6+88WrpK2CcnnJShhGY2ZTOBAALpwC29uvkv/448DiqUOBnB7Kfh4m3xq
	BV1o8kE5Kftb+HbtaJOCaWjarFS1+Tj10xSsRP9lN3GJXt8XKGBGKjPec+a8W0gWXaD9xo
	cmW86mdcuwrEJstl9+/75zQKNO1crTg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-z9yWvXEnNweP8hSVYutr7g-1; Mon,
 07 Jul 2025 21:27:18 -0400
X-MC-Unique: z9yWvXEnNweP8hSVYutr7g-1
X-Mimecast-MFC-AGG-ID: z9yWvXEnNweP8hSVYutr7g_1751938037
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93F8F1955F38;
	Tue,  8 Jul 2025 01:27:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6D3B30001B1;
	Tue,  8 Jul 2025 01:27:10 +0000 (UTC)
Date: Tue, 8 Jul 2025 09:27:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGxz6s9oUp2FkbyX@fedora>
References: <20250707141834.GA30198@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707141834.GA30198@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_182725_076792_D9312ACB 
X-CRM114-Status: GOOD (  22.12  )
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

On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> I'm a bit lost on what to do about the sad state of NVMe atomic writes.
> 
> As a short reminder the main issues are:
> 
>  1) there is no flag on a command to request atomic (aka non-torn)
>     behavior, instead writes adhering to the atomicy requirements will
>     never be torn, and writes not adhering them can be torn any time.
>     This differs from SCSI where atomic writes have to be be explicitly
>     requested and fail when they can't be satisfied
>  2) the original way to indicate the main atomicy limit is the AWUPF
>     field, which is in Identify Controller, but specified in logical
>     blocks which only exist at a namespace layer.  This a) lead to

If controller-wide AWUPF is a must property, the length has to be aligned
with block size.

>     various problems because the limit is a mess when namespace have
>     different logical block sizes, and it b) also causes additional
>     issues because NVMe allows it to be different for different
>     controllers in the same subsystem.

The spec mentioned clearly that controller AWUPF should be supported by
any namespace format:

```
Atomic Write Unit Power Fail (AWUPF): This field indicates the size of the write
operation guaranteed to be written atomically to the NVM across all namespaces
with any supported namespace format during a power fail or error condition.
```

So I am wondering why nvme driver can't validate NAWUN against AWUPF?


Thanks, 
Ming


