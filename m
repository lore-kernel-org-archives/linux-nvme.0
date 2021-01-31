Return-Path: <SRS0=pTPU=HC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6035C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Jan 2021 15:47:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6588D64E0E
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Jan 2021 15:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6588D64E0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eHJZqxz8Cmph5RJgtpzYfeTa8flxkktaEDI7mvKbiyk=; b=OXMsz28fpRpkDm1nnPaYVyelLU
	VpViBTcXiPHXDZn1G9WgADRkWc7lGkGPeBRrzwibug+TOxFHRM74uCGpaTrwh5/W+r7JMcSsc6Tio
	n4PyeMsmTrkWRdpXood52DF4FnyzPbYyjpxIPxFeo7g3L0yw33n1svdF93x7eul+uQ4M+Iek+rQY9
	clU4ED/43iH4lJmEdHgEak1iPnquU+44OgyAMN3nOU0ryTwEpcDlqojNzBgSMivkZ74UX76As9AlY
	0DGMFSTSqvAoDbKeqKVEnYjcJKBTVYdudH0Sc/WA5rgXHUGpY6YnRRTKPrBaHqWVxrFrzKzAxr6Jc
	BfFEZuwQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6Ewl-0004uc-6l; Sun, 31 Jan 2021 15:47:31 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6Ewh-0004u3-OX
 for linux-nvme@lists.infradead.org; Sun, 31 Jan 2021 15:47:28 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10VFceNH023360; Sun, 31 Jan 2021 10:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=vIbJKp+XaisxVVGJEzkfRhykEwMJmNMmf3dmhiTPMMc=;
 b=R9Ij3EQC7z1QnLUTzmyLJkp3d2MH1y/UyMpTp4yegC935q3FR3UK5W1Qu+rFbLp1ZeEX
 Nj3dXPJBPg8Tvousr301Y69zEaqggGDpxzBztDgOytoQ4d11Kp72bqYnywt4aGxOdaht
 OOiat6yuYPnV/npnRTvolasgbro11Ap3yOhvHTHCYbla/9lHSrpZHLn3UvxGfFBHLZqS
 C30Zy7QqMyoFLq+ZPQ8V0DPkzeS0nSEaD/Ewv9NtHhAgiYb0/WaRd3QYxFOyUxbnmrOS
 qPn1Gk+PEOSASXia3zuohfr4ydb1D1QZILhNKYkdVQ6E7eXLiElxSAlOtWBahX2A6bHY dg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 36d4bqhyas-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 31 Jan 2021 10:47:24 -0500
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10VFe38Q134221; Sun, 31 Jan 2021 10:47:24 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-00154901.pphosted.com with ESMTP id 36dn6cm0se-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 31 Jan 2021 10:47:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4D9a3vReDg90m55TZlEl5XnPB+y8ep94du+8meljwuV4UOIbjtPA3ELPFYvjmGtDuBouuWa3UtaNC5B1tKRcNpPPWLFjev+xvKNBVVUMd8T7WyB2YAtCDb9D6xLFYaLzIqs2pjZRd9MhYxzsdpICI7qFZd7QX5HTqbpAri9SPonCiiFZM9Zr4tz+XGRfYJwi0c42omfD5qG6RFOZfeGoauNYUKrEVlIy1qgf2gcBbX8frYAuUSlTX2D/SKKrOF7k1jKXWywW4J02w+hlFiHeydOASmNDgWOQxOuZFgLuGN6BIxT9eoe6gWv7Sb9e3nh55dYwQnCW6VEjUCPL/j//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIbJKp+XaisxVVGJEzkfRhykEwMJmNMmf3dmhiTPMMc=;
 b=mF7CMZUrxyzvzupWZo2d0+G+MIpl7f2R5JbGrlBXLBDimJNoefSNqUv5JFZjU/ES+47b6pOGccPCygZzn/jGGVbLeXWoYAfORCnAk8hT3gSqFUQGrRV9OeWvPAmJKjaxGV/clv7PFIGHA/GtxzwRfSQGPK8QysMk73rYDbp0UfS2wgTtRsnrEn/U155NWf7vPA2EZdI3rjP8/03Xvo8+vFbZf/Swuc5IPpuTc1mpILOTkOWxmWa2F2dZopHWgsVxICnOLnmoKbxWouxVPVKbxoWs6K9fThXG8uSZ/XCHnzmdV3uCjf5hLDRc8w2Vwe672YrA1qWCzQ4O8258IdKIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB4327.namprd19.prod.outlook.com (2603:10b6:5:2b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Sun, 31 Jan
 2021 15:47:22 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2%5]) with mapi id 15.20.3805.024; Sun, 31 Jan 2021
 15:47:22 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
