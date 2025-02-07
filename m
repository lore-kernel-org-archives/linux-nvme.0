Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DC8C02194
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2025 20:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Nic8ojS4EXBep35hzMklfV5WWGDJAUqGDfhA+YaVbE=; b=1a8gLGHDewK/Kw09ZWyK7Dby74
	NuR1NVmANIGmfQy8XBft/JBykugMzTJpmNjoLru5XRwH9QqtfKlNVq75Gd+u7YM5MBrvqTZ99ewS7
	/4AhvATsbv+loAb2n2iYuPv5Jyqrm2r4b7hy++IEIMx08iCjTfX3FMKfcRUWH0AVr6CBtXXl5wOq2
	odIV7U7vW/pO07ZPPO2QAum+nuuBmB2rZG0Xw5RMwzKO6/GzjoopDvaSK73BQCGK7DcvrHnpIN1xN
	1saq9yv0+QoMbgeG+m06od46yKd6KkXZyJxBfUeJW3ZLMIYuBxcasP5nsWLkoX3vDzfbsg7CiTh2R
	JqumPIpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgUyk-0000000B40m-0Miw;
	Fri, 07 Feb 2025 20:29:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgSVt-0000000AZJQ-3oWr
	for linux-nvme@lists.infradead.org;
	Fri, 07 Feb 2025 17:51:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738950696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Nic8ojS4EXBep35hzMklfV5WWGDJAUqGDfhA+YaVbE=;
	b=JfgPrzSSjOdt8xBiDmHrt1az0VB0nTNQsJQqLgTuEp1Fpv01binUpw5akL5sJoV5YFkOz0
	Di48i2MJWo9/8zRVVDfFytD+cJDMFXuD43tnMuZJxi2t0KyP4IiMd28DzVhfENhuzrBILy
	GnTfPyEJplVGjivWq+Cg54K/b7/O5G4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-oLiiHGHHOCaky5zv04fY8w-1; Fri,
 07 Feb 2025 12:51:34 -0500
X-MC-Unique: oLiiHGHHOCaky5zv04fY8w-1
X-Mimecast-MFC-AGG-ID: oLiiHGHHOCaky5zv04fY8w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80FF71955DB8;
	Fri,  7 Feb 2025 17:51:32 +0000 (UTC)
Received: from [10.22.90.103] (unknown [10.22.90.103])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3F681955BCB;
	Fri,  7 Feb 2025 17:51:29 +0000 (UTC)
Message-ID: <e2229e53-b09b-4bbc-892d-67b1566b6fee@redhat.com>
Date: Fri, 7 Feb 2025 12:51:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] TP4129 KATO correctoins and clarification
To: Sagi Grimberg <sagi@grimberg.me>,
 "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Mohamed Khalfella <mkhalfella@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <63af907d-9cdd-4956-9978-4e77389b1716@suse.de>
 <Z5yYk7vHIhMfiPz1@infradead.org>
 <527f476b-18e3-43f9-98c3-d19a25a6488a@suse.de>
 <613065bf-ad13-489e-9d57-408684e85923@flourine.local>
 <PH0PR84MB1358752FEA88D5EF0971B27E98E82@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
 <Z6OMGweV-wUI3iVn@infradead.org>
 <DM4PR84MB1374EB9468EC63867217240E98F72@DM4PR84MB1374.NAMPRD84.PROD.OUTLOOK.COM>
 <67b7e3e2-ce79-459f-a451-8d4dfbae299b@grimberg.me>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <67b7e3e2-ce79-459f-a451-8d4dfbae299b@grimberg.me>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vRbv4IelxghrpfhUoTCpdiwoEGczyeh5XU5NY7-i01A_1738950693
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_095138_011424_9BE79FD5 
X-CRM114-Status: GOOD (  14.95  )
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

On 2/7/25 4:00 AM, Sagi Grimberg wrote:
>>
>> I appreciate the comments on TP8028. I don't like how slow the timer method is
>> and really hope that we can continue to work on methods of making NVMe-oF
>> error detection and recovery faster, while maintaining data integrity. The
>> TP8028 effort is what we have in development and I'm optimistic that we'll be
>> able to discuss that model at LSF.
> 
> I think its reasonable for a subsystem to report the host a failover delay. While it is
> indeed a "best effort", its most likely sufficient for implementers to never see
> where it breaks... I just had an issue with prior attempts to make it behavior universal.
> 
> I also agree that making quiesce in failover explicit is the best solution. But I don't think
> we should reject any attempt of making the host respect the controller CQT.

Good to hear Sagi.  Sorry for my rant.  I should have read your email to the end before send my response.

/John


