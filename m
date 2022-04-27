Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C134C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 12:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AhiokkY/aBDCWH/aAgbLXIk5ld/rkPAbjyQZqgE7uTw=; b=0UcxURHvzpsSIqpGpLKTOQ6qVs
	47rBmEpPRNj9eygaEKU8h9RDmUqJA52iy5CwkJnSNjJj3/i/0ZS4yz7KsUfZsdvm21QACVcM3bz80
	JNG7ABI3K8QZvqxzeT3nPt4+7FWvTyrJC3ZwgEQreI4BhpMsodyS7eGCrReD5Im3FN8QB1xrTvvIy
	Q/DoPNHAimXsgCnueFuoIgGnxVI5xG/NwNzdK1rT6Zr4yIGZCN+Q3ZMAaAEaOfWbOepS0RaRgvv+J
	CbxRDcNfvW6AsAHPKCScx6uMZ23oiOBi6CmW7sLMkmeeuVizUv+uwf2zpCE+4wV96Mw5bFlR2hpyU
	3Dqw3jCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njh7Q-001NUk-Dq; Wed, 27 Apr 2022 12:50:08 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njXjo-00H5QM-DR
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 02:49:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651027748; x=1682563748;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=iWpU0HwIqdFrg2zx3TJihfa/upjaFNfHL6fd3w+flV4=;
 b=Ux/W3TlTkiagYd/6vb/jiVYXnsSRDsoh1aRzciyY4EDX+sQLNKZCZ4lo
 djJHQdfKZP2pnT18MjvUwiuMT1QN1TRV+LBL4jNFUWEg+OTpYiLIpKg7S
 iXrjMzYdyBED2r20YUiZn9RoEkjHh3C0mYKRlcZ/a6D/OPeeBuE7vYd4+
 eWapqx48bYiVfSKPGEduwIm/t0rsJ45wL4MUIIVzU0tdOpmbRGPYaJJMr
 BDEz/JRqPzef3qy9MqB8VeyuHKZyyWNNPVQ3/7rNP2OYvbqbsAuN5ppcg
 e2ssyXVfJSz6Ch5XEHZJEu9NwQHLrUaAkJYYjfSQje2wJSfK3NEDQ2sPX w==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643644800"; d="scan'208";a="197756986"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 10:49:07 +0800
IronPort-SDR: oWzCEyZEhkkxYHz0RF7K4++I98TaRHfTHcJH9YRPIBUOl1dCUc+rcX2Nv+ZFmxFvOgvH0uyHxk
 lxn0DE2OQTBEzjSGxL5kZoPIfiAq5+H7RwNBO0GZg0v6CjOhzG8lZHOvKPwMDBLtMoGVJ4dWuk
 9xXqjaooARJR1zqzAzUXiJ5dr+EYfedTRMYH6og6ltb4NY3YmFmt4LHIMagwYP2Jb90hhAXTOR
 qKyPRwDPYn1tZc4FuitkcJL937FYRmr2Z+eUj022kWoUJgXlApSwlS39dhIizEFNcIou2KNyV1
 S5U/LODwGAWY5Ioi49v3/bg9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Apr 2022 19:19:18 -0700
