Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF2AECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K9IfnsDeFwVQ1W1jxqWlUVBS49FENYsoTk2vabXknpU=; b=YylmK16w4qckQ49W85pEH0EeDi
	5xiPDGnNwPAsqKthK8doppWDjJbKYIc+M5mSQOAhWB+q8kUxkQsnlFHfifGa+KY19I62fMnLGwYLL
	izKA6oh7pqxTrLx2bY6ERrD0UjGOV2PZHtS2Hqc/PLoEBLed5l0iM8udyr8rhXyLeGm2eDM4sjm4s
	Jyn2Lh5fWiYtrBxFTu6TKquUJbZpiH9bhCy1BRkwbgKj7idT3BBY2xODRdXpql9aUPQR14xBR9Sqc
	G1gGOG9CabfKa1vRJAziizV58bZ27UPmzMddi44J3CW7jLJyHHiYDHPNJaPF+jlP6ML/aS1J6Bcij
	eoYz4zJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on0Sj-002Jp7-31; Mon, 24 Oct 2022 16:38:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on0Sh-002JoM-DH
	for linux-nvme@bombadil.infradead.org; Mon, 24 Oct 2022 16:38:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:In-Reply-To:Content-Type:
	References:Message-ID:Subject:CC:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K9IfnsDeFwVQ1W1jxqWlUVBS49FENYsoTk2vabXknpU=; b=dvfrQ735lhxHLrt+cAuBuGLMS1
	t96gOE1rweumRfxm2hZw8DzWX9z1/GPv6w+9eQtx1mXtRbEXJUjctBeB+6qNGCTRlukdxZFY9wwP/
	u87Dj1NWyuU2bR+hm5CplUVnnEDS4/TuUNYCFLSS5LklfmM/C1/usrX41K3gmQpOZbR9MGGudsgoz
	AOUHZfdoP/E/peMHzI2XfXhXLheOa5hj4FwrfMcnSkx2X19ejbRoUT09djq7sQM3Fd1wWNi98rRrX
	4aszgUJutDtDOvd4PDAcmm2/KgwcDfqyJLyjz+++bdpkhZYe/XtMX4thk1GJagN4baJS2q0s/+3CG
	5WwqN+Ag==;
