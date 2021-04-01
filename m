Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823E3C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 17:21:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA3F613D3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 17:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA3F613D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vdv/UzijvzyLTdXGx2rqR/KU66XnOAXj9+5IXqPJiSU=; b=nDKxIufVH0c5MFPBZUsgsrjnU
	Gq51slnXuqbckQwH7Tf1BV0CZMYYA6VYK4wCPscRZMcRsncuo/Y5ra8np2luiRkwffDBbe1gSwKRX
	QN2l03AoNw+OW34MoS7TH56VC6w4ksEcIhNI6JseZflX+ntN7rG/5FF38ErE7soazNWM6ulkAPjYx
	NdIpdyDMCa9A+TC3kIjURMd5iV/E10mLFeaS/2T1UZvLbWcR+Mw9HZKJQCNsLTSwMr0BBVgm1kuGt
	5SxiObG0HjtB+/PefuAgTk5IzsFZpRCmPoSXtWBB5UfTG77mPTrBfh47mHLvKgQenpPgV46gM6yj/
	IaRjk4s3Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lS10H-00AUfX-RV; Thu, 01 Apr 2021 17:21:09 +0000
Received: from mail-pl1-f175.google.com ([209.85.214.175])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lS10C-00AUbk-5Y
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 17:21:07 +0000
Received: by mail-pl1-f175.google.com with SMTP id e14so1360518plj.2
 for <linux-nvme@lists.infradead.org>; Thu, 01 Apr 2021 10:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v+ktk7V2bw/Mcb0XtcgotmPIQtuo7j7aw4ap3uSCL/s=;
 b=bpff6aoVKFylFpjADfEx/QsDwvE3s8RfHnoL3U4wjk5WZP0dzsVbcYSn1AwwX4OIUS
 wuLDZlT6A5V/6YzoF67O4kBS+UrtREQc0TICkRSJaob3WE+8xJ9VIrJBZCEEZsF/qZuF
 xoj3JWNKbQvXrB8VvAn8m4qa17xCPtNlLFr+qMt4oquIkMmqLfSmQYwEzO/dhiFWR7yZ
 EdsxwVLz+UUMQwWfrw+HLl9/BQSDNXWiSvd3krIWOsKeYPxEDBfGOLd4bpwX1/jpx7zl
 7l57K0PmXd4TDg4Yz8X7d1eZHAcWyog11PYrbJ0WaHc9UivQFO1CyXIhzRCSblzs9uW1
 oZlA==
X-Gm-Message-State: AOAM530ow3bInNiy+MMUyJgPswu6/3wL4Onpq+TLktxndKeJ6flr22ut
 3XTkAoXaiGSgkeIyCS1c8umc5GtBPEU=
X-Google-Smtp-Source: ABdhPJxNksYJbz+SE3F1+xjMDGWK0V1//99BWlF41RMAR39+wzGPhRXuYRS+dLt7RteTeHD7oz/3rQ==
X-Received: by 2002:a17:90a:1049:: with SMTP id
 y9mr9765471pjd.173.1617297661957; 
 Thu, 01 Apr 2021 10:21:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:bc4f:2be9:2efc:aaf7?
 ([2601:647:4000:d7:bc4f:2be9:2efc:aaf7])
 by smtp.gmail.com with ESMTPSA id k5sm5981077pfg.215.2021.04.01.10.21.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Apr 2021 10:21:00 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: Recursive locking complaint with nvme-5.13 branch
To: Christoph Hellwig <hch@infradead.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <f8288fe3-d8d2-5cfe-6aef-410bcd6e6231@acm.org>
 <20210401153722.GA1501960@infradead.org>
 <2d76014e-1e78-0ea9-e661-e441334f7897@acm.org>
 <20210401161248.GA1510273@infradead.org>
Message-ID: <a7dbac1f-ac55-abf5-12c2-d3e60796f52e@acm.org>
Date: Thu, 1 Apr 2021 10:20:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210401161248.GA1510273@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_182104_443600_87051128 
X-CRM114-Status: GOOD (  14.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/1/21 9:12 AM, Christoph Hellwig wrote:
> We've seen a similar trace a while ago, and back then decided not to
> fix it given that it is harmless and pktcdvd was considered to be on the
> way out.  But it seems like systemd now tries to set up pktcdvd?

Hi Christoph,

The following snippet from the system log shows that the call trace was
indeed triggered by setting up the pktcdvd driver:

Mar 31 20:55:10 ubuntu-vm kernel: pktcdvd: pktcdvd0: writer mapped to sr0
Mar 31 20:55:10 ubuntu-vm kernel: Adding 8388604k swap on /dev/sdc.  Priority:-2 extents:1 across:8388604k
Mar 31 20:55:10 ubuntu-vm kernel:
Mar 31 20:55:10 ubuntu-vm kernel: ============================================
Mar 31 20:55:10 ubuntu-vm kernel: WARNING: possible recursive locking detected
Mar 31 20:55:10 ubuntu-vm kernel: 5.12.0-rc3-dbg+ #6 Not tainted
Mar 31 20:55:10 ubuntu-vm kernel: --------------------------------------------

The following information is also relevant:

root@ubuntu-vm:~# lsscsi | grep sr0
[3:0:0:0]    cd/dvd  QEMU     QEMU DVD-ROM     2.5+  /dev/sr0

bart@ubuntu-vm:~$ cat /lib/udev/rules.d/80-pktsetup.rules
# Create and remove packet writing device for each optical block device
ACTION=="add", SUBSYSTEM=="block", ENV{ID_CDROM}=="1", RUN+="/usr/sbin/pktsetup %E{MAJOR}:%E{MINOR}"
ACTION=="remove", SUBSYSTEM=="block", ENV{ID_CDROM}=="1", RUN+="/usr/sbin/pktsetup -d %E{MAJOR}:%E{MINOR}"

In other words, every time a CD-ROM is detected the above udev rule runs the
pktsetup executable.

I haven't found any udev rule in the systemd git repository that runs pktsetup.
I think it comes from the udftools repository.

Please let me know if you need more information.

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
