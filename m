Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FB2C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 08:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XdZYCCskLrh6+kpR44FRvoTC6+ISGgEljwz3TWezp7Q=; b=hP2hV4IhcahsRRGmYzfT+oCi8C
	4ar+AwOx0famtMyt+7bzYYsSs4RZvHYyRtayiSEDqEUiPJ4kyeNvn1o4kjSfNFjC2d1rQ05hZsXDD
	A30wf3yvmQM37AnbeZj/W9IxgC08MWF6v3sqr8nj8FY79usZdz0ga1LYX8lZhDKo9zCPG/R/sTYh4
	m8IjCSxp1TiIA5cyPX8Bec+kqLwsrV6dIAe6npdDDHDfn0iNl7oAITe50DW+CLgxpzJjyZeVguCcj
	+g8SIkk4r2B/xO8Y0kPj863Njy1hg2MnRRIaLD+/HRWNxXKR2wweAbNZ5QZ9oEIqY51tO2R4FEEU0
	BlVtFzaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngML9-00Fv46-Gf; Mon, 18 Apr 2022 08:02:31 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngML5-00Fv0n-P4
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 08:02:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1650268947; x=1681804947;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OmPuKz2YWA8zfnI8UisdXu/UB5gIbMI/eeJtu4mrOgE=;
 b=A3mgHwhj1kv++9h7+OUmRHriXOaNQly06qly0WetdBnDt310s7XuG5hL
 +HV4rtN6Opxx83kj/nLRKSg/dob1CNZdf9wTJ6hF+MrjY8E4TAJYn4aSm
 1/2C0MrXzaUxJOmc7QpAqsy/KTUKheMNHh4htn+0mZPC3bDhpq6z6YD0y
 WT+aRsJ+EF+V3lYoiInzy4zS+rqrThs+ArZ4zDx8rWbR37gZxOPTY62F4
 wRqLZskhzZFFtG4OPGL4ogn+/XIVazmCAnbdPj65Yl9tJ39dECP0LoFtb
 n0dB7iIZSz5C8HQanwSapWIpLoWdsKGVYw0GGnGCM2DODvKOkxVJ5U2P8 A==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; d="scan'208";a="198150170"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 16:02:19 +0800
IronPort-SDR: jLmvRpYAOVd4kMwg/XMHM9He3BMZWUgZe6rYWnlGEfQoQgHpnv0CddNTutlFM8uBdgAtwcDCR/
 HOJkUt6cjyiDVTdbksZJzTJmJJ8D2HDoRqN2kzkyc1+2HFkdCBt7XkjL9AlVDRUNseNBlJ/24+
 6A5QyUI4sFyKWWRFZn6j8R2NuOSI3hZUN5ns9NanYIIvS+eoeQ6u66NTDo8lgBzgYy+lhyFwFp
 JO1XJcbLaEkQknlnkmocSrsHDZCNPT6xDVUx6j7P+fYwQJv5mjLO382vdXEykZOqvW9axQjerJ
 owR5iYODvPdY8lAFOm5Ndcyt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Apr 2022 00:32:40 -0700
IronPort-SDR: u6EvWhXestwHCmkS6kfl4X84jAWg+y+XlDH+DMl0o5KBIV4w6KfA6cayyQsCOUUtS9BWi2xaBG
 2jsqKAPS45qiSo0InjSWHdGGVPgJtUv3qCVrtur1hPBe3IDu8LVOqeilRg5DblLlXI5VQ1sJ1y
 2KDkYZ8Q+B15tQjmiU1p2OO/2c7voV6x7vmrZzIv/sATvgcsKMmrALWaajjy6BJRkgVcuq9zK1
 jwkZEmEV0XWo1XP9PF+4s6jbfN4o+HgJ2LotADqA/2qWdMO5dQbI41xad8LIQlU1yjg51vuaID
 VZ4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Apr 2022 01:02:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfY70Kbfz1SVp7
 for <linux-nvme@lists.infradead.org>; Mon, 18 Apr 2022 01:02:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1650268937; x=1652860938; bh=OmPuKz2YWA8zfnI8UisdXu/UB5gIbMI/eeJ
 tu4mrOgE=; b=iq/DZtxIsH78J5+wxR20C/juR8srBcWxSV3ywtDv3tYOwTkL3uf
 A4HxBcRKotnvWTD1KOdCakjP9CBAMXOHFJQO+gW4W6NrXUdaQZyeATpC3vgDmC2/
 b6aR8MWIxQbBtWd1k4bmN29Kj9j2x8zQll9Nsvat1LryPuatUaKeqt6IZHWw7oia
 bqBLagLvqtOUd2viud2b+TaA8azo8Z+FIKRDbpTaA5wl7IVqak3jDSz781qRatoX
 CTPLw/8uTXPPOE41sDbbehCUr8tIW9Z/uhgJpZu1tDB8tDKbjkbWp6PdcoxYla18
 GMXcdKSGpAk9WAmZJwmUHgxuVE+HqnZ5TbA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id BQZoLE_SL7oq for <linux-nvme@lists.infradead.org>;
 Mon, 18 Apr 2022 01:02:17 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhfY24GYPz1Rvlx;
 Mon, 18 Apr 2022 01:02:14 -0700 (PDT)
Message-ID: <cd77bfd9-e133-1929-2d61-73822ad95366@opensource.wdc.com>
Date: Mon, 18 Apr 2022 17:02:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH 09/11] nvme: remove a spurious clear of
 discard_alignment
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 Song Liu <song@kernel.org>, dm-devel@redhat.com,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 linux-s390@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 xen-devel@lists.xenproject.org, linux-um@lists.infradead.org,
 Mike Snitzer <snitzer@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 nbd@other.debian.org, linux-block@vger.kernel.org,
 Stefan Haberland <sth@linux.ibm.com>, linux-raid@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-10-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220418045314.360785-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_010227_832572_A7BE0CF0 
X-CRM114-Status: GOOD (  20.31  )
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

On 4/18/22 13:53, Christoph Hellwig wrote:
> The nvme driver never sets a discard_alignment, so it also doens't need
> to clear it to zero.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b9b0fbde97c80..76a9ccd5d064a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1628,7 +1628,6 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>  	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
>  			NVME_DSM_MAX_RANGES);
>  
> -	queue->limits.discard_alignment = 0;
>  	queue->limits.discard_granularity = size;
>  
>  	/* If discard is already enabled, don't reset queue limits */

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

