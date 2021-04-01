Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30700C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 16:28:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC64761286
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 16:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC64761286
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jqmDriZOaqUqC4GHF1e528+xKwR8oohUqELV8CvFG2Y=; b=VtY75AS/YZWE3P0YshC65l1na
	f/Hnt/+PYJfzcVxRM/gzeweTOG6HzDxhy/tW307p0+aHCnGzRfH3OOP/l6QhTv6NufGWMNVclosS5
	SWD5YEIIlLh5ceor6optnCCaz72jSQuLlLkpJ/EJY6Ds2i8pmoapH+UWf8gHMwTlWlF8UAHUOzMEM
	CluvVanW9gBiF3dfv+B9NuY7+LYEw+xSzTVcbr7f2bxcdqMppeAfKYP4Tc+KceGSlEUzCP0Romdzc
	JNO0BYZpyERd1DQFt09K1b38wsTE7mvKNz8PeTb3VC87FjV3ndR9wYpdrUu6UQR7FQQtuwTarnW5L
	OzbyUj4jw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lS0BB-00AIe7-Fj; Thu, 01 Apr 2021 16:28:21 +0000
Received: from mail-pl1-f179.google.com ([209.85.214.179])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRztN-00AAmm-6I
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 16:10:00 +0000
Received: by mail-pl1-f179.google.com with SMTP id l1so1238398plg.12
 for <linux-nvme@lists.infradead.org>; Thu, 01 Apr 2021 09:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=epmYWQszktmNWpmvCF02u/oX9+R7qBG5q5IzevycwUU=;
 b=YkMLXLY0OeT9pOO3IU5reNY1z7CNIJU4bCdQJs3V8CAKtgl1HPwy/EAigh+o+BOtAV
 r2feqXd5Kv8tfDZc1OwHgnbwbr3cv9AcuZdlh55EVcfbk3E25Vtcn+hl4hH7F+KQ6VHk
 p2n3tzABH2ZOoL4IntXwNLDxpx2FxLOYOw/LAWTJUjqeSK//wxTCawO3r3kRlvQJdVUH
 2L7s9KfE5dY+lID4AxSfrUzuOKbMcD2fI1OUhbwxQ9cZBov1t6zKOjoCnL0kp3dE6qGo
 lZKQHdnSpvXv9Fj/+f2xekbr/eK4HFgTBqIi7sK+ot1QGUGBX7KRzSwMxVHx0m5BBxex
 /hhw==
X-Gm-Message-State: AOAM5314X1AANwg7dqIpPI2bgYbiTwPHJTU8Ye1XhxZJkpOzOJuTc9m3
 uUzaVBhDDwjjYnT8CoOmNan/2JshBK0=
X-Google-Smtp-Source: ABdhPJx9twYkl6mYH9lwKgQrmOJlb9W6TqYDpvxn94pLnfoGNrRJl7nTR06pdi4ER9UJZJm57xE7sA==
X-Received: by 2002:a17:902:d4c2:b029:e7:32bd:6b77 with SMTP id
 o2-20020a170902d4c2b02900e732bd6b77mr8518017plg.45.1617293394855; 
 Thu, 01 Apr 2021 09:09:54 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id i22sm5921657pgj.90.2021.04.01.09.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Apr 2021 09:09:54 -0700 (PDT)
Subject: Re: Recursive locking complaint with nvme-5.13 branch
To: Christoph Hellwig <hch@infradead.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <f8288fe3-d8d2-5cfe-6aef-410bcd6e6231@acm.org>
 <20210401153722.GA1501960@infradead.org>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <2d76014e-1e78-0ea9-e661-e441334f7897@acm.org>
Date: Thu, 1 Apr 2021 09:09:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210401153722.GA1501960@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_170957_711392_01F7C3E2 
X-CRM114-Status: GOOD (  17.24  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/1/21 8:37 AM, Christoph Hellwig wrote:
> On Wed, Mar 31, 2021 at 09:03:36PM -0700, Bart Van Assche wrote:
>> If I boot a VM with the nvme-5.13 branch (commit 24e238c92186
>> ("nvme: warn of unhandled effects only once")) then the complaint
>> shown below is reported. Is this a known issue?
> 
> This looks like someone is trying to open a nvme device as the backing
> device for pktcdvd?  In that case this is a different bd_mutex.  But
> I'm really curious why systemd would do that.

Hi Christoph,

This call trace was reported during boot. The configuration of the VM 
that reported this call trace is as follows:
- Boot from a virtio disk.
- One SATA CD-ROM.
- One SATA disk.
- One IDE disk.
- One SCSI disk.
- No NVMe controller since virt-manager does not support NVMe 
controllers as far as I know.

I reported this call trace to the linux-nvme mailing list instead of 
linux-block since I haven't seen this call trace yet with Jens' for-next 
branch.

Please let me know if you need more information.

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
