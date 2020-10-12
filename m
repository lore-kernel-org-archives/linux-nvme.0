Return-Path: <SRS0=YdFy=DT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9C0C43467
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 16:48:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC82020838
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 16:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vKmEv7nC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r0J6Sx/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC82020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2x4XywAuuK87oVN6ceLngXdAASISn36SprdM+ACr/CE=; b=vKmEv7nCXsddlXQ4K50bUU+kb
	P9xnTYOOxrk7rv2cUWBaVujQhDrmSKqnelVKtIu+5ojUZ5MDXNgPMEarpfVQUiW7SM/Gv5WFGCxFO
	eaNkCIigjimqKdEjR+7eB2xksBGvePg6qa+dearz2Vn2tAKQ+r/hVcpYEv234e3ZPauKkIVUxGMaY
	DzRM2AKj6llNNAAPrIJ6oUEvOyO58HG4YDqXeh3fggCtP8vkSsQpBqhdzwXvDHiE5Y9K4dBYRGCAb
	Myq6wDEi1C1CFkvlQSU0V1CENVn12VWOImKmslScCgVBrgPXyTt2mGsK/xgqUVg+y7Rc/kPDAb905
	cpqIWX6Qw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kS0zw-00083a-NB; Mon, 12 Oct 2020 16:48:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kS0zv-00083B-9m
 for linux-nvme@merlin.infradead.org; Mon, 12 Oct 2020 16:48:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=c0qiq02WC8RL85uMcCI6g0IMZwRK/aQydvv8iai/B5g=; b=r0J6Sx/ynRaXiPD0rYgQZ/hVCO
 GsnX4CJ0amAf2sl19r1hkWbhzOC3Z7pF30zh/Wd23g92NllTpznPd51aqxABPJkK/V38O2aiW2/xK
 SpYuWOGWWMBoDtSSETNdRBCxov5raZFBJ6C9bg80JwlMQHFTmPGImdhxSet8v11X2Q3LFvccMih91
 jUY+UIDyZ3qM2au5/XCe3X4PvtopButc40ce9Ipfuv821LDZ3D+Y4azfFie0TyCXDIdk9tSFbg1rL
 zoLUkkWHgRvcW377XhlrGhYnxiXMxvTpuMe6aONVwutJ0KeRYQmStI0EigcAQ9KJ15qzBDT/xPSKm
 iTxlqv7w==;
Received: from [2601:1c0:6280:3f0::507c]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kS0zt-0005Ce-38; Mon, 12 Oct 2020 16:48:30 +0000
Subject: Re: [PATCH v2 01/22] mpool: add utility routines and ioctl definitions
From: Randy Dunlap <rdunlap@infradead.org>
To: Nabeel M Mohamed <nmeeramohide@micron.com>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mm@kvack.org, linux-nvdimm@lists.01.org
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201012162736.65241-2-nmeeramohide@micron.com>
 <954153c4-ee2f-2a2f-8643-8ff67d8cd649@infradead.org>
Message-ID: <bcc66e64-a19a-cb40-34cd-e71fa983b861@infradead.org>
Date: Mon, 12 Oct 2020 09:48:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <954153c4-ee2f-2a2f-8643-8ff67d8cd649@infradead.org>
Content-Language: en-US
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
Cc: plabat@micron.com, smoyer@micron.com, jgroves@micron.com,
 gbecker@micron.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/12/20 9:45 AM, Randy Dunlap wrote:
> On 10/12/20 9:27 AM, Nabeel M Mohamed wrote:
>> +#define MPIOC_MAGIC             ('2')
> 
> Hi,
> 
> That value should be documented in
> Documentation/userspace-api/ioctl/ioctl-number.rst.


Sorry, I see it now.

thanks.

-- 
~Randy


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
