Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01516C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7K2j+iJjt71qri7MYWgoSqhbLBMSKqlPcwbP02kFYG0=; b=4oetYseIUWI2j9uNrXUBVH0QSJ
	h2NdAVX+LelwHZ/+wN1rGytn5IbKFsS0yXdBwx5yQmN6JlDOWe4JvD9xpqQWiXWgxQPiMdz8QcRag
	36eVwCPR84BY6PBRCW3H1EvNy4XJvmryno/2TAgacJTWXu7hyZ+JGtCIbdnLzj8Itf/ZSrYlXvdr2
	1A1cVDcP3zcaiavoEGfTRDGJq0EQWmCwkVHeYFAssJVPsH1uUdcCV09/943XfD+Nb6VaqtU02IEGC
	8nTAVURCLN0zdqu2nkRITiVvsokKGa28C48JB4TfJH38LgL3c7AnsLMq/rFgnpmH9lWbgWP2oBmvg
	mKisW0+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osmrA-00EVHm-7Z; Wed, 09 Nov 2022 15:19:12 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osmr4-00EVEE-OC; Wed, 09 Nov 2022 15:19:08 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9EdGtq001802;
	Wed, 9 Nov 2022 15:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=7K2j+iJjt71qri7MYWgoSqhbLBMSKqlPcwbP02kFYG0=;
 b=NdNP113yvxHnNDx8u3glNjOmmaWEpEEm/t5ZzZAzhPChPSIEdDzWQTieir3vnowMvwX8
 HbeHOTWnTsy8v4WFU+tBl00kkjl3wTDd/gwB0OBR2JeCKetnTBnc6NOJ5wtUBrX9OQBN
 dvJ4bcJ6QjvDcmzVsvq4XmZe3eg813h53HeKmUUeSn0smO2B+uSlsWxU7Z9ijNSDpUN/
 pGPBKMN7ggatyaeSgL2W9IboqVtIfCG4DhmAOnFNrsyThOpFbgYpxEFYmyTaWMnoYA2+
 RuDVLKZWDLDV8aUFowqpaoqgin9nhy9XDm3IAExng7XPVNMce3cLJX4+5r551XRc28WK kQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krapk7dyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Nov 2022 15:18:37 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9F6M4k004349;
	Wed, 9 Nov 2022 15:18:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma03fra.de.ibm.com with ESMTP id 3kngp5m9pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Nov 2022 15:18:35 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A9FIWKV5767810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Nov 2022 15:18:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB7AFAE053;
	Wed,  9 Nov 2022 15:18:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7745CAE045;
	Wed,  9 Nov 2022 15:18:32 +0000 (GMT)
Received: from dyn-9-152-224-237.boeblingen.de.ibm.com (unknown [9.152.224.237])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed,  9 Nov 2022 15:18:32 +0000 (GMT)
Message-ID: <7d469dec0b3e11f20c720fbf2c9b3b1e5b765372.camel@linux.ibm.com>
Subject: Re: [PATCH 11/12] nvme-pci: split the initial probe from the rest
 path
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 09 Nov 2022 16:18:32 +0100
In-Reply-To: <20221108150252.2123727-12-hch@lst.de>
References: <20221108150252.2123727-1-hch@lst.de>
	 <20221108150252.2123727-12-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zP7hulsqWEA9P9Mg2Wt8V8qJjbXExptU
X-Proofpoint-GUID: zP7hulsqWEA9P9Mg2Wt8V8qJjbXExptU
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 mlxlogscore=837 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_071906_822301_B86DB98D 
X-CRM114-Status: GOOD (  28.70  )
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

On Tue, 2022-11-08 at 16:02 +0100, Christoph Hellwig wrote:
> nvme_reset_work is a little fragile as it needs to handle both resetting
> a live controller and initializing one during probe.  Split out the initial
> probe and open code it in nvme_probe and leave nvme_reset_work to just do
> the live controller reset.
> 
> This fixes a recently introduced bug where nvme_dev_disable causes a NULL
> pointer dereferences in blk_mq_quiesce_tagset because the tagset pointer
> is not set when the reset state is entered directly from the new state.
> The separate probe code can skip the reset state and probe directly and
> fixes this.
> 
> To make sure the system isn't single threaded on enabling nvme
> controllers, set the PROBE_PREFER_ASYNCHRONOUS flag in the device_driver
> structure so that the driver core probes in parallel.
> 
> Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> Reported-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 139 ++++++++++++++++++++++++----------------
>  1 file changed, 83 insertions(+), 56 deletions(-)

I have successfully tested the patch series as proposed here on top of next-20220908.
The small test script that I used to expose the race condition in my initial bug report
https://lore.kernel.org/linux-nvme/20221108091609.1020-1-hdanton@sina.com/T/#t
did no longer reproduce the kernel panic.
Even repeated unbind/bind/remove/rescan cycles worked without any issue.

Out of curiousity I did run a little traffic to the NVMe drive after the repeated
cycles, too. No issues.

While the patch series did apply fine on next-20220909 I was unable to do any testing
with that as that had different severe issues to boot.

So feel free to add my 
Tested-by Gerd Bayer <gbayer@linxu.ibm.com> for the whole series

Thank you,
Gerd Bayer



