Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0C9D75E4F
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NFXk9mqkVM9P4jO5qIAEBl+vinIgn7s7A2Iirsp1WlM=; b=uoFwV/mttzceKJr4G+SI92zfMD
	S4knrh/1k99HzhBly9ejbnFKVQdKQPqYGfqaOflCdhWI1VLT/XwNhCHG/lTtttYtcmzkjMTr67Om+
	K6LXjfbT9MidKTrMFw+8cQGhpYjfEs50hcpa2YZx1JghjPVOuzRliI9km8ch1AarnMtvmqykeU17H
	wzgsMKzyVGX7noAZnsOhv8kN3mBJBcXoER/AQ72SaHnu3UMIBFezV7G/FsqRSo/nyH4E7kuVIR+oC
	n/+m2XOzXO5Zm2HaFFsWQkUecPIVhVqx+z3pXNHGE0ZcbaEPZzTe8F7UmtFVCMlWh1tX7Wp/pKDyA
	QcerKv3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEUMl-00000002ae3-0ZJ3;
	Fri, 22 Nov 2024 14:10:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEUMh-00000002acJ-3ZLG
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 14:10:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732284629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFXk9mqkVM9P4jO5qIAEBl+vinIgn7s7A2Iirsp1WlM=;
	b=XUR/0TP5m7rIOhEA4DCbIwEU+GTnC8dP9iYOuEml3qEV4o4UvG+/x51iVz3CfsJQHd+mR+
	nHl7rTKpdkVV5bqoqczMTf02MBBfOqjdLzZ+2ADjCHg4uiL1AGyMN4R6ucN/JOrfSM+8px
	X6MIgHtWn/c3m2rNavvqSLMjsahh3o4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-_hXRCg6-PfGqEPLgdA5rnA-1; Fri,
 22 Nov 2024 09:10:26 -0500
X-MC-Unique: _hXRCg6-PfGqEPLgdA5rnA-1
X-Mimecast-MFC-AGG-ID: _hXRCg6-PfGqEPLgdA5rnA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B9631955F41;
	Fri, 22 Nov 2024 14:10:23 +0000 (UTC)
Received: from [10.22.81.129] (unknown [10.22.81.129])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC41B195E481;
	Fri, 22 Nov 2024 14:10:19 +0000 (UTC)
Message-ID: <a9c1329a-c5b3-4807-8536-810b45f0c6ef@redhat.com>
Date: Fri, 22 Nov 2024 09:10:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: always enable multipath
To: Nilay Shroff <nilay@linux.ibm.com>, Bryan Gurney <bgurney@redhat.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
 mpe@ellerman.id.au, naveen@kernel.org, maddy@linux.ibm.com, kernel@xen0n.name
Cc: bmarzins@redhat.com
References: <20241121220321.40616-1-bgurney@redhat.com>
 <5bbfcfe6-6e7f-437c-9c0e-cb80578b0c87@linux.ibm.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <5bbfcfe6-6e7f-437c-9c0e-cb80578b0c87@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_061031_964541_4E94C3D2 
X-CRM114-Status: GOOD (  14.83  )
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

On 11/22/24 01:26, Nilay Shroff wrote:
>  
> On 11/22/24 03:33, Bryan Gurney wrote:
> 
> I applied the above changes to my kernel tree and ran the below blktests:
> 
> # ./check nvme/033 nvme/034 nvme/035 nvme/036 nvme/037 nvme/039
> nvme/033 => nvme0n1 (tr=loop) (create and connect to an NVMeOF target with a passthru controller) [not run]
>      /dev/nvme0n1 is a NVMe multipath device
> nvme/034 => nvme0n1 (tr=loop) (run data verification fio job on an NVMeOF passthru controller) [not run]
>      /dev/nvme0n1 is a NVMe multipath device
> nvme/035 => nvme0n1 (tr=loop) (run mkfs and data verification fio job on an NVMeOF passthru controller) [not run]
>      /dev/nvme0n1 is a NVMe multipath device
> nvme/036 => nvme0n1 (tr=loop) (test NVMe reset command on an NVMeOF target with a passthru controller) [not run]
>      /dev/nvme0n1 is a NVMe multipath device
> nvme/037 => nvme0n1 (tr=loop) (test deletion of NVMeOF passthru controllers immediately after setup) [not run]
>      /dev/nvme0n1 is a NVMe multipath device
> nvme/039 => nvme0n1 (test error logging)                     [not run]
>      /dev/nvme0n1 is a NVMe multipath device
> 
> As we can see here, the above tests were skipped because the test detects
> that the device (/dev/nvme0n1) is a multipath device. However, in fact,
> the test device is NOT a multipath. So I think we need to update the above
> tests. We may submit another patch to blktest and update above tests once
> your changes are merged upstream.

Nilay, what kind of device is /dev/nvme0n1 ?

Can you show us the output of

nvme id-ctrl /dev/nvme0 -H
nvme id-ns /dev/nvme0n1 -H

Thanks,

/John

> Otherwise, changes look good to me:
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> 


