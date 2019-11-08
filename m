Return-Path: <SRS0=cJ6X=ZA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFEAC43331
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2019 01:02:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54CC621D6C
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2019 01:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kVEr7Tss";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Rvhyx6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CC621D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EMQyLyNXm5PDt2KfKhpnOBpm59sgoDXx/LHh1XlaTZ4=; b=kVEr7TsswVGF+f
	vAPO/2vdpMjngcy80ZoE0Vz7yLEMX7jWAk22xoHeYK6LkXaNuDk60WE8GiwHROanyGFK1SqoT5O+i
	mAn/oRxDS2uHC5S8rs7TnWi9Ts+J8xHojq/dZY9kOwOwZtwfD1Gx5yM6Wa+Mu0jlaAm3pUEVeqCkd
	4qfT/JNNEnfW+WZv1pmutMn5368TCVJ9wkcdS3X9kM8KmNhdhWeRlvhF7hR3Q/AjB23vorcgjGnKv
	GbhybBCpPtSBytG1SsmU0gfAMiggnj0LgVgMmZBE/PcikbgBr/iUekkn+Atna6ZQ0G/sepeIpKqJt
	YqjPH6eGwAKnRF74N8Jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSsfq-0002Vc-Nb; Fri, 08 Nov 2019 01:02:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSsfn-0002Ua-Hn
 for linux-nvme@lists.infradead.org; Fri, 08 Nov 2019 01:02:48 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 57C482178F;
 Fri,  8 Nov 2019 01:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573174964;
 bh=Xe8aTUi9v+EhewXJWx4w2msv331058sgb10Ksged9dI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1Rvhyx6r4XfeUEWuG00A62ThrNUrnecINps2x8j4KEFJdsivp+7MRlbIiZGh0Oiqa
 7btD+jeXMt+O3O0HbWjFvPZTrf116SWltijTJcX1+Wb2KCxPYnsUCP0nl2p/8AGHNT
 68OrWSezOGABUzzDbuhW/byuM9aoFgiv5IG4lZq0=
Date: Fri, 8 Nov 2019 10:02:37 +0900
From: Keith Busch <kbusch@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5] nvme: Add hardware monitoring support
Message-ID: <20191108010237.GA904@redsun51.ssa.fujisawa.hgst.com>
References: <20191106143518.1557-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191106143518.1557-1-linux@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191107_170247_607796_9D37C966 
X-CRM114-Status: GOOD (  12.73  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 06, 2019 at 06:35:18AM -0800, Guenter Roeck wrote:
> nvme devices report temperature information in the controller information
> (for limits) and in the smart log. Currently, the only means to retrieve
> this information is the nvme command line interface, which requires
> super-user privileges.
> =

> At the same time, it would be desirable to be able to use NVMe temperature
> information for thermal control.
> =

> This patch adds support to read NVMe temperatures from the kernel using t=
he
> hwmon API and adds temperature zones for NVMe drives. The thermal subsyst=
em
> can use this information to set thermal policies, and userspace can access
> it using libsensors and/or the "sensors" command.
> =

> Example output from the "sensors" command:
> =

> nvme0-pci-0100
> Adapter: PCI adapter
> Composite:    +39.0=B0C  (high =3D +85.0=B0C, crit =3D +85.0=B0C)
> Sensor 1:     +39.0=B0C
> Sensor 2:     +41.0=B0C
> =

> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks, applied for 5.5

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
