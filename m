Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BC1C28CF5
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 07:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ChzXGjDq+n0o2fu8dy3EjJHxjjUhkcJ57NGo6xi+9ws=; b=y79R0sWn4zg0KJyiEzrxici19v
	MZYZKebHK2/AiN+TRnrbZUjEOBEuAciFBbAhXWJJkuyOf00EAUvCf7G08yVMmWqNDuvs6VrMblAAT
	3GIdhjzX8hIxG4By7vbT+u2X/HKOjEhJOuTgv11isZOkcH4Ekcw4FbyRzrhRhPstmg40MaKeg9OrB
	R38G770uh7CcisVW9prtBJmloafKLKFtVEYbGj/Qpv+JGtd2WA79GVwqCho0Nf6dZaVEKL1CWee4f
	A4gSxodt2fmCReQTwgkVu4O8hzR9uczIpopiBv3Qq+bjo1VUqj3s/70yOi8VgyL1QSlYMhlNrVF3j
	Cpvg4jYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCcgO-00AWDQ-On; Wed, 26 Jan 2022 07:25:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCccT-00ATy0-Ce
 for linux-nvme@lists.infradead.org; Wed, 26 Jan 2022 07:21:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643181686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ChzXGjDq+n0o2fu8dy3EjJHxjjUhkcJ57NGo6xi+9ws=;
 b=G6zhpwUeQtEbI0OUDFUmtWXOsZF64lNxjR5ojGvD08JbzpOxOxHwcZBNWnc2jThWR4UgYC
 LwUbk5aHJsMLCRTk8KHS1gXlm3PpupgYlJO2zPJV+Ia8yhFqkFXOoE6APi/Xl8gZoFF/mn
 cqO9Im911OGoFOdQnvQelNwrfoGbI+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-2_DijEOSOzidwZtTm4ux6Q-1; Wed, 26 Jan 2022 02:21:22 -0500
X-MC-Unique: 2_DijEOSOzidwZtTm4ux6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3647A18C89DD;
 Wed, 26 Jan 2022 07:21:21 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECBB410589BC;
 Wed, 26 Jan 2022 07:21:09 +0000 (UTC)
Date: Wed, 26 Jan 2022 15:21:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 05/13] block: only account passthrough IO from userspace
Message-ID: <YfD2YNRf+lhe5BcU@T590>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-6-ming.lei@redhat.com>
 <20220124130555.GD27269@lst.de> <Ye8xleeYZfmwA3D7@T590>
 <20220125061634.GA26495@lst.de> <20220125071906.GA27674@lst.de>
 <Ye++VmBkg0I8Lq8+@T590> <20220126055003.GA21089@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126055003.GA21089@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220125_232129_560453_7172E3ED 
X-CRM114-Status: GOOD (  19.00  )
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

On Wed, Jan 26, 2022 at 06:50:03AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 25, 2022 at 05:09:42PM +0800, Ming Lei wrote:
> > Follows another simple way by accounting all request with bio attached,
> > except for requests with kernel buffer.
> 
> > -	else if (rq->q->disk)
> > +	else if (rq->q->disk && rq->bio)
> >  		rq->part = rq->q->disk->part0;
> 
> Most passthrough requests will have a bio, so you'll still use e.g.
> the sd gendisk for sg request here.
> 
> I think the right way would be to just remove this branch entirely.
> This means we only account bios with a block_device, which implies
> they have a gendisk.

That will not account userspace IO, and people may complain.

We can just account passthrough request from userspace by the patch
in my last email.


Thanks, 
Ming


