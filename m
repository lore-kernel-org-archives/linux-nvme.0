Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDC9C4361B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 04:20:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5EB2389E
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 04:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5EB2389E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:References:Message-ID:
	From:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+euThl52p42RFuGkG1qtD47xU0JHhcte1BKPul04hwY=; b=xFW9J7ZkpXAGe6rxNWrHWogYw
	g+SejVXv9e15DcQQuy0lZVRKtQQzJgHjnCf9noBvRYmIu1eNpnIcu9Ro1UCfnYKyQZchldIiKOzWE
	if37U4nVSWh8NSyI9CFU2d/XjqDHzodwO+OobZAsX8KP2LMOylGs1YcVqff8DjRUcSeROaVDHNxuh
	B5nc49mlXCsCeJx6H/RsHT+Hg4gH4pPshmaDyhk93HzLH3BCEf2bPmytHQGsIn0i5rrj3RMbW6CX7
	74pK2/30k5/SpvaTfpMNpNAad3uJhq1uZY0kXrgSx7ewtBq1RCLILnZw78/Mw2LRFLF4zqOMr0LVE
	X3EizLm0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmqxN-000498-1c; Wed, 09 Dec 2020 04:20:01 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmqxJ-00048n-ON
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 04:19:58 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B949u0E131946;
 Wed, 9 Dec 2020 04:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Ep5p4WguGIxmqM0JCUhPZOzQgsjp0oCH6k9sBId5oWo=;
 b=gl2ipg+Tm8sUO1pBILyyw7c41EYC8ReHRi4MFDRleivboQYW23bVGzQPRRP0otm7A6fw
 C8yc+1vNxep0dDAnFwwkRcchMj/3AccRCVrC7/ijl7WMs+nPiRqL05A3hbHCBzvoG8kJ
 wczzy/7oMyl1OUMyn7VKIIYNL1KvOT8rs+LTzD5a5a4FIvvkj0vW6N6+Hi0J97xY65qw
 9jvcZrtOck7VBaA7e0YP71dqmBvPt/USIib3UfCZJyO8yuueNFm6jb+6b0IMfl7H5/Gj
 6dr6QpNDzFFyqIX3qa0WAXA77liVrAG1IggFjcNKH//f1c0LMCDlMeeBKyB43XHr25Bp mA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 3581mqx3qy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 09 Dec 2020 04:19:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B94Anxw018646;
 Wed, 9 Dec 2020 04:19:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 358ksphs6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Dec 2020 04:19:46 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B94Jh8Y005517;
 Wed, 9 Dec 2020 04:19:44 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 08 Dec 2020 20:19:43 -0800
To: SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [dm-devel] [RFC PATCH v2 1/2] block: add simple copy support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1blf3smcl.fsf@ca-mkp.ca.oracle.com>
References: <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <CGME20201204094731epcas5p307fe5a0b9360c5057cd48e42c9300053@epcas5p3.samsung.com>
 <20201204094659.12732-2-selvakuma.s1@samsung.com>
Date: Tue, 08 Dec 2020 23:19:40 -0500
In-Reply-To: <20201204094659.12732-2-selvakuma.s1@samsung.com> (SelvaKumar
 S.'s message of "Fri, 4 Dec 2020 15:16:58 +0530")
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090028
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_231958_158689_962ADE24 
X-CRM114-Status: GOOD (  20.60  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, damien.lemoal@wdc.com, sagi@grimberg.me,
 snitzer@redhat.com, selvajove@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org,
 kbusch@kernel.org, dm-devel@redhat.com, joshi.k@samsung.com,
 javier.gonz@samsung.com, nj.shetty@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


SelvaKumar,

> Add new BLKCOPY ioctl that offloads copying of multiple sources
> to a destination to the device.

Your patches are limited in scope to what is currently possible with
NVMe. I.e. multiple source ranges to a single destination within the
same device. That's fine, I think the garbage collection use case is
valid and worth pursuing.

I just wanted to go over what the pain points were for the various
attempts in SCSI over the years.

The main headache was due the stacking situation with DM and MD.
Restricting offload to raw SCSI disks would have been simple but not
really a good fit for most real world developments that often use DM or
MD to provision the storage.

Things are simple for DM/MD with reads and writes because you have one
bio as parent that may get split into many clones that complete
individually prior to the parent being marked as completed.

In the copy offload scenario things quickly become complex once both
source and destination ranges have to be split into multiple commands
for potentially multiple devices. And these clones then need to be
correctly paired at the bottom of the stack. There's also no guarantee
that a 1MB source range maps to a single 1MB destination range. So you
could end up with an M:N relationship to resolve.

After a few failed attempts we focused on single source range/single
destination range. Just to simplify the slicing and dicing. That worked
reasonably well. However, then came along the token-based commands in
SCSI and those threw a wrench in the gears. Now the block layer plumbing
had to support two completely different semantic approaches.

Inspired by a combination of Mikulas' efforts with pointer matching and
the token-based approach in SCSI I switched the block layer
implementation from a single operation (REQ_COPY) to something similar
to the SCSI token approach with a REQ_COPY_IN and a REQ_COPY_OUT.

The premise being that you would send a command to the source device and
"get" the data. In the EXTENDED COPY scenario, the data wasn't really
anything but a confirmation from the SCSI disk driver that the I/O had
reached the bottom of the stack without being split by DM/MD. And once
completion of the REQ_COPY_IN reached blk-lib, a REQ_COPY_OUT would be
issued and, if that arrived unchanged in the disk driver, get turned
into an EXTENDED COPY sent to the destination.

In the token-based scenario the same thing happened except POPULATE
TOKEN was sent all the way out to the device to receive a cookie
representing the source block ranges. Upon completion, that cookie was
used by blk-lib to issue a REQ_COPY_OUT command which was then sent to
the destination device. Again only if the REQ_COPY_OUT I/O hadn't been
split traversing the stack.

The idea was to subsequently leverage the separation of REQ_COPY_IN and
REQ_COPY_OUT to permit a DM/MD iterative approach to both stages of the
operation. That seemed to me like the only reasonable way to approach
the M:N splitting problem (if at all)...

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
