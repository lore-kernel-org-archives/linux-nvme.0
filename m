Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577D8C47083
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 14:51:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF9F61159
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 14:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF9F61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5b622hxU0ioqlMjBB/wdbn7uTucM9JI75XBzMEqpnbk=; b=cwySPPW+eSEI9WuTi3T+RycK9p
	pg5pISWYDZbW073+98FqnS30RE2CNRJw7exuGd9x7O6m2XTupEVb7zIOKoc3Y0uyJmjqZ8OS2mTZo
	Pad8uK/BIVg+LOMYm/dTTA5Gj3blpTQGUvPSkhhSf29IkK63s4th03uId7PMtlZ8vpNXIvyyvnFwi
	AeLAUWgkas7g0n/1REODJC77IR8nlBaWsiYrGzotaFwpaaC+f6wqeaG1hkYeBwtYAcTlnADSUhPbT
	kCOiEgODK54rfZ76vYCWRaQmqw2pbtDgGXgEucxHM4jSGy9QanVCCFzCmia7SwfgeVphmJbYfL6DC
	21O6M/VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loSDU-004h9J-Hh; Wed, 02 Jun 2021 14:51:32 +0000
Received: from mail-mw2nam10on2083.outbound.protection.outlook.com
 ([40.107.94.83] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loSDL-004h20-Us
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 14:51:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTLVzN7e66NoVgvdJMIG+/1YGl2FgnCavq9mSgPgvlcq/zwQ3QxZHodrB+0nmNhch8IrnQiCtfHJe63It5mf+nEs59VGWUnQMQ0QlJmfxd4CWXdTzwNePaWb4M6BKZot6rtzoLeEvocuDlCpvlBejB496JQ9DKeJ09H9+8PhGrton2F9j0pt1mkJLEKeJLYylBM2A8HDy7qv5nhHsQRnO1Z91fd/92eiPjXGPGQ2LzsQGhkmvwPSF832Rj61E6kaaK4dkCeOmblWei3UZXngLANQuMJong8bEWYsARFDXjWL2qZZAzyUFtuclp3c3sJ00EP2GI+EgPmzd90duO90zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ULJXLHdulZUZclQOWwpize9zFbG5RM4pFW4+JipfN4=;
 b=PUjozCwlv8J1fE5m0PTpKImMz5IHUCZ8spEXV1f9DPXkvmCR8iEyrDY63zNUOvZtATffqPIUaQRtReCklG3F3/Cr+JFd0xyYcr4sEmVMZ0pM7s4prAj6VeK0suTK2mfvFkOY1f11o5XpBf74v7ttsQzsPJIYB2iguzcUrcVptLneaAx9ChZbcwCfhZ5J/H/gbgI9jYohlONvJ7R0b0q2GbKYKKkE+T5yx6mZgQjnOvi91IvLzZYukHbmILQV9d8hAYXHR2swKfGh981MIeMRA+RHz2e6axiSaNbEh9OayMCvKwHfUJXgznzCi1CGzwDhL3YSJZ3eQ9Ps0otUexE88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=deltatee.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ULJXLHdulZUZclQOWwpize9zFbG5RM4pFW4+JipfN4=;
 b=tJtmNvI2NIencBwrGHbINGXPQkwOanPRVEdpxXKhMgxHvsUA24JplIWJ8RKg8h0a9yAPPn10rdZFNi38X0VI7HhDMIoxXaizUqq9HJ9E5ghcOcPb7CCz3PNzaw6nEy0cIL2GsjzR8bFznT9ly4KJthZlAPfqvzmlf6qsVGWJWv9O+Ym6naxvWBlybRVtYVmSJdvcpyZ5pafB8T+SYsG7KoVd6DPkuhCvwXHfbmArOUFswPyTOLkrMV4jWRp2i7UnftWLJlTOh8k062KqjefRlvjY5P7siqpbePEZ/r4flj0U67/YaDns+dXbJczySK6OFgDm95mgMFdxXv5crqO8WQ==
Received: from BN8PR12CA0019.namprd12.prod.outlook.com (2603:10b6:408:60::32)
 by BYAPR12MB3016.namprd12.prod.outlook.com (2603:10b6:a03:dc::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 14:51:18 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::48) by BN8PR12CA0019.outlook.office365.com
 (2603:10b6:408:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Wed, 2 Jun 2021 14:51:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 14:51:17 +0000
Received: from [172.27.1.6] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 14:51:08 +0000
Subject: Re: [PATCH 3/3] nvme-pci: align CMB size according to P2PMEM alignment
To: Keith Busch <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <dan.j.williams@intel.com>,
 <logang@deltatee.com>, <linux-mm@kvack.org>, <hch@lst.de>,
 <sagi@grimberg.me>, <david@redhat.com>, <oren@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>
References: <20210602111055.10480-1-mgurtovoy@nvidia.com>
 <20210602111055.10480-4-mgurtovoy@nvidia.com>
 <20210602143940.GA5751@dhcp-10-100-145-180.wdc.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <9ff88c55-2e9c-3cec-81a5-b47b344815a4@nvidia.com>
Date: Wed, 2 Jun 2021 17:51:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602143940.GA5751@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6ddeca1-9dce-4b3c-d51b-08d925d5e085
X-MS-TrafficTypeDiagnostic: BYAPR12MB3016:
X-Microsoft-Antispam-PRVS: <BYAPR12MB301613D54DF6DC5031517EABDE3D9@BYAPR12MB3016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /zGc0WPxquroDtQRbeI9ZV4AePLZJWDmPSS99/b+b8sswrPGnhlyHraLCn1Hub4DHL5579RiTh/07X6VAq06r7gk1dSMJjSOwWURPerhpFaA1YHOqHYNANvLHOWxprpgjOF+PY+vhq2LFezwcD7b1hMpS8lrQA0z6GrgCIP18cFQOQG39FDhB+hgWU8Dr+RIxsTi5MCNGeJ/7AUrx9oJ+DQmF6NifUHnuN/xYRAqpnmTULjNWURBGTXpMx9fjVxXB6Ry4Vz2OcSVEZh5FvVY6CsfKKXQGf5cnDQCSes13NNSl+zYNWUgjtUx4Zir/TONy3bShhSiYPuqrFOWjdVPpxhgtegwFW8fCKjeDG7hoCt7PPf03t3cLlfzkDWe1ikxvEj6JD2lQ8TlMC5aJOuv89tyNRn4DmBE8MQDOlzjgHZCEppBbHAhufEeFWeRm1T/J4oQQIu+k1viFRgRsy3WXqCOq3+3jP6buZ9x9/snZuY5HXrw3xYyLXLEsS/PnLbqt/RId4RLASE9aJbG/ml26LCR1KF6jRKmV8Jvh8d8N4awtFCp5n1ptDNftYKlX+LIuWsU93+LqdsilO3Fm+Iz8h4jZ9+7rIoXAfGWim6MtP1sO0xGkz+2pP+pVeH1VwPhBbtZB6L6OvWkzdXyGXOLT5MIyMQ78ylg5DO+Y6LkEocytO22kmr0bqQ27VBaNOLt
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(36840700001)(46966006)(70586007)(7416002)(5660300002)(31686004)(82740400003)(4326008)(86362001)(31696002)(336012)(7636003)(70206006)(47076005)(54906003)(8936002)(356005)(16576012)(36906005)(83380400001)(36860700001)(16526019)(82310400003)(8676002)(478600001)(6666004)(26005)(186003)(2616005)(2906002)(316002)(6916009)(36756003)(426003)(53546011)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:51:17.3155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ddeca1-9dce-4b3c-d51b-08d925d5e085
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3016
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_075124_045032_CBEB7127 
X-CRM114-Status: GOOD (  16.82  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 6/2/2021 5:39 PM, Keith Busch wrote:
> On Wed, Jun 02, 2021 at 02:10:55PM +0300, Max Gurtovoy wrote:
>> P2PMEM is using mhp framework to connect to the memory subsystem. In
>> case the CMB size is not compatible to mhp alignment, the CMB mapping
>> will fail. Use pci_p2pdma_align_size to align CMB size in order to
>> successfully map non-aligned original CMB.
>>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/nvme/host/pci.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index a29b170701fc..1197263b4cd0 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1817,6 +1817,7 @@ static void nvme_map_cmb(struct nvme_dev *dev)
>>   	u64 size, offset;
>>   	resource_size_t bar_size;
>>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
>> +	unsigned long nr_pages, min_align;
> These new variables don't appear to be used anywhere.

oh, I have some leftovers..

Sorry.


>
>>   	int bar;
>>   
>>   	if (dev->cmb_size)
>> @@ -1856,6 +1857,12 @@ static void nvme_map_cmb(struct nvme_dev *dev)
>>   	if (size > bar_size - offset)
>>   		size = bar_size - offset;
>>   
>> +	size = pci_p2pdma_align_size(size);
>> +	if (!size) {
>> +		dev_warn(dev->ctrl.device, "CMB size is 0 after alignment\n");
>> +		return;
>> +	}
>> +
>>   	if (pci_p2pdma_add_resource(pdev, bar, size, offset)) {
>>   		dev_warn(dev->ctrl.device,
>>   			 "failed to register the CMB\n");
>> -- 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
