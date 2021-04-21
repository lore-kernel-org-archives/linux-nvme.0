Return-Path: <SRS0=D0Wy=JS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E42C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 00:26:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1B261404
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 00:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1B261404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PcNCW6J9z4oTnOPgw9SD4OQQHiT0qHmEzdbmSpvVxVk=; b=jQbo+18GSAd/MEOI7U7VeuZ85
	24d2iyrjfpBLLBxJEMTFAPOl7cfbazIvmaK4pZcbcF2v/qFugLELXYJPd9LJsiWEQzuG8iQszqmSS
	G8aOkz8uM3ITgiKUov5zWDLHLBr9yS2mqHJdmi/g4kPgzbV+PY+cyLviwnFSWboGG6OrzOIXoMFPA
	0VZGG9Nu4s5womcMslkTZfHdPVnDa6KuyeGoMDGVJAGCgu7BxJOokMWvTDLYYwME9xCiFiEmU+O+Q
	S2eFhEeR3Bs9aCOZpvxMrWOvFiZ830/3Jbk3cvgQ0ijWwiq2LoXCuA4KYJgcyhtWt+kzuAbqGobVT
	nwAjs68Og==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZ0gx-00DLJv-8T; Wed, 21 Apr 2021 00:26:07 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZ0gv-00DLJm-BV
 for linux-nvme@desiato.infradead.org; Wed, 21 Apr 2021 00:26:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 Message-ID:In-Reply-To:Subject:CC:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nb7e1Da7ksuC6gseOGJeFjbfYi/f84VANXyeKraCt3A=; b=Taw3uLoH4dYxqVI96Ws4+fQ4Dg
 NZf7DzLq3nB2bFbWvNktyRs4Rg6lWHIMR+R8vMNvGOaRLDlyu8HSckLDUg1fObkbD6O7fYGHLsScS
 dk1WZWpsD+Zr+N9OFf6FlI2gXcIPH8qpG54t0WLyRqGH+wqWsdHb7CG47j0bsrDrXQr4FaMIdJjru
 JsQcs9eABYVSwrViGD84XNyIzJM5LQhA51aPzsmY8gHNFFb+kl30H+loWVCRfVkK2PJe1DAHPWwiq
 F5pfSoLPOYiKwLCZg1ooWLd6tmRKEEJRIB8p5199bJVELkUUalz1+RJaiy554EJr/B05+QSsR9kjw
 vuFUoIoQ==;
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZ0gp-00CVZW-7k
 for linux-nvme@lists.infradead.org; Wed, 21 Apr 2021 00:26:03 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13L0FJH9030887; Tue, 20 Apr 2021 17:25:55 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 3828xv036f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 20 Apr 2021 17:25:55 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 20 Apr 2021 17:25:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Apr 2021 17:25:54 -0700
Received: from irv1user01.caveonetworks.com (unknown [10.104.116.179])
 by maili.marvell.com (Postfix) with ESMTP id 129433F703F;
 Tue, 20 Apr 2021 17:25:54 -0700 (PDT)
Received: from localhost (aeasi@localhost)
 by irv1user01.caveonetworks.com (8.14.4/8.14.4/Submit) with ESMTP id
 13L0Pq71031473; Tue, 20 Apr 2021 17:25:53 -0700
X-Authentication-Warning: irv1user01.caveonetworks.com: aeasi owned process
 doing -bs
Date: Tue, 20 Apr 2021 17:25:52 -0700
From: Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@irv1user01.caveonetworks.com
To: Daniel Wagner <dwagner@suse.de>
CC: Roman Bolshakov <r.bolshakov@yadro.com>, <linux-scsi@vger.kernel.org>,
 <GR-QLogic-Storage-Upstream@marvell.com>,
 <linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>,
 Nilesh Javali <njavali@marvell.com>, "James
 Smart" <james.smart@broadcom.com>
Subject: Re: [EXT] Re: [RFC] qla2xxx: Add dev_loss_tmo kernel module
 options
In-Reply-To: <20210420182830.fbipix3l7hwlyfx3@beryllium.lan>
Message-ID: <alpine.LRH.2.21.9999.2104201642290.24132@irv1user01.caveonetworks.com>
References: <20210419100014.47144-1-dwagner@suse.de>
 <YH8QzgWiec8vka20@SPB-NB-133.local>
 <20210420182830.fbipix3l7hwlyfx3@beryllium.lan>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
X-Proofpoint-GUID: V9XXs5SRMPbv1PKldr62adnaO7Jz7EI6
X-Proofpoint-ORIG-GUID: V9XXs5SRMPbv1PKldr62adnaO7Jz7EI6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-20_11:2021-04-20,
 2021-04-20 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_172559_307620_8E6F5892 
X-CRM114-Status: GOOD (  23.82  )
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

Hi Daniel,

On Tue, 20 Apr 2021, 11:28am, Daniel Wagner wrote:

> ----------------------------------------------------------------------
> Hi Roman,
> 
> On Tue, Apr 20, 2021 at 08:35:10PM +0300, Roman Bolshakov wrote:
> > + James S.
> > 
> > Daniel, WRT to your patch I don't think we should add one more approach
> > to set dev_loss_tmo via kernel module parameter as NVMe adopters are
> > going to be even more confused about the parameter. Just imagine
> > knowledge bases populated with all sorts of the workarounds, that apply
> > to kernel version x, y, z, etc :)
> 
> Totally agree. I consider this patch just a hack and way to get the
> discussion going, hence the RFC :) Well, maybe we are going to add it
> downstream in our kernels until we have a better way for setting the
> dev_loss_tmo.
> 
> As explained the debugfs interface is not working (okay, that's
> something which could be fixed) and it has the big problem that it is
> not under control by udevd. Not sure if we with some new udev rules the
> debugfs could automatically discovered or not.

Curious, which udev script does this today for FC SCSI?

In theory, the exsting fc nvmediscovery udev event has enough information 
to find out the right qla2xxx debugfs node and set dev_loss_tmo.

> 
> > What exists for FCP/SCSI is quite clear and reasonable. I don't know why
> > FC-NVMe rports should be way too different.
> 
> The lpfc driver does expose the FCP/SCSI and the FC-NVMe rports nicely
> via the fc_remote_ports and this is what I would like to have from the
> qla2xxx driver as well. qla2xxx exposes the FCP/SCSI rports but not the
> FC-NVMe rports.
> 

Given that FC NVME does not have sysfs hierarchy like FC SCSI, I see 
utility in making FC-NVME ports available via fc_remote_ports. If, though, 
a FC target port is dual protocol aware this would leave with only one 
knob to control both.

I think, going with fc_remote_ports is better than introducing one more 
way (like this patch) to set this.

Regards,
-Arun

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
