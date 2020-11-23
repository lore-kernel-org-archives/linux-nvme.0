Return-Path: <SRS0=38m3=E5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8346C2D0E4
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 19:29:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323EE20637
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 19:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dOMLqXbl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="Wxpcr80o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323EE20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FE+yx0NJ2onVf600xdQ3f/d+2beWY4lCY5q8EEmbxoc=; b=dOMLqXblymSGhZv6zt4aSkwyn
	t1xIjjg/4oABNt7N/apRvpBw30MaXIPo1aKdszqAyE0odqcpS9t6KJaMmVjy/NC3+V8+HZ+NUTzX+
	pxDjRfHqXDFc9xdhZJJEiHueBVOyM+14Wm5j/Lf/F3quU6mBzXg4vLj8zQEfcw8dL+nr8+2H8ZWMN
	4xOxiCwAPI+mhH0QSfarsUFE2tQdOyNkFTkgMLRprH7U1bAtdrmbFM1gxtnCDoQ886wwVsBaMEnzy
	n//CuLVBcBxvNFr6N7HMfSXY2EJtai0pTHEQJG+a6UXPmRy4yoN1NpfgX4jdNzKD0ULOI08yWoL0j
	FpwiIUUpQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khHWT-0004wU-MJ; Mon, 23 Nov 2020 19:29:13 +0000
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com
 ([40.107.93.53] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khHWP-0004vm-Bi
 for linux-nvme@lists.infradead.org; Mon, 23 Nov 2020 19:29:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k69q8iS9Klv58ioiptg3xQ2AGS6SXHnV9YvAECqxOIIepS+i/J0bXASbyYtFqxziAVYT2vkL1FHAz+uy0Ba9sPRJbKCTfDdQTZdx4j7FGVLYXVJDNI7XqD8M5jwrTJXFjpnqFjVaiT3fM7dn5oh+2FdJYEe3q9buxGSSKnGgpbXYH2ITBRHg95gSYMDRMYsNcckhYAt8ge3LqB3N/Ud01mdcdbOZ5OVd5eYVS3prNTkPjBdXTtRmsszyoKqqVPIonBMEfcnteNZBbwh9NnDmedl0bvPwlNL2XoSFGSqKKpUNq82w+etGTadWRvq0alp9uXSBH4FlwkeymaC2M5h+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbMJB5rlmUeR3pLSqJc/YsfE06N2qBH5Rz/WJ3a/IY0=;
 b=XnpHhPsUJSUGsoRNFXAcPIor0rR+gVwZfihloiKMrf9LJwHZ0eleFBTy+VgvenkVj5YMbqJKKiw1qc4pzuwVCMPXn+k04TMMSZFhOocfDCSCgm7AGfEA/dTGpPYXJP+5Bbst/yjqoxvrAlBueTxoXHeXvGTQb5LWrtW12EWet8ahcErxOR2MGwRcDNohESzs/vc7ke0nrcLgVULjhcktFz7J3/tT97wW61oSCkf63Va6AtQOqcyqHTtZIbA0xHFvCOWgYWdB+eHjj+/mFHiq55IpUGeDRQEylYfNIZhsDmM57Zn7yqZ2ai+rBvPv4dMCqQtYSQ13HXyahEMJFv9r3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbMJB5rlmUeR3pLSqJc/YsfE06N2qBH5Rz/WJ3a/IY0=;
 b=Wxpcr80ov+sH2oJztbMFbaYOXHWPNneQy4Vrb3qPQVtEase3INQtVluP/bc+ZyIy6vb/JBnWASZy1L95gIipWAuHn12j22zQxam3s9EOc06losOrhyNk2dOsKPSJuui7Onewgh4KRJZ0T4zNmlV0ix+LXCXvxsD1+LCNY8c1wxM=
Received: from DM6PR06MB4634.namprd06.prod.outlook.com (2603:10b6:5:ff::25) by
 DM5PR06MB2444.namprd06.prod.outlook.com (2603:10b6:3:58::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20; Mon, 23 Nov 2020 19:29:05 +0000
Received: from DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::e84b:922e:adff:146a]) by DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::e84b:922e:adff:146a%7]) with mapi id 15.20.3541.028; Mon, 23 Nov 2020
 19:29:05 +0000
