Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EABC77B61
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 01:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=fI9rQcWR6mU+/1aYJZGyFexVldl1WppDXinZgWY1slE=; b=hUx+CI1IMCYpga
	uFO603q2GL4IrWn8lhBzj/0B9bRByS9rlQbZhKiMuNPfcAzjNxaJYcCJK2aFI9pTkY6wZdf4K+1lG
	Ol0DanNc1AKLji/rFgo3MIBJ8TcH7Na86kSZw3urufF1WPyZFDJNYYi7swiy7UVIoiIhuKR3Pupe/
	UDy6xPCtK1UA6NUrMkvgT1f33RPg6FMyrXPHwDz/9bZDXWhNMSGoerH0po6T1r5zXrDkShrNx98zL
	4Gf41Si18d2mbb3r9+j7bq+6cO4jwlNETyp/y1C2dVQcZtmVRYW4UCrbCEoRfFNm4F8lttuD9AiG0
	STLQR2YvGh0yzlMsA9ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm2MY-00GAuy-21;
	Tue, 11 Apr 2023 00:59:58 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm2MQ-00GAua-09
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 00:59:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681174789; x=1712710789;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=kkmXcT7IfTeCQ+A0lbAlimBiTvCBNoQXWpyyrflqnfg=;
  b=XoHSygo+KE9J+InE6EX7eEQGntPD50HK4+JXTUeVbOBQ76Yu7HzaAMSF
   g+Ik9bwhnfOSiw0a+dCy4PbMNw6nOpRFI8iuPPeYtMhAZaRwBPd+Z3miF
   Ig1RESCzta4RvIN+owg8QjTo6TyLEBBfqGUO+FpliEBh31m4bH1Clm2wX
   lLOu2THDnaAoe+9jfsM9E21kC9CcLLYYaiO22POdmgMWL7akl3aebTeJ9
   ntoiVVeeieR/ZSXHwGoraqaQVGS9Is8Z2huqDGMs16/6Usn8SCqHj+rDj
   j/xlM7w3EWdYLPA1oFmBTVOjY84u6os0CyzGF6lrNRP0KQCSQsFYHC8KR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="406322221"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="xz'341?yaml'341?scan'341,208,341";a="406322221"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 17:59:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="862664713"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="xz'341?yaml'341?scan'341,208,341";a="862664713"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 10 Apr 2023 17:59:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 17:59:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 10 Apr 2023 17:59:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 10 Apr 2023 17:59:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU+1MdqWHMwkyHcJ/D3vWyXRHoVUt/iB360Jik2hrMUuWdte3GnNbHZNDg6PnSUITRrBwqPOo9/XP4P7GHBUJ6K0jgjWffOLc3hGoLVxAaFl17ZQChUR9BtT8fcaC+EUWAU4cIGyyJdhj9Rg9I9Fnve1xTZoZWdRHw4B+W96oQwoZEicORgYAbz/q8xo0+U1LXhv5oxhrdr7QUcY1ueKHURldgLSciXpJ3ifm9cTJ30q03zbZiG4uogCZJPsBqgsNUij0mxSGBEYIXyG0bl+4/gRNjXkW6T2T/O/gdcxThfdvpU3Y728wensG1lKax7QU7vWUKS3V87ozOTc1kIsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ8zNLRGmAgrVYHpbXvMeqly6cD+k9CGhWRNwK9Pze8=;
 b=IXf4AekRcfPf7yJpv5DPiuw9tBBHWLEwPMYjlTWm/fHDi7+aLqttZch3I/h5pFQVbAp51zRWtgoe4MQU4GGNdHYdImumImBbMJNoiI3DPwSc1grR81eDL0xvKY0Z+4lRnFe620XLqkgccfPuYsvqhA97XhVFERnnvG4m1/OxAGGlnuwlTliKkgVwHYLU1+L3YpUlFi8peUr3/szYSsFi8rITNU1pWd+GyIEFVvvM2yq4u7SZuPNMlNUD9kG2PhW57CoOG4N3WB0KcbbJ+zYa8eR4+vw3/B+fgDAevIojhr6Utmarhl3U6nH8SLdPeJp9Nn2LEZGMWiQ7PnTm7hzxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA0PR11MB7259.namprd11.prod.outlook.com (2603:10b6:208:43c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Tue, 11 Apr
 2023 00:59:32 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf%8]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 00:59:32 +0000
