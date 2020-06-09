Return-Path: <SRS0=KBoe=7W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0D0C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 23:27:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56929206A4
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 23:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yh0nZpju";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VK/K0s/9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VFbNGN9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56929206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=v4NJTcd9loPSBSem77TBGMHOOUdw3D+Q2lQcGQGPjtY=; b=Yh0nZpjuK+vEPL
	Dw5zP5gBMFucVeX6uBcFCJGqz+UKH/yPm0sfiq45lzaiNEng2d/j/Gqgwfk73v/lZUxBCN5sKyo4T
	9bh9o7DHicK9a4kKwiIcaupjDQDVJZIv7chFmZdX5SSDI1w25fyVqfDTSlaIdtVStDuCFxucZCExd
	XXayFbosPhOLn1xomQl+Hx5bG00cMooYg1awXk4YAUmD6wvPq1LlxojsyZ2lnnTT9kHMUPTgz8JL1
	7FRNNIISWghcEYIvyEcocHUlNNbx8X5b6RGhE8nxNn9xHLDWUqwHiqI/MzEBQ5v6Mm9HfOCfUlMcz
	3Tj0Y27L2G3wcFHMvVQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jinev-0007GL-73; Tue, 09 Jun 2020 23:27:57 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jiner-0007Fj-Iv
 for linux-nvme@lists.infradead.org; Tue, 09 Jun 2020 23:27:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591745273; x=1623281273;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=r/jBIosijcZ6IX3lubliEKaAh/dwioUisGfY5FRudP4=;
 b=VK/K0s/9Ign32Z0v5jEL8JW27DivS9TFUy+ZsziqXcUXffUiwaVfeuJP
 3CGmyffOO3xM1AOH4Lg+Jar5ZYv2orMJAKqhMCsKHKdb7Luj4JDVrG3CX
 +FN7K1ZE6L4+6Sj1ngJNlxeZeCBSxmA02RwOUgcSa48EIZ1LgDuyE2AtJ
 oLCPSTQP/Zu/LxxqcxJ2T1Brsr8L63ZaDjQ5ODY1+6M+UU9bemI5Lhvuv
 X9qNNPzz4depYi27klbxMDMtk6Qnkf7CLxYQF4aHGk99NmqbQqS3/tX3g
 yXJWf9BzphamW1IV/aOR4IPdZBJynWNoQnBlsLYpmX5LNq0MsUDsQ5efp w==;
IronPort-SDR: DtmOahfcMnRP2yDoQh2x7MzpN+WWYvog9URyDvYhWdfyZ98TRXjF0/NPk78hzsHGwQzbFIyEDY
 yTADq6jDhDTfujF4xj1nBj0E7x/ulYdqUhS2QwaSkpWEO2f9COYBySdk2JlpwJwcqImdd2ffnL
 ynt20Bd82Gcv7WBbiXIHkNDpraB4XkQmJAq8pvGg3yLMgAjE6ULYF6wD1EE8gZWAxQhu77Ag+a
 SEEVLXdzWkfaoaGmyYT+KBfS6V0sBMZPAH7wIsRA+uvCzxveV6Aa0kInaAq5M0WdCj+KRiCS//
 Fgg=
X-IronPort-AV: E=Sophos;i="5.73,493,1583164800"; d="scan'208";a="248716829"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 07:27:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFS3J59Mrkc9xmITyC4zJIs2PnkpJow5gzPCi2MJmlyVIVz7fA05fbGS7abw2M4zgvaX1Q49H62zx1ZqlBvRtr0ldkdyk+rc25ssZKr6ZtyByVLJKyLrlamWVljSmGW6z/RsyUBUd9uKFSV60QqHoqn+5ks7a6aG7jq6hAcltZAoI4vNhIq62CCF2JEO1hcuyCZB/X3m9rWiaMxlRqk/enwDwte16nWbxifV2P8ecO+j+f6hPzIk1VWmqVD8B1hLpgcVOdRgXUoog9Wivbt7KLFi3j+zI8Uy4HiWpMK1A5+hy2fmEyleiJPLsH7pl6qk2NDy5pU/cWjFkoKRmtWq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn9ealwWUve8vq5w12eGS4WnUn8I+yDsp5/DQgv5ViI=;
 b=APQzASi+5tQ/V2fc1e5GnhkJjEYEwDFb1vzZGvO5Pdtmg39qz29a6Ht0DOyweQshqmaBs4F+dLFl+qEQB2lJ5FDvKZRyZam7AFMyW97zu3Hv422aI5V7SpD6tlnMrI/ijfbNU/9J8q/H9zyu84CF84IFcCHTXy+2ry7IjlSAP5Saw2ETVZhklzMvis8dN+kocr3lXLVscqM7ErHer/g1CglgR0LNyKJkXZh8fgONUAbm4tG+Qlp1mgPvWqQ3MeNQLLypRUTjimPIa9/Oc9dQcLRNN3A7bwfjITRowFvz5vrDqZIpca6oFG1wXU/GQBEm2loXYm+fuAMeNoxVEVaaFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn9ealwWUve8vq5w12eGS4WnUn8I+yDsp5/DQgv5ViI=;
 b=VFbNGN9AC6QB7grLxLjm/wUBJDjXfcS42qS4/s233AUKVnGYxPQPFDRJkcuFNheHav6ayj65dQ7b44Ne0Q0GAT/PfXHS76KBM6le+ppbJQzAIcZ9yOwK+PlYi+ebEIRH6zJSbelH+MG5kzsdV5fwYUjQ+L871ddVC9WsqQWXrko=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4119.namprd04.prod.outlook.com (2603:10b6:a02:f9::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 9 Jun
 2020 23:27:49 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 23:27:49 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2] nvmet: fail outstanding host posted AEN req
