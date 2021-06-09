Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13CAC47095
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 09:42:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658196136D
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 09:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658196136D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=qFQZ/E4DO6ppMe7IXlU0Z/F8hecsIi5BTY9uHwozVKA=; b=u7aPOM2zbTpXWD
	GPNlf8ImLy+8ofl33l3d9wUEgd8dldspQyYXMmxjDikAteUtmU7edxcJXdSgi7sAG0uGVwDWJ4d2a
	mxCAuY2bSkeh5qd9f02iZ/dwiUS32xQ6Sr8GfPM8GNTXnIJ/zUktTRBPnpJ671GH3zBF6v2Mr1IU6
	vS+gtmKUM1AxGuV5pVz4oC8Dirx8vLE5YjDz+LNCQLM/kYGoMj+9KlL2EuckyOMU1TnctPtwhB685
	GMRtshtNRe9TAve8i3J1Sre2+sXwIruG2kfPA70pXfVgACeofHZ+kRdtNeV9MMFAuUqbH/MwppFn5
	OfGGF1G9qYa3zEA7ifzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lquii-00Cl5Y-6K; Wed, 09 Jun 2021 09:41:56 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lquZZ-00ChRL-Kk
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 09:32:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623231149; x=1654767149;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=vTRakpr+n+9vuvdK5ofqM29kzH9Ce9USlwqPVaOiU+0=;
 b=r4JZXBzUtTGBg97ySpBQf9XkFBnfoCEehR2CgcgV6Y7kDUD2sccZeVM1
 cgYa1g7spykZ17jzmUq+WPx271X5oA3NnB8aBHQURDQSBosfOkVa1GECg
 ixI1b1DMCONpH8FnwMU5FWJjTESHmi8ffiwUdHp+WraOJne8tINzKr3g8
 z2u5XWhQlkGiglXkYaBzW9rEPibklXuG89AOBvhr9/N2QrgSADbRHcusb
 1AGnpBD2cpfPMTNXeW7+PkNl0vTN6+blegrSqS8KGOWq4eSUE0xFWac6F
 v8w4ZX0lDZFSQ6ycokFSykt0piZ5LT1Z4nuxuCiUqTtbINUzfF9TaYAGs g==;
IronPort-SDR: qdlsusp+vgqWhN8v+24bFkpLBtb6/qyKCc0S2QmRJVAvBaB8gEaj99TQZyt7gFE9ymDUFSx1jC
 10NgDmI3ls9QKzIO9L1n6YVLdjAPaOcMPis/43RBCR33eeZJRHdHnbD4d5P1CGAb+HbEIGDCcD
 I3CcNtr10IvXbNPacGlpkFD0kuInrEU7Frkznw0a+loWFN1FZJZyx727kOrPxHd+fvJl+yTgq/
 n/7QeZaLvDUxA9WNxo9RjnPqHbbULMnEt/2Dn0SwekVqKg6Y+4CNHvaGxjApCZVZDDgz/Jqg19
 E+Y=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; d="scan'208";a="171282211"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 17:32:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3KjXSQvfuJo3MPX3N7PX3+9xAEQnRhnb9xcKSUyeqocXuFX3K0pAwqhOkCl8wCuzssC09sU/3+PM2+TZUkDVKcEQi4tbdf5NkGaT6+tIVTs8jnojDlTpl3sGPxY8mgy7XUZLnibwnbNOnAs2gM01hHXsqJHM5K1Lx0qwTcGvQX4tTWoR/AvrEr0j1rVGG4LK+H5zyRhBGHxIEGtlklclPSAvsd3sMwjEnQpeBfvXSzCU5UZX2sYJZETQPkWDUv5u9Y/xAbbvyxjTX3NMhV7RNAxJw4qjGQHHVzHJrx2OqtIb13r0qD6Zsl+FFmbZYN3b8YcfG+qH58WylP9yGQ9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzbGKkMrKJxYThWDcPlDvM+zgwb3KFpUoFa8I2QZHcY=;
 b=GieR83RSAA6eBUmKiwegFgEint0vgX7o5Y5HVOpmSRflWO5ELT9zWK0SY47Xcnb8gOUnx+swqLwvJPJoRxfjf9z22YHzbAEbtfMfEasob5zE3s2OcsQoe3d6+cWOFOeJac1xfI9NQ7cTQywUnAoDUyu0IMG7mRl4D8aC4hfWAFuFr5qEcfucTX9it4lQExG2mFKcytmcFYZyQK2RQr+fF/KE9EBkzncQvm/pFt1mmupTnlqt0qX667WspvohMnA26dquUiSYA2Ul19RKYQXZypXHmG2q17efMpgNOVkJtFfrv8YQrw3hDk+b9XklTCVT47iWVbzr0GbZv2vjTFbplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzbGKkMrKJxYThWDcPlDvM+zgwb3KFpUoFa8I2QZHcY=;
 b=qcWHl8Vw7fgrVcgDo90mvc4pvRTwZ/OWbagCXPJHidbW9d5IxfmZEQbGpgw89F16anxw5BIesixq7DNOwl+LWNdUuh5Ah9UYNJXvaMwyx4gSrin7i9wlPs04UsY9j0LB8ee1lYM3vqEGPViia2qcEXE55aTuaCBAcl4DrTPpRrM=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6606.namprd04.prod.outlook.com (2603:10b6:5:1b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 09:32:28 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 09:32:28 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 2/5] nvmet: add req cns error complete helper
