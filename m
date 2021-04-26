Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156FBC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 20:29:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455C06105A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 20:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455C06105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vTw+wz+RPZKTTM4u11P0zDDvymorJxpzQzCOrivbkdY=; b=ZxfDuuy+dNAMi8fe4g3jyIBeyi
	jcPMCae4w6okH8d6+Xg1ldp9UJmwhL3M/vbnA2RqdNCkqe05YqGoEjnBCMmi11QFAzz8TDQTnIDDl
	JQ0togwTo0miJmpEym5Pf/BL10UTRW0cGlDBaWE3UBzJFzw9pd+cWfkocRczVoPVPvgk9wi1SI6N1
	wvq5sV0lJ53VI8Fwdze9rWJPkSpGAvPqi6br8aLKrJtpj79eTLcQgIP7TYuPAH01CtG2g241NpOLp
	nA9187fD9l5qX1qHljEuWv4RYp9spvpvZs8LBgagr8gsnx6yJQ6++9P/CTSuo/SY0B9otNopKSqz6
	MfA/wVBQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb7r8-008Tyb-C8; Mon, 26 Apr 2021 20:29:22 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb7r4-008Ty9-J0
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 20:29:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=RxkX2HTCriucXeUiHAHNNkcGalBNXRvFjGlljzM30dk=; b=aIZjxcKrphKDnNlUgdivuDNFVA
 obp6C9ykI6kjP0Vo77jGXiEMi0HeVN/JN/fcp20KkfxJhi03H9skGTablkrQF5YvLR9QKSe+9btuF
 iDVvAVkNfnakrtnqPKnDoWp4JxyIZx93ZW2oraBnnf4NzTsfhFfwo9UU8YPqBYAf7oQUY/9lO/o76
 8MqQVJWfKMuGndAa5CY9z+BL5OkDSWVG3mQK7wvBbliMTGTVIGF/2YIzRF0YkARfS2DC/jbJKAZQR
 oOu5lQSBPF0I+gCJQJkqKGduyQT67eSPfDe7PqdIuAfyTo0L3XWj7A6IZnJSNRPWh2E815VdYCnZX
 tLtyPXqg==;
Received: from mail-oln040092003067.outbound.protection.outlook.com
 ([40.92.3.67] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb7qx-00GCoK-Eh
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 20:29:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYF1+wBOSnocrOihCia1mfW0JSiMvlKQDvpewBHRJnVM83lCHHatfHIbMR14EC98sdKdr7D3n+AWNoLAcIVBNcc5cenKWGdgrTlrsLjjlshZ6SdxctYkHg2ogyciot1PPugYLZ5cuYOU4AUoSCPMXbf+KEfawDkyJAdSLrYBJMoaw87vVuYCdiTRvekl05DM280QmHFYqH3G4yjox8IvNyv6ekuc+B7kt9Rea/UA4zX0KVkjJzIOp0+/gHfUT9bev+xTdkUuX16Piw+9ok8NGVyCO3FQqhvxL3HzlmY73oyDnA0deNVEJKP28rkbbW89JC/AoUqUU7PhIOgLvgS19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxkX2HTCriucXeUiHAHNNkcGalBNXRvFjGlljzM30dk=;
 b=YaeMniWBgFC47M49/hxINbCA5I+h7wofjmD5x9juxNKSer7QamA+ITU3l7gcP/eHVKLahcj/vsbUgqoABjBgzSE+Nt7e3h7BCytRGhmr2h9N+VQRQvGaJnsVIP8LdZjjtAlnrr4fM4oxEKtbUe16BmPS46kPlNwioXQLeEMSXtUby5FTJxy9IXP6ipu/EeTSS3Zy3RTtiMH2U8dd2ooCpL4UXlWZVREOU/sHU/q6oAbbF1NxROrBMExydguCfxZB9a6f3KF8SspS237rShqIJZWKVbWM7JOcPcXfWdNquiQXGln6dWtKZbdMfPLwmzn0dYEu0PtH9rmFlMAG+Ecgag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxkX2HTCriucXeUiHAHNNkcGalBNXRvFjGlljzM30dk=;
 b=YVphopMMnGuRxt4DYbAWex0EKzNdqdXIhs8EksslJIrcIvu83zNdnRhIj7jpMZl4yvwU2uuDTinH7wnVeGOBfwVWzXOaOKPGB+NDN7wUOsD56UiPAnaj7yO4YBwyRK9XCq7IQPC5JMZz7VoovYN1+WPghauIkHNOv6AfF5YUzy14se2dsm82adDI42A05Qa9wY3+20EEg1A8/Wl3QYxcsBKtq8T1X6Uoi07oJ0qnK2A9eOt76OJc/vVfhSJNfSELSBy2plDTLS9fNgcQp1/Evq01DuTB9XzbEk9PZsk2wxFWbSxt6pBRcTmJnWx1z3unaj1yqq5epLmslQ7Ixh7zsA==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB3837.namprd13.prod.outlook.com (2603:10b6:208:19f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.19; Mon, 26 Apr
 2021 20:28:58 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::ad8e:90ea:1f15:2aeb]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::ad8e:90ea:1f15:2aeb%6]) with mapi id 15.20.4087.025; Mon, 26 Apr 2021
 20:28:58 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH 0/1] Generate uevent on namespace AENs
