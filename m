Return-Path: <SRS0=wdCx=X2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F40AC352AA
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Oct 2019 17:12:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CC42086A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Oct 2019 17:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SCgqhK7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CC42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H0LonBV515guw7PPYs9acG2hkI6jcHxNqSintPM8wC0=; b=SCgqhK7DmFxUt4
	QYBriHcOkblzWFWivNbVhS7VuhxMK3PGqKeCfE3hACPhOkAShvyqAl27g1XJnpseWBL6jq8NQILXm
	sPvu6nVnU2ys4uARct5eK1WN/8qkBLlnsSxerS6VCsaFXkIkmJmGKkmSZ8jjM5t2WlHxH0bjJPf5F
	nP03YwrAGhhNbzJO7MQUA/EYMnvyMEmCXyN/bYbSarLb0VYdnneCSWypS4XdHZMMzq4ROYBHhhe7L
	fIhLo1Mynrd5kfSFtzm1397g5Zoyo73ygQHiEGS7KVAmKL6dfNb/6mS2tT1wfmW5U2Gkez4e/gFeo
	Fssycy62tBYYQgq8sonQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iFLhD-0005gQ-6B; Tue, 01 Oct 2019 17:12:19 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFLh7-0005Xn-Id
 for linux-nvme@lists.infradead.org; Tue, 01 Oct 2019 17:12:15 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Oct 2019 10:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; d="scan'208";a="191517085"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
 by fmsmga007.fm.intel.com with ESMTP; 01 Oct 2019 10:12:08 -0700
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 1 Oct 2019 10:12:07 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.204]) by
 ORSMSX121.amr.corp.intel.com ([169.254.10.190]) with mapi id 14.03.0439.000;
 Tue, 1 Oct 2019 10:12:07 -0700
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "'linux-nvme@lists.infradead.org'"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH v2 rfc 1/2] nvmet-tcp: time based stop condition in io_work
Thread-Topic: [PATCH v2 rfc 1/2] nvmet-tcp: time based stop condition in
 io_work
Thread-Index: AdV0iGjbKvWo9MHKT5+sPKvOVIqgiAAWK9YAAOJ6dBA=
Date: Tue, 1 Oct 2019 17:12:07 +0000
Message-ID: <B33B37937B7F3D4CB878107E305D4916D383D8@ORSMSX104.amr.corp.intel.com>
References: <B33B37937B7F3D4CB878107E305D4916D37CA2@ORSMSX104.amr.corp.intel.com>
 <0695bebb-968f-36f2-c850-4974c100cbd7@grimberg.me>