Date: Tue, 11 Apr 2023 08:59:21 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Keith Busch <kbusch@meta.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<io-uring@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
	<sagi@grimberg.me>, <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/5] nvme: simplify passthrough bio cleanup
Message-ID: <202304110813.d885e981-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="8/Xv+PwOGCAmY8bk"
Content-Disposition: inline
In-Reply-To: <20230407191636.2631046-3-kbusch@meta.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA0PR11MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: be76dfa2-7393-47fa-bb7d-08db3a280264
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mjqCTXNVxCx9Y3ocKer3lixyxqr8ZDv2Ep4Z22tRjQKGuEUQOHOxWQJlAiKUp20M0y09M0X/Pe0+qr1n24xsnMgkr497f6TB0nq5cySj5OpIIHhzeZalHZ01f/ZV/9IPhckUJjPT15WKVu0pFKs3+JUNfqH2CqMmhU/wP+dr90yVvDoRo5grhWFFX1jEVdYmt3bghbnGYBr+5HH3xR70O25jWcLYRk5b+Qwt4S64RJWwISWDy/OqZaEXCcEra2YVPpOJ4sMe7cQst0r5N3U/XoUG+dEQRvZpNGbXu6LKU5xyG9G1NcHh8T8Y9df62drGSYxvmt/BWHMuNhtRWb8SFSWo220SkoIQZuyjVzazDLwK/8ca7nFWoEuHSClEpjk55WVnPebHvwWH3x0nTZjMdCHNwcNy1YiOap9qBBBb1U15nOG15DeQdXMt1/HZkiuiRBxzZ7pGsRBE8eBm4mqbSWVrh067TlwuJN8QpLNxm7WrPefaR8KCH+UjYAZG6Meu7fY74118AN+sIINWQBfWyoQzxUW02gHwRaArbmW8CKGUYDS+t8Q8sMqLOWfDSgS1edj7/VZJJJvuuTwp2CMt/QJ1kC28Aa5Ck06737u2C/aZVrTGIMl5YamqETEEFikdEdLlxf2GcuWMw+lYTYVhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(8936002)(966005)(7416002)(235185007)(5660300002)(41300700001)(66476007)(66556008)(66946007)(4326008)(8676002)(6916009)(316002)(2906002)(478600001)(36756003)(6666004)(6486002)(86362001)(6506007)(26005)(44144004)(1076003)(6512007)(2616005)(21490400003)(186003)(38100700002)(82960400001)(83380400001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H8FtxwtCCkX4nf/K3UNyvmz4aKi21Su3HBZ0iKmxHBth6u9Ec8gr8hQ+vFui?=
 =?us-ascii?Q?YwPPtMrRBAw0ijf+3e1OSHK9Sw5YLek05ZnRGY4MLwIdeKqWYUXPUIkd0CUU?=
 =?us-ascii?Q?zL+udWdNxOiD/8dNQvEAC8BhPspLYVxJTeU2cceyvloHLkHYGljQ/R09HLCK?=
 =?us-ascii?Q?C9qToG6OutxPhS6g1VzqLTAQr23VNGy8LxYlyVW+FleUnxewMswjvangZ7p6?=
 =?us-ascii?Q?cbBYEXuWJROl8nP1o5nv2bNSp+kzEwpdWYnB0LTJK+R/1KTD4W/q1iJTziTJ?=
 =?us-ascii?Q?Qs+gZ/6dE02h/CgMNc8ErqA7uO2aoimGKaSp/ej8/SBF/v55wTfllEEYkETO?=
 =?us-ascii?Q?m52hYYs4OfuTU6kEo2fwZX6ysoJqAT7q0G5lncfzQpefMX3uGNEQtkwhEgDo?=
 =?us-ascii?Q?zTyzYu0dGDkCzWxwGM6bNjiWX1mrPIfG2nqqMYMlyJ1zmld1G4oSRLBFvVlN?=
 =?us-ascii?Q?4Bbsa2CvVUg5nvk/orppVzCLpOuYNt3hHeOsRPYzitLknyE8H+Q8kSh8ajom?=
 =?us-ascii?Q?khEw5fpO9365p7A6XEouzNVmGW0eEGQQmLBMa+NI3kklKgD5TIoVgNr1qpjG?=
 =?us-ascii?Q?GeYvxwORW7sRgBrFU8jLcDc+NMoaR5S/kizPt70svEdDgZhAoioOQpyRL7cZ?=
 =?us-ascii?Q?GsIyhyyatP6mV3wb8Mvv6wqbNlqbLzrdrqDxjIGnucc4b0ZI4SCG1Au5LtlV?=
 =?us-ascii?Q?JCdK07AQvBrmDT/YH9gpb4L028L4xjBo2lDtUqkOARaD+2I1fQI6GBaYaqll?=
 =?us-ascii?Q?uZ+TE8FTvl1PcK/WhcFJsNNkfF6k2T5+p42Dy+3D5XOBpcobvkxxOxLU1b+c?=
 =?us-ascii?Q?2bmf8gDatmRuvLuhUkGjqlMuih7Gtk+vMNO6egHT+9sqCuieyTb5VdLh7vtM?=
 =?us-ascii?Q?HqHZh3vekgsyQa6hQQb+ecRtZkECwWQ7DmmvqY4ja704d01wXyVoMSZkf4Ns?=
 =?us-ascii?Q?Y7RyUF0SqJFd7CvllZ8/yvaJJ9HTlzpQwkeghhwSAbZPe8L8IQfiTEtbPsJn?=
 =?us-ascii?Q?YoAhV1+BZrYgoloVRavEipIdCe3y63gs5P1XntV78PLgMlr1CUhj5iAJjv7K?=
 =?us-ascii?Q?RQipkCsN8I9cAXPGadeMpNBcf4HEaTOqcf8HJErwjNbBPmWnpvFV62A4pv4J?=
 =?us-ascii?Q?ICm2t0CH+d5omav8Zz/RhuAe7KbqUh0KlSf6u7u+RK0RHfov/gBqucMohT+5?=
 =?us-ascii?Q?Sgt8vmtIquLd8lKo4aCw20NECZjFKkzYxV6kdP/q0bIgUxe3NMDj3Zid4kMb?=
 =?us-ascii?Q?+h3p1MkntEYepx5Ze4Nt1/5wlxVUsfJz6QZYFKtNOKPNwRG4jG9beS+HSVDG?=
 =?us-ascii?Q?ymbphyPgLXXy4U37EZbMCNfixosKa5erCuvEMfPMcOyMfjYOyCBv0uI0paFJ?=
 =?us-ascii?Q?w0y3cN2oZISaMQYiFbD/0894LYo9IvKnnmkw9LyI5cesG9lw0CtW9nsSNGS2?=
 =?us-ascii?Q?VyqzbasSNr3yHaHcVJC1+Uv+oUQKDREK7lRYVM010Q87qgJx6hxARDi4v2/S?=
 =?us-ascii?Q?4SYgKLgAKl0fXxHAyKFawbNEyNvUSQckxPfRzhcMLqEtbrMaFK/HswWLeKR2?=
 =?us-ascii?Q?sgeyv9gAPYQ2ZfY9tjOTOa6+2ADGcgMktPOXUJU/hYIeGu6b0yCt7VqyNDm1?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be76dfa2-7393-47fa-bb7d-08db3a280264
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 00:59:32.5046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoUvDz3a1KGAvh5jbl1xokPBOo7FgMgUlOF+nINJhn/Pa/fLdMl4Tj509flQieS1o2HXuccFwRn4/I//X/2qyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7259
X-OriginatorOrg: intel.com
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

--8/Xv+PwOGCAmY8bk
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_include/linux/pagemap.h" on:

commit: 9a32e7ca02dd8cff559b273fe161b5347b5b5c97 ("[PATCHv2 2/5] nvme: simplify passthrough bio cleanup")
url: https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/block-add-request-polling-helper/20230408-031926
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch link: https://lore.kernel.org/all/20230407191636.2631046-3-kbusch@meta.com/
patch subject: [PATCHv2 2/5] nvme: simplify passthrough bio cleanup

in testcase: phoronix-test-suite
version: 
with following parameters:

	test: darktable-1.0.5
	option_a: Server Rack
	option_b: CPU-only
	cpufreq_governor: performance

test-description: The Phoronix Test Suite is the most comprehensive testing and benchmarking platform available that provides an extensible framework for which new tests can be easily added.
test-url: http://www.phoronix-test-suite.com/


compiler: gcc-11
test machine: 12 threads 1 sockets Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz (Coffee Lake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202304110813.d885e981-oliver.sang@intel.com


kern  :err   : [    6.784763] BUG: sleeping function called from invalid context at include/linux/pagemap.h:969
kern  :err   : [    6.785533] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/11
kern  :err   : [    6.786313] preempt_count: 101, expected: 0
kern  :warn  : [    6.786315] CPU: 11 PID: 0 Comm: swapper/11 Tainted: G S                 6.3.0-rc5-00116-g9a32e7ca02dd #1
kern  :warn  : [    6.787644] Hardware name: Dell Inc. Vostro 3670/0HVPDY, BIOS 1.5.11 12/24/2018
kern  :warn  : [    6.788315] Call Trace:
kern  :warn  : [    6.788585]  <IRQ>
kern :warn : [    6.788822] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
kern :warn : [    6.789199] __might_resched (kernel/sched/core.c:10062) 
kern :warn : [    6.789593] set_page_dirty_lock (include/linux/pagemap.h:969 mm/page-writeback.c:2861) 
kern :warn : [    6.789998] __bio_release_pages (include/linux/bio.h:232 block/blk.h:441 block/bio.c:1171) 
kern :warn : [    6.790445] blk_rq_unmap_user (include/linux/bio.h:493 block/blk-map.c:751) 
kern :warn : [    6.790874] ? blk_mq_complete_request_remote (block/blk-mq.c:1164 block/blk-mq.c:1187 block/blk-mq.c:1168) 
kern :warn : [    6.791386] blk_update_request (block/blk-mq.c:909) 
kern :warn : [    6.791803] blk_mq_end_request (block/blk-mq.c:1021) 
kern :warn : [    6.792200] blk_complete_reqs (block/blk-mq.c:1099 (discriminator 3)) 
kern :warn : [    6.792599] __do_softirq (kernel/softirq.c:571) 
kern :warn : [    6.792965] __irq_exit_rcu (kernel/softirq.c:445 kernel/softirq.c:650) 
kern :warn : [    6.793351] common_interrupt (arch/x86/kernel/irq.c:240 (discriminator 14)) 
kern  :warn  : [    6.793742]  </IRQ>
kern  :warn  : [    6.793995]  <TASK>
kern :warn : [    6.794236] asm_common_interrupt (arch/x86/include/asm/idtentry.h:636) 
kern :warn : [    6.794652] RIP: 0010:cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291) 
kern :warn : [ 6.795152] Code: 00 e8 de ce 26 ff e8 99 f1 ff ff 8b 53 04 49 89 c5 0f 1f 44 00 00 31 ff e8 07 b2 25 ff 45 84 ff 0f 85 cc 00 00 00 fb 45 85 f6 <0f> 88 88 01 00 00 49 63 d6 4c 2b 2c 24 48 8d 04 52 48 8d 04 82 49
All code
========
   0:	00 e8                	add    %ch,%al
   2:	de ce                	fmulp  %st,%st(6)
   4:	26 ff                	es (bad) 
   6:	e8 99 f1 ff ff       	callq  0xfffffffffffff1a4
   b:	8b 53 04             	mov    0x4(%rbx),%edx
   e:	49 89 c5             	mov    %rax,%r13
  11:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  16:	31 ff                	xor    %edi,%edi
  18:	e8 07 b2 25 ff       	callq  0xffffffffff25b224
  1d:	45 84 ff             	test   %r15b,%r15b
  20:	0f 85 cc 00 00 00    	jne    0xf2
  26:	fb                   	sti    
  27:	45 85 f6             	test   %r14d,%r14d
  2a:*	0f 88 88 01 00 00    	js     0x1b8		<-- trapping instruction
  30:	49 63 d6             	movslq %r14d,%rdx
  33:	4c 2b 2c 24          	sub    (%rsp),%r13
  37:	48 8d 04 52          	lea    (%rdx,%rdx,2),%rax
  3b:	48 8d 04 82          	lea    (%rdx,%rax,4),%rax
  3f:	49                   	rex.WB

Code starting with the faulting instruction
===========================================
   0:	0f 88 88 01 00 00    	js     0x18e
   6:	49 63 d6             	movslq %r14d,%rdx
   9:	4c 2b 2c 24          	sub    (%rsp),%r13
   d:	48 8d 04 52          	lea    (%rdx,%rdx,2),%rax
  11:	48 8d 04 82          	lea    (%rdx,%rax,4),%rax
  15:	49                   	rex.WB
kern  :warn  : [    6.796767] RSP: 0018:ffffc9000014be80 EFLAGS: 00000202
kern  :warn  : [    6.797259] RAX: ffff8884260ed680 RBX: ffff8884260f7a00 RCX: 000000000000001f
kern  :warn  : [    6.797931] RDX: 000000000000000b RSI: 000000002819aad9 RDI: 0000000000000000
kern  :warn  : [    6.798582] RBP: 0000000000000002 R08: 0000000194673496 R09: 0000000000000018
kern  :warn  : [    6.799290] R10: 00000000000000b3 R11: 00000000000001e9 R12: ffffffff82cbb6c0
kern  :warn  : [    6.799965] R13: 0000000194673496 R14: 0000000000000002 R15: 0000000000000000
kern :warn : [    6.800626] cpuidle_enter (drivers/cpuidle/cpuidle.c:390) 
kern :warn : [    6.800995] cpuidle_idle_call (kernel/sched/idle.c:219) 
kern :warn : [    6.801438] do_idle (kernel/sched/idle.c:284) 
kern :warn : [    6.801774] cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1)) 
kern :warn : [    6.802172] start_secondary (arch/x86/kernel/smpboot.c:198 arch/x86/kernel/smpboot.c:232) 
kern :warn : [    6.802571] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:358) 
kern  :warn  : [    6.803061]  </TASK>
kern :debug : [    9.653162] calling init_netconsole+0x0/0xff0 [netconsole] @ 685 
kern  :info  : [    9.653814] netpoll: netconsole: local port 6665
kern  :info  : [    9.654324] netpoll: netconsole: local IPv4 address 0.0.0.0
kern  :info  : [    9.654917] netpoll: netconsole: interface 'eth0'
kern  :info  : [    9.655431] netpoll: netconsole: remote port 6677
kern  :info  : [    9.655940] netpoll: netconsole: remote IPv4 address 192.168.3.200
kern  :info  : [    9.656590] netpoll: netconsole: remote ethernet address 3c:fd:fe:d2:10:00
kern  :info  : [    9.657309] netpoll: netconsole: local IP 192.168.3.109
kern  :info  : [    9.657887] printk: console [netcon0] enabled
kern  :info  : [    9.658373] netconsole: network logging started
kern :debug : [    9.658876] initcall init_netconsole+0x0/0xff0 [netconsole] returned 0 after 5063 usecs 
user  :notice: [    9.956400] is_virt=false