Thread-Topic: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
Thread-Index: AQHW9Yot5sDcdvF1ckSEbnpOtZTZe6o/K/2AgAK4XFA=
Date: Sun, 31 Jan 2021 15:47:22 +0000
Message-ID: <DM6PR19MB40115B3CE827B63255F0C2EEEFB79@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210128152758.114112-1-elad.grupi@dell.com>
 <a3c4ef7f-45df-c071-8e00-074d1e48eaca@grimberg.me>
In-Reply-To: <a3c4ef7f-45df-c071-8e00-074d1e48eaca@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-31T15:47:20.1609769Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=2a3a1765-fe69-4862-b4af-6bac3b3acef2;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [152.62.109.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13a1d53d-8fdd-4c6b-98eb-08d8c5ff7ffc
x-ms-traffictypediagnostic: DM6PR19MB4327:
x-microsoft-antispam-prvs: <DM6PR19MB4327D00DA15BA4B3A026B096EFB79@DM6PR19MB4327.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u9gOl/z63IKbkj4Cu6lZn+HC+0n617pJhsWrXil3XmmHn0IO8nmWuoT+nI1hKE4lnxB5+XP7lQMP0WNu/lr6OvWMr3ersuBqKlHLRbigzbtvY7A2uvDi7pWgzpqMpXqGbvRtLRAdcGHB/4CYo1L3SGA1VqafPtSQG6Pp/2BvGkH0cBOfJzHB8icXSCzkN5cyk/FqdgsvItLpAJLE2tKu88riX+/Is4splX/tYZoiSp3+tQNELwzpBEVHsnCTZ982IC7N1nqFRWNwFStZRJNInpVmnRhbtdfOCs4l/+wyEeIKhQho0YfMXwkt6CbMebLcC6kg+teZSjYuDfDMycCNNIuV3pwsEP8PEtiGHnhwWQVTs6cgXiNzLB36LMnz7MzoEHMc7heqEC//iVVENauOcUu9RHVlNx+8EyvB5URtvWP1nkNqnVbXgm6kyuTlUBIq/R21w6PkgFn3rajwLJgmkP4a06UVM/F7G4SX1SazyuRzfPpN1Sa2k+rwhfSwmu+LNoeRPt4W4pwBCPCwga7HBQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(4744005)(66476007)(52536014)(5660300002)(83380400001)(55016002)(66556008)(66446008)(64756008)(9686003)(66946007)(86362001)(33656002)(76116006)(110136005)(26005)(7696005)(186003)(2906002)(786003)(316002)(478600001)(8676002)(8936002)(71200400001)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?cDVLMm9KbjkvdkVuWFZPVHI4UUQ2SGVJWlRGcnRTdVRTUWlQNTN6M2xjSjZL?=
 =?utf-8?B?dEdwSUZLbk9SNE41aDJqUlBPMlllQzZqK05BZGFlS29oVXdqcDY5WERlOVhG?=
 =?utf-8?B?UlVqcmhjalBnNHBISW9YaFNrNFlobmN3MXhvY3VtNjdNWmJvTEdWY2VHei9w?=
 =?utf-8?B?Mklic3V0NnU5WFZncVUxSCtNT2dSZUpHRzRabTU2ZXk1bmZnc2ZMNW91ZHFs?=
 =?utf-8?B?WXdYa3JZam1QU0h0OUFVUndSTWpQMjBzUTdsMFVsTlg3Tzd5N0lUQkZLbjFa?=
 =?utf-8?B?RkMyQXoycmRyM2d6RVFYcnEyTEliaWJkRzV5SkpNNU1XcldkcVBYMHVEeEdL?=
 =?utf-8?B?bmhERTcyeElxTDgwOHZQY1BGYlNKN3dKOFFiUTNrRnlQUU9vNnRIZS90djJW?=
 =?utf-8?B?VE1FMFZpM3gxdy8vS1pCS0JiYmpKbThHczVFYXJFY3ZvNWhQSm4zMnlvSXQx?=
 =?utf-8?B?SjYxUkUxU3pJSFA4blNWa3JZQVFrdmdVTHhmd0J0U3FZUmlMbGdTWkF5L1hQ?=
 =?utf-8?B?WU5maWxWdHBMc2VZUUpnMXdISnhpYjVPTXFZUjI4MWJyRzZGMXBjcVVNNVdT?=
 =?utf-8?B?VTBMdmRYSDIrNERyRUhkc294Z1JRU1Z2U1J0aWJBSzJ5Um9RTnlERDN1cy84?=
 =?utf-8?B?OU5JbTFIWnFUcDFFa1FpN1J1RG9tSjBudlNxUjUycno4R1VuSXRZMDBLdlVk?=
 =?utf-8?B?d1l4aWt3ZkY5ZFkybEVQTm9QU1kvTEYxTW1vWHFjTU5JNHJJNXZCT3hjbGFw?=
 =?utf-8?B?NzFna1dCTndYWmhLaVRPMjJ2a0lHeHNNMzZHbVk0VW9BZFUxOEJ1a0lnMFlm?=
 =?utf-8?B?Rm5hVlBiWXd4LzBFRVh3UVBmQSttVTdEUkVlT3BXaGE4UHpIMk1qcUVpOEpN?=
 =?utf-8?B?aE1YaXRDYWhVTzRMaEl4SnExWUxYbmFseDRudUtZRnVtN3UwYWVHYVhKVmpH?=
 =?utf-8?B?YVh6ZUpoaDB2NWUyUEF4cU9CZkJiRzl1dzZtVWduWnhZcHNiSDRUK1Z2VkMx?=
 =?utf-8?B?Mm5CRFJKWlNIRVNCejFkR2pDRThuL3hGWDhGL0NDMXFkRWNPZTFDNG5SUUQ1?=
 =?utf-8?B?cUJ5Y2lBV2cvR01VU0FZeU5XMkR0MUZhVnRNZlpYOHFkeWVBNVc5WGo5YnRI?=
 =?utf-8?B?VThJYXF3WHpXdWYxcC9Zay9OdzU1N3FGQy9QdTRGZ3UwVSthditscWI0cUhm?=
 =?utf-8?B?ZjF2SzBJNmx1d3VjQ3YzMVpZbmxTUzBlVUtyZ3VaZFZRTzVZbkE4ejNEZjZB?=
 =?utf-8?B?STFWcEVGeXczUUpiWWs1cENSTmFrL3NMQmZ1Q09haFN4VnZ1SGx6V1M3OHBB?=
 =?utf-8?B?SWhYZkdnTHVRMnk0WWpzZkZtTmNjMHcwSjVpYTBIUmJIcU5tSGtEcFV2Rlhs?=
 =?utf-8?B?TktuVmMxcTUyeW1kUkx5VCt2R3NiTmpVSmlzWS93VEhpSlRtYzZyamQvMlZv?=
 =?utf-8?Q?jLKJvrpD?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a1d53d-8fdd-4c6b-98eb-08d8c5ff7ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2021 15:47:22.6940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lHPkvD2WOrotrH0kfjzTpx114bU/b7G+tgvIbw1qf+ORXEo37hA4uAEh9BzL6CkpwukLKmjRT1X0cFf+kb757Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4327
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.737
 definitions=2021-01-31_04:2021-01-29,
 2021-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=918 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101310090
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101310090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210131_104727_926323_DE1C11BB 
X-CRM114-Status: GOOD (  15.88  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Yes. That's looks good

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Saturday, 30 January 2021 0:10
To: Grupi, Elad; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: proper handling of tcp socket closing flows


[EXTERNAL EMAIL] 


> @@ -1453,9 +1453,27 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   	sock->sk->sk_state_change = nvmet_tcp_state_change;
>   	queue->write_space = sock->sk->sk_write_space;
>   	sock->sk->sk_write_space = nvmet_tcp_write_space;
> +
> +	switch (sk->sk_state) {
> +	case TCP_FIN_WAIT1:
> +	case TCP_CLOSE_WAIT:
> +	case TCP_CLOSE:

BTW, shouldn't this be if (sk->sk_state != TCP_ESTABLISHED) ?
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