Thread-Topic: [PATCH 2/5] nvmet: add req cns error complete helper
Thread-Index: AQHXXCmyCqaqIfmaQUuMXpSYDcg+XA==
Date: Wed, 9 Jun 2021 09:32:28 +0000
Message-ID: <DM6PR04MB7081145E11808E08288DFF3CE7369@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210608054635.5661-1-chaitanya.kulkarni@wdc.com>
 <20210608054635.5661-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:513e:a3fe:98aa:a7ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75b093a1-d511-404c-050f-08d92b297f85
x-ms-traffictypediagnostic: DM6PR04MB6606:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6606CA1681EF98C3F9024515E7369@DM6PR04MB6606.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sIpqvJyxudqmi0eKTzfgvDUNBypvqnq4tlNs551NW4B4rezXB3s3xljt6PNAnvDTU+Pbdi9L3KHwQflBO0sHY4CF5QI/Hv5fVX6QQXzEusROLQ/yomFU06Ev/+FgDno9lCtO7eXm60nEGi0RZufHcHXI1l9bUGbYvm9A2MN3RR3R6fRh2y0piKBJTT6MUSprZGQbMykic9jpoY6M0Yo1tFOaqDnsfQ0k8ivAFM00EwxZavsQHfmUoyHvwskdobV6dhpQpUsnSBTBm1OoJ63YhIsZrM6upHkdAkW8mgWhEtqFDtSsK9wGpAlPERs+xJ5MNPPRyLZhj/R2hgmu9G+NUtGphBPDo5KegaKlMrub8YTBrU74eMHiN7osUPS5iQ16q6skcPE6wiG/PsKIzi5p4cdMrolcp+TGm0dx06pABW/Apc6eKSnZ5SfTzUrfe/AUNFmvWxZu3btlLCHibiml/+ni7cgk0u1YPp7BVQcluatNJHRAsa0K2SQOBCE1XhXAJu0iDZ6qX+Oq1Fn8m1YUlEWGH38SfJuPFJE+TJjS06nvBT6DIGeaoWEd4igWfDU2FjwoDvj2y3t0+5d4sEDCHwLoleE66qPzLiK+fMd5Fb0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB7081.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(33656002)(8936002)(316002)(66946007)(71200400001)(66446008)(64756008)(55016002)(76116006)(186003)(66556008)(91956017)(478600001)(110136005)(86362001)(7696005)(5660300002)(4326008)(53546011)(2906002)(6506007)(52536014)(122000001)(9686003)(83380400001)(38100700002)(66476007)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d9rAgttVapOCz2vdBpNJAK/liCzv86kEDwCunXRLLbyOHnmTEeyMT2haOtP1?=
 =?us-ascii?Q?a8guPthjv1iWrUnaU31BY82iaktw49MaCDPo7Sg7Qr06/YryIS35JbTF1qjC?=
 =?us-ascii?Q?ZOHMuB+3bW06srlDlHUsbq2AoKs+QIlFzhwQCIYN6Kiodd6BnAIRuxEWNE9i?=
 =?us-ascii?Q?UKou/0q01NqCLhjI5UqukNiWN+byFFeQaKX/rg7n90hoqeYHmNnZ6e3JUOmj?=
 =?us-ascii?Q?HVUdD9bsG0EMjp0MibIrppIZkxPny8Bkc4ZBCTrKCZWwMWgmunUvWTLzyRzw?=
 =?us-ascii?Q?klDlGtuWJX7t32z6KMoUGT702RfodXWJoQwk1crrpEuXss79eeTyYgopDcRH?=
 =?us-ascii?Q?KW7eJSp6NpUKuAicD9nTdNTKhxiiPElKg0njfBJVm6m0UzmuaJ8vr00d412M?=
 =?us-ascii?Q?d+JvlNlJ3GZfIdxWV2DEgg7nGEsfKTyHo9UOpf4G+j9PON0TEi7hxLtp90eP?=
 =?us-ascii?Q?lG9tmvIPzq6v3aVctYdoS1U2boshAUfoSA/BAVMOOvoU4tPaUS4Hnxf6eNKY?=
 =?us-ascii?Q?7XXvSFvzy/xaId4h0IB7ddtIf6fitNqDhfrtnyzAkgdUBhEqxq5KxtuEL4kG?=
 =?us-ascii?Q?awBTZFk6lix0j8JrIl0cJ1UoSMGYdcDfxXG0foukjy39E1S/DwXaBE2z5H3Y?=
 =?us-ascii?Q?Sl+afWqEpOlKItUoq3I6NQ22l13tciaL2msN4D+purdfx3qcZqyJRQmJ2qNK?=
 =?us-ascii?Q?6z0msmdbEA80gEfi93aYM6mXRp6zVEsUyxlSyXEep2Cj0idZlrSlt1ruOJ71?=
 =?us-ascii?Q?iHXdx3sM+R/9uxXDHMXdVGyJR/v3DnT+uohjf0JzrVKREIvaaFmth1Qvkvo5?=
 =?us-ascii?Q?VzTNi9mKs+belrvi8HJpddqFsRHH3QaUt9q0CGJL+9ynPXvvu8mgdyJk0lea?=
 =?us-ascii?Q?qHg1LSMDnSgdYA15qiEeQUoIRmtTuxiWerltRFgwxijg8P2d00CVkw4JP06Z?=
 =?us-ascii?Q?aTEC/rso9vlQZEZQDzaqIJH9JueNzDiFhM+nEOxTwMQDs4Yd+swi5c3XhJAi?=
 =?us-ascii?Q?tx8x6n2dkoaRKNT4OHGE3B1QUDHrck/aUJAxAg2aZf01FgLEjEPO2OE8vHIC?=
 =?us-ascii?Q?SPPes9XzcZqJHWz+5s0L48Efo4D8PB7ahWsDy2vedWdDFyzjl/gYgqQjHFE4?=
 =?us-ascii?Q?Ncmqtr/8U6rNXlNH5gIDXuan1yD/Lrq/DQriuxTg2eDrKiUdodDY0TkvKBHN?=
 =?us-ascii?Q?hgagfpzwt9FkKky2mExErWGh1sY5OxCBta/D9Qq7SRTIHzDW1AG7g0CBiiEs?=
 =?us-ascii?Q?aGPz9Rurxm6g2fPqjd5W4A2f8goC+QpWc72CnegsX6Ijd56G2LD2EfJL5VqU?=
 =?us-ascii?Q?TfjDLIzEa6fV2TG7RrpA3uNLF2eqNeavoMydUjqgw4eoZHgyEZIba4Hl9vUl?=
 =?us-ascii?Q?HteiK7/OjirPJmMgqAJ3GNF2vQjWthDXeSsc6Sfq57Cw+sheQQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b093a1-d511-404c-050f-08d92b297f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 09:32:28.1976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IyeNw9o1/ZXkGMAIg6o5nsHDWs9b6atHGphJAdaxyn8Y3YKVkUCSAFjDNl9hGKYIWwOgxgfR6o/R2Ud203l+LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6606
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_023229_765273_537BF2B3 
X-CRM114-Status: GOOD (  16.11  )
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

