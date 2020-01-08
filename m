Return-Path: <SRS0=AClc=25=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91FAC282DD
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 21:32:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873AF206DA
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 21:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LStUIcf1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHBPXVfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873AF206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4qLirGbObSDtfaE0ZRkT8TO79Pc6CXErrIbUVv890IM=; b=LStUIcf17XW3+V
	llK2KvWXeEEjcnWfZZd66i/mrUe975haMYw6r0FB+0+ATDevCxY/8fxPgJz1t1YGFenrgfuTrn8rs
	HR8whlSuqkg1xKRqxhgVXyGHsBFcOVr8YMP+gV11k8CHG8gwSz7POQyHgFrk0VKF3mD7Dg1W4enhi
	psD5uwtexYadr/NVRYGCM9o+qCRlJoYZXDFNXB+FvUgihcjA7a6zGQKBaPFnlVIrYxay6FtcUkq9j
	S7uf0Tjj4DAKBzDqL0sRa2cyqUjq45MS81py1LibRTPjQgOjvMDgiVvzyHtShIP5oDTIF9DZ8aw3C
	+Zp9+T8uCnqQOuQ0W4ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipIwY-0007Ek-3c; Wed, 08 Jan 2020 21:32:46 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipIwU-0007DX-IK
 for linux-nvme@lists.infradead.org; Wed, 08 Jan 2020 21:32:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578519161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2Tl300doSUHOEtlULkq/YaFUqcc7K1ac46TaKPX0Ws=;
 b=RHBPXVfWHxC5fY090qFeY0PpbeGYdqwRXs19lXhHsyRUkOsXuSzri0LTFTE21Yc7P4C94i
 y8AD5BkKjUab+rOvB8++US3o91rxXfJPAxz5XjobOx05fpOiiWMeLlfMv3dDKYHNT4xU2W
 B0xXnepfk32ig+5vDPwZ/LxW6nxAFXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-4JXflz8VOOWLa-f3AACnGQ-1; Wed, 08 Jan 2020 16:32:37 -0500
X-MC-Unique: 4JXflz8VOOWLa-f3AACnGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C190800D48;
 Wed,  8 Jan 2020 21:32:32 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E33A586C54;
 Wed,  8 Jan 2020 21:32:28 +0000 (UTC)
Message-ID: <8339b890eec74c423fa2260a90fcc2154cf05b53.camel@redhat.com>
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
From: "Ewan D. Milne" <emilne@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, "Singh, Balbir"
 <sblbir@amazon.com>
Date: Wed, 08 Jan 2020 16:32:28 -0500
In-Reply-To: <yq1blre1vwr.fsf@oracle.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-6-sblbir@amazon.com> <yq1blrg2agh.fsf@oracle.com>
 <bc0575f1bb565f3955a411032f97163b2a5bd832.camel@amazon.com>
 <yq1blre1vwr.fsf@oracle.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_133242_681996_FCA4C72E 
X-CRM114-Status: GOOD (  14.11  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "mst@redhat.com" <mst@redhat.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Sangaraju,
 Someswarudu" <ssomesh@amazon.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, 2020-01-07 at 22:15 -0500, Martin K. Petersen wrote:
> Balbir,
> 
> > > We already emit an SDEV_EVT_CAPACITY_CHANGE_REPORTED event if device
> > > capacity changes. However, this event does not automatically cause
> > > revalidation.
> > 
> > The proposed idea is to not reinforce revalidation, unless explictly
> > specified (in the thread before Bob Liu had suggestions). The goal is
> > to notify user space of changes via RESIZE. SCSI sd can opt out of
> > this IOW, I can remove this if you feel
> > SDEV_EVT_CAPACITY_CHANGE_REPORTED is sufficient for current use cases.

Remember that this event is generated because of a Unit Attention from
the device.  We are only passing on this indication to udev.  It basically
allows automation without having to scrape the log file.  We don't proactively
look. e.g. in the case of SCSI unless you have commands being sent to the
device to return the UA status you won't hear about it.

> 
> I have no particular objection to the code change. I was just observing
> that in the context of sd.c, RESIZE=1 is more of a "your request to
> resize was successful" notification due to the requirement of an
> explicit userland action in case a device reports a capacity change.
> 



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