user  :notice: [   10.545083] lkp: kernel tainted state: 4


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



--8/Xv+PwOGCAmY8bk
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.3.0-rc5-00116-g9a32e7ca02dd"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.3.0-rc5 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23990
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23990
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_CALL_PADDING=y
CONFIG_HAVE_CALL_THUNKS=y
CONFIG_CALL_THUNKS=y
CONFIG_PREFIX_SYMBOLS=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CPU_UNRET_ENTRY=y
CONFIG_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
CONFIG_CPU_IBPB_ENTRY=y
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_MQPRIO_LIB=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_SGI_XP is not set
CONFIG_HP_ILO=m
# CONFIG_SGI_GRU is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_PARPORT is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_CAN_DEV is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
# CONFIG_WLAN is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

CONFIG_I2C_HID=m
# CONFIG_I2C_HID_ACPI is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
CONFIG_SUNRPC_DEBUG=y
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--8/Xv+PwOGCAmY8bk
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='phoronix-test-suite'
	export testcase='phoronix-test-suite'
	export category='benchmark'
	export job_origin='phoronix-test-suite-opencl.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-cfl-d1'
	export tbox_group='lkp-cfl-d1'
	export submit_id='643482aec0d0a4dc304dbf75'
	export job_file='/lkp/jobs/scheduled/lkp-cfl-d1/phoronix-test-suite-performance-Server_Rack-CPU-only-darktable-1.0.5-debian-x86_64-phoronix-9a32e7ca02dd8cff559b273fe161b5347b5b-20230411-187440-4nykc3-5.yaml'
	export id='35545b1bdfe880eac47172af220212a4db4fda3b'
	export queuer_version='/zday/lkp'
	export model='Coffee Lake'
	export nr_node=1
	export nr_cpu=12
	export memory='16G'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006J800RGN-part5'
	export swap_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006J800RGN-part3'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006J800RGN-part4'
	export kernel_cmdline_hw='acpi_rsdp=0xb9e23000'
	export brand='Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz'
	export commit='9a32e7ca02dd8cff559b273fe161b5347b5b5c97'
	export netconsole_port=6677
	export ucode='0xf0'
	export need_kconfig_hw='SATA_AHCI
{"R8169"=>"y"}
DRM_I915'
	export rootfs='internal-lkp-server:/osimage/debian/debian-x86_64-phoronix'
	export run_on_local_disk=true
	export force_reboot=1
	export kconfig='x86_64-rhel-8.3'
	export enqueue_time='2023-04-11 05:42:06 +0800'
	export _id='643482c8c0d0a4dc304dbf77'
	export _rt='/result/phoronix-test-suite/performance-Server_Rack-CPU-only-darktable-1.0.5/lkp-cfl-d1/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/9a32e7ca02dd8cff559b273fe161b5347b5b5c97'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='2ac2520a41cdb7137280076b2dc65a4ea462b1a2'
	export base_commit='7e364e56293bb98cae1b55fd835f5991c4e96e7d'
	export branch='linux-review/Keith-Busch/block-add-request-polling-helper/20230408-031926'
	export result_root='/result/phoronix-test-suite/performance-Server_Rack-CPU-only-darktable-1.0.5/lkp-cfl-d1/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/9a32e7ca02dd8cff559b273fe161b5347b5b5c97/3'
	export scheduler_version='/lkp/lkp/.src-20230410-171556'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/initramfs/initramfs-20191118.cgz'
	export bootloader_append='root=/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006J800RGN-part4
