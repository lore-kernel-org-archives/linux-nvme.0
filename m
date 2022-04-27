Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0B1C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 12:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uBiHXbB2vbuCi8zkqrP/WxP0n00qmXlNJm4scsV0P9c=; b=DRTDpX92xBIvEyoE6j4sTiWN3p
	e9CxXWOXFnXMvii+wYaYX5utGc8uoEur7oAQxUL5FFBzmtm0BBVKP1RwrGQb0RWsDAmbTN+c0w/y5
	BF0LKHjbUrQ73XyeNXaEbt+AF6t0zqcj+LMw+HDdOkR1es9k9t43Z1kKD7Deb7t3mjrJQC6WBZ77V
	3xeaoa0zP8Z1G/uh1/H8fiEjGMC/R3beXMagf+H0zAF4DmwDfwBLJ5ljfhq8lURBjESUQPOd/aiA2
	gl7YOTJzQ3gqPLBqFrN9zEc65ezKUBwyItcXsjbKRB/X7HT2vmjMtFO7JT4AeXeUM+PZoBhSTrjwn
	tnbnVVIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njh6x-001NDI-2w; Wed, 27 Apr 2022 12:49:39 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njWzK-00H0cX-K5
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 02:01:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651024866; x=1682560866;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=aVEYVQf35+Uh7XzM6a1kJevWBsv5Uf3EWaUSl6Zi8N0=;
 b=A+yHnmRvrnJH0i/BGBq/JigLSIBTIMtmxq7muN8ic+U+vQln7Suq1ip3
 Fh6x+dfcjtEm99VabViuXNFz4Zxmj8AaokZc9yUZS91pvBZRcc2QWVtDA
 wgdmwxeWJq76Be1om3VUSjFXj4IGttH0z6F1mCQ1ZdKL/XNMomI9XmgYq
 3VgHgnv16OX9OzORvyDGOQ9bD3rtPnwdbyxvGMWWJ8cpP3tIBWk7p8//2
 gN7Axs3UAawqOjfHZsu5K/rifavIu05rGRaptcOg8CKBIhVVnYFAxx3QK
 5Eec/X9k8zbtZe8xQFD5t9/ylTwagUD14nCxt0pPrmrAm5SKsxvw32Cgv A==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643644800"; d="scan'208";a="310879865"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 10:01:06 +0800
IronPort-SDR: 46sRBj40CrvZMnvYTYNXa4s0x7OTFdFysCGX2w3wSf4fHWTe9Po5nXd6Z/RQ0DINH54DSKulv/
 /EoNmlekPHX+nVX37S8kdP71i2tXkF7vVMt11KjPIMo0amTUl9u3s/cNnThTVzFdb9LY5cZdBQ
 Fnmwlq8eJ35mfEZW3ytyEacG8MmBbly3oTcp+K23dUQ6o5Mr2GHjFZYNugmmFG9u40WUT48hw9
 NMrJ6O0xYHjvbOAp6tvCAhp9xZ+CZ4z6OXVc72a1RSSo/b/2ID9YYmBgBMoD4rHBXthD0B7hyj
 ecgmmH8YUWGvkt/PoyrS3cTx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Apr 2022 18:31:16 -0700
IronPort-SDR: 1WVZqZMoy+smA4Dm5a52ZtoXPBdSq0F0pcX7PnLojaMZQpld3M3IUey1xjadamoi7r3vmFoAGJ
 swpO6q0rWQkYJ6pQnx3g3DCoHvEgDQmJifFwLoWEjSB4zI+LyFCDAtYVPl//bGHrwQhB1awoQw
 Smb9tMfENRH5YpILteT9FcPbC86T5HMH0ELS/Mu2bj1pwFfBuCfCj1F84OyXVw6O/f7Hxxa3O1
 SsI/Geum2OvFc2vxn+qGNrKasFdtOei9USPHXYvcdpcW2s2r+2ZMCBi1+wU686Tt46wm2KETsd
 bGk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Apr 2022 19:01:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kp2695b2Qz1SVp0
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 19:01:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651024863; x=1653616864; bh=aVEYVQf35+Uh7XzM6a1kJevWBsv5Uf3EWaU
 Sl6Zi8N0=; b=KfX3t52RHjy82z2TJzUhoVlJ0/BxFzUJLFKPzHSozkhHJJmCA2P
 nweuPL+ydqBMCKQEK2VHh35Y/SPhWrUHSvx9x7hn0VwCddnnjN9XqHGV8T+TR+RY
 aKeV2RSsxx1DxTEJxJeTvRr3oFCucN5CLVD2xVdrUgsoJTLNmlkJJNPBnjOu8xh1
 ChIzLsgudSmkQoeSFyEiaMjAm71wKa4uYjsEYZ0pKmTZDDD6frJfWMF7mEmwuXgW
 0X4RpDdKxB4i1yrkm5y0mIWo8WBIMJsp0WeTsmtrh2XcJOR7GVoyk1lQPHQ1IXqb
 kKDvjaQQ+59quwxyWYKAYS90TOq0fi3lUyw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id bXYIFa0JhGLE for <linux-nvme@lists.infradead.org>;
 Tue, 26 Apr 2022 19:01:03 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kp25z67Pcz1Rvlc;
 Tue, 26 Apr 2022 19:00:55 -0700 (PDT)