Date: Mon, 26 Apr 2021 16:28:41 -0400
Message-ID: <BL0PR13MB4291DDACF842AAA23C0B71D49C429@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
X-TMN: [SUfqVBe00kkndPt1zr+qkijyoRsINLJ4]
X-ClientProxiedBy: BLAPR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:208:32a::20) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20210426202842.42096-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (174.19.123.177) by
 BLAPR03CA0105.namprd03.prod.outlook.com (2603:10b6:208:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Mon, 26 Apr 2021 20:28:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c020961-f720-4bba-22a8-08d908f1eaff
X-MS-TrafficTypeDiagnostic: MN2PR13MB3837:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfM/QJ4n26vDEYVuaOpEzcNBBdAUneWITVqeTuLEpXqD+AU/ScHdZg6rb6Byw8YA0AFLty/D5Fpm3WA9F+bYD1yUcSFpz6H0iOHRaxWuZHCd8n8T0ImgQjPhsWiul69OTjOnG+JW/qt5sRtbzml8zY52lB0MaCnIy2DfGD3liKitDfI2dKeRN+Zy5Y8mXayh1k4m0w4LymAFIQBdoMa2d48NSxbb+qnaXzk+OkEVG+B7WtjoWNArOSMlMPO8z9X7fwrz2QsiC/6mKF/9k8B3lqHuv4dCiF5SA8SXE6xgaDPkrdPTyu9Gl/x/iW/7Z+FySTVeurdtmFQPyn37TAhenRGbjrtNkmVEXyH15Z3TWOG0qGyym/NHSIizU9Y0YDW7
X-MS-Exchange-AntiSpam-MessageData: vhaBz97Hdy1jZWxmMjOvKQorM10neux8VZsmpaKOB6v6Vg2UlVi89GlIKZp+ZOEb9CGy4Gt8jEWTeFROc/tfi1647X5eWV+EGxuIRn81Bv2Q72mvMDL+Ctx1i0uXGHYIUAYkQnpYQdQJdy8reu3XGw==
X-OriginatorOrg: sct-15-20-3174-8-msonline-outlook-32ef5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c020961-f720-4bba-22a8-08d908f1eaff
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 20:28:58.4378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3837
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_132914_131126_CA949EB5 
X-CRM114-Status: UNSURE (   6.23  )
X-CRM114-Notice: Please train this message.
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

From: Martin Belanger <martin.belanger@dell.com>

Generate uevent on NVME_AER_NOTICE_NS_CHANGED (Namespace changed) and
NVME_AER_NOTICE_ANA (Asymmetric Namespace Access).

Martin Belanger (1):
  Generate uevent on namespace AENs

 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
