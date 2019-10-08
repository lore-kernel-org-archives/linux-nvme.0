Return-Path: <SRS0=/gup=YB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD28EC4360C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 17:46:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E4B206B6
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 17:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S5UlHAYQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HY1E61z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E4B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oesj1k3SRbGTsBg5PhlO6xK67xQq3By/qJpWX92EMVY=; b=S5UlHAYQBNzcwHHcFuzGKdkkQ
	K+8GbnGdEkqgM4fJiAA0+64iCmKfYc2pjooRKedS18k3C5gVDAwvEXpIVtUk19tIT7l2hmH1zaPcF
	uF+Idn9QV/BuGvhhtFbmsrqozwuEsSC43mWJV5J/IlIRj+uuHtPbLTDiXTLBqDSsRwHg7gojZUhUW
	bcKXXdqVRORQ+uy+Ja1FCCDWr60TkGEqpLB3AV8L78GbMzYm2+J9uOPO7bZQhxKL/9yX6pfVddw3l
	HEEf+X1viXJyQEYlCXID9YZwdDkmFnOSFXEZzITTbQVmUPnOJEkA51ns/M2FTrJrdkQfqDELHpOqH
	IJn34L/bA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHtYk-0006jz-SP; Tue, 08 Oct 2019 17:46:06 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHtYh-0006jU-C6
 for linux-nvme@lists.infradead.org; Tue, 08 Oct 2019 17:46:04 +0000
Received: by mail-pg1-x533.google.com with SMTP id 23so10661991pgk.3
 for <linux-nvme@lists.infradead.org>; Tue, 08 Oct 2019 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=0I6nmqThIO2/cV954eLyGRphlXB+DS7u+3m6GoAIHU4=;
 b=HY1E61z9PCtAbzV3WBIJh+1SC0ljri2WzbJGRIUgE2hnKcLHVmTSteqDjxoaTlutWT
 ntsu/77Ua5wHJoNtckLvVnLN52qkR+odR1Mn1TfktwzSWjac3dD47sctHNRRtMqRt7s8
 5MfWng7kZcyig81DYDH0u1vfY9NRCIVrKuhDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=0I6nmqThIO2/cV954eLyGRphlXB+DS7u+3m6GoAIHU4=;
 b=SQWXddef6OyvIu3bwjxSMmM5r6YfB69et6achJ3Ire5lB1/T5EH2bSZ9/XM3F5psUB
 mBEa/x4EGEUgoHKWYkhJUrL4a00p7WnBxI21Ur3jyQVwcik4e+nYCe1irHxSHHHzSbfc
 Q3F/7kFzlVGstqX9KylLHjAFSUe5bGN27VkS7HPdKS2grtFriAIjF2YSdzFR96vDPOwy
 +7du22Nu7/j+wmZZxkrmn7z7cAAhO1CTOGKFsQSByDusDG90mWtTd8Lx5e9CCwIxoAJo
 jzgGOsRVuzJXHpKHJGGZVt3h1Mw+HShrmej0xKwaDfxkaWosdVoYKS8F0D6kYtcQXfdZ
 4++A==
X-Gm-Message-State: APjAAAUFSMio2X+0Fupzmjc+I1lYkjTo12l9GCCMtrli7TKWRVy1sLKA
 oF0rsu4XdV5Ud57eQmrGH2K4yg==
X-Google-Smtp-Source: APXvYqwMWlmDTY7HKesMpz0Kyv+SMg3pc4hHN8HdCDbyZcf9Cr4+6tgyS47O81f5bN5440yXUbhnaw==
X-Received: by 2002:a17:90a:a781:: with SMTP id
 f1mr7374286pjq.29.1570556761821; 
 Tue, 08 Oct 2019 10:46:01 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id s202sm22342620pfs.24.2019.10.08.10.46.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 10:46:01 -0700 (PDT)
