Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2251EE77198
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1QBb1SxSbkhq0fjJPP/D8igQzmWEtDwWTFQrDDQ04OM=; b=PSU+FiJrbAnmzxwf6uQwaOlQLc
	1MYWiXvRqXw3tj5uZpTYAGqrizQ+c9vH44l3S4L1wrFUDFy7eRS1VJ8TzxCHO6G6KWSMfgyoUeScf
	aJiUw1CrSkZD8wFz9cRo0eBtHrRKdFPV2uNu2ZbkVNyKvsv/W/kGF34bdzKaW7O29fbsv7DgUkWeu
	XSMe5cER+iC8m3/6cWmmYyVmFoHXPOAbMHdJfbiJNm2zWjqEEcQwtDgzTBNR02Wv+heDY15uWjctD
	OIeegm/g/eifBvS7jTqWdb5jQTC+iLJV/ebtbRoiFJOUpFGFNdbSspoolf40Aw2XnRvk7nonHKOEQ
	ejrLX4zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUoUF-00000001frP-2cr3;
	Mon, 06 Jan 2025 14:53:47 +0000
Received: from out-170.mta1.migadu.com ([2001:41d0:203:375::aa])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUoGc-00000001bmX-0NBI
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 14:39:43 +0000
Message-ID: <6c63dd3a-378d-471f-8af0-725edc3785ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736174377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QBb1SxSbkhq0fjJPP/D8igQzmWEtDwWTFQrDDQ04OM=;
	b=JLi2So6YMgc1dnvVKl8hkq5wxmbpmbt93tP9dW3JvqKloiWUhxBzIW4jWw3BIH4IdoUiuD
	9wXf2ugoGGIVDR78uxu6XWy1ZOr8e/zHj8vPORYlyin6Oy6bcJETw/dBqjDwmgeLJYnrPl
	dmUulL7tkr6kcGySvUEWJOd+D5/Ekcs=
Date: Mon, 6 Jan 2025 15:39:34 +0100
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Christoph Hellwig <hch@infradead.org>, Vishnu ks <ksvishnu56@gmail.com>
Cc: Song Liu <song@kernel.org>, lsf-pc@lists.linux-foundation.org,
 linux-block@vger.kernel.org, bpf@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
 <Z3uIOPxr4s09qS1X@infradead.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <Z3uIOPxr4s09qS1X@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_063942_406864_4B1D6AC6 
X-CRM114-Status: GOOD (  12.90  )
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

On 06.01.25 08:37, Christoph Hellwig wrote:
> On Sat, Jan 04, 2025 at 11:22:40PM +0530, Vishnu ks wrote:
>> 1. Uses eBPF to monitor block_rq_complete tracepoint to track modified sectors
> 
> You can't.  Drivers can and often do change the sector during submission
> processing.

If I get you correctly, you mean, the action that **drivers often change 
the sector during submission processing** will generate a lot of 
tracepoint events. Thus, this will make difference on the performance of 
the whole system.

If yes, can we only monitor fentry/fexit of some_important_key_function 
to reduce the eBPF events? Thus this will not generate too many events 
then make difference on the performance.

Zhu Yanjun

> 
>> 2. Captures sector numbers (not data) of changed blocks in real-time
>> 3. Periodically syncs the actual data from these sectors based on
>> configurable RPO
>> 4. Layers these incremental changes on top of base snapshots
> 
> And all of that is broken.  If you are interested in this kind of
> mechanism help upstreaming the blk-filter work, which has been
> explicitly designed to support that.
> 
> Before that you should really undestand how block devices and
> file systems work, as the rest of the mail suggested a very dangerous
> misunderstanding of the basic principles.


