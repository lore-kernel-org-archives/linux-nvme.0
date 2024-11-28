Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FF5D69105
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2024 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=EsE2p5Lsn6DiSRw9jPl2JTjQ+1coWvYvPIlllSo4/K8=; b=MdP/zL6iXntXPPLds/qkBIR9aZ
	04YXto0bELiWQL7ELTcNN4GAxyWXoJqhACUqU06wlumqXjWIVHfBj826sMmHBRBeFDTvdZkQENKuO
	BAflXoKJEJW4LKyfyYZAsJWqRb1x3iV4qRdUXVuhbCpl2OmHfx8Ocvf+lr79GSxiv8v3Xm1xBY+UM
	lc/49fEQlLWP1dL2HzGefKG407vshF1ogq/4cPYoJUhw9QK+MksxisjM19KWqF/w9GuBPBeNTPff2
	5lh0cxGQS/KIJUSOjvU4SabruOiXSFl4RMOkFpBo6zwilDw4viLRi0vP7eyF8Ugqi3/ecYzXtOHWo
	2Fut6x2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGe01-0000000FXz5-49Cc;
	Thu, 28 Nov 2024 12:52:01 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGcxt-0000000FNpf-18cz
	for linux-nvme@lists.infradead.org;
	Thu, 28 Nov 2024 11:45:47 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241128114538epoutp021b39ac5ab8767ec65b445af50310ef4c~MH0Ur-w9N0947009470epoutp02c
	for <linux-nvme@lists.infradead.org>; Thu, 28 Nov 2024 11:45:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241128114538epoutp021b39ac5ab8767ec65b445af50310ef4c~MH0Ur-w9N0947009470epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1732794338;
	bh=EsE2p5Lsn6DiSRw9jPl2JTjQ+1coWvYvPIlllSo4/K8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=TeGzOyjISaOeeiR6yAw4+Fq4ELpV+XodZDWczACDhuo7Idy7bUNrr9wd9iRKRHxXe
	 VDQbLhnplmjzMo12rAiBNFoFb1t8nOJCMy2sFjC6qNYMbSpHqnx289+m1ioVLZpNrg
	 5wg4XOjgVYHbdp9beDQCH8kqKwgv9wlI9HJYX/dc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241128114537epcas5p188e84a48cd96295a4b55228e4b96887b~MH0UIn7GO2942729427epcas5p1A;
	Thu, 28 Nov 2024 11:45:37 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XzZJ05xJTz4x9Pw; Thu, 28 Nov
	2024 11:45:36 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C8.1D.19933.0E758476; Thu, 28 Nov 2024 20:45:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241128113036epcas5p397ba228852b72fff671fe695c322a3ef~MHnMdoWIC2988929889epcas5p3i;
	Thu, 28 Nov 2024 11:30:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241128113036epsmtrp18df4dbdfcf4717d428847f74bff26bf6~MHnMcKeFP0051900519epsmtrp1J;
	Thu, 28 Nov 2024 11:30:36 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-5c-674857e0882e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.FC.18729.C5458476; Thu, 28 Nov 2024 20:30:36 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241128113033epsmtip2d90264e910af5b602410e3f5ec4fc633~MHnKBDbax2429524295epsmtip2T;
	Thu, 28 Nov 2024 11:30:33 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v11 00/10] Read/Write with meta/integrity
