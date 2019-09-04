Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA1BC3A5A7
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 14:13:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F6C22CEA
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 14:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XdhfoRNt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="qTT1hygs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emc.com header.i=@emc.com header.b="khi/mwbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F6C22CEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ett+hfOxx/M0GIo+pGjUHA21OeCb9QMi4UQsBYJPyZA=; b=XdhfoRNtEnoJkS
	G/Z2T3S2kydkq50KBpXFQARQbYAJ9KN68VAo1fowpsnk6m2JEvFW+7RalnsECzzfVKP/NZfglobc7
	+ZmfAMkJFR7s4HbEQUm/n4zRHQ3GYFMugTFemXB9CwuIWiXUpOneGkmK7jM1AXMY2+RBKdFEtmJkS
	TAirS+9b94DRc15DhZCj7s0KhxoLDrYOii9V+ByygAei49CSbg6O3/oW/dJj4YmdyfMeRzmvegcrQ
	5TGA5FwKknKqhessZqPSUe4Vp31kWYZ9t2mKPFvyUtN886EK3xUlezm+89hywFoel0ZJ8k9zMm7q0
	tjUVgClB9yMRq4hwjFNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5W2O-0005S0-7d; Wed, 04 Sep 2019 14:13:32 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5VwF-0005Iu-Li
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 14:07:14 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x84E0FLg013814; Wed, 4 Sep 2019 10:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ClEff/R68nJHiwNNS6jYylwcLX6tiOY+rMZUFGBSZMk=;
 b=qTT1hygsTTt7g3Y6LyGOiJ3JcJ+MnKmd9E+r9lsbxkNeZsACi/CgfsJKGjxZqLeieREA
 siSBpW/oJp3MrYsZnu9bVJxp8qAyyytWPoyo7GG7qqF1CDDpBuRjU9zQQRLU1aez3nXJ
 MOgUb/FLgKVgR/BKGWHHzQbDdZDY9lrrcMcqymhjVRO1sG6zAj8D8u+X1dJFHSprZsbf
 S7shtrlCEVX0md98Hu37QFnaJ633FpkYS/Y0wP7n4/FUif3Djr+Yd7BiDoJ6S94PUVq7
 qNr03bYSion/+YFsyysjTGkVFK0PRvwOC/Iz1T8S4TDAUmP//hJ1Q6WVPPobLhMrdVVz DQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 2uqhyurbmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Sep 2019 10:06:46 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x84DwaBX025905; Wed, 4 Sep 2019 10:06:45 -0400
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com [168.159.213.141])
 by mx0a-00154901.pphosted.com with ESMTP id 2ut6tv7sw9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 04 Sep 2019 10:06:45 -0400
Received: from maildlpprd05.lss.emc.com (maildlpprd05.lss.emc.com
 [10.253.24.37])
 by mailuogwprd03.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id x84E5lX2013708
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Sep 2019 10:06:43 -0400
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd03.lss.emc.com x84E5lX2013708
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=emc.com; s=jan2013;
 t=1567606003; bh=hZCSzgSLE6aJgkgtzykdOlhYfl8=;
 h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 b=khi/mwbp5GvDwkxvCHM7JLEp/eBcWlLG5qpdu6kcFSpyL11YWovldrg705ibRWU4F
 FfaQIYWhvw5ejM6AUSjnPV5j3Zd+iWWNFmDTBRp2bxlon54KS98jt4gcF5ercTzz93
 7mewt8Eb8SwTykIa7dgMzk+6duqeBA8AyR4Mh710=
Received: from mailusrhubprd03.lss.emc.com (mailusrhubprd03.lss.emc.com
 [10.253.24.21]) by maildlpprd05.lss.emc.com (RSA Interceptor);
 Wed, 4 Sep 2019 10:05:14 -0400
Received: from MXHUB315.corp.emc.com (MXHUB315.corp.emc.com [10.146.3.93])
 by mailusrhubprd03.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id x84E5Iql014827
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=FAIL);
 Wed, 4 Sep 2019 10:05:18 -0400
Received: from MX302CL04.corp.emc.com ([fe80::18ad:6300:21eb:2b39]) by
 MXHUB315.corp.emc.com ([10.146.3.93]) with mapi id 14.03.0439.000; Wed, 4 Sep
 2019 10:05:17 -0400
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH] nvmet: fix a wrong error status returned in error log page
Thread-Topic: [PATCH] nvmet: fix a wrong error status returned in error log
 page
Thread-Index: AQHVYCzrqpORZZYTjEisFVH6xiRa2KcbyCeA///DvnA=
Date: Wed, 4 Sep 2019 14:05:16 +0000
Message-ID: <8739B0CD2FC2DC40AF691A1CCBB9896034610E40@MX302CL04.corp.emc.com>
References: <20190831185006.119748-1-amit.engel@dell.com>
 <20190904131447.GA9892@infradead.org>
In-Reply-To: <20190904131447.GA9892@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-09-04T14:05:15.4639473Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-originating-ip: [10.76.81.143]
MIME-Version: 1.0
X-Sentrion-Hostname: mailusrhubprd03.lss.emc.com
X-RSA-Classifications: public
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-04_04:2019-09-04,2019-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909040140
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909040140
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_070711_913946_130F8BF9 
X-CRM114-Status: GOOD (  16.49  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I agree that your proposal should work as well.

(BTW, we can simply use
num_of_sgl_slots = req->data_len/sizeof(struct nvme_error_slot)

How do you want to proceed?
Should I provide a patch according to your suggestion?

Thanks
Amit
-----Original Message-----
From: Christoph Hellwig <hch@infradead.org> 
Sent: Wednesday, September 4, 2019 4:15 PM
To: Engel, Amit
Cc: sagi@grimberg.me; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: fix a wrong error status returned in error log page


[EXTERNAL EMAIL] 

Sorry for dropping the ball earlier..

> +	num_of_sgl_slots = do_div(req->data_len, sizeof(struct 
> +nvme_error_slot));

I don't think this does what you think it does.  do_div has a reall odd calling convention where it returns the result of the division in the first argument (despite that not beeing passd by reference, thanks to being implemented as a macro), and returns the remainder in the actual return value.

But I think the fix might actually be as simple as:


diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c index 4dc12ea52f23..543fb2a0c005 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -37,7 +37,6 @@ static void nvmet_execute_get_log_page_noop(struct nvmet_req *req)  static void nvmet_execute_get_log_page_error(struct nvmet_req *req)  {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-	u16 status = NVME_SC_SUCCESS;
 	unsigned long flags;
 	off_t offset = 0;
 	u64 slot;
@@ -47,9 +46,8 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 	slot = ctrl->err_counter % NVMET_ERROR_LOG_SLOTS;
 
 	for (i = 0; i < NVMET_ERROR_LOG_SLOTS; i++) {
-		status = nvmet_copy_to_sgl(req, offset, &ctrl->slots[slot],
-				sizeof(struct nvme_error_slot));
-		if (status)
+		if (nvmet_copy_to_sgl(req, offset, &ctrl->slots[slot],
+				sizeof(struct nvme_error_slot)))
 			break;
 
 		if (slot == 0)
@@ -59,7 +57,7 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 		offset += sizeof(struct nvme_error_slot);
 	}
 	spin_unlock_irqrestore(&ctrl->error_lock, flags);
-	nvmet_req_complete(req, status);
+	nvmet_req_complete(req, 0);
 }
 
 static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
