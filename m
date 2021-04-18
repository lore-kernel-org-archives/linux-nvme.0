Return-Path: <SRS0=3bHd=JP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88743C433ED
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Apr 2021 15:33:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3E9610CB
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Apr 2021 15:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3E9610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mageta.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JOkg3gA+DwtcRHcJ0A4k1wQ/kRgS3sNt3gwBCNveBEg=; b=DS/pzY5yBuWgZxwPTlGnOII3v
	4q5d5lBBDe4rdhHFxievfDbZr0f1vStjcpuJblGHdUiK1dNm3whQRPfZcim8GzFFThdQm5nibxKlO
	ufy90i6Le+KyUIc7P/DZ0bKt/492BcyE3RHpB0nwNrtA1UNffBsv0cQiBhSB9/cSLA/E9khLViJPl
	F2trENKN3Kez8QCDZbwZgZ8RRtY5XZXr11UkEQ7jX0kmUlWwqBI8iwkFdSeHrX7hs3ihLwyATvbPb
	cmDb8fDKWHDTw3Bl9ER94islnMC0qnBCmQ7k3sPEIAT29SJJUu6HDUq6ap/4LUVVww9wHWXCL0ZqZ
	Rs5e0wW6Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lY9QL-008DqG-Rg; Sun, 18 Apr 2021 15:33:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lY9QI-008DqA-Ex
 for linux-nvme@desiato.infradead.org; Sun, 18 Apr 2021 15:33:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=a4m1kZxvdnxLbl38EB8BmN7WjXi8HxCA9N7c9l6qto4=; b=unoepL7iZIyk9v48rjNfg2ww+B
 HmGTKJHonidXGhIMRg4GMNRlvSaMAapCEcharI5PgjTa4RopmA40L3+3fdpyDwXSKWC5dSm7hoJuK
 SYmrTUZ7ADheh69uFB/yrY7nRC5yfZx6Nv2ktYNl6dWi9VOUQuADOfiApHe3g1V1bcs3bMlbl5BCM
 GaxmHWxTNOERvPFwVMIaDc6zJ65IUylZlTZsqefZOyZgCbeNnYYS1Uwhb4UDsq66uSCd769t1xkvB
 lvE6ZTRCs6qYA4PicVGny00tiibBMdI7anTBZ5choEesO1WL779H5fcRlThdrVEUimLz0XEjZWvkJ
 cHGPGIMg==;
Received: from mout4.gn-server.de ([87.238.194.231])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lY9QD-00ATV9-2h
 for linux-nvme@lists.infradead.org; Sun, 18 Apr 2021 15:33:20 +0000
Received: from mout17.gn-server.de ([87.238.194.244])
 by mout4.gn-server.de with esmtp (Exim 4.92)
 (envelope-from <lkml@mageta.org>)
 id 1lY9Pz-0005mU-80; Sun, 18 Apr 2021 15:33:03 +0000
Received: from lc0.greatnet-hosting.de ([178.254.50.20])
 by mout17.gn-server.de with esmtp (Exim 4.92)
 (envelope-from <lkml@mageta.org>)
 id 1lY9Pz-00064f-34; Sun, 18 Apr 2021 15:33:03 +0000
Received: from chlorum.ategam.org (ategam.org [88.99.83.185])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: work@mageta.org)
 by lc0.greatnet-hosting.de (Postfix) with ESMTPSA id DF015E5103C;
 Sun, 18 Apr 2021 17:33:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mageta.org; s=mail;
 t=1618759983; bh=aIb+3JQGrzBG0FwrkfudyZqWQwRxYBchgNGVY8AgfXA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GVvXHf9lhGo3a5IQR4rJDZyU7nPCVGrgEY1VfZPb5n+bpaIKuehgiXsZFh+ycoBnN
 i0c5v6mN9b9XC0HZdXYHALKptKp2yS86SFsSc5/CkIYgGLQtuXEKJ61eAjgKwTL+Nn
 gmT0pHl2Y6DDLNkUfkIr6S26gXUIW5Q4WPdy8AU6eyS1CcBnIKstvaWDz8aEKBjUTX
 Z15T0VzbQ6XS7lFChOrly17SrYY1dSpbb0K5kXPYJZQnsqmvnkplYyKWAK667h/2hu
 K9JmvnnXVW3EUAh1G6vDhmRaS3tSHMckSYWuvdXcoQHp7LWgSNEFwVW1prQovjPtAB
 JArXtwLky0ybw==
Date: Sun, 18 Apr 2021 17:32:59 +0200
From: Benjamin Block <lkml@mageta.org>
To: Muneendra <muneendra.kumar@broadcom.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de, jsmart2021@gmail.com,
 emilne@redhat.com, mkumar@redhat.com, Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH v9 03/13] nvme: Added a newsysfs attribute appid_store
Message-ID: <YHxRK33kf7OSVlxf@chlorum.ategam.org>
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
 <1617750397-26466-4-git-send-email-muneendra.kumar@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1617750397-26466-4-git-send-email-muneendra.kumar@broadcom.com>
X-Virus-Scanned: clamav-milter 0.102.4 at lc0
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210418_083317_296458_B7A28AFE 
X-CRM114-Status: GOOD (  14.25  )
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

On Wed, Apr 07, 2021 at 04:36:27AM +0530, Muneendra wrote:
> Added a new sysfs attribute appid_store under
> /sys/class/fc/fc_udev_device/*
>
> With this new interface the user can set the application identfier
> in  the blkcg associted with cgroup id.
>
> Once the application identifer has set with this interface it allows
> identification of traffic sources at an individual cgroup based
> Applications (ex:virtual machine (VM))level in both host and
> fabric infrastructure(FC).
>
> Below is the interface provided to set the app_id
>
> echo "<cgroupid>:<appid>" >> /sys/class/fc/fc_udev_device/appid_store
> echo "457E:100000109b521d27" >> /sys/class/fc/fc_udev_device/appid_store
>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
>
> ---
> v9:
> No change
>
> v8:
> No change
>
> v7:
> No change
>
> v6:
> No change
>
> v5:
> Replaced APPID_LEN with FC_APPID_LEN
>
> v4:
> No change
>
> v3:
> Replaced blkcg_set_app_identifier function with blkcg_set_fc_appid
>
> v2:
> New Patch
> ---
>  drivers/nvme/host/fc.c | 73 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)

Hmm, I wonder why only NVMe-FC? Or is this just for the moment? We also
have the FC transport class for SCSI; I assume this could feed the same
IDs into the LLDs.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
