Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14373C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 21:48:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D752075D
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 21:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="v13aYQVR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuyejGI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D752075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MzmNCIZC+PKD7Q7fPD3f4E/AJPq5kRM+NhykysEtM1w=; b=v13aYQVRYN9yyNqr/O0q4LPoW
	S0oVxL2eB1OWCR944EF2Vc1zSR6UO7DwtDrS9I8xL+Yh8VuK8vW0GYM/RpsF9JqcmUZYLhia7HcMB
	QIiTMCCkKBONbTyPyF2Dnu3S6TL78/FvoMIgjWBC0pzNPqNL0kDikyjth1c22CV3de+WjTnstv8uq
	45vZ1ls6p4t1GWLIXbXRvxEoZJwm44GQpyxi9mGaEjNEtq2FH8LlvYNWkEmhTHxsGEPO3Q2m/jBIS
	nEW6M/H5d1/+4A4vLqtvdnpfXXGh/WOtTG0FL5M9AeR1upmf8FVpQjgwYceVj7aHS6Nka8ghEctVH
	iY+W+R5Zw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jr74P-0007bh-13; Thu, 02 Jul 2020 21:48:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jr74L-0007b0-SZ
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 21:48:34 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2F52F2075D;
 Thu,  2 Jul 2020 21:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593726512;
 bh=WaMAjGXRF0xNZ+BE3biFJ8eJlMH7f6MWbZXzAb26QeQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IuyejGI2SrPvFDKOASNmuFCLbRtnfoyXozXMCsgD3IOpGoKaS8FGAlVJuaUpZcmKY
 BQe2dWTCnpx0L2w/daDKAEYsIy8lx+kUT943jWG6AggaQY0xVzr2ESooUjML7d+WdJ
 Yw7YWjVILAP3jC/l0ub7Md8tq/F3v8gbuEXoZGcw=
Date: Thu, 2 Jul 2020 14:48:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: David Fugate <david.fugate@linux.intel.com>
Subject: Re: [PATCH] nvme: associate stripe size quirk with D4512
Message-ID: <20200702214830.GB1990925@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200611033836.45701-1-david.fugate@linux.intel.com>
 <20200611054156.GB3518@lst.de>
 <e2c46dfec9e779d945088b025f833bcd4e29cc1e.camel@linux.intel.com>
 <20200615072031.GA21903@lst.de>
 <43c990124bf8b0cb20434e78fb455302fe3b8c52.camel@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <43c990124bf8b0cb20434e78fb455302fe3b8c52.camel@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_174834_017529_F5BA518D 
X-CRM114-Status: UNSURE (   9.58  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@fb.com, david.fugate@intel.com, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 02, 2020 at 03:16:04PM -0600, David Fugate wrote:
> Did hear from our D4512 team there are concerns with this drive
> advertising itself as NVMe 1.2 compliant while also implementing
> aspects of NVMe 1.3 such as NOIOB. Of course the Linux NVMe driver
> does the right thing in terms of ignoring the drive-reported spec
> compliance value in favor of feature detection. Can't be certain
> that's the case with all other OSes and closed-source drivers
> in particular.

I don't understand this concern. If a driver fails to detect a feature,
then they're in the exact same situation as if the controller didn't
implement it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