rootflags=subvol=debian-x86_64-phoronix
remote_rootfs=internal-lkp-server:/osimage/debian/debian-x86_64-phoronix
RESULT_ROOT=/result/phoronix-test-suite/performance-Server_Rack-CPU-only-darktable-1.0.5/lkp-cfl-d1/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/9a32e7ca02dd8cff559b273fe161b5347b5b5c97/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/9a32e7ca02dd8cff559b273fe161b5347b5b5c97/vmlinuz-6.3.0-rc5-00116-g9a32e7ca02dd
branch=linux-review/Keith-Busch/block-add-request-polling-helper/20230408-031926
job=/lkp/jobs/scheduled/lkp-cfl-d1/phoronix-test-suite-performance-Server_Rack-CPU-only-darktable-1.0.5-debian-x86_64-phoronix-9a32e7ca02dd8cff559b273fe161b5347b5b-20230411-187440-4nykc3-5.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3
commit=9a32e7ca02dd8cff559b273fe161b5347b5b5c97
initcall_debug
nmi_watchdog=0
acpi_rsdp=0xb9e23000
max_uptime=2100
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-11/9a32e7ca02dd8cff559b273fe161b5347b5b5c97/modules.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.4.0-0.bpo.3-amd64'
	export repeat_to=6
	export stop_repeat_if_found='dmesg.BUG:sleeping_function_called_from_invalid_context_at_include/linux/pagemap.h'
	export kbuild_queue_analysis=1
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-11/9a32e7ca02dd8cff559b273fe161b5347b5b5c97/vmlinuz-6.3.0-rc5-00116-g9a32e7ca02dd'
	export dequeue_time='2023-04-11 05:44:37 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-cfl-d1/phoronix-test-suite-performance-Server_Rack-CPU-only-darktable-1.0.5-debian-x86_64-phoronix-9a32e7ca02dd8cff559b273fe161b5347b5b-20230411-187440-4nykc3-5.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor debug_mode=0 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='darktable-1.0.5' option_a='Server Rack' option_b='CPU-only' $LKP_SRC/tests/wrapper phoronix-test-suite
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='darktable-1.0.5' option_a='Server Rack' option_b='CPU-only' $LKP_SRC/stats/wrapper phoronix-test-suite
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	env debug_mode=0 $LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time phoronix-test-suite.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--8/Xv+PwOGCAmY8bk
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kmsg.xz"
Content-Transfer-Encoding: base64

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

