Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330E8C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 23:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c9Mb3V2rysf84iO0kb3yPAj0/QZ83AN7HSENEvqQ9nI=; b=dBXLrPttNhstDQlIZYnK9ZGkuf
	70VCGX4PwmpaWvC4qY/KweDulQ8MCHBhj0KahNjQWsFqvvSiD4aZXDZ6tqhrxC4HV8eW4rNUUdgHM
	oFApIvDfmQmaHv4O4ccPsxkm0mhP72foJ0kSQo/tAYW6RcDuEybe4PE9TlMPmzTe8AO3giMQb3IpV
	rJHRO9qQHPbX001ehRTDgPMV24rtVzp+IKB+82uK3Ep6/LqYr8P9nKJAjrpE5ikfV5CJmBhOFG0bZ
	iVIucgMBvsrNQYxcU3bldoTDjbdX+UO7Be2D/j021VCVCvfAKRglUfrqmCt3DXt/BcLZDyOY+lV8Q
	TR1grtQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okvxM-00Avsq-7e; Tue, 18 Oct 2022 23:25:08 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okvxJ-00AvrI-9R
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 23:25:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666135505; x=1697671505;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CnWgzw6L+sWoYU1ATlgBxxsAPYDbsPoZLaq3V8Sleyk=;
  b=jMfMf0Z8kMAnUYaAh6PgKgsQKR2L5mT/USNk2rOdVHO9W1JUXaX8WAGO
   uwU3/X6Gub74nhL/3NPaz79DhBihMBLdayc7ubYnpUA/X1Ixc+k+pzCQV
   kjBcaK3ciy0NbYKG1tlRCzkP9pVQpBqLdZU8zddWI9ET8kI0SoyymddeF
   hS5XXF97ZGKgq3RWFr0BBQEUGJt0dZb4BLHnC2Yfd1D3rQrNgtyBTQPwR
   hU2cb4a7KN598XS+yu+YyvrwNHW78yGFouObGzSg7jXcD1eswzCaG0fuv
   OUjR+0304sVv8GhBwLhSaLSY2GUCXf5AGmvzAw1SDbJlWSuRFuuCSDlre
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="286649120"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="286649120"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 16:25:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="697763571"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="697763571"
Received: from fmmunozr-mobl1.amr.corp.intel.com (HELO [10.212.59.160]) ([10.212.59.160])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 16:24:57 -0700
Message-ID: <1bff16e2-576b-f141-aee6-898649a9ffb3@linux.intel.com>
Date: Tue, 18 Oct 2022 16:24:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [Question] nvme namespace enumerated to 2 when hot-reinserted
 into a server in 5.14 kernel(RHEL 9.1)
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <f3b75aec-d29a-8c6a-1b12-6cf7b83d9892@linux.intel.com>
 <Y08U0dr9Kgl0Pbvt@kbusch-mbp.dhcp.thefacebook.com>
From: "Munoz Ruiz, Francisco" <francisco.munoz.ruiz@linux.intel.com>
In-Reply-To: <Y08U0dr9Kgl0Pbvt@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_162505_415081_7CDA98C4 
X-CRM114-Status: GOOD (  15.65  )
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



On 10/18/2022 2:04 PM, Keith Busch wrote:
> On Tue, Oct 18, 2022 at 01:22:01PM -0700, Munoz Ruiz, Francisco wrote:
>> Hi,
>>
>>
>> We are hardening our tests for RHEL, and we'd like to know if this is the
>> expected behavior.
>>
>> After a couple of tests via trace-cmd and booting with
>> nvme_core.multipath=N, we found that the number "2" presented to userspace
>> comes from nvme_init_ns_head()->nvme_alloc_ns_head() when an SSD is
>> hot-reinserted
>>
>>
>> ret = ida_simple_get(&ctrl->subsys->ns_ida, 1, 0, GFP_KERNEL);
>> if (ret < 0)
>> 	goto out_free_head;
>> head->instance = ret;
>>
>> Then in nvme_alloc_ns() the string representing a disk name is assembled via
>> sprintf because nvme_mpath_set_disk_name returns immediately due to
>> multipath == false
>> /*
>>   * Without the multipath code enabled, multiple controller per
>>   * subsystems are visible as devices and thus we cannot use the
>>   * subsystem instance.
>>   */
>> if (!nvme_mpath_set_disk_name(ns, disk->disk_name, &disk->flags))
>> 	sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
>> 		ns->head->instance);
>> ns->disk = disk;
>>
>>
>> We also observed that the ida API used in core.c was updated in a recent
>> commit 8b850475c08caa9545c460d7. Does this fix the namespace numbering
>> presented to the user via disk_name? if not, should we pass our tests if
>> nvmeXn2 is observed instead of nvmeXn1 when hot-reinserting an SSD?
> 
> If the last number is incrementing, that means something is holding a
> reference to the older one that you removed.
> 
> Assuming a reference is being held, a hot remove-insert sequence would
> expect the controller holding the namespace to be removed. The
> subsequent insertion would have the controller enumerate with a new
> instance number instead.
In our test we are reinserting the SSD in a new PCI slot and this 
enumerates the controller with a new instance like you said, however we 
see namespace 2. Ex: nvme0n1 becomes nvme9n2
  Ex, if the namespace was nvme0n1 before, we'd
> get nvme1n1 next time instead of nvme0n2. Or are you just detaching the
> namespace without detaching the controller?
We are not running any nvme-cli command(like detach-ns) before 
mechanical remove. (Sorry, I don't know if this is what you asked)

