Return-Path: <SRS0=9Zwh=6G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EDBC55185
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C780F2076E
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EQf5Sp7e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="mBllWf30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C780F2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mA9WtpzSZaD+fN/jl6LXAmUrV2QrjM1KUxi33SHBPSo=; b=EQf5Sp7e91rYhl2rHvyaKHYSM
	+cjVLd1z/wnSF6XmF9U4h/UH/kVFop/Tzw/W5A7sIvlO6pZ9XgUeB/ouAxViX+LWcWx7YXuT5FGUb
	k0y9Y9sjDDUTpqkKRsQaKWnXU6DK5rDJT8rPRiN4Rj+tumjUgJoRQpD2qV092MZw49TupqwkHyL26
	QZUjRNRiSlyg1S+7jP1DE/wg16bWxK0URMQcowQl097CYQHswoLLlZy/cZv5ZXub/7thoWyyrfovP
	zocXP0VMkKKABUmuZFORsjUYi9Dts6LJ9q9KoZm+AVv2RfsY5yrFgP1oz2pMXA4W3Z07naYKcLFES
	9tKRi6W8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRNXF-0000xn-8a; Wed, 22 Apr 2020 22:08:01 +0000
Received: from mail-eopbgr20076.outbound.protection.outlook.com ([40.107.2.76]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRNXA-0000v2-Kv
 for linux-nvme@lists.infradead.org; Wed, 22 Apr 2020 22:07:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIcts24ba/K3o+9kTqqJSNQjDocTLnxa7tuBUn4MOAJia5Md8SG1tObRYIMB17zQuZihX5wVl8MQWCwtWV/8hgUz7AzBvIj2fIM2Ri6/rdEGLZhtu6h+6vPnTWedjtwyl0Xzc8Bk1RmGPNiQjALayatCmpciXhVC2mRHOImlBShnbCqlKXkGQpmbsR9EJdIBlWbZXPZGTaNySdsF9p7gNxnsELqO1cPwoqU0mrSWtXAcRfqdfESQ3NiK6uNWdwMkc0mHZatpOsoO/7Q6TpW3J+pXWJ8pPTRUnTrLZDsrt5ZKV5ksIJ1kU08nBASaDUtgoXX66+YUf/NGTY1fkCT2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfeScfucmiTzSqAdnRGSl3Tlge0R87qRwsWI4JEqP3Y=;
 b=AmyZzfmnXAqjlXzjlod9LOEj2RXn74Nnnh4kvIR6rlMy2R/uARjbjbSeHjMpiGJeYVCOK4Ct9lMXQFTEr8r3DoKR1fGjz+gre7XCL0ihqzzD/w9KdgAenI81b1QxWx51yJooIiYVPMe3+M5zvzQ69PiojF8N6DSsO3+QoM3WW7FFkIFNXiIulWXlJy3/jRTBiYG/ugqNh1SqpX9Xvd/VOKo2qFf0DXT9nkE3WIlPq20oc+mXHcd73XnTEWp85R1j5d4qbU+Rv4lKu9k4bLCl6OtUeqaIwIjHuzlAqSwTsh+pgDFJCLGvwucJ+XszfhZqW8QITKj+TxNNvmQFKZLGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfeScfucmiTzSqAdnRGSl3Tlge0R87qRwsWI4JEqP3Y=;
 b=mBllWf30HRKMJi+a5DovaYOf2ZKNaix+sOKAmalXGlorj5EFpEjGztbamIhw1yW4wKtNuSXraQyeFNsXlP0FYqd/HKvV+1FKc2WhfyevBOGDwpHTImT9BcsxYMWYbOwHYjRO4Odqi/AZoWJ02nZvGZpYmFIIjL5WL/6mdXfC/3Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4737.eurprd05.prod.outlook.com (2603:10a6:208:b0::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 22 Apr
 2020 22:07:51 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 22:07:51 +0000
Subject: Re: [PATCH 05/17] nvme-fabrics: Allow user enabling metadata/T10-PI
 support
To: Christoph Hellwig <hch@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-7-maxg@mellanox.com> <20200421151747.GA10837@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com>
Date: Thu, 23 Apr 2020 01:07:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200421151747.GA10837@lst.de>
Content-Language: en-US
X-ClientProxiedBy: AM4P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::16) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by
 AM4P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 22:07:49 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab260f7f-883f-48eb-2b3c-08d7e7099969
X-MS-TrafficTypeDiagnostic: AM0PR05MB4737:|AM0PR05MB4737:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB47372C589C7998CF2B5CBEF2B6D20@AM0PR05MB4737.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(16576012)(6486002)(2616005)(956004)(52116002)(86362001)(107886003)(4326008)(4744005)(66556008)(6916009)(66476007)(66946007)(26005)(31696002)(316002)(5660300002)(478600001)(8676002)(186003)(81156014)(53546011)(36756003)(2906002)(8936002)(16526019)(31686004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjQMc0wR1lPiWhfHy1bpEfh9WOB75be0MnYHxl7YGpiPK8um2bI49XHWU7Uh4jhUChnqTJ0sZdCGEQY+jwKWhJY+IO/4hnSjOuPLDmY9uCj+pZcjpY4kudfeb9k16X7zfPvf5MWA5w5fEfV1yeLdrIruJYYjCwOt0bNwzGQuKTCCnIxv8cr6sKX/XWsx+OsaqfkyRdy2pLWkhty/euzxzZeL0nbKtGlzwEzXgYNOMUp+NuTX4xLNpzbDJwOicSDngReS5XhI5O3+4gIRCM1/j488jpYdrm6DrhvRzprdy0fV/sZCo3IpRZWXW5OkJWNJB7ArOEtaJgZjFwW+j4Tb2JkxFdOBAJfjFSJJ0bUR6WugG6R4T/0sVWlkthn73VUBDP9cnoDPmYzebocn1fZ5/UWb7JR/B/vNZ2lQkmO9tNRDss7S63S/NTGvHXgeiSB3
X-MS-Exchange-AntiSpam-MessageData: vK/9zR1NPVf24+OuyfvfQ282zfqRZYdWXk1/DwL/t0nxBTOkLIGiJBjZNaTtrOsb78ktNDOExnqJVr0KcfOwezTUjvEF1nYWb97TTSbwzhJgyUpqhVVgv3PXPItwLLdYIJ85te2eMpQoipeEXgk6PIhM7cOyAQ9VjjfVN1qJ2Qtl9xEs1LXn8Sf3rn3fZPu3hW7DQ8x6GBzWk1F06vbBuGek3pcIBcR/JYf378pCC0QRy8zQxjBZJ5b1rv+hqfrOI7ICb2FpAGCSZOSyFNGRM+ed1kkpODpROC85Kipfz3eqE5JvMKLNjnmIn4Q09GhYq6Rth5O9bpkeQQKqG0D0N4iEhLF33w+M3Dk7RZZUhmItwXYGZvvkucoDxeGxQ+Zni+6UlDNRIQH6dLo3MDgvXIBqH6fChCtAfptVQB6UbG3TvcqahEpS6usWtl8yVixrCZT32Pb4t3SofsSApGawFXat0ABYnADnwigusc0NJTWYPgDVwM7u03OAiNoQfcOcJA9LHKYzdicza+zvLOIVSBSYW69qa9CYVGjvLPjDelpwmsyxL5eDQWQHnNWnJpEBYgQ1xGs/lMwibvppWv/hVuxs8k04aZ/KmWcf/cfrBtwMONe12VqZHeqbd56KxwgPQ5MgIzt6XXWOjHLnbdKDU+a3fC/Yo/D8QZT6gr9m2cyjgoq6P9KJZRc+Gzf4K9pzfT5SC+ndPmykLdjz4xNby+AAq2BmBveQjjnzIyoLqyADdn/oeWDeuzkW1+4LeM/zM65p1Jzdc3etx7A//VNuloeOdHMocVwulS/lmZ4Xfm2yZ21lYjxvqC3TdRoVvkUw
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab260f7f-883f-48eb-2b3c-08d7e7099969
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:07:51.4870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fyQe5aa2RwDgJsst50v7Nrvx0n3UDTOEnTcwQI2GUR7LwK90+8wi0x6sulCuSXrbP+1dlXsVZo98jUYolEQuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4737
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200422_150756_762909_6537375B 
X-CRM114-Status: UNSURE (   9.81  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 4/21/2020 6:17 PM, Christoph Hellwig wrote:
> On Fri, Mar 27, 2020 at 08:15:33PM +0300, Max Gurtovoy wrote:
>> From: Israel Rukshin <israelr@mellanox.com>
>>
>> Preparation for adding metadata (T10-PI) over fabric support. This will
>> allow end-to-end protection information passthrough and validation for
>> NVMe over Fabric.
> So actually - for PCIe we enable PI by default.  Not sure why RDMA would
> be any different?  If we have a switch to turn it off we probably want
> it work similar (can't be the same due to the lack of connect) for PCIe
> as well.

For PCI we use a format command to configure metadata. In fabrics we can 
choose doing it in the connect command and we can also choose to have 
"protected" controllers and "non-protected" controllers.

I don't think it's all or nothing case, and configuration using nvme-cli 
(or other tool) seems reasonable and flexible.



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
