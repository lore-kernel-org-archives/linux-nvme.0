Return-Path: <SRS0=iyK+=NW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6946BC4320E
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Aug 2021 13:45:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19EF060462
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Aug 2021 13:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19EF060462
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=primelogic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FJp2aHDGZ14l3TnQdz3SqIn9k32VZ1HDrm3Cj/PWjjg=; b=hxbUxoWfoliTlQ
	6VCAvmHRvTrdmmpPtPtWxNYa8jeqXVUXzkkFJjJIDIfBw6YtApggCqNs68Mr9cY0xBCqFJColhaXj
	ZzoUrElJe0pu6Tk7LGL68TfpnuinRMKXF0Z64pkyY29lJO4bGsYxwo4pcrnvFavGPH4H7AxCXrjRl
	DaoZG18Z1Z9wkrpmvz2T3o6fgeGzwN/Mruyr1lXog9BYGrZ9RhYEJ25+rxTm6Oi3wML0Ybyvps67z
	kQTvao3hZM5ZG2qqZR9NUfqLtwG9pzvdNUJSWMThwMTfyh/A2vAMu3Au9DU5KbVyGnw5fyoauQE1c
	TYSY/JkQ5LnrKaCbWJtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mL44A-002Nkj-Io; Tue, 31 Aug 2021 13:44:43 +0000
