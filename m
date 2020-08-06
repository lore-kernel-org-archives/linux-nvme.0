Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5AAC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 22:43:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCED2075A
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 22:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vQFz6vro";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="mkZmBNFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCED2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=d14m84IK0sivYD9G4ODk8Mau9AKLZOpgFkWCrNieuhQ=; b=vQFz6vroZDGGawVtEi5Itw0jd
	lR6knLos/l6pfUIGbXPMIr/JTo4PqbHB1p8cTTIKwsE1m/HozvA8ARfGfiklJRjfCouE5ig0yYLMo
	H+Z9bxbt2viTIw3o8YLp7kDi62xzLMQGUi8DzeyGigoJTcL+Pis1bg+BoysXzpNI14NBScdARCnHu
	ECWpiGkGveWOZEgXZl7Xg1nY4jL2/PeQqakh9TNWoY67BNPQAfzeLWv1JLUtYDiGPxvhNFJRItxGE
	EeNpTlRguf2bUYM7ZCGhRPjqeMl7LzrMvaEUdfhqAFFBE3MZ+xS0JKX8EKs4313/arLqc05BC2zAZ
	kYDr+aP/Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3obM-0002ki-FG; Thu, 06 Aug 2020 22:43:08 +0000
Received: from mail-mw2nam12on2059.outbound.protection.outlook.com
 ([40.107.244.59] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3obH-0002hp-Ae
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 22:43:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnoMIFKR+k8yEkdFDUrdv7CJWHhjAdqlrZgKRT7LXRBrw3c2EOIWRVslQpQ5QtlKUEahvRxHlokUrLJwb/eV2nkaLsMW6c5DoDpO42fjP1dNRimQXyam8BihIPIS7h6xeX956QS1mJLCO6zbQril4+ntj9kNj2ABj7CVkVZN4v5GkaTnVrYTNdxvqW6kXcV+aip9kZU0v/vjBv8XH4WQ0hRGpRBx8mM7DvxuHhGJ7J512QQ0VMkQcdTQNDbhOg9yWFT12OWotHnkB3QWaDgLRLPvcIzCbR4kLthWflbg/lh3dtflrvn8HhS8HED8uyufcCORvStm0iOIsN24MrOFLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a71Hz1hjV201wAsNosW/5MS+7r37cSdm0dfOxl29sE8=;
 b=NjSuOAD/9V2/fSEzKXpKbeE+BEYdAcJD6Eo/BdoEvEE49GmRMolNACpkb+n+jiO5zJpsDuCGfe17ItnBJCQ5vwj3xyq/FHaxsXatsTjcb/sDYqNwwNyUrxsfsERdOMQyhXY3iFuFEeh2qEJkh+3QMisW+502p/ivoCqiAito1oSTMGJQ1jIQeDDIimPO7lP25XsQmCilUPacMzxKtmvF+H9Spn+imleDh+3KXeRKdi6qT+hwMrQebOW6CV7TvasWC/x6IpmmoU4VpxdSWsmkRAcih0bcUZ+sBqOfRw7z2M0t4GwjZfz0HpawjsrqbD2BYkv3sld9EmXFdjlUDd8rJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a71Hz1hjV201wAsNosW/5MS+7r37cSdm0dfOxl29sE8=;
 b=mkZmBNFxnA4vyMmXHdXc51XfjT+0Z4j21PcIOUJlNYB8h1z1pFttkOUDVxDzokrnv9yQJelvGorankDPgKx2IEosSMbVPl4wrEC4Acjp04H65lMUvhKrA0cytwkQTC6fsz9fiEAk3KCjgTeOCsHb41KUQEe5X2DbT8Xmysc/h28=
Received: from BN8PR06MB5714.namprd06.prod.outlook.com (2603:10b6:408:d2::32)
 by BN6PR06MB3140.namprd06.prod.outlook.com (2603:10b6:405:3e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Thu, 6 Aug
 2020 22:42:56 +0000
Received: from BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9]) by BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9%3]) with mapi id 15.20.3239.022; Thu, 6 Aug 2020
 22:42:56 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH] nvme: restore use of blk_path_error() in
 nvme_complete_rq()
