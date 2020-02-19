Return-Path: <SRS0=nRQ2=4H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE83C34047
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 16:29:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB582067D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 16:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gri/blOf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="0YdfWtcy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="MLX9vbFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB582067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=seagate.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=68EriVpjRhqMoazdXbon70UXvSdnQVSFYxXkT5bprrA=; b=gri/blOfUIki62
	5p4LOOWhTrvqzVOBKlypAV+W0D46bRWHgk2x+DjSd69KeBf0JprNIBVxkKbO7BAZpyZct2TWiHtPX
	oz6e0jb4fJ6aHg9w2k5eaNASNcgQ9cTATrl6/Nl9/HKMhNwigtSTrEAOsNkM8HjRqNoJ5zcauZHbk
	V0IZOgxwQfxHZeS897dWoV4UR9CS0I2XVr+OGpqiAo3tvHsWjQ32EcsAJX93wwIYDCcZwTUxFAqPV
	IjJOphBdhH11DbXkhCrT931oVxhSyim2qF6U5mOJshEn14OlwTSYMYk5K05gBRrSzVUQOx/2tMTZc
	kL5LOfvC3oNCAR6vY4QQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4SDx-00035C-Sg; Wed, 19 Feb 2020 16:29:21 +0000
Received: from mx0a-00003501.pphosted.com ([67.231.144.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4SDu-00034m-WA
 for linux-nvme@lists.infradead.org; Wed, 19 Feb 2020 16:29:20 +0000
Received: from pps.filterd (m0075555.ppops.net [127.0.0.1])
 by mx0a-00003501.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01JGTGAQ010018
 for <linux-nvme@lists.infradead.org>; Wed, 19 Feb 2020 11:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type : content-transfer-encoding; s=proofpoint;
 bh=1lxPn5J8l7sAgo/GHD0tAxkrMHXMjx4BXV7yqQDCzqc=;
 b=0YdfWtcyZRSlaV4APnz7JncVJr5FNIRt30VCaZRLupPXF6dA6F8/Xg9c9I+vFiEXD1rv
 KzJ0N2dikcpj7+AWVtdtaARosbeOa48awnxtfdW2zOjpMq4/BN7rggQHkYvN3SHvZf+s
 4NxQeSOQLIuXUPzR9l9v7Qp0DELBZhxZTT0NpU/937ZdQIly2MgeVrn2oty4ojQQBVph
 y+mcB0nfSZabqJL/8r5aE8zqSvCM+ZGMhotlyN6h/xNu7lCK7qkD6UZRPSPaCu8xNLZ3
 bprmLvCCExuOChX3kI42VKGyDxQcyxj9kE0NrWU2eWZLw35kreDPcodRKMUwaovwXkZ8 0w== 
Authentication-Results: seagate.com;
 dkim=pass header.d=seagate.com header.s=google
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 by mx0a-00003501.pphosted.com with ESMTP id 2y8ubmkkd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 19 Feb 2020 11:29:16 -0500
Received: by mail-wr1-f71.google.com with SMTP id w6so320861wrm.16
 for <linux-nvme@lists.infradead.org>; Wed, 19 Feb 2020 08:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1lxPn5J8l7sAgo/GHD0tAxkrMHXMjx4BXV7yqQDCzqc=;
 b=MLX9vbFbP65j85qKNvipcw9YLHTREF9ax9V+7I+oo8m0JvELcjUItp2Rt1s7EPiGlL
 7WRxk3feo/AdV/bzIqoojrVBpExiOh+jy8qhKCWMLQNdYUt0Ysc8QFhihFbEFyA1IHAr
 DgcyFotHHbjD4t1ycWeyHx1dvhZn0eCZRoTqxwnvAvDukbU/3HZjnfJVPBDJ5+PEo5Rs
 aRHZCffPq1lEovYxwVkY+nt7B4xFkBY/9pG9q251XbY+cVBvj94xtA7h7BTimKEbtdp4
 g2Oaz5FqR5gQKXkESBmTWxnt1EvwV7YiVAfk7pOfbvODkyD+CZ1DAqCyJkH3VVNggcNH
 VQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1lxPn5J8l7sAgo/GHD0tAxkrMHXMjx4BXV7yqQDCzqc=;
 b=USZ0jTLM+oEhV/jgc95HXLGNXJHG1qNAFPg9qKVsFYgd7oo11gq+e5qG2/EL2z31Gv
 t1dphoyxQzVrULRkhWL64ev8xTmlRNHRkV6KwqknuBI4DZtvOw/ZZ54TCCrj2sTG4VGu
 KyjKoF4UWOLY/mMYns4YUyovaWkGNuQcClERzrjvIucpx8fhmLlgWvgc82XnAHQDVEm9
 IOm7uoxKP5+hmezxuqCqk+AGDHyV4fbLk0eo75a4qmJY4uvFW7NhiKmmHzyOvoX8fC9c
 O9+l7nX7FUCBsEKtsSGv5cSIpM7uE+uhsE8UPD4mZpJCXw0/vV6VCPHEudhCXNFrGxAv
 x0Pg==
X-Gm-Message-State: APjAAAW7gQfsd5m3BcPJuqreH15JRIJ/YUfFNUPzTnNdKmmIMfPcYEJv
 YsdCiuV3rnP7dMWKFbOqMhyMIbg0H8L2D/nKCXD0hApfIUPjIKjY67mVI6n5ZYVr1HJYWaERyHK
 aZ78MHa9cZylb8eJ9M8L61vN9JNBDGo5jBJE7rOoOe7N03CBk9RbJb+9StO2mAeLfxZ1b
X-Received: by 2002:a1c:5f8a:: with SMTP id
 t132mr11069679wmb.162.1582129739603; 
 Wed, 19 Feb 2020 08:28:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpZjopGkNRUbUmjFCRC/J5GZcSk0RT7uEgunWC5mKDJRnefetL+ahyCqNcjJoya29Md6LjRgQsTIKgBBDakj0=
X-Received: by 2002:a1c:5f8a:: with SMTP id
 t132mr11069640wmb.162.1582129739117; 
 Wed, 19 Feb 2020 08:28:59 -0800 (PST)
MIME-Version: 1.0
References: <CANo=J16cDBUDWdV7tdY33UO0UT0t-g7jRfMVTxZpePvLew7Mxg@mail.gmail.com>
 <yq1r1yzqfyb.fsf@oracle.com> <2d66bb0b-29ca-6888-79ce-9e3518ee4b61@suse.de>
 <20200214144007.GD9819@redsun51.ssa.fujisawa.hgst.com>
 <d043a58d-6584-1792-4433-ac2cc39526ca@suse.de>
 <20200214170514.GA10757@redsun51.ssa.fujisawa.hgst.com>
 <CANo=J17Rve2mMLb_yJNFK5m8wt5Wi4c+b=-a5BJ5kW3RaWuQVg@mail.gmail.com>
 <20200218174114.GA17609@redsun51.ssa.fujisawa.hgst.com>
 <20200219013137.GA31488@ming.t460p>
 <BYAPR04MB58165C6B400AE30986F988D5E7100@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20200219021540.GC31488@ming.t460p>
 <BYAPR04MB5816DF16BC3720ABF286671EE7100@BYAPR04MB5816.namprd04.prod.outlook.com>
 <CANo=J15Wvm2R+vuLj6QQ5Vete507cA==5Rw=4vn3Z8npZ=2vww@mail.gmail.com>
In-Reply-To: <CANo=J15Wvm2R+vuLj6QQ5Vete507cA==5Rw=4vn3Z8npZ=2vww@mail.gmail.com>
From: Tim Walker <tim.t.walker@seagate.com>
Date: Wed, 19 Feb 2020 11:28:46 -0500
Message-ID: <CANo=J14GM=Uu7qWirtvgzjEKVCzLV0nZLOOPqD9M+nwOKrv7yQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
To: Damien Le Moal <Damien.LeMoal@wdc.com>
X-Proofpoint-PolicyRoute: Outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-19_04:2020-02-19,
 2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190125
X-Proofpoint-Spam-Policy: Default Domain Policy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200219_082919_049499_B9DAC847 
X-CRM114-Status: GOOD (  40.91  )
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
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 18, 2020 at 9:56 PM Tim Walker <tim.t.walker@seagate.com> wrote:
>
> On Tue, Feb 18, 2020 at 9:32 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> >
> > On 2020/02/19 11:16, Ming Lei wrote:
> > > On Wed, Feb 19, 2020 at 01:53:53AM +0000, Damien Le Moal wrote:
> > >> On 2020/02/19 10:32, Ming Lei wrote:
> > >>> On Wed, Feb 19, 2020 at 02:41:14AM +0900, Keith Busch wrote:
> > >>>> On Tue, Feb 18, 2020 at 10:54:54AM -0500, Tim Walker wrote:
> > >>>>> With regards to our discussion on queue depths, it's common knowledge
> > >>>>> that an HDD choses commands from its internal command queue to
> > >>>>> optimize performance. The HDD looks at things like the current
> > >>>>> actuator position, current media rotational position, power
> > >>>>> constraints, command age, etc to choose the best next command to
> > >>>>> service. A large number of commands in the queue gives the HDD a
> > >>>>> better selection of commands from which to choose to maximize
> > >>>>> throughput/IOPS/etc but at the expense of the added latency due to
> > >>>>> commands sitting in the queue.
> > >>>>>
> > >>>>> NVMe doesn't allow us to pull commands randomly from the SQ, so the
> > >>>>> HDD should attempt to fill its internal queue from the various SQs,
> > >>>>> according to the SQ servicing policy, so it can have a large number of
> > >>>>> commands to choose from for its internal command processing
> > >>>>> optimization.
> > >>>>
> > >>>> You don't need multiple queues for that. While the device has to fifo
> > >>>> fetch commands from a host's submission queue, it may reorder their
> > >>>> executuion and completion however it wants, which you can do with a
> > >>>> single queue.
> > >>>>
> > >>>>> It seems to me that the host would want to limit the total number of
> > >>>>> outstanding commands to an NVMe HDD
> > >>>>
> > >>>> The host shouldn't have to decide on limits. NVMe lets the device report
> > >>>> it's queue count and depth. It should the device's responsibility to
> > >>>
> > >>> Will NVMe HDD support multiple NS? If yes, this queue depth isn't
> > >>> enough, given all NSs share this single host queue depth.
> > >>>
> > >>>> report appropriate values that maximize iops within your latency limits,
> > >>>> and the host will react accordingly.
> > >>>
> > >>> Suppose NVMe HDD just wants to support single NS and there is single queue,
> > >>> if the device just reports one host queue depth, block layer IO sort/merge
> > >>> can only be done when there is device saturation feedback provided.
> > >>>
> > >>> So, looks either NS queue depth or per-NS device saturation feedback
> > >>> mechanism is needed, otherwise NVMe HDD may have to do internal IO
> > >>> sort/merge.
> > >>
> > >> SAS and SATA HDDs today already do internal IO reordering and merging, a
> > >> lot. That is partly why even with "none" set as the scheduler, you can see
> > >> iops increasing with QD used.
> > >
> > > That is why I asked if NVMe HDD will attempt to sort/merge IO among SQs
> > > from the beginning, but Tim said no, see:
> > >
> > > https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Dblock_20200212215251.GA25314-40ming.t460p_T_-23m2d0eff5ef8fcaced0f304180e571bb8fefc72e84&d=DwIFAg&c=IGDlg0lD0b-nebmJJ0Kp8A&r=NW1X0yRHNNEluZ8sOGXBxCbQJZPWcIkPT0Uy3ynVsFU&m=nUNT2_IvSlbeY_25S516HctZv4od6WK6h2q2_C4Q8SY&s=TTxCbaBVGOCBZROb7fqSBDCe9wIZrYdBDSCW2TqrLzM&e=
> > >
> > > It could be cheap for NVMe HDD to do that, given all queues/requests
> > > just stay in system's RAM.
> >
> > Yes. Keith also commented on that. SQEs have to be removed in order from
> > the SQ, but that does not mean that the disk has to execute them in order.
> > So I do not think this is an issue.
> >
> > > Also I guess internal IO sort/merge may not be good enough compared with
> > > SW's implementation:
> > >
> > > 1) device internal queue depth is often low, and the participated requests won't
> > > be enough many, but SW's scheduler queue depth is often 2 times of
> > > device queue depth.
> >
> > Drive internal QD can actually be quite large to accommodate for internal
> > house-keeping commands (e.g. ATI/FTI refreshes, media cache flushes, etc)
> > while simultaneously executing incoming user commands. These internal task
> > are often one of the reason for SAS drives to return QF at different
> > host-seen QD, and why in the end NVMe may need a mechanism similar to task
> > set full notifications in SAS.
> >
> > > 2) HDD drive doesn't have context info, so when concurrent IOs are run from
> > > multiple contexts, HDD internal reorder/merge can't work well enough. blk-mq
> > > doesn't address this case too, however the legacy IO path does consider that
> > > via IOC batch.>
> > >
> > > Thanks,
> > > Ming
> > >
> > >
> >
> >
> > --
> > Damien Le Moal
> > Western Digital Research
> [sorry for the duplicate mailing - forgot about plain text!]
>
> Hi Damien-
>
> You're right. The HDD needs those commands in its internal queue to
> sort and merge them, because commands are pulled from the SQ strictly
> FIFO which precludes any sorting or merging within the SQ. That being
> said, HDDs still work better with a good kernel scheduler to group
> commands into HDD-friendly sequences. So it would be helpful if we
> could devise a method to help the kernel sort/merge before loading the
> commands into the SQ, just as we do with SCSI today.
>
> Ming:
> Regarding sorting across SQs, I mean to say these two things:
> 1. The HDD would not try and reach up into the SQs and choose the next
> best command. I understand the SQs are FIFO, so that is why NVMe HDD
> has to pull them into our internal queue for sorting and merging. Our
> internal queue has historically been more than adequate (SAS-256,
> SATA-32) to provide pretty good optimization without excessive command
> latencies.
>
> 2. Also, I know NVMe specifically does not imply any completion order
> within the SQ, but an NVMe HDD will likely honor the submission order
> within any single SQ, but not try and correlate across multiple SQs
> (if the host sets up multiple SQs). I believe this is different from
> SSD. I think of this as being left over from SAS/SATA where we manage
> overlapped commands by command order-of-arrival.
>
> Many HDD customers spend a lot of time balancing workload and queue
> depth to reach the IOPS/throughput targets they desire. It's not
> straightforward since HDD command completion time is extremely
> workload-sensitive. Some more sophisticated customers dynamically
> control queue depth to keep all the command latencies within QOS. But
> that requires extensive workload characterization, plus knowledge of
> the upcoming workload, both of which makes it difficult for the HDD to
> auto-tune its own queue depth. I'm really interested to have this
> queue approach discussion at the conference - there seems to be areas
> where we can improve on legacy behavior.
>
> In all these scenarios, a single SQ/CQ pair is certainly more than
> adequate to keep an HDD busy. Multiple SQ/CQ pairs probably only
> assist driver or system architects to separate traffic classes into
> separate SQs. At any rate, the HDD won't mandate >1 SQ, but it will
> support it if desired.
>
> -Tim
> --
> Tim Walker
> Product Design Systems Engineering, Seagate Technology
> (303) 775-3770

Hi Ming-

>Will NVMe HDD support multiple NS?

At this point it doesn't seem like an NVMe HDD could benefit from
multiple namespaces. However, a multiple actuator HDD can present the
actuators as independent channels that are capable of independent
media access. It seems that we would want them on separate namespaces,
or sets. I'd like to discuss the pros and cons of each, and which
would be better for system integration.

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
