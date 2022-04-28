Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB50EC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 21:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6q2xQceNs1vuR1v5EFRDcdDShVehLIfVtEbgXkZcWFY=; b=nvWywf0tIagxm0cJSuGgmzF7hY
	75yTNCiymJTkOrLXoIw9GDiEQTMuWVjSLK0YW1XevIOhoIpHTxmInbjuauyQ3qrmXCCQrlRBdEHUT
	9e2aXuzRsUL1uK8HQLu5MRLzoLVsREKvmUHXdPm1dWjl3LJdK6R/fRGt0GJiUWwqOByT0Ozot2AqN
	oSFQ9FAj9vXrCMN6FNeRk7FLhyBLXSLbBlLvuDgn55+rUzlkKuStpi5rPeyAPNZgq73uvpyFuGS/t
	TsmEP171qAs367/BoTVhEjEcKQ+g+XF9ZKte4DP+yLWMC+d84/D2L53XlgmllXdBhq26JlZUXJf+0
	W7FiN/4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkC8Y-008dru-4E; Thu, 28 Apr 2022 21:57:22 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkC17-008aDC-1R
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 21:49:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651182580; x=1682718580;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cyLVSk6BbZwyGjjwD1EPGCFpNeRSIZ2G598CAEec1yg=;
 b=jnvUzulXm+QvWb+t3zkCXSuB9tAtuXdOrF32zIpK8gcUeoOShLqynVub
 FogAESaY75QKIXy1ROF7878vp6W0CfaM9jKpn6bMDTrLk4PayznI6alAK
 m13Wcs460jUpXk1Ht1RjX+be8LUzLbpVba5oxQK73W+zvpzROvJqWfqo7
 AuUALkItk3Uo6jXeMu95oTiEIIyvyi5oR88nfHvsDJvb9x1Dnb6ZmNbqH
 shvMT/YjWfvoC95XalZ1AmlIBxgWEtSsKv2hZGxA+c0IioWTiX/tuVH27
 E7uueq2ji/ACb3TJ9mh15n/7n2ZbmwDryMH+BsW50/xpejS17Wwn2jvYM w==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; d="scan'208";a="303311284"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2022 05:49:40 +0800
IronPort-SDR: I4udefpobAMr5qhjVqkpgMqgQ/V2nHhuavAbSWsD0TUVurydwsX3YOWUcx3KRs3GD/7L7Hbhrj
 ivjCq6+MBlQYfDK3eAYScL8bBnWd5RSoBQmbkuY0UbgkcwgUmS1JCDHdjnOna5Bpc6n4gG1Rhz
 t9nDemjVg4jE3Uokk4Zeuxl0yBT7zePYqYLHwHHj9w6oCG8IowVo7LafHJrSAQWSZL6pAdNyNT
 zXBeQrP67PGBxIsFQzUbCMRgCwdd/IIub9X2YIgpPy0/wNRFH8zEQn6Z557Bv5yFD7T+8d++X4
 7Z5w4evyAHB3ycmTeiATAsan
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Apr 2022 14:19:48 -0700
IronPort-SDR: 2BqsyPEPeQ+GnmJrN6a3sZ2YI+YbQDOKFmhRPlC/1/ztn5JIv7i80+JQLQBUjUWL5jDJ7AQlcY
 PGOc6VdtVpCyEbyWFttDznscw3IcczrcW6y+xNG+Zx5+68AAFkbUXukA9Xbh/GSQw+Iq3TvEx3
 JpT3pvhCxPGW5ylCkdi5Qn/1UEorhZEeSIfxYHKJT/mK5D4oBbFNOvENFKIxA/TKdE8bLp2mJA
 PVoanXiEK6JqSyZGiq4IMHqwwpKLUsLjnZQTbNvn99Z+7lMR2mgso9MuX3kF7i1H00lki9AEvv
 ib0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Apr 2022 14:49:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kq8R76vWYz1SVp5
 for <linux-nvme@lists.infradead.org>; Thu, 28 Apr 2022 14:49:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651182578; x=1653774579; bh=cyLVSk6BbZwyGjjwD1EPGCFpNeRSIZ2G598
 CAEec1yg=; b=WwDx6zjd5KL3eBUwwa0frNLPJfE5RvQ5zQDMlt1v+brK+CSfEOM
 AwrfKkAoj2MBEg6wPs2KU3cJ8RSuEjUUfxJA/SnSSyFA0auCwS8BShF8Rbde2kZt
 F/4slST/ipXIa+YYgpBZD6WGrhaVTjjKv0mIiW+HQG2XMJl7BpdYBUrEDvL2VHLv
 OVhzsmUWCuQAL8m1VmKZeCeUWiXVI61R1ZfdjxD4e1pIAEdOCsLHVPrXFurRHvrK
 IsiOGhM4lfUwCPBepH8wbdpUuGAD3BpaImFC+lb69DkA3rJxyldi/EA6SbDqlURe
 uqC0i0yoxJWPS5tpYnGwaGc29HA02pISISQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 2749i5XOekyA for <linux-nvme@lists.infradead.org>;
 Thu, 28 Apr 2022 14:49:38 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kq8R21lmLz1Rvlc;
 Thu, 28 Apr 2022 14:49:34 -0700 (PDT)
