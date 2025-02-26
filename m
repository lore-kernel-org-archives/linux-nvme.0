Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED0BC1B087
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 15:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:To:Cc:From:References:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZqGB3dHEkHXDAW5t23ZRy/tk7CvQyYHBVX5yXFeysoI=; b=HG3eY7sUsXNzHeROsAQl1EKH96
	ck0u/0ybAF6hX1I+e16mnbQs0esB4FAPOqiC6o2SCMTv4WP3caQehGTjhc1UItO9r2cFcR5aCFsPJ
	Z6bXJVk7yjvGFNQOjnC0ryKXGOSXdR8gl4Tssa+2FfgOICteAc1pMA2MfklRFN+8mkmwwnDBxvmRb
	0khPOerxf9jd+G5zQsIJM4zVggA3BwniO3aT8GKRk1qQ5oNxIxhOLYNLg+P128i/PhdeTxwCUrg2O
	EPFnief0aEqg/czR254lgdI946YnRq2L/s+aRyPxjaEat6uYiUcAm08NHSiVzas2AgeDVpFaFrVVR
	cnqV89kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJEq-00000004FK8-1IDE;
	Wed, 26 Feb 2025 15:22:20 +0000
Received: from smtp-66.smtpout.orange.fr ([80.12.242.66] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnCUr-00000002pAx-1Gr3;
	Wed, 26 Feb 2025 08:10:27 +0000
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id nCUZttGc7xgLFnCUctj4sa; Wed, 26 Feb 2025 09:10:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740557422;
	bh=ZqGB3dHEkHXDAW5t23ZRy/tk7CvQyYHBVX5yXFeysoI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=eN5Aq4eovmdL2fTfqQhqmyNlSDtRmJIyRo9BV90ujHdViAKnbjtHr7qbLtUGcLRlZ
	 sm6a7gFroiFb3USkdQ363fe5J2nBAhWrC7vKq9Gr98LlhArejaCxQtmS/g1lQfI49r
	 0aIAOKfoRo4tNDooG9At7xMG826jfO8nyaZlknhJmJI7Jeype1X6hRb1E9umLPEZG2
	 XbWU654Orv/crOsdG/XuK2GvaB+YBDki8U4i31RNmbRUpE2c+df/ckkinYznub6VnQ
	 yhVMeiNx7yCwm+qgQ83RKYb4GoAOEUYS84Jpg4YkW7VlX71dQkYv0MO6jlmI4MTa2U
	 +sFJCwiWciqJQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 26 Feb 2025 09:10:22 +0100
X-ME-IP: 90.11.132.44
Message-ID: <7b8346a1-8a7d-4fcf-a026-119d77f2ca85@wanadoo.fr>
Date: Wed, 26 Feb 2025 09:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/16] rbd: convert timeouts to secs_to_jiffies()
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
 <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr>
 <CAPjX3Fcr+BoMRgZGbqqgpF+w-sHU+SqGT8QJ3QCp8uvJbnaFsQ@mail.gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Frank.Li@nxp.com, James.Bottomley@hansenpartnership.com,
 Julia.Lawall@inria.fr, Shyam-sundar.S-k@amd.com, akpm@linux-foundation.org,
 axboe@kernel.dk, broonie@kernel.org, cassel@kernel.org, cem@kernel.org,
 ceph-devel@vger.kernel.org, christophe.jaillet@wanadoo.fr, clm@fb.com,
 cocci@inria.fr, dick.kennedy@broadcom.com, djwong@kernel.org,
 dlemoal@kernel.org, dongsheng.yang@easystack.cn,
 dri-devel@lists.freedesktop.org, dsterba@suse.com,
 eahariha@linux.microsoft.com, festevam@gmail.com, hch@lst.de,
 hdegoede@redhat.com, hmh@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net,
 idryomov@gmail.com, ilpo.jarvinen@linux.intel.com, imx@lists.linux.dev,
 james.smart@broadcom.com, jgg@ziepe.ca, josef@toxicpanda.com,
 kalesh-anakkur.purayil@broadcom.com, kbusch@kernel.org,
 kernel@pengutronix.de, leon@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org,
 martin.petersen@oracle.com, nicolas.palix@imag.fr, ogabbay@kernel.org,
 perex@perex.cz, platform-driver-x86@vger.kernel.org, s.hauer@pengutronix.de,
 sagi@grimberg.me, selvin.xavier@broadcom.com, shawnguo@kernel.org,
 sre@kernel.org, tiwai@suse.com, xiubli@redhat.com, yaron.avizrat@intel.com
