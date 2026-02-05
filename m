Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C66ECD983
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 15:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JvT4BB7laPBurfcYuu1QzQTlY+sAIOn6S7atHkXFEm4=; b=jxX8qKv1Z1bi+co84AvB00oxGH
	9Uw1OAICjqPfaZfpmjjSONjqmnoNGkhOitef/LPimv+qS0B+syoohYhQGJTNyrdzRJTHKkI/Zx16j
	+noZmJMtoi3qUDIhmSTalQzQ/sS6psSBgdCDSynYMfMfM4qmGKNMi9n7R6iM9hhgDPvOa7+lUCHR8
	LvrHZVtPAlpIrlmL+t7g67Cx0C5h4oHVaDPoLN0JraxcGXuXnyQneXib/v8Y/EiP+rws2sadXrGkk
	5TY7ydlqbhM0XU23hmwMrSrtxQB/Zr6Lszb/EEsjrxQZFbKqFDfMtxDc9KxjGSWR2jHiLiVajDAIz
	0eWp9PyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo1hx-0000000ABR8-3M1H;
	Thu, 05 Feb 2026 15:55:53 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo1hs-0000000ABQG-2uwr
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 15:55:51 +0000
Received: by mail-ot1-x341.google.com with SMTP id 46e09a7af769-7cfd0f349c4so691204a34.1
        for <linux-nvme@lists.infradead.org>; Thu, 05 Feb 2026 07:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770306947; x=1770911747; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvT4BB7laPBurfcYuu1QzQTlY+sAIOn6S7atHkXFEm4=;
        b=BhrfmleqWvrPKtRsd+pnhLhT4YGuC6YtKGr6sMItx6UCz0TVjzNTim/7CU4CLPe/ll
         F9Ec3NqKDLqqnaMuCG3YChRJgB4zwQ2Oh5clNCJNlqlE9HWdhcQrHk8zG/5flQWyNLBo
         aRVPEjKq0/CbFjxCP+LRpWFNXEOn1BWPtsMuFP6R+BRNFFVzjMwSs9uQbfG0w7vGFjYy
         lnIYAQcY2n8t6llhiL/cjS3jhXOmbc9QPQz6eSECLKIFIObXn1G+YvH6KxtS5dMIWVuR
         Dccy+16KBb6UgU9S4Za13bRqkCJUZU4teLDSSotuTl7OrkLO7A8rrPqOPLp0nHqtnnGQ
         B2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770306947; x=1770911747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvT4BB7laPBurfcYuu1QzQTlY+sAIOn6S7atHkXFEm4=;
        b=B67PicU583pF4yF36eoe6AFdxJbBYhB+SNfMgTd56w1Q63ivtCU8Na3ckpGte/Cy5B
         3L+RsC6qyuva9sCmXzP2jeYqa5FYiWyTBgVcT4ZlGTDVS8ypU4iRViinnb/5QA96xriy
         DXLToMguLjZlKhtWq1fgUqz0ia1dlgVatjQ1ET43qpxKLniJ+98xRj/lxNL5WrXEIrEf
         yhiEdRMz0M7Vqxn3OwXqkN3/UMOX2DC6osyU+sPVshwp/GEaGR7cgomKq2z4TSzaLwen
         slDkNybmhqq0iF/AY19FjMDnaEyFMfEacUYSk9Gn0HtwbpTA8nBrXUEBKZZkQSTe4myu
         1I6A==
X-Gm-Message-State: AOJu0YxPwvhDhlUpnHWQhH5OFZxtip9WsdjDxyKeEAiUXkCVhxrSjv6N
	WYp6bhWaznM9xllcG8zR5/k+ZpGs4nSrzaKSKh78sbcWpA1jYwwz4VONnCTZIswNcZ4=
