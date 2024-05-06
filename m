Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D4BC10F16
	for <linux-nvme@archiver.kernel.org>; Mon,  6 May 2024 12:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cARjFm4dAPs0cL8Zs2E+ekrxcphDgk10Ml6qxh5wFjQ=; b=TvqKoRhE5PY7lxnzQPi35HBkjt
	qu3UqfIXgQRZy+IiHUzBE1z/ic099dP5xis5UUXMi+a3sQG/TaGdcNdpPtF0t7mp9r/asrVQ4jbF9
	EgbPCWgR6l6HavnrnVCc0/1KkjgVWmuNEMvuIWh41jxnyq7zXS/75F0IZfzCK8+ijC2LCT8BzOjNs
	VXdQfRc22sW6ylPv0xL2ONGp+vBaLph/pzmGJKMVfTBqLRZTYbsCcP3x3wXUbNZfQMMupV/G83hLA
	/Uh+VD5Wq8aZPkN5gNrsLByQ+zOvmcPCDzMivzQXpNKQRKK/AJ4LVvJObPmi0AehoMjCEq0TUzdqa
	mbRqBBmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3xSW-00000007Haz-0Q27;
	Mon, 06 May 2024 12:28:44 +0000
Received: from mail-dm6nam04on20600.outbound.protection.outlook.com ([2a01:111:f403:2409::600] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3xST-00000007HYT-0Z6b
	for linux-nvme@lists.infradead.org;
	Mon, 06 May 2024 12:28:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0FBtSbiynSoBEh7+s9UK1LciSJIOyh+EAvIGsf86Wy3eCi6R2T0k2d9TSjC1J/sciXk929oduV2EVDQeOWSTVhG5Yl19bgoyF8tIohY+WF2MrzatJg0+mt407gvK/au6C+wfCT4dRrcR4IoWGDDpfmsl9bob/ZqoxPR9IVUuFxRFrHcLvsbvvsHWiKbZyEkXSE3LVs+DcYDgjoA7Coo99gbWH2ZjpvhdiRP/Jxd8hePbaiIiQRHI7f65LvTQaeunwKv8IQkrp3BTMOM0GlX8/p/WjEv4oMiKt8NcuywrbTcMUI9vt9SmgfMJeooRBr92BlRQlCa59/fHtcogyPSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cARjFm4dAPs0cL8Zs2E+ekrxcphDgk10Ml6qxh5wFjQ=;
 b=cQU9+qHft+Z9KF+HT1Dms49j6Q6kca186n0u/7BCuty5AZe+CozFJ3AQphi/svuvPSWbx0qLUEhbaEE+mgswdVLPNlMmy5vevSsCaIkD6bNhe7bAHmDjQ0C2gWMr0PNE+fFtYi2oO8HR8/dS/cRjxrnDp59MIECn2eTJCP3IoA32//eZF+VPAZzwRhJcK08BasCT9kEUBlsXLU/4mP8N4ab7GZaFNFrX4//cgfDcahKXMDBuyUrvIzc83LgAAaT97B+/WuG4W0gOn5Y2tVd7p2BE+luF+QGvitdswcTehkpXyLRuFbEFQS4eYxuUpdS8c7Or6/gQf6D79PxMHGo7kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cARjFm4dAPs0cL8Zs2E+ekrxcphDgk10Ml6qxh5wFjQ=;
 b=clTcpFj0OWK6RihWCCmEZBmxivOcf1/vIAiqfWhg604MvKD/tMfypoPCOmMJ9a2OObufqb50DauQGrpEB0sz5ZASy8V7MWEUYAL6kVt2jWiiEUYrk6GK73eE3BZu/T6prFJL93GQ3le/h5FAPi5noVN5/4YX0PWm7E2KM+ikvJKrgOD3oxhub/HuilPpuuLQ+yZNQX/BOxuAQnzEl/w09oii2W6q293T3thlMWrIpqEw1opaHpVXgR7OrfbJfKSnNYKdYGB4ohY1XJLlcVCxxrl1dZpsa2e1ZoExjdKaQpoCKG1GSZFBRonc472Cs0O34eszoKsFuiU572EWUl+nCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 12:28:16 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 12:28:16 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
 ast@kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH v24 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <29655a73-5d4c-4773-a425-e16628b8ba7a@grimberg.me>
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-2-aaptel@nvidia.com>
 <3ab22e14-35eb-473e-a821-6dbddea96254@grimberg.me>
 <253o79wr3lh.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <9a38f4db-bff5-4f0f-ac54-6ac23f748441@grimberg.me>
 <253le4wqu4a.fsf@nvidia.com>
 <2d4f4468-343a-4706-8469-56990c287dba@grimberg.me>
 <253frv0r8yc.fsf@nvidia.com>
 <29655a73-5d4c-4773-a425-e16628b8ba7a@grimberg.me>
Date: Mon, 06 May 2024 15:28:11 +0300
Message-ID: <253a5l3qg4k.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::12) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: a4dfde02-df13-49a6-af91-08dc6dc800fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PFfy5c9s/U3CmhY6hBC1ESQB2VL4yZcn0NXAaLHIuu9Qz829MOJ7mdS3abTI?=
 =?us-ascii?Q?kzYYrKhJSiv2OYEWOwBmBemSGxDq2q0b6oY3RaXry73KGshdkFGs5Pcb6ttO?=
 =?us-ascii?Q?ROFBfJdmGIe9VjCDk8V46WC64kLeXix1HJUnnnhqTFROqJjK6ujjfG2fAUEY?=
 =?us-ascii?Q?dyNR8M2G/XhfSIVBX+MyWyjSjum1ybb4bd7rFJSXXwYdSefqbUfgY+dJNJoV?=
 =?us-ascii?Q?5jucxcYBzIw3R9h1s+xTp1pfmQg0eebaZln+fCf76EjaDULNOShcPUoS9ovr?=
 =?us-ascii?Q?GAEsyZGISef8uMKztPZzhbTTldMm8iIZuWkZkZgpx3M1n0gvGZWJvWbvTORL?=
 =?us-ascii?Q?0hE9rqfXsdpx0qXt03u7OA2juQMGI77Ibb87ik57gmYTB/e/iXWeKeVmGbMk?=
 =?us-ascii?Q?45hynQFESCYczsiYYOEahpoVkUFfp/zI8QQ6UYm6fIf1Y+eWVJmwWG+K7RJl?=
 =?us-ascii?Q?FssnlKJSCR0jp4Db2aoQzWv9Fx72+JE3P7VMyw4KN5WU+pZWAdg7XSr8PqJA?=
 =?us-ascii?Q?CCsJsnrLzv0KDMbuCugvwTrvK1Li7dWiJNkC7mMsQ+O1LkyX5FT5cyU4etyv?=
 =?us-ascii?Q?Ms3OC3TBJ6QA3/mTwQ1jQ0+aMfpVcbNLV8T2gU3idB1pcfO8DjqsaNMmqfy5?=
 =?us-ascii?Q?S1QHS9hAZIv8nTLDvPd5A51sKpjm+ne8orORprKyEhk8/Zo17lCFeRgi/KhH?=
 =?us-ascii?Q?Am6OspaeDnTze2mM9iY/0MmAh/C93gjEeDhtB3ifQBvPFzvqTybzNk/BtbCE?=
 =?us-ascii?Q?TsF7FXILxNJyO/ByOqXFYhbUdz2pIUjffsEKSXsRWVpLLTfcJ2WWGAid5ddG?=
 =?us-ascii?Q?LehtRzdjOQtjLPvIrIRJa9XowrjZZL3ENn19xs5gAq8eG7iIO8YLa/Cz8dtS?=
 =?us-ascii?Q?3FFw3SkSpyw2ccCeURvv1evpltAnniLv18zZ5g1+ltduTrRTYWkiTyEwgtGK?=
 =?us-ascii?Q?SbY1RhPHiMnVmJ1x0mZ+9CM5snyrCUIzpwyXV3uCmql0ONJG5vKNNY3zJaL/?=
 =?us-ascii?Q?GfIoZqcyYY6Dt01AEvEHD6mGQAN18SFj0NGo4qIUJUIgLyT+x7CshYvyWmBv?=
 =?us-ascii?Q?wcvNYqxcBTQSvsCPPv7oROHb95b+4sPgSVqMv/WzayZSBFXNSWdoqc1f93i0?=
 =?us-ascii?Q?68n3JlSnHvSGmb+Ou1fZBuMODa+k4sXVcVxN8MZ7Mv30G9h/g/yl9actgRlV?=
 =?us-ascii?Q?jKEM5+JivitNTSQk+PaQ5YgdIROINtr8pERwyZQjsIZ+xlGp1SjO5XBQEjXw?=
 =?us-ascii?Q?knApU41CCu9BXAB97KtdRln8ed0REHWGKKHitYOihA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UAvRviZ4qhyJydZyxeAoodsgj9wFFz+osKNvSi6b2/7UF8cuXWLBauyc7LTk?=
 =?us-ascii?Q?s/tvLTU1e0uK9LSXbggvUjSaLQ60pAtd4RKIDxGEMCyiEYZjq4gowk+F0tIT?=
 =?us-ascii?Q?X4fqSIuhKconolPRLtTPFIL2k5/cOimxqtAYVarah4o6TnV2MYXuHUTQJl0K?=
 =?us-ascii?Q?ttbvWEdZdLgv1v2EQ/NPKra/tu0GGEznLOZozfT5+61ko9wHkVUkYJb0uWVf?=
 =?us-ascii?Q?8AXaqmP9vyeh7xwcjhPy4RAF7dC3MstSRTNKoY5ZFT8evjzFh3Kdow7usajM?=
 =?us-ascii?Q?wgGoAqf7LN9SAIjkjSB3QoQUspwS0cNjUHleFEGuJVbCCHAQIHws1edws6yN?=
 =?us-ascii?Q?Y50NF9JCgfRi2E0TW7kHsYpy93MyDMi7atuPsLN4FOFeD32B5+N53LFNDjnp?=
 =?us-ascii?Q?UZUKy2B0JDsrTqMQeAQBJMeEqQu3RJiwnHofenkHVR8LGYgCgJp4uh0EegMU?=
 =?us-ascii?Q?Lx6jhhD5Llu3HMHHWS3CazhXMZZ8ZuuF6pXtwpS5YHA/0qX7EevSx9OVgn1p?=
 =?us-ascii?Q?ZOlimTYPZNGSC2s61HRI6PtPXxs3CbdY+lR4/puLTknWw7CQIDmUBtdp8eUw?=
 =?us-ascii?Q?V3LqhFuFnTyj6UR27lIggS7bCNvgqJj7O6H9pEbP4n7RGBsjFhGhN1+1hqhs?=
 =?us-ascii?Q?Nknca4sNjDifAHa6k/2ceVDvOimDKJXq/4pfHxrgOra3BNHigvXyfkKqL174?=
 =?us-ascii?Q?9MBpHPwp/FN+8ImscLLALuo3LF+ZRUpONXuhkIZg0y/D17bXirAW75wUk9l8?=
 =?us-ascii?Q?y9/JVrryDJfmlm4henh1ci+jO59ikk9Q3JY6JPlzkZdwG8Ry7FBSKqUM90cG?=
 =?us-ascii?Q?/th/UXIIpNiMdhBDY6KGPEsylGvM8Jm09pFdO/eMyRkzyDHV8PrMElGt85C+?=
 =?us-ascii?Q?2R0YzC7GUzshIARzgLkuAjmqupEQrO7ZQMUC54u1xGY7AOK5ZQl1bXqH7alX?=
 =?us-ascii?Q?OjtTmb502HSg0bR69mRfK3DkxfysIUwyFr77ZTbdwKQbxrxvidJJgGuEUmBm?=
 =?us-ascii?Q?mqZ41BRdVL9d2gQdcH4iHENPmfZJ8nEoAazj/INcvyy9nesDATmuz2Lh7Ma9?=
 =?us-ascii?Q?ni+Mx1nqb/99gm/mEsKxjBC0+/zbzc6qWnxSoFu9JySlFeDnDYYESMliwMc2?=
 =?us-ascii?Q?x7EBmLWVydQS/ETl/1spr8R0K3kc99V0oW2o5nsMb15axSe9qGl+e/b2qXZm?=
 =?us-ascii?Q?fEQ9z8JYpE0cymaa0ys1scP9+BaF3nXD1KIRE98omcWr+HMmMcX0Cq/RVdbp?=
 =?us-ascii?Q?P4pOTS8W961ksFMuZxgKg1FxalmLaHAOpegKQ47HelwAmSCkBbLToF0X1x4R?=
 =?us-ascii?Q?xOUNdnF5oolaV9nWbyOPvhgkSJ4GO1tdsX/uxI0cILVSNEsIMQifBUBsjWMF?=
 =?us-ascii?Q?vdbmZSL1qP7EHid96FqLCIakBslMyRlwAhEKDN1Gna39W670DKhuPGNGAie2?=
 =?us-ascii?Q?B46MGVMz8LM+2pcxXq/ukV7OqyrMn7SDtb0d8AAnMSFCfKkxJVvovvRD+gBN?=
 =?us-ascii?Q?GMJFS5MG+Fwt1mL2Ff55KaYysHHy6OSF7B9kBHw99FheH2VNQyTE8kS604ex?=
 =?us-ascii?Q?SeWCI+Vl1c042PjWdLf9pciO3ZYgxzjEOk5oyU8+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dfde02-df13-49a6-af91-08dc6dc800fe
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 12:28:16.0267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LicWK9v8AAPQK2GdEfAaiVmq1wntjkO5Lv3D2yEji4WYs39UZPgcmSk9dt3mfBiOM9F/v6uNHmdnc8/ISfi0IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_052841_205361_078BEAD9 
X-CRM114-Status: GOOD (  14.73  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sagi Grimberg <sagi@grimberg.me> writes:
> Understood. It is usually the case as io threads are not aligned to the
> rss steering rules (unless
> arfs is used).

The steering rule we add has 2 effects:
1) steer the flow to the offload object on the HW
2) provide CPU alignement with the io threads (Rx affinity similar to
   aRFS)