--8/Xv+PwOGCAmY8bk
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="phoronix-test-suite"

PTS_SILENT_MODE=1
2023-04-11 05:46:50 phoronix-test-suite run darktable-1.0.5



Darktable:
    system/darktable-1.0.5
    System Test Configuration
        1: Boat
        2: Masskrug
        3: Server Room
        4: Server Rack
        5: Test All Options
        ** Multiple items can be selected, delimit by a comma. **

        1: Boat
        2: Masskrug
        3: Server Room
        4: Server Rack
        5: Test All Options
        ** Multiple items can be selected, delimit by a comma. **


        1: CPU-only
        2: OpenCL
        3: Test All Options
        ** Multiple items can be selected, delimit by a comma. **


Phoronix Test Suite v10.4.0
System Information


  PROCESSOR:          Intel Core i7-8700 @ 4.60GHz
    Core Count:       6                                        
    Thread Count:     12                                       
    Extensions:       SSE 4.2 + AVX2 + AVX + RDRAND + FSGSBASE 
    Cache Size:       12 MB                                    
    Microcode:        0xf0                                     
    Core Family:      Kaby/Coffee/Whiskey Lake                 
    Scaling Driver:   intel_pstate performance                 

  GRAPHICS:           (1200MHz)
    Frequency:        1200MHz          
    Vulkan:           1.1.102          
    OpenCL:           OpenCL 2.1       

  MOTHERBOARD:        Dell 0HVPDY
    BIOS Version:     1.5.11           

  MEMORY:             2 x 8192 MB DDR4-2666MHz 8ATF1G64AZ-2G6E1

  DISK:               Samsung SSD 970 EVO 250GB + 800GB INTEL SSDSC2BB80
    File-System:      overlayfs        
    Disk Scheduler:   NONE             

  OPERATING SYSTEM:   Debian GNU/Linux 9
    Kernel:           6.3.0-rc5-00116-g9a32e7ca02dd (x86_64) 20230411                                                             
    Display Server:   X Server 1.20.4                                                                                             
    Compiler:         GCC 9.2.1 20191130                                                                                          
    Security:         itlb_multihit: KVM: Mitigation of VMX disabled                                                              
                      + l1tf: Mitigation of PTE Inversion; VMX: conditional cache flushes SMT vulnerable                          
                      + mds: Vulnerable: Clear buffers attempted no microcode; SMT vulnerable                                     
                      + meltdown: Mitigation of PTI                                                                               
                      + mmio_stale_data: Vulnerable: Clear buffers attempted no microcode; SMT vulnerable                         
                      + retbleed: Mitigation of IBRS                                                                              
                      + spec_store_bypass: Mitigation of SSB disabled via prctl                                                   
                      + spectre_v1: Mitigation of usercopy/swapgs barriers and __user pointer sanitization                        
                      + spectre_v2: Mitigation of IBRS IBPB: conditional STIBP: conditional RSB filling PBRSB-eIBRS: Not affected 
                      + srbds: Vulnerable: No microcode                                                                           
                      + tsx_async_abort: Vulnerable: Clear buffers attempted no microcode; SMT vulnerable                         

    Would you like to save these test results (Y/n): 