Date: Thu, 28 Nov 2024 16:52:30 +0530
Message-Id: <20241128112240.8867-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmpu6DcI90g+UXtCw+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBaTDl1jtNh7S9tiz96TLBbz
	lz1lt+i+voPNYvnxf0wW5/8eZ7U4P2sOu4Ogx85Zd9k9Lp8t9di0qpPNY/OSeo/dNxvYPD4+
	vcXi0bdlFaPHmQVH2D0+b5Lz2PTkLVMAV1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGh
	rqGlhbmSQl5ibqqtkotPgK5bZg7QO0oKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpSc
	ApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IynXw4zFdyJqZjY187UwPjQuYuRk0NCwESi/94q
	ti5GLg4hgd2MElPv3WOEcD4xSjyb8poJwvnGKNF/5hsjTMvHRfuhqvYySjyZuIoZwvnMKDH7
	wSdmkCo2AXWJI89bwapEBPYwSvQuPM0C4jALvGSUWLpqEQtIlbCApUT32U1MIDaLgKrE1E0/
	gE7h4OAVsJA4vzMPYp28xMxL39lBbF4BQYmTM5+AtTIDxZu3zgbbLCGwh0Pix7XZUPe5SKy+
	dJIJwhaWeHV8CzuELSXxsr8Nyk6X+HH5KVRNgUTzsX1QvfYSraf6mUFuYBbQlFi/Sx8iLCsx
	9dQ6Joi9fBK9v59AtfJK7JgHYytJtK+cA2VLSOw91wBle0gsPb2IEWSkkECsxNYO0QmM8rOQ
	fDMLyTezEBYvYGRexSiZWlCcm55abFpglJdaDo/Z5PzcTYzgZK3ltYPx4YMPeocYmTgYDzFK
	cDArifAWcLunC/GmJFZWpRblxxeV5qQWH2I0BYbwRGYp0eR8YL7IK4k3NLE0MDEzMzOxNDYz
	VBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qByU/uke7hRQfVF4t8uH54fhK/dqbs6kSDjxcl
	qopfyltdjj8y2Z0l6fuigpbudyd+tW27cE91//yCF4If2krfdCh0XJZZv+URh3J95kXtJdud
	me9rpwcz+0jrn05/z8L+udNnqvmXl/x/r+clM0aoPGL6JFMTeVVoesH6oDVeL64+rJVpba4r
	nrk7deJNo6WvgniffHtwx1JUTy3YKO3h8qS3Jyu2dz2Icqg7b8kvXh+dGBwUzM/20SGqcr5R
	MsM2Zc8jFbd47hgfrNjrfnZ56lrWFfbOASfmPhBj9Gu8otbOwBZwQ4nJ04PnSnbw5/Ur7Nsm
	eZ1XFy+f9neGzqmIWQzLVKxY+uVe/EqNPRqtxFKckWioxVxUnAgAxi3pCl8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSvG5MiEe6Qc9vAYuPX3+zWDRN+Mts
	MWfVNkaL1Xf72SxeH/7EaHHzwE4mi5WrjzJZvGs9x2Ixe3ozk8WkQ9cYLfbe0rbYs/cki8X8
	ZU/ZLbqv72CzWH78H5PF+b/HWS3Oz5rD7iDosXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j49P
	b7F49G1ZxehxZsERdo/Pm+Q8Nj15yxTAFcVlk5Kak1mWWqRvl8CV8fTLYaaCOzEVE/vamRoY
	Hzp3MXJySAiYSHxctJ+xi5GLQ0hgN6PErb+nmCESEhKnXi5jhLCFJVb+e84OUfSRUaJ9+2Sw
	IjYBdYkjz1vBikQETjBKzJ/oBlLEDFI04ctsFpCEsIClRPfZTUwgNouAqsTUTT/Yuhg5OHgF
	LCTO78yDWCAvMfPSd3YQm1dAUOLkzCdgrcxA8eats5knMPLNQpKahSS1gJFpFaNkakFxbnpu
	sWGBYV5quV5xYm5xaV66XnJ+7iZGcNxoae5g3L7qg94hRiYOxkOMEhzMSiK8Bdzu6UK8KYmV
	ValF+fFFpTmpxYcYpTlYlMR5xV/0pggJpCeWpGanphakFsFkmTg4pRqYuvyyPizu/LM56rWx
	qyXr0T3R4oXbOd94lxQvWthbxnfq09H5tgmHKlMEpsYxtplEqlxRvR+rHtHhnxWx6fm9hpe5
	ReUnvnO86vH58VTXJPXvQj226d2OXl4VLGsyFs5psZ95q833bdVaGxmDk7pb/jnfMfDo836e
	z/Hm5feDqy1a/k9N3n7H7nbeioZlHzf9sN3M9fikxpvDT7YkuAp4+2xO23O3xqey6E0I+44z
	7q82q+zQWxj5tjTk2+VzwnFVB9wcNd2Egn+H3gq4zVrxZOECH50Ihd+PJK5rcNbk8/se3asa
	212esyxp77r8Qw3/KxzZsv/tWPl8pZ/Ym1j1xR93fubV3Ni73Yxl4UlRJZbijERDLeai4kQA
	0dqWKQoDAAA=