In-Reply-To: <0695bebb-968f-36f2-c850-4974c100cbd7@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjk4NjUzNGUtOTk4Yy00YWFmLWE4MzctZWE5ZWFmY2M0NTczIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNmFuK25cLytSR1JjTUE3OW50SUV0eGN1Mld5ODdmVGNvWVF2UVcrOTF2QUxJZmpHRUxqcytHdEF4MTlTUithckwifQ==
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191001_101213_658685_FF71789A 
X-CRM114-Status: GOOD (  27.96  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Move to a do/while loop terminate condition in
>> nvmet_tcp_io_work() that is time based that can be applicable for 
>> network interface that is in either interrupt or polling mode.  If a 
>> busy poll time period configuration setting (net.core.busy_read) not 
>> active then assume interrupt mode and default loop period to 
>> sufficient time period that would have satisfied previous default ops 
>> count of 64.
>> 
>> Preserve previous interrupt mode behavior in that do/while loop could 
>> exit early if at end of an iteration that 'pending'
>> is false.
>> 
>> Outside loop add poll mode interpretation of 'pending', resetting it 
>> to true if any recv/send activity during complete loop time period.
>> 
>> Re-queue the work item if either mode determines that previous 
>> activity indicates there may be additional 'pending'
>> to be processed.
>> 
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
>> Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
>> ---
>>   drivers/nvme/target/tcp.c |   29 +++++++++++++++++++++++++----
>>   1 file changed, 25 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c 
>> index bf4f034..8ec124a 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -21,7 +21,6 @@
>>   
>>   #define NVMET_TCP_RECV_BUDGET		8
>>   #define NVMET_TCP_SEND_BUDGET		8
>> -#define NVMET_TCP_IO_WORK_BUDGET	64
>>   
>>   enum nvmet_tcp_send_state {
>>   	NVMET_TCP_SEND_DATA_PDU,
>> @@ -1167,6 +1166,15 @@ static void nvmet_tcp_io_work(struct work_struct *w)
>>   		container_of(w, struct nvmet_tcp_queue, io_work);
>>   	bool pending;
>>   	int ret, ops = 0;
>> +	unsigned long deadline, bp_usec;
>> +	bool interrupt_mode = false;
>> +
>> +	bp_usec = READ_ONCE(queue->sock->sk->sk_ll_usec);
>> +	if (!bp_usec) {
>> +		bp_usec = 1000; /* 1 msec default for interrupt mode */
>> +		interrupt_mode = true;

> Can't say I like the interrupt_mode variable...
Yes, I was torn on this as well.  Because it is not really about interrupt vs. non-interrupt, that is confusing things.  It is really about taking advantage of the advanced polling option to reap packets that are available via the sockets layer, which is busy polling.  Maybe the more appropriate variable would be something like 'adv_polling_mode' or 'busy_polling_enabled'?  the key thing is having a variable that the code could use to preserve default behavior if busy polling was not available.  The code should change to include busy_poll.h and use the function 'sk_can_busy_poll()' to get the sk_ll_usec polling period if that advanced kernel config option is available.

>> +	}
>> +	deadline = jiffies + usecs_to_jiffies(bp_usec);
>>   
>>   	do {
>>   		pending = false;
>> @@ -1194,10 +1202,23 @@ static void nvmet_tcp_io_work(struct work_struct *w)
>>   			return;
>>   		}
>>   
>> -	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
>> +		/* If in interrupt mode, exit loop if this
>> +		 * time through there was no activity.
>> +		 */
>> +		if (interrupt_mode && !pending)
>> +			break;

> Why can't you break in the adq mode if you don't have any pending work?
> This will mean that you don't get an interrupt?
The meaning of pending work somewhat changes during busy polling, where the underlying sockets layer is indicating a recommended time period in which optimized performance can be achieved while looping or polling for packet arrivals.  This polling option being able to efficiently bridge gaps in packet arrivals.

> I think we're lacking understanding of how this works, when does the application get an interrupt and when it does not...
As I indicated above, I probably confused the issue using the term interrupt mode.  Indeed, in the beginning, an interrupt is required at the device level that results in the first data_ready indication that kicks off this Io_work thread of execution.  Once indicated then busy polling is active (if configured).  During the busy polling period interrupts aren't necessarily disabled, and how any NIC implements advanced busy polling may be different.  But all should efficiently support the polling period they advertise.

> I would like to see some abstraction from the socket interface that will tell us if we should poll more instead of becoming aware of the interrupt vs. adq thing...
In a way it is.  The sockets layer is indicating a polling time period to monitor for activity.  If no activity during the period, that is the best indication it is time to stop polling.  There are no means for the SW to predict future arrivals other than leveraging the idea that if there was recorded activity during one period then there should be more in a highly active network scenario.  This is the benefit of busy polling and why one would configure it into the system.

> Overall the performance improvement is impressive with adq, does this have any impact vs. a non-adq device?
I expect that any vendors implemented support for busy polling (adq or non-adq) would perform better vs. the default when busy poll support is not configured.  If busy poll support is not configured then this code will perform basically as it did before.  The only change being that the loop becoming time based vs using the hard defined ops limit (NVMET_TCP_IO_WORK_LIMIT).  

Using a time period in general seemed more consistent with how the host side of the code worked.  Since the default behavior is to exit on the first loop iteration with no activity, then the loop limit of 64 historically was defined to cover a specific burst size or max I/O size?  There may be a better time period to use than 1 msec to represent the previous work limit that was 64?

I suppose if there is significant pushback in giving up use of NVMET_TCP_IO_WORK_LIMIT a hybrid loop terminate condition like the following could be used?
'while ((!busy_polling_enabled && ops < NVMET_TCP_IO_WORK_LIMIT) || (busy_polling_enabled && !time_after(jiffies, deadline));'  But in my mind, using just the time based condition is cleaner.

>>   
>> -	/*
>> -	 * We exahusted our budget, requeue our selves
>> +	} while (!time_after(jiffies, deadline));
>> +
>> +	/* For poll mode, pending will be true if there was
>> +	 * any completed operations during the complete loop
>> +	 * period.
>> +	 */
>> +	if (!interrupt_mode && ops > 0)
>> +		pending = true;
>> +
>> +	/* We exhausted our budget, requeue if pending indicates
>> +	 * potential of more to process in either mode.
>>   	 */
>>   	if (pending)
>>   		queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
>> 
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
