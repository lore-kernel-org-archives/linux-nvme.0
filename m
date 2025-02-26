Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE020C021BE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 00:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BFPE5nqMT5TV/F32YTt+Q2sFqdqX3HzV4emGmVK7HJw=; b=tY9qyyJzfiDvoT6j9g8WD8WO3K
	WljOMN0TSs/1nuq+rr3/9hN6JsaTmwGXV0A1xx8kOfI4koECI/Fu0mrgzXwaRSwd8ufBtVX1Jfz/C
	MVqJgExeZzVRdh4qzGu2UMDzOb4pCvAl+YOjf0bHMGwcN60SlttGcmgMHi1Zs6Nl+XRbRJ+M3auaa
	FQuKrCHvcD6Bz/NmTD4dXYr8MwOX+7U3Fy4uouXiJ60TuWdxnO/L9qgfhuhTHmIuJNBfXNzdIUxou
	lZpZk0qoZtw1vX/kJjcTAj37oxJIlTU2rZXVfsm/ibBVqOYf0w4h7XyWfqcTQCMd//glqsVs4lsm+
	5ifXxylA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn5jh-00000001vbR-0b6E;
	Wed, 26 Feb 2025 00:57:17 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn4t0-00000001q25-2r1Z;
	Wed, 26 Feb 2025 00:02:51 +0000
Received: from [100.65.162.92] (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id A62F5203CDFE;
	Tue, 25 Feb 2025 16:02:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A62F5203CDFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740528165;
	bh=BFPE5nqMT5TV/F32YTt+Q2sFqdqX3HzV4emGmVK7HJw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HuaKl3qdKUi413qXmLg1j75aNN8MijOcIeKtJu18EQJFDjoRXls3deulMv1TJVsSW
	 65ILxLiYMFv1sS1yCqPvEvTeMb7w5g4ew6OAxy2dKtMZrrLZYy7Kf0E371zAONpm5r
	 c4JAQrpBSBxtsQowW5sxR9dgfpM5kWSNcx4MfN/8=
Message-ID: <df0c2400-147c-4104-a2e6-d1038ff31524@linux.microsoft.com>
Date: Tue, 25 Feb 2025 16:02:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Frank.Li@nxp.com,
 James.Bottomley@HansenPartnership.com, Julia.Lawall@inria.fr,
 Shyam-sundar.S-k@amd.com, akpm@linux-foundation.org, axboe@kernel.dk,
 broonie@kernel.org, cassel@kernel.org, cem@kernel.org,
 ceph-devel@vger.kernel.org, clm@fb.com, cocci@inria.fr,
 dick.kennedy@broadcom.com, djwong@kernel.org, dlemoal@kernel.org,
 dongsheng.yang@easystack.cn, dri-devel@lists.freedesktop.org,
 dsterba@suse.com, festevam@gmail.com, hch@lst.de, hdegoede@redhat.com,
 hmh@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, idryomov@gmail.com,
 ilpo.jarvinen@linux.intel.com, imx@lists.linux.dev,
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
Subject: Re: [PATCH v3 06/16] rbd: convert timeouts to secs_to_jiffies()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
 <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_160250_773965_667EE161 
X-CRM114-Status: GOOD (  14.57  )
X-Mailman-Approved-At: Tue, 25 Feb 2025 16:56:55 -0800
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

On 2/25/2025 1:09 PM, Christophe JAILLET wrote:
> Le 25/02/2025 à 21:17, Easwar Hariharan a écrit :
>> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
>> secs_to_jiffies().  As the value here is a multiple of 1000, use
>> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
>>
>> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
>> the following Coccinelle rules:
>>
>> @depends on patch@ expression E; @@
>>
>> -msecs_to_jiffies(E * 1000)
>> +secs_to_jiffies(E)
>>
>> @depends on patch@ expression E; @@
>>
>> -msecs_to_jiffies(E * MSEC_PER_SEC)
>> +secs_to_jiffies(E)
>>
>> While here, remove the no-longer necessary check for range since there's
>> no multiplication involved.
> 
> I'm not sure this is correct.
> Now you multiply by HZ and things can still overflow.
> 
> 
> Hoping I got casting right:
> 
> #define MSEC_PER_SEC    1000L
> #define HZ 100
> 
> 
> #define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)
> 
> static inline unsigned long _msecs_to_jiffies(const unsigned int m)
> {
>     return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
> }
> 
> int main() {
> 
>     int n = INT_MAX - 5;
> 
>     printf("res  = %ld\n", secs_to_jiffies(n));
>     printf("res  = %ld\n", _msecs_to_jiffies(1000 * n));
> 
>     return 0;
> }
> 
> 
> gives :
> 
> res  = -600
> res  = 429496130
> 
> with msec, the previous code would catch the overflow, now it overflows silently.
> 
> untested, but maybe:
>     if (result.uint_32 > INT_MAX / HZ)
>         goto out_of_range;
> 
> ?
> 
> CJ
> 

Thanks for the review! I was able to replicate your results, I'll try this range check
and get back.

Thanks,
Easwar (he/him)