IronPort-SDR: t2NlJOHYD/5I7gPRtHc091IOIoTfG3zo/K9UgrLAZV2Vx7fvppWLoXDkzvSJ+fMjdykrJqqq4f
 hwTWe16v0v3I2a6xSrqKUwZfYBHI9HNWsSilMUnOFmfP/isDjKurMGlg5ktk92bYfwyoUH0wnH
 0Cpp0/nAR+LSY4QcWB5LU8Cdu1LuZHhtDAJpjF2YI7K3MTriH6aejy36T1RPGHTNNMqos6FBHn
 Qo4rcMC4+Zq9il1NQmZ9U7h1EW7hhOt2jH38T6wXbWfQVP3AoaUqS8NOZ5hWlJ2v+pdDL8He5a
 GhY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Apr 2022 19:49:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kp39Z5skYz1Rvlx
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 19:49:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651027745; x=1653619746; bh=iWpU0HwIqdFrg2zx3TJihfa/upjaFNfHL6f
 d3w+flV4=; b=hikYTurwappRrrZasDTrqUqmKOTuKu4rZvUNZjPAd1cl9dkwlq/
 m2Sa9DPyXNi3xu6jhSuIOCnmz1HjekfSujLBC8Vzwj+VpHXxKwTa0kHl3cC6q4I/
 vnebs5mXEBMfWil0VWD7Aliqzov5gJfUIOuG8BMSxpnxmXzqLSESCpAsTlPy26QP
 XVwKEGJVnLpYvh1n7JAKbFMbo2+O962s9G7/+vWFGFYAQfeC+S5aTobuLNYzvtsm
 0hjcJOJFy01d0didhwDTvIOJY4NO8/OUayXwuqJfYagWh55n9Tco6gfvUlI1N9d4
 i1TD2XJ7QSFZG2GpfC0R35CGnj2voYJyncg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id yBVNfK4mWFue for <linux-nvme@lists.infradead.org>;
 Tue, 26 Apr 2022 19:49:05 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kp39Q3MMrz1Rvlc;
 Tue, 26 Apr 2022 19:48:58 -0700 (PDT)
Message-ID: <513edc25-1c73-6c85-9a50-0e267a106ec0@opensource.wdc.com>
Date: Wed, 27 Apr 2022 11:48:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 03/10] block: Introduce a new ioctl for copy
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: chaitanyak@nvidia.com, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
 martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org, hch@lst.de,
 Frederick.Knight@netapp.com, osandov@fb.com,
 lsf-pc@lists.linux-foundation.org, djwong@kernel.org, josef@toxicpanda.com,
 clm@fb.com, dsterba@suse.com, tytso@mit.edu, jack@suse.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 Arnav Dawn <arnav.dawn@samsung.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101938epcas5p291690dd1f0e931cd9f8139daaf3f9296@epcas5p2.samsung.com>
 <20220426101241.30100-4-nj.shetty@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220426101241.30100-4-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_194908_557596_667DE78D 
X-CRM114-Status: GOOD (  28.39  )
X-Mailman-Approved-At: Wed, 27 Apr 2022 05:48:55 -0700
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

On 4/26/22 19:12, Nitesh Shetty wrote:
> Add new BLKCOPY ioctl that offloads copying of one or more sources rang=
es
> to one or more destination in a device. COPY ioctl accepts a 'copy_rang=
e'
> structure that contains no of range, a reserved field , followed by an
> array of ranges. Each source range is represented by 'range_entry' that
> contains source start offset, destination start offset and length of
> source ranges (in bytes)
>=20
> MAX_COPY_NR_RANGE, limits the number of entries for the IOCTL and
> MAX_COPY_TOTAL_LENGTH limits the total copy length, IOCTL can handle.
>=20
> Example code, to issue BLKCOPY:
> /* Sample example to copy three entries with [dest,src,len],
> * [32768, 0, 4096] [36864, 4096, 4096] [40960,8192,4096] on same device=
 */
>=20
> int main(void)
> {
> 	int i, ret, fd;
> 	unsigned long src =3D 0, dst =3D 32768, len =3D 4096;
> 	struct copy_range *cr;
> 	cr =3D (struct copy_range *)malloc(sizeof(*cr)+
> 					(sizeof(struct range_entry)*3));
> 	cr->nr_range =3D 3;
> 	cr->reserved =3D 0;
> 	for (i =3D 0; i< cr->nr_range; i++, src +=3D len, dst +=3D len) {
> 		cr->range_list[i].dst =3D dst;
> 		cr->range_list[i].src =3D src;
> 		cr->range_list[i].len =3D len;
> 		cr->range_list[i].comp_len =3D 0;
> 	}
> 	fd =3D open("/dev/nvme0n1", O_RDWR);
> 	if (fd < 0) return 1;
> 	ret =3D ioctl(fd, BLKCOPY, cr);
> 	if (ret !=3D 0)
> 	       printf("copy failed, ret=3D %d\n", ret);
> 	for (i=3D0; i< cr->nr_range; i++)
> 		if (cr->range_list[i].len !=3D cr->range_list[i].comp_len)
> 			printf("Partial copy for entry %d: requested %llu, completed %llu\n"=
,
> 								i, cr->range_list[i].len,
> 								cr->range_list[i].comp_len);
> 	close(fd);
> 	free(cr);
> 	return ret;
> }

