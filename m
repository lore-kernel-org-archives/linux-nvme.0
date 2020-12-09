Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBACC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 20:58:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B1223CD1
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 20:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B1223CD1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wLEKajKEK0Zhp0YTjS9QQtd7BC6rW0zZV37PZ2rnYlk=; b=ifcMJliBLmCL9P5S4zQVB//1G
	Wqu3OWdUEhGCRgHe6l+u/XJ2dMPjeU0pRbYnYmbgZRnELMZZx43h99LbVpODOWsCpQ9vvwuX7CHkn
	oCoTCXyWDmIfZPMz7OOya7ZexmdOM/x09Ft2uXucSaWEGv/GL99ljj6s++bCOM0eguaMiz54g0ckN
	dy1lfHQC3gjP/MB0isWpmh5pZrz6QMGzWeM38yMziSuvTrdauFy31/q8+ox1QTPSc9O3F6IsWfUlv
	FEkRSB+4JSgChT6gYcRC58yxqDADu4Yl8zIJYFEZAHtIt/YmLdJNRgZuvw0MPpBFd3fR2UVV0Gvl5
	3rGrJauzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kn6XY-000109-SO; Wed, 09 Dec 2020 20:58:24 +0000
Received: from mail-dm6nam12on2058.outbound.protection.outlook.com
 ([40.107.243.58] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kn6XT-0000yt-6H
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 20:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1n3AqsJow5y2GXoUS3xRsFoZ61ffqU+Y7pKrVF+adc9wqIWW7W67KlZGGiwSFwmEmtambuWS5gmUpIeRmGeUHp3s9GLd5ZTkcxpBL58i5TRNNw2HHsyRViPy49xZM7eUmOt3Hnlh+legPVBXpvgGCUAI3EhYzOeSEsnV5DzciK5Ys8L/6muo7SWnhUwQS0x+V5oiHY9gEdaEC8eJmItcr/P0oVXsI+yoU9UOjNS3NiDTZHK4zO/k3kfxGkNvhdvfxlsQz9n1Qy/88kmvLYvmv5g2b7j+wBxcKceAmvei836WeCos5ujfYPX6aEGDbuktGK2EaMbBAqD8U+ZrRzKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr6sN7GDXthEy87delzB/T6zFbI9VqlQh77HayrXPc4=;
 b=V6qIOnM6zn7E5T2H1JOr0C0VygQiarS2qoVYVNaEyIerZG6Z8V+pIX5J3Xl8sWVjHsBz6z65jk2H0OI7EuhH41fef3fIGjPDggNU+cqvAG+q1NPcY06ruV8DceToa3qZaTvG11eOFhLXz7H9yKYUpDbckU0SROItcbtngsUuPbE/gP2CsYylGX14t36cFHlsJaCROP+OAivHBEcnh2xabKxI6S+IMAkiIYdpkysbMxtpsNI8OrjgUUwPUekgUrpLxqy7BhNj2gOnjnUQVqflOOJL8/eJOG8K9YOzMQjvJ34ROso+YfjWQR4QhddxUndrv16nGpL+4D0G4PTka0A/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr6sN7GDXthEy87delzB/T6zFbI9VqlQh77HayrXPc4=;
 b=F9OceYEQNn/TibuXTWpGdqmvFi1BC0YeEKe5uuwGoUw8E4p3/v7Jb7P+bAexUIThRGum9tL0mOS9gMh3Y7tBui41MsdIT3h4r7IvJsv+e/AINrKMg7RFbb2ADADYNJulmaZ0YD1OkMi6hdCVwZcRiljWeSNOTAsJ+fvt3iogC5iEY51vOTNJqFVmb1LNoRQ8netHzJU/Eiv2kKSXQJxKjmKTHnViKWLM3hyc7cMrfDuhNv8GoXvXU0YFCNOFkaZcwBks9XFLYd880RV6yvqWCfgal+uH3Y5+DKpEgWo/nCdttnOFUjCJN82Vj7E3R2siNciB/1EAY6f2q8RSCxcGkw==
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com (2603:10b6:4:7f::28)
 by DM6PR06MB4026.namprd06.prod.outlook.com (2603:10b6:5:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 9 Dec
 2020 20:58:06 +0000
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610]) by DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610%4]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 20:58:06 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: "hch@lst.de" <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: RE: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Topic: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Index: AQHWvceZTKwQ33oCEkWHEJt+GYZ8+qnOUfKAgAJ1/QCABLR8gIAAWHaQgBYJ9gCAAAOmgIABtGiAgAACP8CAAAzlAIAABdaQgAAv1gCAACeTIIAAetQAgACBg7CAAAuogIAAAnCAgAAEx4CAAAyogIAACdAAgAACJwCAABmU8A==
Date: Wed, 9 Dec 2020 20:58:06 +0000
Message-ID: <DM5PR0601MB3624722C4C00B5A7EDB7E6A0F1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
References: <DM5PR0601MB3624104F7CC63DF394AD0772F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208214650.GF27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362434919691D589BCCF637BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209072806.GA10037@lst.de>
 <DM5PR0601MB36241F3E2F4BF6AECD96B72BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209155321.GA31729@redsun51.ssa.fujisawa.hgst.com>
 <b9c9e5f9-a447-2a2e-b687-304dd8f3d2b2@suse.de>
 <20201209161911.GA31836@redsun51.ssa.fujisawa.hgst.com>
 <66bad47c-0cd3-8461-3629-146778f15059@suse.de>
 <20201209173936.GA31971@redsun51.ssa.fujisawa.hgst.com>
 <20201209174718.GA19512@lst.de>