Subject: Re: NVMe PCI driver ignores SQHD from completion entries
To: Keith Busch <kbusch@kernel.org>, Vaibhav Nagarnaik <vnagarnaik@google.com>
References: <CAL26m8+WdjrKvnXDZdP4d2ekznfORDUV2Td6U6-DY9gcOqoOUA@mail.gmail.com>
 <20191005142722.GA30437@keith-busch>
 <CAL26m8+gM6KdrqpDTTQ_Tj7FGSd-qbcU78O0Ok3EaQ_B9rgHkw@mail.gmail.com>
 <20191008155928.GB23704@C02WT3WMHTD6.wdl.wdc.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <6facf1d3-d1d3-4b0c-72cd-246889ab2c68@broadcom.com>
Date: Tue, 8 Oct 2019 10:45:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191008155928.GB23704@C02WT3WMHTD6.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191008_104603_424695_8E8C542A 
X-CRM114-Status: GOOD (  19.96  )
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
Cc: Abbas Companywala <acompany@google.com>,
 Bart Van Assche <bvanassche@google.com>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, "Mihai R." <dizzy@google.com>,
 Christoph Hellwig <hch@lst.de>, Eric Gouriou <egouriou@google.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/8/2019 8:59 AM, Keith Busch wrote:
> On Mon, Oct 07, 2019 at 05:32:55PM -0700, Vaibhav Nagarnaik wrote:
>> On Sat, Oct 5, 2019 at 7:27 AM Keith Busch <kbusch@kernel.org> wrote:
>>> Checking SQ head is required only if the host might submit more commands
>>> than there are entries. The Linux nvme driver allocates enough tags
>>> for the depth of the queue, leaving one entry empty, so having a tag
>>> available means the next sq entry must be available.
>> But the driver does overwrite submission queue entries under process
>> (which are already fetched by the controller). Are there guarantees
>> from controllers out there that once fetched, the SQ entries will not
>> be fetched again for any reason? The spec doesn't prohibit that.
> Every controller I've encountered fetches commands exactly once. I have to
> admit I don't find this spelled out in great detail in the spec, though
> out-of-order fetching doesn't sound like it would satisfy the properties of a
> queue.
>
> Closest thing I can find is in section 4.1:
>
>    The consumer of entries on a queue uses the current Head entry pointer to
>    identify the slot containing the next entry to be consumed.
>
> And later says:
>
>    Once a Submission Queue or Completion Queue entry has been consumed, the slot
>    in which it was placed is free and available for reuse.
>
> If you have to re-fetch an entry, then the controller didn't "consume" it on
> the original fetch. If the controller completes a later entry, it has consumed
> an entry that wasn't the "next" entry in violation of the consumer requirement.
>

Agree - Nearly everything so far works in a fetch-once-in-order manner, 
but there's also nothing quoted that has great conviction. There's a lot 
of implications, especially with the word "next", but no hard 
requirement spelled out.

What I read that is more conclusive is.:

(4.1) "A Submission Queue entry has been consumed by the controller when 
a Completion Queue entry is posted that indicates that the Submission 
Queue Head Pointer has moved past the slot in which that Submission 
Queue entry was placed."
and
(4.1) "The controller uses the SQ Head Pointer (SQHD) field in 
Completion Queue entries to communicate new values of the Submission 
Queue Head Pointer to the host. A new SQHD value indicates that 
Submission Queue entries have been consumed, but does not indicate 
either execution or completion of any command."
and
(CQE SQHD description) "A Submission Queue entry has been consumed by 
the controller when a Completion Queue entry is posted that indicates 
that the Submission Queue Head Pointer has moved past the slot in which 
that Submission Queue entry was placed."

All of which say an SQE slot isn't consumed until the controller says so 
via a CQE with a SQHD pointer that says it's moved past the SQE slot. 
And it becomes absolutely necessary with a fabric and OOO SQE delivery.

Given there's some deviation in interpretation, it's likely a good thing 
to take up in the NVM Express group.

-- james


-- 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