To: neelx@suse.com
In-Reply-To: <CAPjX3Fcr+BoMRgZGbqqgpF+w-sHU+SqGT8QJ3QCp8uvJbnaFsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_001025_883647_502E31D4 
X-CRM114-Status: GOOD (  21.15  )
X-Mailman-Approved-At: Wed, 26 Feb 2025 06:39:23 -0800
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

Le 26/02/2025 à 08:28, Daniel Vacek a écrit :
> On Tue, 25 Feb 2025 at 22:10, Christophe JAILLET
> <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org> wrote:
>>
>> Le 25/02/2025 à 21:17, Easwar Hariharan a écrit :
>>> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
>>> secs_to_jiffies().  As the value here is a multiple of 1000, use
>>> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
>>>
>>> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
>>> the following Coccinelle rules:
>>>
>>> @depends on patch@ expression E; @@
>>>
>>> -msecs_to_jiffies(E * 1000)
>>> +secs_to_jiffies(E)
>>>
>>> @depends on patch@ expression E; @@
>>>
>>> -msecs_to_jiffies(E * MSEC_PER_SEC)
>>> +secs_to_jiffies(E)
>>>
>>> While here, remove the no-longer necessary check for range since there's
>>> no multiplication involved.
>>
>> I'm not sure this is correct.
>> Now you multiply by HZ and things can still overflow.
> 
> This does not deal with any additional multiplications. If there is an
> overflow, it was already there before to begin with, IMO.
> 
>> Hoping I got casting right:
> 
> Maybe not exactly? See below...
> 
>> #define MSEC_PER_SEC    1000L
>> #define HZ 100
>>
>>
>> #define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)
>>
>> static inline unsigned long _msecs_to_jiffies(const unsigned int m)
>> {
>>          return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
>> }
>>
>> int main() {
>>
>>          int n = INT_MAX - 5;
>>
>>          printf("res  = %ld\n", secs_to_jiffies(n));
>>          printf("res  = %ld\n", _msecs_to_jiffies(1000 * n));
> 
> I think the format should actually be %lu giving the below results:
> 
> res  = 18446744073709551016
> res  = 429496130
> 
> Which is still wrong nonetheless. But here, *both* results are wrong
> as the expected output should be 214748364200 which you'll get with
> the correct helper/macro.
> 
> But note another thing, the 1000 * (INT_MAX - 5) already overflows
> even before calling _msecs_to_jiffies(). See?

Agreed and intentional in my test C code.

That is the point.

The "if (result.uint_32 > INT_MAX / 1000)" in the original code was 
handling such values.

> 
> Now, you'll get that mentioned correct result with:
> 
> #define secs_to_jiffies(_secs) ((unsigned long)(_secs) * HZ)

Not looked in details, but I think I would second on you on this, in 
this specific example. Not sure if it would handle all possible uses of 
secs_to_jiffies().

But it is not how secs_to_jiffies() is defined up to now. See [1].

[1]: 
https://elixir.bootlin.com/linux/v6.14-rc4/source/include/linux/jiffies.h#L540

> 
> Still, why unsigned? What if you wanted to convert -5 seconds to jiffies?

See commit bb2784d9ab495 which added the cast.

> 
>>          return 0;
>> }
>>
>>
>> gives :
>>
>> res  = -600
>> res  = 429496130
>>
>> with msec, the previous code would catch the overflow, now it overflows
>> silently.
> 
> What compiler options are you using? I'm not getting any warnings.

I mean, with:
	if (result.uint_32 > INT_MAX / 1000)
		goto out_of_range;
the overflow would be handled *at runtime*.

Without such a check, an unexpected value could be stored in 
opt->lock_timeout.

I think that a test is needed and with secs_to_jiffies(), I tentatively 
proposed:
	if (result.uint_32 > INT_MAX / HZ)
		goto out_of_range;

CJ

> 
>> untested, but maybe:
>>          if (result.uint_32 > INT_MAX / HZ)
>>                  goto out_of_range;
>>
>> ?
>>
>> CJ
>>

...

