Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F14AC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 15:46:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E7D60FF2
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 15:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B3E7D60FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxera.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CVH9cSWFGTY9eNZm3f5hs83Fbk5f+pR7kVpDTI7VzyQ=; b=qnGOJzZSXoOM9Su7N0xzXzYAi9
	ke07r0sLGuuc4pAqmODkqsJw0Cy0m+qggXeFLQOl1Zk9bg5io5WwRqFqiY0WzsYouoe/wYJ0eKxMg
	xmzC5m/R20Xfbpbkj/dAL98QhR+UizD+Sm8YdQNsT13TieYtTkJ/AM8WagI05ROQ3Z1kKNA2dsm2l
	fDFnY/l2it3fYgoCEL2eiKF0IWG3/CDiVYJNJ4q250R2oYzgExq0hekaazeLvsi1jNo3L5S+arUTc
	eX2HVb6D47+Fui9exh7Q4BBNW6yL0uP/Z5Q+Vshs0l3xqE16bUSF6mgpeuLpx2lX795vWaytr1Dw7
	5ivpI9xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbPPp-007wsf-Jg; Fri, 15 Oct 2021 15:46:37 +0000
Received: from mgw-01.mpynet.fi ([82.197.21.90])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbOJQ-007e33-Dy
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 14:35:59 +0000
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
 by mgw-01.mpynet.fi (8.16.0.43/8.16.0.43) with SMTP id 19FEWINE065735;
 Fri, 15 Oct 2021 17:35:41 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
 by mgw-01.mpynet.fi with ESMTP id 3bqa6fr1mk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Fri, 15 Oct 2021 17:35:41 +0300
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 15 Oct 2021 17:35:40 +0300
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.023; Fri, 15 Oct 2021 17:35:40 +0300
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
Subject: Re: [PATCH 28/30] ntfs: use sb_bdev_nr_blocks
Thread-Topic: [PATCH 28/30] ntfs: use sb_bdev_nr_blocks
Thread-Index: AQHXwch+sOYTA5n1EU2k5d07nGAE/6vT7f2A
Date: Fri, 15 Oct 2021 14:35:40 +0000
Message-ID: <7644804B-2081-4A1E-A40D-9A5C7BF72E2E@tuxera.com>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-29-hch@lst.de>
In-Reply-To: <20211015132643.1621913-29-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [109.154.241.177]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3668CC17B52D274985AE4DAF6C11620E@ex13.tuxera.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: 4ZKrI-UQqOuYdNTfa7YqNKQX-GuzVYXg
X-Proofpoint-GUID: 4ZKrI-UQqOuYdNTfa7YqNKQX-GuzVYXg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.790
 definitions=2021-10-15_04:2021-10-14,
 2021-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 phishscore=0
 mlxlogscore=999
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110150089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_073556_841151_F221AC08 
X-CRM114-Status: GOOD (  22.12  )
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

Looks good, thank you.

Best regards,

	Anton

> On 15 Oct 2021, at 14:26, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Use the sb_bdev_nr_blocks helper instead of open coding it and clean up
> ntfs_fill_super a bit by moving an assignment a little earlier that has
> no negative side effects.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Acked-by: Anton Altaparmakov <anton@tuxera.com>

> ---
> fs/ntfs/super.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 0d7e948cb29c9..5ae8de09b271b 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -2772,13 +2772,12 @@ static int ntfs_fill_super(struct super_block *sb=
, void *opt, const int silent)
> 	ntfs_debug("Set device block size to %i bytes (block size bits %i).",
> 			blocksize, sb->s_blocksize_bits);
> 	/* Determine the size of the device in units of block_size bytes. */
> -	if (!i_size_read(sb->s_bdev->bd_inode)) {
> +	vol->nr_blocks =3D sb_bdev_nr_blocks(sb);
> +	if (!vol->nr_blocks) {
> 		if (!silent)
> 			ntfs_error(sb, "Unable to determine device size.");
> 		goto err_out_now;
> 	}
> -	vol->nr_blocks =3D i_size_read(sb->s_bdev->bd_inode) >>
> -			sb->s_blocksize_bits;
> 	/* Read the boot sector and return unlocked buffer head to it. */
> 	if (!(bh =3D read_ntfs_boot_sector(sb, silent))) {
> 		if (!silent)
> @@ -2816,8 +2815,7 @@ static int ntfs_fill_super(struct super_block *sb, =
void *opt, const int silent)
> 			goto err_out_now;
> 		}
> 		BUG_ON(blocksize !=3D sb->s_blocksize);
> -		vol->nr_blocks =3D i_size_read(sb->s_bdev->bd_inode) >>
> -				sb->s_blocksize_bits;
> +		vol->nr_blocks =3D sb_bdev_nr_blocks(sb);
> 		ntfs_debug("Changed device block size to %i bytes (block size "
> 				"bits %i) to match volume sector size.",
> 				blocksize, sb->s_blocksize_bits);
> --=20
> 2.30.2
>=20



--=20
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer


