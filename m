Return-Path: <SRS0=hE+E=YY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE508CA9EC3
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 07:06:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47D62086D
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 07:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G9UqeLps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47D62086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:Subject:To:From:
	Date:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K6mU5R4cvXk/NALfdtUCoRHsq69GAjPcrWeL5oJpZ8o=; b=G9UqeLpszRIZX4RxD36IuR8Mu
	6GAa3vFabiR36uvbCL/pnIwz5w8GxNW9zXigc85H8N2cbwSuOcpL8eSgXFHo7bBIwJ/U74e+TjgOY
	YmsFdL833PpdPQkpl8Q8caPdzekkdyEoUOpz2I93i5KAhEJ9XTJmsUzZh7s92vTYbn8/uObGRbYoV
	Jz9mangWVmUQdz1RXMgE311gQ7D89eFeHuNUmjgBea9TthbdkCdbBE71ORDBDxn9Yzo3shAN6viqO
	HeE/ZPir9crzcKcFwqv83hs1FAvtWhsusTeXKW+QaD5wXw3HOe0amDgFRo9/DnMOHQIzf6qb+ojYM
	PS2NlaLkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQ4XB-0001iS-3Z; Thu, 31 Oct 2019 07:06:17 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQ4X8-0001hc-31
 for linux-nvme@lists.infradead.org; Thu, 31 Oct 2019 07:06:15 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7D5F6AE04;
 Thu, 31 Oct 2019 07:06:10 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 31 Oct 2019 08:06:10 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [RFC] nvmet: Always remove processed AER elements from list
In-Reply-To: <BYAPR04MB5749158C2EBD47FC48A79FF286600@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191030152418.23753-1-dwagner@suse.de>
 <BYAPR04MB5749158C2EBD47FC48A79FF286600@BYAPR04MB5749.namprd04.prod.outlook.com>
Message-ID: <82e496f61183ebdf7924d660d3b8c90e@suse.de>
X-Sender: jthumshirn@suse.de
User-Agent: Roundcube Webmail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191031_000614_278324_F7703219 
X-CRM114-Status: UNSURE (   9.73  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2019-10-30 20:58, Chaitanya Kulkarni wrote:
> On 10/30/2019 08:24 AM, Daniel Wagner wrote:
>> Hi,
>> 
>> I've got following oops:
>> 
>> PID: 79413  TASK: ffff92f03a814ec0  CPU: 19  COMMAND: "kworker/19:2"
>> #0 [ffffa5308b8c3c58] machine_kexec at ffffffff8e05dd02
>> #1 [ffffa5308b8c3ca8] __crash_kexec at ffffffff8e12102a
>> #2 [ffffa5308b8c3d68] crash_kexec at ffffffff8e122019
>> #3 [ffffa5308b8c3d80] oops_end at ffffffff8e02e091
>> #4 [ffffa5308b8c3da0] general_protection at ffffffff8e8015c5
>>      [exception RIP: nvmet_async_event_work+94]
>>      RIP: ffffffffc0d9a80e  RSP: ffffa5308b8c3e58  RFLAGS: 00010202
>>      RAX: dead000000000100  RBX: ffff92dcbc7464b0  RCX: 
>> 0000000000000002
>>      RDX: 0000000000040002  RSI: 38ffff92dc9814cf  RDI: 
>> ffff92f217722f20
>>      RBP: ffff92dcbc746418   R8: 0000000000000000   R9: 
>> 0000000000000000
>>      R10: 000000000000035b  R11: ffff92efb8dd2091  R12: 
>> ffff92dcbc7464a0
>>      R13: ffff92dbe03a5f29  R14: 0000000000000000  R15: 
>> 0ffff92f92f26864
>>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>> #5 [ffffa5308b8c3e78] process_one_work at ffffffff8e0a3b0c
>> #6 [ffffa5308b8c3eb8] worker_thread at ffffffff8e0a41e7
>> #7 [ffffa5308b8c3f10] kthread at ffffffff8e0a93af
>> #8 [ffffa5308b8c3f50] ret_from_fork at ffffffff8e800235
>> 
>> this maps to nvmet_async_event_results. So it looks like this function
>> access a stale aen pointer:
>> 
>> static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
>> {
>>          return aen->event_type | (aen->event_info << 8) | 
>> (aen->log_page << 16);
>> }
> Can you please explain the test setup ? Is that coming from the tests
> present in the blktests ? if so you can please provide test number ?

No unfortunately this is coming from a customer bug report. We _think_ 
we're having a race between AEN processing and nvmet_sq_destroy(), but 
we're not 100% sure. Hence this RFC.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
