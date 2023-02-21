Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89178C61DA3
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Feb 2023 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BE58R9baziH8NUp36zqmcDrd4UQGRdldVzp9zhMu2hM=; b=M/uko919AqxBOb
	+Y0EhBOJfoWn/VjVFXL3UTQnHrLhC4rBfI+OtFO/2I2Rde6vnc87sCYi/MX2NbDQF7Icap8sRhQOt
	X0TQSqq0J4GjdNfgXGWZlZvHP+4Z2slTTZOXxV9AB/SNPVc/CgmwRxXUmI6cjTQHtFqGDdohW0N1P
	fBK2XZA5rjgrrZNDAErbdKTk5CRTmXLEYVOLa5S17GrcJObkRATPHS/ZxmBqTDOPxS1zN4ut2OiwZ
	+QLbMMDxltvhow3dyWtzyLg52jdd+GPqAVYydynSeFqm7OwEbCNHeRWaxw8v9ZcN3kylQyjd0VhZC
	7GSIREtfwcdP4k0cU91A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUVSy-008wj0-E9; Tue, 21 Feb 2023 16:26:08 +0000
Received: from mp-relay-01.fibernetics.ca ([208.85.217.136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUVSs-008wgE-JD
	for linux-nvme@lists.infradead.org; Tue, 21 Feb 2023 16:26:06 +0000
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id ED8F4E197D;
	Tue, 21 Feb 2023 16:25:54 +0000 (UTC)
Received: from localhost (mailpool-mx-02.fibernetics.ca [208.85.217.141])
	by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id C392F60529;
	Tue, 21 Feb 2023 16:25:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
	by localhost (mail-mx-02.fibernetics.ca [208.85.217.141]) (amavisd-new, port 10024)
	with ESMTP id TOGJfD7ZUQb8; Tue, 21 Feb 2023 16:25:54 +0000 (UTC)
Received: from [192.168.48.17] (host-45-78-197-119.dyn.295.ca [45.78.197.119])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dgilbert@interlog.com)
	by mail.ca.inter.net (Postfix) with ESMTPSA id 884E660375;
	Tue, 21 Feb 2023 16:25:53 +0000 (UTC)
Message-ID: <57d8dff9-2fdb-8198-6cdc-7265797a704a@interlog.com>
Date: Tue, 21 Feb 2023 11:25:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [LSF/MM/BPF BOF] Userspace command abouts
Content-Language: en-CA
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 lsf-pc@lists.linuxfoundation.org
References: <3d3369f1-7ebe-b3b8-804c-ff2b97ec679d@suse.de>
 <Y+5cjPBE6h/IW9VH@kbusch-mbp>
 <ad837a26-948a-c690-cd9e-4dfffb5f990d@grimberg.me>
From: Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <ad837a26-948a-c690-cd9e-4dfffb5f990d@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230221_082602_746348_C73EBB93 
X-CRM114-Status: GOOD (  21.77  )
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
Reply-To: dgilbert@interlog.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2023-02-20 06:24, Sagi Grimberg wrote:
> 
>>> Hi all,
>>>
>>> it has come up in other threads, so it might be worthwhile to have its own
>>> topic:
>>>
>>> Userspace command aborts
>>>
>>> As it stands we cannot abort I/O commands from userspace.
>>> This is hitting us when running in a virtual machine:
>>> The VM sets a timeout when submitting a command, but that
>>> information can't be transmitted to the VM host. The VM host
>>> then issues a different command (with another timeout), and
>>> again that timeout can't be transmitted to the attached devices.
>>> So when the VM detects a timeout, it will try to issue an abort,
>>> but that goes nowhere as the VM host has no way to abort commands
>>> from userspace.
>>> So in the end the VM has to wait for the command to complete, causing
>>> stalls in the VM if the host had to undergo error recovery or something.
>>
>> Aborts are racy. A lot of hardware implements these as a no-op, too.
> 
> Indeed.
> 
>>> With io_uring or CDL we now have some mechanism which look as if they
>>> would allow us to implement command aborts.
>>
>> CDL on the other hand sounds more promising.
>>
>>> So this BoF will be around discussions on how aborts from userspace could be
>>> implemented, whether any of the above methods are suitable, or whether there
>>> are other ideas on how that could be done.
> 
> I did not understand what is the relationship between aborts and CDL.
> Sounds to me that this would tie in to something like Time Limited Error
> Recovery (TLER) and LR bit set based on ioprio?
> 
> I am unclear where do aborts come into play here.

CDL: Command Duration Limits

One use case is reading from storage for audio visual output.
An application only wants to wait so long (e.g. one or two frames
on the video output) before it wants to forget about the current
read (i.e. "abort" it) and move onto the next read. An alert viewer
might notice a momentary freeze frame.

The SCSI CDL mechanism uses the DL0, DL1 and DL2 bits in the READ(16,32)
commands. CDL also depends on the CDLP and RWCDLP fields in the
REPORT SUPPORTED OPERATION CODES command and one of the CDL
mode pages. So there may be some additional "wiring" needed in the
SCSI subsystem.

