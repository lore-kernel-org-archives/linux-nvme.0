Return-Path: <SRS0=Onny=7V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1522C433DF
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6802420810
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ogWogBpR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FAjE61M0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cjpNJL5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6802420810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=h4WaI7mFud5pWUxBSMvn73t7n3F3vuJjViKxJZFWYsU=; b=ogWogBpREO2gRM
	duYrDRaklU4MrZebcUD5pQTBM7sBFJoH9RlTC4L2WSct52ZbHLvtnqjG4f1jmS/v7UUc9HwmcMNUi
	/+ZhPZptK50qBdkPbcV8B4etyalp3ZsTuGeXTErMYt0EMPik5Gxsbh7JloLWr+C7tugswyr51OxfE
	yz2LnMivTKRKhMbRdjObOxVzCNxYwi0SkKgmEDissIGeu6VkuWV9FuHHdYw1gPRt1B72qwIUwMsJS
	Fy1uVyBhn5JkeYABHEbvghN9mxf/w0zCZsFhvO0r7hYVYPn2LtyDF6e6xbqTHtD2eJJtFxsUCY3dO
	t9+BChUcTs6ac7WrwiNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ji9sH-00048G-LM; Mon, 08 Jun 2020 04:59:05 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ji9sE-00047U-Hm
 for linux-nvme@lists.infradead.org; Mon, 08 Jun 2020 04:59:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591592342; x=1623128342;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Fse0NUdbCAGlaNCmGuxUajmmlhUU8v7vz3VmA+WI3HQ=;
 b=FAjE61M01zHN+aoCZ3gYmXnAogrRbsTtId2yUkqGWh+GAItHqjsm0It0
 JruK6RX412g04lHVmrjI8LLtSD1PIb0rkno61IGTBlAsUJBEFXfTcrJCn
 JsV3eqK0vgjXFQYHDv1DivHUMbyg4VABf1+tuX5Ny8uWh4gYlFTG4H6Vf
 SXKzzt1OMVhKGrrXh21qB7oQL6XPtOaVbVJ0eeCVndyvZPtbhKKi9Yad9
 dAXeZBR+7BQpspjSNhLf7nP7ED9oHD4JJ7j0q5iaft4FRllXV+99jzEYj
 ADR1AvI4dfMXgWwg+2fQ9pjMaXyJ/E1cgLNOjmI6V/6JY6Uw2/GN8UOgW g==;
IronPort-SDR: I7kR4EvR4TuSusdLrDIta54wUey4iSGsXiziBGEWPKybv0vrgOsXc75ZEvo/nKWD+Lddpxh2nv
 asq+hpp4wWuKdV0EMfc66BIhSybwHKTVm96JubBdpnx8zBjjE0ySBovWA0VQTej7lAEkjM0CxD
 f9r8PJtNzXoW3J/9os5xSEW3HGOrME2SMCRstZFW05a+hnzXRS/PA25lo5aobbqcU6ha8sNEsv
 k2DfSAELbwjuvzzykCjvA08Yzkz9QSy5pwe4Ily1zc/oJf9FYRUUsajzEnnOi4CVdc6soTWtkZ
 Icc=
