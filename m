Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570C5C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 22:36:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CE4613FF
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 22:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CE4613FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IdDx5jKX6zPuasn6+0/nwv0J1oKGSJipA7Vl0BbCGmU=; b=KbYCrj3ivk/cZFccx6q+KDPD4
	1F7CjBUlS+y2C47AuG3TA86TjMo4Ilc5N+RPrsaXQV0AwBhhD2PglKzZtrcXnrmI21EF2fdMJbva5
	SXLZzDgSJmDQU+ohistnamgxJwSsDrQEhO1xBpE9OuS3f2c3cPeefRuyreHtw81AovLMUCEvrva7k
	PVH18mHwN3quV6k1+yU+p+yDhgSeDujV4BjVKflbSkfz2WCNmka6e9u4QF5hv7CXiDcnu6FDwdHyA
	IWpgT0lcPK3yfvWg6HFEpayBjieptMPn3L0pSqwTNMvUBNxaBcnzRQN8220Dggv+BP2sGzqclWUcq
	J3ys2Fz5w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbWJH-002LKl-2L; Tue, 27 Apr 2021 22:36:03 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbWJD-002LKZ-Lw
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 22:35:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 Message-ID:In-Reply-To:Subject:CC:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=MlIYn+7Ezy0eeNixJQjXkuHHLPkoNJBRw/0Jadum/tk=; b=PVhP+eiCaFla6o3QC0RbUiJNTx
 1u61lPTDudmxRYnk/tBcOTIugMK+4Lwdkchi+ab1e/k/CzlRRxSKWiglcE/mB4MlHcOrYAWvprpOl
 t9obR4DzLN1/lEyugvH2phJCQbdOSHtSnvNq/CPG1P0w0953tvaXbLjamMcI/rFPZTDcd4d3/MDua
 /WugFM7Emgq9TLFrhiTNndQiIT4y/1x7uhQgTz/kmI9nWoMpxxRc8pra/K+fY5MuUxi6QNj6AHclp
 4O6OQ0hVUfthgiwcnpIhc3te5RGKVGEM484oBiNd4ki3VDzTHjFHicwh34jsm+9juXuK/VmQfAvI6
 fBf7zHCQ==;
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbWJ9-00H3IW-BH
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 22:35:57 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13RMVCPd027582; Tue, 27 Apr 2021 15:35:50 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 386tcrr6es-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 27 Apr 2021 15:35:50 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 27 Apr 2021 15:35:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Apr 2021 15:35:48 -0700
Received: from irv1user01.caveonetworks.com (unknown [10.104.116.179])
 by maili.marvell.com (Postfix) with ESMTP id 678803F7040;
 Tue, 27 Apr 2021 15:35:48 -0700 (PDT)
Received: from localhost (aeasi@localhost)
 by irv1user01.caveonetworks.com (8.14.4/8.14.4/Submit) with ESMTP id
 13RMZlGh010696; Tue, 27 Apr 2021 15:35:47 -0700
X-Authentication-Warning: irv1user01.caveonetworks.com: aeasi owned process
 doing -bs
Date: Tue, 27 Apr 2021 15:35:47 -0700
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
In-Reply-To: <20210427095131.zf6c4siewnrhv7qd@beryllium.lan>
Message-ID: <alpine.LRH.2.21.9999.2104271531440.24132@irv1user01.caveonetworks.com>
References: <20210419100014.47144-1-dwagner@suse.de>
 <YH8QzgWiec8vka20@SPB-NB-133.local>
 <20210420182830.fbipix3l7hwlyfx3@beryllium.lan>
 <alpine.LRH.2.21.9999.2104201642290.24132@irv1user01.caveonetworks.com>
 <20210421075659.dwaz7gt6hyqlzpo4@beryllium.lan>
 <20210427095131.zf6c4siewnrhv7qd@beryllium.lan>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
X-Proofpoint-GUID: LUWLFQulvNyKwWs_EhlnyiiH9jAd-9vm
X-Proofpoint-ORIG-GUID: LUWLFQulvNyKwWs_EhlnyiiH9jAd-9vm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-27_12:2021-04-27,
 2021-04-27 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_153555_546938_3ECBCBF3 
X-CRM114-Status: GOOD (  16.30  )
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

On Tue, 27 Apr 2021, 2:51am, Daniel Wagner wrote:

> On Wed, Apr 21, 2021 at 09:56:59AM +0200, Daniel Wagner wrote:
> > Ah, didn't know about nvmediscovery until very recentetly. I try to get
> > it working with this approach (as this patch is not really a proper
> > solution).
> 
> Finally found some time to play with this. FTR, the nvmediscovery
> carries following information:
> 
>   UDEV  [65238.364677] change   /devices/virtual/fc/fc_udev_device (fc)
>   ACTION=change
>   DEVPATH=/devices/virtual/fc/fc_udev_device
>   FC_EVENT=nvmediscovery
>   NVMEFC_HOST_TRADDR=nn-0x20000024ff7fa448:pn-0x21000024ff7fa448
>   NVMEFC_TRADDR=nn-0x200200a09890f5bf:pn-0x203800a09890f5bf
>   SEQNUM=12357
>   SUBSYSTEM=fc
>   USEC_INITIALIZED=65238333374
> 
> The udev rule I came up is:
> 
>   ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
>       ENV{NVMEFC_TRADDR}=="*", \
>       RUN+="/usr/local/sbin/qla2xxx_dev_loss_tmo.sh $env{NVMEFC_TRADDR} 4294967295"
> 
> and the script is:
> 
>   #!/bin/sh
> 
>   TRADDR=$1
>   TMO=$2
> 
>   id=$(echo $TRADDR | sed -n "s/.*pn-0x\([0-9a-f]\+\)/\1/p")
>   find /sys/kernel/debug/qla2xxx -name pn-$id -exec /bin/sh -c "echo $TMO > {}/dev_loss_tmo" \;
> 
> I am sure this can be done in a more elegant way. Anyway, I am testing
> this right now, the first 30 minutes look good...
> 

Looks ok to me. Just keep in mind that, with this you'd be setting all 
instances of pn-XXX (multiple initiator ports seeing the same target 
scenario). It looks like this is what you want, but thought I'd point that 
out.

Regards,
-Arun

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