In-Reply-To: <20201209174718.GA19512@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [2601:186:0:56d0:5cd3:ab9b:a8f1:b122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 526a1951-fd82-4239-34af-08d89c8520e0
x-ms-traffictypediagnostic: DM6PR06MB4026:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR06MB4026BF86CC57A96CECACA01DF1CC0@DM6PR06MB4026.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DAwZwzoApw9XCyyWdH+S67Od+vcvFA7uxf9HUjY0V3oUMMGASARQ+h5JjNax8ELHoO/q5AvdPd2KQa8HzNyY65Sj7c4TL3NbT6OBLwGzxOcA2ZLMJoY4DqwjR/WbUL5mBUE+q6HHl0Yop5z4x07Xk8U1o5u2Cl+iagBRqs8ysNf2SuOIxnUKXN9JoRLDJBA7qVNt9wntwkCH6+pGdKDM9zkumBpqJv68D35kh5NsI9S0EicQfKMeMNxh8BvwWf6wPcgEVYcgpM85DXJIjqZc7OfX5CFwRvZQnkmxRbQkXmhlKeJgQGxpbZ1NbHAW+piKcah4l0ZobO5rhDGrOkGjaA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR0601MB3624.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(76116006)(53546011)(33656002)(6506007)(52536014)(66476007)(15650500001)(83380400001)(186003)(66946007)(66446008)(5660300002)(66556008)(9686003)(4326008)(64756008)(110136005)(54906003)(508600001)(86362001)(8676002)(71200400001)(2906002)(8936002)(55016002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: VQH+B5YJan7ayr7Gflu1zhIaDQZgKd8HQ8/+e6aii771S7iNhB58PLrmwm3pkFENDyJJ3KesUHF0EOPxTWyfMbBF91LDOpWRba2OEhvlGTwj8DMmFVWIn1K7ZoXB+bNrC9qFakZsSK33e3THknaiPUa2PoQOOhiGoZAEUHbwNAKSAMy6454qC3VQDIE2hJFo8M8K0LBxJnlxgUW1xUn7hs7BCG8JjATw+uneB35N/zb6H2Unpr19FIrZjGAdAGCy8RoPXeMfeHczaY3HtIk7Y4XwyBhJqDQYN/hLbU3Y08YFtQvABm23rbhJ5C49E3gT1d2Bdag0amxDTqKegTeCLjR/hwEOpQC9zOfMrXTVrWx+5wk3TnxKJWlkmtfOB3nraPNdy4Uvbh3we9yb48l3+YQ6OH/mGhHDZ9Qmj7DccE6W5eeTOqDJ0WGqIG3K0HFHrDGa5HbXASGBSCo4s2d6kJG2jWgjXxjCfcznGX6jWYhOdmk4yBZBCyTy6x2cFcx+SW/CvNvl0TTvCwSKhQX7lE4L2WSy8pxMKP+9Vkzi60V1XOEzH7yV4nyAjqVauVuHP0DUxpEW6p4Irc8WbAhIelCFn3FkjWzQGZ+YpCGFtNAeoosJoBroJPZN9DqytuSdzys1WYkNfJsIe778e9d8jTg6vvyEolZ9UcGSzrWmP8l3qW9Vs0HRwFaNEboT3mwpmRhUV9L2skFGKu0LClRpC1Dq4GUit6kbGS4AprMaqSDiALtaX1bVN3g+c2cAnBUkMAG9nU9MQkv6o8TUr/J/p44iHL/fpMY3R0KT9/fJEZ4=
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0601MB3624.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526a1951-fd82-4239-34af-08d89c8520e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 20:58:06.8083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOtKwJ4NQyvjhQfkyDoyx18DQ/BrderPYZCoD/4eLUl+1bhW7yfJIN9vK4UV1XxvBVXxSMxqrTn0CQVCFFD+Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_155819_638815_B573BD13 
X-CRM114-Status: GOOD (  25.13  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

"Deeper mess" - I do not know, but this DOES sort out the misunderstandings.  Whether it does what we want is a different question.

Create and attach are discrete actions in NVMe.  VS management tools may have a single command that invokes both actions (making it appear they are a single action, but they are not when it comes to how NVMe describes what happens):

1) Creation of a namespace (no matter how it happens) adds a namespace ID to IDENTIFY (CNS=10h).  This action does NOT change IDENTIFY (CNS=2h).
If we look at the AENs, the Namespace Attribute Changed AEN happens for a change to one or both of the following:
a) the Identify Namespace Data Structure for one or more namespaces; or
b) the Namespace List returned for IDENTIFY (CNS=2h).

