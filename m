Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE63C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 23:01:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27372207FC
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 23:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yl+EsoNc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="tOLfZLK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27372207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ON1KQUkVF5Q9TOJAAcU4xZyEX+FCmMLxVdBhuZ/quT4=; b=Yl+EsoNc+A5X+XpuGMnZ56DBv
	w/8L6BDo9nMBjNKGUGIw8t1Bx7alntOJUiKKYLOfdMVymrFD9z6XPEK5uRjqO/BiX0i7cz+lRUL0N
	WG9x2jxc6uVSsdNIBbs4zDel5059z3xg2iLIN/ij6ewf0hgquZfwIs86cLMHt9Tpl1JEmIZ4ROg85
	0l1kiylZTuOO/B0bWVQ+hiLWKdEzvnI6RRS+pMUk4BpingIg0xdd2HGXH7T9m7tuM0HXLX8pk3EDe
	VqveN0TJjMGKfr9oh7qmscD11vX0FIEDSJ+a4HhCOk4M9RQkei5hvKM4h6EEwQtV1fRkTk8Uw2z5U
	9wzuk145A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxemm-00072P-7p; Mon, 20 Jul 2020 23:01:28 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxemj-00071h-SP
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 23:01:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wh/cbRuJktuOsZzlc8uRgoVgjdqNsTzfdwIGfGrtxog=; b=tOLfZLK8pRPsPMltT5G8kggzB0
 nO41G2ploZ70DChEYnLTnJPhOV19aXLUIaLE66P1go572nRzWz1RCML0pFyGUwkTw8+P9WmzC/rHc
 pF0trKf1llt0ta4rL64uGgZRp/nSyDLfBy4aokNrjaWDGfO8sC0dHKpBp7nssrm5URlhkt8Me/n3a
 m/bQ1XKXy7xOeLpwOVrrLAPST3wBVBu+6NnQlfGnsCtzdZ12zJ9u1Big4u1pOMoEVo9+1hkHSYNti
 rW9h7PkY35K25VVHWpL8lAUQj21Ry8TGnJpwFqeyKtDhFO3BNwg+tWN1c3U6a1pN5jPgPQCQs9+gS
 lMraswAw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1jxeme-0003gG-LY; Mon, 20 Jul 2020 17:01:21 -0600
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com> <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
 <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
 <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b8fc47a2-0b53-3316-775f-0e9a8eddfdc2@deltatee.com>
Date: Mon, 20 Jul 2020 17:01:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com,
 Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de,
 sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_190125_961196_C34D76A3 
X-CRM114-Status: GOOD (  19.06  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-07-20 4:35 p.m., Sagi Grimberg wrote:
> 
>> Thanks for the review Christoph. I think I should be able to make all
>> the requested changes in the next week or two.
>>
>> On 2020-07-20 1:35 p.m., Sagi Grimberg wrote:
>>>
>>>> I'm still not so happy about having to look up the namespace and still
>>>> wonder if we should generalize the connect_q to a passthrough_q.  But
>>>> I guess we can do that later and then reduce some of the exports here..
>>>
>>> That is a neat idea! should be easy to do (and we can then lose the host
>>> xarray stuff). I don't mind having it on a later patch, but it should be
>>> easy enough to do even before...
>>>
>>
>> I sort of follow this. I can try to work something up but it will
>> probably take me a few iterations to get it to where you want it. So,
>> roughly, we'd create a passthrough_q in core with the controller's IO
>> tagset and then cleanup the fabrics hosts to use that instead of each
>> independently creating their connect_q?
>>
>> Though, I don't understand how this relates to the host xarray stuff
>> that Sagi mentioned...
> 
> passthru commands are in essence REQ_OP_DRV_IN/REQ_OP_DRV_OUT, which
> means that the driver shouldn't need the ns at all. So if you have a
> dedicated request queue (mapped to the I/O tagset), you don't need the
> ns->queue and we can lose the ns lookup altogether.

Thanks, that helps clarify things a bit, but which xarray were you
talking about?

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
