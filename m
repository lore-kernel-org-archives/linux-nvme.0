Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA44C433B4
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 09:28:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EED661209
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 09:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EED661209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E45tg3KqzG/Obn1Nsiyh5nuRLsktliTwSdOP82gZiYQ=; b=AuFhoxdMqdmyb9g8i/d8MwtNw
	JPOTy3j3rWh3koghatvIzHR8QJ9gbqC9+c02cMER7IFCLUHmkjBGxJjR8jI8hwkvQz8aLt1ZMjuKC
	Ky1OH4z0AhWUpbEo9u4Zuz8O9hwIdFp7qca1RtAapdoQAHo2m6G1WMYiRT71EnSmAPG+rqvbrVkvp
	P7DxFJMjt+3pBckGlriwov/dgdDSf7gB7HLFN1wz6CfiDrWlCbKy9B3P503foD6XtUS44kpb0KvWa
	7c8ieC5FS1UWxJ4F0UrlSJ2foCiy6vFw7Wf5GfVfZws9OciHYn2UHHbgI2alda7Qz2vNwRJESTUJ7
	4te1fBPAg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lab3P-005Mj2-N5; Sun, 25 Apr 2021 09:27:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lab3N-005Miu-9T
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 09:27:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=RjtHhf1h2GPdx4OubhfVpPhMn9ZwNKESK31goEka/aE=; b=YIDI3+N5qUT+jHalO9qNmShIS3
 bYgYqHqI+wmhHEOZnCsHWcEI7oCyhnmdc82L+1SCjDhPUwCP2Oj9TXT1IMqnn1X7XIRQ3O6IBtQ/v
 0cSb8AIl+s5OPhSi1x8NPCD1Zh12e/grU9F6pDhAmIVrjFL9EtQMbV3NholIa6nQbGsv0auBb5g97
 e6Nw6dpRstNKoBqm92+lL3LB2yrB6W0BHHgBw+wydAJak5GlqOt/0aa0HmxZYX/XnU69B+tifqxrf
 gnb8umWa456YZrxxSTSDh0Tmf2cyP1Fw2cuqB/v4iFmUCzX8lG4S9c56oLC/zJv1oDdLg7WGtPNAu
 Yd51UKlw==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lab3K-00FNWI-LU
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 09:27:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619342865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RjtHhf1h2GPdx4OubhfVpPhMn9ZwNKESK31goEka/aE=;
 b=KTpjcIuWQT92TeE1K02kF6yo/mXlwX01J7bsgOxN8b0Txvi1iL/k5KWtgdzHdMabDEUGk1
 e3kqgpFLBDcx4SjY9dpaXvu4wbaguYovblgUl+9t/QshHfkm/K0foWZFxNcvcVUdL3ZB/Z
 1/MxO6Uf0G/a3H/pApbcuzcvDcq5rBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-GqeOQ1fnNlejx8ljXbLlEg-1; Sun, 25 Apr 2021 05:27:43 -0400
X-MC-Unique: GqeOQ1fnNlejx8ljXbLlEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B46610053E7;
 Sun, 25 Apr 2021 09:27:41 +0000 (UTC)
Received: from T590 (ovpn-13-143.pek2.redhat.com [10.72.13.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63BFF5B4A1;
 Sun, 25 Apr 2021 09:27:31 +0000 (UTC)
Date: Sun, 25 Apr 2021 17:27:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH 0/8] blk-mq: fix request UAF related with iterating over
 tagset requests
Message-ID: <YIU2BhuYZAAgonN0@T590>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210425085753.2617424-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_022746_803984_28E342A6 
X-CRM114-Status: GOOD (  13.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Apr 25, 2021 at 04:57:45PM +0800, Ming Lei wrote:
> Hi Guys,
> 
> Revert 4 patches from Bart which try to fix request UAF issue related
> with iterating over tagset wide requests, because:
> 
> 1) request UAF caused by normal completion vs. async completion during
> iterating can't be covered[1]
> 
> 2) clearing ->rqs[] is added in fast path, which causes performance loss
> by 1% according to Bart's test
> 
> 3) Bart's approach is too complicated, and some changes aren't needed,
> such as adding two versions of tagset iteration

4) synchronize_rcu() is added before shutting down one request queue,
which may slow down reboot/poweroff very much on big systems with lots of
HBAs in which lots of LUNs are attached.

5) freeing request pool in updating nr_requests isn't covered.

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
