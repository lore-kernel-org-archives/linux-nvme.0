Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390E7CA5FED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 06:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tzSyUMbaOVP4PqZjpoUmE5ENxFdraryzwtCBhVn0SF4=; b=b51NYBFYUqGWlqTyBjUu46RSsI
	D3MwwWlH3U1KeFR9NBJGgn/664dz7ha+WbsdlNSyI5juWdex6NcZx0DlzARJuj+N5Ak/PLQdPu75F
	XZGBiKUuCnvaoougP4URsI3NljPsgRKx6c9T+jSImy1PV3xkNvUDV2v70d0h2liqgl9RuDIIbJ8T6
	Nb0aH6Df21Dnu+D718CXGd2j2W+uDXzgs+wcLk2jRAXaTVP3aHnZdvYXyv8khmq1f0w2yZ0lAR3bB
	mYKzQYZ/rl1eIBzxCnZHWmRgdVj8/Glzr21I3Dap840irOoKwxpes6nhOoimbTAUlQqxjeCOBpPK+
	Au14390g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF4Sc-00000005f6b-3yxF;
	Fri, 09 Oct 2026 06:52:06 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF4Sa-00000005f6D-2o0Z
	for linux-nvme@lists.infradead.org;
	Fri, 09 Oct 2026 06:52:05 +0000
Received: from [10.95.65.84] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 395D020B716A;
	Thu,  8 Oct 2026 23:51:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 395D020B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791528722;
	bh=tzSyUMbaOVP4PqZjpoUmE5ENxFdraryzwtCBhVn0SF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ggne8UvMa+5nVG8g64tWRtb60F1gCaZM0Suf/oukOj2uYpX+kckKqMSZb9EmkchRz
	 N/FntKp/jymWswPnwdC9jTarcU/CnhOvGh1+yryMTgZe81a1rPjg25JJmM4cILbRSL
	 EcXKguPFQxZqxm15DiFxVS8xrxuWku3M5d8zm6a4=
Message-ID: <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com>
Date: Fri, 9 Oct 2026 12:21:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler
 pressure
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_235204_764783_A28CA560 
X-CRM114-Status: GOOD (  11.34  )
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



On 10/9/2026 11:24 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, October 8, 2026 10:06 PM
>>
>> On systems with several fast NVMe controllers, completion interrupts can
>> keep returning to the same CPUs faster than scheduled work can run. Each
>> handler may drain only a small number of completions, but the combined
>> interrupt stream can still prevent scheduler and watchdog progress.
> 
> See this recent proposal [1] that sounds like it is addressing the same or a
> similar issue. And there is this [2] more global approach. It's worthwhile to read
> through the discussion on both threads. I haven't done a detailed comparison
> of either vs. your proposal.
> 
> Michael
> 
> [1] https://lore.kernel.org/linux-nvme/20260818033846.53790-1-changfengnan@bytedance.com/
> [2] https://lore.kernel.org/lkml/20260819124341.4185621-1-lrizzo@google.com/
> 


Thanks for sharing these Michael. I'll check more on these, and try it out.

Regards,
Naman

