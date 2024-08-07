Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB53EC52D6F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Aug 2024 03:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PpVmrLTYNd4S7KcvA1/vQwQWdC99+AddDx4ncTDHq2c=; b=Be2b3KwOnOL1cWbed4cAsR9mno
	bLe6+BPduvrA9X3/RC9fnOy9mKNznPcVdf+80K1Jyw5nVh4FnnRiyTmh6wx9L+3Qrc7FCUVINk5v0
	r+vEV5JvYVaG4PjenUbXseqlUhlYKSXYvp1/Vfdwpu9sJsfqRWb+E0F+0QpiqcrilycKELBS+o6R/
	WHJKoAXXYDcJ2O/KWLEFHkt1Ls4uYOH4wA60XE3oBi6g9KlvNiiSv8afk1z3Jj+SxoXaRlVlNACg/
	PWegZ9WwppK4+tMMlPXSmXM5OJOe2JpmbcRtY0JAqecrFOGKmoQu7v36YflUwGYmR+i55j3biopXm
	KtXqYwXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbXL1-00000003hvL-33XB;
	Wed, 07 Aug 2024 03:27:47 +0000
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbXKz-00000003huc-0tvq
	for linux-nvme@lists.infradead.org;
	Wed, 07 Aug 2024 03:27:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4nryr3oOkXGJQdjyXpD4Wao9MSUrhoZAco97drE7p2boHvIxPR1LlV8KA60fkskKr7PrG0Vvja29HwgtWadW0lKyImSAqXsubtDBNc5jCnVzl++s+bCt4yGXbGrP2f/Xp4O+UUAktVOfTOL9aaqjFHOOlSKUWYS+Mk3HlJYu8eFJchGHzLUeEy6ij08Epkjsm59+3nAcj3J4ssDgUbcdXMmdMck3xOzWp0Z6gOV6+LDXAQRVFAup/mbaHc8TMBy3jdmzrvU5mscAGdq4/JoTlzlH2rBAGsBQzPjvlJr1cStce8e6IK1UUO8nq6FtEDLH84sJq9p22fwdyh6xBa8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpVmrLTYNd4S7KcvA1/vQwQWdC99+AddDx4ncTDHq2c=;
 b=XkIWCgOfpRojFSGHOyha3u4JopxR98EdTEAf5+Qhkfsa+/J3gzTJCprTOTMIJFmCN0vgxHXSsgoBp370Erk5P0VW/uvJU8QdJ5d5IG9730qbB/qtBebDn1I+a5GUFBD2txdtgdVe8ObIzh7kkD3VUPnVU4CN2Qqven3UmtRDJVIeoAv9WPbdq7YUAHzJQxsSAU57TqDcbuT5TmzjFI4mtTprjW+owhg0m7JcxSZAn/U9R3vOHmdoOhjMz6csIOjABDqwWxAy1nb/+vZhlsjL5/UkGRkzrH6scsTEF4VXWW4HvNMtkd+7qdFQEZM4iOlV3eqh/cAC8IJfdVKWcHhHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psmnv.com; dmarc=pass action=none header.from=psmnv.com;
 dkim=pass header.d=psmnv.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psmnv.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpVmrLTYNd4S7KcvA1/vQwQWdC99+AddDx4ncTDHq2c=;
 b=Q8Up2QxGz6XuAPn1CYegpOqFrDzOz6T20M1ZngjTmn7ZhT3MqZFoNcTxv8phN6ZQybiIfWbHrp6TTlOmuWXh/k03HLIrJCnRVinCkrhUNRIGX9USSnsSmuFtZbW5OUmfsFH8gJ14A8yHZR3uNUGllAh7PoAjQRdB+63yr6pjAkE=
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com (2603:10b6:a03:386::18)
 by MN2PR03MB5328.namprd03.prod.outlook.com (2603:10b6:208:1e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Wed, 7 Aug
 2024 03:27:37 +0000
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b]) by SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b%5]) with mapi id 15.20.7807.026; Wed, 7 Aug 2024
 03:27:36 +0000
From: Eric Robinson <eric.robinson@psmnv.com>
To: Keith Busch <kbusch@kernel.org>
CC: Daniel Wagner <dwagner@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: RE: Disk Says It is Full But There's Nothing on It
Thread-Topic: Disk Says It is Full But There's Nothing on It
Thread-Index: Adrnh75MzNJkXFWcSMupUSjuDERcWgAbfTgAAAMQYXAADoXcAAAAtK2wAAxXa4AAAjAxEA==
Date: Wed, 7 Aug 2024 03:27:36 +0000
Message-ID: <SJ0PR03MB65018D5649C7BEBDE4B8B75CFAB82@SJ0PR03MB6501.namprd03.prod.outlook.com>
References: <SJ0PR03MB65014AE3AD77A352D0C88855FABE2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <zsyfgzmoyvjgvywkbkgtxchpfei3pyfcaf2mzu4gltraf34ymx@vocftyxjmedn>
 <SJ0PR03MB65010C717291244293A88CAEFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <vqbcmbet5jfbhmjfuhr66om2ta5lw2octpynjdzyvk66ok47kd@oj7vhatyai3g>
 <SJ0PR03MB650188563CEBA3B2E6D2130BFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <ZrLZs2ZpxcM1XcV_@kbusch-mbp>
