Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0411CC02193
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2025 00:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xRWaHhWbTCrKFMbELKeRZrUxx6YrTIFn1aAhri0xE3o=; b=nVZCs6LvpfqBwSxRy3Y0BWyjyS
	sGWvrXJL1vtCbsmil1iE0WVNebHyBQF2ImmSE1HJxZvUTb1tdGqXQEBcq3h4IqHoZ8psCI+qyj0fG
	L3cN9QnDSlSGZ8UjE9OBz27DjjPHzkFbVs5xOthxP7E7Pdry+E/Zd5s35oYiXkSBPRex/deLa8kAp
	jNJ0hoWaY+DVs/y/WROagzPexVDP2ieSxB1xdehyVAijlP2bP2/ceJ4cJD/E46GM+32/WSHX4+R+S
	iUWeleijgi79cCZSD8Xs8e5hAcwnPPou6u+iRAE56be4nUefVMT/J4LuRVX7kx8OB7R3INE8lFxac
	KrKBR4Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfT9E-00000001uut-40NT;
	Wed, 05 Feb 2025 00:20:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfT9B-00000001url-1s3y
	for linux-nvme@lists.infradead.org;
	Wed, 05 Feb 2025 00:20:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738714803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRWaHhWbTCrKFMbELKeRZrUxx6YrTIFn1aAhri0xE3o=;
	b=iRRusnUtEZN1fU5ywV7ah7neMHqWeZ5tOQUXmYb0K30AM0bqTTprV4YI0FkWqvif70IXlb
	esjsZJ7kYLlmSlqHwssfFruCC5UsT9v0yEBwYcbyGPI6oEpUi1K9nTFCebSrttcp1IzTOy
	zp1s33EeYlONx+yN5MP5APla6kUiegM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-RD05EMHfP3WNeQXh9kwD7g-1; Tue,
 04 Feb 2025 19:18:29 -0500
X-MC-Unique: RD05EMHfP3WNeQXh9kwD7g-1
X-Mimecast-MFC-AGG-ID: RD05EMHfP3WNeQXh9kwD7g
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D73BC19560AA;
	Wed,  5 Feb 2025 00:18:26 +0000 (UTC)
Received: from [10.22.88.114] (unknown [10.22.88.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1305E1800268;
	Wed,  5 Feb 2025 00:18:22 +0000 (UTC)
Message-ID: <a63802be-2038-4c1f-b9d5-8298da44120e@redhat.com>
Date: Tue, 4 Feb 2025 19:18:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] TP4129 KATO correctoins and clarification
To: Christoph Hellwig <hch@infradead.org>, Daniel Wagner <dwagner@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
 Mohamed Khalfella <mkhalfella@purestorage.com>,
 Hannes Reinecke <hare@suse.de>, Randy Jennings <randyj@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, lsf-pc@lists.linux-foundation.org,
 "fmds@nvmexpress.org" <fmds@nvmexpress.org>,
 "Rose, Charles" <Charles.Rose@dell.com>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Ewan Milne <emilne@redhat.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <63af907d-9cdd-4956-9978-4e77389b1716@suse.de>
 <Z5yYk7vHIhMfiPz1@infradead.org>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Z5yYk7vHIhMfiPz1@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8vT1-j3Vi2uf4ttrCEbUK1klPwB692k_HeOtMduDQTM_1738714707
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250204_162005_557933_39296389 
X-CRM114-Status: GOOD (  36.97  )
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

On 1/31/25 4:32 AM, Christoph Hellwig wrote:
> On Fri, Jan 31, 2025 at 10:24:31AM +0100, Daniel Wagner wrote:
>> Hi,
>>
>> The KATO handling in the spec got updated via the TP4129. In short it
>> mandatas that failing requests should be delayed by some value before
>> retried on a different path.
> 
> TP4129 is broken and the TWG has been told that.  There is absolutely no
> point in either implementing it or rehashing the discussion over and

If by saying "TP4129 is broken" you mean that it is a another timer based mechanism, I think you need to get over it.
We are talking about a fabric. And in any fabric the error recovery mechanism of last resort will ALWAYS be a timeout.

And if by saying "the TWG has been told that" you mean that you've expressed YOUR opinion that TP8028 is a better
solution than TP4129 because it involves no additional timer, I think you need to get over it again. We all get your
opinion but that opinion can't dictate the volition of the industry.  TP4129 exists because there is code running
out there in controllers that fails to interoperate with Linux.  This TP is not some new feature like NVMe/TLS or FDP.
TP4129 is a repair to a broken protocol, the KATO protocol.

> over again.  Concentrate on making 8028 useful instead.  And if you want
> a discussion, "why do people people push stupid things though the
> NVMe TWG and then comaplain later about the lack of implementations"
> might be more useful.

I'm sorry but you are going to have to give us a little more than insults and name calling to
convince me that TP4129 is a piece of crap and not worth implementing.

How is it, exactly, that TP4129 is broken?

Before TP4129 the spec said nothing about controller requirements following a timeout and the linux host code assumed
it was safe to replay IOs immediately after a keep alive timeout period. This problem is exasperated by the fact that
KATO is a negotiable parameter that can be changed by the the user, on the command line, with out regard to any requirement
of the controller.

For example, from the v 2.0b spec:

   If a Keep Alive Timer expires:

   a) the controller shall:
      * record an Error Information Log Entry with the status code Keep Alive Timeout Expired,
      * stop processing commands;
      * set the Controller Fatal Status (CSTS.CFS) bit to ‘1’; and
        for message-based NVMe Transports:
        - terminate the NVMe Transport connection; and
        - break the host to controller association;

   and

   b) the host assumes all outstanding commands are not completed and re-issues
      commands as appropriate.

