Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BB7C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=180wHj2mbLM7r2fft5Iz3Ljz/DcuYqijBw09u/j0Uok=; b=0bRFiKQ+e8x2WaF9+Bfh1yVqdi
	Xz5zk91axyvCLvi8/Cusx3Yxki7us3EnzVwTtvevYA+beZLIod42rMx4ffT8pQ/Q0yxwZWgRCyoRk
	MVskPUtKv+YpUFeNCIgHrl2Rm4r7xI+4mNK58a9xgNr1M3PmNGufAtQW8RUsxmk0kaMUgWqg5+bXX
	5HO2hku8V4GJYR4Sx2Yz5abS0ytdfYPCArRLeavbLSciwImfjC/oEKY2ubFwwoY3pHzRbAHXp8FHJ
	sdY2uW8ajTZmYa71r0PI4Z//SVB9usynwDne2Ln2K2y+urpHkQS6M/kZTNZ2IJ/fP+VdVWWBNBLFK
	X1cGxPAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odYs9-00GsK7-Cb; Wed, 28 Sep 2022 15:21:17 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odYs6-00GsHy-B1
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 15:21:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AEAB921A81;
	Wed, 28 Sep 2022 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664378469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=180wHj2mbLM7r2fft5Iz3Ljz/DcuYqijBw09u/j0Uok=;
	b=ihdv7n+q4XST2eeip6DjjJhpjtohBBOGMyFAcjx2xgfRtaKAOwuZ0PadyKCUvsmgY2Od/U
	JlA5osLn18MX/+5P4zk5A8wkLX+y2nqUtEaA4tZBPqIoyvw1c1soyCmMlwmjlPnc/kibNw
	kR0mvG/xMl8dfxvVQikDQmpEpC9LK4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664378469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=180wHj2mbLM7r2fft5Iz3Ljz/DcuYqijBw09u/j0Uok=;
	b=homxEt+yx5quh9myj3BlSk0df3Db8KhjnusUmjdhmFX+uHj6GQUTJGSsa8/SEB5UAYABsi
	PuNlSVSqtwK8vPDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AA4613A84;
	Wed, 28 Sep 2022 15:21:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id etC+IGVmNGOlDAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 28 Sep 2022 15:21:09 +0000
Message-ID: <ff83b414-e268-e5e2-3e2f-c6d33cd0cc5d@suse.de>
Date: Wed, 28 Sep 2022 17:21:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 "Knight, Frederick" <Frederick.Knight@netapp.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
 <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
 <20220928135053.s6h6xr3llhp6riwr@carbon.lan>
 <b121c092-cecc-b891-be3c-b32c2a3e611d@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b121c092-cecc-b891-be3c-b32c2a3e611d@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_082114_570253_43000DA8 
X-CRM114-Status: GOOD (  31.26  )
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

On 9/28/22 16:23, Sagi Grimberg wrote:
> 
>>> Would this be a case for a new AEN - controller configuration changed?
>>> I'm also wondering exactly what changed in the controller?  It can't
>>> be the "Number of Queues" feature (that can't change - The controller
>>> shall not change the value allocated between resets.).  Is it the MQES
>>> field in the CAP property that changes (queue size)?
>>>
>>> We already have change reporting for: Namespace attribute, Predictable
>>> Latency, LBA status, EG aggregate, Zone descriptor, Discovery Log,
>>> Reservations. We've questioned whether we need a Controller Attribute
>>> Changed.
>>>
>>> Would this be a case for an exception?  Does the DNR bit apply only to
>>> commands sent on queues that already exist (i.e., NOT the connect
>>> command since that command is actually creating the queue)?  FWIW - I
>>> don't like exceptions.
>>>
>>> Can you elaborate on exactly what is changing?
>>
>> The background story is, that we have a setup with two targets (*) and
>> the host is connected two both of them (HA setup). Both server run the
>> same software version. The host is told via Number of Queues (Feature
>> Identifier 07h) how many queues are supported (N queues).
>>
>> Now, a software upgrade is started which takes first one server offline,
>> updates it and brings it online again. Then the same process with the
>> second server.
>>
>> In the meantime the host tries to reconnect. Eventually, the reconnect
>> is successful but the Number of Queues (Feature Identifier 07h) has
>> changed to a smaller value, e.g N-2 queues.
>>
>> My test case here is trying to replicated this scenario but just with
>> one target. Hence the problem how to notify the host that it should
>> reconnect. As you mentioned this is not to supposed to change as long a
>> connection is established.
>>
>> My understanding is that the current nvme target implementation in Linux
>> doesn't really support this HA setup scenario hence my attempt to get it
>> flying with one target. The DNR bit comes into play because I was toying
>> with removing the subsystem from the port, changing the number of queues
>> and re-adding the subsystem to the port.
>>
>> This resulted in any request posted from the host seeing the DNR
>> bit. The second attempt here was to delete the controller to force a
>> reconnect. I agree it's also not really the right thing to do.
>>
>> As far I can tell, what's is missing from a testing point of view is the
>> ability to fail requests without the DNR bit set or the ability to tell
>> the host to reconnect. Obviously, an AEN would be nice for this but I
>> don't know if this is reason enough to extend the spec.
> 
> Looking into the code, its the connect that fails on invalid parameter
> with a DNR, because the host is attempting to connect to a subsystems
> that does not exist on the port (because it was taken offline for
> maintenance reasons).
> 
> So I guess it is valid to allow queue change without removing it from
> the port, but that does not change the fundamental question on DNR.
> If the host sees a DNR error on connect, my interpretation is that the
> host should not retry the connect command itself, but it shouldn't imply
> anything on tearing down the controller and giving up on it completely,
> forever.

Well. And now we're in the nitty gritty details.
Problem is that 'connect' is tied with the whole 'create association' 
stuff from the transport.
I can't really imagine what would be the results of a successful 
association creation, a 'connect' failing with DNR bit set, and the 
association _not_ being torn down.
In the end, the association is only valid for this specific 'connect' 
command, and as that failed we have to tear down the association.
Am I correct this far?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


