Return-Path: <SRS0=f2Gy=4C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B32CC2BA83
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 17:05:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAEDC20656
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 17:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PeAfftg/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAqU7RRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEDC20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Ydq8gS8wEQ/2EUnpJsVxuAObFePov8bchvgrxtFcTM=; b=PeAfftg/1VA0Mf
	hsfr4Ox1VjB+pW3xDMdomdByETdJ4kwmgQ2JNRit7hoegWmXPbUEkouAOuuZxrzff/WeBICoSF0Yl
	UL1tFvVrqrD684cAF1E8LPi8MjcwES5RJ3oG2+FGzO1sA4eFlcfMapoejtppUE/e77rC2sZ+DuV0b
	nzQOeADZvvtIm6/DxbnXojsEp18ZhsEWqAc3Ll84cceOBwmX6DCizCwdMKA8paFO0eSVxBd9F6/iE
	8VA7V453Him3GnpLWmIMtDuoge/MFaP+fARmR4Nht/pzJovuJ+7GnU9KON8KtrzIb3/G7heGzln/U
	D/9zI+h6gBovhYnVWjIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2eP6-0005tI-3c; Fri, 14 Feb 2020 17:05:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2eP4-0005sq-31
 for linux-nvme@lists.infradead.org; Fri, 14 Feb 2020 17:05:23 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 45A0920656;
 Fri, 14 Feb 2020 17:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581699921;
 bh=cWM9G1+pZU3ZZCBvu3fIWh4fzIRXlhjZcJ8EV4CjiQ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DAqU7RRXAEyU1EJAwzZGw0BmErbfj4k3CaDJbiUIDvJYLuPB0JyLiv0MnAGJgFX0B
 Cb13B6mBmLGphZRZDHyDvsQQ4EkKhDNaR+02nQn+OJGsvPnzmzr0zNZLuSrUNlDTIH
 H9Gun0tLntYG+Npjsw5EEBdjqksgTqKXqXL9kYJA=
Date: Sat, 15 Feb 2020 02:05:14 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
Message-ID: <20200214170514.GA10757@redsun51.ssa.fujisawa.hgst.com>
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p>
 <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
 <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <yq1blq3rxzj.fsf@oracle.com>
 <CANo=J16cDBUDWdV7tdY33UO0UT0t-g7jRfMVTxZpePvLew7Mxg@mail.gmail.com>
 <yq1r1yzqfyb.fsf@oracle.com>
 <2d66bb0b-29ca-6888-79ce-9e3518ee4b61@suse.de>
 <20200214144007.GD9819@redsun51.ssa.fujisawa.hgst.com>
 <d043a58d-6584-1792-4433-ac2cc39526ca@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d043a58d-6584-1792-4433-ac2cc39526ca@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200214_090522_173894_94484E86 
X-CRM114-Status: GOOD (  22.21  )
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

On Fri, Feb 14, 2020 at 05:04:25PM +0100, Hannes Reinecke wrote:
> On 2/14/20 3:40 PM, Keith Busch wrote:
> > On Fri, Feb 14, 2020 at 08:32:57AM +0100, Hannes Reinecke wrote:
> > > On 2/13/20 5:17 AM, Martin K. Petersen wrote:
> > > > People often artificially lower the queue depth to avoid timeouts. The
> > > > default timeout is 30 seconds from an I/O is queued. However, many
> > > > enterprise applications set the timeout to 3-5 seconds. Which means that
> > > > with deep queues you'll quickly start seeing timeouts if a drive
> > > > temporarily is having issues keeping up (media errors, excessive spare
> > > > track seeks, etc.).
> > > > 
> > > > Well-behaved devices will return QF/TSF if they have transient resource
> > > > starvation or exceed internal QoS limits. QF will cause the SCSI stack
> > > > to reduce the number of I/Os in flight. This allows the drive to recover
> > > > from its congested state and reduces the potential of application and
> > > > filesystem timeouts.
> > > > 
> > > This may even be a chance to revisit QoS / queue busy handling.
> > > NVMe has this SQ head pointer mechanism which was supposed to handle
> > > this kind of situations, but to my knowledge no-one has been
> > > implementing it.
> > > Might be worthwhile revisiting it; guess NVMe HDDs would profit from that.
> > 
> > We don't need that because we don't allocate enough tags to potentially
> > wrap the tail past the head. If you can allocate a tag, the queue is not
> > full. And convesely, no tag == queue full.
> > 
> It's not a problem on our side.
> It's a problem on the target/controller side.
> The target/controller might have a need to throttle I/O (due to QoS settings
> or competing resources from other hosts), but currently no means of
> signalling that to the host.
> Which, incidentally, is the underlying reason for the DNR handling
> discussion we had; NetApp tried to model QoS by sending "Namespace not
> ready" without the DNR bit set, which of course is a totally different
> use-case as the typical 'Namespace not ready' response we get (with the DNR
> bit set) when a namespace was unmapped.
> 
> And that is where SQ head pointer updates comes in; it would allow the
> controller to signal back to the host that it should hold off sending I/O
> for a bit.
> So this could / might be used for NVMe HDDs, too, which also might have a
> need to signal back to the host that I/Os should be throttled...

Okay, I see. I think this needs a new nvme AER notice as Martin
suggested. The desired host behavior is simiilar to what we do with a
"firmware activation notice" where we temporarily quiesce new requests
and reset IO timeouts for previously dispatched requests. Perhaps tie
this to the CSTS.PP register as well.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