Darktable:
    system/darktable-1.0.5 [Test: Server Rack - Acceleration: CPU-only]
    Test 1 of 1
    Estimated Trial Run Count:    3                     
    Estimated Time To Completion: 2 Minutes [05:48 UTC] 
        Started Run 1 @ 05:46:58
        The test run ended quickly.
        Started Run 2 @ 05:47:03
        The test run ended quickly.
        Started Run 3 @ 05:47:08
        The test run ended quickly.

    Test: Server Rack - Acceleration: CPU-only:
        0.164
        0.162
        0.163

    Average: 0.163 Seconds
    Deviation: 0.61%

darktable-1.0.5.seconds: 23.482667185

--8/Xv+PwOGCAmY8bk
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/phoronix-test-suite-opencl.yaml
suite: phoronix-test-suite
testcase: phoronix-test-suite
category: benchmark
phoronix-test-suite:
  test: darktable-1.0.5
  option_a: Server Rack
  option_b: CPU-only
job_origin: phoronix-test-suite-opencl.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-cfl-d1
tbox_group: lkp-cfl-d1
submit_id: 64346608fc51bc2777712356
job_file: "/lkp/jobs/scheduled/lkp-cfl-d1/phoronix-test-suite-performance-Server_Rack-CPU-only-darktable-1.0.5-debian-x86_64-phoronix-9a32e7ca02dd8cff559b273fe161b5347b5b-20230411-10103-1v0wnt4-0.yaml"
id: 5dc7549e4048259608d46ec428685c8b8af31852
queuer_version: "/zday/lkp"