In-Reply-To: <ZrLZs2ZpxcM1XcV_@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=psmnv.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6501:EE_|MN2PR03MB5328:EE_
x-ms-office365-filtering-correlation-id: 8a93392e-2378-46b9-a7e8-08dcb690e251
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dKbNN24/y3eVKhZOjyLCHOcwyWGMeCICD9p/P4ja9lR+5QFpyrqnwngqFw4J?=
 =?us-ascii?Q?McXPv87DGl1lcdQ/bPr4au+jM/90ZfGHMpUjbSaDkoDKlEZxOlon57TSINQl?=
 =?us-ascii?Q?FcRmAxA60sq4O1cU5HS4zR3JHKQAUJTrhwsU/Qpsj/PsgkX0y3jL5536pQ2X?=
 =?us-ascii?Q?xYrdb9gYZy1pXfyuGxYZ9n/RqRCvWWnosbhr+d2Sx7Wvb5VXOA0fSw1QC3+R?=
 =?us-ascii?Q?G0vHsT2FHsp5awCs0C++UMxOTLN1qO9IvAcTEXn8/lHG3jJBXlArPdkosEAh?=
 =?us-ascii?Q?W4K67i7B3K8qSUznZq9dvEKl342XGrvXfz4VGqdwuhvDbinoQwc/5pTP2Acx?=
 =?us-ascii?Q?X/KVH+TODhEnX/3x1iQ0l5AC3xfCti05yhExnG12DTK7fgYtCaLUd8mjPxdn?=
 =?us-ascii?Q?OFlYM19K2ZNIAFj0AeN+TMSG6z/D6XnA+tNO6sG96Xxwb4BAjoE7rAEB3Mwx?=
 =?us-ascii?Q?fdUsp77TgnrzOEH8EdEfd2+S+G0+T+tfNyobxe4tKfdZUj9WYiS4AdNHWYLn?=
 =?us-ascii?Q?exfPYJNs+uC6w8VOBdgH28MwLBhGVlwY1a/aiN87YMz1+weEh/1kWCQASuFV?=
 =?us-ascii?Q?md9oMC3zGNquVhqRDoE3ByqXoK+VRx313t0N1DHwOGU+0Lrh3xQvKFfIrN/n?=
 =?us-ascii?Q?l5MjJqJNk9iqJBWTVCE4+VwF/kHTvNpnRTqfb5EdTpXtAXrp/Zrtv07q8T6Q?=
 =?us-ascii?Q?uurz7tcYNZ7/WNzcnwy0ju2ls8FxiRVOJEq5qJZtSt1aLvYpXcsv9tkbx/qK?=
 =?us-ascii?Q?cTaO1NPkJylbVva7ZJzSgM2+1qmNXsI6W7+2a33Qk9oQCsBg3l8ENPd4vxZf?=
 =?us-ascii?Q?w+x6h+QMP/C8VcyrsgxlCqlt6IYWol3Atnb2q+aaajOQBjssXK03eut6SqMm?=
 =?us-ascii?Q?nLCKi+sPc7+EXhRr9LBs38vhSiqoyQ7YpPm2UjidPNIu9YQg70z4eVHIdywi?=
 =?us-ascii?Q?8eXxa5qfr+/v2q9qnqEpoA5aRMDOk9w4Tvc6ZqZlaWpm4zLd+G/o/fv77bpP?=
 =?us-ascii?Q?dq82IfDmqt6Fa0D1QCKlL6+YhVGfdpnH2MiFG6EgQMPLEznD4Ku039S8BUpX?=
 =?us-ascii?Q?b7/U2BaXGWJXpo2ddanxJlabnjur6LDzWhjr4+PUE5hXD2ET669ICGUJShXR?=
 =?us-ascii?Q?IM6ItSBzTiU/Dt71VwidltumnyoO7yAPBEM7RoBAVJNjfmkDBR5ohEq74BZj?=
 =?us-ascii?Q?kcg8HYRx5S0o7MmqUQ+mV1VNRsoxWnr35ImbEmuhldHqyQ9gPsT6gH/ZP65m?=
 =?us-ascii?Q?rHtf97H0d6X1LwiyiEKgZzG1egyaI8CAyhfmR7+0es1GDTd7IFs6U6wWyaZT?=
 =?us-ascii?Q?dy6CfDyT62iCGyDwol2RakLtbOHRvR4VA1kDcL5PKWKbrD6DZhHOIkG3BqKO?=
 =?us-ascii?Q?lVokReBFYdMLNPFzlD2Y99Ab2xBaiD6tZZjwqJXiQDp8uvuLeA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6501.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QVXt/lyVVv7KJ+AgYabgFBxeRN9y0cXoDR+as7p7xPXwol0egPf1Nmq7Gz1j?=
 =?us-ascii?Q?jIPwHuYm/XW0REMOo/FMGwmD6qXkdju7pUOZMH7C7gp0RQUyCb61I5JTFLwG?=
 =?us-ascii?Q?1vsqZGOlNiwjVM9GBRK5bv/U25EBgm3DqS/tg2/S1yqcBoMfDJp2SYFiVmxP?=
 =?us-ascii?Q?dW5vCCy3zZylJ7sGvkoH5UC5o+qgp70OR9EYLWAup3B240iq3wKTU0eaqCoD?=
 =?us-ascii?Q?0BFHPGdqLi2wLGzT7wstD5OEm9uDC6kBO0qKHvYrPkTnKksN1QicYIJVVSXO?=
 =?us-ascii?Q?RUYNDXN3N8I1Rhhirb+0JYVWHAogjde91L6YbKu7DgdEp4bmrCDH1RUIzHHO?=
 =?us-ascii?Q?Q+qX2ELZvnSCJ6lbehk47fhuVOjRFmz3simt2HUQQoYDSi3jn6tkFpTiznYB?=
 =?us-ascii?Q?SqvBsZYNOTY30Q6D9clLcQIK+2D+jYuk0jm65nhUW3eGvglv9eF/5KjNCPjx?=
 =?us-ascii?Q?78L60AF1b1VgtHV0PDsHJToxFLoqyBe7Rn6f/nvAGlSWg7poctHexk3ZGL4T?=
 =?us-ascii?Q?RAbQ7b5b1F+HUANBbyzLxPCW8yDRckdYVw40Yn/iEEUjdsvThC3D1xneXGQx?=
 =?us-ascii?Q?TnJ9aBSNChU1SfW46awjAlTRigNCRiau6HAVtAONCpPBKkoFsOnuDH5M93+z?=
 =?us-ascii?Q?SheHztprwrAfuk8GWqdS2ABo99+xwQDAzfu8tm725oYyzxuPkinX2m/gI3QR?=
 =?us-ascii?Q?5kX6X6Q/07FreKSZYwFYqVYKuH+BDn9cnSHRXNI7ZTjE8ZZveXp249SlAdOW?=
 =?us-ascii?Q?ESxUn7GA8YxMViCmFd++a1UWxAsb01KEVdFnAz5m/MEsfmNw1tl7Q9jxFxNF?=
 =?us-ascii?Q?xFZPVq+G40lZwbYykiGjf4MPmqsJnmzzfGP2XE3KBTGofz+0/BTXr/lNuW1b?=
 =?us-ascii?Q?8vfRPZRX8xJs4qly0RozOEbBSSI4Yse/JjhATHIArlwPD3AxrZ2mswmUDPCe?=
 =?us-ascii?Q?+n+SxtJorSt/6asK7ba/0+htGfIRAlnBcpuVuoLcKCrmED2iPapx7OYP+QwG?=
 =?us-ascii?Q?vJuaOWBgyyateMCfycp3kiUzNsl+pxt7ZJL6MliqYxQKSlnxY/CccDU60vaH?=
 =?us-ascii?Q?RlvE9Kbp098appfK2BBc3YqpDnA+cCIsC7rXW3WeYKa+k7BAIp9/gtoTUCfE?=
 =?us-ascii?Q?Edp8RvAgZ0U1KZ3kEvlBTY5RDtWMpYJMbi+FbPAEYIveODADx5AypG95MIZj?=
 =?us-ascii?Q?xgNAIKDJekozK9Knwg2ZHaCVuaFKf/3nvdsHe5y8TKlYm9TcCjyyjc1iYuOD?=
 =?us-ascii?Q?4sHHGzwDbeEV23sF2i4vEnYSt0DeOEOagov8khvocENGXMwVRqVNP1iIj4V+?=
 =?us-ascii?Q?qXOKimFxMOxPTvB2sRwLYhjx8OvskCWVaNWSQh2+eqs26E3IuowNYbj/QvJd?=
 =?us-ascii?Q?sEptXSuQbKUSqQvn3mXV31KArxS0LHvQMgRizreKi6yTedKsfQhf15L8SewK?=
 =?us-ascii?Q?X5jNX69TQ16qQaQ+W4flWjGwYFpWFkqKVhLsVbf5RNEgaFxSc1q1KulQbwzn?=
 =?us-ascii?Q?jOrSlX4g5mhyyZBYD9MLJ350oN/ByoITtZwOIQVLUqk9P/02hn5eXvXtDtGj?=
 =?us-ascii?Q?0BPtzxs6XGMPy2aw3ssr23DBgW3CI4MKiR8Dio90?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: psmnv.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6501.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a93392e-2378-46b9-a7e8-08dcb690e251
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 03:27:36.7841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41c01403-a265-4172-8028-7972e133fa87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zArr9/pY9qMBYRH38gz99HJhlliXG+xgaqNsoBr46zwrmCg2/qBUR2z1HSHKa6fVSpLxizPMpg+9Uo20L2e7IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5328
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_202745_352343_747722BB 
X-CRM114-Status: GOOD (  22.07  )
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

> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: Tuesday, August 6, 2024 9:20 PM
> To: Eric Robinson <eric.robinson@psmnv.com>
> Cc: Daniel Wagner <dwagner@suse.de>; linux-nvme@lists.infradead.org
> Subject: Re: Disk Says It is Full But There's Nothing on It
>
> On Tue, Aug 06, 2024 at 08:28:05PM +0000, Eric Robinson wrote:
> > > someting bogus (nsze, ncap, nuse).
> >
> > [root@store11b zpool0]# nvme id-ns /dev/nvme0n1 NVME Identify
> > Namespace 1:
> > nsze    : 0x6fc400000
> > ncap    : 0x6fc400000
> > nuse    : 0x6fc400000
> > nsfeat  : 0
>
> Is this after a fresh format? If you've no data on here that you wish to =
save, run
> something like
>
>   # blkdiscard /dev/nvme0n1
>

That did the trick. First, I issued the blkdiscard command against /dev/nvm=
e0n1. I then ran nvme list several times in a row, and each time I could se=
e the Used column decreasing. Clearly the drive was doing cleanup. I then r=
an blkdiscard for all the other drives in sequence. Each time it took 24 se=
conds to return to a prompt. At the end, I ran nvme list again, with the fo=
llowing results. It is obvious that each of the drives is going through a d=
iscard process.

