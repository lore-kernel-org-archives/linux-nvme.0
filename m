Return-Path: <SRS0=BJyz=JK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6739C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 15:40:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F126128C
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 15:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F126128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2Hvc28zlSk8yOoIB3v6Mhq25qEQQuk6znJGczbrjc9I=; b=Mr+GsxUDMuNhN9xWkJZqdWJ8R
	QH12tGOnbfuxG4ncvyXNz5jDZ8dJ4MIt3ryMh6v56Ffsnasmmr8kTYM5pbP7OcoVfRKqUMc5mH1pl
	UE9miSvaYAr0ZuNp8WuA52uy2oK/23/TLxYL5stXwa+jl0GYxm8XlWtw0xvOfVz1sgIoWOhDy34uR
	tglBsoAqyoK7OqXid7qGGf6P/go8S211r9q5XRrLYEJfRekAPc4bRgenF7mPS8EIaGhRPT9EpR8TU
	UNGFDv0OutjpyTzbXqHd/ERnYTwan2AmnDL/Iu7ZHs7EYRnsBZwCiOJ9JKtyUVtdxIlGya4eF/gpv
	LCX4ZTPUg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWL8i-009g97-5w; Tue, 13 Apr 2021 15:39:44 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWL7T-009g0X-Me
 for linux-nvme@desiato.infradead.org; Tue, 13 Apr 2021 15:38:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=eoUQN1Q1Fzt3H7DtMpUk7mBdT0XGqNWDw9fgRlU1bH4=; b=jW/1rs7QzRLiQ6RgxJXKjzDe6D
 pSjRpPCfyNlAMehvHrVMlcrjMZAo3HFLLv9G65NVvArNhvZd7Tsgxf49IuzFC84ZgVYB8Pdn4xTkx
 iA/9XM/u2u1L9k+SPkq44suUPnTgWwPFU4M5gOoN4Z7x9Y+yAGGMxyHL1tDG1xicti/0ZuqDYjil0
 Vp7FSJLw7gM/ClISM5aKjnBJp6YHqglgsBx6uKu5gXgdkTCz3/AOsTHgm3zlYMKWkAaX2PCYOeF89
 lxthFsFYnyfZK+BdecZSK+XFmUREgl7oV5H+cERRg/hsWuoTcNQSNSYU/7Vjo3VKP/Fw9XeCouZ0X
 WUsFoX8Q==;
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com
 ([40.107.93.57] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWL7Q-0079K4-9D
 for linux-nvme@lists.infradead.org; Tue, 13 Apr 2021 15:38:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMMxT1BmkpMI3B0m7jNwDj2KUhboh7yyPFsP7HDpcI0eudLzKfUKIEYeJH3+42rDFj+YKNNsW5VMGjjdc8UBH4RSUalOxZsAgn4/Enjf+q2MC4THKxt4vEQPmiQ5fxaTy+dUjXr+XmYxEtb9Lh7LUIm74Sk0pGTcYl5baiLKLnYJIHo7U8PNdUelr51YOJy/dLoExHrRfQOqn9ExECKOwK5F9/jdL5o6ivSVHIl0HTH8UihIQ2yND4+5H83fNHgdNzXyZw0NVqQ7IyxCZHqpjZXc9j2wx+iS+ewfD4FdmQefc9cRrXukDqwdfqy4g3uJeH2rMccYzcJRLLL4nnEIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoUQN1Q1Fzt3H7DtMpUk7mBdT0XGqNWDw9fgRlU1bH4=;
 b=V3jWO48CZDGHgqWuO1ZRC+BqzdwOXl6/FRAi82YrD3w23mIrOcJeL/dzq8OAsvaj6uLp0mVnWJJ+OZKtG7B5RnY7+Eu341xCYJQdlK3+Wzwf8OsYmTnZzAI7mTwN2vmijQs2uFfMN2LmED/WgsMLoKiB8bMhbMkFctIpIOey+RdO5U3ZY+NZwRKDvp7mOlCCNNmNYe2cJ2WkZuz7t2Nh2m3xGyLcERyxP65rRXQZ6zeKgmFu4sWpFbCa9skzBCJLdtw1l+/ws5H5Y6UJFWKGz9iQ6lOPY0RUsh9DiuZ8KNgj+9DZZLi+n7fdmiD0mVH0kCKo0KvwYpplPdw6lziOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoUQN1Q1Fzt3H7DtMpUk7mBdT0XGqNWDw9fgRlU1bH4=;
 b=EEf3H1UQfiJopIN2TEWXt2Zr7O/27Sr3EdK3kWYZKNzupz874PUu86T5TW7ghfmsegYOz5FVFoBqlv6OeNKL3TZ1tmwgLOv6bIBRIFjaaxDfdxSF4M6dzLAwNs9cva7uBMP2E7N7bRdWelNxpMlW0NFsM/P2Ez6B9Y2EuwNGhkFXJMwzqUuOqKxklS4wYOG6ySZYPSam0KPAV6bqt0oVHGS1gTX45tTCjvgvRIulexV/pRO3QmMhdfMRp/Kj18h0dASCw0F5M1OTKs43hJa5xDFq/+y99HOiYIlNlqw7gCA9QrYobZ4GmX7KZZ0AtzVixc1PadBHEx4a8MxDmQf63Q==
Received: from DM6PR11CA0063.namprd11.prod.outlook.com (2603:10b6:5:14c::40)
 by MN2PR12MB3822.namprd12.prod.outlook.com (2603:10b6:208:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 15:38:19 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::9b) by DM6PR11CA0063.outlook.office365.com
 (2603:10b6:5:14c::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Tue, 13 Apr 2021 15:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 15:38:18 +0000
Received: from [10.223.2.15] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Apr
 2021 15:38:14 +0000
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
CC: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, SelvaKumar S
 <selvakuma.s1@samsung.com>, <linux-nvme@lists.infradead.org>,
 <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@wdc.com>, <kch@kernel.org>,
 <sagi@grimberg.me>, <snitzer@redhat.com>, <selvajove@gmail.com>,
 <linux-kernel@vger.kernel.org>, <nj.shetty@samsung.com>,
 <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <dm-devel@redhat.com>, <joshi.k@samsung.com>, <kbusch@kernel.org>,
 <joshiiitr@gmail.com>, <hch@lst.de>
References: <BYAPR04MB49652982D00724001AE758C986729@BYAPR04MB4965.namprd04.prod.outlook.com>
 <5BE5E1D9-675F-4122-A845-B0A29BB74447@javigon.com>
 <c7848f1c-c2c1-6955-bf20-f413a44f9969@nvidia.com>
 <20210411192641.ya6ntxannk3gjyl5@mpHalley.localdomain>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <3a52cc06-27ce-96a4-b180-60fc269719ba@nvidia.com>
Date: Tue, 13 Apr 2021 18:38:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210411192641.ya6ntxannk3gjyl5@mpHalley.localdomain>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a914c676-6f7c-46cb-9daf-08d8fe922991
X-MS-TrafficTypeDiagnostic: MN2PR12MB3822:
X-Microsoft-Antispam-PRVS: <MN2PR12MB382272F99D14AC96BD0161B3DE4F9@MN2PR12MB3822.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRwsa/ZIFUJT9oDNfeid8YfEt7/YoQE8QtMVv+aVyWOonUITrXuZO4sZf4Kayz7Q0UcscVaLKip2lSTCVL8v1McYO7qsvfF3QB6HqwCabnf35AQwfCtDTCeZC70bK1T5FkJCUD5J7vowlTC5lJE7Y5YSspQ2/s8wiCk1D9ugm7DnQ4OVU9vXGYiE7dMq/M9nu54ZZLOZe7jHI0DypMUSx8AL4dDZU5Ce+CCAuz2M56KpH8x1Fbpo1HLlQOD2DgkizEYzy5oQGdfxcBI/LmQB1Y+MW4pc1tVYkSPJIfHVeCLpkyh7U6ARhT48n6UQXHqCMb4XSYG79WfXYbItWBz2Nfgy4vl9wOJ2j2wKWP25umGfDRe4lTwEBYhAmGYgxLgAeHPEyDCslovLcCL3CRjbP2GglGNaTpH08GUjzmcINMTeBNKZoAH2dm37oplaU031pDV15tUBkh2Zr909N8RMFU/jTodKdKXbTjDMmbKn7ERJBc8mjdw7h5qI0tZXITaVIgcG4wycy57TvDVNxWYvNR8I7AfaXC69yelXflS2qOWyUMuDL3NWEo+IJegXUMMP6LQhpk5uFZ27P7ILMwzlJSYxzhgZrGv9wJXC/h9wmhBF+QOdcYqafa2p0J0YZEFDwS5LBT6e8j3VwifaKVHBomZkuKEuxCgbfX5HsjK+JEcC/tAsppQTXVtPYSyOwfvaTvYsrCF36cFhYxS7TE5IUsl2pQp77QFC4KATDqXXlwbpE3XEVNM56TSUEVyX5ta7eLBtHqY6NCetEkX6WPvASjEnKuCunuMyHNMqR8HrUXEZyzEsD8IxbpaG1u6SiSUa1r7emgaL8J4QUa7fC9f+/A==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(66574015)(2616005)(426003)(6666004)(36906005)(6916009)(36756003)(16576012)(86362001)(26005)(31696002)(5660300002)(83380400001)(16526019)(356005)(54906003)(70206006)(8676002)(336012)(70586007)(2906002)(31686004)(7636003)(4326008)(186003)(82310400003)(53546011)(498600001)(7416002)(966005)(36860700001)(47076005)(8936002)(43620500001)(43740500002)(15398625002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 15:38:18.7965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a914c676-6f7c-46cb-9daf-08d8fe922991
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3822
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_083824_376935_F2F464E1 
X-CRM114-Status: GOOD (  27.21  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDQvMTEvMjAyMSAxMDoyNiBQTSwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPiBPbiAxMS4w
NC4yMDIxIDEyOjEwLCBNYXggR3VydG92b3kgd3JvdGU6Cj4+Cj4+IE9uIDQvMTAvMjAyMSA5OjMy
IEFNLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+Pj4+IE9uIDEwIEFwciAyMDIxLCBhdCAwMi4z
MCwgQ2hhaXRhbnlhIEt1bGthcm5pIAo+Pj4+IDxDaGFpdGFueWEuS3Vsa2FybmlAd2RjLmNvbT4g
d3JvdGU6Cj4+Pj4KPj4+PiDvu79PbiA0LzkvMjEgMTc6MjIsIE1heCBHdXJ0b3ZveSB3cm90ZToK
Pj4+Pj4+IE9uIDIvMTkvMjAyMSAyOjQ1IFBNLCBTZWx2YUt1bWFyIFMgd3JvdGU6Cj4+Pj4+PiBU
aGlzIHBhdGNoc2V0IHRyaWVzIHRvIGFkZCBzdXBwb3J0IGZvciBUUDQwNjVhICgiU2ltcGxlIENv
cHkgCj4+Pj4+PiBDb21tYW5kIiksCj4+Pj4+PiB2MjAyMC4wNS4wNCAoIlJhdGlmaWVkIikKPj4+
Pj4+Cj4+Pj4+PiBUaGUgU3BlY2lmaWNhdGlvbiBjYW4gYmUgZm91bmQgaW4gZm9sbG93aW5nIGxp
bmsuCj4+Pj4+PiBodHRwczovL252bWV4cHJlc3Mub3JnL3dwLWNvbnRlbnQvdXBsb2Fkcy9OVk0t
RXhwcmVzcy0xLjQtUmF0aWZpZWQtVFBzLTEuemlwIAo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBTaW1w
bGUgY29weSBjb21tYW5kIGlzIGEgY29weSBvZmZsb2FkaW5nIG9wZXJhdGlvbiBhbmQgaXPCoCB1
c2VkIAo+Pj4+Pj4gdG8gY29weQo+Pj4+Pj4gbXVsdGlwbGUgY29udGlndW91cyByYW5nZXMgKHNv
dXJjZV9yYW5nZXMpIG9mIExCQSdzIHRvIGEgc2luZ2xlIAo+Pj4+Pj4gZGVzdGluYXRpb24KPj4+
Pj4+IExCQSB3aXRoaW4gdGhlIGRldmljZSByZWR1Y2luZyB0cmFmZmljIGJldHdlZW4gaG9zdCBh
bmQgZGV2aWNlLgo+Pj4+Pj4KPj4+Pj4+IFRoaXMgaW1wbGVtZW50YXRpb24gZG9lc24ndCBhZGQg
bmF0aXZlIGNvcHkgb2ZmbG9hZCBzdXBwb3J0IGZvciAKPj4+Pj4+IHN0YWNrZWQKPj4+Pj4+IGRl
dmljZXMgcmF0aGVyIGNvcHkgb2ZmbG9hZCBpcyBkb25lIHRocm91Z2ggZW11bGF0aW9uLiBQb3Nz
aWJsZSB1c2UKPj4+Pj4+IGNhc2VzIGFyZSBGMkZTIGdjIGFuZCBCVFJGUyByZWxvY2F0aW9uL2Jh
bGFuY2UuCj4+Pj4+Pgo+Pj4+Pj4gKmJsa2Rldl9pc3N1ZV9jb3B5KiB0YWtlcyBzb3VyY2UgYmRl
diwgbm8gb2Ygc291cmNlcywgYXJyYXkgb2YgCj4+Pj4+PiBzb3VyY2UKPj4+Pj4+IHJhbmdlcyAo
aW4gc2VjdG9ycyksIGRlc3RpbmF0aW9uIGJkZXYgYW5kIGRlc3RpbmF0aW9uIG9mZnNldChpbiAK
Pj4+Pj4+IHNlY3RvcnMpLgo+Pj4+Pj4gSWYgYm90aCBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uIGJs
b2NrIGRldmljZXMgYXJlIHNhbWUgYW5kIAo+Pj4+Pj4gY29weV9vZmZsb2FkID0gMSwKPj4+Pj4+
IHRoZW4gY29weSBpcyBkb25lIHRocm91Z2ggbmF0aXZlIGNvcHkgb2ZmbG9hZGluZy4gQ29weSBl
bXVsYXRpb24gCj4+Pj4+PiBpcyB1c2VkCj4+Pj4+PiBpbiBvdGhlciBjYXNlcy4KPj4+Pj4+Cj4+
Pj4+PiBBcyBTQ1NJIFhDT1BZIGNhbiB0YWtlIHR3byBkaWZmZXJlbnQgYmxvY2sgZGV2aWNlcyBh
bmQgbm8gb2YgCj4+Pj4+PiBzb3VyY2UgcmFuZ2UgaXMKPj4+Pj4+IGVxdWFsIHRvIDEsIHRoaXMg
aW50ZXJmYWNlIGNhbiBiZSBleHRlbmRlZCBpbiBmdXR1cmUgdG8gc3VwcG9ydCAKPj4+Pj4+IFND
U0kgWENPUFkuCj4+Pj4+IEFueSBpZGVhIHdoeSB0aGlzIFRQIHdhc24ndCBkZXNpZ25lZCBmb3Ig
Y29weSBvZmZsb2FkIGJldHdlZW4gMgo+Pj4+PiBkaWZmZXJlbnQgbmFtZXNwYWNlcyBpbiB0aGUg
c2FtZSBjb250cm9sbGVyID8KPj4+PiBZZXMsIGl0IHdhcyB0aGUgZmlyc3QgYXR0ZW1wdCBzbyB0
byBrZWVwIGl0IHNpbXBsZS4KPj4+Pgo+Pj4+IEZ1cnRoZXIgd29yayBpcyBuZWVkZWQgdG8gYWRk
IGluY3JlbWVudGFsIFRQIHNvIHRoYXQgd2UgY2FuIGFsc28gZG8gCj4+Pj4gYSBjb3B5Cj4+Pj4g
YmV0d2VlbiB0aGUgbmFtZS1zcGFjZXMgb2Ygc2FtZSBjb250cm9sbGVyIChpZiB3ZSBjYW4ndCBh
bHJlYWR5KSAKPj4+PiBhbmQgdG8gdGhlCj4+Pj4gbmFtZXNwYWNlcyB0aGF0IGJlbG9uZ3MgdG8g
dGhlIGRpZmZlcmVudCBjb250cm9sbGVyLgo+Pj4+Cj4+Pj4+IEFuZCBhIHNpbXBsZSBjb3B5IHdp
bGwgYmUgdGhlIGNhc2Ugd2hlcmUgdGhlIHNyY19uc2lkID09IGRzdF9uc2lkID8KPj4+Pj4KPj4+
Pj4gQWxzbyB3aHkgdGhlcmUgYXJlIG11bHRpcGxlIHNvdXJjZSByYW5nZXMgYW5kIG9ubHkgb25l
IGRzdCByYW5nZSA/IFdlCj4+Pj4+IGNvdWxkIGFkZCBhIGJpdCB0byBpbmRpY2F0ZSBpZiB0aGlz
IHJhbmdlIGlzIHNyYyBvciBkc3QuLgo+Pj4gT25lIG9mIHRoZSB0YXJnZXQgdXNlIGNhc2VzIHdh
cyBaTlMgaW4gb3JkZXIgdG8gYXZvaWQgZmFicmljIAo+Pj4gdHJhbnNmZXJzIGR1cmluZyBob3N0
IEdDLiBZb3UgY2FuIHNlZSBob3cgdGhpcyBwbGF5cyB3ZWxsIHdpdGggCj4+PiBzZXZlcmFsIHpv
bmUgcmFuZ2VzIGFuZCBhIHNpbmdsZSB6b25lIGRlc3RpbmF0aW9uLgo+Pj4KPj4+IElmIHdlIHN0
YXJ0IGdldHRpbmcgc3VwcG9ydCBpbiBMaW51eCB0aHJvdWdoIHRoZSBkaWZmZXJlbnQgcGFzdCBj
b3B5IAo+Pj4gb2ZmbG9hZCBlZmZvcnRzLCBJ4oCZbSBzdXJlIHdlIGNhbiBleHRlbmQgdGhpcyBU
UCBpbiB0aGUgZnV0dXJlLgo+Pgo+PiBCdXQgdGhlICJjb3B5IiBjb21tYW5kIElNTyBpcyBtb3Jl
IGdlbmVyYWwgdGhhbiB0aGUgWk5TIEdDIGNhc2UsIHRoYXQgCj4+IGNhbiBiZSBhIHByaXZhdGUg
Y2FzZSBvZiBjb3B5LCBpc24ndCBpdCA/Cj4KPiBJdCBhcHBsaWVzIHRvIGFueSBuYW1lc3BhY2Ug
dHlwZSwgc28geWVzLiBJIGp1c3Qgd2FudGVkIHRvIGdpdmUgeW91IHRoZQo+IGJhY2tncm91bmQg
Zm9yIHRoZSBjdXJyZW50ICJzaW1wbGUiIHNjb3BlIHRocm91Z2ggb25lIG9mIHRoZSB1c2UgY2Fz
ZXMKPiB0aGF0IHdhcyBpbiBtaW5kLgo+Cj4+IFdlIGNhbiBnZXQgYSBiaWcgYmVuZWZpdCBvZiBv
ZmZsb2FkaW5nIHRoZSBkYXRhIGNvcHkgZnJvbSBvbmUgbnMgdG8gCj4+IGFub3RoZXIgaW4gdGhl
IHNhbWUgY29udHJvbGxlciBhbmQgZXZlbiBpbiBkaWZmZXJlbnQgY29udHJvbGxlcnMgaW4gCj4+
IHRoZSBzYW1lIHN1YnN5c3RlbS4KPgo+IERlZmluaXRlbHkuCj4KPj4KPj4gRG8geW91IHRoaW5r
IHRoZSBleHRlbnNpb24gc2hvdWxkIGJlIHRvICJjb3B5IiBjb21tYW5kIG9yIHRvIGNyZWF0ZSBh
IAo+PiBuZXcgY29tbWFuZCAieF9jb3B5IiBmb3IgY29weWluZyB0byBkaWZmZXJlbnQgZGVzdGlu
YXRpb24gbnMgPwo+Cj4gSSBiZWxpZXZlIHRoZXJlIGlzIHNwYWNlIGZvciBleHRlbnNpb25zIHRv
IHNpbXBsZSBjb3B5LiBCdXQgZ2l2ZW4gdGhlCj4gZXhwZXJpZW5jZSB3aXRoIFhDT1BZLCBJIGNh
biBpbWFnaW5lIHRoYXQgY2hhbmdlcyB3aWxsIGJlIGluY3JlbWVudGFsLAo+IGJhc2VkIG9uIHZl
cnkgc3BlY2lmaWMgdXNlIGNhc2VzLgo+Cj4gSSB0aGluayBnZXR0aW5nIHN1cHBvcnQgdXBzdHJl
YW0gYW5kIGJyaW5naW5nIGRlcGxveWVkIGNhc2VzIGlzIGEgdmVyeQo+IGdvb2Qgc3RhcnQuCgpD
b3B5aW5nIGRhdGEgKGZpbGVzKSB3aXRoaW4gdGhlIGNvbnRyb2xsZXIvc3Vic3lzdGVtIGZyb20g
bnNfQSB0byBuc19CIAp1c2luZyBOVk1mIHdpbGwgcmVkdWNlIG5ldHdvcmsgQlcgYW5kIG1lbW9y
eSBCVyBpbiB0aGUgaG9zdCBzZXJ2ZXIuCgpUaGlzIGZlYXR1cmUgaXMgd2VsbCBrbm93biBhbmQg
dGhlIHVzZSBjYXNlIGlzIHdlbGwga25vd24uCgpUaGUgcXVlc3Rpb24gd2hldGhlciB3ZSBpbXBs
ZW1lbnQgaXQgaW4gdmVuZG9yIHNwZWNpZmljIG1hbm5lciBvZiB3ZSBhZGQgCml0IHRvIHRoZSBz
cGVjaWZpY2F0aW9uLgoKSSBwcmVmZXIgYWRkaW5nIGl0IHRvIHRoZSBzcGVjIDopCgoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
