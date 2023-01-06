Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EF8C3DA7A
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jan 2023 11:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sg2ErD691gIY7IQ03M6WyT6ITXQYcEOG0AqeiVtrhlU=; b=ae6ETYCUsmx9Tz9hTLE71wo8fb
	j8RaE1zxhSwR9y+emSjHrUCO71bnLjFstVn2SUaPYn00Ai4OKiqITv4lKYa1vC++YIJN/Yi3IR+u5
	MXtEw3Qjz6SkHHeCHdBZvpH0Da1PQO+MO9+uSGovxXMD1GIA3fQl/ELvF+/CB6uSrJT+wHv2MS04U
	aeFKuEJbEEihaQoB6XOaQRJX+XnGyDTXwLGyE6m9utQr9cq5R7iYi64GaEj0G6xuQaGkA0p6Rncdf
	QI9IZh+iEC3LBpy3tSAJHhONIT9Wnzlj+PIqmLwDP7SV1BegPVrWaIot3d+zE28esqrFKbUVStCmP
	9tfKjoWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDkUL-007cdd-Jy; Fri, 06 Jan 2023 11:02:17 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDkUH-007caR-Le
	for linux-nvme@lists.infradead.org; Fri, 06 Jan 2023 11:02:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673002933; x=1704538933;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qOPZjLWb85oTosl4Zg0QMHphA/mZ2a9oPbXY3mUvq2I=;
  b=F4DtGuKfZhe6Wb/LUrQe29HCMXergsBJ0qUb8muQb8yJB7TjcFFULJuA
   YVNqLwdrvdm5+MiGVvg7sA4DVbzNCZihhHROKJ9YQnyJNxopVoYXM2qx7
   HXAADBaPAMC+49ADtEEQ1LJ9pRoS40E9WP6wmMDS/dtHXJ57QH/JflwXo
   lvRI6origODrAcBTgGqr1PAsvnnei8bku+0xEm0BhjkxnQgRA7zGCZ0pI
   gLXDauP8hPKqlV8mQO1uxMsosLYZ9O7JI+LxJQJEdC3KPDOZP/IT7+QfG
   iNMjL7Jzq4tNwQzgAug+zrejDz3AhcZC0mkKyeN87CjgOda4xKYCM8HlC
   A==;
X-IronPort-AV: E=Sophos;i="5.96,305,1665417600"; 
   d="scan'208";a="218433971"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2023 19:02:07 +0800
IronPort-SDR: Ccx1hFQ5sJb844KfSE3lrNFyOxxd66IhKJe1ARAFWh0ObH+XhAKlHy8oCxVmF32YIde2mYith1
 ho0xyOj916dC0GnW3rXgBJd7LdnU/urwJ/MR4nNsiK6jG9GZisC2X1Io4uAygeyWguy01asTIq
 W0tEvO+Ws+LAsArm229MRGdymH6Ucs8NnA521FZdoTTfP7JhXxIQyQcTYNtfuW6pJJbOwKlOKN
 +yExVf4fxVQ/vKLZKW6KrpZQvTzW1/+YBWfmBbkbgBshtqDcTkpVSqwa60/2dmfjyra3gG40Bi
 rds=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 02:14:17 -0800
IronPort-SDR: 45Z87h2wyKDiNbjuvRa/lol7n0fxblIibl/5AKIFIDCx7kx1Dp8zcLHexpyeZOhf3/xFy4VHmE
 vNK2AQ/jsT0dkyu6821izRV8bkLMa7ZegYLEwkEPlfD19UPeHrdt+qbnNmOY75CWE9H4lUrYeE
 VObgUJjeepRi+HyMnlIam4SBVseox3wcRauOcQemrCI9o81x5U51mAQh4OYW6M0G4mJnI+3aI5
 npVazSDzGRhtafNwAwyju8mgji86ltMm4h7GW+kYrefUtlLcnasYOmHu9RGow1oM3KQdQrhBs0
 el4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 03:02:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NpL5B5sRYz1Rwtm
	for <linux-nvme@lists.infradead.org>; Fri,  6 Jan 2023 03:02:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1673002926; x=1675594927; bh=qOPZjLWb85oTosl4Zg0QMHphA/mZ2a9oPbX
	Y3mUvq2I=; b=emYsWRsPcpEOiygtnbX+ay8RXWSrr1fcQ4j8rreH6rJjU2nAPaS
	VzO8gx9YDdVHkW9GQBjUF6hjKzBRitRNzQ4eoiLQWjUYn2L+Q/ar7jC4fruwf8JK
	Ugy/6fnb5aO9NTjCvBqDGvL/lezCh5xnJTUniSO7/kiiSlNeEODpep5QyWihFrWV
	mKhv/s3F01NwuKnyWchz1FtyC5XtXhd2rDJIbHuCVdpJmXycoX+tfJsnxIAU5A2o
	Ah6exVQViCJ0efyk3f8XU25Z7dEYHGu1yCQWGtb0lFcKts5ykU5VRTlsIFa+bDcg
	cDnycyHYt4hoXnjVLrZ/JjkgfjVeA3wru2Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lkEfaAFhb6FH for <linux-nvme@lists.infradead.org>;
	Fri,  6 Jan 2023 03:02:06 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NpL583jLFz1RvLy;
	Fri,  6 Jan 2023 03:02:04 -0800 (PST)
Message-ID: <e6216fe9-f77a-adb5-6ab4-2f86d6a86ef5@opensource.wdc.com>
Date: Fri, 6 Jan 2023 20:02:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/7] nvmet: introduce bdev_zone_no helper
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc: kernel@pankajraghav.com, linux-kernel@vger.kernel.org, hare@suse.de,
 bvanassche@acm.org, snitzer@kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083320eucas1p1d23de4ad21d0a7aecb74c549ebc7757c@eucas1p1.samsung.com>
 <20230106083317.93938-4-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230106083317.93938-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230106_030213_773965_87712E0D 
X-CRM114-Status: GOOD (  12.08  )
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

On 1/6/23 17:33, Pankaj Raghav wrote:
> A generic bdev_zone_no() helper is added to calculate zone number for a
> given sector in a block device. This helper internally uses disk_zone_no()
> to find the zone number.
> 
> Use the helper bdev_zone_no() to calculate nr of zones. This let's us
> make modifications to the math if needed in one place.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research


