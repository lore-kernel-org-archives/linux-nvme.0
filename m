Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0083DE94609
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 21:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PwJK6C7uj+PdiSlpFRWiuAs5zIA0mKj5gLHCNH7N1Zk=; b=2h7nrQLp5SHaNoyjkU9PNt5085
	JbGkCJaqo4LOwRwE4GIPK7i7WvDIK4iY1m66sc6dEbvuJmlT2Gh6MeZYe2e0vNccGbBdyPCGF9Mu0
	n0aY2wxoOQ4DaAJuzMOuQQIwovEJipRqKPMkcxmpMrNOQTcQ+pPtcqe8N92IGLykIAipxD/cXEP6l
	7iPj3RvulqC4cwjSFgf/KEeBHbpFoYjlBD7pO3VBLsEH4dln3TS9azeoqjsGkqdpu398phhSMiXMn
	csGd5usMgHz0iEX9Ya3pXm3C8kDXAvzNHrQfqUo1pKNmXu1N+ZkADQsX2GMvXqdyo7q6tX99vg5hs
	rG4euvOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpYmV-0000000G28c-288E;
	Mon, 09 Feb 2026 21:26:55 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpYmS-0000000G27w-3Nzx
	for linux-nvme@lists.infradead.org;
	Mon, 09 Feb 2026 21:26:54 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4f8ySX2R7HzlfddR;
	Mon,  9 Feb 2026 21:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770672410; x=1773264411; bh=PwJK6C7uj+PdiSlpFRWiuAs5
	zIA0mKj5gLHCNH7N1Zk=; b=OM83KAGbO1+o0h4kxxvvtejeAFNKNyQ95fCne0bA
	K6YhC6RM3FZsrKdKNtEhd3Pp4/k61ChcvnARRKdBwW/RSubGTSW/uO/ML1hVjRx+
	ucjoNAkTlQZFVoEaXN3LD8Zf0Q0TglUMhzxThQMcMBtqCYnnHUbHnEB8G6JHlBqd
	ar5Cnq5G0r8N/wJl8ZUJz1Ek0ktAHs1AkeqfNxtdagRLgc+GKf6U//r94HaGQJ+x
	rRYRRKHgEi3l/tzeDeLKLH0Q22bS5yJy51GeS4d+gBRNdk55PFAAWRlE0xbOfRmZ
	tESeZcfXYur+bL6PJ8QevuZduz0ZjgYqpg7nB2Dr25xTWQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id L55xXk_P6xjf; Mon,  9 Feb 2026 21:26:50 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4f8yST527kzlfddn;
	Mon,  9 Feb 2026 21:26:49 +0000 (UTC)
Message-ID: <7a6077b3-0be0-4447-ad69-973a4f064a8c@acm.org>
Date: Mon, 9 Feb 2026 13:26:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Block storage copy offloading
To: Keith Busch <kbusch@kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 lsf-pc@lists.linux-foundation.org, Jaegeuk Kim <jaegeuk@kernel.org>
References: <0cfe6fe2-3865-4dc2-92a7-74b1240f7b63@acm.org>
 <aYPdHYvuLeIevwUJ@kbusch-mbp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aYPdHYvuLeIevwUJ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_132652_871481_4558EF4B 
X-CRM114-Status: GOOD (  15.30  )
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

On 2/4/26 3:58 PM, Keith Busch wrote:
> On Fri, Jan 23, 2026 at 02:19:44PM -0800, Bart Van Assche wrote:
>> Adoption of zoned storage is increasing in mobile devices. Log-
>> structured filesystems are better suited for zoned storage than
>> traditional filesystems. These filesystems perform garbage collection.
>> Garbage collection involves copying data on the storage medium.
>> Offloading the copying operation to the storage device reduces energy
>> consumption. Hence the proposal to discuss integration of copy
>> offloading in the Linux kernel block, SCSI and NVMe layers.
>>
>> Other use-cases for copy offloading include reducing network traffic in
>> NVMeOF setups while copying data and also increasing throughput while
>> copying data.
> 
> I'm interested in the topic. I'm just not sure about the approach. If it
> doesn't support vectored sector sources, then it's much less
> interesting. From the host point of view, I'd like to be able to submit
> arbitrarily large bio's to the block layer that can be split and merged
> for optimal alignment to hardware limits. The two-bio approach looks
> overly complicated with respect to that.

Hi Keith,

How about supporting vectored sources with this approach:
* Copy requests with multiple discontiguous input or output ranges
   are submitted as multiple bios - one bio for each contiguous range.
* Before these multiple bios are submitted, blk_start_plug() is called.
   After these have been submitted blk_finish_plug() is called.
* After device mapper LBA translation has completed for all involved
   bios, if all involved bios apply to the same input and output
   block devices, and if sufficient requests are available, the block
   layer submits all the translated requests at once to the block driver
   by calling a new callback pointer that is added in struct blk_mq_ops.
* The block driver is responsible for combining the discontiguous
   requests into a single copy offload command (if permitted by the
   device limits).

Thanks,

Bart.