Message-ID: <76a89205-f4f1-1e51-aa23-c8082bfefd3c@opensource.wdc.com>
Date: Wed, 27 Apr 2022 11:00:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 00/10] Add Copy offload support
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
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220426101241.30100-1-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_190106_716240_1B3A9BB1 
X-CRM114-Status: GOOD (  25.44  )
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
> The patch series covers the points discussed in November 2021 virtual c=
all
> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
> We have covered the Initial agreed requirements in this patchset.
> Patchset borrows Mikulas's token based approach for 2 bdev
> implementation.

Please reduce the distribution list. List servers (and email clients) are
complaining about it being too large.

>=20
> Overall series supports =E2=80=93
>=20
> 1. Driver
> - NVMe Copy command (single NS), including support in nvme-target (for
>     block and file backend)
>=20
> 2. Block layer
> - Block-generic copy (REQ_COPY flag), with interface accommodating
>     two block-devs, and multi-source/destination interface
> - Emulation, when offload is natively absent
> - dm-linear support (for cases not requiring split)
>=20
> 3. User-interface
> - new ioctl
> - copy_file_range for zonefs
>=20
> 4. In-kernel user
> - dm-kcopyd
> - copy_file_range in zonefs
>=20
> For zonefs copy_file_range - Seems we cannot levearge fstest here. Limi=
ted
> testing is done at this point using a custom application for unit testi=
ng.
>=20
> Appreciate the inputs on plumbing and how to test this further?
> Perhaps some of it can be discussed during LSF/MM too.
>=20
> [0] https://lore.kernel.org/linux-nvme/CA+1E3rJ7BZ7LjQXXTdX+-0Edz=3DzT1=
4mmPGMiVCzUgB33C60tbQ@mail.gmail.com/
>=20
> Changes in v4:
> - added copy_file_range support for zonefs
> - added documentaion about new sysfs entries
> - incorporated review comments on v3
> - minor fixes
>=20
>=20
> Arnav Dawn (2):
>   nvmet: add copy command support for bdev and file ns
>   fs: add support for copy file range in zonefs
>=20
> Nitesh Shetty (7):
>   block: Introduce queue limits for copy-offload support
>   block: Add copy offload support infrastructure
>   block: Introduce a new ioctl for copy
>   block: add emulation for copy
>   nvme: add copy offload support
>   dm: Add support for copy offload.
>   dm: Enable copy offload for dm-linear target
>=20
> SelvaKumar S (1):
>   dm kcopyd: use copy offload support
>=20
>  Documentation/ABI/stable/sysfs-block |  83 +++++++
>  block/blk-lib.c                      | 358 +++++++++++++++++++++++++++
>  block/blk-map.c                      |   2 +-
>  block/blk-settings.c                 |  59 +++++
>  block/blk-sysfs.c                    | 138 +++++++++++
>  block/blk.h                          |   2 +
>  block/ioctl.c                        |  32 +++
>  drivers/md/dm-kcopyd.c               |  55 +++-
>  drivers/md/dm-linear.c               |   1 +
>  drivers/md/dm-table.c                |  45 ++++
>  drivers/md/dm.c                      |   6 +
>  drivers/nvme/host/core.c             | 116 ++++++++-
>  drivers/nvme/host/fc.c               |   4 +
>  drivers/nvme/host/nvme.h             |   7 +
>  drivers/nvme/host/pci.c              |  25 ++
>  drivers/nvme/host/rdma.c             |   6 +
>  drivers/nvme/host/tcp.c              |  14 ++
>  drivers/nvme/host/trace.c            |  19 ++
>  drivers/nvme/target/admin-cmd.c      |   8 +-
>  drivers/nvme/target/io-cmd-bdev.c    |  65 +++++
>  drivers/nvme/target/io-cmd-file.c    |  49 ++++
>  fs/zonefs/super.c                    | 178 ++++++++++++-
>  fs/zonefs/zonefs.h                   |   1 +
>  include/linux/blk_types.h            |  21 ++
>  include/linux/blkdev.h               |  17 ++
>  include/linux/device-mapper.h        |   5 +
>  include/linux/nvme.h                 |  43 +++-
>  include/uapi/linux/fs.h              |  23 ++
>  28 files changed, 1367 insertions(+), 15 deletions(-)
>=20
>=20
> base-commit: e7d6987e09a328d4a949701db40ef63fbb970670


--=20
Damien Le Moal
Western Digital Research