This is one place where the current KATO spec is inadequate. Unlike the FCP standard or FC-NVMe specification the NVMe 2.0 spec.
provides no guidance, whatsoever, about how or when commands should be replayed following a keep alive timeout. This was a major
defect in the NVMe specification that led to assumptions in both the host and controller implementations we have out there.
Those assumptions led to running code in shipping products that fails to interoperate and this is is addressed by TP4129.

For the uninitiated, simply put, TP4129 expands point b) above by providing an optional controller based Command Quiesce
Time (CQT) which advises the host how long to wait before replaying any command assumed to be completed following a KATO.

This timer is needed because different storage arrays require a different additional timeout or delay period to abort
commands that are internally in-flight following a keep alive timeout. At Red Hat multiple storage array vendors have reported
that, while testing the keep alive timeout mechanism, they are experiencing data corruption. These data corruption issues have been
tracked down and root caused by more than one distribution to be related to ghost writes inside the storage array following
a command that was replayed by the host during a KATO event.

This has been discussed multiple times in the past on the email list. For example here:

https://lore.kernel.org/linux-nvme/1cea7a75-8397-126c-8a2e-8e08948237b1@grimberg.me/

And in many conversations about this on the email list and at LSF/MM in the past it was agreed that we would
solve this problem by modifying the NVMe Specification.  This is what TP4129 is. We wrote TP4129 specifically to
address this ghost write problem and we did so by adding this optional CQT timer mechanism. This optional CQT timer
was designed to have the lowest possible impact on the existing KATO mechanism. Only storage arrays which need the
addition time following a time out would need to fill in the CQT (which is a new field in the Identify Controller
Data Structure).  This would allow the host to support both storage arrays that don't need the additional timer,
with no impact, and solve the problem of storage arrays that are currently broken because they do need an additional
timer. That is what TP4129 did.

As for TP8028, this undisclosed technical proposal will not replace TP4129. Everyone involved in the development
of these technical proposals at NVMexpress.org/FMDS has agreed that TP8028 will be an enhancement of TP4129 and that many
storage array vendors may not implement it.

Red Hat is currently involved in implementing and testing changes to support TP4129 in collaboration with those vendors.
If it can be proven that those changes don't work, or that the CQT timer is not needed, I can agree with Christoph that
support for TP4129 may not be needed in the upstream Linux host.  However, in the absence of any kind of empirical data
that says a CQT timer is not needed, I can't support any arbitrary decision that says we are not going to implement TP4129
or even talk about it. I plan to attend LSF/MM this year and one of my proposed topics is this one. Too many people have
been working on this for too long to say that we are not going to talk about it.

Right now the Linux KATO implementation is suffering from all kinds of problems. It needs to be improved and repaired. I
see no reason why, as a part of that process, support for a CQT timer can not or should not be implemented and tested in the Linux
host. Any way we do this the NVMe keep alive timeout mechanism needs to be there and it remains as the error recovery mechanism
of last resort. We need to continue to test and improve the KATO mechanism whether TP4129 is implemented or not.

/John