X-Gm-Gg: AZuq6aIR67zVvfEAWAVmqsnxMLNwHxKdC0c0s1ZuvqNaINA6wmvtfO+PZ4fAknJppil
	CxG9kD5ArdxcXUgmquoPTWTAZ9a5InUr415gbe0dhjYKlfr4Yo/s9b9rOzNcMvQerNZicc8lOmG
	6TLyq06FcplN/MPf9N/jHKFOJQqSq0R0bwYZP9N9o1FKUexkyrVYL7uTKHGwKP3Gxb568+x3uDO
	yavoBnLOKVWCrrdiwihSAmjxII74efEAW8ilwbYlXQmno6/fanrJOTY0wqiQui1bav665vkbmOH
	FHBW2s0dyaeteFNaYAGrb4RgKbbH4OHq0sJ9iw7pC4AHMeKtrDAQrUCk/XZm3W0FUY+igEL+HW9
	gDfHwMW2MspaR4P3ppT7KwAbuz11Cn4ueYKUN3KtDmlZyGgotd2BORS6JvzwmdpbBE//ECVkRWW
	Cu02R9M8jrFrqR1+quavPxJI7h0bWlFX5MERrIrFvhmUL+6D56beGesPts4EcNyVMqacsi2q3uX
	ztQXBt1
X-Received: by 2002:a05:6830:2690:b0:7cf:cd4c:347 with SMTP id 46e09a7af769-7d448accbb9mr3451279a34.30.1770306947375;
        Thu, 05 Feb 2026 07:55:47 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4492017b6sm3814774a34.15.2026.02.05.07.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 07:55:46 -0800 (PST)
Message-ID: <91c3fbcd-dd8c-4633-96c4-9b60022cb857@kernel.dk>
Date: Thu, 5 Feb 2026 08:55:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for 6.19, final
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org
References: <aYS5ZlwruxpNCdTL@kbusch-mbp>
 <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
 <ded8f99f-2d4a-48fc-9cff-02aa317a1c25@kernel.dk>
 <aYS9KeAYcTh9GIaJ@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aYS9KeAYcTh9GIaJ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_075548_964479_3B613DDA 
X-CRM114-Status: GOOD (  15.06  )
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

On 2/5/26 8:54 AM, Keith Busch wrote:
> On Thu, Feb 05, 2026 at 08:49:35AM -0700, Jens Axboe wrote:
>> On 2/5/26 8:47 AM, Jens Axboe wrote:
>>> On 2/5/26 8:38 AM, Keith Busch wrote:
>>>> Hi Jens,
>>>>
>>>> Some late fixes for nvme that should go in this release. One for a pci
>>>> regression that causes a kernel panic during certain dma conditions. The
>>>> other fixes a vulnerability in the tcp target.
>>>>
>>>> The following changes since commit 4da7c5c3ec34d839bba6e035c3d05c447a2f9d4f:
>>>>
>>>>   bcache: fix I/O accounting leak in detached_dev_do_request (2026-01-28 19:06:55 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://git.infradead.org/nvme.git tags/nvme-6.19-2026-02-05
>>>>
>>>> for you to fetch changes up to 52a0a98549344ca20ad81a4176d68d28e3c05a5c:
>>>>
>>>>   nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec (2026-02-05 07:29:10 -0800)
>>>>
>>>> ----------------------------------------------------------------
>>>> nvme fixes for Linux 6.19
>>>>
>>>>  - Fix NULL pointer access setting up dma mappings (Keith)
>>>>  - Fix invalid memory access from malformed TCP PDU (YunJe)
>>>>
>>>> ----------------------------------------------------------------
>>>> Keith Busch (1):
>>>>       nvme-pci: handle changing device dma map requirements
>>>
>>> After this one, iod in nvme_pci_prp_iter_next() is now unused, which
>>> will trigger a compiler warning...
>>
>> Actually this is only true in the 7.0 based branches. Should be fine
>> for 6.19, I'll add a commit for the 7.0 merge.
> 
> Yeah, I initially applied this to 7.0 with it removed, but we decided
> this was a nasty and easy to hit bug that 6.19 is better of having fixed
> on release. I had to leave the 'iod' in for the 6.19 port, so looks like
> we'll have a merge conflict for the next cycle.

It actually merges cleanly, but you then end up with that leftover
iod. If it hadn't merged cleanly, I would've seen it before building
it :-)

-- 
Jens Axboe


