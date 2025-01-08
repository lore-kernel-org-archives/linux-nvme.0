Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237CBE7719A
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 02:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BUmFn0QdcbnrP+kAJCEAifsFmvKuEgoz5SMuFeJiqRM=; b=VXD0InzpY9DoZODkTydcfADZok
	iR4CP7dLtx6CFSRGqDEHkUbrbYOeRvjv2vIBgZLOf/EpbHdp92D5zmeUAMwWgqLH7evm6tQLtTWLW
	nzncvOZ+BSOwtVOeLAwq8AIyc0Cm1AUbm9UjzP2iSdTpnqpcrLKiVdtP5hbhLIDPxq93yngvpgABl
	fkietABQ9WF/7zybvsSQGIZGCrKnJn3RANbnHxJNIPuAagEoezp1JBXq6+J7gEtJvG6gE1t831/Db
	22XS6UIUXZQqHoJHiDnoCD59uYh8UBoUzo4UTPp/cVQZArZS1SARj0BJrW4LsJBNYLQovT4AQZZ2U
	hUCnwe0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVLpb-00000006uPU-0eQx;
	Wed, 08 Jan 2025 02:30:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVLjm-00000006t5l-2acJ
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 02:24:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736303041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BUmFn0QdcbnrP+kAJCEAifsFmvKuEgoz5SMuFeJiqRM=;
	b=Swz7kZN32U+G/SvlZaricwWEhlhR3H/Bvo5rMxrFcFnsYQCYnQmhtdfjm50StjLoVe+/HK
	11+aK5Mor2AbJhaJ/NtGafRK0qhJWuHKB8Cjr4CTkceSW59tTmdx9slX8zq9hBo1M/7JtM
	O5j+I03UB9c8Ew5CE8Y6zzb92Hv2TK0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-rFxU6K-JNFO5J-Hw5JdVVw-1; Tue,
 07 Jan 2025 21:22:07 -0500
X-MC-Unique: rFxU6K-JNFO5J-Hw5JdVVw-1
X-Mimecast-MFC-AGG-ID: rFxU6K-JNFO5J-Hw5JdVVw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D476919560BE;
	Wed,  8 Jan 2025 02:22:04 +0000 (UTC)
Received: from fedora (unknown [10.72.116.126])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E153D3000197;
	Wed,  8 Jan 2025 02:21:58 +0000 (UTC)
Date: Wed, 8 Jan 2025 10:21:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: fix queue freeze and limit locking order
Message-ID: <Z33hQfkbolsku7yr@fedora>
References: <20250107063120.1011593-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107063120.1011593-1-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_182402_978918_544B52D3 
X-CRM114-Status: GOOD (  14.67  )
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

On Tue, Jan 07, 2025 at 07:30:32AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this is my version of Damien's "Fix queue freeze and limit locking order".
> A lot looks very similar, but it was done independently based on the
> previous discussion.
> 
> Changes since RFC:
>  - fix a bizzare virtio_blk bisection snafu
>  - set BLK_FEAT_POLL a little less eagerly for blk-mq
>  - drop the loop patch just adding a comment
>  - improve various commit logs and coments
> 

loop_set_block_size() needs same change, can you cover it to this series?

Thanks,
Ming