X-CMS-MailID: 20241128113036epcas5p397ba228852b72fff671fe695c322a3ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241128113036epcas5p397ba228852b72fff671fe695c322a3ef
References: <CGME20241128113036epcas5p397ba228852b72fff671fe695c322a3ef@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_034545_782297_23C6AB19 
X-CRM114-Status: GOOD (  26.11  )
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

This adds a new io_uring interface to exchange additional integrity/pi
metadata with read/write.

Example program for using the interface is appended below [1].

The patchset is on top of block/for-next.

Testing has been done by modifying fio:
https://github.com/SamsungDS/fio/tree/priv/feat/pi-test-v11

Kernel tree:
https://github.com/SamsungDS/linux/tree/feat/pi_us_v11

Block path (direct IO) , NVMe and SCSI driver are modified to support
this.

Patch 1 is an enhancement patch.
Patch 2 is required to make the bounce buffer copy back work correctly.
Patch 3 to 5 are prep patches.
Patch 6 adds the io_uring support.
Patch 7 gives us unified interface for user and kernel generated
integrity.
Patch 8 adds support in SCSI and patch 9 in NVMe.
Patch 10 adds the support for block direct IO.

Changes since v10:
https://lore.kernel.org/io-uring/20241125070633.8042-1-anuj20.g@samsung.com/

- keep only attribute_mask and get rid of type (Pavel)
- io_uring code cleanups (Pavel)

Changes since v9:
https://lore.kernel.org/linux-block/20241114104517.51726-1-anuj20.g@samsung.com/

- pass PI attribute information via pointer (Pavel)
- fix kernel bot warnings

Changes since v8:
https://lore.kernel.org/io-uring/20241106121842.5004-1-anuj20.g@samsung.com/

- add option of the pass the PI information from user space via a
  pointer (Pavel)

Changes since v7:
https://lore.kernel.org/io-uring/20241104140601.12239-1-anuj20.g@samsung.com/

- change the sign-off order (hch)
- add a check for doing metadata completion handling only for async-io
- change meta_type name to something more meaningful (hch, keith)
- add detail description in io-uring patch (hch)

Changes since v6:
https://lore.kernel.org/linux-block/20241030180112.4635-1-joshi.k@samsung.com/

- io_uring changes (bring back meta_type, move PI to the end of SQE128)
- Fix robot warnings

Changes since v5:
https://lore.kernel.org/linux-block/20241029162402.21400-1-anuj20.g@samsung.com/

- remove meta_type field from SQE (hch, keith)
- remove __bitwise annotation (hch)
- remove BIP_CTRL_NOCHECK from scsi (hch)

Changes since v4:
https://lore.kernel.org/linux-block/20241016112912.63542-1-anuj20.g@samsung.com/

- better variable names to describe bounce buffer copy back (hch)
- move defintion of flags in the same patch introducing uio_meta (hch)
- move uio_meta definition to include/linux/uio.h (hch)
- bump seed size in uio_meta to 8 bytes (martin)
- move flags definition to include/uapi/linux/fs.h (hch)
- s/meta/metadata in commit description of io-uring (hch)
- rearrange the meta fields in sqe for cleaner layout
- partial submission case is not applicable as, we are only plumbing for async case
- s/META_TYPE_INTEGRITY/META_TYPE_PI (hch, martin)
- remove unlikely branching (hch)
- Better formatting, misc cleanups, better commit descriptions, reordering commits(hch)

Changes since v3:
https://lore.kernel.org/linux-block/20240823103811.2421-1-anuj20.g@samsung.com/

- add reftag seed support (Martin)
- fix incorrect formatting in uio_meta (hch)
- s/IOCB_HAS_META/IOCB_HAS_METADATA (hch)
- move integrity check flags to block layer header (hch)
- add comments for BIP_CHECK_GUARD/REFTAG/APPTAG flags (hch)
- remove bio_integrity check during completion if IOCB_HAS_METADATA is set (hch)
- use goto label to get rid of duplicate error handling (hch)
- add warn_on if trying to do sync io with iocb_has_metadata flag (hch)
- remove check for disabling reftag remapping (hch)
- remove BIP_INTEGRITY_USER flag (hch)
- add comment for app_tag field introduced in bio_integrity_payload (hch)
- pass request to nvme_set_app_tag function (hch)
- right indentation at a place in scsi patch (hch)
- move IOCB_HAS_METADATA to a separate fs patch (hch)