On 2021/06/08 14:46, Chaitanya Kulkarni wrote:
> We report error and complete the request when identify cns value is not
> handled in nvmet_execute_identify(). This error reporting is also needed
> for Zone Block Device backend for NVMeOF target.
> 
> Add a helper nvmet_req_cns_error_compplete() to report an error and
> complete the request when idenitfy command cns not handled value.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/admin-cmd.c | 5 +----
>  drivers/nvme/target/nvmet.h     | 8 ++++++++
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index dcd49a72f2f3..94230803c75a 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -659,10 +659,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
>  		return nvmet_execute_identify_desclist(req);
>  	}
>  
> -	pr_debug("unhandled identify cns %d on qid %d\n",
> -	       req->cmd->identify.cns, req->sq->qid);
> -	req->error_loc = offsetof(struct nvme_identify, cns);
> -	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
> +	nvmet_req_cns_error_complete(req);
>  }
>  
>  /*
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index d69a409515d6..058b6d3d48fa 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -622,4 +622,12 @@ static inline bool nvmet_use_inline_bvec(struct nvmet_req *req)
>  	       req->sg_cnt <= NVMET_MAX_INLINE_BIOVEC;
>  }
>  
> +static inline void nvmet_req_cns_error_complete(struct nvmet_req *req)
> +{
> +	pr_debug("unhandled identify cns %d on qid %d\n",
> +	       req->cmd->identify.cns, req->sq->qid);
> +	req->error_loc = offsetof(struct nvme_identify, cns);
> +	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
> +}
> +
>  #endif /* _NVMET_H */
> 

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
