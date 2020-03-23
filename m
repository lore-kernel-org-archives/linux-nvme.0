Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CEEC4332B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 20:46:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B182820719
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 20:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sgYMo83F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BG2JdSt2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Wuhgo2uQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B182820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=mMUazbGd9kU3zuSYL13Il4vHuod2eQv6ASIy8yrplyc=; b=sgYMo83FFaw1BU
	rCQP/UaklDahTznY7IsMWs7uJ1S9yttet4jdwPH0Gt4L5irY2rBMmRY45IrvT5571cUPsqVVjjUc9
	Qd6pQntF4eQk94GKPHUUaXk2us6CzxDoheViv1cRVsK7xytRDZ+nZOZXTS2wxKSG5zQvbI/AlGBQV
	qNnVtnj6KnlzslQ8OJ9s72pTmSmNM2g9krkg1H2o6ut5PAJPgJ+xSty1/GfovxLXC15kVC5vV2eG+
	jOzK5/MP5ftq0DijW5WQbMoOj12WdaM/7WdFJIJQOB+d6Kz9/G1DKFJeNefUuYMwNpP+H6UJjH0N3
	jDqqIBv8f+56kBVyJk1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGTy4-0004lI-Ri; Mon, 23 Mar 2020 20:46:40 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGTy1-0004kO-NP
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 20:46:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584996397; x=1616532397;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5v+/SeLmu5CbpHUqT4nIgOMPAa/Ajz203pgHCuBQs5k=;
 b=BG2JdSt27tEChwej/OlOr/gQPlhBMK0yQV0YvEMoQGGghervC30+L0/o
 LSRCFcA7C0lupg+Xs0oAk/S9IPuBaCAx6/+dKPb+2WdNcI3gB/t/Gn6QO
 nOjH4fO0z/x0a+eJbSUJKRDYv0O56+4cI48PfjsWoZwlQXNQlOwdsJn3i
 gvyW9kwOH558ICYIGZKEtgIyG4pMYCxuvN7L2cSoktvYuhu7byp8uJVhn
 LEKDzLmXao/HR3vhsUAspmQxWjxan3gQ+9Zi7KF1eKb64SID512Ct2jzh
 b9PAl/VsgQDLvx4Tp/x5LxE9BoKlpC5xFe5ovmYWmGMPpbWRJ2PyKr/fH A==;
IronPort-SDR: /Th6eOLNVCB1KerCPMi4DBssp0ejrwbZFE1Rse6TX0pNpNQoP2eORm+u4zcKZLQOYohNdX1ZNP
 THGdSZmIYI6iDjYNgme4DUNA9oUNOfAMFc6gVgWAUuUxDfmG2nTsQ1L0U82VXbYOuAwr4JdJD3
 Tx6/Esq0WjAVFlHQMkvsVGSqFEJLfwypHeWEIcRj+t1fRK0MAQ4+ddMAQUwm1EUmATrTS8fGDs
 IkGoccUjnCVHtjHTG5hsFnteo48gtpYlP0kBCbQsou1AA7MRsdAZ/jsMcpDY18pgw+kFse9vV2
 tmw=
