Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F55CCD1284
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 11:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0lq57rMxA2eeohz1VbLqBRbw3vhQf9dD4AvnoImgGA8=; b=O8sO1aes7XH0YIwBpNb25vIb0E
	mz2/F1n82c3EOr+508U4Jk5Tvm7fXI5U34MflFWnlhkTyx3ib/4V0mH8KrBoB0TFs7HVvhkLVn8Yw
	TPnKN8ENB4ViUIXK8gloYSAl7a/tWebclPBbNPfjvvmfbII+ZZDhuw4AIoNgSur2IOzSqIzlKO8cD
	UZoS2NSN5Gf3Yft9OWjEyXxtyINqYD64XscXtKZmvhUOQd8/WOISPXDKk6nJXyBSAaCwkMbsqcXAV
	VGsIOPQ1WFW2hNlfEotovXjm80+jICdTfzROkR7F/yThqyyMs3PhBZSJ+Xdql6+QqNTPfzVSZtF4j
	hGcPtAbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsKws-00000002Jer-03l2;
	Thu, 04 Apr 2024 11:08:02 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsKwn-00000002Jd1-3Maz
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 11:07:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712228877; x=1743764877;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=N8xqOIqsN7USS+yE1njWsIfrNaF1AovoFluNHh7iuY8=;
  b=GkQS4dmaztVpa0q0W5E8RXffWY9N3IglVhW+ECxtbVmru7zu0quKGy6a
   vA9ztxbBt6QE6rDwlaS4BhDpaBpaH080owfggFDiuxVWTKg0ZLPDjGWQH
   prwck/1aYWitc8/J6jXwX/vDmQbOKvz3hSckHIC0N/nqCVBLafW9AxVXo
   X8i494IQCUk7YwvcxSsHUANXEvfDoofPWbEeTLswzLbO7h5YsLK0iiQhc
   w7iO4Qkaqln05vdkpm6Oak53S33Lg2fUtqlNS5fpf7c2ws0v2Cc8KEz2I
   R04Gvh0UxRchM/4+vG4gJ3B7l9FbyX4xv8Roct4eLYnpmVo9lGK5hJOEk
   w==;
X-CSE-ConnectionGUID: bRJWAeY0RAq1TuFSjm3Whw==
X-CSE-MsgGUID: OSA9FtsyQSO4BTIu6jzljw==
X-IronPort-AV: E=Sophos;i="6.07,179,1708358400"; 
   d="scan'208";a="13484033"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2024 19:07:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL3zdv5S+gFlDZ8ZaxtCJwoTikYdfz9TvaEQOJ1z+Z62E1ht+ZPa+2WFd0LpXPndBe7UnkHInikrQNw5uj8SaKjrV1/AY75Z2EPlGz/9KhKWfwqkch3y9LMMLVMT5tboGEBnDo/+MK4yxpMgLE2HbIJF4lflHhdV5PikcDBQoZ2F3qO/WOgOVoNaCQAFDDmwycqmuxAu3k/PrhKx0mf81FTRnBhzG1ZqPNT7Vgt5Knr+fgWyIQ08+YZoD6s0VXDRCN8Nji44q0CgKeC2sJgnoXgEVgcChSZV7ZxESdBaZClB2bQdTlppmlrsBQIs3aABwmNzkLg+z+Bi7X7OxA5/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lq57rMxA2eeohz1VbLqBRbw3vhQf9dD4AvnoImgGA8=;
 b=R8fTgjUBgSPY1s5rDXq88SOc7PYH65jN/0/akhQ3hjuslFw5/NRBIMKchKeTIF8NDAX2u/9+IWRUhr9hGTJ9IzmcpUHElYV9eYq046b1GTevx0Sog08+5ReFv7pyGQ/TmHKI1eGVdO+/aVCFBqe1E7285KsKQIrjauicSo84qtTd7HMA0yR0+FEeuqJfYVXC/Q3QC2+GTCwmJhAQtSXTUFOjy2B8U7T4ZJTupnYEPvfOwpDcKlCdDOaQ78KFzUwFyYa2kVx6I6riU5ONOEQ4JX3JfQeY5+W3r+x83lUATQyPQSKEITrfvLH3MEBUoFNlUrIMALLfAQvXovYiEJbZ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lq57rMxA2eeohz1VbLqBRbw3vhQf9dD4AvnoImgGA8=;
 b=TDJaqQaA2J+tacC+Z0L3ttIx651V8yJ3snRCbSOi+EaJJ/tbWn/DCnb2UY7u6FXEKblTMFBywGXEkqHDwHIaxjLQgS0eyYaZPUJTeAQXLWLXDSMsi/48k6A1kvuqQqpvMEIW2SGY57kvD4ex+jE1MMxAy6l05w8JpKqujl2/Sw0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7847.namprd04.prod.outlook.com (2603:10b6:8:3b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 4 Apr 2024 11:07:51 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 11:07:50 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 0/3] add blkdev type environment variable