Message-ID: <a68a2d40-dff4-bac6-bb05-57c5c88af66e@opensource.wdc.com>
Date: Fri, 29 Apr 2022 06:49:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 12/16] zonefs: allow non power of 2 zoned devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
 axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
 naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
 johannes.thumshirn@wdc.com
Cc: linux-kernel@vger.kernel.org, clm@fb.com, gost.dev@samsung.com,
 chao@kernel.org, josef@toxicpanda.com, jonathan.derrick@linux.dev,
 agk@redhat.com, kbusch@kernel.org, kch@nvidia.com,
 linux-nvme@lists.infradead.org, bvanassche@acm.org,
 jiangbo.365@bytedance.com, linux-fsdevel@vger.kernel.org,
 matias.bjorling@wdc.com, linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160309eucas1p2f677c8db581616f994473f17c4a5bd44@eucas1p2.samsung.com>
 <20220427160255.300418-13-p.raghav@samsung.com>
 <bfc1ddc3-5db3-6879-b6ab-210a00b82c6b@opensource.wdc.com>
 <c490bd45-deab-8c2b-151c-c8db9f97e10c@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c490bd45-deab-8c2b-151c-c8db9f97e10c@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_144941_223928_F56C8C63 
X-CRM114-Status: GOOD (  21.12  )
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

On 4/29/22 00:54, Pankaj Raghav wrote:
> On 2022-04-28 01:39, Damien Le Moal wrote:
>> On 4/28/22 01:02, Pankaj Raghav wrote:
>>> The zone size shift variable is useful only if the zone sizes are known
>>> to be power of 2. Remove that variable and use generic helpers from
>>> block layer to calculate zone index in zonefs
>>
>> Period missing at the end of the sentence.
>>
> Ack
>> What about zonefs-tools and its test suite ? Is everything still OK on
>> that front ? I suspect not...
>>
> I don't know why you assume that :). Zonefs had only one place that had
> the assumption of po2 zsze sectors:
> if (nr_zones < dev.nr_zones) {
> 	size_t runt_sectors = dev.capacity & (dev.zone_nr_sectors - 1);
> 
> In my local tree I changed it and I was able to run zonefs tests for non
> po2 zone device. I have also mentioned it in my cover letter:
> ```
> ZoneFS:
> zonefs-tests.sh from zonefs-tools were run with no failures.
> ```

This is still not convincing given the code I saw. Additional test cases
need to be added with data verification & concurrent regular writes also
sent while doing copy to verify locking.

Which also reminds me that I have not seen any change to mq-deadline zone
write locking for this series. What is the assumption ? That users should
not be issuing writes when a copy is on-going ? What a bout the reverse
case ? at the very least, it seems that blk_issue_copy() should be taking
the zone write lock.

> I will make sure to add my private tree for zonefs in my cover letter in
> the next rev. But even without that change, a typical emulated npo2
> device should work fine because the changes are applicable only for
> "runt" zones.


-- 
Damien Le Moal
Western Digital Research

