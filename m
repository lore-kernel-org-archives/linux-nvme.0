Return-Path: <SRS0=mOBO=5P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B4DC43331
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 09:37:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C593920714
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 09:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YJQzF8br";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Q6V91E0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C593920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4FN7ftJhJ5GfH7RFDWpNreqb4dFzsV2fRY8Dl/CdD94=; b=YJQzF8brvtXhPxaVvoAb3B0Mu
	Xtq1GsqbHPxVwscYJjXdRGgTj8ajPkfySHz6haJqR0l/1aT3FBxuCj1opiqbDNvHsZGRqgsMlac3S
	75zLrWbJuIE1ttxEvUj4BTWhonQuWPogDRlX9UjPOrr6Q1XyQjAr3CzdNcz1htAcLLaWSERkxO2+8
	HxuPe+/UAvmZ06dKBy2bKw2m9htJatz1YZGKgVxgcYP+zj14Vt1zuhMWrfCyeCTvQRBqOydQkrDn+
	afDYhJJ8ExuaJ/carjsQ7ZBrLq1Yv5KG4PGyQLIHXIBaT5QcwY5FEX9PWwOn5TeKxGBqN27kxmkrn
	2xAKS21QA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jIqrJ-0008Hg-08; Mon, 30 Mar 2020 09:37:29 +0000
Received: from mail-vi1eur04on0609.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::609]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIqrG-0008HD-Jd
 for linux-nvme@lists.infradead.org; Mon, 30 Mar 2020 09:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCHZhAI7O/gsXKDuJ9BRu3d1saVM7RX78DGpFD4C16hheTRoY3r/dl2SNbfG1+QKrnpdSQdz6NLiBvdm9Zjp2A4Nv4G43/V7RBT1Vbpp4NWWsb8806Pd9oo2jrKoUJbTctA9i7Myi6daOfsTeOhcxpK8dhLUQ/e6SGq80MkJ0uqsdPPU/d6f6gYJFGA04rQjhMpF/CvDY7IKNjvFaCPobImiQfn7oSjmhVwsgaiOJoP9Tm2F93fH8pLEYtyEiBNH+70Ip4Vk6yQqfO8E93qA+9AWQS9bzIZcDGwzFOzme5WeodJPuLh2F28btDPuUqn7Ryy1eR8qRW4z01rJ+O+mbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPzAf+2p1LxBvqX90jiJDaQ9JoafCSsrK5NNynxTzUw=;
 b=Jq4rtIiUaWUx8p8EhP5FcFDQfyzsrLISi2JGvqBA0yZUJ2qB55mNwA3Gd/CJEQCQmGtGBEi8fmcmPP55yytXkKISLmbUqI9IyVQKLUZthndcH0nr4Zcj8SN5KjcR5O8rLaltmzebGEutdYPmH/WMzV/T5QrC3MGXQi73nD+aXhGMpx5LrZz3WFcvz+Qroyqk3RO/xY4k9mWgRcxW5aOYFSgjmLdqD78hj6bAviWDrW7sue8SQHwY6Y0zgA539GXWhV1G+q9gDu/cau8pJQ35cQYLvqDcImouvQ+d2LW56aTIjpcpVPUSJXLmNAsC82xDSt6AZgdTuBLb2b2xKBAjPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPzAf+2p1LxBvqX90jiJDaQ9JoafCSsrK5NNynxTzUw=;
 b=Q6V91E0IPWjSsM2Iz93112tmmlZALWlaUU3YG1+Yqa+VQ5hR4lwCa2Ga8er7kKl8u9hio/JRe+fXRCdgloWVjRPey9jmNkqKQ5bVJnIY3b0yHhFqD5AfC6InaC3HlC70D6x6Wqx/hR7hpOMVWB2gPYXvyPIwd5+rijFsHygNdmc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=israelr@mellanox.com; 
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com (52.133.45.151) by
 AM0PR0502MB3649.eurprd05.prod.outlook.com (52.133.49.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 09:37:23 +0000
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::d0df:a78a:c082:95fe]) by AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::d0df:a78a:c082:95fe%7]) with mapi id 15.20.2835.025; Mon, 30 Mar 2020
 09:37:23 +0000
Subject: Re: [PATCH] nvmet-rdma: Fix double free of rdma queue
To: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1585477302-4307-1-git-send-email-israelr@mellanox.com>
 <39a9e27b-51fa-6c87-8e5f-17f4f7318bd0@grimberg.me>
 <05c7907c-9c43-2a2b-c760-bff0364892d9@mellanox.com>
 <f356a0d4-2e05-f629-ebab-a55e7e0c369b@grimberg.me>
