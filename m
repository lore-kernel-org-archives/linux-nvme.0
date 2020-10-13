Return-Path: <SRS0=D3oK=DU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53714C433E7
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 06:24:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AA120790
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 06:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ha1STI8+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="pyOMDQC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AA120790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IifCpumgrDgrYrK79EX8Lo5lyUh7APQPxxsiXAAYSPY=; b=ha1STI8+BuUCNUiHWWEmCH4Sh
	+jLCPKRE7Gp/Wbsc6M1mB0LR+qJ6ZcI8mRwOiFU2XqS8p29I4YQR8+ZbZqKL5ujh9BD6ER3cVuPgb
	iO5UAMwSamNCKyPoE8ttiKVYRDkyxxgtR1SaBL1/3acfsP5gwIaWF/lY4UWzM9+nmlS2EMWkdbDpa
	0Psdtcwd6cAtqRr7UehHJANR1OVmKu1DOaaosa1fHEHkUkwe5oXn4db3XhIrXAXGd1bjN7/C1QYpk
	A3+vbzEbhVPyP60rgQdbOvfXdWeuA79Emga+oP6VaV2oh20tZYfvKyDsXHlE3PYdUHabv1GDGQ4gF
	l6gGIHyFQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSDjG-0006KB-MM; Tue, 13 Oct 2020 06:24:10 +0000
Received: from mail-eopbgr760070.outbound.protection.outlook.com
 ([40.107.76.70] helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSDjE-0006Jj-11
 for linux-nvme@lists.infradead.org; Tue, 13 Oct 2020 06:24:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ec7kKykXMbluI5LeAroTuMBx+7C0qrp8qxap819u2IyeJNk7LFUUFJPn8XTJB69rYEwkh1U5R+VzSCw1dReXhxp5Me1+wmDUqJJ7oycwYFnoy9315Q+WuEzNPpWmBxoxmBU2rXAoHCiyvnLB9rhMrneRCrM+FVZLDEwkM/00A2E7cKrTw2nfHmxteRPDq9QTikNEcxNTUevLpXXmUURQlqKQBL3WtOy6hX1Uhzx4EM2Q9GcpieL7WDJHbZx0XFM7GASlCaRUsBHDtzCwGUaGm5E2O5orBLWjvcopOcQLPjXL/hZ8OxmjrsDLqR6NtyPemDDrQec6HNLhu5gY1UHV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zykVXvx8B63ONER3KuH0uaDPyqFMUz3A3/pu/Cs4jkw=;
 b=FO3AoozBGUCnhJiS2es3THxvrSyXDjDZ/L/yBPdSmlm+G6gEizA1vEsqqsRBYfwOF5PubQ/7p+RFeBrtSKoWo1y51V51Y/bM1G7TGKoJndXlgdv/Q6lO1xRIOjnP1I7CaWt6oYGECSI1gqF3tag19rbA64t7WcoE5KqJebqFlEAxTPxdya1FcBCLR5ZID7emT76efA+uF1AWAfZKvsitLkT70mbPivhkmh3XBj9kKwJDqRMVWBxyzWEAiNgMckShkV7+M+hYt+M6zo1QdNf/oZzBn1E6jDsmGBX+blK9OLAA1/4dVf3fduoDpZRIzmlkHxbtIj+ugcG4Jn2V7T79+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zykVXvx8B63ONER3KuH0uaDPyqFMUz3A3/pu/Cs4jkw=;
 b=pyOMDQC/+KrzDliJf/pEzbl1XrpcCp4Pd13rMmFfm1Hdz61X7zoP8pS78Qr74mulZc2cu3gsw7+tRT/9Dyi0u7Rf/pqE4DpK/cVuEiapnF5yJA2zolNiwVEsrqS8N1eytvvRECkEBLVcvUssz+uwyOcbwhzp6vPmVplOh2eg5sc=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BYAPR11MB2613.namprd11.prod.outlook.com (2603:10b6:a02:cd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Tue, 13 Oct
 2020 06:24:06 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40%6]) with mapi id 15.20.3477.020; Tue, 13 Oct 2020
 06:24:06 +0000
Subject: Re: NVME, isolcpus, and irq affinity
To: Ming Lei <tom.leiming@gmail.com>
References: <2a4a5174-d1b9-86b7-f3c8-03b041fa093e@windriver.com>
 <CACVXFVM=UPgJ0K4iZOG=DJNmfovHFjg-u5zQkEFgwG7np5V3PQ@mail.gmail.com>
From: Chris Friesen <chris.friesen@windriver.com>
Message-ID: <c199e17e-2c7d-8010-7648-3d16ed964c2f@windriver.com>
Date: Tue, 13 Oct 2020 00:24:03 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <CACVXFVM=UPgJ0K4iZOG=DJNmfovHFjg-u5zQkEFgwG7np5V3PQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [70.64.84.123]
X-ClientProxiedBy: BYAPR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:40::30) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.5] (70.64.84.123) by
 BYAPR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:40::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.22 via Frontend Transport; Tue, 13 Oct 2020 06:24:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acb4dca0-4f82-43f7-8fa8-08d86f40960b