[root@store11c ~]# nvme list
Node                  Generic               SN                   Model     =
                               Namespace  Usage                      Format=
           FW Rev
--------------------- --------------------- -------------------- ----------=
------------------------------ ---------- -------------------------- ------=
---------- --------
/dev/nvme0n1          /dev/ng0n1            6240A0Y0TCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1          1.18  TB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme1n1          /dev/ng1n1            6240A0T2TCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1          4.37  TB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme2n1          /dev/ng2n1            6230A0N9TCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1          5.92  TB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme3n1          /dev/ng3n1            62D0A0FFTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1          7.74  TB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme4n1          /dev/ng4n1            62D0A0FPTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1          9.24  TB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme5n1          /dev/ng5n1            6240A0XNTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         11.04  TB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme6n1          /dev/ng6n1            6240A1BJTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         12.63  TB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme7n1          /dev/ng7n1            6240A0Q4TCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         14.04  TB /  15.36  TB    512   =
B +  0 B   2.2.1

And then finally, after a few minutes...

[root@store11c ~]# nvme list
Node                  Generic               SN                   Model     =
                               Namespace  Usage                      Format=
           FW Rev
--------------------- --------------------- -------------------- ----------=
------------------------------ ---------- -------------------------- ------=
---------- --------
/dev/nvme0n1          /dev/ng0n1            6240A0Y0TCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme1n1          /dev/ng1n1            6240A0T2TCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme2n1          /dev/ng2n1            6230A0N9TCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme3n1          /dev/ng3n1            62D0A0FFTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme4n1          /dev/ng4n1            62D0A0FPTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme5n1          /dev/ng5n1            6240A0XNTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme6n1          /dev/ng6n1            6240A1BJTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme7n1          /dev/ng7n1            6240A0Q4TCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   =
B +  0 B   2.2.1

...success.

> or
>
>   # nvme format /dev/nvme0n1 -f
>
> and see if it changes. If it still doesn't change, then you need to check=
 with your
> vendor on the discrepency because nvme-cli is just the messenger and fait=
hfully
> shows what the device reports.
>
> In my experience, about half of nvme devices always report nuse =3D=3D ns=
ze.
> LBA allocation tracking is an optional feature that many devices don't do=
, but
> since you apparently have the exact same model and firmware that shows it
> implementing this option, that's just weird.
Disclaimer : This email and any files transmitted with it are confidential =
and intended solely for intended recipients. If you are not the named addre=
ssee you should not disseminate, distribute, copy or alter this email. Any =
views or opinions presented in this email are solely those of the author an=
d might not represent those of Physician Select Management. Warning: Althou=
gh Physician Select Management has taken reasonable precautions to ensure n=
o viruses are present in this email, the company cannot accept responsibili=
ty for any loss or damage arising from the use of this email or attachments=
.

