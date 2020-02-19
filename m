Return-Path: <SRS0=nRQ2=4H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2971BC34031
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 01:32:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04C6207FD
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 01:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DcnBWhYk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cswxiv4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04C6207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aqWqlK1PaeYQQBXPkv3N13kTSn816kAtmkp+53WP2jc=; b=DcnBWhYk9NWXZr
	399a0uASTNadw/E52QcOyvYY4JT1KKIIM8AKarFwzdtnGFrtp8HbGrvKDbtrkibhQpvegQEypRBQw
	Rb2ofhrET7S75/+3MNDz36tlTyZV3Vklimv09SWHps3RQNOoRf1ErCQGnZ4kuK2yRDLWpTVCTOVX+
	Z4X2nPx8Kei8+GNnox7DPwEYvza6bPF7Y1WeEwBWOlcV7DK2iMdLQSGrFaTdGTsqcxxxQXNh1/u70
	p2neAHWL91WLlZLz43w8XboBzhROuKv+S8ysXSgKRzq2933UPJ2r/XuRaAb3siKWYJJ3252xKRE9v
	fucp1kxNVgPQznSrt5Sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4EDg-0007e3-TN; Wed, 19 Feb 2020 01:32:08 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4EDe-0007cj-5V
 for linux-nvme@lists.infradead.org; Wed, 19 Feb 2020 01:32:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582075918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zVYL+QbOz6z8x8H9e6MwpzZamAakZ5n5YLc7miQ2518=;
 b=Cswxiv4SxDk0VNa22bM5LSLBvj0gl2ZGB7bM+Vrn3K10q49qEJPe+Zk1+K9dKK3HkArGXO
 0vm7OrUh6m7P2GxrIvoCbvZQbfFNfMJ7DrtOs3yvDx4Io+9fByE6il342qZ4lMH0QuCrUT
 bhMZFkkfIgJ7tQS9qf9Lvvo3ceQFVhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-9ETsOWYJP5KwewucCzzY8g-1; Tue, 18 Feb 2020 20:31:51 -0500
X-MC-Unique: 9ETsOWYJP5KwewucCzzY8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C2E78010C7;
 Wed, 19 Feb 2020 01:31:50 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6167A5D9E5;
 Wed, 19 Feb 2020 01:31:41 +0000 (UTC)
Date: Wed, 19 Feb 2020 09:31:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
Message-ID: <20200219013137.GA31488@ming.t460p>
References: <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <yq1blq3rxzj.fsf@oracle.com>
 <CANo=J16cDBUDWdV7tdY33UO0UT0t-g7jRfMVTxZpePvLew7Mxg@mail.gmail.com>
 <yq1r1yzqfyb.fsf@oracle.com>
 <2d66bb0b-29ca-6888-79ce-9e3518ee4b61@suse.de>
 <20200214144007.GD9819@redsun51.ssa.fujisawa.hgst.com>
 <d043a58d-6584-1792-4433-ac2cc39526ca@suse.de>
 <20200214170514.GA10757@redsun51.ssa.fujisawa.hgst.com>
 <CANo=J17Rve2mMLb_yJNFK5m8wt5Wi4c+b=-a5BJ5kW3RaWuQVg@mail.gmail.com>
 <20200218174114.GA17609@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200218174114.GA17609@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200218_173206_284913_A9EA5181 
X-CRM114-Status: GOOD (  19.72  )
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
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 19, 2020 at 02:41:14AM +0900, Keith Busch wrote:
> On Tue, Feb 18, 2020 at 10:54:54AM -0500, Tim Walker wrote:
> > With regards to our discussion on queue depths, it's common knowledge
> > that an HDD choses commands from its internal command queue to
> > optimize performance. The HDD looks at things like the current
> > actuator position, current media rotational position, power
> > constraints, command age, etc to choose the best next command to
> > service. A large number of commands in the queue gives the HDD a
> > better selection of commands from which to choose to maximize
> > throughput/IOPS/etc but at the expense of the added latency due to
> > commands sitting in the queue.
> > 
> > NVMe doesn't allow us to pull commands randomly from the SQ, so the
> > HDD should attempt to fill its internal queue from the various SQs,
> > according to the SQ servicing policy, so it can have a large number of
> > commands to choose from for its internal command processing
> > optimization.
> 
> You don't need multiple queues for that. While the device has to fifo
> fetch commands from a host's submission queue, it may reorder their
> executuion and completion however it wants, which you can do with a
> single queue.
>  
> > It seems to me that the host would want to limit the total number of
> > outstanding commands to an NVMe HDD
> 
> The host shouldn't have to decide on limits. NVMe lets the device report
> it's queue count and depth. It should the device's responsibility to

Will NVMe HDD support multiple NS? If yes, this queue depth isn't
enough, given all NSs share this single host queue depth.

> report appropriate values that maximize iops within your latency limits,
> and the host will react accordingly.

Suppose NVMe HDD just wants to support single NS and there is single queue,
if the device just reports one host queue depth, block layer IO sort/merge
can only be done when there is device saturation feedback provided.

So, looks either NS queue depth or per-NS device saturation feedback
mechanism is needed, otherwise NVMe HDD may have to do internal IO
sort/merge.


Thanks,
Ming


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