Nice to have a code example. But please format it correctly.

>=20
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Javier Gonz=C3=A1lez <javier.gonz@samsung.com>
> Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> ---
>  block/ioctl.c           | 32 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/fs.h |  9 +++++++++
>  2 files changed, 41 insertions(+)
>=20
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 46949f1b0dba..58d93c20ff30 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -120,6 +120,36 @@ static int blk_ioctl_discard(struct block_device *=
bdev, fmode_t mode,
>  	return err;
>  }
> =20
> +static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
> +		unsigned long arg)
> +{
> +	struct copy_range crange, *ranges =3D NULL;
> +	size_t payload_size =3D 0;
> +	int ret;
> +
> +	if (!(mode & FMODE_WRITE))
> +		return -EBADF;
> +
> +	if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
> +		return -EFAULT;
> +
> +	if (unlikely(!crange.nr_range || crange.reserved || crange.nr_range >=
=3D MAX_COPY_NR_RANGE))
> +		return -EINVAL;
> +
> +	payload_size =3D (crange.nr_range * sizeof(struct range_entry)) + siz=
eof(crange);
> +
> +	ranges =3D memdup_user((void __user *)arg, payload_size);
> +	if (IS_ERR(ranges))
> +		return PTR_ERR(ranges);
> +
> +	ret =3D blkdev_issue_copy(bdev, ranges->nr_range, ranges->range_list,=
 bdev, GFP_KERNEL);
> +	if (copy_to_user((void __user *)arg, ranges, payload_size))
> +		ret =3D -EFAULT;
> +
> +	kfree(ranges);
> +	return ret;
> +}
> +
>  static int blk_ioctl_secure_erase(struct block_device *bdev, fmode_t m=
ode,
>  		void __user *argp)
>  {
> @@ -481,6 +511,8 @@ static int blkdev_common_ioctl(struct block_device =
*bdev, fmode_t mode,
>  		return blk_ioctl_discard(bdev, mode, arg);
>  	case BLKSECDISCARD:
>  		return blk_ioctl_secure_erase(bdev, mode, argp);
> +	case BLKCOPY:
> +		return blk_ioctl_copy(bdev, mode, arg);
>  	case BLKZEROOUT:
>  		return blk_ioctl_zeroout(bdev, mode, arg);
>  	case BLKGETDISKSEQ:
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 822c28cebf3a..a3b13406ffb8 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -78,6 +78,14 @@ struct range_entry {
>  	__u64 comp_len;
>  };
> =20
> +struct copy_range {
> +	__u64 nr_range;
> +	__u64 reserved;
> +
> +	/* Range_list always must be at the end */
> +	struct range_entry range_list[];
> +};
> +
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl defin=
itions */
>  #define FILE_DEDUPE_RANGE_SAME		0
>  #define FILE_DEDUPE_RANGE_DIFFERS	1
> @@ -199,6 +207,7 @@ struct fsxattr {
>  #define BLKROTATIONAL _IO(0x12,126)
>  #define BLKZEROOUT _IO(0x12,127)
>  #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
> +#define BLKCOPY _IOWR(0x12, 129, struct copy_range)
>  /*
>   * A jump here: 130-136 are reserved for zoned block devices
>   * (see uapi/linux/blkzoned.h)


--=20
Damien Le Moal
Western Digital Research