#! /db/releases/20230407192341/lkp-src/hosts/lkp-cfl-d1
model: Coffee Lake
nr_node: 1
nr_cpu: 12
memory: 16G
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006J800RGN-part5"
swap_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006J800RGN-part3"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006J800RGN-part4"
kernel_cmdline_hw: acpi_rsdp=0xb9e23000
brand: Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz

#! /db/releases/20230407192341/lkp-src/include/category/benchmark
kmsg:
boot-time:
uptime:
iostat:
heartbeat:
vmstat:
numa-numastat:
numa-vmstat:
numa-meminfo:
proc-vmstat:
proc-stat:
meminfo:
slabinfo:
interrupts:
lock_stat:
perf-sched:
  lite_mode: 1
softirqs:
bdi_dev_mapping:
diskstats:
nfsstat:
cpuidle:
cpufreq-stats:
turbostat:
sched_debug:
perf-stat:
mpstat:
perf-profile:
  debug_mode: 0

#! /db/releases/20230407192341/lkp-src/include/category/ALL
cpufreq_governor: performance

#! /db/releases/20230407192341/lkp-src/include/queue/cyclic
commit: 9a32e7ca02dd8cff559b273fe161b5347b5b5c97

#! /db/releases/20230407192341/lkp-src/include/testbox/lkp-cfl-d1
netconsole_port: 6677
ucode: '0xf0'
need_kconfig_hw:
- SATA_AHCI
- R8169: y
- DRM_I915

