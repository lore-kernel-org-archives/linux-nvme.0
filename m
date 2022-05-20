Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C0EC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 03:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=43MITOhhcpT3zFdSGUUqLzt/83kE9ZJ7yIIW89qHhhM=; b=rv5z0bi2GEeP2ZhipH85a1Oo2l
	Q7/kZDS/E425nTcafGz4Fo4TfMLsTGUzpvTucbQXUMtg5J4j65Agq49mwzSHyDDI5Wu+JdMiYintt
	1ejrVhNK2Lkh4RMgsawTe8GA3uVYv05DzkjOqJUft23xoBkJR2cie4kxTjCmoqaXnqq6KLHB1pScl
	vAyEl57yksqHeD4AD1orIYY14E/Fw3s2sSzCdnv7YIouuPQeObKsFMzg3eEnDo0CtssoxbunQW7DS
	Q+yPjJs7wJhxVxymw/yttnMbkVyGmhCZuiw4MXyHnjg/Cxb7N9R7iNV6DR+2Eys7WhvAi3agJt0bE
	imZVkxCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrtbf-00ALgE-VN; Fri, 20 May 2022 03:47:15 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrtbd-00ALfR-7c
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 03:47:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1653018424; x=1684554424;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=6lc1EXDyRH/qdIBQrgfdid5K6UO5RT0eqtEDiI6MCtI=;
 b=ZNxLFRCXxKOI4RtnHCVYswtLoOzjZyfLkYV91kYXdVwTb5es+6b3Cgpk
 7bDzFJfPu8BGHbUk7WQxdAQlWqAvtzfe79T8jCPOjbqqAGEaZWin6KG9T
 KHzHuoHM/PrLMXcgH85PitESX+JoI8D6RFLf+dhyMfZXRGQVUxJDOnv/v
 uk+8uFA17aw0BRP4Zc2RwdbLS0ptq3wAzBMfTvaQdBl/rOxNxiykR1Q3c
 eF77w0Z+vB7wcy9j4OtuzoUI+iwq7mG6QyndC5mUJx7fJZJTPikGm5YIR
 tYxxUoEayrRYUIJs3XRF+Rq9aN6VawtDboF/JV7OJkeowXV7ofBh3uGev g==;
X-IronPort-AV: E=Sophos;i="5.91,238,1647273600"; d="scan'208";a="200879637"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 20 May 2022 11:47:09 +0800
IronPort-SDR: e4KYEtmkhTxmIuA292JU2z22vrNtEas5vttxrimLr0RpBi/auxlgQYoIYBelm8FdJ2ca70nk/o
 +H7i3Bsh3t+Fx7lYmhGc+Hu/WIZ5ZLnnolWRN9tmbDTqRlqc0mFyu0XwPynku6DpajpG2JU1a8
 ouEFZ2JzR5E4PS/UN/GG7amL7NNuZNDK2VXkiOmSt7iWp2rWKNBP8/4QqaU6ktPo3tR9aDUUbI
 K1+UEp9Ha3gY0fTTThkvUJuRSaMtAMJIu+Ju/PhaPV+qY8gahdXkNcSe0yQbilJRIZLs6gsTV4
 VPKC1A6GQA3gY/yIaFcOYo2Z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 May 2022 20:12:32 -0700