X-MS-TrafficTypeDiagnostic: BYAPR11MB2613:
X-Microsoft-Antispam-PRVS: <BYAPR11MB2613C1B515234D46BC3A3A27F6040@BYAPR11MB2613.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DHi3mesb8D7EcXBBkr07gE0SVknaaIDIioXc+jZ+5OfYZUOZMwA/MbuKVsNSmC5k+WKvGS1r08jIEHaKqWitwO2wIyCNxb9fdJxnP8BBd3+hcgq0yDzZeIDycuUqR6RJG6FjAQ4xc9z9etCpHtmYwTkTosMlgYJK5c1UScJXT4a/39Je2F//BbNLWh6EYlq3PLHLpx6uN4wxutkSF8e8C6QUPfjM+cHfPNKQvBfIvANbWCtljVEXErw5jF87qoJbzKNTN7Wy+lllEQ5CBHtlRS45KHsRGhnv88JMuOmi2l03uhwNX7+nqdPjF3ej95Fpsdu4FEH2N8aNAIs8fJs5OqbSh82rmBMfnLMZxZAZJOQOW70maffVN2y+V7Yp0sAsHG2woYCI1ao95RpUAVc8INYfmxwLmswXnwQk9Q911+gB7t1YBoLaTAPtDeRr3wSHTnOGm03rxhqhy4y/73TiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5120.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39850400004)(376002)(396003)(31696002)(53546011)(4326008)(5660300002)(83080400001)(83380400001)(52116002)(478600001)(66946007)(2616005)(36756003)(956004)(2906002)(86362001)(966005)(316002)(16526019)(66476007)(26005)(31686004)(66556008)(186003)(16576012)(8936002)(6916009)(6486002)(44832011)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: aZN3DVJXI7q4QDUE3bNa1SYKWOhsJCg3w86PHtvcpGFIfECnugeHxKn4mk8bMoJpvhSMB40eV9EH09YiW7zSaO4Y9D+wbWnMg6Ms5VPgit2eq1u0KVclhV7D5eWkUm0vuaIvAUuFAPrkmrOWQKj6xacjGlzAmxhJCE84LCYeRA20/Odff3iexpjD132iesTIsma8i1lNoTNVMLpil7VKwE+WN46WmPUAoOfakDIDlw3PjCjjYkbeayK4lh/+Ak6ZjIPIbwx8/8+zEi0CMBhl6S4rICU7KWRaDpDVJ3b5K75xL/y9Oxx4+6qaSO3IHBQ7QhTNLKk2QPRSLBNhfpPorV5Wf4YVSPpPDizKglyKJ1hW47YIipVtirI71xIa5WmAEl6/zGVDPCV7ITvW1yuIPNT2A2aEEfqvZxDNIjSIbf5pvOTNmNek24bi3fV50EJMNwkz9AQ2jaJffFWmhPsoCNHUYZsQQxl4zPo0Vwt1Oapoxkko5I0VwwmpTAxwmL6HzsJtj0J4RyF6MKzfP8kBO4Mq3FO5KZcrjOzgeOpo5qGkZut/gv0h3xCUmCowoQzwZ+IIAjCnmRutH/JC3R1ltKgjXEqjB/imkZ8X2IIfZzg3qzYoolXMG51ucjwOqU8aCbeZjPbjHgennTFocO1mOw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb4dca0-4f82-43f7-8fa8-08d86f40960b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 06:24:06.0358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuxkh2HaGctsbeFWDggdUUB2ZEy/squlgIHZl99/jggzFpC6EFagEINBjtcZfiBMGW3DawvzXYbJpHsZDsgrADAqtk1fO+3C22HGhFth8dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2613
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_022408_251785_59C42D39 
X-CRM114-Status: GOOD (  23.80  )
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
Cc: linux-nvme <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/12/2020 6:51 PM, Ming Lei wrote:
> On Mon, Oct 12, 2020 at 11:52 PM Chris Friesen
> <chris.friesen@windriver.com> wrote:
>>
>> Hi,
>>
>> I'm not subscribed to the list so please CC me on replies.
>>
>> I've got a linux system running the RT kernel with threaded irqs.  On
>> startup we affine the various irq threads to the housekeeping CPUs, but
>> I recently hit a scenario where after some days of uptime we ended up
>> with a number of NVME irq threads affined to application cores instead
>> (not good when we're trying to run low-latency applications).
>>
>> Looking at the code, it appears that the NVME driver can in some
>> scenarios call nvme_setup_io_queues() after the initial setup and thus
>> allocate new IRQ threads at runtime.  It appears that this will then
>> call pci_alloc_irq_vectors_affinity(), which seems to determine affinity
>> without any regard for things like "isolcpus" or "cset shield".
>>
>> There seem to be other reports of similar issues:
>>
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1831566
>>
>> Am I worried about nothing, or is there a risk that those irq threads
>> would actually need to do real work (which would cause unacceptable
>> jitter in my application)?
>>
>> Assuming I'm reading the code correctly, how does it make sense for the
>> NVME driver to affine interrupts to CPUs which have explicitly been
>> designated as "isolated"?
> 
> You may pass 'isolcpus=managed_irq,...' for this kind of isolation, see details
> in 'isolcpus=' part of Documentation/admin-guide/kernel-parameters.txt.
> 
> And this feature is added since v5.6.

I suspect that might work, unfortunately it's not available in our 
kernel and jumping to a brand new kernel will mean a lot of additional 
validation work so it's not something we can do on a whim.

I'm definitely looking forward to moving to something newer though.

Chris

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