Received: from mga02.intel.com ([134.134.136.20])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on0Sa-0066Ff-T2
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 16:38:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666629476; x=1698165476;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wP7GcARxnBDRGVQtKaGTP/lRpE9CMir6AoJ6BmEdSMU=;
  b=P/vVakN+BaS1JFncFV6eLui+Nif/68bB8bOdWsXomDJ1RD1BsKdxtSvR
   rmk66WI4rqnycalJmp8QZ/laYQcxF+1qLaYyCTEQRSEXt6nJmDuSvb13B
   Cqfjl4b/7Hp2/qh9ILuFB9+Ygg1yzVqgQTbHLO8mSgdxjAO9cdEjK4tdm
   FEjmOOqnyav+7CDag65e6j/1mojlXdRMUWEVn2ik/CR1ljucuGGp0z/gf
   SzCMbQwo/8NBKZ64sbhjXnuxcDgMUIVJrrrWWxwpE1IU4T88Y3FnfjUsd
   usQX4QOR8veVvaRU5w0cDmkpXr/ldiSr3Bk7SFUIQv242MJqGtVUVMhTM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="294867983"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="294867983"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 09:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="609257578"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="609257578"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 24 Oct 2022 09:37:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 09:37:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 09:37:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 09:37:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 09:37:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7FX4Dcys7KpARIYeWgyTQ3TzEZx5iP3Z/6yAc9vd22xEoYBYTxLhGwAfBmYO8vMTC3k2C8v6CFaf0d/1Is1EJvbZ1eS6YxhCjZGuiGlH+IPNQetfnxgNb/YGzEUNfJn+9sgrue0mK6bsjnN/YzR9sfpePAICp2KlJCf+H1sf9q6BEHuPrJRMG2qDzEFFA6Wk2OJA40q9TIwjvVFwS/3/NdyOBqTchOlGX/sZMr8uMKgtQhUuYgVwUB9vFjHG08BOmkojf4/NQx9hh3Ba+EBx76bp+EbAC0IG1qwr9vytXua77tch6AoZcUNEXiia5c1mVTOyYkQzUxemsz3vB3vbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9IfnsDeFwVQ1W1jxqWlUVBS49FENYsoTk2vabXknpU=;
 b=ZOu26kWe1vDtw4SlNbsttoHt2lIun0ywDQklibf4IjwyKuNoao1Ye7FYvMFFNsi4ARxcIOGDcBpgxnRxa5uFo3qlvlMmC9zvm5DuI4LtgPQybvFcm4VFZ6byy4cS4Va1XBuxAba6Ics8oMNvM8macorqyXnIhB5Hc+J1tVTy6SBba/lL2Zv9FkGqPkFWJVWPZe0xCXgyfF9gp19DNpU89Mk+HQTnFL1Gwc1XBeBObgi2TfjrDRlCgiZH58htWMor0m1/9RR/WBV08188gekW/i4Qj/P+jGEq6ykfKz2+I0WTiGtosg5KKBiIFDONR1Kpi1dV3eHxKzxY5EeE3fCLfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB4809.namprd11.prod.outlook.com
 (2603:10b6:806:112::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 16:37:30 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Mon, 24 Oct
 2022 16:37:30 +0000
Date: Mon, 24 Oct 2022 09:37:25 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Logan Gunthorpe <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-mm@kvack.org>
CC: Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Christian =?iso-8859-1?Q?K=F6nig?=
	<christian.koenig@amd.com>, John Hubbard <jhubbard@nvidia.com>, Don Dutile
	<ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>, Daniel Vetter
	<daniel.vetter@ffwll.ch>, Minturn Dave B <dave.b.minturn@intel.com>, "Jason
 Ekstrand" <jason@jlekstrand.net>, Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>, "Martin
 Oliveira" <martin.oliveira@eideticom.com>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>, Ralph Campbell <rcampbell@nvidia.com>, "Stephen
 Bates" <sbates@raithlin.com>, Logan Gunthorpe <logang@deltatee.com>
Subject: RE: [PATCH v11 1/9] mm: allow multiple error returns in
 try_grab_page()
Message-ID: <6356bf459ba_1d21294c1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221021174116.7200-1-logang@deltatee.com>
 <20221021174116.7200-2-logang@deltatee.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221021174116.7200-2-logang@deltatee.com>
X-ClientProxiedBy: BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17)
 To MWHPR1101MB2126.namprd11.prod.outlook.com (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA2PR11MB4809:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c2f555-6dbe-46f3-d38f-08dab5de0ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Z744B31IQuppiOaAxweFV3XWQ7kvsJFgEfcqO/QcIdusmJvXlPXdfY/HooYiq52kFjjAOTmRrmrh5instDnoEB3TT+ToN5Vm6rpzhXhpgYN3ieVMZ9Fl4pdLgDXzIjml3HiIzASnB2qJCswfYCFE3EVFilfoyY9LQSK26LGhP7vxJ8aYR8qPyz5Of/RDZk68pe61LiC8qqUY6dlFT2WWIm2NCLCOJNhnznq4JgSEqRyw4dyMTh/gi2wxbY+cqTEaELWnY7nWGucNKcB9wKJs+ync+fLkhgFMX7KRDquFmF25uIaFtR0m3eobQ9XayBkTEpbu9AlXIXM/bnM8osM1zjbjupC9C7GfuWSAH2DknC5DKKD+LK6fY0aJjeUgHQgU1wFp5Ua6Ap6oFNj/kXDg3kvZNvUuMQEcxnrdlKnj87t8k4aQ+V2IFh06UYmgA8mFz7eYyR7nbeQ1d8yRVjSf095jiURcLbHsnor6U3zMECYKznPI2ZzHIiu7fvmEwOI4B95LBExmRJq3ypmxwx3vP89qQeUrhCmzX5AMnyhOMUD48S1/0C6OTrP9oz1tiauJCNPdBjJ34zKNs97iTs1lUWia5qAxe3dPbRAruWuXfmd4eoW95kEE7CNBJqiCs2k9jJcvq/oSH7Y4070N2cQHoKawp3dr4PlGJETI8kbRcatOwH7oA1kDYhzKjACioeYYQkKpKdECZ70pbBKTyB6ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199015)(6512007)(6666004)(6506007)(478600001)(9686003)(26005)(6486002)(2906002)(86362001)(82960400001)(38100700002)(5660300002)(186003)(83380400001)(316002)(41300700001)(66476007)(4326008)(8676002)(54906003)(7416002)(4744005)(66946007)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A/YEdXvkRo4OLxjovpCuZZ1rvAKwZKXrEfiFOUqsIuwidQY3/Y9PnFZKBbD4?=
 =?us-ascii?Q?RQXwB3qiNlrNwPX6361tgPhv7LpaWlWPZcEUX+bW3/pWjyymk8P9xS3Z3dG+?=
 =?us-ascii?Q?a6ptj+qmKhAcYK3tCeG8FQwhNmplXAGnXZ9cBfmlKbwMNia4ToZoBlFQQ+lX?=
 =?us-ascii?Q?yT3CzIKfrT8Q3FHEG9HIkrgOIM/k6M3pauxVZzFgetp6oEU+QzpR32IQisey?=
 =?us-ascii?Q?K03ljkff3mALZuqfHGwYb3ID1nDvywGkuibbHfCb2nAS4720mAeWgJhQYH68?=
 =?us-ascii?Q?LbJCmewlYfrtZkd4IkQqReZXk0EK07f0yiLKThxLCr5/UQswV8ubpbb4UvSq?=
 =?us-ascii?Q?biYQsRlKqK/UOy6it/BbuzFaRIBTCDtn380qauCirmrv9ycnp8nU8OVXAHqb?=
 =?us-ascii?Q?sLU5OjML1H1Xj2RNzT+Wu8OOVNo+SqnQoO8TE14kS51t1uLwTo9r1y3WUcfo?=
 =?us-ascii?Q?iw9WFzeZoWqqwx/CvQKYL+5nCErgDI/pXgCR9ybICzcgEYO6/IDX2PlO3MEy?=
 =?us-ascii?Q?yXag91hQ3ik63Kzf3seuRfDeBXk2rFoOcZ/cyeUl4+0ZsaY2nz0B1LKGWcLn?=
 =?us-ascii?Q?96WNNtP1yQRSXJRkQgiwzWHortzfFa8ILWxMugcVxEVhjo6aDdNS00//U7FV?=
 =?us-ascii?Q?yj1VRsY1VRwuqXovZsTtSdTpfa81lto0S6hUMKay6G1yAw+XrNY5cWCEx9hK?=
 =?us-ascii?Q?MglZTfSeY3iOruAr8/xTJWlLLtd0EqMU36v5W5+xRS1ESkRWndSg/wbyLdlI?=
 =?us-ascii?Q?THm/gTOQuvJ+IPIhUN4adE/MCAx0dCMnzgSFmYDtBNT1dZiSW6CzbFzS1LGJ?=
 =?us-ascii?Q?0VhArncRQMKEvRirpUlFOk0+1wss8Z/0cLreTKGKWtGI6p4vgoXRelpjU1Qn?=
 =?us-ascii?Q?5nPlIjYPNrAba1yzauYyPFw7ptxe371p+0ydV7RVrGAooZp5UEIwp6VlFenH?=
 =?us-ascii?Q?VxLZjm8LBVX7nUlHmgoc2n/dP792hSz/HULKNRJ/VnmVovtxqXaIc2UOSaNy?=
 =?us-ascii?Q?v9lErrAWMujpd/mEUjLeOjDSfBfSG3tM5bBwzhzyZWK++WWhfI/S2ls+zEVF?=
 =?us-ascii?Q?CaSSULy/SnO8GnbCTzLSve+a4eIJxk1cdFLk5IQbxGg7cS0E1HsjbGbWEdd7?=
 =?us-ascii?Q?gjWKkH9x6afVQVQ9y16d8KyUVehgp06e79cPGqf60cRHRPgMc7SUL8h9KXFZ?=
 =?us-ascii?Q?2tj3GP+QkJ9182OMPz9T2Af0ywHf22vdNnY814FnOFEeKfqPDiehOkzTagkT?=
 =?us-ascii?Q?xvvEWaJuLRFJiQt8CN+Ftyb2LAOleISKBm+hBWYrfVgrtx2o5J22d3janyj4?=
 =?us-ascii?Q?unpE1pOGC04Mt7zVBXytqsQQmphKHzCEUkzUPun4iUOALUITclhYbDuZGkYu?=
 =?us-ascii?Q?LybaLSy8/C/S3ogiPZL+4GlHT7DdvAQ4aKb5hIzrY66km+yG0fssMO+9r5lu?=
 =?us-ascii?Q?2XzYDdZdK+R7ttqnr0SF2GDC/CKZG+AtnXjZlWvhQE41FtE2bZNeKM2K9Qda?=
 =?us-ascii?Q?IcJv4x5AMaU1is4tGjAd+FVJCuz6lryN0Bg7wZIlMdiFrWs9NQLnRVtLV+fB?=
 =?us-ascii?Q?pY4AYRmI1Ew8j1sT9xgo9wLmYBTPPaHp7VgRMYFEumy29dYGFe37ydQ2YDAS?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c2f555-6dbe-46f3-d38f-08dab5de0ae5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 16:37:29.8891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsIbt8jTlFMhASR125g7PbjVuzmPvjXaWjvWFg2AiW5OOZO9zxOPUFG2JR9l0yl3nfuZcM+eAHTEeN+3WdLywCmGN6ZNxUCEAVnSaAjBIjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4809
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_173757_575039_A2B6E62B 
X-CRM114-Status: GOOD (  11.64  )
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

Logan Gunthorpe wrote:
> In order to add checks for P2PDMA memory into try_grab_page(), expand
> the error return from a bool to an int/error code. Update all the
> callsites handle change in usage.
> 
> Also remove the WARN_ON_ONCE() call at the callsites seeing there
> already is a WARN_ON_ONCE() inside the function if it fails.

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

