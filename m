Return-Path: <SRS0=vpxS=XN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610D4C4CEC4
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 21:43:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3032021924
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 21:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LfQCJ33E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="DxycVrDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3032021924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T+ewQU8FiGXfRNXeUtqAJgdj3XSRjRJFyBH46eSMY3o=; b=LfQCJ33Erhd0Bb
	u4t1SO03vUu7TGRgPNiA3dWaqvkweRt1dZepP1y3bloeN+BGUJLOHJ73xL+8nasW+tgVe7oGtN1W2
	MoF/JunQHwfNmcVg+vKuwkLEut/aexunpqiPUzOgQ380zn5dMd5nEZODoVjguAN0PGoqrZf62cwvh
	s+qEyYDD8tdkWck3FeE/+yXMt0fJ1cLFOzKFrnJbn5JO5uWtain+H7UvY2+xhcIMwk1rY3YkJ3Q6z
	O1uqTmtpwhFb6eTGJDi//gv4oFRtsurVsk/5NVHom7QMObR7SGyk7hqD9O12ZmGmHTtbs6zcRYiY3
	NfenUelXrwkNQzq5d4kA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAhjb-0002c9-0P; Wed, 18 Sep 2019 21:43:35 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAhjY-0002bP-92
 for linux-nvme@lists.infradead.org; Wed, 18 Sep 2019 21:43:34 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x8ILeTr9020358
 for <linux-nvme@lists.infradead.org>; Wed, 18 Sep 2019 17:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=APeqSupOa17yJyshJEarRmRxQctnz7EtTNwsuT5TFO4=;
 b=DxycVrDL556xL+ixdMIls8i5GnjMbZWlvruCYGrYqAOzGDYjLV34CVHTaAHkJ9reEjCa
 H7W/rcec3EwpDLQLeg2yDaJV8d9XudXqxDvCfzgRRiYyD7gr6ao6NSLN63qAFO8dfqvh
 JjH9nOGbk0kdWKGfLuVxd8WEhRjl6aEb26Z8ZfdBRLce7X6HwlZGWZy3hsXhBhrK/r7W
 8yPkMWhxVqGJvq7qnDPZ3hSfhDzCiqta1VLJMao/Ac/Db1pwmXaPDTpFn3FWtFp0lReK
 j1hCX2ShK2QHJ1xqz7615yKo5iJX0Z/khQjznj3Spa6qnkxne0nx6ouWuy1hQ6Ymd1VV GQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 2v3vdx02sh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 18 Sep 2019 17:43:31 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x8ILcMLC093192
 for <linux-nvme@lists.infradead.org>; Wed, 18 Sep 2019 17:43:31 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com
 [143.166.148.223])
 by mx0a-00154901.pphosted.com with ESMTP id 2v3vd788hp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Wed, 18 Sep 2019 17:43:30 -0400
X-LoopCount0: from 10.166.132.54
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; d="scan'208";a="398570735"
From: <Mario.Limonciello@dell.com>
To: <rjw@rjwysocki.net>
Subject: RE: [PATCH] nvme-pci: Save PCI state before putting drive into
 deepest state
Thread-Topic: [PATCH] nvme-pci: Save PCI state before putting drive into
 deepest state
Thread-Index: AQHVaPqcVa1BaYWKPkaPLLLTJYPQjqcyUq2A//+vI2A=
Date: Wed, 18 Sep 2019 21:43:28 +0000
Message-ID: <346fd9ced98e40229d0cc0871ad5ed32@AUSX13MPC105.AMER.DELL.COM>
References: <1568245353-13787-1-git-send-email-mario.limonciello@dell.com>
 <4858057.cjDlXVALXj@kreacher>
In-Reply-To: <4858057.cjDlXVALXj@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-09-18T21:43:26.4017972Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_10:2019-09-18,2019-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909180184
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909180184
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190918_144332_376167_AD554E6B 
X-CRM114-Status: GOOD (  26.18  )
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
Cc: Crag.Wang@dell.com, sagi@grimberg.me, linux-pm@vger.kernel.org,
 sjg@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, Ryan.Hong@Dell.com,
 kbusch@kernel.org, Jared.Dominguez@dell.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Rafael J. Wysocki <rjw@rjwysocki.net>
> Sent: Wednesday, September 18, 2019 4:31 PM
> To: Limonciello, Mario
> Cc: Keith Busch; Jens Axboe; Christoph Hellwig; Sagi Grimberg; linux-
> nvme@lists.infradead.org; LKML; Hong, Ryan; Wang, Crag; sjg@google.com;
> Dominguez, Jared; Linux PCI; Linux PM
> Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into deepest
> state
> 
> 
> [EXTERNAL EMAIL]
> 
> On Thursday, September 12, 2019 1:42:33 AM CEST Mario Limonciello wrote:
> > The action of saving the PCI state will cause numerous PCI configuration
> > space reads which depending upon the vendor implementation may cause
> > the drive to exit the deepest NVMe state.
> >
> > In these cases ASPM will typically resolve the PCIe link state and APST
> > may resolve the NVMe power state.  However it has also been observed
> > that this register access after quiesced will cause PC10 failure
> > on some device combinations.
> >
> > To resolve this, move the PCI state saving to before SetFeatures has been
> > called.  This has been proven to resolve the issue across a 5000 sample
> > test on previously failing disk/system combinations.
> 
> This sounds reasonable to me, but it would be nice to CC that to linux-pm
> and/or linux-pci too.
> 
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > ---
> >  drivers/nvme/host/pci.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 732d5b6..9b3fed4 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2894,6 +2894,13 @@ static int nvme_suspend(struct device *dev)
> >  	if (ret < 0)
> >  		goto unfreeze;
> >
> > +	/*
> > +	 * A saved state prevents pci pm from generically controlling the
> > +	 * device's power. If we're using protocol specific settings, we don't
> > +	 * want pci interfering.
> > +	 */
> > +	pci_save_state(pdev);
> > +
> >  	ret = nvme_set_power_state(ctrl, ctrl->npss);
> >  	if (ret < 0)
> >  		goto unfreeze;
> > @@ -2908,12 +2915,6 @@ static int nvme_suspend(struct device *dev)
> 
> This is the case in which the PCI layer is expected to put the device into
> D3, so you need
> 
> pdev->state_saved = 0;
> 
> at this point, because you have saved the config space already.
> 
> >  		ret = 0;
> >  		goto unfreeze;
> 
> And here you don't need to jump to "unfreeze" any more.
> 
> >  	}
> > -	/*
> > -	 * A saved state prevents pci pm from generically controlling the
> > -	 * device's power. If we're using protocol specific settings, we don't
> > -	 * want pci interfering.
> > -	 */
> > -	pci_save_state(pdev);
> >  unfreeze:
> >  	nvme_unfreeze(ctrl);
> >  	return ret;
> >
> 
> 
> 

Thanks, I actually followed up with something along that line in a v2 sent out
today.  My apology you weren't in CC, but here is a weblink to it.
http://lists.infradead.org/pipermail/linux-nvme/2019-September/027251.html


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