X-IronPort-AV: E=Sophos;i="5.73,487,1583164800"; d="scan'208";a="248547666"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2020 12:58:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9QobndJXw6btjQb4Q5ocEaDNqHMpaF9KHwcaiNVXqOHA5nmwUw+duylnFQ+4Fd5A3/0LKeFNyf2sKnkOuMw3bfL+MKHR/ARuC8uxs5JEWzeVW5sDZgS1GK6BnP6e7FN00mYQslKmLQk9wFpMtMJicXLkzuEnKDC8vLeZIB8kKIZ7PcmrKRhX+xgC27d0nqWuTts+poFCA1y79jgMfmT95OBuR8ubevFPl9/V/5lQul+37BuMssw1CsManAc+DqIR5SBb4z8/EH+uKymDzns30fyF2lVVCd0lrqVENnndZjb9OnRPG1UQLxnhwzkWQ/VJ971Nh7+Id7H0nwRYwizRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntlW0PbmUJpBQXVH6Pz26xzabuBxR90w+3t8XfeQgH8=;
 b=hTVd0jjYJFGtG9r7cN9jslhyPLQ9Ub3U4wvIXfq7IqAxvW0mKn9/+LlTVvIP3lpAKzD5sm84iXyKbad62K0Tqy1cDDB+Hx5xxlSWMN0EgT5bhMqjXxzrAYZnh8s2T43wGEsV7QZYtZOfwiqeuwgzhQNBrlOnQXcNq0szqwt+3gYWsxA/Iiip5lMRjoQbUwX6CcknZ0GA+ufz/pLiOZOqnNh4YyWiEwvVPr98KwjgiwbI7UjKsBHDpeW5hPuCQoOw4IZrqYeGP8BreOs/DcyC4NrO52lIaGKj6Fo/Ih0NT77uMSN+2S7p2srAEBaBaM/j3EKzqynPCEm2pRSXh7ul7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntlW0PbmUJpBQXVH6Pz26xzabuBxR90w+3t8XfeQgH8=;
 b=cjpNJL5MPVVHasMde6Wr48pmHJ9/0zF6n1kGQaBfvL39pVzMgnw6f1McwqdY6mLP+41PVJrs46tYs6SXW+W1YtXNFXFIZ/Ngf+/bxaJFG05qO6zWGnrg/K9HgiuUEWEN8M8kKUSAWzNL5Hkh2nN5lYZCte4g0XveKTDOIdLrXeY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5416.namprd04.prod.outlook.com (2603:10b6:a03:cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 04:58:56 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 04:58:56 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: blktests test nvme/003 fails
Thread-Topic: blktests test nvme/003 fails
Thread-Index: AQHWNIJZVRL6ENIo6Uy1ge01JbudSw==
Date: Mon, 8 Jun 2020 04:58:56 +0000
Message-ID: <BYAPR04MB49658EAA5D722230E5036DE686850@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <a2b9e92a-f499-b54c-a275-c08a23467866@acm.org>
 <BYAPR04MB49651040C77627E3A70FF86886880@BYAPR04MB4965.namprd04.prod.outlook.com>
 <fddde27a-eb61-7031-a067-5538e0fe3243@grimberg.me>
 <BYAPR04MB49651CF1169CD33108A484B386880@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR04MB4965217373E87DFEE2398D3F86890@BYAPR04MB4965.namprd04.prod.outlook.com>
 <96530c68-0cc0-8b88-4d3e-c2a66be44167@grimberg.me>
 <e110c297-a357-5e8d-754b-09a5faec7399@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a318a32-1f66-41f9-480a-08d80b68a65d
x-ms-traffictypediagnostic: BYAPR04MB5416:
x-microsoft-antispam-prvs: <BYAPR04MB54162BA969B8C4CE7026E40F86850@BYAPR04MB5416.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AapmQcKfMmgmz/8bQphIvGWC4dpJAppoeisFt3FpioyU0qOVzrhBLqfNBKfssFljgJZ6nRlT2m71C+E4Q0Cy1ascqnxS1GrIz9iU33Efa/50ejcNsj01J23pCKYTzISbZs7gsrNuz1Cs+Z8315oWD7igBYlF6/wMllJXePmwxuP4DZTiWkONXpwgqMso9M3wOIs/s3Y4TVyL+EnW5Sf85uDzLeohaD6GPhwL6qY3WWP0LPg9K5hHaoB+2BqPhpYsynog3Le5SGTYExhh5LSCs4Xd+q+i7tfesCDPJrGciGViOvrG3uamCejwzOhmPEp4DdGDuATPcG/8puXjPf2NGSDiUJKbrS/95SP66oz7RfL85XrYsn7kOB1HyiZL22XR4AMwMxtitOMFTLlZDwO20o3PlU7JURS4/W5DyGISUy9/VREOjwkEAcJZCUxUz3f94MQhcqPLmgYGyMAr/3frLA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(71200400001)(2906002)(66556008)(64756008)(316002)(186003)(6506007)(5660300002)(26005)(6916009)(54906003)(76116006)(55016002)(53546011)(66946007)(66446008)(9686003)(52536014)(66476007)(8676002)(4326008)(478600001)(86362001)(7696005)(8936002)(33656002)(83380400001)(533714002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: vkIW7KCXBjt37HjanyIdk95t0b5imkD46aBwPS+nUvwn626gTRQWpx4OuM8kXTfHBgNEaxUg3/ceDic9vN+oPLaX5r5X8IaGqKxlZXRay3rjyCzDJX2DgL4UcfF53Pjw6xsl4GnIBatkx8MQDW34z98mX2GG2FrUlmM4ZgHmt98LtOkaMtnCWRp9Pl+hE5hIdmw2wOraHQoZa05hSed1acWjUX13tFQbKZXYABAiKH/j6s+U8QcCzmqQGBembRADTIFiQFY9EQinp1vwn0wKpQ89C1eatjHOgdmgSubo7mg48ecg258KzhoBIC/BG+AWIszzuc2irwdBTqRfLxLBipl6BXRSPsH7uxCliCnOZPSa4uvh2g11wmiybFvbKDV85NkD41ODMSJzcU/1h32l7zor9VtO0kRIv7zh8QE/8ULr2hyQU92/SZ+z/oEEdGgp2tEL3U4/FJN20Wf6hrWxgwk35vgDHuxGjCI9pw2XTyc=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a318a32-1f66-41f9-480a-08d80b68a65d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 04:58:56.5702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NB/tivlRXrTik5OszQEkxqdcEdEigVD81MzaSttDqyoh71ET/YOo7fyaNgcz93M7a/+kC5j/9Qm/eoHIIXJVV+dhjayXJxJ7hsYGUgNgvfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5416
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200607_215902_655941_7A0F3BFF 
X-CRM114-Status: GOOD (  15.90  )
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
Cc: Bart Van Assche <bvanassche@acm.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sagi,

On 6/5/20 4:15 PM, Sagi Grimberg wrote:
> =

>>>  =A0=A0 void nvmet_sq_destroy(struct nvmet_sq *sq)
>>>  =A0=A0 {
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 u16 status =3D NVME_SC_INTERNAL | NVME_SC_=
DNR;
>>> @@ -786,8 +800,16 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * If this is the admin queue, complete =
all AERs so that our
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * queue doesn't have outstanding reques=
ts on it.
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
>>> -=A0=A0=A0=A0=A0=A0 if (ctrl && ctrl->sqs && ctrl->sqs[0] =3D=3D sq)
>>> +=A0=A0=A0=A0=A0=A0 if (ctrl && ctrl->sqs && ctrl->sqs[0] =3D=3D sq) {
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nvmet_async_events=
_process(ctrl, status);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Target controller's ho=
st posted events needs to be
>>> explicitly
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * checked and cleared si=
nce there is no 1 : 1 mapping
>>> between
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * host posted AEN reques=
ts and target generated AENs
>>> on the
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * target controller's ae=
n_list.
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nvmet_async_events_free_hos=
t_req(ctrl);
>>
>> Call it nvmet_async_events_fail_all(ctrl);
>>
>> I think the older was better though.. Can you send the latest one to see
>> it side by side?
> =

> Are you sending a patch Chaitanya?
> =

Sorry for delay.

Here is initial patch with modification to [1] as it had a bug which I =

fixed here that clears out outstanding AENs in the =

nvmet_async_event_process() :-

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6392bcd30bd7..843da121cddf 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -139,12 +139,26 @@ static void nvmet_async_events_process(struct =

nvmet_ctrl *ctrl, u16 status)
                 aen =3D list_first_entry(&ctrl->async_events,
                                        struct nvmet_async_event, entry);
                 req =3D ctrl->async_event_cmds[--ctrl->nr_async_event_cmds=
];
-               if (status =3D=3D 0)
+               if (status =3D=3D 0 && aen) {
                         nvmet_set_result(req, =

nvmet_async_event_result(aen));
-
-               list_del(&aen->entry);
+                       list_del(&aen->entry);
+               }
                 kfree(aen);

+               trace_nvmet_async_event(ctrl, req->cqe->result.u32);
+               nvmet_req_complete(req, status);
+               mutex_lock(&ctrl->lock);
+       }
+       /*
+        * When status !=3D 0 we are called from nvmet_sq_destroy() =

context that
+        * means we need to complete remaining host posted outstanding =

requests
+        * in ctrl->nr_async_cmds[] which doesn't have 1:1 mapping onto
+        * ctrl->async_event list in order to put the reference on the =

req(s)
+        * which was taken by outstanding req(s) so that we can make =

progress in
+        * nvmet_sq_destroy()-> wait_for completion(&sq->free_done).
+        */
+       while (status !=3D 0 && ctrl->nr_async_event_cmds) {
+               req =3D ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
                 mutex_unlock(&ctrl->lock);
                 trace_nvmet_async_event(ctrl, req->cqe->result.u32);
                 nvmet_req_complete(req, status);


Here is the new patch which clears up the outstanding AENs in a separate =

function from [2]:-

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6392bcd30bd7..b494a902c3fc 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -777,6 +777,20 @@ static void nvmet_confirm_sq(struct percpu_ref *ref)
          complete(&sq->confirm_done);
   }

+static void nvmet_async_events_free_host_req(struct nvmet_ctrl *ctrl)
+{
+       struct nvmet_req *req;
+
+       mutex_lock(&ctrl->lock);
+       while (ctrl->nr_async_event_cmds) {
+               req =3D ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
+               mutex_unlock(&ctrl->lock);
+               nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
+               mutex_lock(&ctrl->lock);
+       }
+       mutex_unlock(&ctrl->lock);
+}
+
   void nvmet_sq_destroy(struct nvmet_sq *sq)
   {
          u16 status =3D NVME_SC_INTERNAL | NVME_SC_DNR;
@@ -786,8 +800,16 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
           * If this is the admin queue, complete all AERs so that our
           * queue doesn't have outstanding requests on it.
           */
-       if (ctrl && ctrl->sqs && ctrl->sqs[0] =3D=3D sq)
+       if (ctrl && ctrl->sqs && ctrl->sqs[0] =3D=3D sq) {
                  nvmet_async_events_process(ctrl, status);
+               /*
+                * Target controller's host posted events needs to be
explicitly
+                * checked and cleared since there is no 1 : 1 mapping
between
+                * host posted AEN requests and target generated AENs on the
+                * target controller's aen_list.
+                */
+               nvmet_async_events_free_host_req(ctrl);
+       }
          percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
          wait_for_completion(&sq->confirm_done);
          wait_for_completion(&sq->free_done);

[1]http://lists.infradead.org/pipermail/linux-nvme/2020-June/030823.html
[2]http://lists.infradead.org/pipermail/linux-nvme/2020-June/030839.html

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
