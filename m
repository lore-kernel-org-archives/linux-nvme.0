Return-Path: <SRS0=tyJo=4G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C300EC34026
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2020 15:55:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D2F8207FD
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2020 15:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j1XaHb10";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="Pd8TlXxr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="Ona4IlGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2F8207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=seagate.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=12nwFgtJ4k0anF6zewjRkgwOJsutoCpVc1kr6c9Xkf0=; b=j1XaHb1080ohpI
	jru6PsiZt4d6k/BzOnVtk1M74A3GL4v8lftH5qwCz4QfjO65wff5/d1gBVxgoxLHNWor5boLhpg/o
	b166PIbHRPyjQfnr8vhoq3F4dgJsX1RsGdUxAKWSzMDq48oWjSaikbBrcAtHc+ochZcw2/Ol6gQXz
	4prm+NxDmDG1LObr8ZyzyQnfQhxjaQTlCrP6SdrcZ151afOS24GVCNDHFWNaMV+5II0mkoXE3IT8g
	klP4Cb/h3U7MNoO7nLoI9mulm0B7JDNc0IP2H3qGNThz7u/BqL1xXPOsfwgeywcxA0CF/irfEtA/y
	Q6jMJFx9M/siaamwy3Mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j45DR-0004ra-Jy; Tue, 18 Feb 2020 15:55:17 +0000