Thread-Topic: [PATCH blktests v1 0/3] add blkdev type environment variable
Thread-Index: AQHahOUD7cM19WGut0Kq15XIUevcELFV/DcAgABEoQCAAXzpAIAADMcAgAAsVwA=
Date: Thu, 4 Apr 2024 11:07:50 +0000
Message-ID: <b4agkxjt4wtcvxlv3wkl5potagg7ct5dd7wl6aqy523bzb53qo@bq6ebuvnxklx>
References: <20240402100322.17673-1-dwagner@suse.de>
 <mqpuf2a7obybtw42ydte2wq7ktema5odvc3dqm32hknjmamgdb@rbo3i6lqqkld>
 <j6awxljufwg6r5rs5kojwsnatfb4aj3vnqsq43hkuuhgvcflvh@u6l5cf2ponaw>
 <w2eaegjopbah5qbjsvpnrwln2t5dr7mv3v4n2e63m5tjqiochm@uonrjm2i2g72>
 <j47jtsnraylush4xlxu6sng5frrawim5j2vjwt7zgei7jwi7ke@7ga6dd5sssur>
In-Reply-To: <j47jtsnraylush4xlxu6sng5frrawim5j2vjwt7zgei7jwi7ke@7ga6dd5sssur>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM8PR04MB7847:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hbQ3N9E8STcmxwm3/GYQhWGvDrtH2jZwxwyYnDOPWDDjBiNlLkJS44fOnaNDIIWeWVkqmqGL++9xDnBDrF4wE7vNSKNsuKBd6PC02ofiS8E6G47N44rKeGC1H0LVfq6bap4//M2Z7Zw5Ktoq7B0psmZlF/J4USyh0Z/Q5ngLr2FjCS+7+UGQKLTkn5DSv1VkUO/8oHQ7gbTBdCD3p1oEfv1BZYzf/X97hu6p1afX7jKUraDueWZLGVJsL5M2XDn0Er8Px0Q4IWiDQew/8q0OFaG7XCxGp35ixWW2HuFRP6vPsDte7aNqooMXCG8qg4ts3GQ1siZqJCPr62ZMDsnHbIpmj4Ad3r7jp7UICkL1t0ic1oV034HkY+egyimyETI9g3q4YiDR0Er/pEqIgZ/LXASWwEBU0iMt29lCVjp67jxN4liYzuQrl4S+nUxuzQDfh0g2YNM5jfKpNRhp1qaov+JxBO5Mog4T48R5gV053Dqu1hgA8XExDqydqmm8Aky+vdQMiVPQmg5+l7MvGEDFCVtWxWCBjNI8Ojqto1iV2sVbXUbtkiAc5FVSrVNayrtmMKMirBi4sZl6J+4rVHfVg62FOduJ+jKLO5GQ/DhXnS8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?belJuUyT8I/uQhZw7nLzbwahY6yrdGSJBe4h0TLtFmQDh9KkFZ2Tf5c59Zcp?=
 =?us-ascii?Q?e6gd1FV/XL1VdsKYam7sdFuBDnotKNvsgm2uZZ/9IbgWrcIenJdhIsFen7MO?=
 =?us-ascii?Q?O8Og2+q8tdEwUuu7PJ+VNIm5TypRLEikFYpVMXkma6LeVmGPgJw5tQ+ImlNE?=
 =?us-ascii?Q?JRWhtPooXqCEJl1U8tJgqdiwSYprE+chUvXxFCnz4f8tQ5N9PHnnhJkrQqMb?=
 =?us-ascii?Q?c3zuX78f835o4qeemGoiqhW3hOB0Jr7+6PVyk9UVSMpLXFT+ZvnZEKCKnuHQ?=
 =?us-ascii?Q?+k9CbI3Bys0LiHdAmybUExc4Jj6/qsMPB9Vi88wQ5zxfncVK2/coVtQ6tkED?=
 =?us-ascii?Q?zO9wWhpYiKV68hXbulO6ySfBmOYFoQmtHR0xzoJST8l7WFceJ2Dd5VxbXpo8?=
 =?us-ascii?Q?RMQgs8y8Tpd8rwTWPpSBmnvqRzAtPw0gmGv5I49y5ZTYqZ0+SWbWsnKbk5Dt?=
 =?us-ascii?Q?5fSOPRi80zQtHg/7xjZnbqXf2uWqlmss6uqu3poIJvJS54fVb1dWkmGSVaQc?=
 =?us-ascii?Q?8v+7RDLACSS7iMBy9PO1hVXRsvhs0pBP+Q4zZ9sjr4a7HFJJEdP4XDn5UWy1?=
 =?us-ascii?Q?HhSbgu7U1lUU7iQyvPOu/Nmtctx8ud0+xCbh4ffFVBqkc04pL/tBOa2olsLH?=
 =?us-ascii?Q?SdKCuhF5H7gz5TVR9EDuMH3671g4jIsa33iwMj6opC9PDARb0HKSa63zk0XA?=
 =?us-ascii?Q?vFDaqTCErKO6n2yduJN8zV29584vng743M1ycEtNmQA3FVQKbJrawg+i4Fcc?=
 =?us-ascii?Q?VjXS7APWDZ0WyNx0Y/BVBkMJb4yDYBKBiJ8FIFcVR4Xw2BubUex1lpAyeFXn?=
 =?us-ascii?Q?g2wNNtj8Xmi5jeILms7i1E5TLyjWe8g4xLR0t5BidKgtKUNgeYw71i2EWgdr?=
 =?us-ascii?Q?fwjWaFzsVdJ5506ZWWJBDE0AL5OqbtEKScwe/Hf6RXPNExhTEeVKq/+qGpN8?=
 =?us-ascii?Q?KwTLwfQYxYW850inQx/a6KafShTdHQKldI1Rj8JVwZkSajaSRaUXoGWtHKX8?=
 =?us-ascii?Q?HPybKyfYeIyhTkOpJt3rZKszEhdLDbYBjV9LfOVAQEz4EFvjHIpFrSEytXtU?=
 =?us-ascii?Q?c58096cGOl9PmHfdSlh8MKqORT6reHQnTazB4JJifuBaWrAdtnO2XbDUuRsd?=
 =?us-ascii?Q?80E4I/3ui30DWYABDNGoN0iJlXjPitbyxJXJ0AVIBD16rKZQBiA6VurgxhJa?=
 =?us-ascii?Q?bpjj7q5NLbKL09aHFojbbFjKo1Mio9q8jqBe3rfGJKpVqzBUGDxgHtbEkN4E?=
 =?us-ascii?Q?vQ1RXaZaUfYr7qIIJtgHMzq2eirNNOHxibx3TURF+ZS9yXAI06a1XloNBxyK?=
 =?us-ascii?Q?5CczHa9QPgsIWRkUoTbGaisrGHoVhfu1bFX2erFK9xzr6w6RT+SgJOZE2sSK?=
 =?us-ascii?Q?ZcVosiI/qcjSuzCvfALE1zJF7rJiwl/sXBauFLwb1v9KYWOZ/ffD5LuoNpzR?=
 =?us-ascii?Q?iThBmx1ayf9SysULKvCTFzxIUaiHGEWyfZPc1pZfzvVPpXo6BWshyhjKCWTI?=
 =?us-ascii?Q?48SHhGlmlT0Po9yU6bXS3GW+qjGGq7rO+OsLAvnPiapWk356k9EKWuTar9BJ?=
 =?us-ascii?Q?CUZFRx/ZmlECAwXY2IyN2Sq3L9EpBS4G1BJkCES2o23LRREqJLHYAkwiYpdZ?=
 =?us-ascii?Q?vNMBzXQSVySXfQocJULpGwo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B0C934D1A17FCB4EB40D49DC596AE255@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ccqv6pr1Vf6lur+dJeO24H/Md8EwMQjTy1VKDcN0bPVdVmNQuUu6us3pSlWcGwPtg8TLpRG2gDPSdF5CIaS2LxLV0FWRNj9dnAOfGlfnNkw1YczbSv2GuLzfj5uHMM1NvKYweAusqocm1DY43l6x/7apJwpetMkXUD6EqO8oZ7+a8x9VEds1W40DstnNAHr9Isgpn0kREOaYgAaZeBvJNBnth/pAXG6jmEw2dEdNmmrVrVXUJ0byIfmS8xhE+eMnZm6aGxSEWaWgmdmEQYlKxKals5Ue6aZsQrBL8Dlcp7NYP9DHauGOa/zKh5d5AcKWvuAvwliwFs2+C3ItPkmuBjdxWU8FHISCaSfZcd5diE7pOBgg39KH3x2LYyqF9zViQhqYb+UEOcPg33wGwyMZETTqwGg8Ylf29nE4QIU8jbHvdspNFCVVyO+tkqxn/bljq8pJL12YKjcMiKVzUjefEPwqBOArYf8rsXF1dkt4nk7nGyM23dVjUJvwU4o0HKBcLkG5/7qSHWuT1XvJFGAO+2/MtMSjn+3TC4ToH8XrJQ+7K0RkVoqHKNIc5T0c9cIO/RQX8CbbVL9zpt6kt+oNlWvKpCWcKWNxo2cxsop0OSqtdRDxFeet6LDyo6eUqpnj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd2c004-190a-4378-7622-08dc549777ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 11:07:50.8465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kKXh8ZKSzU0wktqr3QzzfOCb3Fx0qmblNC6cOkJBjO5Ubj5d27PQqq+yB/3ssRT0Odg1rBs139osV+CE7nJFdPoYjuQddVGVIKqlAuS0I2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7847
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_040758_067204_07BAF1EC 
X-CRM114-Status: GOOD (  19.92  )
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

