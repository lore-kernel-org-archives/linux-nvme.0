Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E84EC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jun 2022 23:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w8jn/6Fg98rQXv6qPgUWMVBi2cF5wFHUU27ff7xJZUs=; b=wi08CQPZitiCg9K7xbBTcFKDPF
	ZyYuURalACa5uhNa9wLcvm8ncstwHj0H2A9zxNtVOJPga7W7TO9vC3GoHx4xB8sR12NSzG907P0iS
	yqpYN+1x3Q42NXfe35qflmUw/7lakdLYvmgv3RJujRG5vmV25lGJBaC6XFuOJJ4rFpnDMgHLOTPhi
	28sk7+Cx3NEoQLA3K7NnP+Of5kOYsP3jfJTfSM7pVUDI2sAT5guXGzNyjpAavPDfZtefTSu67nXJD
	PBSQbRdFAKr8loj1S8kCkppODVxHsmYW3ooycf4rq6JAz9V5T8g/4UQ+zqywki9zub50lFQqCw4av
	Mj5YpC5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1yvl-004kkN-Vc; Thu, 16 Jun 2022 23:29:42 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1yvi-004kiQ-Mb
	for linux-nvme@lists.infradead.org; Thu, 16 Jun 2022 23:29:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655422178; x=1686958178;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M1Jr05JZnR9lUrkDq8vnHTcIMrK8D3ELTGTIx+c8baM=;
  b=I5rXintzCQ3OPa7vmb1QQDREqH1gvc+4ckQG2TOsY7G18EBGRADVjOBQ
   3NxX1SpAoS2WV1AqccRAoveHt3ncXa5FdA95sIQVlG25wdTIOSOE2ELh8
   oaSkNcAmdausKmB4SNwkqmF/UANU01IbjrE/hYHAyfHijOtWiwkfSBwnM
   Jepn9H2T/DxAz+XRPreb8aWAXTs3GammHpGg12bmIIsdrxx/njiv7oJrO
   AwdBgpf9UO6jBKdhP8jrY33J2LZhZbPLfR5F+dtQUp1G+bwKAMKGsRqJt
   tK6EkM+CpaCQYSbM2EWHiLDQnCOK8+HmYQyNIvDuyErU4vYWk6ahAn7Jq
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="202082371"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 07:29:33 +0800
IronPort-SDR: QnUpotg44rKtj1XI2yhrJn5XsSFXxu8Q7P1ct77hMJPrkkIcW9jZRwVjM+m1iHASawTp/4ATN1
 /FjlGwq2ShlMXjwTVtu7UF+g0iv/CUL8KRTapvwb8EkAspjPa1UMWPRFfPd1CiHNu2rMn+PkLL
 Iav3UAJZMfjql9My0bOIBKSolMApRUcsAMJwk6GGG2cnP16ahZSbhrE0gITUXy1nXlmJbIhtOq
 ypNvdb196V5TyeqFBF3j5gIpTcsKeoyivAQ+9GJ/aQ6Xn2zd3lnvajDG0mrZ/I1M2YQXLUL97T
 dnCbKYU+/vkf/OsDSmPaZBhQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 15:52:09 -0700