IronPort-SDR: LMYGmmE2MJ+LKvQFR4FFc8fXC3GnNXkEMluG+Q+iigILaUSNP2QKELMNiKXDvpOOUtYeA8VR8/
 TQPULEROnv0qRSDnULDdTXXnFVaBf5xsJ0GrW99vZ19tCoSHprH5fV54ZfNbl1xfx6Tmbl2TiJ
 1JvAVdT6+uuuKVxlrC5OtLwAttD0GfCnZbhXGRgkgZHRq6rivZxzmB8puk5pKbrFm3CoSN6b/k
 pa9IDRz9hXtt+BY/Wckxgh0ZyxZrkIW8yQAOtVGULOl5RlBi120EThatiSUSA1YnHUoKFB0VeA
 2AQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 May 2022 20:47:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4CMw590cz1SVp7
 for <linux-nvme@lists.infradead.org>; Thu, 19 May 2022 20:47:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1653018427; x=1655610428; bh=6lc1EXDyRH/qdIBQrgfdid5K6UO5RT0eqtE
 DiI6MCtI=; b=Qs9M+NujlyY8B4k/o4j7hSbfG13ti0oADtMb/umY3xRCYTQNY3J
 T2xdFmUh9CSB7RfRlgugV018loJtAR0z9EGT0S58D6UYUFDTmHf8P8VRWqemnD12
 hS5OmTUPjVTzO+ZX5W6IdWB0kk6jh2k0nN3xK9Z0v3wpoOMnabK1LKBbkgGTqBxf
 z7r3LFquTotFb5ib6u0lxv3Tw3J3qHygfRYrez3CbkQ5MZOQjEIeRlWkIKwHWt+R
 TYFK2ggtvkfb8RaQH6RyquQyFCRfVmNQe16t3cZb3xRBq3AUFjgPefGP0/pWMal0
 Ic2RxZWrwEWckGJNSitECSJ/V7Iv8+V+Fqg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 1mKdhZuhgRE6 for <linux-nvme@lists.infradead.org>;
 Thu, 19 May 2022 20:47:07 -0700 (PDT)
Received: from [10.225.163.45] (unknown [10.225.163.45])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4CMr5cBWz1Rvlc;
 Thu, 19 May 2022 20:47:04 -0700 (PDT)
Message-ID: <4a8f0e1b-0acb-1ed4-8d7a-c9ba93fcfd02@opensource.wdc.com>
Date: Fri, 20 May 2022 12:47:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Luis Chamberlain <mcgrof@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
 Pankaj Raghav <p.raghav@samsung.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "pankydev8@gmail.com" <pankydev8@gmail.com>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "dsterba@suse.com" <dsterba@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
 <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
 <20220519031237.sw45lvzrydrm7fpb@garbanzo>
 <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
 <PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_204713_446057_4619D2F0 
X-CRM114-Status: GOOD (  21.30  )
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

On 5/19/22 16:34, Johannes Thumshirn wrote:
> On 19/05/2022 05:19, Damien Le Moal wrote:
>> On 5/19/22 12:12, Luis Chamberlain wrote:
>>> On Thu, May 19, 2022 at 12:08:26PM +0900, Damien Le Moal wrote:
>>>> On 5/18/22 00:34, Theodore Ts'o wrote:
>>>>> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
>>>>>> I'm a little surprised about all this activity.
>>>>>>
>>>>>> I though the conclusion at LSF/MM was that for Linux itself there
>>>>>> is very little benefit in supporting this scheme.  It will massively
>>>>>> fragment the supported based of devices and applications, while only
>>>>>> having the benefit of supporting some Samsung legacy devices.
>>>>>
>>>>> FWIW,
>>>>>
>>>>> That wasn't my impression from that LSF/MM session, but once the
>>>>> videos become available, folks can decide for themselves.
>>>>
>>>> There was no real discussion about zone size constraint on the zone
>>>> storage BoF. Many discussions happened in the hallway track though.
>>>
>>> Right so no direct clear blockers mentioned at all during the BoF.
>>
>> Nor any clear OK.
> 
> So what about creating a device-mapper target, that's taking npo2 drives and
> makes them po2 drives for the FS layers? It will be very similar code to 
> dm-linear.

+1

This will simplify the support for FSes, at least for the initial drop (if
accepted).

And more importantly, this will also allow addressing any potential
problem with user space breaking because of the non power of 2 zone size.

> 
> After all zoned support for FSes started with a device-mapper (dm-zoned) and 
> as the need for a more integrated solution arose, it changed into natiive
> support.
> 
> And all that is there is simple arithmetic and a bio_clone(), if this is the
> slowest part of the stack involving a FS like f2fs or btrfs I'm throwing a
> round of anyone's favorite beverage at next year's LSFMM.
> 
> Byte,
> 	Johannes
> 


-- 
Damien Le Moal
Western Digital Research

