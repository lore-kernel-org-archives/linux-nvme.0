Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B60DC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 23:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N+wwYJiJV7lf4unUgeH8hMkl/QFEbcBle7z7SN/75fc=; b=WM/WRI07ytcE/E6VR7CaAe9oHo
	+b7wb3GMeVNp/3gCxfk6iW0ELkzByPLGP4BHM8YwRNr/+DaGWZnbMOWGsfdCj2P8adAfiol6TZCK8
	YYEvRWQFpdIqH+sS0nOwA5IAn4B1Tg82KAJASg7+LDsqa38BA7GYhrZ3J8raIXCX0GjM0lYIe76XU
	WsL0/Aw+Q95UjVMrZQs3mMD8SZZZaaNeQ1Nl64iVsvJJnSt0RlT6wzNn+Vi7aSCTV/ZjHc5m/MDlI
	NjuMJMklncCYClMsABYugP0oyWN2le2APm2cuaZVXICl+9TiJ1Cgacn34LzebPxpQPOKwG6Ikj0Fj
	0PlQxTsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0AIl-00Bfcz-Dn; Tue, 29 Nov 2022 23:46:11 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0AIi-00Bfbz-El
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 23:46:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669765568; x=1701301568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ycxaYLjYb+ma8DDHfOmlnxZ6kUuyag3iWhXxhAoI4Bs=;
  b=ddeDK72HHIS/NPkjY+Bqh+9SoSY0EOgXK1e1Y8DBUjSNY5200KtH1NTG
   7pmZjpJFeSuagPhk9dg2AakDNoCWgE6CLjwh1C1y5H4UJupbOGYG1/iiO
   PmCVICQzWOkaDMIkAlVyICMwcJ7+GBmDgkCCOa5sUdOD2+EoAClZ+PVSw
   zutdsLkhKJPZC4OZ6cmSjebLyfDSZRNjWHuOXq0AbbCRlJw7mMFNT1moq
   TlaaP2G0ZZMJHs0id5hideEqWv6JKBYuWg/eZMYYP/k6JkGmvseZZGWfV
   FioDb+6S8T6uhfdl8kp8tLhitHrUBDtRi643jD1kc1eQwbcb2uToCUe8d
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,204,1665417600"; 
   d="scan'208";a="321847012"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 07:46:02 +0800
IronPort-SDR: emfj0B/VwDxgoU7z2j5Xbgkl5GV6OSoTXQYPXKTtNAv0SeO+XJwxCaUa2vi4viGwJOjyPCvuVJ
 Sukqf0CaRaRXRcckTADK/SRknKhiUDViHVUUkPHxOJ2b9mo4mu3H9nxfEmWHEkV58vpH4ip440
 PrGQHaPMnwRDq9BztbrSa9Y0gNSlHwKIAWXjCfeAJP+Z5WeFGWChGdJQOPrW6aIUuNEbY6NYyR
 ft88+VLXgp73jYLnE/cUOWt2buDtVEorcK5L/SfCjhtUXlSSsVT8a6qJM9mM5P1DTwRzzp8dKy
 e+0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2022 14:58:58 -0800
IronPort-SDR: 8iVAQUQ/U47+HEWwjE66rnxuaYFkdNtHzYxmfADCr2CAhaY9b4ykAXtEobPaBAG/BpbqINV4Vn
 DnfyvQPQw0tjFYUp0B8e+2THGBWS9zh/eBjonn038MPPkOWOsqhszp+t5JKJkHA4G/G5aUGQw4
 tzFuNo+Kf7W+Co+KOpc7qJ60AeYhgNnSaG4+TVTJnDsOg7zOmLH2427gAu/NHy8R0YTZJ1Ju9i
 izwUoPD1BkzH83tLOghAsCr+4Q+IPnQqC5RaCT9T+xnOIpQraIq65lyT3XW2/bGzmgld5F4S6p
 jsY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2022 15:46:02 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NMJrB1jqpz1RWy0
	for <linux-nvme@lists.infradead.org>; Tue, 29 Nov 2022 15:46:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:content-language:references:to
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1669765561; x=1672357562; bh=ycxaYLjYb+ma8DDHfOmlnxZ6kUuyag3iWhX
	xhAoI4Bs=; b=qHUBIFsDit9tB+442wqkn8FnslJgjothH93jBEv+p37QzdcVqT7
	JfyO2rDEUbUFU9ySIb6ZZMnZBkjX7o0IfKCBh9VF3scGsxJdsvMdYhmob3Tpcuab
	QG6jHaofPY0hzIb5TbUHsCGPOi6edYL/y4fqu2zn4hilxMkcewsJd7eFcQmVvb7b
	41/WHvDf10VLkoY2+XPdKEsfCgSclP6hWS1nxiADYM69SXCQQsVgN48gtFRUhqDm
	CsGxlhrpkpqISWqICcXfGp/oz1v4MaTTkLG3r0YCNvoZm6NCTsx0miQge60XpbWC
	vDK9OwTwLp1OVSbohBFP1cwtZh8aadUIFVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8MOGiKMYvkZ4 for <linux-nvme@lists.infradead.org>;
	Tue, 29 Nov 2022 15:46:01 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NMJr51fc7z1RvLy;
	Tue, 29 Nov 2022 15:45:56 -0800 (PST)
Message-ID: <b22652ee-9cca-a5b1-e9f1-862ed8f0354d@opensource.wdc.com>
Date: Wed, 30 Nov 2022 08:45:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 10/10] fs: add support for copy file range in zonefs
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, james.smart@broadcom.com,
 kch@nvidia.com, naohiro.aota@wdc.com, jth@kernel.org,
 viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, anuj20.g@samsung.com, joshi.k@samsung.com,
 p.raghav@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com
References: <20221123055827.26996-1-nj.shetty@samsung.com>
 <CGME20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c@epcas5p2.samsung.com>
 <20221123055827.26996-11-nj.shetty@samsung.com>
 <729254f8-2468-e694-715e-72bcbef80ff3@opensource.wdc.com>
 <349a4d66-3a9f-a095-005c-1f180c5f3aac@opensource.wdc.com>
 <20221129122232.GC16802@test-zns>
Content-Language: en-US
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221129122232.GC16802@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_154608_680757_1187440E 
X-CRM114-Status: GOOD (  12.49  )
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

On 11/29/22 21:22, Nitesh Shetty wrote:
> Acked. I do see a gap in current zonefs cfr implementation. I will drop this

cfr ?

> implementation for next version. Once we finalize on block copy offload
> implementation, will re-pick this and send with above reviews fixed.
> 
> Thank you,
> Nitesh

Please trim your replies.


-- 
Damien Le Moal
Western Digital Research