Received: from mail-am6eur05on2102.outbound.protection.outlook.com
 ([40.107.22.102] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mL42I-002Miu-9R
 for linux-nvme@lists.infradead.org; Tue, 31 Aug 2021 13:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4zI5hwHx3GCQfQ5a3ciV3XFqddDIp8OXgn60Nk2jHL6VG/XiTMF3oUuG7S8RXYzWlvW1MLFXQWMVGCq6IF7TY3IDM9JNL5q8kfrtRHni5DWn/hxx1BZON3+JYQVrIT4awThaLKCGaTtjGiDK7Xtxcf60Q6VedUWESofYRi6A/NFkm6uB8F/dt4A75hqJTPq4F9sbwVAjsjqNHjclVCk93q05STInZCp89pbsbxx2F826Gzi/4QPioqIlPeEkzUK1hgO58pjM00nmEjHa79wpykt4FlutiyqzDd/KGjsqyO678UeUPTaLxsf2sAAu6gWT3ryDe4UftjP6phZ4ThI3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzpaejX55d/pTxaKtBSJvrVM29fug3Y7PPqW9drWKGA=;
 b=Oi6nLIynY2FF9qBITYQ8m53MbjmK9150+5YM3GadmTzgUr7fu2eNjCTaqMdBo/Y6f0BNTq4AzgfioXkJ34nSOeMRXTMdf5spuyIl0Oy2tUf6D6HvxlWO4o5g4g7Ccb2FdRqHZ2ZRP/mB4sRITpGdcm6C4rNM2nKf5W/XH6QzbZr5ptDj9V3J8ioNHgiqRv+lBehx2G4+CHbFAOooPELd/HgZ6rWoG7TBgSnV61+2J5roWsdCePZ7XDY8ywVe+Aw1d/AoWYN2wF0g1oCi+Vcn+QGd3DYEuSqyXjTqAChozg2goq7FOcnEOpa69C1IvKnjE7xAyzziwxzgUgaqWE+3sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=primelogic.nl; dmarc=pass action=none
 header.from=primelogic.nl; dkim=pass header.d=primelogic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=primelogicnl.onmicrosoft.com; s=selector1-primelogicnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzpaejX55d/pTxaKtBSJvrVM29fug3Y7PPqW9drWKGA=;
 b=wVLw8xamcEGqojSAOF+BwjQgViPHKj1zmw+i195YoY5c3gB30u9HOVvXjdiCurjt5Qlje92nGJmbM9MRH0LN1QndPYHT1g1BbLwCER+R6ebJLi9ZgvV7lvN+JWsbR+CeLMsVLY4IJfeETOjutg6SYt48PYDteLxJVhaQ5aEZgW4=
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com (2603:10a6:208:c1::28)
 by AM0PR03MB4721.eurprd03.prod.outlook.com (2603:10a6:208:ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 13:42:43 +0000
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::4d63:671e:2943:5086]) by AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::4d63:671e:2943:5086%5]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 13:42:43 +0000
From: Mark Ruijter <mruijter@primelogic.nl>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: SPDK initiators (Vmware 7.x) can not connect to nvmet-rdma.
Thread-Topic: SPDK initiators (Vmware 7.x) can not connect to nvmet-rdma.
Thread-Index: AQHXnm4SW+F2pBQEIUGXFPYlGAQ1jg==
Date: Tue, 31 Aug 2021 13:42:43 +0000
Message-ID: <CA3F5384-4B57-47ED-9DFE-27E80F3D312C@primelogic.nl>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=primelogic.nl;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fcd0150-1685-41d9-a3bc-08d96c85356a
x-ms-traffictypediagnostic: AM0PR03MB4721:
x-microsoft-antispam-prvs: <AM0PR03MB472189775D5AD6458CA9A8F8D1CC9@AM0PR03MB4721.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4LBGQMdSuyhFWFahOIgKTQuVx5nGlCbHQ9LFUJEWAslxEkBHe5ZYkk1j2kA0VjPMhsamjXFwQm0cKJmDhDksQBGioHseHKLxFwAJDcrhIyboibY0zvsq+GUbOTTKN+zZ8ddt/67F9ZFLclkDEwp4dKBi3NmnMs/YglQDdFxzPfqiBnON8NS9QzqB1ymFBe438oLEvLakkgBPJkElwe3N0NuWcTgVrOphSJgSKwBG5692/KUhz76Duv6H46lIdjU1bTSflu+yhyJpTFmd84vUA6/uBZb9p328CqSx2BbEv18tQwQEuAx1wpKPW1z3jIeAyY8qFXIF5SCGZMNINNCg4q7JFK52TEqDRw+VAf4LLgsuPkFhY28yRvjCBNIE3RQ0LA4PPsfU5waahfUZIcZaQiTqCRK0sZnnwjCOIeqnqSI6O4qStkkSh3WayMkVCW30FPPeofjX98FCIlHcXqnWeBpxvCg5vpI1t2PDSBzm2r34fjeBCwj+XCskAIBKRFoLaPD+QQv7Eg9TZUxM6Fnv+tsEsrr0ofgfYHSqkVTWexi2P0SjFTi4tcTH8c+qBCKp0BWQdoQkQQoi9hnOWwjizLmRBcGJoPGlHVM40wVkNMLuU3kE5Qeq4ZlYKMHPM2/QsZWWVD4L9n2D6UuvRWzGToXww0MiV2Cv6DbkGoNbYw8UEDgm38DBle5etdzZRkqHcgqayWb7aHo0xipzeF0ZNb4uhONuMmYrLN401TaRR8R8zlLHajLILcXcdYRQ/QQ/UnoEcZHGg39Kx4780QQxc3ByvXU9/FntQfsVKpmeoMXWu4i8SJs724WR/v0XSgwa1J08UrMmDEK5xEp90opMtQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR03MB4211.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(376002)(39830400003)(136003)(366004)(346002)(8676002)(508600001)(66946007)(38070700005)(5660300002)(6486002)(8936002)(38100700002)(6512007)(83380400001)(122000001)(966005)(76116006)(71200400001)(66446008)(64756008)(36756003)(186003)(33656002)(316002)(2616005)(86362001)(6506007)(6916009)(2906002)(66476007)(66556008)(26005)(21314003)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnVvckk2SXFKeXhnYzF6R1pZKzNsMm9heHYvV3dSR29SeEhEN3dNNVRZcTBx?=
 =?utf-8?B?bDg1RS9XZExNWFg2dG9jTVBYaVlEaGp2aStWUHg3Q1pacGZHbmFmV0lzMXMx?=
 =?utf-8?B?aHdRek16OUhCQ1B6b1FHcmdhZVRnWHd6b0pLVjN5OE1FdS90bktHeTEvZDVl?=
 =?utf-8?B?b0p0YXVGWk84YWpuYWt6RmZoSkowdzhWYnNIYkozc1N1OEI4aUlFdFEzcndu?=
 =?utf-8?B?cS9YZ3BOQ2U5QU5MbFAyRnpsTVFSOFRoMkpkQ3owcDNrS2NFRlg4NDZ4R1JN?=
 =?utf-8?B?eG1HOTBITnMxWThYQ1NnemprRFZkR3pOWWxYVEppeWxFa1NadE8wa3FEdUxI?=
 =?utf-8?B?YWs2VEJBejZZdlVwN3poQUNZM2JJajE3NGMySytTM3ROdVcwbnhsU1FBZlNG?=
 =?utf-8?B?WkFpVVhLck14ZmRrLy9PNmxXWmlac2xYWVBseWRGTnRQZVpSNTJOSTZkVVhu?=
 =?utf-8?B?Q21rbkh4cG9NT3JUaS9uUEV0dzJKR1IxWDJtbEdKNFJyNjBFMEUzeWpRei9k?=
 =?utf-8?B?dzBRZDhLWG16c0xGclFWQ1NGUjdkeTg0aDJaMnZIQXRvRXk5and0WW5peExk?=
 =?utf-8?B?Rjl6eFAzU1JRQVJyN2NhYlV3SFpUVmhIZTgrSGxsM2Y2T3RLWUFhd1crQzEz?=
 =?utf-8?B?cll5cFNjdWhsZXdyWm9lOXNNaTRhbFEvU05lV2Jqb2picE0ySUtCMUVaa0pD?=
 =?utf-8?B?ZDl2a25HK0JONTc2Z0llRHd1VFp1ak1YaHlHdXJ2MytuRHRCL0JOMWY2MkNY?=
 =?utf-8?B?ZVM2eWkxMDNWSWRkYXY1Z2NDSmNvQlRhampxUnRlcElhNHczYVkrM2tmaFps?=
 =?utf-8?B?UC96c081M2lOYzhTUDlKaEFKMVJxUlE5dzdJYm9KLytXYnhmRUFBZWtjdmhx?=
 =?utf-8?B?NlFrVER2RUxFYzJnK01hN1lpTDZweU9GZHM5WHZuVWtoTDYyTzZVNmRZVzdS?=
 =?utf-8?B?cUxHTVlxaU9tYy8wa0dDY1lON0FNTTdzbTZ5SmVZRTNtczQ0SitCUCtnR3ls?=
 =?utf-8?B?RU05QWZBaTdqYnpaN3V3d2YrVmpWQzFuUkZLVllQT2xYVERZSW9LRHI5Q3hH?=
 =?utf-8?B?Q1krZHRHWVpOeGVSWGdleThza0NLTXhOTU5FTHFvYUw1OElHc0tRbHp2SCtE?=
 =?utf-8?B?a1lEVTNHVVdHdUwwNU9LNEwrWnBodVhyRWI5TXE4SFgrWkZpaEJldFVzOXBp?=
 =?utf-8?B?cnFnZEVjMjY2cXQ3ZVAxRHMrM05BYkdkUVV4YkkxQjdteG95clA1MWFZR1JW?=
 =?utf-8?B?Q05CUTRRMCtnbXUvWmhCa3o5dk5kNEs4WmJWQlRCckVVRUJPQVpZbVlVelhH?=
 =?utf-8?B?QnpPQWR6dTRZK0V1cWpuTlRIU2w3ZVp2L3kyZ0JMeXpTMWZHaW5zMmFyeldp?=
 =?utf-8?B?d3k4QWZsQVhhVUNiRWlKeDllN0lsOCs0dlFPNXlLUW5vUnQwMnVXenZTRXNu?=
 =?utf-8?B?S2UwOTFhM2h4anMrMDNrV29VeFd2MXNjUTBhcFk2dlRod0EvUTVkRnVaZlBF?=
 =?utf-8?B?cGp0QW1Md2ptTVVhdEIyMGFBR1VrVVliZGVCNC94dTdPWEZPK1VZY25Rb3d1?=
 =?utf-8?B?d2p0dk9JTDJIWjZWSGlsQW5lNGluVUk5SXJTUXNTSG5XaFo2aWtkUzBMeXlz?=
 =?utf-8?B?dnFqREpZS203TVA3SUdWR0JIR0Z6dGVNdG9WbG5oc3k2QTNYTWpJTmtHRnpy?=
 =?utf-8?B?WHlkZHUrYVJnVXF4dnIvZ0NqV1pzaFZ0RUFJVGQ1U2xISzdlbnhBRGp1dE5P?=
 =?utf-8?Q?VvtpmpoFVCwI9wrZxdj1Iq9X8IQL0kbWhHlQNFo?=