We understand point (2) might not be achieved with unbounded queue
scenarios. That's fine.

>> But when it is bound, which is still the default common case, we will
>> benefit from the alignment. To not lose that benefit for the default
>> most common case, we would like to keep cfg->io_cpu.
>
> Well, this explanation is much more reasonable. Setting .affinity_hint
> argument
> seems like a proper argument to the interface and nvme-tcp can set it to
> queue->io_cpu.

Ok, we will rename cfg->io_cpu to ->affinity_hint.

>> Could you clarify what are the advantages of running unbounded queues,
>> or to handle RX on a different cpu than the current io_cpu?
>
> See the discussion related to the patch from Li Feng:
> https://lore.kernel.org/lkml/20230413062339.2454616-1-fengli@smartx.com/

Thanks. As said previously, we are fine with decreased perfs in this
edge case.

>>> nvme-tcp may handle rx side directly from .data_ready() in the future, what
>>> will the offload do in that case?
>> It is not clear to us what the benefit of handling rx in .data_ready()
>> will achieve. From our experiment, ->sk_data_ready() is called either
>> from queue->io_cpu, or sk->sk_incoming_cpu. Unless you enable aRFS,
>> sk_incoming_cpu will be constant for the whole connection. Can you
>> clarify would handling RX from data_ready() provide?
>
> Save the context switching to a kthread from softirq, can reduce latency
> substantially
> for some workloads.

Ok, thanks for the explanation. With bounded queues and steering the
softirq CPU will be aligned with the offload CPU, so we think this is
also OK.

Thanks

