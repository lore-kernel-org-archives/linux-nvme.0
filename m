Return-Path: <SRS0=f2Gy=4C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CEDC352A3
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 00:36:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92AAF217F4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 00:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D2SlOYXQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYwtF5hU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AAF217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fC58RIh+edNbyYxX4gEEzt5tBLOHxUw/+utndCCRw4c=; b=D2SlOYXQGZ9p99
	Kc0anN8qbZKlV5J+MSrYaMUtVALCJe1yCSI5ecC6ctC7hHqeoUWkb0TTb/BhzB5wmQtRpa8gLp03n
	plzXdcoFv0Q2pi4gzL/Lku5M8B7P1HxXIYZDWppBQmRBCMpCDYyr9Su8vz+K8S7iDOo2cEIsNd0Yp
	d+XDdLd9jvoY7lGEYZhzfQB7z1dWnrspeJ02rKhYkTBFyQaR+lMDXY4FKsjAJ0etoewy6oKtp0xR+
	y2fjn6oC2FCmKXreYKpazf1BJWQ8sCzOKFITagGEuCjBsmU27ohRgKtvyIKtYhnztSTT2ho3Z3FaP
	jg/KwX79RZcobk8dI7Xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2Oxr-0007wB-TQ; Fri, 14 Feb 2020 00:36:15 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2Oxi-0007nf-Al
 for linux-nvme@lists.infradead.org; Fri, 14 Feb 2020 00:36:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581640561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ME/CnINQO2pWAEByneP/dtw6TscGVRMxunDfKVudhs=;
 b=YYwtF5hUOjz1IuVh88lXkO4MAi+OVArmZ5Ggpeh+5omr4Sh44xmj4LXmNmoga9DQrhrpP0
 SQICz6KX6isiTpq8qyw5bkIvvStEVybWkGe2I5wbRAHJ7EAe/pvPgK2KIrl/MPGMsvDb4a
 GipbslYTXjqexKN6Mph5l3Q/loXqz/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-5oZdy6SWOIW8J9jkT1Gj2A-1; Thu, 13 Feb 2020 19:35:57 -0500
X-MC-Unique: 5oZdy6SWOIW8J9jkT1Gj2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 979558017CC;
 Fri, 14 Feb 2020 00:35:55 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C53E90095;
 Fri, 14 Feb 2020 00:35:49 +0000 (UTC)
Date: Fri, 14 Feb 2020 08:35:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
Message-ID: <20200214003545.GB4907@ming.t460p>
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p>
 <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
 <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <yq1blq3rxzj.fsf@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <yq1blq3rxzj.fsf@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200213_163606_446573_3699332F 
X-CRM114-Status: GOOD (  16.71  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Tim Walker <tim.t.walker@seagate.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 12, 2020 at 10:02:08PM -0500, Martin K. Petersen wrote:
> 
> Damien,
> 
> > Exposing an HDD through multiple-queues each with a high queue depth
> > is simply asking for troubles. Commands will end up spending so much
> > time sitting in the queues that they will timeout.
> 
> Yep!
> 
> > This can already be observed with the smartpqi SAS HBA which exposes
> > single drives as multiqueue block devices with high queue depth.
> > Exercising these drives heavily leads to thousands of commands being
> > queued and to timeouts. It is fairly easy to trigger this without a
> > manual change to the QD. This is on my to-do list of fixes for some
> > time now (lacking time to do it).
> 
> Controllers that queue internally are very susceptible to application or
> filesystem timeouts when drives are struggling to keep up.
> 
> > NVMe HDDs need to have an interface setup that match their speed, that
> > is, something like a SAS interface: *single* queue pair with a max QD
> > of 256 or less depending on what the drive can take. Their is no
> > TASK_SET_FULL notification on NVMe, so throttling has to come from the
> > max QD of the SQ, which the drive will advertise to the host.
> 
> At the very minimum we'll need low queue depths. But I have my doubts
> whether we can make this work well enough without some kind of TASK SET
> FULL style AER to throttle the I/O.

Looks 32 or sort of works fine for HDD, and 128 is good enough for
SSD.

And this number should drive enough parallelism, meantime timeout can be
avoided most of times if not too small timeout value is set. But SCSI
still allows to adjust the queue depth via sysfs.

Thanks,
Ming


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