#! /db/releases/20230407192341/lkp-src/include/phoronix-test-suite
rootfs: internal-lkp-server:/osimage/debian/debian-x86_64-phoronix
run_on_local_disk: true
force_reboot: 1
kconfig: x86_64-rhel-8.3
enqueue_time: 2023-04-11 03:39:53.133300737 +08:00
_id: 64346608fc51bc2777712356
_rt: "/result/phoronix-test-suite/performance-Server_Rack-CPU-only-darktable-1.0.5/lkp-cfl-d1/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/9a32e7ca02dd8cff559b273fe161b5347b5b5c97"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 2ac2520a41cdb7137280076b2dc65a4ea462b1a2
base_commit: 7e364e56293bb98cae1b55fd835f5991c4e96e7d
branch: linux-devel/devel-hourly-20230409-131512
result_root: "/result/phoronix-test-suite/performance-Server_Rack-CPU-only-darktable-1.0.5/lkp-cfl-d1/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/9a32e7ca02dd8cff559b273fe161b5347b5b5c97/0"
scheduler_version: "/lkp/lkp/.src-20230410-171556"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/initramfs/initramfs-20191118.cgz"
bootloader_append:
- root=/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006J800RGN-part4
- rootflags=subvol=debian-x86_64-phoronix
- remote_rootfs=internal-lkp-server:/osimage/debian/debian-x86_64-phoronix
- RESULT_ROOT=/result/phoronix-test-suite/performance-Server_Rack-CPU-only-darktable-1.0.5/lkp-cfl-d1/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/9a32e7ca02dd8cff559b273fe161b5347b5b5c97/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/9a32e7ca02dd8cff559b273fe161b5347b5b5c97/vmlinuz-6.3.0-rc5-00116-g9a32e7ca02dd
- branch=linux-devel/devel-hourly-20230409-131512
- job=/lkp/jobs/scheduled/lkp-cfl-d1/phoronix-test-suite-performance-Server_Rack-CPU-only-darktable-1.0.5-debian-x86_64-phoronix-9a32e7ca02dd8cff559b273fe161b5347b5b-20230411-10103-1v0wnt4-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- commit=9a32e7ca02dd8cff559b273fe161b5347b5b5c97
- initcall_debug
- nmi_watchdog=0
- acpi_rsdp=0xb9e23000
- max_uptime=2100
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw

#! runtime status
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-11/9a32e7ca02dd8cff559b273fe161b5347b5b5c97/modules.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /cephfs/db/releases/20230410100009/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 5.4.0-0.bpo.3-amd64
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-11/9a32e7ca02dd8cff559b273fe161b5347b5b5c97/vmlinuz-6.3.0-rc5-00116-g9a32e7ca02dd"
dequeue_time: 2023-04-11 03:53:24.153687960 +08:00

#! /cephfs/db/releases/20230410170018/lkp-src/include/site/inn
job_state: finished
loadavg: 0.37 0.11 0.04 1/314 2908
start_time: '1681185337'
end_time: '1681185361'
version: "/lkp/lkp/.src-20230410-171632:b79e65fca59a:bfda8207adbe"

--8/Xv+PwOGCAmY8bk
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "phoronix-test-suite" "run" "darktable-1.0.5"

--8/Xv+PwOGCAmY8bk--