X-IronPort-AV: E=Sophos;i="5.72,297,1580745600"; d="scan'208";a="134737340"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
 by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 04:46:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH/jhKbNwT8sw99A+3WM5Pm8DuWsbpIASG1fBE7/9txHrmMBuzpJ9RzJ1kZcB+adE3TwbKcBG3qNcrhodsmmz0W+Cuq4YzHaU2g7uJMNusq/j4Ykxs48HTKjjF+nz/XaXWF9LqT5uNAGhtl6AAt9eqrVg2X3nYNCIi1sZkhns6Bo105WpphisL44qiKz3kwWlVqcA0dfRXj0yxE2gSG5UzbjdWs3wtQYn3U3G5+czCbLiWZQwHz0GmWwHln9CiuNRucDNR3MXBN3P5YAUY6QO1+Sx9Iy7Pptg6UvL7Lf8UIkf59jkE1OFXvZearD3An+NnDvSxXgEsyQFQbGLXOghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iZv7XHkuSPn64dAu4jBn7zDG7PyeBN0uaR+XeiUQ3A=;
 b=a9KaLcxWx+7dNLrKSd8ZZeaNU7i4FiDA3lghx2mRATk8flEqGMsWnyF8LJ5g3x4YgFeO5VgqSfN9/BZKnnIyxDsIFw0A2PiTS5G21AffvM3Mh9N67d43xNE4hCPW2oONBQkkCRkC3sENAROo6AqxMDWaokT2kgLoBpDf4n8sNw8Z+c23nG6uOHh7Rzri9RfIKQ7iFPMqgVVEjTIV21meT0MmPTxfouspHKpXZQk6SLKMCEPP+5zxtKcU33EldTYjSem1GhiTttvzcMOX6Fnmg1YtIAyE+LTxxAcnMaryQiNEVbmvQpvLk8haEGG++GH7tx/ROe73CpX5qQCmC0+5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iZv7XHkuSPn64dAu4jBn7zDG7PyeBN0uaR+XeiUQ3A=;
 b=Wuhgo2uQWlENNEYLYYf1TWQqwBrAcj9+vaA5JINhdArDhKN0EKw5g50G/yfatYIfdnGa0I3b6yubzU33st9FT1hcaGEFjcGAq7KC+3khraHgQv6U++1jIvUC2XVe5ESon+cB9k8bIw/xRb5xC6kkoOcRkJLUi4M4dkhnSUVkEyI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5671.namprd04.prod.outlook.com (2603:10b6:a03:10a::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Mon, 23 Mar
 2020 20:46:33 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 20:46:33 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "tasleson@redhat.com"
 <tasleson@redhat.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: nvmet: Kernel oops when doing mkfs on nvme-tcp device
Thread-Topic: nvmet: Kernel oops when doing mkfs on nvme-tcp device
Thread-Index: AQHV/v+4UHRulWo1ZkOrantftUuKDQ==
Date: Mon, 23 Mar 2020 20:46:33 +0000
Message-ID: <BYAPR04MB496517B2AF9555819C4A684086F00@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
 <507887d2-96dd-b0ee-bb05-519039d98359@grimberg.me>
 <e16baf6a-c9e0-2249-6d7a-4e8d58f8e9b6@redhat.com>
 <f390f5a1-a80f-44d7-5d69-642119eef9b8@grimberg.me>
 <c8fce5f3-a01b-da38-820f-cf6caaa377ab@redhat.com>
 <d5e056ca-05b5-c91b-6ed7-668d28b1fe62@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 855392c4-9826-4833-5641-08d7cf6b45fe
x-ms-traffictypediagnostic: BYAPR04MB5671:
x-microsoft-antispam-prvs: <BYAPR04MB5671F30D26268E3EF82A6AAA86F00@BYAPR04MB5671.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(316002)(53546011)(6506007)(71200400001)(26005)(33656002)(186003)(64756008)(110136005)(66556008)(66946007)(66476007)(66446008)(76116006)(86362001)(55016002)(5660300002)(8676002)(478600001)(8936002)(9686003)(966005)(52536014)(81156014)(2906002)(7696005)(81166006)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5671;
 H:BYAPR04MB4965.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d2kxf5IHDEbV8GFMMtdIOv2Tu1b0lnk0RoXSOE5brTlwcoTUK4OSqr/L9hh0l9lgIAedFg8oVx17cGOy/JXBZ4dE8hsAp24MLxtY+1P0o+/CUKQiXp3JUaKpMIQO/F88JqWDaiKRDsRI0JJFmwD4Lab4LEI0KawuExovbsrucy7eIKaXx6BzFf/WNaLUxo8x/P0RdIMxh60NFFmAN2mzZJCFIof6+YhnvMAGynYFJvQB8RxIz5g8M0Q1L/gSzfKEqrrXzXbl+r6mfaKZq3JGgNWlzdhuPEPLca01C4q7vNaHTFw4OTG5V2REfTnLVRp8YWZMdBgqOBj3UJhwLCqg3DYJzWq/RVVfz7oGU962nrHQRn3UOwlbWKehLRDgpd88EDoJ8/EKvPE+g3U7ao8LrCvMbvRH9e0VySPeOhQGfxfqD++UiVj2zGChxHD1JW6KkF7w28awjxBMfqSw3BcUMIHG0NQV5kIkEwDzAX/+XfSb3GZqlmw7azWaFLzeWzOLnFAAbJtNodk1q5v0FUiJ8wMsH2CwYbMsMpbAEVrlWVT/wG6d6bIaRQNniJMWCEi9
x-ms-exchange-antispam-messagedata: Fu7MdcUdk8seEzakT9K3GDzGXvYJrybKqVV87q2lPKD3WkSewDqIY4lvFg7a5LZpKKVN/Wblmf+SFYJg4zzD5cLPRIT5mU7VlUJrGujIcXGubDnMOewHXXq7A8aMk4/giVbvSJmV1oKqD2joXMzP7w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855392c4-9826-4833-5641-08d7cf6b45fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 20:46:33.6782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ny/fIgQvUIBukqu3qIjOrSj+9OV6hnEWfK3x5M3iDjIAWVqLpx94Xw5hrr+Z5wN07CzPw7SS9y9dO2NC3Tpk8oBwopIzv+/lksvOlYclioY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5671
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_134637_896327_D1D8B2DF 
X-CRM114-Status: GOOD (  21.07  )
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

On 03/23/2020 12:42 PM, Sagi Grimberg wrote:
>
>>>>> Can you share which line *(nvme_tcp_io_work+0x303) map to?
>>>>
>>>> I'm not running a debug kernel so I don't think I have that available?
>>>> Please advise if otherwise.
>>>
>>> Maybe you will still have frame pointers though?
>>>
>>> If you run:
>>> gdb <path_to_mod>
>>> ...
>>>> l *(nvme_tcp_io_work+0x303)
>>>
>>> Do you get anything useful?
>>
>> Nope, sorry.
>
> Maybe install also kernel-debuginfo?
>
> I tried looking at the sources myself, addr2line got me to:
> --
> gdb nvme-tcp.ko.debug
> GNU gdb (Ubuntu 8.2.91.20190405-0ubuntu3) 8.2.91.20190405-git
> Copyright (C) 2019 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later
> <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> Type "show copying" and "show warranty" for details.
> This GDB was configured as "x86_64-linux-gnu".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
>       <http://www.gnu.org/software/gdb/documentation/>.
>
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from nvme-tcp.ko.debug...
> (gdb) l *(nvme_tcp_io_work+0x303)
> 0x1c33 is in nvme_tcp_io_work (drivers/nvme/host/tcp.c:181).
> --
>
> Which is:
> --
> static inline struct page *nvme_tcp_req_cur_page(struct nvme_tcp_request
> *req)
> {
>           return req->iter.bvec->bv_page; // <== this
> }
> --
>
> This means that we are trying to send data from a bio that doesn't
> reference any data. So something here is strange.
>
> Anyways, is it possible to add some information the the source?
> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 11e10fe1760f..95c9e40037b4 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -888,6 +888,8 @@ static int nvme_tcp_try_send_data(struct
> nvme_tcp_request *req)
>                   else
>                           flags |= MSG_MORE;
>
> +               pr_info("sending req %d len %lu page %p\n",
> blk_mq_rq_from_pdu(req)->tag, len, page);
> +
>                   /* can't zcopy slab pages */
>                   if (unlikely(PageSlab(page))) {
>                           ret = sock_no_sendpage(queue->sock, page,
> offset, len,
> --
>

FYI, not a tcp fabrics expert.

I remember a following fix for write-zeroes target/loop.c.

commit eb464833a2e787996474ad33dafa2c5336d4c477
Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Fri May 11 02:38:15 2018 -0400

     nvmet-loop: use nr_phys_segments when map rq to sgl

     Use blk_rq_nr_phys_segments() instead of blk_rq_payload_bytes() to 
check
     if a command contains data to me mapped.  This fixes the case where
     a struct requests contains LBAs, but no data will actually be send,
     e.g. the pending Write Zeroes support.

     Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
     Signed-off-by: Christoph Hellwig <hch@lst.de>


I can see that :-
nvme_tcp_queue_rq()
  nvme_tcp_setup_cmd_pdu()

   req->data_len = blk_rq_payload_bytes(rq); <--


Based on the above fix maybe something like following fix the problem ?

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 814ea2317f4e..f9aac34c87ac 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2187,7 +2187,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct 
nvme_ns *ns,
         req->data_sent = 0;
         req->pdu_len = 0;
         req->pdu_sent = 0;
-       req->data_len = blk_rq_payload_bytes(rq);
+       req->data_len = blk_rq_nr_phys_segments(rq);
         req->curr_bio = rq->bio;

         if (rq_data_dir(rq) == WRITE &&
> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