Changes since v2:
https://lore.kernel.org/linux-block/20240626100700.3629-1-anuj20.g@samsung.com/
- io_uring error handling styling (Gabriel)
- add documented helper to get metadata bytes from data iter (hch)
- during clone specify "what flags to clone" rather than
"what not to clone" (hch)
- Move uio_meta defination to bio-integrity.h (hch)
- Rename apptag field to app_tag (hch)
- Change datatype of flags field in uio_meta to bitwise (hch)
- Don't introduce BIP_USER_CHK_FOO flags (hch, martin)
- Driver should rely on block layer flags instead of seeing if it is
user-passthrough (hch)
- update the scsi code for handling user-meta (hch, martin)

Changes since v1:
https://lore.kernel.org/linux-block/20240425183943.6319-1-joshi.k@samsung.com/
- Do not use new opcode for meta, and also add the provision to introduce new
meta types beyond integrity (Pavel)
- Stuff IOCB_HAS_META check in need_complete_io (Jens)
- Split meta handling in NVMe into a separate handler (Keith)
- Add meta handling for __blkdev_direct_IO too (Keith)
- Don't inherit BIP_COPY_USER flag for cloned bio's (Christoph)
- Better commit descriptions (Christoph)

Changes since RFC:
- modify io_uring plumbing based on recent async handling state changes
- fixes/enhancements to correctly handle the split for meta buffer
- add flags to specify guard/reftag/apptag checks
- add support to send apptag


[1]

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <linux/fs.h>
#include <linux/io_uring.h>
#include <linux/types.h>
#include "liburing.h"

/*
 * write data/meta. read both. compare. send apptag too.
 * prerequisite:
 * protected xfer: format namespace with 4KB + 8b, pi_type = 1
 * For testing reftag remapping on device-mapper, create a
 * device-mapper and run this program. Device mapper creation:
 * # echo 0 80 linear /dev/nvme0n1 0 > /tmp/table
 * # echo 80 160 linear /dev/nvme0n1 200 >> /tmp/table
 * # dmsetup create two /tmp/table
 * # ./a.out /dev/dm-0
 */

#define DATA_LEN 4096
#define META_LEN 8

struct t10_pi_tuple {
        __be16  guard;
        __be16  apptag;
        __be32  reftag;
};

