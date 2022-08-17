Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F44C25B08
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kF6L5lBVEYEWO6HCovKa2gIExjDrBBg5oudOvILDX18=; b=3clcKBlQ0u9tTLCAwCw8kJogTr
	wUSDXFp7QO1yjr18HOKokVJolHE8VoZ3aFttqtBGkCNJdkRIrfeMNtKv/WMoaNuQ+p9EUllASGJm7
	bzVYafJsojWZim9eQpIbn2Q+gNbdDRcHd12F12k8UWrVhcw/TuuU6K3q/2HBDZQotx623NGnP/Ook
	C92B8UawRIjbeSdZjdHteo5bA0iMnu2cbr/sQK4ZTxHV8ZJ0sCNq9S08OT6bkLJZ2wD2URUrTisqL
	56VkFoLgsrNibmYMqc3cdctYMwQl2UGZFOzLK16t2gpsjN7yjeCjbF9qZDf9xnwszsz09hH5mGwOo
	LwJxMUmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOLcl-003eVX-Cj; Wed, 17 Aug 2022 16:10:31 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOLce-003eQJ-SF
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 16:10:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660752622; x=1692288622;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tGXL1veMClRR6J6COmjOo7zqJDj1I9afT5K0DiyexSs=;
  b=pnXMLQfrMc4x/G8Nn/NtSmzBND7NQlsCnsyYAIopR3gpWeddARRxj342
   IYXwv1F01b4Jivrbu45Rxn2arVLCRt4IsvC3wvyMkfamZBSSOIyeMO/tp
   ft/97NhCh56Q5jpqRN5gUCNBmTxa93kV0KwLlpzmSLMyaBYI8cLTfSoay
   y+6PcUuLLhk4BbTwsfKp6fLyjz4VqYANAWRQi0eaHTjWuXsm8cRgGvgTn
   QaOCwHnUbNK3KwpwPPDAoz4ogIr2p4jAR3KLp8iAOlMrnkmgjUoAPQKwK
   BZPmGeK55Q2VWbwOSgQMiniNOvLwjcN0btnYflaIzyENTDcLK8ecPs0fc
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,243,1654531200"; 
   d="scan'208";a="208955154"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2022 00:10:16 +0800
IronPort-SDR: 8Hx65kUeOKfSJ4Z8ICsnecB7AGDCP1KviK4ZowbaFLQT8NcLGv8U99uVgPA3vb675OASrTbHQq
 j7Qhxqz1VkQSR+a0db+j913kjfpxMznjkp/0mH1LHJ2NZJr4qrGOh9bZAS2kEBefXVAYbeUwbf
 E34B9lDERrnmIBGOPzXiATtbMyo4sO6inOF2oF1zwE2kGZGsFTPbpCQ7lyLiWkL9KftpMK/lCw
 ZTyDvbVAjW+Yjh0O+bxFCB0o9QVT8ak0qvL71ECwHrY4WApNrIYdX1396la+l9shyeerEKUYWw
 hrqWr49zIU586Ku/tB4l8rJd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 08:25:46 -0700
IronPort-SDR: +0iTLo2yjIQRFbDSWLH3LFc6uK2GVrhDnCnJWNkWFVjsC3VP7Hlef3cbGupmeKR54PcJYZkhzc
 /FJCvpJmsKlKkv8StxgcbighGuTP7W5qRuIy0ndj2YfMR68hLRHWFtzkngumLh3NbBqUquaBfE
 TUZL5HJvWOStDm8VARtpAmRQ9V9LyT//WzndSlj1IM93hMgRDEJG02jf3oILjidNYZwlimi4hN
 Vc7pMb8BmHQVlzAOkfRJKLWv75NplTzGEZcjT1z9vL423X6zTbNwswf80vzkAnsY0MsNM9zwUs
 8CE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 09:10:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M7CfL2WlHz1Rwnl
	for <linux-nvme@lists.infradead.org>; Wed, 17 Aug 2022 09:10:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1660752617; x=1663344618; bh=tGXL1veMClRR6J6COmjOo7zqJDj1I9afT5K
	0DiyexSs=; b=m9BkyA42lhKQOlCHS75npA6KAXx1QnGZcXPa+ScENhVWJDJNb7B
	CA4xAIg2JLIQh1qDtAFUfRAdEgicNU7AzvGl1UX407LVeNHE65d+ytCK6hieUVyP
	GfegZ1iiJLB6FcIM+/XCOJO7XUf2WX7xe7nJat0qikxM2uttvMxMvTRO3z7r6ERf
	ywpSS5GyDiYyH5Of0AxXUKuEzNQGyHY+oEQHV1sxk6T1Gk/2q/GT7quFCU/K4TUD
	dfYtsC3MKMsJlsS/IgqSjBoNzukrcw9g15hSBhwy2cI7TC86JIrtSHtbDD025sK3
	K8pihhaJ2GB2m9/g249orQLFyIo8N6bv99w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id etXy6aUaOQ08 for <linux-nvme@lists.infradead.org>;
	Wed, 17 Aug 2022 09:10:17 -0700 (PDT)
Received: from [10.11.46.122] (unknown [10.11.46.122])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M7CfJ44Fbz1RtVk;
	Wed, 17 Aug 2022 09:10:16 -0700 (PDT)
Message-ID: <840ce5cf-32d5-d694-cb79-2df871a607c9@opensource.wdc.com>
Date: Wed, 17 Aug 2022 09:10:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v11 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
 snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc: pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
 hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
 Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
 Damien Le Moal <damien.lemoal@wdc.com>
References: <20220816131536.189406-1-p.raghav@samsung.com>
 <CGME20220816131551eucas1p218faf35348e78a73aaa87d5477ecdb2e@eucas1p2.samsung.com>
 <20220816131536.189406-14-p.raghav@samsung.com>
 <30790cae-5440-2447-a8b8-52a57fa16fa5@opensource.wdc.com>
 <ab3ef674-c453-5b38-80b5-f41dcfed62bb@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ab3ef674-c453-5b38-80b5-f41dcfed62bb@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_091025_127053_97ACE324 
X-CRM114-Status: GOOD (  13.00  )
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

On 2022/08/17 0:35, Pankaj Raghav wrote:
> Hi Damien,
>>> + */
>>> +static bool bio_in_emulated_zone_area(struct dm_po2z_target *dmh,
>>> +				      struct bio *bio, int *offset)
>>
>> This function name reads like it is a block layer helper. It mat be less
>> confucing to keep using the dm_po2z_ prefix for it.
>>
> Good point. Even though it is a static function in the same file, it could
> be confused for a block helper at the caller site.
>>> +{
>>> +	/*
>>> +	 * Read operation on the emulated zone area (between zone capacity
>>> +	 * and zone size) will fill the bio with zeroes. Any other operation
> 
>>> +
>>> +	return DM_MAPIO_KILL;
>>> +}
>>
> Do you see any more issues apart from the two you pointed out?

nope

-- 
Damien Le Moal
Western Digital Research

