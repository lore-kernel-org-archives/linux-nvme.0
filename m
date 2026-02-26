Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1646FD8FD7
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 16:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SsBdkNgdY8o4f3ZKswpTJzrG/sFi18dzucDnk4F4sHo=; b=kpAJrUNgqub3LcTUAdkWHk+JtJ
	wRsBxmLBKAL/3iTnk5mT2zYEgRc+hhwQ8b/yfHK446ITI6asDajq3TF60OeIXQN5TKeZal3PxdqdE
	3rBS4RJ7RwmclCfMA+M+Kz+j0/rax3ZyNi7ofUjIdblSnWMTkMpMzfIeWi4VRipZnfIkUXQD59ila
	uXn3EE9TMozCQSRysYBHcTECh6egn0HgUEiG6KIP8dRvOB4Rduu8rfJn4DqE1MYYBeLUAVbCfDaOr
	7bEaMPPVNlauF6nMYuKDB+o2oq7LqKE/tVTgaGdE0cj/8X1Ogj+wKu1QFQb46xTt3Cbpia4i1rBmj
	PCU7O1jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vveL4-00000006k0O-2gte;
	Thu, 26 Feb 2026 16:35:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vveL1-00000006jzg-0hMI
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 16:35:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772123739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsBdkNgdY8o4f3ZKswpTJzrG/sFi18dzucDnk4F4sHo=;
	b=S6o3KPbvvJIQ/kzSevzGB77Cv8VExpcPqSrsLgvEJmL6nbFfuPDZmN/f9DvTEo6bTtJ+R9
	WEqd2rCK2XZ0zn6bMe5L9ZwUMeiBy+EFtRi6RjJMG5HzBm0s2mRffzBdQ68tUZfwMdEXjU
	ZFoBqBkuX7ogr4XxyEg4rQ8g63/rXZo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-Gnn-uyuBO168zBSSxnrCZw-1; Thu,
 26 Feb 2026 11:35:35 -0500
X-MC-Unique: Gnn-uyuBO168zBSSxnrCZw-1
X-Mimecast-MFC-AGG-ID: Gnn-uyuBO168zBSSxnrCZw_1772123733
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AAC41831358;
	Thu, 26 Feb 2026 16:35:20 +0000 (UTC)
Received: from [10.22.65.209] (unknown [10.22.65.209])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7E3F1800677;
	Thu, 26 Feb 2026 16:35:16 +0000 (UTC)
Message-ID: <e43b914c-2ca5-455e-b0fe-3ce2eb0c64bd@redhat.com>
Date: Thu, 26 Feb 2026 11:35:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during async
 scan
To: Maurizio Lombardi <mlombard@arkamax.eu>, Keith Busch <kbusch@kernel.org>,
 Maurizio Lombardi <mlombard@redhat.com>
Cc: hch@lst.de, hare@suse.de, chaitanyak@nvidia.com, bvanassche@acm.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 James.Bottomley@hansenpartnership.com, emilne@redhat.com, bgurney@redhat.com
References: <20260225161203.76168-1-mlombard@redhat.com>
 <aZ9sjbZ3CEW_1rW1@kbusch-mbp> <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: A_apbrYPYoybwJPlXCJ74O-7dYX6roklNwQWi-V66Sk_1772123733
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_083543_303255_D1A44505 
X-CRM114-Status: GOOD (  16.35  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 2/26/26 3:07 AM, Maurizio Lombardi wrote:
> On Wed Feb 25, 2026 at 10:41 PM CET, Keith Busch wrote:
>> On Wed, Feb 25, 2026 at 05:12:00PM +0100, Maurizio Lombardi wrote:
>>> The NVMe fully asynchronous namespace scanning introduced in
>>> commit 4e893ca81170 ("nvme-core: scan namespaces asynchronously")
>>> significantly improved discovery times. However, it also introduced
>>> non-deterministic ordering for namespace registration.
>>>
>>> While kernel device names (/dev/nvmeXnY) are not guaranteed to be stable
>>> across reboots, this unpredictable ordering has caused considerable user
>>> confusion and has been perceived as a regression, leading to multiple bug
>>> reports.
>>
>> The nvme-pci driver also probes the controllers asynchronously, which
>> can also create non-determinisitic names. Is that part not a problem?
> 
> Potentially, it is. The difference is that so far no one ever complained
> about it, while with namespace async scanning we immediately received regression
> reports, to the point we had to revert the changes and restore the
> sequential namespaces scan in RHEL.

It's worse than this.  Yes, in RHEL we carry out of tree patches to tun off the async scanning with SCSI,
and we reverted this async namespace scanning patch in NVMe.

We had to do this because, as soon as we turned these async scanning mechanisms on, we immediately
received customer escalations. Customer were not able to upgrade their systems. We have customer issues
and complaints open about this and we see this async namespace scanning as a barrier to adoption with NVMEe -
especially with NVME-OF which tends to have many more Namespaces than PCIe.

We've talked about this at LSF/MM - more than once - and several solutions have been proposed in the past,
but nothing ever happened.

And yes, the PCIe async discovery stuff does cause some problems.  The difference is: the PCIe bus configuration does
not change nearly as often as, e.g., the nvme namespace configuration in a fabric, so customers don't notice the changing pci ids.
Unless some one is going lots of hot unplugging and plugging with their PCI bus, the PCI ids typically don't change at all.

So from boot to boot, pci id don't usually change.  This async namespace scanning causes the namespace ids to change with every reboot, especially on
a system with 100's of nvme-of namespaces.

So, we really need this change, or something like this, to be accepted upstream.

/John