IronPort-SDR: WKY1+zvBWAhOjajHhiVnsfciP+m/hZDC+TzyRNmNxwiVa4J+zwwGz2C2OlxiK+XJOPJNp0ATTB
 GdF5q3kzCe7IH7E7i7HSk76YAYE5YxxutGrB+VZTOY2x7mt9IN0N+lJuLQwP0Z4wRV6ZW+4ntg
 oaqd7ZRRvKxeg9/3hKAxbGgwybey2xuWUTDWGxl/7I43JJx/xsUMB2o3OPOuUIiglKENeQP76V
 23RgTEQO8ijfQsX8fNX9sr6wcm7NBxHyISOfC6bNlTl60DFVQeA0dreEXTd0qC8QmuMQtvte7i
 +SU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 16:29:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPJKn2mpBz1SVp8
	for <linux-nvme@lists.infradead.org>; Thu, 16 Jun 2022 16:29:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1655422172; x=1658014173; bh=M1Jr05JZnR9lUrkDq8vnHTcIMrK8D3ELTGT
	Ix+c8baM=; b=i+6JJJumlrgRNCcYWcsCF45bt2ecb8JVt57/UQZwPVKB9Y9xlVi
	1GFtdmm9W/cROhD0ul0E796KjYCyQc2As5v8It40xyC7usUlm0PUvk435TQgfYnL
	v3ejtmB2RVfuhEy6vFFyCmZYmZ8MelncumtncOJPBAKtC/m0fsUkSYnXll8GgSUw
	S7z/pTo5/MVw9tPeVY4wvxyp6ldlK0bnNmCWTaLew7A3CMC5blmmvVp6OHM7gDnW
	/kdKsbkT4zg2lD8pZSma7YEw1e1iMCF/T6CrzW9UvDY32bYrIZFfzE9pleN1yoL/
	Qb9Litbg6QNYnKjyxFoLYLaoGlgD7ONJM8w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BE_Qb1kSu8HB for <linux-nvme@lists.infradead.org>;
	Thu, 16 Jun 2022 16:29:32 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPJKj0df1z1Rvlc;
	Thu, 16 Jun 2022 16:29:28 -0700 (PDT)
Message-ID: <065e9c29-0ceb-9b5d-ee99-ab501773c883@opensource.wdc.com>
Date: Fri, 17 Jun 2022 08:29:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 10/13] dm-table: use bdev_is_zone_start helper in
 device_area_is_invalid()
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, snitzer@redhat.com,
 axboe@kernel.dk
Cc: bvanassche@acm.org, linux-kernel@vger.kernel.org,
 jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
 dm-devel@redhat.com, jonathan.derrick@linux.dev, gost.dev@samsung.com,
 dsterba@suse.com, jaegeuk@kernel.org, linux-nvme@lists.infradead.org,
 Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102000eucas1p27720aaa3c309327b2b9a33c5f840f498@eucas1p2.samsung.com>
 <20220615101920.329421-11-p.raghav@samsung.com>
 <064551fa-4575-87cb-d9da-90a34309f634@opensource.wdc.com>
 <50731e57-e0bb-179e-388c-32a18b0c610e@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <50731e57-e0bb-179e-388c-32a18b0c610e@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220616_162938_878349_2FD082A6 
X-CRM114-Status: GOOD (  16.02  )
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

On 6/16/22 18:55, Pankaj Raghav wrote:
> drivers/md/dm-table.c
>>> +++ b/drivers/md/dm-table.c
>>> @@ -251,7 +251,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>>>  	if (bdev_is_zoned(bdev)) {
>>>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>>>  
>>> -		if (start & (zone_sectors - 1)) {
>>> +		if (blk_queue_is_zone_start(bdev_get_queue(bdev), start)) {
>>
>> This is wrong. And you are changing this to the correct test in the next
>> patch.
>>
> Yeah, I think I made a mistake while committing it. The next patch
> should only have the removing po2 condition check and these changes
> should have been only in this patch. I will fix it up!

This one and the next patch should be squashed together. They both deal
with non power of 2 zone size.


>>>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>>>  			       dm_device_name(ti->table->md),
>>>  			       (unsigned long long)start,
>>> @@ -268,7 +268,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>>>  		 * devices do not end up with a smaller zone in the middle of
>>>  		 * the sector range.
>>>  		 */
>>> -		if (len & (zone_sectors - 1)) {
>>> +		if (blk_queue_is_zone_start(bdev_get_queue(bdev), len)) {
>>>  			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
>>>  			       dm_device_name(ti->table->md),
>>>  			       (unsigned long long)len,
>>
>>


-- 
Damien Le Moal
Western Digital Research

