Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9811FC43460
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 09:51:56 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0BB6023B
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 09:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0BB6023B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7rUfYhSWBpRPNXccPWDUXe0pOxdvnCRrI4ISK8R1VNM=; b=PpfdkCsoiphCejtUY5j37kSY+
	BcsIks1el/tozM8jyafZh81gaCLb+Zx+4RRwK+b+vJhs6RYv2DsAuqOy3ct3HT21VzsPQ0Y6o81AR
	H24B8mvVMUeWnSomPwWA86tENr80WjvaBaVIkkza9io3RXtQ648miXPM0KS7m6gFJ+3yAd1saHsnY
	4Yu9ciCZDQ+K3pZyhxFwnPb8XfORV6saWmQCnOv5d+Walph+3VjhukttBH90WarjDlD/1dFIdvoRq
	KaCS0T9b7ICCUrgenMfIyw+Qvs/c3HsXrHfFSwJ755Kf+hKnoATwArc3K0hoSy5oEHpV/EsNMlAue
	F5sH54vCQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbKNW-001Ge6-ET; Tue, 27 Apr 2021 09:51:38 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbKNT-001Gdu-Qb
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 09:51:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=EiIKKyUYJ1mnuMUoUvXGdJ/XLpygKTwvBm4t7SXq43s=; b=s58uBmalNlH6z8YC5RXIYqEKgk
 6R1tSt2kCku1FAIur7fyL03DJS8+TKQhuoqMIcezz7mMRVROffveqGbpRefPpT8uyYdIyeWUFZe3a
 8Szc7Y4nbv7b12VhnjI1cLgCa+qIU4eW3y62XxthbRU5KJ43DgD322m4BymjlGXo/tWlOzVanD7GI
 gf37cU69EqwXJ4mZayib+4kWZek4q8SLtvxNtkv9YVEBBmIjWBcsArwh09BawWnEdloJURViHuFBV
 64wKQgEcaWpwSa+D08wQx0EorQZC0etBFWAUDBZQ6dZ/P+CxCqMOOPcc4WSAM1a5CAwz92eAi5KM6
 FCCd11SA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbKNR-00Gb70-5T
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 09:51:34 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 73FC6B13E;
 Tue, 27 Apr 2021 09:51:31 +0000 (UTC)
Date: Tue, 27 Apr 2021 11:51:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Arun Easi <aeasi@marvell.com>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, linux-scsi@vger.kernel.org,
 GR-QLogic-Storage-Upstream@marvell.com,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Nilesh Javali <njavali@marvell.com>, James Smart <james.smart@broadcom.com>
Subject: Re: [EXT] Re: [RFC] qla2xxx: Add dev_loss_tmo kernel module options
Message-ID: <20210427095131.zf6c4siewnrhv7qd@beryllium.lan>
References: <20210419100014.47144-1-dwagner@suse.de>
 <YH8QzgWiec8vka20@SPB-NB-133.local>
 <20210420182830.fbipix3l7hwlyfx3@beryllium.lan>
 <alpine.LRH.2.21.9999.2104201642290.24132@irv1user01.caveonetworks.com>
 <20210421075659.dwaz7gt6hyqlzpo4@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210421075659.dwaz7gt6hyqlzpo4@beryllium.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_025133_379547_E55A2DF2 
X-CRM114-Status: UNSURE (   9.80  )
X-CRM114-Notice: Please train this message.
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

On Wed, Apr 21, 2021 at 09:56:59AM +0200, Daniel Wagner wrote:
> Ah, didn't know about nvmediscovery until very recentetly. I try to get
> it working with this approach (as this patch is not really a proper
> solution).

Finally found some time to play with this. FTR, the nvmediscovery
carries following information:

  UDEV  [65238.364677] change   /devices/virtual/fc/fc_udev_device (fc)
  ACTION=change
  DEVPATH=/devices/virtual/fc/fc_udev_device
  FC_EVENT=nvmediscovery
  NVMEFC_HOST_TRADDR=nn-0x20000024ff7fa448:pn-0x21000024ff7fa448
  NVMEFC_TRADDR=nn-0x200200a09890f5bf:pn-0x203800a09890f5bf
  SEQNUM=12357
  SUBSYSTEM=fc
  USEC_INITIALIZED=65238333374

The udev rule I came up is:

  ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
      ENV{NVMEFC_TRADDR}=="*", \
      RUN+="/usr/local/sbin/qla2xxx_dev_loss_tmo.sh $env{NVMEFC_TRADDR} 4294967295"

and the script is:

  #!/bin/sh

  TRADDR=$1
  TMO=$2

  id=$(echo $TRADDR | sed -n "s/.*pn-0x\([0-9a-f]\+\)/\1/p")
  find /sys/kernel/debug/qla2xxx -name pn-$id -exec /bin/sh -c "echo $TMO > {}/dev_loss_tmo" \;

I am sure this can be done in a more elegant way. Anyway, I am testing
this right now, the first 30 minutes look good...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
