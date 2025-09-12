Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828F5CAC582
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Sep 2025 20:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4FE0N/47zkxj+T6NN7zANe50UtAuanvmKlIiTCKZ9X4=; b=aFSQdTHNF6XWJSJn6pSbgzCAlP
	IaObB8eth/jw3lBmlev8rlYtKRsTsQV2IPg84Az6zX3paP5hLi5yCQXo0dGoNbcWe489eEpvE0MKS
	hmqbWoNg9eRdgBmcajHIkbvdfe/FnnlZ4Q4I0ohAWDmBOhQoe0bzi7Eq6eSefF6aKE036A5S8RhXA
	nKAgehu0mpMvObQ/sOSi7/DIzNBCjVhfIyiPlqMMYSonqeOiat/iBRXzP6iANQsgYfAoiv0b2q4FR
	KX4Z+cjfoKBjCD6OHi8+buX/5CSCmv4dL1LHP74ddHMqU2s8JEFI4L3hBi4aKk7eKP4e2ozF5bdzn
	sMgZyY1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxARs-0000000BRWB-0N6e;
	Fri, 12 Sep 2025 20:32:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxARp-0000000BRVR-2IDj
	for linux-nvme@lists.infradead.org;
	Fri, 12 Sep 2025 20:32:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757709163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FE0N/47zkxj+T6NN7zANe50UtAuanvmKlIiTCKZ9X4=;
	b=Tg2beZd1h+lsLAQjI2BLNIrMm4c2cH8pEX5X6gjxLW9cwM1GSZqJXtb46EfmyRF2CcQl9A
	e0RWDz0nHFP4SztJG9ybumeBZWACwIavpgu7ng8Gt2yx3QPizaVdmbqBczsDF0tCOem+yV
	QJPJvAZ4nlf9xBOWAkRmtxKOK5EaJbY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-TZTnaETAP9GghDZIJjBt8Q-1; Fri,
 12 Sep 2025 16:32:39 -0400
X-MC-Unique: TZTnaETAP9GghDZIJjBt8Q-1
X-Mimecast-MFC-AGG-ID: TZTnaETAP9GghDZIJjBt8Q_1757709158
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AA861800577;
	Fri, 12 Sep 2025 20:32:37 +0000 (UTC)
Received: from [10.22.80.24] (unknown [10.22.80.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4A83419560B9;
	Fri, 12 Sep 2025 20:32:34 +0000 (UTC)
Message-ID: <6791b6cf-9f54-4f75-bf78-7ce513902351@redhat.com>
Date: Fri, 12 Sep 2025 16:32:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: check duplicate unique identifiers in order
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 axboe@kernel.dk, mlombard@bsdbackstore.eu,
 "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>
References: <20250509151627.20434-1-bgurney@redhat.com>
 <aB4gO7mAYDO3Bm3A@kbusch-mbp>
 <cec53fce-2f1d-4162-8685-ab7c56649953@redhat.com>
 <aCId7XmLnrLWZPdk@kbusch-mbp> <aFrBVeEcapNtOvPx@kbusch-mbp>
 <1352e125-180b-4ec9-ac3e-1cd8570910a3@redhat.com>
 <aHasJPv2Jb4bQ3ik@kbusch-mbp> <da450263-9944-45d0-aa58-f4f606f88c6a@suse.de>
 <yq1a54wwiu2.fsf@ca-mkp.ca.oracle.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <yq1a54wwiu2.fsf@ca-mkp.ca.oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: znUnLqYG_Wo88JicHQ6338utDSt-jkXoMvOvydU193M_1757709158
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_133245_664337_91CACB62 
X-CRM114-Status: GOOD (  16.19  )
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

On 7/22/25 7:58 AM, Martin K. Petersen wrote:
> 
> Hannes,
> 
>> If we now can get Oracle to chime in (maybe with a different patch
>> altogether?) we have all major vendors implementing different fixes
>> for the same problem.
> 
> We have posted our quirk patches on several occasions.
> 
> The challenge is how to work around duplicate identifiers while reducing
> the number of cases where /dev/disk/by-foo would end up changing. Either
> as a result of a firmware update or as a result of updating kernels.

Not sure that's possible because we can only control what the Kernel does.

If a firmware update is going to change, add, or remove an EUI64 or NGUID or UUID identifier
we can't fix that.  But we can enforce a uniform set of rules in the kernel that does the
correct thing based up the spec.
  
> The issue is pervasive enough that OCP has a defined EUI64 workaround in
> their SSD spec.

https://www.opencompute.org/documents/datacenter-nvme-ssd-specification-v2-6-2-pdf

Is this the specification you are referring to?

NVMe-CFG-7
The single default namespace (see SECTOR-3) shall have a unique non-zero value in the
EUI64 (Extended Unique Identifier) field in the Identify Namespace data structure.
For each namespace that is created other than the initial namespace configured in the
factory, the device shall clear the EUI64 field in the Identify Namespace data structure to 0h.

NVMe-CFG-8
The device shall support a non-zero NGUID per Namespace that is never reused (i.e., the
UIDREUSE bit in the Common Namespace Features field of the Identify Namespace data
structure shall be set to 1b).

/John


