Return-Path: <SRS0=c2UW=74=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F52C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 08:29:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0D820714
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 08:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SjHtCVpC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Z4OvDAf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0D820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XPiul1TVcqjLCHgCPNZue4gX3cAJzVlBlhkCFqtbLHg=; b=SjHtCVpCFuzAVTb90CzUqOeOB
	ktA+//l+LtA+nSpEfAtBbCCSmX/tZXR4KGc06Q/1cy5MlBQA5QrW5TGOWO5uoJ6LEFTa7odkE0MnN
	lHGY7qrYOL/vgonqcv/WqyOCBcIOkiRaetxv8Nki4Z0RsZEWhACKLoTtKZxfKSImKAgEkHhnfqucB
	zBWSjBEcvezzdsaER6rT/o7/Sb1XtG8Zw/Tn1EOgaGgvheYSdkXUmf05yxzm2IID0Z+b/ZJzxJ/hs
	93YIPhcN794wMqoaa9kU1+Ur00e42VFOBW84aqMes+lJAkeA3jcOgMXfzDof+Pa0vPR2zY91fTtLd
	epXbtVvtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jkkUw-0001CU-JM; Mon, 15 Jun 2020 08:29:42 +0000
Received: from mail-am6eur05on2059.outbound.protection.outlook.com
 ([40.107.22.59] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkkUt-0001Bb-TX
 for linux-nvme@lists.infradead.org; Mon, 15 Jun 2020 08:29:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXafSSibkBRYSblTZcFAijb+ZvMcT4VGtRngQSFwPLHRh+F9Nnw/TBwIzu1+MD91QMYQ+vibppGa6kJTucN5UbpQnajMZlKYlh57ux4Se7R3Q7fD0Y87iaFxDrYGoR/twCzB6xpfNoQ2KgKQgv26S7z0z72jt3AXINvJ4Xa1kzBA7D8/YjMmx8g0VkyTr9bKNq4ZFR9oJrsMNviks1LO9lvfa++cmSnGMSxRs6cprxtMwaWZrFUgojlcGT85mDIXTgoqqWWeD6yDR6Gjmv5QdoCiUGuYz51A+TRc/FtbovpfEzaGoQjOBjS6Gs7IsIXv6iMSN2F7IYlhfztaOA+TzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLCQpk2yE7c+HuT+Uvq/QgyHSv33cz5/ZgFuwGlGtw4=;
 b=k1mShBJFLPLO1hIjmzo2BdtWVarpvTrkgliYNGANIYMTNFH6WHpIbgjWg7WD6gEXfgrJk256R05MsfEjBviy4rqCXPCME9PKMXEGwbkccyqlJ7MaNm3t+ji06/hh9BSpOABfBVPBDSbAkdVo5sLdqZAC4OlMi4bznTU8qKEN3urxw9eBksXEocwuMgVm5DA6Ge/V/5SH/5Ww5byZR2+/WGQBvL6TbVbAMg3TrJVAUZrZMImqFq70+LIk9Jh8aTTEW8o6xnnmOPmKP2A7qqMOPvCli2XpnoiQ/ThR0+W8r7Ez+aUM+yDdoROGSpSoh92XilKMgcgXruIrHwJkFfw6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLCQpk2yE7c+HuT+Uvq/QgyHSv33cz5/ZgFuwGlGtw4=;
 b=Z4OvDAf/2UtIW+89lt/3gEpIZOfYmRHHujBQJruQDDHx2+g+puvNLsPDNiIHD+ebSeE2LTKp0d7ve0Riw++qg3g5XuUzmLS5ZQCiVIBXZ6Z9Y64fvbyYBrsciVQUkwyV7NrOIihtwpR0w0QoPeosEC7c0Uz7apt4wtPSl6CPTZY=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6548.eurprd05.prod.outlook.com (2603:10a6:208:13c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Mon, 15 Jun
 2020 08:29:36 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 08:29:36 +0000
Subject: Re: [PATCH 2/2] nvme-pci: override the value of the controller's numa
 node
To: Christoph Hellwig <hch@lst.de>
References: <20200614151556.88558-1-maxg@mellanox.com>
 <20200614151556.88558-2-maxg@mellanox.com> <20200615071204.GA21856@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <e83cbfc3-55b7-9268-3aea-a3e54cab094b@mellanox.com>
Date: Mon, 15 Jun 2020 11:29:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200615071204.GA21856@lst.de>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::36) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM0PR10CA0056.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Mon, 15 Jun 2020 08:29:34 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 997d6040-069c-4e10-9d9f-08d811063cc8
X-MS-TrafficTypeDiagnostic: AM0PR05MB6548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB6548E587B69B15EF0BDA2165B69C0@AM0PR05MB6548.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6DsronxrItaxJwHT74pn+D35Mz4DnAI058qADOgS1tsdYKshK7MfUqvHnIJaHCz2tm8Qy1qQGTdjjRls+ssRZ23BqVfJ74XgoqIM4g3c1mU3YWcZz6dVA/pScXPHuZ/llEgX8EdrhIDDR4MQUwpaemHGKTZpbQTspKTtrahiFnrdK3MBU6LaSzwEiODucuegqjIvUW8lHK9rrHFZjg1+Hd3jOFdmFV8miSQfgye4llrbkF9EXEpcTY+oegW8xEOmEH93oylYrEZxBYYu/D9U15MBWdLMZmbEqFJjSGHQqLnLPBNixRt5CHpMk+BBhjkSiusU9Vz9olBZwX5/uYA759OAyoRdgHLqLykhXbg8biuvs3KiGjbX9t5m8w1FMZn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(66476007)(6916009)(956004)(2616005)(66556008)(66946007)(4326008)(53546011)(16576012)(316002)(31696002)(26005)(5660300002)(186003)(478600001)(4744005)(16526019)(36756003)(8676002)(2906002)(52116002)(31686004)(6486002)(8936002)(107886003)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: r16hw3DOQkLP93D3M6tMaqJfFBxGO0EtNp2vB5TlpjK9vUxrvBY0ARL3foczZpjxt0nkcZ9zJHXCTdt0pjUSnaaVgFzqApyQorYSoXgLB3t5P/chLTtlR+VobiK0s96S+WjcnuCmS0X2DPZRHYzXQqs8K8UpAD2eR3JxgiG3EHx3NU2NPQx1BotCUDZteLgRBkf89PA/dfZzmVeFZ4+puJQhuZdbx/Zm8LNGhUe+3S7IvIfTQcuVwsNjzVZM4UQX0L5XdKdZrklfJFAqxZ8Aww0cntYEHkBvakCrYgqttagXSOC03Sq1naKHarczV4AnYjaYFuzAts0+GJt/xXw41xmJ4kwqWnDKM4J7LyCfds92Z3M17neGNml3vash4QPruUlW0CnyPBpqD5XrmblX8ocwwPIcJs0yyRviaPR5V/epbdooW+BeuY9VWT4dkIs3YruJPfPURYAFfRXBEPh7dKEYro3Oa4xFVUjolSyQGUfkZ9gdADlUDnYMoElf1fww
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997d6040-069c-4e10-9d9f-08d811063cc8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 08:29:36.2050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaaRkVXZqE4g/uiva+wzvluqHgOsmEEVxGB0tgufyhj9tAroCj50HFadXrm+gq9cctDzHGPjzxWzIAsL2TlBhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6548
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200615_012940_222802_D49A582B 
X-CRM114-Status: GOOD (  11.88  )
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
Cc: sagi@grimberg.me, israelr@mellanox.com, james.smart@broadcom.com,
 linux-nvme@lists.infradead.org, shlomin@mellanox.com, kbusch@kernel.org,
 "alexanderka@mellanox.com"@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 6/15/2020 10:12 AM, Christoph Hellwig wrote:
> On Sun, Jun 14, 2020 at 06:15:56PM +0300, Max Gurtovoy wrote:
>> Set the node value according to the PCI device numa node.
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> It doesn't seem like we use ctrl->numa_node for much, though.
> For RDMA which initially added this set->numa_node is initialized
> based on the ctrl one.  Maybe you want to add a patch to at least
> use it for the set initialization everywhere as well?

Yes i'll do that as well.


>
> What is the motivation behind the patch set?

For PCI/TCP, you use wrong numa_node in nvme_alloc_ns for example and 
also the configfs show wrong value (always 0).



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
