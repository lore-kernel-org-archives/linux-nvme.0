Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDD0C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jun 2022 04:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mQexh/Q+rUR17C/DfzsMoG+835+OPPq80Bu+WwVIQ2I=; b=vQq9+qAFug9wMjW07APoOumMwC
	AJcEMdtcG/3eFp9UABWm3+qaSDHKSgaPMkBlIpWFqcCvsvONgh3q85Ee1y3BpbsuHfRgMMTd/H/DE
	q6TW/E6dYBMnmzTr1OiTtOQBYu3ya9EXddBzyBb8zYxe4MSd1IwadRs3DnB9mup1Cyur6B0ou0TgO
	Jvtap76QowBPsVrQ3ko+wc160TLX60SNgY9P7Mrigrn4+T8ksUwvmqA/XUyhQzIsXPr3EZliASs0S
	cPvZLYw8jCmBl1OAnvT2zgt5rtZTJ63a3vS/Bi/HRoO7V7esTBgW7nDygwtRW6rqV6TfUFIzYDL0B
	8xgynY8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1hKq-000PDT-W7; Thu, 16 Jun 2022 04:42:25 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1hKo-000PB5-Jk
	for linux-nvme@lists.infradead.org; Thu, 16 Jun 2022 04:42:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655354542; x=1686890542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mQexh/Q+rUR17C/DfzsMoG+835+OPPq80Bu+WwVIQ2I=;
  b=jQri1uFBG0QdXNYaq7Y81TD/pxEpu6TngEcNFt+MASjyCiTkhcYOXood
   LbexRLnsNfmTcZAVz7wazXOM0ZsAJs69skrV6jbGLRIecowKCwuvaD3MT
   7wg2yRPki1R5LMzP6JTw4juwWFqqmGMOy5Z7uXLEO+EaVuLy7AP9JuW1T
   zTzj9NPCBNvkeOhx9QsWut79F59hkxMe5DGQXq0l8UA7/2oaNnyngdph3
   evcatxNEOVP9lrW1lpFVmh7atNsiSjVvxC8HIBSyPVe6JPR9mc57BHvbj
   x+HGKuP8bxXmmrEd2T1ERFi5hYw//bZC2mbtPrvPsDsaunEFz/bM1NjqY
   A==;