Received: from mx0b-00003501.pphosted.com ([67.231.152.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j45DN-0004mZ-GS
 for linux-nvme@lists.infradead.org; Tue, 18 Feb 2020 15:55:15 +0000
Received: from pps.filterd (m0075032.ppops.net [127.0.0.1])
 by mx0b-00003501.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01IFlvXE018949
 for <linux-nvme@lists.infradead.org>; Tue, 18 Feb 2020 10:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=proofpoint;
 bh=kSDqbBAaWJOPcd7RVa5GGBLqUbqCfZEQDaf8+NwB1Nc=;
 b=Pd8TlXxrRMOfmLTHuJsp2iJVyPTeke5+u0mwVxNXf+bKYpNlKQ2PwniZy8NOzupiV7dq
 tNzJLOM5TnpewPQNA/ttBAuowmjz8MqhaUS3CUr4I4W/W/3LgXRkMr/iHH92HcuVbF9T
 xIHqI03bScVyktpfGp1E902Koz1iK4e8rDzw/xga1pnGnxqiAIXl83UZltbxxPaGo+tV
 Zm19QrO4PLKa4xg3hmYxFEy7Q9fW/aX0MTNx0PnmBAhTL2E812PkXNYiMuHY3lzyxD0C
 neP1cfO/meSy1IjFye62pA+O1Wx0LMkIa3pKYE27evlXwBo3B2gKZXEE/dzyPt6ObHnp YA== 
Authentication-Results: seagate.com;
 dkim=pass header.d=seagate.com header.s=google
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 by mx0b-00003501.pphosted.com with ESMTP id 2y8598uhp0-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 18 Feb 2020 10:55:09 -0500
Received: by mail-wr1-f71.google.com with SMTP id w6so11026930wrm.16
 for <linux-nvme@lists.infradead.org>; Tue, 18 Feb 2020 07:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kSDqbBAaWJOPcd7RVa5GGBLqUbqCfZEQDaf8+NwB1Nc=;
 b=Ona4IlGEcWZfh6ckDkpNYiNAcM2nQ7bwfAeS48H8KPa2P0iukl4xAXOENVc/XNfbrn
 afmuQNGns01izKW0uYNYYIfCtdkYzZxwtAbcUBQzl3HjMoJxZ7jm7BEKW+DILBxfTLpT
 w0h07QcLENsXoz3Omv9EeIxaHIThy3KPJzWqPXj1BHhrRCV18cn8LhgZs8WRT428OUt2
 3JXrKNcIAWrUp1YAN1a5QG/0xKYJkyYVSsp5d7FM50esKgIk0gmnKrj77yAKYjgUqKzT
 fuXxdo0J7ApMUdMGmiL8JXHuVHddwvPhzf6yobCQtWTQzVrQzvjwmGDiQkIt2O/PRWcM
 tB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kSDqbBAaWJOPcd7RVa5GGBLqUbqCfZEQDaf8+NwB1Nc=;
 b=E+mYe8PlDiBmFyYsLXEjGiLn4Tb5TcWZZTqqJXe1f711dQjJTgVeSSC5eUU/mVdS+p
 98YQE97l4EkViJPLo8qcd/ffdy5UQ7h7SxU1xu6xUsp+s4UNWwQ3gBa6SivZKAbha4jV
 odk4nV7qaLsVFTKt4zoKTu+TAIJb2B5pHjS0x2aiuNrvlktItJSadZCZ0dLNbyK7tPJZ
 H5wjZDeZ/6hURLMzakw2ONrFNHylBaaLHOfIYUfroxHoCOm+NqUkGemhMvBfJyiiPlb2
 tv6clOiCRUBMMySqhe1OUdmTS4+hqbzwFD6UwYFPt+0bPzSsoe96K4I7UjWv6zi9rc5q
 12cQ==
X-Gm-Message-State: APjAAAXxAs7u1jIPQIJO2SM4ahPGXWOKocC9LSj7K42Iv2oNUcbb61rF
 5olw3eCID9MwRTI2u5PeOVhjjPp0pfHLZBRzKVDFsV/EsqfFGG468tj215aHVN6jbofiNeCMGgf
 UnANkgHkVdux821yysf1AYvaO/DZ7MslwvBAUq6HWU6c+VsekopZYsF5eMt66070po8rI
X-Received: by 2002:a7b:c152:: with SMTP id z18mr3848792wmi.70.1582041306539; 
 Tue, 18 Feb 2020 07:55:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7kjtcwQBU6hxW2ktpZzuRb16b7GW1dpbZK+0FbadMiM6j4qD6QT740JsUZrXMIpAxofZZ3R6I5bUS+Tr8rZ8=
X-Received: by 2002:a7b:c152:: with SMTP id z18mr3848736wmi.70.1582041306110; 
 Tue, 18 Feb 2020 07:55:06 -0800 (PST)
MIME-Version: 1.0
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p>
 <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
 <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <yq1blq3rxzj.fsf@oracle.com>
 <CANo=J16cDBUDWdV7tdY33UO0UT0t-g7jRfMVTxZpePvLew7Mxg@mail.gmail.com>
 <yq1r1yzqfyb.fsf@oracle.com> <2d66bb0b-29ca-6888-79ce-9e3518ee4b61@suse.de>
 <20200214144007.GD9819@redsun51.ssa.fujisawa.hgst.com>
 <d043a58d-6584-1792-4433-ac2cc39526ca@suse.de>
 <20200214170514.GA10757@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20200214170514.GA10757@redsun51.ssa.fujisawa.hgst.com>
From: Tim Walker <tim.t.walker@seagate.com>
Date: Tue, 18 Feb 2020 10:54:54 -0500
Message-ID: <CANo=J17Rve2mMLb_yJNFK5m8wt5Wi4c+b=-a5BJ5kW3RaWuQVg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
To: Keith Busch <kbusch@kernel.org>
X-Proofpoint-PolicyRoute: Outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-18_04:2020-02-18,
 2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 suspectscore=1 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180119
X-Proofpoint-Spam-Policy: Default Domain Policy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200218_075513_675291_5EB2022B 
X-CRM114-Status: GOOD (  29.52  )
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
 linux-scsi <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 14, 2020 at 12:05 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Feb 14, 2020 at 05:04:25PM +0100, Hannes Reinecke wrote:
> > On 2/14/20 3:40 PM, Keith Busch wrote:
> > > On Fri, Feb 14, 2020 at 08:32:57AM +0100, Hannes Reinecke wrote:
> > > > On 2/13/20 5:17 AM, Martin K. Petersen wrote:
> > > > > People often artificially lower the queue depth to avoid timeouts. The
> > > > > default timeout is 30 seconds from an I/O is queued. However, many
> > > > > enterprise applications set the timeout to 3-5 seconds. Which means that
> > > > > with deep queues you'll quickly start seeing timeouts if a drive
> > > > > temporarily is having issues keeping up (media errors, excessive spare
> > > > > track seeks, etc.).
> > > > >
> > > > > Well-behaved devices will return QF/TSF if they have transient resource
> > > > > starvation or exceed internal QoS limits. QF will cause the SCSI stack
> > > > > to reduce the number of I/Os in flight. This allows the drive to recover
> > > > > from its congested state and reduces the potential of application and
> > > > > filesystem timeouts.
> > > > >
> > > > This may even be a chance to revisit QoS / queue busy handling.
> > > > NVMe has this SQ head pointer mechanism which was supposed to handle
> > > > this kind of situations, but to my knowledge no-one has been
> > > > implementing it.
> > > > Might be worthwhile revisiting it; guess NVMe HDDs would profit from that.
> > >
> > > We don't need that because we don't allocate enough tags to potentially
> > > wrap the tail past the head. If you can allocate a tag, the queue is not
> > > full. And convesely, no tag == queue full.
> > >
> > It's not a problem on our side.
> > It's a problem on the target/controller side.
> > The target/controller might have a need to throttle I/O (due to QoS settings
> > or competing resources from other hosts), but currently no means of
> > signalling that to the host.
> > Which, incidentally, is the underlying reason for the DNR handling
> > discussion we had; NetApp tried to model QoS by sending "Namespace not
> > ready" without the DNR bit set, which of course is a totally different
> > use-case as the typical 'Namespace not ready' response we get (with the DNR
> > bit set) when a namespace was unmapped.
> >
> > And that is where SQ head pointer updates comes in; it would allow the
> > controller to signal back to the host that it should hold off sending I/O
> > for a bit.
> > So this could / might be used for NVMe HDDs, too, which also might have a
> > need to signal back to the host that I/Os should be throttled...
>
> Okay, I see. I think this needs a new nvme AER notice as Martin
> suggested. The desired host behavior is simiilar to what we do with a
> "firmware activation notice" where we temporarily quiesce new requests
> and reset IO timeouts for previously dispatched requests. Perhaps tie
> this to the CSTS.PP register as well.
Hi all-

With regards to our discussion on queue depths, it's common knowledge
that an HDD choses commands from its internal command queue to
optimize performance. The HDD looks at things like the current
actuator position, current media rotational position, power
constraints, command age, etc to choose the best next command to
service. A large number of commands in the queue gives the HDD a
better selection of commands from which to choose to maximize
throughput/IOPS/etc but at the expense of the added latency due to
commands sitting in the queue.

NVMe doesn't allow us to pull commands randomly from the SQ, so the
HDD should attempt to fill its internal queue from the various SQs,
according to the SQ servicing policy, so it can have a large number of
commands to choose from for its internal command processing
optimization.

It seems to me that the host would want to limit the total number of
outstanding commands to an NVMe HDD for the same latency reasons they
are frequently limited today. If we assume the HDD would have a
relatively deep (perhaps 256) internal queue (which is deeper than
most latency-sensitive customers would want to run) then the SQ would
be empty most of the time. To me it seems that only when the host's
number of outstanding commands fell below the threshold should the
host add commands to the SQ. Since the drive internal command queue
would not be full, the HDD would immediately pull the commands from
the SQ and put them into its internal command queue.

I can't think of any advantage to running a deep SQ in this scenario.

When the host requests to delete a SQ the HDD should abort the
commands it is holding in its internal queue that came from the SQ to
be deleted, then delete the SQ.

Best regards,
-Tim

-- 
Tim Walker
Product Design Systems Engineering, Seagate Technology
(303) 775-3770

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