On Apr 04, 2024 / 10:29, Daniel Wagner wrote:
> On Thu, Apr 04, 2024 at 07:43:28AM +0000, Shinichiro Kawasaki wrote:
...
> > It sounds an interesting idea :) I prototyped the common code change ba=
sed on
> > the idea and shared it on GitHub [*]. It introduces two new config arra=
ys
> > NVMET_BLKDEV_TYPES and NVMET_TR_TYPES. When these two are set in config=
 file as
> > follows,
> >=20
> >   NVMET_BLKDEV_TYPES=3D(device file)
> >   NVMET_TR_TYPES=3D(loop rdma tcp)
> >=20
> > it will run a single test case as follows. 2 x 3 =3D 6 times repeptitio=
ns.
> >=20
> > $ sudo ./check nvme/006
> > nvme/006(nvmet dev=3Ddevice tr=3Dloop)(create an NVMeOF target)  [passe=
d]
> >     runtime  0.090s  ...  0.091s
> > nvme/006(nvmet dev=3Ddevice tr=3Drdma)(create an NVMeOF target)  [passe=
d]
> >     runtime  0.310s  ...  0.305s
> > nvme/006(nvmet dev=3Ddevice tr=3Dtcp)(create an NVMeOF target)   [passe=
d]
> >     runtime  0.149s  ...  0.153s
> > nvme/006(nvmet dev=3Dfile tr=3Dloop)(create an NVMeOF target)    [passe=
d]
> >     runtime  0.138s  ...  0.135s
> > nvme/006(nvmet dev=3Dfile tr=3Drdma)(create an NVMeOF target)    [passe=
d]
> >     runtime  0.300s  ...  0.305s
> > nvme/006(nvmet dev=3Dfile tr=3Dtcp)(create an NVMeOF target)     [passe=
d]
> >     runtime  0.141s  ...  0.147s
> >=20
> > I hope this meets your needs.
>=20
> Yes, this is very useful.
>=20
> > [*] https://github.com/kawasaki/blktests/tree/conditions
>=20
>  I quickly looked into the changes. The only thing I'd say it looks a
>  bit hard to extend if we have yet another variable. But maybe I'd make
>  it too complex. I don't think we have to be too future proof here,
>  because we can change this part without problems, it is all 'under the
>  hood' and doesn't change the 'user interface'.
>=20
> Great stuff!

Okay, thanks for the positive comment. I will brush up the patches and post=
 for
review. Let me have several days.=

