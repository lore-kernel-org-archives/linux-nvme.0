Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5E0C0219C
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2025 18:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EFSQ19goxxYTFLCSMzMZ7YTIfQ6x2LC48M7flOh8CXg=; b=Q1OIQU6q8qPHEJaM6igtoO9t0i
	E2OrCZz4mEpRyQ/tFm06NQYhCHWQ1QIkpWDKuXDnyUVuyIb+FM5xyh4WoflwIA3AF9GtrWJo2HMH/
	v9tWavznz9gMbxFltJs1c/+HGR4NsVfEH0uY4GIAFQZVKTQgv7/FawMQ1EjgT8Nv/XpHdyms61qN2
	k3zH0H5P9jYITMyNhLC6rPJHV8sT6bQFLOPTpVDZkK2R9goP6pTQBZFbWF+JVPOqkfbfpeLTZOcMP
	Rmv83cKHPa4OcmsR5nytFzyiN5SWqml0LpCnlu/ObR9zRQN0IQ7RyEvgJM618b3yPSKTatNSVXbsF
	2debCljg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgTN2-0000000AmBX-3Nuw;
	Fri, 07 Feb 2025 18:46:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgRvq-0000000ARuY-33U7
	for linux-nvme@lists.infradead.org;
	Fri, 07 Feb 2025 17:14:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738948460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EFSQ19goxxYTFLCSMzMZ7YTIfQ6x2LC48M7flOh8CXg=;
	b=ZQ0M83bRzbJ2jhJ/reEaEkyu7thp8VE5tuKCiCIPiW6jL8iKfkRM0OlKujAhAY+X5TqFWX
	cZaD1+vG3Djwu/qtzmIDxezdCkVKA+FtCzEBCVYBHVv0pCSX4a4iLAq40pZ7cJuOrvDTak
	rc8yx35jkIYjDTGpk4dLlxVvZQWroSg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-nftw4RNENfaIChrgrxD5sA-1; Fri,
 07 Feb 2025 12:14:17 -0500
X-MC-Unique: nftw4RNENfaIChrgrxD5sA-1
X-Mimecast-MFC-AGG-ID: nftw4RNENfaIChrgrxD5sA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15AE11800984;
	Fri,  7 Feb 2025 17:14:15 +0000 (UTC)
Received: from [10.22.90.103] (unknown [10.22.90.103])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ADED619560AE;
	Fri,  7 Feb 2025 17:14:11 +0000 (UTC)
Message-ID: <ebe0d0f7-78dc-4b3a-9ce6-c58540625320@redhat.com>
Date: Fri, 7 Feb 2025 12:14:10 -0500
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
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 Charles Rose <crose@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HVds2RDmXA6Jr152syRI6wNQFY63fcO2MpD2WWzAAqI_1738948455
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_091422_840099_343CC112 
X-CRM114-Status: GOOD (  25.59  )
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
>> There was quite a bit of work to go through scenarios, and timer processing, to
>> address the concerns that the timer was a "best effort" (to reuse the term)
>> rather than a reliable method. I'm not aware of a scenario where applying the
>> timers, with the process described in TP4129, fails to provide a reliable
>> assurance that it is safe to retry write commands.
> 
> Unless the controller is able to reliably upper bound its abort operation of all inflight
> commands I can't see how this is 100% reliable. Which will likely mean that a healthy
> margin is taken such that it will not break in practice.

Who said the controller is not able to reliably abort the operations of all inflight commands?

TP4129 doesn't say this.

The whole point of TP4129 is that it provides something that is missing from the KATO protocol.
What's missing is exactly what you are asking about: "what's the amount of time the controller
needs to reliably abort all inflight commands"?

KATO is a heart beat. It is an error detection mechanism. KATO defines how long the controller
needs to wait before making the decision to BEGIN the process of internally aborting all inflight
IO. The problem is, the current KATO protocol does not define how long the controller takes to
FINISH the process of internally aborting all inflight IO. This is something that is controller
specific and this is what CQT was designed to communicate.

The current KATO protocol is broken because is confuses the error detection time with the error
recovery time. The idea that a controller "should" have run down all inflight IO by the time
KATO is detected is a completely arbitrary assumption. It is an assumption in the KATO
specification and it is broken. TP4129 addresses this assumption. It improves and corrects
the KATO protocol by providing a mechanism for the controller to communicate to the host what
the controller specific error recovery time is through the CQT.

As to whether or not the CQT is reliable... that's not our concern. We have this same issue in
other parts of the protocol. For example, the ANA ATT.  The ANA Transition Time communicates
a Service Level Agreement to the host, and if the the host sees that the ANA state does not
finish transitioning within the ATT, the results can be catastrophic. But in that case,
the problem is in the controller, not the host.

The same thing is true for the CQT. CQT is a service level agreement. So, if the host replays
an IO after CQT, and the controller screws up and corrupts data... not the Host's fault. The problem
is the controller. But with out CQT we can't say this. The host will always be suspect.
Without a clear protocol that provides a clear SLA, we can't hold things together.

Right now we have NVMe/TCP controllers out there that experience data corruption during their cable
pull tests because of this problem. These are shipping products that are supported by VmWare and
Microsoft, etc., however, they are not supported by Linux. This problem was root caused and fixed by
patches[1] that Hannes proposed back in 2023.

[1] https://lore.kernel.org/linux-nvme/20230908100049.80809-1-hare@suse.de/

Sagi, you NAKed these patches. At that time both Hannes and I talked with you about this
and we agreed that we would wait for TP4129 to address this problem.

Since that time some ditros have actually shipped these patches, out of tree, and I
am told by my storage partners that these patches fixed their data corruption problem.
In fact, Red Hat has been asked several times to include these patches in RHEL, but we've
been pushing back on our storage partners and telling them to wait for TP4129.

So to be told now that TP4129 is bogus and won't be implemented is more than a little madding.

At the end of the day, I don't care about TP4129.  Linux needs to fix the problem. Red Hat is
seeing NVMe/TCP adoption begin to pick up. More and more of our customers are trying NVMe/TCP
and using NVMe/TCP. If we want NVMe/TCP adoption to continue, we need this data corruption
problem to be fixed upstream.  If you don't like TP4129, then ACK Hannes's patches.

/John


