Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA777C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 15:46:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BAFE610E5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 15:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4BAFE610E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxera.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VvXlpb5CGB7unM79tnn2MeEFde+3sYstl/aq6e+qLDA=; b=w/6mP/a82Da05FS/2yFh342jIL
	shha4HZJhIjhQuI3lg5YV62CliFkjr3W9Z2BZ6Iws+uUbvd1d616fU6IGrxN/a8uJ6/556/jhewY8
	TH6dWce6dvoBZBdfhW1yeJTpEeb9sNvsYPoJE52ItTRxfnyXOayFyNO2sMuCKiKQdqfCHe5HH5h7b
	ep0fVfZQN0f/Plq+KLpvr5XcvuaeyunLpcYVRM/4o08Nuc0XaPIyj3G1DcI7wgi2wO2P2whdKwtIX
	UsbWhbIsEnErd0CkkBjD5AlUqiq834gpawSpVAeD6nTVlrGQUdGlCLk5RlFLpI911aNRBiOg6dNk/
	xAUVb6fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbPPz-007wtt-JI; Fri, 15 Oct 2021 15:46:47 +0000
Received: from mgw-01.mpynet.fi ([82.197.21.90])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbOLF-007egs-Hs
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 14:37:51 +0000
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
 by mgw-01.mpynet.fi (8.16.0.43/8.16.0.43) with SMTP id 19FEWINI065735;
 Fri, 15 Oct 2021 17:37:43 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
 by mgw-01.mpynet.fi with ESMTP id 3bqa6fr1nj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Fri, 15 Oct 2021 17:37:42 +0300
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 15 Oct 2021 17:37:42 +0300
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.023; Fri, 15 Oct 2021 17:37:42 +0300
From: Anton Altaparmakov <anton@tuxera.com>
To: Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>, Mike Snitzer
 <snitzer@redhat.com>, Song Liu <song@kernel.org>, David Sterba
 <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>, Theodore Ts'o
 <tytso@mit.edu>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, "Konstantin
 Komarov" <almaz.alexandrovich@paragon-software.com>, Kees Cook
 <keescook@chromium.org>,
 Phillip Lougher <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, "drbd-dev@lists.linbit.com"
 <drbd-dev@lists.linbit.com>, "linux-bcache@vger.kernel.org"
 <linux-bcache@vger.kernel.org>, "linux-raid@vger.kernel.org"
 <linux-raid@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "target-devel@vger.kernel.org"
 <target-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>, "linux-ext4@vger.kernel.org"
 <linux-ext4@vger.kernel.org>, "jfs-discussion@lists.sourceforge.net"
 <jfs-discussion@lists.sourceforge.net>, "linux-nfs@vger.kernel.org"
 <linux-nfs@vger.kernel.org>, "linux-nilfs@vger.kernel.org"
 <linux-nilfs@vger.kernel.org>, "linux-ntfs-dev@lists.sourceforge.net"
 <linux-ntfs-dev@lists.sourceforge.net>, "ntfs3@lists.linux.dev"
 <ntfs3@lists.linux.dev>, "reiserfs-devel@vger.kernel.org"
 <reiserfs-devel@vger.kernel.org>
Subject: Re: [PATCH 02/30] block: add a bdev_nr_bytes helper
Thread-Topic: [PATCH 02/30] block: add a bdev_nr_bytes helper
Thread-Index: AQHXwchZP9onky8YCUWD+iMtrLLvTavT7o+A
Date: Fri, 15 Oct 2021 14:37:41 +0000
Message-ID: <7C4AC4BD-B62D-41B3-AAF7-46125D1A1146@tuxera.com>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-3-hch@lst.de>
In-Reply-To: <20211015132643.1621913-3-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [109.154.241.177]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA141EBD26CA2142955225C1A7459553@ex13.tuxera.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: H-3YelUF38QeF4AeejuL002U0EzCkK0i
X-Proofpoint-GUID: H-3YelUF38QeF4AeejuL002U0EzCkK0i
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.790
 definitions=2021-10-15_04:2021-10-14,
 2021-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 phishscore=0
 mlxlogscore=984
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110150089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_073749_961252_9C7DE485 
X-CRM114-Status: GOOD (  20.80  )
X-Mailman-Approved-At: Fri, 15 Oct 2021 08:46:36 -0700
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

Hi Christoph,

> On 15 Oct 2021, at 14:26, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Add a helpe to query the size of a block device in bytes.  This
> will be used to remove open coded access to ->bd_inode.

Matthew already pointed out the return type for bdev_nr_bytes() but also yo=
ur commit message has a typo: "Add a helpe" -> "Add a helper".

Best regards,

	Anton

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> include/linux/genhd.h | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 082a3e5fd8fa1..f67db3c5a04b3 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -235,9 +235,14 @@ static inline sector_t get_start_sect(struct block_d=
evice *bdev)
> 	return bdev->bd_start_sect;
> }
>=20
> +static inline sector_t bdev_nr_bytes(struct block_device *bdev)
> +{
> +	return i_size_read(bdev->bd_inode);
> +}
> +
> static inline sector_t bdev_nr_sectors(struct block_device *bdev)
> {
> -	return i_size_read(bdev->bd_inode) >> 9;
> +	return bdev_nr_bytes(bdev) >> SECTOR_SHIFT;
> }
>=20
> static inline sector_t get_capacity(struct gendisk *disk)
> --=20
> 2.30.2
>=20