Thread-Topic: [PATCH] nvme: restore use of blk_path_error() in
 nvme_complete_rq()
Thread-Index: AQHWbCaRkQkrsfgdNkeCg0AeYtZuaKkran6A
Date: Thu, 6 Aug 2020 22:42:55 +0000
Message-ID: <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
References: <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
 <20200729055903.GC31113@lst.de>
 <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
 <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
 <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
 <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
 <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
 <20200806184057.GA27858@redhat.com> <20200806191943.GA27868@redhat.com>
In-Reply-To: <20200806191943.GA27868@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.39.20071300
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [216.240.30.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e575583-8a61-4c88-781f-08d83a5a0ffd
x-ms-traffictypediagnostic: BN6PR06MB3140:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR06MB3140A4A05B7203A9F49965F8E4480@BN6PR06MB3140.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eBhThj07HR/uf4BPcDhX8XmENcwdWzRiNi+5E+WEz6ivHnYJlOCiMKP22XUUstYPkpX9xvElizMXmMH6QbIA4mDuNPLAE6aEeRXznvtm/oxGFvGhm0nPYZQg1K3ByGm22mQuerwMSIUmH1LdujIT5HxKFEq2CpQYtDKoR5wlUAbu8R1h+uYb1iEsZY2UIvf4azBlx2VdzcvOxKg+MOL4gAWHxyazm5lnAgDM+kTjnfqVWrYGtjVmwIWBt3kOBPlNAxj6z/DIb1nNCX8IcoD9/RAM8h+7nJnuMUQMSKidqfPdcz5PSuDKJYFYEJmT1kgJ7UDOvDrqipJDT9PTVrJmug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR06MB5714.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(26005)(83380400001)(53546011)(86362001)(6506007)(8676002)(71200400001)(6486002)(54906003)(107886003)(2616005)(6916009)(478600001)(4326008)(33656002)(8936002)(316002)(6512007)(186003)(66946007)(66556008)(64756008)(66446008)(2906002)(5660300002)(66476007)(91956017)(36756003)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: kjIBG3dnK3E7o62RCIV480T05B5Ou9MiAzW83M35TFyWoe4BkSDHc1vaNXWzJ6RYWBW6ig5ae/pK2g/SL2/PxkTLluHiu+PWCo6Ke7XNvQPDoH0xrCHaiaJffWX84u+4VW/4X+vaQ7xM/6oM+zkmkE0814TgbNfyLntUmOsCn694/EdEKtPer8igzwltEMBc/7WpsggXGZDye9rKXvVE7S3ynrrTV/eUhCJtyNbdZzW06YaBxI8BxUkLRBqAUJJNZghpBV+7KeSV3qCk8Du359e5hIa3tGePRBWP9tR0hC+cV4ILSCaQRfYHVLKxNRC5OggCBpzdF/2oF5BcpdEHHsn+5fz/Uhmn2OUEmKLUct689eEonA2l9fKVHWJXRfli1BMs7cR3kH8FJh+02joqp2szixkJhmRmjbmaFAfTuG4xQhGy4GG8LVeJoWn08Cg+OBYHu/bgk4cLlaR1S7b9/Il6uWVgseCiu34BFTfwmGvS3Ll19bYufLNRchUe1VwYzmulKtI0IcBhJxbESQfDQj0CUiRx1FWn7tPJgAVuxNVCHx0OT6P0souFZlVRAQRi+EMhsmBUke2qrqSqwotnlxEpq3ZrGvoVo8/auRBF/fa0uskN/xe33qEY+RL7cn20CpXijXlLn8HhPkI9shGWWg==
Content-ID: <3FE56A7E08FD024B8A55EFCDA4F1CA39@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5714.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e575583-8a61-4c88-781f-08d83a5a0ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 22:42:56.1003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qx3OWJScHxt0c5Jq8nJxMjKs505lR4X0aZirZlx2kfVLbR8ODRFE5kQ6h4gDLfr81Onbv6Oe+y76ghbVwdFEhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3140
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_184303_427824_00A863B3 
X-CRM114-Status: GOOD (  18.63  )
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
Cc: Ewan Milne <emilne@redhat.com>, Christoph Hellwig <hch@infradead.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/6/20, 3:20 PM, "Mike Snitzer" <snitzer@redhat.com> wrote:

    From: Mike Snitzer <snitzer@redhat.com>
    Date: Thu, 2 Jul 2020 01:43:27 -0400
    Subject: [PATCH] nvme: restore use of blk_path_error() in nvme_complete_rq()

    Commit 764e9332098c0 ("nvme-multipath: do not reset on unknown
    status") removed NVMe's use blk_path_error() -- presummably because
    nvme_failover_req() was modified to return whether a command should be
    retried or not.

Yes, that was a major part of this patch.  nvme_failover_req() was completely 
reworked and fixed because it was badly broken. 

    By not using blk_path_error() there is serious potential for
    regression for how upper layers (e.g. DM multipath) respond to NVMe's
    error conditions.  This has played out now due to commit 35038bffa87
    ("nvme: Translate more status codes to blk_status_t").  Had NVMe
    continued to use blk_path_error() it too would not have retried an
    NVMe command that got NVME_SC_CMD_INTERRUPTED.

I'm not sure others would consider it broken.  The idea was to get the blk_path_error()
logic out of the core nvme driver completion routine. 

    Fix this potential for NVMe error handling regression, possibly
    outside NVMe, by restoring NVMe's use of blk_path_error().

The point is: blk_path_error() has nothing to do with NVMe errors.
This is dm-multipath logic stuck in the middle of the NVMe error 
handling code.

C symbol: blk_path_error

  File        Function             Line
0 dm-mpath.c  multipath_end_io     1606 if (error && blk_path_error(error)) {
1 dm-mpath.c  multipath_end_io_bio 1646 if (!*error || !blk_path_error(*error))
2 blk_types.h blk_path_error        118 static inline bool blk_path_error(blk_status_t error)

    Fixes: 764e9332098c0 ("nvme-multipath: do not reset on unknown status")
    Cc: stable@vger.kerneel.org
    Signed-off-by: Mike Snitzer <snitzer@redhat.com>
    ---
    drivers/nvme/host/core.c | 9 +++++++--
    1 file changed, 7 insertions(+), 2 deletions(-)

    diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
    index 6585d57112ad..072f629da4d8 100644
    --- a/drivers/nvme/host/core.c
    +++ b/drivers/nvme/host/core.c
    @@ -290,8 +290,13 @@ void nvme_complete_rq(struct request *req)
                    nvme_req(req)->ctrl->comp_seen = true;

            if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
    -               if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
    -                       return;
    +               if (blk_path_error(status)) {
    +                       if (req->cmd_flags & REQ_NVME_MPATH) {
    +                               if (nvme_failover_req(req))
    +                                       return;
    +                               /* fallthru to normal error handling */
    +                       }
    +               }

This would basically undo the patch Hannes, Christoph, and I put together in
commit 764e9332098c0.  This patch greatly simplified and improved the
whole nvme_complete_rq() code path, and I don't support undoing that change.

If you want blk_path_error() to handle any new NVMe error status differently,  I would suggest creating a new 
BLK_STS code to translate that NVMe status and add it to the one place in nvme_complete_rq() designed to
do the NVMe status to BLK_STS translation:  nvme_error_status().  Then you can change  your application specific 
error handling code to handle the new BLK_STS code appropriately, further up the stack.  Don't stick your
application specific error handling logic into the middle of the nvme driver's nvme_complete_rq routine.

/John
                    if (!blk_queue_dying(req->q)) {
                            nvme_retry_req(req);
    --
    2.18.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