int main(int argc, char *argv[])
{
         struct io_uring ring;
         struct io_uring_sqe *sqe = NULL;
         struct io_uring_cqe *cqe = NULL;
         void *wdb,*rdb;
         char wmb[META_LEN], rmb[META_LEN];
         char *data_str = "data buffer";
         int fd, ret, blksize;
         struct stat fstat;
         unsigned long long offset = DATA_LEN * 10;
         struct t10_pi_tuple *pi;
	 struct io_uring_attr_pi w_pi, r_pi;

         if (argc != 2) {
                 fprintf(stderr, "Usage: %s <block-device>", argv[0]);
                 return 1;
         };

         if (stat(argv[1], &fstat) == 0) {
                 blksize = (int)fstat.st_blksize;
         } else {
                 perror("stat");
                 return 1;
         }

         if (posix_memalign(&wdb, blksize, DATA_LEN)) {
                 perror("posix_memalign failed");
                 return 1;
         }
         if (posix_memalign(&rdb, blksize, DATA_LEN)) {
                 perror("posix_memalign failed");
                 return 1;
         }

         memset(wdb, 0, DATA_LEN);

         fd = open(argv[1], O_RDWR | O_DIRECT);
         if (fd < 0) {
                 printf("Error in opening device\n");
                 return 0;
         }

         ret = io_uring_queue_init(8, &ring, 0);
         if (ret) {
                 fprintf(stderr, "ring setup failed: %d\n", ret);
                 return 1;
         }

         /* write data + meta-buffer to device */
         sqe = io_uring_get_sqe(&ring);
         if (!sqe) {
                 fprintf(stderr, "get sqe failed\n");
                 return 1;
         }

         io_uring_prep_write(sqe, fd, wdb, DATA_LEN, offset);

	 sqe->attr_type_mask = IORING_RW_ATTR_FLAG_PI;
         w_pi.addr = (__u64)wmb;
         w_pi.len = META_LEN;
         /* flags to ask for guard/reftag/apptag*/
         w_pi.flags = IO_INTEGRITY_CHK_GUARD | IO_INTEGRITY_CHK_REFTAG | IO_INTEGRITY_CHK_APPTAG;
         w_pi.app_tag = 0x1234;
         w_pi.seed = 10;
	 w_pi.rsvd = 0;
	 sqe->attr_ptr = (__u64)&w_pi;

         pi = (struct t10_pi_tuple *)wmb;
         pi->guard = 0;
         pi->reftag = 0x0A000000;
         pi->apptag = 0x3412;

         ret = io_uring_submit(&ring);
         if (ret <= 0) {
                 fprintf(stderr, "sqe submit failed: %d\n", ret);
                 return 1;
         }

         ret = io_uring_wait_cqe(&ring, &cqe);
         if (!cqe) {
                 fprintf(stderr, "cqe is NULL :%d\n", ret);
                 return 1;
         }
         if (cqe->res < 0) {
                 fprintf(stderr, "write cqe failure: %d", cqe->res);
                 return 1;
         }

         io_uring_cqe_seen(&ring, cqe);

         /* read data + meta-buffer back from device */
         sqe = io_uring_get_sqe(&ring);
         if (!sqe) {
                 fprintf(stderr, "get sqe failed\n");
                 return 1;
         }

         io_uring_prep_read(sqe, fd, rdb, DATA_LEN, offset);

	 sqe->attr_type_mask = IORING_RW_ATTR_FLAG_PI;
         r_pi.addr = (__u64)rmb;
         r_pi.len = META_LEN;
         r_pi.flags = IO_INTEGRITY_CHK_GUARD | IO_INTEGRITY_CHK_REFTAG | IO_INTEGRITY_CHK_APPTAG;
         r_pi.app_tag = 0x1234;
         r_pi.seed = 10;
	 r_pi.rsvd = 0;
	 sqe->attr_ptr = (__u64)&r_pi;

         ret = io_uring_submit(&ring);
         if (ret <= 0) {
                 fprintf(stderr, "sqe submit failed: %d\n", ret);
                 return 1;
         }

         ret = io_uring_wait_cqe(&ring, &cqe);
         if (!cqe) {
                 fprintf(stderr, "cqe is NULL :%d\n", ret);
                 return 1;
         }

         if (cqe->res < 0) {
                 fprintf(stderr, "read cqe failure: %d", cqe->res);
                 return 1;
         }

	 pi = (struct t10_pi_tuple *)rmb;
	 if (pi->apptag != 0x3412)
		 printf("Failure: apptag mismatch!\n");
	 if (pi->reftag != 0x0A000000)
		 printf("Failure: reftag mismatch!\n");

         io_uring_cqe_seen(&ring, cqe);

         pi = (struct t10_pi_tuple *)rmb;

         if (strncmp(wmb, rmb, META_LEN))
                 printf("Failure: meta mismatch!, wmb=%s, rmb=%s\n", wmb, rmb);

         if (strncmp(wdb, rdb, DATA_LEN))
                 printf("Failure: data mismatch!\n");

         io_uring_queue_exit(&ring);
         free(rdb);
         free(wdb);
         return 0;
}

Anuj Gupta (7):
  block: define set of integrity flags to be inherited by cloned bip
  block: modify bio_integrity_map_user to accept iov_iter as argument
  fs, iov_iter: define meta io descriptor
  fs: introduce IOCB_HAS_METADATA for metadata
  io_uring: introduce attributes for read/write and PI support
  block: introduce BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags
  scsi: add support for user-meta interface

Christoph Hellwig (1):
  block: copy back bounce buffer to user-space correctly in case of
    split

Kanchan Joshi (2):
  nvme: add support for passing on the application tag
  block: add support to pass user meta buffer


 block/bio-integrity.c         | 84 ++++++++++++++++++++++++++++-------
 block/blk-integrity.c         | 10 ++++-
 block/fops.c                  | 45 ++++++++++++++-----
 drivers/nvme/host/core.c      | 21 +++++----
 drivers/scsi/sd.c             |  4 +-
 include/linux/bio-integrity.h | 25 ++++++++---
 include/linux/fs.h            |  1 +
 include/linux/uio.h           |  9 ++++
 include/uapi/linux/fs.h       |  9 ++++
 include/uapi/linux/io_uring.h | 16 +++++++
 io_uring/io_uring.c           |  2 +
 io_uring/rw.c                 | 83 +++++++++++++++++++++++++++++++++-
 io_uring/rw.h                 | 14 +++++-
 13 files changed, 277 insertions(+), 46 deletions(-)

-- 
2.25.1