x-ms-exchange-transport-forked: True
Content-ID: <49550FD4B4C00A40BC5563506EF5B23B@eurprd03.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: primelogic.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB4211.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcd0150-1685-41d9-a3bc-08d96c85356a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 13:42:43.1357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6f00f2a-c615-4e27-aa0e-cb78655623c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNra4Of20N/ecFdmKGJ/mBh81I+UuqYaXTORyH0nxh2utFySI2i+ttmmDT2IJfzrPGcBhJRaoNXAyJIWdZcR9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB4721
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210831_064246_408270_5F8C14D7 
X-CRM114-Status: GOOD (  14.11  )
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

When I connect an SPDK initiator it will try to connect using 1024 connections.
The linux target is unable to handle this situation and return an error.

Aug 28 14:22:56 crashme kernel: [169366.627010] infiniband mlx5_0: create_qp:2789:(pid 33755): Create QP type 2 failed
Aug 28 14:22:56 crashme kernel: [169366.627913] nvmet_rdma: failed to create_qp ret= -12
Aug 28 14:22:56 crashme kernel: [169366.628498] nvmet_rdma: nvmet_rdma_alloc_queue: creating RDMA queue failed (-12).

It is really easy to reproduce the problem, even when not using the SPDK initiator.

Just type:
nvme connect --transport=rdma --queue-size=1024 --nqn=SOME.NQN --traddr=SOME.IP --trsvcid=XXXX
While a linux initiator attempts to setup 64 connections, SPDK attempts to create 1024 connections.