X-IronPort-AV: E=Sophos;i="5.91,304,1647273600"; 
   d="scan'208";a="315371935"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 12:42:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9CmfYf8DPjjKcr2VG73CeC29ajV9H0sXlgbfEk5nGm9RgiiMXOQiBt4LSp+m8EJOsdX9EbM39HnpStNVeTTyKgwNacY6VXshkCBv5qaBFZMlCvSFJF2So7uknw387eK12U5JS4A6L19SARdcVm3escIT08/LgpQJvCZhlZRodTThRUTyTI+0OuT8dg5MoYZdL9besPPABYBu6Pl4sdAJ2lRD2GpdgzcY37FzsHf4UKmurBj4LkRKgCf5YrkP5+98pZ5t+uM/POhiaVSFJZkSXLmclP5qtAcFMzD+lJbNo/0ugkAerbb5tPajYwqXfZzBgV4HmaPrjTdiju12gwcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQexh/Q+rUR17C/DfzsMoG+835+OPPq80Bu+WwVIQ2I=;
 b=jboFqmmUV1XJcScaEea/OYvZEKfP2vksG84fIzz4A2JBLxp7/QEO88VsYQrcH8zNKSlDCFeocSg+geEeTlo4ql+7yWwZXwpEGQowPHwAJbUNlm2WUiZOOjWr3o5Rm9oqSlsJEpsvKJcAf+9C6M7OlzGWE4VUTKTuqj6/4bq1R+U5okr7WPRAbIy5l/+LJbqH0va5DagTlYY/c1gF1Lcy2Wq+m78+7ZsbApYz1uFX43q/E30V39elVVHxk0V88Il0K1iaymO9RmKXC4pLLs4KSCLvWVBQ2uPpSlIbIOmLILb5ZEvRV/DUUtCfajgTgJ2hYJ61xFka/FbhG/zJFLnSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQexh/Q+rUR17C/DfzsMoG+835+OPPq80Bu+WwVIQ2I=;
 b=opE2RCL3Vvr5rEfmQpsL616tR8COPfbtPlB7IHWJ3VQLIY3MNo2nI/nxMAZZOTwrMI+jkc8JLnMRYcFh1De2YuPMA/Tw3/g7sjxDnkPfEF1SRlXyU1fF2X9lHkrbeofNFwjE0YaT4JWeL+YB7QTBaKDM8eRHoUmrRDzufMNtmzQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB5291.namprd04.prod.outlook.com (2603:10b6:5:105::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.15; Thu, 16 Jun 2022 04:42:12 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 04:42:12 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"mstowe@redhat.com" <mstowe@redhat.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Thread-Topic: blktests failures with v5.19-rc1
Thread-Index:  AQHYfFwe8PMwMXtEZEqIJFDj8WJWFa1IXnmAgAACxQCAADBSgIAAJ8QAgAEp9oCABDqugIAAFNGAgAAEQoCAABbgAIACmtiAgAAlfQCAABQHgIAAW+OA
Date: Thu, 16 Jun 2022 04:42:12 +0000
Message-ID: <20220616044211.3c3yspyxfnay5q2i@shindev>
References: <20220615194727.GA1022614@bhelgaas>
 <cfaee02b-0390-6e1c-e26c-fa0ba3689704@nvidia.com>
 <CAHj4cs88gLYMMefQVrH_+kSsrZhV+VJa5yapEaYXc1Cjnd2w_Q@mail.gmail.com>
In-Reply-To:  <CAHj4cs88gLYMMefQVrH_+kSsrZhV+VJa5yapEaYXc1Cjnd2w_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b06b2a00-10fa-48ca-8d1f-08da4f529462
x-ms-traffictypediagnostic: DM6PR04MB5291:EE_
x-microsoft-antispam-prvs:  <DM6PR04MB5291DAF9C95D4746F6C5FFFCEDAC9@DM6PR04MB5291.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  E6ZXxG3qviOLjvB/F+XpOQ0GoiX9t2lovBjxxcxzylndh0E+KjfaYaRPqjFreTGyjpGlHq1vvZofBbfNEKptUH3wAksFWEbHmiTqqxmvZElwrtxSYr8juHiBsDmmehIhE6waBNFu/pBZY/hVWiylX/lb6AEHukuWm8cAoV++KpjE1r7bu7U244VuhsqNzCNQT+KWbIOBLUPtZkiZ9156pI2YjNj2ZFGEngub8eC6vO5zKMuQcBN3ODTzwpXMAKHKQiiQwtuCybUzQvoTG+gnoJ3ClhgAoqPxtDFPQP71o6OqP8PMn7qDL5weU6g2BixJNgTReflAQdyEa+xUIAuxN6iIXZJHK+9O9RtFTsTXW06ZwUazklfo1IQXfhXCf9K+h7TxbjU4giDB378K/LM6COcGD8Bxc/f8E1JJhXlvQLBzbwQp40ekIosIgvs1+qMh5szaAUySuveVBvGNSgE1HStdSVzwJpsvg7idfO53EWZxsqBA+S3sSuP0sz0qbbjY+q2b+czMBhXYHdQJSReh90r9bevNK+IO8PumHbmnQtGeI4zGTFWjiZ23CvAkR8V+MbXoDsw7IjZ/mvtSSt5QtAP+Dmj9cxtS9fp9R2SiqaEuB1pH+QhR2EP+FfHA07IIWEl7Y+wrudEicT7FOClx6FCTGqmlYJou4Ran5Y69W4NRY7NZNWT+KfvPUa0afKkNuDjePZ+nJxXzA7SsaoRDrg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(186003)(6506007)(1076003)(53546011)(26005)(83380400001)(6512007)(2906002)(38100700002)(33716001)(316002)(38070700005)(8676002)(66946007)(122000001)(82960400001)(64756008)(66446008)(6916009)(54906003)(9686003)(508600001)(44832011)(8936002)(91956017)(76116006)(6486002)(4326008)(66476007)(66556008)(5660300002)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?ePFrhAmb6XfHvF0GEzbzE+otwQLZDWR+itDstIQh1kJOI/q34bdr9fWK5CqZ?=
 =?us-ascii?Q?/DujtLMH0bNqbzCFYjKr8nr4fKY2h0K9mppfmIAC4qPA87R+ct7Cl5/j4ko8?=
 =?us-ascii?Q?qRNAzjIwAI/7xT1yICnJk6i6z0RFW6w4lnVJ3Ue8k8UOWHRiKlSTDFAeyDCb?=
 =?us-ascii?Q?8BQlluhH7K2mECy6qDm57JYyIMkFZ/9TusD1JdKBlcEEh8YD3Jj4gpVUHv32?=
 =?us-ascii?Q?2MzNw9NZpW/tmJ/ZfchGvg4srQzK1xKOJJyVELzSo+REzqjHAnnkXGO4qsNW?=
 =?us-ascii?Q?GcFLrQoRO8aFOA7eE0OJy9v1B0gEjKKy5Fx+v1IyP5OdWPwEujhUfLFKEiGF?=
 =?us-ascii?Q?HapLovMYLHkVHKGGmIZ24K7whFfjTy+XCaVsI84BGlKmv/tzeXZXPSohmX+d?=
 =?us-ascii?Q?MDo7+09Px5RNpWDnV5ED75XoVdLjqOOpQejBqB03BfMrdw67bow0WbCAriZR?=
 =?us-ascii?Q?u7GfOWG0PZnJEUd8QbKgVbwBbjP6VDuojfLpEAc6TnZeKskNZVge5oYAZFkY?=
 =?us-ascii?Q?oLyn1b0eTeyvNHz4zeL4JDMPCzmh78D/qYIzUkKGRlX/l0ulEqc+ZARcPzbj?=
 =?us-ascii?Q?gVj+QxDWbSaFDaDpd7GtIE+W/+UiROtHJhEjVlk4h5k0xLKdaRIcIR7as/qd?=
 =?us-ascii?Q?DmTiDaKsTpqYwFkZ/h7ur23fqZkiSV3B+uIgWAcEM9/Om7PPGOSL193a+50n?=
 =?us-ascii?Q?IVHS0uHBAv4tyYVYBje8htlQNiM8k5mvMSgPUNyPRfBjAjofYQs23TcyZHbA?=
 =?us-ascii?Q?QwISc8PSWO6PqixT/4eRLDsxW4O7XcU0QWr2tBuDz56wow8jiDsQB+2V7KRF?=
 =?us-ascii?Q?y1gqD70sNEHSBKYvc22Ru6bushI0qPbhT+xEO/rSoF4/RcKjQv6goihaJ9hK?=
 =?us-ascii?Q?F2O0OUREpVSJZl/vBIRzyt3QozmytmzEv2zmzDPGD6jY6H1b+2gjL6AcYaGf?=
 =?us-ascii?Q?WYXYTlawaLkiH9G8IRLTd6V6WT74Mb4eu0PAtWFhpugVFS4oFZMIEH+ONls5?=
 =?us-ascii?Q?F9puKinY5Ttc9KQpNm4m08u8pgUJwjzeHmCrg6V4bXEEUBUFD1a3zBPbVTnE?=
 =?us-ascii?Q?K4WFwkvRyHpfUu8gYTVMKFNt1IsMyMfTEUgyz/cOFrswTH40DlWCSerjNBuU?=
 =?us-ascii?Q?YKcZKQ2wKMTr3W12cOH+qyq7joUVkwrFCEfeqUeH/D2uDVDsgX2gvKKmF9bj?=
 =?us-ascii?Q?L4TDjI3XwxOjN082CZssZNd4P1B24wPWKSfQ8tWzEpTb2ANrT+oo8a5Y0nHd?=
 =?us-ascii?Q?OlsRAx2cAgdEp/ZHzNC+zv+lOGHX0vlOBM2kTgsZ4zB70pZqaktvVOuw831B?=
 =?us-ascii?Q?wsmuDc7YLIbfiL9QnhlFx/j1C9elXoMjcS514RNnJtqXxKu2YY8JyEDQz4p4?=
 =?us-ascii?Q?Feg5q1LiFoO1gipsVKKgorRml4JyfQBmkm6C0/6PpNJ/dsZ6OvmDZbwBrLz0?=
 =?us-ascii?Q?VQ5CPGk8CjOnZPpC4sMTaAW7OSZLOER88M+E7CSr+OMUIVsnr/TJpkPVoE9Z?=
 =?us-ascii?Q?Fu1q3bockBu4kwwChyYjj8kNk3wkEPAy0xixRcZ5ul4owJQWQL+LVbWw/3DN?=
 =?us-ascii?Q?MReezGHU7rIvWrD/KDRL7FAiCTJ0tBAcNuJOmRjf4g6ho9WSnm4O+iRqXHzp?=
 =?us-ascii?Q?JYgwB3CwIJMSPNYmBtx3r4ZVhsniPVqVlJVZ8AxnBp+oNh535G7tu17aj/Sf?=
 =?us-ascii?Q?Y+5ER/PpDmmzlEVw1lT9U2E5kb5hZ4eqhNVf6jO7Hl7rY4v15tVyuJpCW9s3?=
 =?us-ascii?Q?u+djNbS0yE7e53JV8JuRMR1fobnOu/V+zF+lqWcYaIQTATYDh51Z?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <462E6719A86A9846B6AC6A969E95033A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06b2a00-10fa-48ca-8d1f-08da4f529462
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 04:42:12.1277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYT5TSoCUAyOkunp/lXI18wzxQfaueyHniZzGFGfc8yKxhn4wX+ZTcRSeVKjRx3JHd82P/bc3U3NwCX2UdRuwn/nzZ1U5qQxrfzTunZ6RtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5291
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_214222_681177_3A62B20F 
X-CRM114-Status: GOOD (  27.60  )
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

On Jun 16, 2022 / 07:13, Yi Zhang wrote:
> On Thu, Jun 16, 2022 at 6:01 AM Chaitanya Kulkarni
> <chaitanyak@nvidia.com> wrote:
> >
> > On 6/15/22 12:47, Bjorn Helgaas wrote:
> > > On Tue, Jun 14, 2022 at 04:00:45AM +0000, Shinichiro Kawasaki wrote:
> > >> On Jun 14, 2022 / 02:38, Chaitanya Kulkarni wrote:
> > >>> Shinichiro,

[snip]

> > >>> I think it is worth adding a testcase to blktests to make sure
> > >>> these future releases will test this.
> > >>
> > >> Yeah, this WARN is confusing for us then it would be valuable to
> > >> test by blktests not to repeat it. One point I wonder is: which test
> > >> group the test case will it fall in? The nvme group could be the
> > >> group to add, probably.
> > >>
> >
> > since this issue been discovered with nvme rescan and revmoe,
> > it should be added to the nvme category.
>=20
> We already have nvme/032 which tests nvme rescan/reset/remove and the
> issue was reported by running this one, do we still need one more?

That is a point. Current nvme/032 checks nvme pci adapter rescan/reset/remo=
ve
during I/O to catch problems in nvme driver and block layer, but actually i=
t
can catch the problem in pci sub-system also. I think Chaitanya's motivatio=
n
for the new test case is to distinguish those two.

If we have the new test case, its code will be similar and duplicated as
nvme/032 code. To avoid such duplication, it would be good to improve nvme/=
032
to have two steps. The 1st step checks that nvme pci adapter rescan/reset/r=
emove
without I/O causes no kernel WARN (or any other unexpected kernel messages)=
. Any
issue found in this step is reported as a pci sub-system issue. The 2nd ste=
p
checks nvme pci adapter rescan/reset/remove during I/O, as the current nvme=
/032
does. With this, we don't need the new test case, but still we can distingu=
ish
the problems in nvme/block sub-system and pci sub-system.

> > >> Another point I wonder is other kernel test suite than blktests.
> > >> Don't we have more appropriate test suite to check PCI device
> > >> rescan/remove race ? Such a test sounds more like a PCI bus
> > >> sub-system test than block/storage test.
> >
> > I don't think so we could have caught it long time back,
> > but we clearly did not.

I see, then it looks that blktests is the test suite to test it.

--=20
Shin'ichiro Kawasaki=

