Return-Path: <SRS0=5LEM=CT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81574C43461
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 22:50:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D9E2087D
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 22:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UbgAp05y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNh++Q79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D9E2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VwpW5yNlC9JpH2Jp6YjXF+EeW7+csLr4CkithNDaUGk=; b=UbgAp05yXnmjM4DcrZjCSVta+4
	c4O6hIKJmqQ5UuYXD5AkGXboyKzTkh4I/MqVyczGb5nFFTWkEigxySbyoeZi1yr7kZ4+26QOaaF6y
	sh8WHxtDONLyMXxZ2Pbx9oKPDwDiarV/4UxOdA4OGifeIEw6rK5kB2MSaVFj1Rhn8/k1ZPAOfv6FA
	HqL5vd4pEHDp+Sc5GIFw6KvPtDnKh+2+HXLqOelrHKgZ2MWTklUZEEHsZhLE90AQADdk7xnZH4H3w
	PniZGD+wJePP1+YhAZDQZDQgwzE/Zb7OiM6baj28hjRLk3II02SVKTZ+Ddpv9rRpixGadl7Rmw8pb
	G4zhf8qA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGVOJ-00084k-AC; Thu, 10 Sep 2020 22:50:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGVOE-00084R-R8
 for linux-nvme@lists.infradead.org; Thu, 10 Sep 2020 22:50:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599778202;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y17yuQHxhjN9jL5yNgMUbhOeY0j134anJHB+DpoFjy4=;
 b=LNh++Q79OUqoIvRCSE2GmHqq/fIN+NWcGRlri0HOtFXgk6GIMSzKlHFY4skPIunx56CsBP
 z4IHdPmSP1QW2fdgABHotnGkFstDx8asEedW32cgfSm4uHbana3KWljZfZbJGvHJL/IcFD
 yemJWBiZm7skFqWvRM9SYD45iL8QWfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-vHPcvBkYM_2jFV-gmmRpig-1; Thu, 10 Sep 2020 18:48:28 -0400
X-MC-Unique: vHPcvBkYM_2jFV-gmmRpig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D26D31007482;
 Thu, 10 Sep 2020 22:48:27 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn04.gateway.prod.ext.phx2.redhat.com
 [10.5.9.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41E635C22E;
 Thu, 10 Sep 2020 22:48:26 +0000 (UTC)
To: David Milburn <dmilburn@redhat.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de
References: <1599772730-23806-1-git-send-email-dmilburn@redhat.com>
From: Eric Sandeen <esandeen@redhat.com>
Subject: Re: [PATCH] nvme-pci: disable write zeros command for Intel 600P/P3100
Message-ID: <45b4338a-dcfe-5193-c7ba-0493b29d3acb@redhat.com>
Date: Thu, 10 Sep 2020 17:48:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <1599772730-23806-1-git-send-email-dmilburn@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=esandeen@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200910_185003_005661_F4AC0B47 
X-CRM114-Status: GOOD (  20.56  )
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
Reply-To: sandeen@redhat.com
Cc: david.fugate@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/10/20 4:18 PM, David Milburn wrote:
> The write zeros command does not work with 4k range.

... or larger, it seems.

mkfs.xfs started using FALLOC_FL_ZERO_RANGE to zero the log, and this resulted
in a corrupted/un-parseable log & un-mountable filesystem after mkfs on a
600P drive.  (this behavior was introduced in xfsprogs v5.5.0)

I just happened to notice that the smaller size seemed to work.

The particular model & firmware I had trouble with was:

# cat /sys/block/nvme0n1/device/model 
INTEL SSDPEKKW512G7

I don't have access to the machine right now, but I /think/ the firmware
sysfs file said "PSF122C"

This patch does make it work for me, so if you like you can add:

Tested-by: Eric Sandeen <sandeen@redhat.com>

Thanks,
-Eric

> 
> bash-4.4# ./blkdiscard /dev/nvme0n1p2
> bash-4.4# strace -efallocate xfs_io -c "fzero 536895488 2048" /dev/nvme0n1p2
> fallocate(3, FALLOC_FL_ZERO_RANGE, 536895488, 2048) = 0
> +++ exited with 0 +++
> bash-4.4# dd bs=1 if=/dev/nvme0n1p2 skip=536895488 count=512 | hexdump -C
> 00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 00000200
> 
> bash-4.4# ./blkdiscard /dev/nvme0n1p2
> bash-4.4# strace -efallocate xfs_io -c "fzero 536895488 4096" /dev/nvme0n1p2
> fallocate(3, FALLOC_FL_ZERO_RANGE, 536895488, 4096) = 0
> +++ exited with 0 +++
> bash-4.4# dd bs=1 if=/dev/nvme0n1p2 skip=536895488 count=512 | hexdump -C
> 00000000  5c 61 5c b0 96 21 1b 5e  85 0c 07 32 9c 8c eb 3c  |\a\..!.^...2...<|
> 00000010  4a a2 06 ca 67 15 2d 8e  29 8d a8 a0 7e 46 8c 62  |J...g.-.)...~F.b|
> 00000020  bb 4c 6c c1 6b f5 ae a5  e4 a9 bc 93 4f 60 ff 7a  |.Ll.k.......O`.z|
> 
> Reported-by: Eric Sandeen <esandeen@redhat.com>
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> ---
>  drivers/nvme/host/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5e07d5628864..d31e298669a9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3153,7 +3153,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
>  		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
>  				NVME_QUIRK_MEDIUM_PRIO_SQ |
> -				NVME_QUIRK_NO_TEMP_THRESH_CHANGE },
> +				NVME_QUIRK_NO_TEMP_THRESH_CHANGE |
> +				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>  	{ PCI_VDEVICE(INTEL, 0xf1a6),	/* Intel 760p/Pro 7600p */
>  		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
>  	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