The result is that anything which relies on SPDK, like VMware 7.x for example, won't be able to connect.
Forcing the queues to be restricted to 256 QD solves some of it. In this case SPDK and VMware seem to connect.
See the code section below. Sadly, VMware declares the path to be dead afterwards. I guess this 'fix' needs more work. ;-(

In noticed that someone reported this problem on the SPDK list: 
https://github.com/spdk/spdk/issues/1719

Thanks,

Mark

---
static int
nvmet_rdma_parse_cm_connect_req(struct rdma_conn_param *conn,
                                struct nvmet_rdma_queue *queue)
{
        struct nvme_rdma_cm_req *req;

        req = (struct nvme_rdma_cm_req *)conn->private_data;
        if (!req || conn->private_data_len == 0)
                return NVME_RDMA_CM_INVALID_LEN;

        if (le16_to_cpu(req->recfmt) != NVME_RDMA_CM_FMT_1_0)
                return NVME_RDMA_CM_INVALID_RECFMT;

        queue->host_qid = le16_to_cpu(req->qid);

        /*
         * req->hsqsize corresponds to our recv queue size plus 1
         * req->hrqsize corresponds to our send queue size
         */
        queue->recv_queue_size = le16_to_cpu(req->hsqsize) + 1;
        queue->send_queue_size = le16_to_cpu(req->hrqsize);
        if (!queue->host_qid && queue->recv_queue_size > NVME_AQ_DEPTH) {
                pr_info("MARK nvmet_rdma_parse_cm_connect_req return %i", NVME_RDMA_CM_INVALID_HSQSIZE);
                return NVME_RDMA_CM_INVALID_HSQSIZE;
        }

+        if (queue->recv_queue_size > 256)
+               queue->recv_queue_size = 256;
+        if (queue->send_queue_size > 256)
+               queue->send_queue_size = 256;
+       pr_info("MARK queue->recv_queue_size = %i", queue->recv_queue_size);
+       pr_info("MARK queue->send_queue_size = %i", queue->send_queue_size);

        /* XXX: Should we enforce some kind of max for IO queues? */
        return 0;
}



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