Clearly, a create NS changes CNS=10h, and does NOT change CNS=02h, so b) isn't happening.  As for a), that is a little more murky.  Consider, that CNS=2h (attached namespaces) is specifically mentioned, and CNS=10h is specifically absent. Does that suggest the intention was to only send the AEN when something related to an ATTACHED namespaces changes?  Well, the exact text of a) includes CNS=11h.  CNS=11h does contain an Identify Namespace Data Structure, and it DOES change when you create a namespace (although, the namespace is only allocated, and not attached).  So was the intent to send an AEN for the creation of an allocated NS, or just for an attached NS?

What happens to the ANA Log page when a Namespace is created - nothing, therefore NO AEN about changes to that log page (it is only about attached namespaces).

Neither the Identify Namespace data changed AEN, nor the CNS=11h exist prior to rev 1.2.  They were added as part of 1.2 development.  I have not yet been able to dig out the history to see if there are any hints as to the original intent.  Is the a) item supposed to be only about CNS = 0h, or is it intended to apply to CNS = 11h too? When we invented  CNS = 11h, did we forget to exclude that from a) (did we forget to add the word "attached" to a))? OR, was it intentional?

2) Attach of a namespace (no matter how it happens) adds a namespace ID to IDENTIFY (CNS=02h).  This action DOES change IDENTIFY (CNS=0h and CNS=2h). That means the Identify Namespace Attribute Changed AEN is DOES happen (case b) above, and case a) above (CNS = 0h changes)).

In this case, the ANA Log page has a new entry added (either adding just 1 NSID - to an existing ANA Group, or adding a new ANA Group that contains the newly attached NS).  Either way, the Log page changes, and that means the ANA Change AEN happens.

So for case 2 (the attach), there are 2 AENs for effectively the same event.  This is where we are at with the existing text.

Whether this is what the hosts want, that is a good question. What changes are desired (if any)?

	Fred

-----Original Message-----
From: hch@lst.de <hch@lst.de> 
Sent: Wednesday, December 9, 2020 12:47 PM
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>; Knight, Frederick <Frederick.Knight@netapp.com>; hch@lst.de; Meneghini, John <John.Meneghini@netapp.com>; George, Martin <Martin.George@netapp.com>; linux-nvme@lists.infradead.org; sagi@grimberg.me; Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA group

NetApp Security WARNING: This is an external email. Do not click links or open attachments unless you recognize the sender and know the content is safe.




On Thu, Dec 10, 2020 at 02:39:36AM +0900, Keith Busch wrote:
> > The use-case I'm trying to describe is that the admin on the storage 
> > array is creating a namespace and attaching it to an existing 
> > subsystem, completely without interaction from the host. It just so 
> > happens that this new namespace has a different ANA group than the 
> > existing namespaces in this subsystem.
> > Then the array has to notify the host about this.
> > And the whole discussion is about which AENs this controller/storage 
> > array should be sending.
>
> Fred keeps saying the spec's rules for NVMe's namespace create command 
> from section 5.20 allow him to not send events, but it turns out 
> you're not even using this command? Why would the spec's defined 
> behavior apply to this proprietary use case?

I think we are in an even deeper mess here than I though.

 - one issue is the fact that the exception gets creating vs attaching
   and deleting vs detaching wrong, and that probably is my fault.
 - the other one is the wording should be shall not send the event
   when the creation is ONLY due to the creation of a namespace, that
   is not when a new ANA group shows up (and the way how ANA groups
   are created is out of scope)

So if we do a textual interpretation of the spec, the controller does not only need to send the ANA AEN for the case we are debatting here, but also for the case I specifically wanted to exclude.  Sigh.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
