Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6156C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 01:23:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6834961159
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 01:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6834961159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c0nV3ieLSlFS0fj2mNIF7hPEunDNjQ0gITSL75VMVW8=; b=WgzKnhaxAI5UnE
	jwZWUoVH+Us6tQ6qi8GU7ecoR0T/vI2m0YZmnbUkqRZPWcgSTvYem4AwQSxwtvkBTPZbehS+orr03
	4wgBil6OSr9Nnll25SRzCMdXZ3Iv3sn8lnOnFhZYDk/tOyyd47X6Pd6KsWe9C8izMwaSKGtIPqpdH
	lTRlpguuWhHg589zyNmi/7Tvi7MUqspfk/vymz5zDJEzI+n9dEiEgkM9rXgAXJIqm/7xg4sTKn6cd
	lMBVs9gFRHn+6rT6Ma/Y8ft6FQcB8Za+PbDsVIrhFuY4sl0/EzinXYfsDPdzIhMKGE1G5J1jK1e+A
	tABLu0Ti8rpvdFn0uwmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSqyk-006U2o-Rz; Wed, 22 Sep 2021 01:23:18 +0000
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com
 ([40.107.92.51] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSqyX-006U15-Tx
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 01:23:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGjIqyPL5zYDA7AoOC8ZPqrUMGPbb74WJvCnOoi1ptaWT2uR9G3pl4z6BlYrSMLC0whBNvbLE58Xy5/RFwjVUYgQon3C2swuQgaWl/drMyxFxVz1593wRGQ9DhvjmxxSPM7p/m4xa5f/e9D1Q/02bwJ/ss9qB2HlacT16+VINKB6aonQ1X2HGoZ13oqgsGtoMj9xzUdIqUAQtseCr2Le35KX+CV5oFM9OOGCZ8QljMxreg0opiq7fGN1kTrZwxaVhYo5189wmAWzjbOvcqWe2vnsGLK8lhobNxMCNjCusf099JcwVC8jilhYSbNNSU+RuLBOCm40MlD8GmyJ376Ruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=MeGsPEnu/Qj4l3Eg2cLIO1ueC5owdkT0CVHmPTn7DPo=;
 b=d6cVZQ8JniAoLwo1B5/ALdKFzPXMdy4p2sqZEyndBjHo2LZwVYZO6UU/MGUyOSkpD+e8Nz63+DaPPD8ZBcOE2PASaF55kSHPVsb0NywQfgPEe6J2JJERXxupqdxXJHI8FkMs7FjidikdIkIGfVUxXeXNceNEm/y/zBmRShVb/ketZ2j9FIO7NzsT22R36tFQxsTX9UmhZp3qr1pOisUumLmZLj1xNK31sn1g0SlrzRPV8ga+zA3M4WIhanpMLLcce6O2Xh5JaDtOuKB9CMH5r2TsINKhQqFGGUz9eGzsfs6nPZ4vYyoOa3zJbxNdFKFIsBkFBsYIxP5gpUYPlP0p1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeGsPEnu/Qj4l3Eg2cLIO1ueC5owdkT0CVHmPTn7DPo=;
 b=YkjMDhH+5QZno1cCep7y0RrT6RHfOnzY06cGrl0AO14VsfnK9PzCe5hXoMn4qedQTtP2ePc9KyCMhFnKuTB7VxWfnFx7tCdkK5gAj5H6KaRGvlODoD9+DRsjfL4WQwtZeoVvmSmIWEekY0ll6uvaMOn39ZbMDKko9jG1tob4piG5ZoCZXmyJMvwOJIlUtVk+3otXMEE/S26hxFVd+J9CTRBydcQOgIqWd0QYez0pVcFttT04Dd8gnhTg9Y19ztxqKSrRbPvG+9ZzBzJLuVXubMI8QwzGGFhm0s4VoBeCKRm2dOTIeMVbGYxGsZpC/QyMq21DuARPnqnof1gPZwnujA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB4665.namprd12.prod.outlook.com (2603:10b6:302:2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Wed, 22 Sep
 2021 01:23:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 01:23:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/6] nvmet: set 'CNTRLTYPE' in the identify controller data
Thread-Topic: [PATCH 3/6] nvmet: set 'CNTRLTYPE' in the identify controller
 data
Thread-Index: AQHXrvv+NC/859MakUqKlUuTTf7kUauvQs0A
Date: Wed, 22 Sep 2021 01:23:03 +0000
Message-ID: <0afe1307-44d8-50d5-13b1-1939745dc2a5@nvidia.com>
References: <20210921151529.29419-1-hare@suse.de>
 <20210921151529.29419-4-hare@suse.de>
In-Reply-To: <20210921151529.29419-4-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8413eae8-efe2-4833-341d-08d97d678615
x-ms-traffictypediagnostic: MW2PR12MB4665:
x-microsoft-antispam-prvs: <MW2PR12MB4665F5AFB0600584C7568220A3A29@MW2PR12MB4665.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zOgkVjwlbtXZ+IjGMKjZEcRdBQ+D32I1Krp4F/P0NBmHF48nRoXmJ6iLPAskupZt5aWfPtqBdf+g1kh+dCK+r40Hkk1/g5OB9haVc+ulQTFnrvrVbbgvcAm/jbXrdJoRiKEWtHgbKW+JSdxgwgFkpe4YwMIT6p+NkRrRqG7fUhGDifq04FMQ2spl+Wca2nPBWPz7SM88uokpQPJRbpBiaRoWmqpLFdi03WH6mfh/Kvn1BsYUSSHXMo/MiU29ds7Aj5pF0T8FcqS1EXXvpjrV8yeJVDTvXIyC72o15MGyHsBgqTtOdp/WCvXf0quS8KPMuquj61VTuOKyIzPew84fOABGfhnNTFF22SKtfoZRhSPQ/RDR0WmdvGQ5hOsEtNgz3VAfaiW0t4Oa9UQoQLcsNn1oG2EHTIWxueXWLGR6uak1ipWCm2gbAHhtnctdCbnpw9hBzp2C5D1AeBbXFaYzesEEmd23SsYuAA4fgtIBHdEs1hBkKk63tkYi9eGrAy2/jLxEl6TRhhxLDhBHdKmTagiMunJKeliUAH3dsJVFI/iZMor7T/5TXJXSnYCs9UkFgd72szbzBIfK/mp2iwJlfBC1s3m7YyrMB747tSBac7a8RoMaNVQ929rW6m+MwqBKCv+DGixfr04qPEuSu7thlI2hMnaR6jxXJ4eOZxt/P4uFrpVZIFbGV0R85iBW9lhmg/Sv0MPVtI1nw5G8fP4VX5WItEK2/Vjj5s6+NZg6F9S0NSmpQuNLb2OtD9sX61/tPU/QPpYKegDiB+n/JIO4Kw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(4744005)(31696002)(36756003)(6506007)(4326008)(91956017)(26005)(66556008)(122000001)(2616005)(508600001)(316002)(53546011)(186003)(66946007)(8936002)(86362001)(38100700002)(2906002)(5660300002)(8676002)(6486002)(71200400001)(6512007)(83380400001)(38070700005)(66476007)(76116006)(66446008)(64756008)(54906003)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVhpMlpZKzE5Vk40dG42aW05YVpab3NLa2pwa3dwZlFUUThiejdJWUFQYkE3?=
 =?utf-8?B?NTVDamRza2JwWWR5R2VnL1pnZWs2dlV0RjRIR2VNZjEwMlB4Y1pMZms3eGlR?=
 =?utf-8?B?VmlIU2YzcGliSW1OU0l3ejhhc0JQOXN5REw0czR6akJZV3BLa2VCTGNzMHo4?=
 =?utf-8?B?S3hzamwydkNxWEp6WEEwa05JbzhHOW91WUFUelpSQmVrZFJ4eFFMWmg0cVVF?=
 =?utf-8?B?MHRBMFMyeE1LZ0Q4ZHNuOC9SY1dCajYwb3NkNUFUeFRZUU85RXdjR1hpcUJ3?=
 =?utf-8?B?YmJOWmw3aHJlcFdvSzdSMkRkZlRLdHpNVHdwQk4zVVNsaTk4UFhUZTUxcmU4?=
 =?utf-8?B?Ukd4eE5CaDNDeEYxcVR2Wkp0V3dXV1dxclphanVuVzFnN1JzT2EzQkdGRkxx?=
 =?utf-8?B?YzJhTmZTa2xTa0RGYURFaDdyZnY4Q3JlR0NDeVFROHFkK01WTkFoVXZnaGQz?=
 =?utf-8?B?dlRIelB4NEdueEE2OGUyTUZaTEtHazNoREVQRGdja1hmbitLQ1pTeTMxNW9D?=
 =?utf-8?B?b1NwL2g0cHVPNHlWQVluOUU0R0ZGMXZyckNMYXVDV29YTEtkU2JyaUVRVzIx?=
 =?utf-8?B?TEUvM0pDbVVUUW01c0ptZFM0S09BQnAvSHRtcnhnY0xzYWEzTkg5OFlIa2wr?=
 =?utf-8?B?YVl5QWhkT3dwU01ITk1VVE5MMWtKRUswSDlTbjB6cS9YeDIxaTFJdXAvVkhC?=
 =?utf-8?B?bFBCc3h5YkhxY0ZCak11eExPRnFoV2xHdzQ3NktIWnl4V1ZRbVRKc2FzS2c2?=
 =?utf-8?B?bDZvQ2FYRVdFRTNFYlIxTnhZTXJJcVFxRW8vTDg0RXhQdmhCMEJ6ODJrcjJt?=
 =?utf-8?B?RHdJUzU5Vmd3OUEvT3ZuWVZxemhjZUxocjVxajM4QW9DM21pNzN4SXUvZC82?=
 =?utf-8?B?cTlKUU9aMWtGV1VnbDdoVjNiQjlaSjUycXA5MVlRVm5GL0p2QTRidFhyamcy?=
 =?utf-8?B?OGE5dmxIQW5GSWpQNmRpMXJINWphRHg3c3VYSStZVXpVQVc1Y1hRaExEcEhW?=
 =?utf-8?B?eVVSSk5wdWR4dFB1dkhzL20xT01nK0FRMGs0cjdKaWk3NGtiUUJnQ0dwTHBr?=
 =?utf-8?B?SDVJRzdENjZmUHpRcFgzY2owblcxRVZubUQ4ZmRab3RwcnBneXVaQmpFNUIz?=
 =?utf-8?B?eGtuK3lxOXVXY1VRNklyeHdxRVVyS25LYTRrR1JOYUduajdic0ZyaHFCS2ZJ?=
 =?utf-8?B?ajVQUG9pZURCNzYzVTFXaTBHZjlKZDNkazBjU2pGVGo3ZlJxNE1xZTV1TTZT?=
 =?utf-8?B?MlREelZNdERpV0JhZmxkOVRSd2FBdXkxV2VEOWh3Sm5kbDNybUkzZFVnbHdE?=
 =?utf-8?B?aWQ0aHdjWGQyWXNVc0ZtWTRaVG42bTRFSjVoT0Nnam40cEhaWjJvVmtUTEhz?=
 =?utf-8?B?Kys0aDhwUmdxM3IwT1BBREZBWDVuT1pVMCt1MFlmTEZsclcrUTI2NEJNR0N4?=
 =?utf-8?B?WFdKZjcva0Jtbk1IbjFPbkJ1aGhMM09pc0ZlbkFaRGxyS2k2UFg0MGlPaFlF?=
 =?utf-8?B?NXVpMGlac0NhZFVObmkva3hucFVXdUVRN2FZWkhaTHYyczNTTUM0RVNDN0Z4?=
 =?utf-8?B?WmFjZDJITVo3by9LOFAvOURSZGxyMjRWRGNENFAyZk9oc0RVSCtCaG8vaVJX?=
 =?utf-8?B?M2xmOTM1RnVWUG96b1lHQWpZellpN0lScVdhTHh1V1QxTW1pYzM0TkpVUzc3?=
 =?utf-8?B?MXRSd2ZYZEl6M3FPSUVhbE01enV1Q3Z2QzhzemhZVy91b3g1dW81dHJjVWF4?=
 =?utf-8?Q?YiBpxjLT7dS1m3hU3Dgd55llm7eOBfaqSi/E4nh?=
x-ms-exchange-transport-forked: True
Content-ID: <A220A35443904C4D9DE2255723C66B83@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8413eae8-efe2-4833-341d-08d97d678615
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 01:23:03.2776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F4vHrvblkAhqa2/gbAiEcnE6OUO3NEN9qcUobePd52wyMZbCQ9WVQNe7eakjIFkxv7RWvHyrNeEroQ7pVKCtfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4665
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_182306_013699_7F1BB556 
X-CRM114-Status: GOOD (  17.99  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/21/21 8:15 AM, Hannes Reinecke wrote:
> Set the correct 'CNTRLTYPE' field in the identify controller data.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/admin-cmd.c   | 3 +++
>   drivers/nvme/target/discovery.c   | 2 ++
>   drivers/nvme/target/fabrics-cmd.c | 3 ++-
>   3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index aa6d84d8848e..8546bae5244d 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -374,6 +374,9 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   
>   	id->rab = 6;
>   
> +	id->cntrltype = ctrl->subsys->type == NVME_NQN_DISC ?
> +		NVME_CTRL_DISC : NVME_CTRL_IO;
> +

since this check is used on more than one place in this patch,
why not have a helper instead of opencoding that makes code easy so
search e.g.

bool nvmet_is_subsys_disc(struct nvmet_subsys *s)
{
	return subsys->type == NVME_NQN_DISC ? true : false;
}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
