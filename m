Return-Path: <SRS0=58/p=4Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FECC3F2D2
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 12:53:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D9320665
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 12:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FSXsj0aw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="Wfw0XSQ6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="cubABniI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D9320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PIN9DoeQR7qESVp/Il6xUMzcMHYsNySH343OvCIG3VI=; b=FSXsj0aw76xznU
	OW7Dk4g1oohlqQUAIrWXRqtQWc0tDCRxKrUdEgFPrfEgc4h1gg3s+G599SkoiPv+X9viWukFkRYoZ
	/FO9QR6NjI3eZhQgmxSX6kmoz9SZqLQJsl9lKkhaMQXi1miOVH3qP8hUc95oAFlAx23/yFA6Ml3+a
	/hkLMctuK8Vh/fYmblQDkCXQri0fa1jvkhGMtIaLVPkomYAKcrpZqHQ3X7GTsIFX/dz/RP0psrxIn
	DxPLK8Te8Z7xGhEx193AUK42gPOJ+qdY9mlEU34sG18C3jzxEqbh6yCJnEuS+UqyQ399us8C76brc
	Stiz35p9cahB8AQ8Kr8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7f9G-0004Dy-Pt; Fri, 28 Feb 2020 12:53:46 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7f9D-0004DF-Po
 for linux-nvme@lists.infradead.org; Fri, 28 Feb 2020 12:53:45 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01SCkeNp015422; Fri, 28 Feb 2020 07:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=p6bJbVXH8Bg0s18Z+hG4GzuRw53QZrt9bdykYp1lrcg=;
 b=Wfw0XSQ6SJ6QbpfxQxhuEen7bODAjeaKTthw9Aez3OiGyYKYcWStAmNkhpDsfxV2jMjQ
 OnGNUzZ4hTKnpY5tb6Jb7oRp9gbAJ67Vg8WxHH4xr9lWvIl5V2s2RgnFAjVIKbdzhx48
 XkC8tG647lzrDV0pUbMoQD+gz9Hz03MiQ+U1YwksuUUzJvEYzfQdiHSwzkBTr5U9Yi4y
 6Vi4qq29Z/dBn1Iz5yP8UY+KgO5/ctQevGvNbJelcjL1e1jqBmZGAl/d3LjL5AaCajpL
 khiBpp/SVyYv45oca0/68DYzwZppo0tajbTps2NjGzs7/fesoULF5vklyVG5zpzCY3Tg 7Q== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 2yepvpthte-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2020 07:53:34 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01SClIP1081925; Fri, 28 Feb 2020 07:53:34 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by mx0a-00154901.pphosted.com with ESMTP id 2yepvx14v9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2020 07:53:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXp05DvcY0XsmcUClHHe2kENOoZkM9jG99ZcsajuvK2zR4KH9pK1D1Gedxi9H/erNCEOPRB/n/+2HyvfGIRfme4FrRfYk265aF1R1N/fdPJb+Ib+TrgnKzhzD0jP6ec26LMLMsKB5Nvtz18n6avmHzkJAPcxQSoR/6JrIOAXX0hgI6WJQZj1AMP5IUeX3qZ7uCClHUg26Sn2u0fo8ECv9oTfd8h2C+kjRWb7pTyKGch8r13Y7wCh/NA7LLyy14WrfaJ2f7KWPjHkeks64PGFwd+rmUmHTfCudWD4NOInO2AuLqwDd+RFYQKaR33+fjBm8TlyQIHSjSXwFeygfMs5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6bJbVXH8Bg0s18Z+hG4GzuRw53QZrt9bdykYp1lrcg=;
 b=CSBJ+ENeyed2zeF/uSUtFy37zloZGNejov0xK6xwF2MTrD2hZIwtaxm4kI2peFJWEsb3uw4NA6a4BrR6aOvT5ituYoEyZogpFNL+uLoQV9NbAZSLkmKQyRKXg+OKxDcZU5xyhyTfqUpq1WQC2As5wprvgpUmw/RiSgFedd57DfMel2vblnOGvviuBYicMVaexBdE3fVvCV45zpMGYLnLCD2L0w70BYuLaK8TVDXAK4jCL2tsOtvVn2WzKpznY/GZXZFCGY17v2iFGCr0uiPRQvPzbjTCupw7gUqgcwOsXLlMZRtB5HoRBLSVbQskMkGpCzdzEyD3XFO5QjMwNtPMzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6bJbVXH8Bg0s18Z+hG4GzuRw53QZrt9bdykYp1lrcg=;
 b=cubABniIBbzEKWxxSxL7gmKilh5ezhxG/XdEV7rPr3v7lu1B/BwtlVz7TVCdnCERxQR3Tu2Sjz5E9dIhaS+ickYvQz5utk86MYJr5on5ph0WF/jME0vFXdh1hUYUrbauUHbO0qvSDWcQDt+TLm4MEz7BhJChHBOLZTDABhPcUxg=
Received: from MN2PR19MB3005.namprd19.prod.outlook.com (2603:10b6:208:109::21)
 by MN2PR19MB3341.namprd19.prod.outlook.com (2603:10b6:208:135::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Fri, 28 Feb
 2020 12:53:32 +0000
Received: from MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d23:2a41:b2d:8d0d]) by MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d23:2a41:b2d:8d0d%6]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 12:53:32 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvmet: return Invalid Field error on set features cmd fid
 07h