From: "George, Martin" <Martin.George@netapp.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Topic: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Index: AQHWvaDZ4On1YeAvk0yKbnb0IwXxeqnOE0GAgAA+/ICAAnYAAIAFOsWAgAAb/4CAAAOKgA==
Date: Mon, 23 Nov 2020 19:29:05 +0000
Message-ID: <d50766c203d849fa97003ef9585af47f059dc42c.camel@netapp.com>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
 <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
 <20201123173611.GB2865091@dhcp-10-100-145-180.wdc.com>
 <f2afd4dc-dd4b-d7d0-7421-11daac94b61c@grimberg.me>
In-Reply-To: <f2afd4dc-dd4b-d7d0-7421-11daac94b61c@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [202.3.121.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efe31ad2-a2c2-43a2-88e5-08d88fe60a5f
x-ms-traffictypediagnostic: DM5PR06MB2444:
x-microsoft-antispam-prvs: <DM5PR06MB24442119BF20071A2859160B95FC0@DM5PR06MB2444.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zhFE7IYZ+mR5MqmNnNk4M5FSgZH8M+yLerPr36v9DaSAlXo1hvcQTk3H+WwyF8sycG96QwKuR1Vj9qsp8XNBSa9wBliYyGuK8IUk7Ze1odCgbtm8fzUCO5/cFEFWgVt5cPjFunzqLNa4608qxAVlLVRUp6l1IhEMRFBG1rmfjbW5csr2AvbTO2mXlNeoQcblYuZL+l+TtYQXvP7ZqZDS9FBrRUJLdHsK/sIg2ijpi2Ye2eVFWnCF/Z6yUdpr/DU5u2KAwR4ymeKZi6R6xYCyT22dMyZrs/2V9Hb0JnNlUPU+Y/BbvXsbv5DTsuXY5nLmjOSoaJXJ/VVON5B2bVLniw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR06MB4634.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(6512007)(8676002)(4001150100001)(5660300002)(4326008)(15650500001)(6506007)(26005)(55236004)(2906002)(6486002)(8936002)(186003)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(91956017)(83380400001)(54906003)(110136005)(316002)(86362001)(36756003)(478600001)(71200400001)(2616005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 10MwCVfyjWmAdO+U9qoSWCFDVge+Kfeb5EEG6Fy748cBqr94pNzbcmWBaLfPNcYNOvQ/6UlCB7L/Id5+fMiaYnTRYnKrNFd1XaDWmX3k512zDsCTw4U08jRJ6aRwvs5RBw0IxxpgrFB67ISEvKGMfGSasEIQgLn8DD/CVtY5LS17fMzk+rWQo6BVy6HiJJSjfc93EGbkECcImc0aorp3tX8CXtgYlFeEedTTygr628b0V+nDv5fjdNpRvo38lozwz0Us6LbjFkGMR4AjhDpQFvB9XSDTKnaRzfSIhgARE8hh2ItuL48KQDH6YwmvsAFp1ru4sHXVQLzDZkfs0pm02/sjVtrMzmbQb7WXL+JTRymV1uWeWfWacBaL21PXYBwUrAGMp0S1l6BaQywvUw2YmKddrC6jL09QlPGqPZdjO78QrTmdMPMMzMS+YSAHGpa+xplcDxDrYYADsaepwXvJVsnx7TNQY7AV2AdKRbwXQS4xv96Lmogox1EXkEZapRK3WdKXiQXk7cUMS6gY202uyHftYWMsnURP5q9cXFzvBpK/hLi3wz3EZ/3pDGsaKl8IHGwS/FLbFyDTQfdLas1yAnuxfPOOloiQR4o4wyQFoP1gnggQWJxBk6eS+gHLx+blRD6YNjLx3meyG7VGO49XmVnXGdukyOO5pnfWPqv/U7EXeBZNpn+2N3/bYi2TQz4uJqVLe9VtnLhK3p4j9T52HfABNUT2tiYagA1mkZA++PwBt8YNR/aXjEko51952xCHtlZNSsZMSJHST+gmCwX8UIQ86/OckuRAV7vKHR/7NmVh0vgy3y7c+Z26esAARK5+CqSQgYMGR18kTslf0TuAlILXybU3uJR2LS47SOa9OauDP2r6BpBzwDcKHrMRQqXQ4225onUrMLbCMQ73Ij4Tog==
x-ms-exchange-transport-forked: True
Content-ID: <B74260589FD85747BD8E43B60B9A9FD0@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB4634.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe31ad2-a2c2-43a2-88e5-08d88fe60a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 19:29:05.1128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOzUnUw8oQ33x/yOYq8CZp8HwvSi5u/Fiurz3BJMPKC/mqCSj0K9sA6kwdcG/JidZhRwzXUzJuqxirsnWxuxng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB2444
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_142909_540634_8C898F9A 
X-CRM114-Status: GOOD (  27.60  )
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
Cc: "anton@lightbitslabs.com" <anton@lightbitslabs.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2020-11-23 at 11:16 -0800, Sagi Grimberg wrote:
> How can the namespace reference an ANA group that we haven't
> > > > > been
> > > > > notified about using the NVME_AEN_CFG_ANA_CHANGE AEN before?
> > > > 
> > > > Well, I think that could be possible for a newly created
> > > > namespace,
> > > > which happens to belong to a new ANA group. To quote the 1.4
> > > > spec in
> > > > context of Asymmetric Namespace Access Change under the
> > > > Asynchronous
> > > > Event Information - Notice (Figure 147):
> > > > 
> > > > "A controller shall not send this event if:
> > > > a) the change is due to the creation of a namespace (refer to
> > > > section
> > > > 5.20); or
> > > > b) the change is due to the deletion of a namespace (refer to
> > > > section
> > > > 5.20),
> > > > as the Namespace Attribute Changed event is sent for these
> > > > changes."
> > > > 
> > > > So it looks the NVME_AEN_CFG_ANA_CHANGE AEN is not required
> > > > here for
> > > > such cases, but instead the NVME_AEN_CFG_NS_ATTR AEN would do.
> > > 
> > > For the newly created namespace to beong to a newly created ANA
> > > group
> > > the controller first needs to send NVME_AEN_CFG_ANA_CHANGE to
> > > announce
> > > the ANA group, it then send NVME_AEN_CFG_NS_ATTR to announce the
> > > new namespaces.  But the new namespace can't reference an ANA
> > > group
> > > that didn't exist, that is a separate event.
> > 
> > That sequence would have a group with no namespaces, which I is
> > okay,
> > but we can tolerant targets that don't use that sequence without
> > much
> > difficulty. This ought to do it:
> 
> This looks like a good simple solution to me...
> 
> > ---
> > diff --git a/drivers/nvme/host/multipath.c
> > b/drivers/nvme/host/multipath.c
> > index 74896be40c17..300cff8c616d 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -667,6 +667,8 @@ void nvme_mpath_add_disk(struct nvme_ns *ns,
> > struct nvme_id_ns *id)
> >               if (desc.state) {
> >                       /* found the group desc: update */
> >                       nvme_update_ns_ana_state(&desc, ns);
> > +             } else {
> > +                     nvme_read_ana_log(ctrl);

Shouldn't this be nvme_read_ana_log(ns->ctrl)?

Yes, this should work and looks clean too.

-Martin
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
