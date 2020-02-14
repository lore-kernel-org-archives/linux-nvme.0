Return-Path: <SRS0=f2Gy=4C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D449AC2BA83
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 14:40:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC6822314
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 14:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lvOyBoZv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSBxjsv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC6822314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZIjH8q6zeIzywBzHNtBqq9tPQqSHZ0z6QWHGQfcas7E=; b=lvOyBoZv/lyh5m
	QfHHEbphYtWh4CVO4k8e3OYfaAuR46K1xXLRNM/re86odPW7ZEJRObniU4i0pRBtDruhpULxMLaiC
	q9pvDXaN+s0Dg/RWzkCv4qbDi/DjpAfAOy8gQdd0Dm3UYpuop2DmRIAowUs/PFUKgzrTJzDwSA14y
	t6tvma5zqgrOB1e06EB+xL8EVzPgA9maDtX1MeG4/hUXan1j98BawmuiOABAnfk6Li1KjbCQYwTQI
	0Vt83cK2I3wxVBn+N+1hqNPXfR7MnTUAQs0uqKpwXI8bJMnzzeu2h3xboZ+NhXkQO7prmcAoXcGhO
	QxRZJ8i5YtJbXp/StCKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2c8f-0005jC-8w; Fri, 14 Feb 2020 14:40:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2c8c-0005im-KZ
 for linux-nvme@lists.infradead.org; Fri, 14 Feb 2020 14:40:15 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 23A382187F;
 Fri, 14 Feb 2020 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581691214;
 bh=mH5i6V3YTMULw6H6EwUEg5VymMpkbQ9unTGmkWMJHw0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RSBxjsv7GyGJhd5Tv6ppSe4iLV+As/SfqLKHeujuydizvxrBM+N3DzUBweJfetWPm
 YGerA1vuipxeTZRNMLqQYLyP6xaqElvmx0eYrnzH/brjKtXWHL2ETNESFs5UYX4bga
 yr/ufxeOHFtFFAJak/Lhio4plQw85jwOA9fBDy2E=
Date: Fri, 14 Feb 2020 23:40:07 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
Message-ID: <20200214144007.GD9819@redsun51.ssa.fujisawa.hgst.com>
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p>
 <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
 <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <yq1blq3rxzj.fsf@oracle.com>
 <CANo=J16cDBUDWdV7tdY33UO0UT0t-g7jRfMVTxZpePvLew7Mxg@mail.gmail.com>
 <yq1r1yzqfyb.fsf@oracle.com>
 <2d66bb0b-29ca-6888-79ce-9e3518ee4b61@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2d66bb0b-29ca-6888-79ce-9e3518ee4b61@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200214_064014_696217_C557EC62 
X-CRM114-Status: GOOD (  11.26  )
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi <linux-scsi@vger.kernel.org>, Tim Walker <tim.t.walker@seagate.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 14, 2020 at 08:32:57AM +0100, Hannes Reinecke wrote:
> On 2/13/20 5:17 AM, Martin K. Petersen wrote:
> > People often artificially lower the queue depth to avoid timeouts. The
> > default timeout is 30 seconds from an I/O is queued. However, many
> > enterprise applications set the timeout to 3-5 seconds. Which means that
> > with deep queues you'll quickly start seeing timeouts if a drive
> > temporarily is having issues keeping up (media errors, excessive spare
> > track seeks, etc.).
> > 
> > Well-behaved devices will return QF/TSF if they have transient resource
> > starvation or exceed internal QoS limits. QF will cause the SCSI stack
> > to reduce the number of I/Os in flight. This allows the drive to recover
> > from its congested state and reduces the potential of application and
> > filesystem timeouts.
> > 
> This may even be a chance to revisit QoS / queue busy handling.
> NVMe has this SQ head pointer mechanism which was supposed to handle
> this kind of situations, but to my knowledge no-one has been
> implementing it.
> Might be worthwhile revisiting it; guess NVMe HDDs would profit from that.

We don't need that because we don't allocate enough tags to potentially
wrap the tail past the head. If you can allocate a tag, the queue is not
full. And convesely, no tag == queue full.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