Thread-Topic: [PATCH] nvmet: return Invalid Field error on set features cmd
 fid 07h
Thread-Index: AQHV7XjOe1tnql4je0qWd0G4Qh662qgvrOuAgADkJwA=
Date: Fri, 28 Feb 2020 12:53:32 +0000
Message-ID: <MN2PR19MB300575CFAC349D7133C36885EEE80@MN2PR19MB3005.namprd19.prod.outlook.com>
References: <20200227141652.80584-1-amit.engel@dell.com>
 <599c5eb6-f7d1-291f-5fbb-9a688da0c1e7@grimberg.me>
In-Reply-To: <599c5eb6-f7d1-291f-5fbb-9a688da0c1e7@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-02-28T12:53:29.5344225Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-originating-ip: [152.62.109.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34011f59-0feb-40e7-dab9-08d7bc4d377b
x-ms-traffictypediagnostic: MN2PR19MB3341:
x-microsoft-antispam-prvs: <MN2PR19MB3341E9FD4D85721456631524EEE80@MN2PR19MB3341.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(199004)(189003)(71200400001)(2906002)(186003)(110136005)(26005)(316002)(786003)(7696005)(33656002)(6506007)(66446008)(66476007)(64756008)(5660300002)(66556008)(86362001)(76116006)(52536014)(66946007)(8936002)(8676002)(478600001)(81166006)(81156014)(55016002)(9686003)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR19MB3341;
 H:MN2PR19MB3005.namprd19.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: Dell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B60V1r/7S2qgfQNPNTGqr+tgvHq2DI/nwgi5yiFFPMLqvqSS9F3YYsOQ8du+Z96oTUKYZ4M/bHIdY/i1Z6e04mCP8H1grZHrBlBrEe92XAZovmsI3Ky5Da2e3IijvRDuL2NlQXQuKQkaitQB/EyjrMNPqNp4o+10t4Hz1oIp8VcAf2QysOfp0tcK74Q456k4wm7/YHtRFLRpvhS/BFRAsTTQlXijwG7COJPUVg2i0hSWhjdYFUn7mGc6u+/+09mZmX3ng/6Pvi/Yxi6+qPSt6IAzL0XS5tcAuXSBfYMqF0NeSndPgStFxoX9bLeV/49/dxFolwlDytra7H/sDUFTN6BwMgRwxcbwHoCe+znuc6YZ6hcno7yTtKtEin/BZd/0E3nanp4J9Red6/cAHmAudEZisiBBmAO9M+9SZURe6qcA+VOdOmw3y8owZs50WXvZ
x-ms-exchange-antispam-messagedata: h6e13ThmfcJ4Ur+MteRsX7PADUjftQWc7szVhkHoVJOtMWV2BzOEemfnl+F74Rc+MCv3WtufKaSsWcj+7TySwwt3LtxjYW3uXP/aWr55J2N3JnGQ89+NVynBnW7rLeV+8d850kh4RpPOZZYfee/F7Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34011f59-0feb-40e7-dab9-08d7bc4d377b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 12:53:32.4562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNND6Yd9PU+3gDheVGtkClkgkhv0NcPF3MkFV5IP6SWqO9THydUwn56yRcNdPPTAVtVF7RFmQSf8FY36Jq8//w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3341
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-28_04:2020-02-26,
 2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280104
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200228_045343_868037_984A45E4 
X-CRM114-Status: GOOD (  21.98  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sure, I just uploaded a fixed patch

Thanks
Amit Engel

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Friday, February 28, 2020 1:16 AM
To: Engel, Amit; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: return Invalid Field error on set features cmd fid 07h


[EXTERNAL EMAIL] 


> From: Amit Engel <amit.engel@dell.com>
> 
> If the value specified in NCQR and NSQR fields (0's based) is 65,535 
> the controller should return an error of Invalid field in command
> 
> Signed-off-by: Amit Engel <Amit.Engel@dell.com>
> ---
>   drivers/nvme/target/admin-cmd.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c 
> b/drivers/nvme/target/admin-cmd.c index 19f949570625..f76b44768100 
> 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -733,16 +733,25 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
>   {
>   	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
>   	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
> +	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
>   	u16 status = 0;
>   
>   	if (!nvmet_check_data_len(req, 0))
>   		return;
>   
>   	switch (cdw10 & 0xff) {
> -	case NVME_FEAT_NUM_QUEUES:
> +	case NVME_FEAT_NUM_QUEUES: {
> +		u16 ncqr = (cdw11 >> 16) & 0xffff;
> +		u16 nsqr = cdw11 & 0xffff;
> +
> +		if (ncqr == 0xffff || nsqr == 0xffff) {
> +			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +			break;
> +		}
>   		nvmet_set_result(req,
>   			(subsys->max_qid - 1) | ((subsys->max_qid - 1) << 16));
>   		break;
> +	}

I'd avoid parenthesis in the switch-case statement, just declare them on top and assign them here.
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