From: Israel Rukshin <israelr@mellanox.com>
Message-ID: <b5111042-d90a-0c48-6fe0-3cceca1b75a2@mellanox.com>
Date: Mon, 30 Mar 2020 12:37:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <f356a0d4-2e05-f629-ebab-a55e7e0c369b@grimberg.me>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0067.eurprd07.prod.outlook.com
 (2603:10a6:207:4::25) To AM0PR0502MB3905.eurprd05.prod.outlook.com
 (2603:10a6:208:1b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.14.112] (79.181.230.39) by
 AM3PR07CA0067.eurprd07.prod.outlook.com (2603:10a6:207:4::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.9 via Frontend Transport; Mon, 30 Mar 2020 09:37:21 +0000
X-Originating-IP: [79.181.230.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2432910a-3edd-4849-27dd-08d7d48df2fa
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3649:|AM0PR0502MB3649:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0502MB3649B4CB3C40E48891803E5FD7CB0@AM0PR0502MB3649.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR0502MB3905.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(956004)(2616005)(31686004)(36756003)(5660300002)(186003)(16526019)(26005)(6486002)(8676002)(52116002)(31696002)(81156014)(81166006)(478600001)(110136005)(53546011)(2906002)(86362001)(8936002)(16576012)(316002)(4326008)(66946007)(107886003)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pmtycQ/XF9UOjz7pA3yhCh7LaRtFVQyGqJywH/gyroQHQJjajucNOcSnZwYF8/W/waatP4YAI603y+sOyoY4r4GjPsqhF2H5TiimRHZmOU6O/iYXl/8HrkEM+Wolf7APgcP4oIHMp0PrvD9ZUULNZvUTicfCQZbU1JKWUq9I3LfcU1jhs0eDinKMffdzV+7SKIjOeF6823kKonUv55wOBO7ADwkenLH+JIX/eEp6iGfZG4mqsXAdCzhjbKsoO/4E81WwzO2wmZuV9lj1+klZ2snstRqb4W1cZec+VuPtkksVWWQ54sQtmmZn+NXk1qMVWxfHH5d8mFwuYKaQAnmhR/4ycq/s+wz8q7OTziXqN84EyEDyYdwmnMawdAG2SOyFXlz163FImry6hIhsaoKm6lu6heHhACg6mIsLH5tvZVHIJc3Domutdv3X5k6SVkB
X-MS-Exchange-AntiSpam-MessageData: s0MJ13miACLe0Y0aWNnZa5lZLow/0pwlocHTECZa1vZVFOMYjsW6XcLdx20KphL7FQsAFJD/k4t8yBGoFeabd1GbQ5ZB73LMuxmJ7YWkqG/6nb+vWfB1YclEzqqYYCh4QrlB3DPxCkcwI65zHK1Ppw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2432910a-3edd-4849-27dd-08d7d48df2fa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 09:37:23.0271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zTm5XQcpczZa1NIVMwf7Hl+PS5AGtAlbqeDUgNDFKEgVwBXV+J2UYQYeLpPeP04A0Kc+EUAvvX9vXbz6w34eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3649
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200330_023726_712310_C856AFA6 
X-CRM114-Status: GOOD (  15.88  )
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8zMC8yMDIwIDExOjU2IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvcmRtYS5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9y
ZG1hLmMKPj4+PiBpbmRleCAzN2QyNjJhLi41OTIwOWUzIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZl
cnMvbnZtZS90YXJnZXQvcmRtYS5jCj4+Pj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9yZG1h
LmMKPj4+PiBAQCAtMTM4MCwxMyArMTM4MCwxNCBAQCBzdGF0aWMgdm9pZCAKPj4+PiBudm1ldF9y
ZG1hX3F1ZXVlX2Nvbm5lY3RfZmFpbChzdHJ1Y3QgcmRtYV9jbV9pZCAqY21faWQsCj4+Pj4gwqAg
ewo+Pj4+IMKgwqDCoMKgwqAgV0FSTl9PTl9PTkNFKHF1ZXVlLT5zdGF0ZSAhPSBOVk1FVF9SRE1B
X1FfQ09OTkVDVElORyk7Cj4+Pj4gwqAgK8KgwqDCoCBwcl9lcnIoImZhaWxlZCB0byBjb25uZWN0
IHF1ZXVlICVkXG4iLCBxdWV1ZS0+aWR4KTsKPj4+PiArCj4+Pj4gwqDCoMKgwqDCoCBtdXRleF9s
b2NrKCZudm1ldF9yZG1hX3F1ZXVlX211dGV4KTsKPj4+PiAtwqDCoMKgIGlmICghbGlzdF9lbXB0
eSgmcXVldWUtPnF1ZXVlX2xpc3QpKQo+Pj4+ICvCoMKgwqAgaWYgKCFsaXN0X2VtcHR5KCZxdWV1
ZS0+cXVldWVfbGlzdCkpIHsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbGlzdF9kZWxfaW5pdCgm
cXVldWUtPnF1ZXVlX2xpc3QpOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBzY2hlZHVsZV93b3JrKCZx
dWV1ZS0+cmVsZWFzZV93b3JrKTsKPj4+Cj4+PiBUaGlzIGhhcyBhIGhpZGRlbiBhc3N1bXB0aW9u
IHRoYXQgdGhlIGNvbm5lY3QgaGFuZGxlciBhbHJlYWR5Cj4+PiBzY2hlZHVsZWQgdGhlIHJlbGVh
c2UuCj4+Pgo+Pj4gV2h5IGRvbid0IHdlIHNpbXBseSBub3QgcXVldWUgdGhlIHJlbGVhc2Vfd29y
ayBpbiB0aGUgYWNjZXB0Cj4+PiBmYWlsdXJlIGFuZCByZXR1cm4gYSBuZWdhdGl2ZSBzdGF0dXMg
Y29kZSB0byBpbXBsaWNpdGx5IHJlbW92ZSB0aGUKPj4+IGNtX2lkPyB0aGlzIHdheSB3ZSB3aWxs
IG5ldmVyIHNlZSBhbnkgY20gZXZlbnRzIGFuZCB3ZSBkb24ndAo+Pj4gbmVlZCB0byBoYW5kbGUg
aXQuCj4+Cj4+IFRoaXMgY2hhbmdlcyB0aGUgZmxvdyBidXQgSSBndWVzcyB3ZSBjYW4gY2hlY2sg
dGhpcyBvdXQuCj4+Cj4+IEJ1dCBzdGlsbCwgdGhpcyBmbG93IGNhbiBiZSBjYWxsZWQgZnJvbSAz
IGRpZmZlcmVudCBldmVudHMgCj4+IChSRE1BX0NNX0VWRU5UX1JFSkVDVEVELCBSRE1BX0NNX0VW
RU5UX1VOUkVBQ0hBQkxFLCAKPj4gUkRNQV9DTV9FVkVOVF9DT05ORUNUX0VSUk9SKSBzbyBJIHBy
ZWZlciB0byBsb2NhdGUgdGhlIHNjaGVkdWxlX3dvcmsgCj4+IHVuZGVyIHRoZSAiaWYiLgo+Cj4g
VGhpcyBpZiBpcyBvbmx5IGNoZWNrZWQgaW4gY29ubmVjdCBlcnJvci4gQW55d2F5LCBpZiB5b3Ug
ZmVlbCB0aGF0Cj4gdGhpcyBmbG93IGlzIHJhY3ksIHBlcmhhcHMgaW1wbGVtZW50IGEgcHJvcGVy
IHNlcmlhbGl6YXRpb24sIGluc3RlYWQKPiBvZiBjaGVja2luZyBhIHJhbmRvbSAiaWYiIHRoYXQg
bWFrZXMgdGhlIHJlYWRlciB0aGluayB3aHkgYXJlIHRoZXkKPiBldmVuIHJlbGF0ZWQuCgpUaGlz
ICJpZiIgaXMgZXhhY3RseSBsaWtlIHdlIGFyZSBkb2luZyBhdCBudm1ldF9yZG1hX3F1ZXVlX2Rp
c2Nvbm5lY3QoKS4KCkFsbCB0aGUgb3RoZXIgcGxhY2VzIGJlZm9yZSBjYWxsaW5nIF9fbnZtZXRf
cmRtYV9xdWV1ZV9kaXNjb25uZWN0KCkgCmRlbGV0ZSB0aGUgcXVldWUgZnJvbSB0aGUgbGlzdC4K
ClNvIEkgZ3Vlc3MgbXkgY2hhbmdlIGFsc28gcHJvdGVjdCB1cyBmcm9tIHJhY2VzIHdpdGggCm52
bWV0X3JkbWFfZGVsZXRlX2N0cmwvbnZtZXRfcmRtYV9yZW1vdmVfb25lLgoKQmVzaWRlIHRoYXQs
IHdoeSBkbyB3ZSBuZWVkIHRvIGNoZWNrIGlmIHRoZSBsaXN0IGlzIG5vdCBlbXB0eSBiZWZvcmUg
CnJlbW92aW5nIGl0IGZyb20gdGhlIGxpc3QgYXQgbnZtZXRfcmRtYV9xdWV1ZV9jb25uZWN0X2Zh
aWwoKT8KCkkgZG9uJ3Qgc2VlIGEgcmVhc29uIHdoeSB0byByZW1vdmUgb25seSB0aGUgcXVldWUg
ZnJvbSB0aGUgbGlzdCB3aXRob3V0IApzY2hlZHVsZSB0aGUgcmVsZWFzZSB3b3JrLgoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
