Return-Path: <SRS0=Kbn9=FH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B39C001B0
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Dec 2020 14:02:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04C720793
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Dec 2020 14:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04C720793
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:References:Message-ID:
	From:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YVTV948pbHLf8ct5GEDL4t0m9Deeo7itU/ol6xYkV6Y=; b=dBUgD027MiwiMxX8xKzrZmwgL
	TEofnBob6fNofky11ixzoqqQd2gzpCy/porqTfOLg3KehNBdAUBXQuvN8hoJx6ErR7kiDf4nQ23mp
	lAxJsRx6zcrbvl7fNs4VLoL1k1g9lN2DdnvOZiNyxjmJHeeO7HM4Jmgixp4CcXbYap3Hmsq7rOf/x
	or5gDLC9FXiwB1yXjkBpVGR0AjCaICGx19+x1t1K6go/MRKqJZjWbd7UrvOKr8ZexM7HkwEdRh8ml
	Hbk2Aj9TNfHGBRXSDUhUCHPHoMDt6NrdGXh+cdOXBssLXgFfqy2PqRrAJDr37Kit6BZenqXlDCiTF
	pRzd+4dVw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkpBQ-0002p7-Ko; Thu, 03 Dec 2020 14:02:08 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkpBN-0002ok-5k
 for linux-nvme@lists.infradead.org; Thu, 03 Dec 2020 14:02:06 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3DxZxx020238;
 Thu, 3 Dec 2020 14:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=08xcOXb4h+rrVxGTGyogS4/r+kWmWA3YCYglvjMxUYE=;
 b=kcyvep2IlMZNXZgX98SJMwlq2lXuIIyhI9HBQx9Ss/Quz4W3V/oL3EPzB0qtUwEQPF29
 nIOd7EiId5TTO9+alNySyHgepPuhwgCBDOev+s7nuJufTNAS++ChtlvyMyabXxruCmRJ
 RONOBtRl1a9ac4CgvYSyr/LHBmb/huDm+Rx6YcRDMnx9+PpiEMWxopcjK7X/D7riX2r9
 kyZuuWQRQOMrH54UyV/hy2dVUQXubhv14hhjrWeD8+iXSVguxLtRepgAyNkMAuenLf0T
 IC61q43W1VjqWKQ2b++VvaSFHC2T9i7PnUgQAPp+0dp+IgbIngu4OQE5wEI5V2aP9xoT wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 353dyqx45h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 03 Dec 2020 14:01:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3E0Ixr099297;
 Thu, 3 Dec 2020 14:01:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 3540f1vcx7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Dec 2020 14:01:46 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B3E1gNM026727;
 Thu, 3 Dec 2020 14:01:42 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 03 Dec 2020 06:01:42 -0800
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4] block: add a hard-readonly flag to struct gendisk
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zh2v826s.fsf@ca-mkp.ca.oracle.com>
References: <20201129181926.897775-1-hch@lst.de>
 <20201129181926.897775-2-hch@lst.de>
 <yq17dpza6nz.fsf@ca-mkp.ca.oracle.com> <20201203085339.GA17110@lst.de>
Date: Thu, 03 Dec 2020 09:01:39 -0500
In-Reply-To: <20201203085339.GA17110@lst.de> (Christoph Hellwig's message of
 "Thu, 3 Dec 2020 09:53:39 +0100")
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 suspectscore=1 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=1 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030085
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201203_090205_403005_BF610111 
X-CRM114-Status: GOOD (  22.31  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@redhat.com>, Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Christoph,

>> It's very common for database folks to twiddle the read-only state of
>> block devices and partitions. I know that our users will find it very
>> counter-intuitive that setting /dev/sda read-only won't prevent
>> writes to /dev/sda1.
>
> What I'm worried about it is that this would be a huge change from the
> historic behavior.

But that's what my users complained about and what the patch tried to
address.

Also, the existing behavior is inconsistent in the sense that doing:

# blockdev --setro /dev/sda
# echo foo > /dev/sda1

permits writes. But:

# blockdev --setro /dev/sda
<something triggers revalidate>
# echo foo > /dev/sda1

doesn't.

And a subsequent:

# blockdev --setrw /dev/sda
# echo foo > /dev/sda1

doesn't work either since sda1's read-only policy has been inherited
from the whole-disk device.

You need to do:

# blockdev --rereadpt

after setting the whole-disk device rw to effectuate the same change on
the partitions, otherwise they are stuck being read-only indefinitely.

However, setting the read-only policy on a partition does *not* require
the revalidate step. As a matter of fact, doing the revalidate will blow
away the policy setting you just made.

So the user needs to take different actions depending on whether they
are trying to read-protect a whole-disk device or a partition. Despite
using the same ioctl. That is really confusing.

The intent of my patch was to ensure that:

 - Hardware-initiated read-only state changes would not alter the user's
   whole-disk or partition policy settings.

 - Setting a policy on the whole-disk device would prevent writes to the
   whole device as the user clearly intended.

I have lost count how many times our customers have had data clobbered
because of ambiguity of the existing whole-disk device policy. The
current behavior violates the principle of least surprise by letting the
user think they write protected the whole disk when they actually
didn't.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