Thread-Topic: [PATCH V2] nvmet: fail outstanding host posted AEN req
Thread-Index: AQHWPrR3CK6lFnT9z0+e729zee86ew==
Date: Tue, 9 Jun 2020 23:27:49 +0000
Message-ID: <BYAPR04MB4965E53A28ACA2407DC878D986820@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200609231942.47808-1-chaitanya.kulkarni@wdc.com>
 <183bd810-3904-5be5-3457-d63d5291c247@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4598f027-67f7-4001-46b2-08d80cccb991
x-ms-traffictypediagnostic: BYAPR04MB4119:
x-microsoft-antispam-prvs: <BYAPR04MB4119D49EA886387EAD2AC5FE86820@BYAPR04MB4119.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: thqhOyI2OcxlDzNNoRcljhoTqXEXdLJqEmntxE8+DXaq7+j6TWccu10uDCKHcj0SQk6PPyy8jSV0CG9JodkGqBVRc/UjGwouKnHwiiuM960Nczhr/G4gZlSOQlJAiTilDyey44w3jJ5D81+MJg3h3ci8OZlhI2bVVkHpAn1RR0va9Um22f7CR+1kj2BEfINT4f4esZNucneAjZiEr6pdxVZaO20AdeY5B0p7MHrm0qbsb2+XmJKOXuktkzqlbVoMOkVfKUpQRLzbj3v7bbKcXe005va4IrG+7jRgNsqg/eJQz75lvYg8Wy5qkynDeQBE6KmmjtDqIBmXdxsu1k7Qhw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(136003)(376002)(366004)(346002)(83380400001)(52536014)(86362001)(33656002)(2906002)(71200400001)(316002)(53546011)(4326008)(55016002)(9686003)(186003)(76116006)(110136005)(26005)(6506007)(64756008)(5660300002)(8936002)(66556008)(66476007)(66946007)(66446008)(7696005)(478600001)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: xUxqfyxek9+O6WmqLZdNfiRHpakbXZ/16CI1HKoJwZFeaTp+VjCZC3nwPIgX2W1pt0UmUaRGiVofh2TrElai2uoO39Ce2AwkHHg694rybe7M6UXC0k25ZYZ5toe7LIlK6MaFWRbhLYaJGaHSKbqLt2QRObdwpHuIycCaGfFKOGcUYTDmkEF1dDf7yZylFq4RYMnJ99acS8Zni4auuMjjwozSbGpZ/cfKEFwZ1Q7pYENrIen+8Ur93FuuydtjbK+aSoWQ9rIFBStRV22WxBaagXtQPKsaXjHOmAlVSrvnYi+7xwh4R7SzX2DumtMp1D7dd2ZQHK0b7Hdqryo/yLX7Tz7H0QvnD0p9Ssa+PplTtL2Bb9Fzyjtn7LU86+x44KYw+WzCPoQFExO6Szp24Oxk/9ECWpm0Bz3/23UwJom0/qqYM0ZVd8YgY0ePCNnangpLUToVYARnjTJ0Ab5ZlC0Oc2iC5GDMA0/VcabBnGVJWTg=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4598f027-67f7-4001-46b2-08d80cccb991
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 23:27:49.7443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQIkg0Kbhn9POSIrYy/0eYb3ykjE7X0GaXQrQcYEka92AVpTp0HsG1tO+/WgSoWoqwo1NZQZ/FMSj0nESsbTmTD9P8L7JxzcYapCfPyoxg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4119
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200609_162753_708140_7B698E82 
X-CRM114-Status: GOOD (  16.67  )
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
Cc: "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/9/20 4:21 PM, Sagi Grimberg wrote:
> 
> On 6/9/20 4:19 PM, Chaitanya Kulkarni wrote:
>> In function nvmet_async_event_process() we only process AENs iff
>> there is an open slot on the ctrl->async_event_cmds[] && aen
>> event list posted by the target is not empty. This keeps host
>> posted AEN outstanding if target generated AEN list is empty.
>> We do cleanup the target generated entries from the aen list in
>> nvmet_ctrl_free()-> nvmet_async_events_free() but we don't
>> process AEN posted by the host. This leads to following problem :-
>>
>> When processing admin sq at the time of nvmet_sq_destroy() holds
>> an extra percpu reference(atomic value = 1), so in the following code
>> path after switching to atomic rcu, release function (nvmet_sq_free())
>> is not getting called which blocks the sq->free_done in
>> nvmet_sq_destroy() :-
>>
>> nvmet_sq_destroy()
>>    percpu_ref_kill_and_confirm()
>>    - __percpu_ref_switch_mode()
>>    --  __percpu_ref_switch_to_atomic()
>>    ---   call_rcu() -> percpu_ref_switch_to_atomic_rcu()
>>    ----     /* calls switch callback */
>>    - percpu_ref_put()
>>    -- percpu_ref_put_many(ref, 1)
>>    --- else if (unlikely(atomic_long_sub_and_test(nr, &ref->count)))
>>    ----   ref->release(ref); <---- Not called.
>>
>> This results in indefinite hang:-
>>
>>     void nvmet_sq_destroy(struct nvmet_sq *sq)
>> ...
>>             if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq) {
>>                     nvmet_async_events_process(ctrl, status);
>>                     percpu_ref_put(&sq->ref);
>>             }
>>             percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
>>             wait_for_completion(&sq->confirm_done);
>>             wait_for_completion(&sq->free_done); <-- Hang here
>>
>> Which breaks the further disconnect sequence. This problem seems to be
>> introduced after commit 64f5e9cdd711b ("nvmet: fix memory leak when
>> removing namespaces and controllers concurrently").
>>
>> This patch processes the outstanding ctrl->async_event_cmd[] until
>> there are no cmds available in array irrespective of aen list if
>> empty or not.
>>
>> Signed-off-by: Chaitanya Kulkarni<chaitanya.kulkarni@wdc.com>
>> Reviewed-by: Sagi Grimberg<sagi@grimberg.me>
>> ---
>> * Chnages from V1:
>>
>> 1. Isolate host posted target controller AEN cmds cleanup into separate
>>      routine.
>>
>> ---
>>    drivers/nvme/target/core.c | 25 ++++++++++++++++++++++++-
>>    1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 6392bcd30bd7..86d89b16cf48 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -129,6 +129,21 @@ static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
>>    	return aen->event_type | (aen->event_info << 8) | (aen->log_page << 16);
>>    }
>>    
>> +static void nvmet_async_events_failall(struct nvmet_ctrl *ctrl, u16 status)
>> +{
>> +	struct nvmet_req *req;
>> +
>> +	mutex_lock(&ctrl->lock);
>> +	while (ctrl->nr_async_event_cmds) {
>> +		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
>> +		mutex_unlock(&ctrl->lock);
>> +		trace_nvmet_async_event(ctrl, req->cqe->result.u32);
>> +		nvmet_req_complete(req, status);
>> +		mutex_lock(&ctrl->lock);
>> +	}
>> +	mutex_unlock(&ctrl->lock);
>> +}
>> +
>>    static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
>>    {
>>    	struct nvmet_async_event *aen;
>> @@ -786,8 +801,16 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
>>    	 * If this is the admin queue, complete all AERs so that our
>>    	 * queue doesn't have outstanding requests on it.
>>    	 */
>> -	if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq)
>> +	if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq) {
>>    		nvmet_async_events_process(ctrl, status);
> Why do we need this at all now?

The call to nvmet_async_events_process() is needed when we have 
ctrl->aen_list populated and we have ctrl->async_event_cmds[] posted
by host. The next call nvmet_async_events_failall() will process
not handled ctrl->async_event_cmds[] in nvmet_async_events_process().

> 
>> +		/*
>> +		 * Target controller's host posted events needs to be explicitly
>> +		 * checked and cleared since there is no 1 : 1 mapping between
>> +		 * host posted AEN requests and target generated AENs on the
>> +		 * target controller's aen_list and async_event_cmds array.
>> +		 */
> Not sure if the comment is needed, the call is pretty self explanatory.
> 
Okay I'll remove it in the next version.
>> +		nvmet_async_events_failall(ctrl, status);
>> +	}
>>    	percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
>>    	wait_for_completion(&sq->confirm_done);
>>    	wait_for_completion(&sq->free_done);
>>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
