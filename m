Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0729DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 22:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tCRppCeFVbaxkOhWX+SNPUWRc7R5mYlr0BincOdEP8Q=; b=gHd4ITqLS/iWHvYxRSnlwzgMsJ
	wa7Xdj+KJFyKS2LYudXnezzOaZWVk6N3xeUvCR0v3xY6+WbQcLaWjHVAyWon87zvjYuhDtrt7F8JD
	9w4W3orPTeISbQvdXdyZ7aI7dz5/T+yYhuo9b5e/V47BnUdSO25TSg9orX+mzyeYNPTQuXxjv4Ab0
	lNq34WtAdGaxbxPuVpa8Ujq10ifbZgNXYG7Uy6yJpnTXlYuS2Xqlvj7uzVIv4hqjEvHyJ39Lf/KJu
	tGXMINgTD6DWmRJ3kzLgIny52Ekbi2GunctlqJfQxZ17w9XrntWkihQ2dCXwoqFXZKbwIq515TRmZ
	YVjOGR2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRhvS-006OlV-BC; Tue, 08 Mar 2022 22:03:26 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRhvP-006Okn-Rw
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 22:03:25 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228IXin0027268; 
 Tue, 8 Mar 2022 22:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=tCRppCeFVbaxkOhWX+SNPUWRc7R5mYlr0BincOdEP8Q=;
 b=cDHFW4hXXnbl6TA689vL7Lj4LY2iB23pBIPGU/Jv35yq8P4Ifo3r4DLEl07hVpOFGKt+
 HuPSMuC0si8WeX9rc1ObeY+Tsn95ghYLhKTsH63aosCvJolsgCqCF4H+vD+WLPmzd2us
 3GvVd+5rOYeH8zvFAqWpsQHg2HM/w2qZz1glz5Kv+2dj4MX7i6lbOO0a5nEHXDjbMXmZ
 MoRFtAcKPcRaXNvkQHfvt3n/G1eumCdHd3Yo67s0q+7igPbYNiazGb1VtMefbDrY1hyV
 UoVaOZg/oa5ggBzleftXmGmnViWn4//EAp1hIiXAj5aSQxIM6I3mQtb6+7XZy5RbXa8W pQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3env4ug749-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Mar 2022 22:03:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228LmPd7017907;
 Tue, 8 Mar 2022 22:03:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma03ams.nl.ibm.com with ESMTP id 3ekyg90fn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Mar 2022 22:03:11 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 228M39CT31654146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Mar 2022 22:03:09 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B32BA405B;
 Tue,  8 Mar 2022 22:03:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36619A4054;
 Tue,  8 Mar 2022 22:03:09 +0000 (GMT)
Received: from localhost (unknown [9.171.69.133])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue,  8 Mar 2022 22:03:09 +0000 (GMT)
Date: Tue, 8 Mar 2022 23:03:07 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Subject: Re: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Message-ID: <your-ad-here.call-01646776987-ext-8820@work.hours>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-7-kbusch@kernel.org>
 <your-ad-here.call-01646770901-ext-3299@work.hours>
 <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
 <20220308214612.GB3502158@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220308214612.GB3502158@dhcp-10-100-145-180.wdc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OIEJLqOoE_bT85ZWh-kNBAx5-nznZN4A
X-Proofpoint-ORIG-GUID: OIEJLqOoE_bT85ZWh-kNBAx5-nznZN4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_08,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=862 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_140324_051275_6A9FEED9 
X-CRM114-Status: GOOD (  21.51  )
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

On Tue, Mar 08, 2022 at 01:46:12PM -0800, Keith Busch wrote:
> On Tue, Mar 08, 2022 at 12:27:47PM -0800, Keith Busch wrote:
> > On Tue, Mar 08, 2022 at 09:21:41PM +0100, Vasily Gorbik wrote:
> > > On Thu, Mar 03, 2022 at 12:13:10PM -0800, Keith Busch wrote:
> > > > Hardware specific features may be able to calculate a crc64, so provide
> > > > a framework for drivers to register their implementation. If nothing is
> > > > registered, fallback to the generic table lookup implementation. The
> > > > implementation is modeled after the crct10dif equivalent.
> > > 
> > > Hi Keith,
> > > 
> > > this is failing on big-endian systems. I get the following on s390:
> > 
> > Oh, I see the put_unaligned_le64() in chksum_final() was not the correct
> > action. I'll send an update, thank you for the report.
> 
> I'll set up a BE qemu target this week, but in the meantime, would you
> be able to confirm if the following is successful?

Sure,

[    0.543862] crc32: CRC_LE_BITS = 64, CRC_BE BITS = 64
[    0.543864] crc32: self tests passed, processed 225944 bytes in 118678 nsec
[    0.543986] crc32c: CRC_LE_BITS = 64
[    0.543987] crc32c: self tests passed, processed 112972 bytes in 58932 nsec
[    0.569479] crc32_combine: 8373 self tests passed
[    0.595330] crc32c_combine: 8373 self tests passed

it does the trick. Thanks!

