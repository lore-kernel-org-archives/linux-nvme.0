Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F16FC4363D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:59:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971352100A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dYTP+eiN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="lcHTIxtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971352100A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NK8LFoWRqn9/Bb4GsnVm2BemZ3XJdRybLVL0qLI++SU=; b=dYTP+eiNNutLrwW97fpylxldI
	2+pzKRIjO+U6zd+GHiXzR3RFsGkYpEQtoauDcc3UNZE7ncpY4/2er0j0DsnKYrgAXwAFFPHUmhCy1
	oBchYxbjbMb/Klehq7+e8FP+8d0f/cLYkAo3qbk10uRyse6bNF+nbLs+r5qiB/iBOvYTCwcGgSW4O
	NWesVam7r/lRNSnp28bJL64HW9LHl6Ehqa9mJg+sE0l2Wk1H0nWPc6WOmKNMrULHG2Sn2v6C2lZ0S
	IQpGBku+ghGBcKT7VpbeOvIsb3Fs8iqMcqAwE8D80WWX3jwZYXPDvfpcZlf6QD6nE76ZQaMEJ2EJX
	Kr+fp/LPg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPwrt-0000gt-B3; Tue, 06 Oct 2020 23:59:41 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPwrq-0000gJ-Ma
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 23:59:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JHj9CUDHulvt/1dca/0kn+WWXEkB7eaUTv3vf/yi1ks=; b=lcHTIxtPiDHBVgECn9AZ9Qt3Bo
 +IofrW10Um/Kg01wz9y25FjxYCE8gRn4GlMmNOo5wVVPdwXHMkFK8spdCeo88gqG0Xe82CXFHrPeM
 ix4Y/+aIrHEINluE1m28LkxabWg+T4QlSU4fo9g9GHMa7MdkZcE2xlVuwew0wniUVg3gEibPXBK1q
 jk9Oh4SN3Ghsuxrfhn7fCFb4THtoTkvUcIXzrw3Y296YAJl34KCVx1wWN7ThodL063S8nMpW/jsuR
 HP11CkGzipf3VxAkBNdosKYbdoPX8uHqanmmSEATaDCKS/bQCLtOLEqP9EEsqd9zdV4zmexir0Dym
 h5oZM4UA==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kPwro-0006k3-2h; Tue, 06 Oct 2020 17:59:36 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-4-logang@deltatee.com>
 <BYAPR04MB4965C2DDD4A5FBD86A128FE9860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <868f8fb6-6024-d60d-a9aa-6513b9d0986f@deltatee.com>
Date: Tue, 6 Oct 2020 17:59:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965C2DDD4A5FBD86A128FE9860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, sagi@grimberg.me, osandov@osandov.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v2 03/11] common/xfs: Create common helper to
 verify block device with xfs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_195938_774255_6AE0B5CE 
X-CRM114-Status: GOOD (  19.26  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-10-06 5:50 p.m., Chaitanya Kulkarni wrote:
> On 9/30/20 11:54, Logan Gunthorpe wrote:
>> Make a common helper from the code in tests nvme/012 and nvme/013
>> to run an fio verify on a XFS file system backed by the
>> specified block device.
>>
>> While we are at it, all the output is redirected to $FULL instead of
>> /dev/null.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  common/xfs     | 22 ++++++++++++++++++++++
>>  tests/nvme/012 | 14 +-------------
>>  tests/nvme/013 | 14 +-------------
>>  3 files changed, 24 insertions(+), 26 deletions(-)
> 
> The common namespace is getting cluttered. Can you please create
> 
> a subdirectory common/fs/xfs ?

I disagree. The common directory only has 9 files. And given there
appear to be no other files to add to the fs directory I don't think now
is the time to create a directory. We can do so if and when a number of
other fs helpers show up and there's a reason to group them together.

>>
>> diff --git a/common/xfs b/common/xfs
>> index d1a603b8c7b5..210c924cdd41 100644
>> --- a/common/xfs
>> +++ b/common/xfs
>> @@ -9,3 +9,25 @@
>>  _have_xfs() {
>>  	_have_fs xfs && _have_program mkfs.xfs
>>  }
>> +
>> +_xfs_mkfs_and_mount() {
>> +	local bdev=$1
>> +	local mount_dir=$2
>> +
>> +	mkdir -p "${mount_dir}"
>> +	umount "${mount_dir}"
>> +	mkfs.xfs -l size=32m -f "${bdev}"
>> +	mount "${bdev}" "${mount_dir}"
>> +}
>> +
>> +_xfs_run_fio_verify_io() {
>> +	local mount_dir="/mnt/blktests"
> 
> The mount dir should be a parameter and not the hardcode value
> to make it reusable.

I also disagree here. It is already reusable and is used in a number of
places; none of those places require changing the mount directory. If
and when a use comes up that requires a different directory (not sure
what that would be), a parameter can be added. It is typically standard
practice in the Linux community to not add features that have no users
as it's confusing to people reading the code.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
