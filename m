Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB63C4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 17:47:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9417A22ADC
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 17:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9417A22ADC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4XcIxtUGGMIIKY4sBQVjyKPvZP+z3IWNZwuA67DmD+E=; b=dfRkL9+z0O2zqL6vhSgdcndsw
	ftPFfVIVlSPT1z/NDVxlAwwEaCfq8gKIJ5dc+VymajOFcxnLrjonTWDnbSgLgd3n1aQLWc5Fhn9Ce
	Pc3hb2Hb2KwRkUkYBwWi9NS+iJLKCant4GOcZ7HJWqZVOC0QnPuaekNj8vu9xqkgPa3JV6M0jDqfa
	knXtBxE6zWfEjveevXgLDw18RFKfPwWLG3xs7H3xY1DTbnMVkn/0n5oTptxrhBSfEYdCvWc2q61ep
	mXCQXjIPAUj+SsoMYJREv4SC6dLl6/oIl+VGXNn9vKW/e5lj3B5dMG91WRPSLeg6uQ4x3jvK0gu6S
	JPjlLMTfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpEQG-0000gp-By; Tue, 15 Dec 2020 17:47:40 +0000
Received: from hqnvemgate25.nvidia.com ([216.228.121.64])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpEQ9-0000f4-SA
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 17:47:38 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fd8f6ae0001>; Tue, 15 Dec 2020 09:47:26 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Dec
 2020 17:47:26 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 15 Dec 2020 17:47:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYn6YGaAJcv7hvf9SSQFRpZCN3YxhSfEec/T+30WXBd1m0T/a+jDYq99LoJrDtJsnIfxCsh9JH9RA+YER9j7Cl5DseukGG1G786++z8Lk0R1SmmMU4LCE3rYxcuRvPLLtQ8+GnFVqE59RwvODHucSPV/wLnwBf21FwPmPfBPm6AL+dK/tdLNt0BHyXc9D+9CDzcAH82XabAu8CJRQ+VX9M8/HWfUb7Fo17dhe1FHFruv0vpy7nWWakuJBCfgOg9eZcuEY4giWZM6SrokbPfHKq2CcSjqaxUvMun1S69VQPqJauhAT6/0pqDLShnkxnilRFpGMVcM6+1nYmsXq6rjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6Mt8oMG6707IXG9uhfxur226sIgo4Sgi6IVVl3knsU=;
 b=Skq4Curt2znsWNbJtBdnOGL/iR2W3Ch7o4P/Lt4sV+eHEIM+nabegk+zt6jUFD2Yg7rGSrZUmr6BsPDlwOKnBCD1rmqVnVCN8RmOUVH7N4eIjdrit68Mk/jVCNvKMbPqvf90RCs7L9Oc1ZW3X+8ZIZ272VH0gFqF+ptQpnZKZCPlSZIAaAeSJWyUoK3fZQ7+4R6fT/Rt1VsXI0fAcYr0YNFE7hkrLs0iIdPKNf0V6ZvOpfGxeWB7ctSZI9xuAGnOM1ASYuhmW0zjhFnGsiJMmUFNvvDleDzbi3uGhsavBQIu02Cuhs15lbQT+D2fG/gC19yGI0oa2bcecbuCi231Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 15 Dec
 2020 17:47:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 17:47:18 +0000
Date: Tue, 15 Dec 2020 13:47:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH] RDMA/siw: Fix handling of zero-sized Read and Receive
 Queues.
Message-ID: <20201215174717.GZ552508@nvidia.com>
References: <20201215122306.3886-1-bmt@zurich.ibm.com>
Content-Disposition: inline
In-Reply-To: <20201215122306.3886-1-bmt@zurich.ibm.com>
X-ClientProxiedBy: BL1PR13CA0465.namprd13.prod.outlook.com
 (2603:10b6:208:2c4::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BL1PR13CA0465.namprd13.prod.outlook.com (2603:10b6:208:2c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.9 via Frontend
 Transport; Tue, 15 Dec 2020 17:47:18 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kpEPt-00AzcV-4B; Tue, 15 Dec 2020 13:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1608054446; bh=j6Mt8oMG6707IXG9uhfxur226sIgo4Sgi6IVVl3knsU=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=Ap7tc+W3ve/r7b2a849F0lzxbKR4NMtdKHM91fQMbe1wchaJ99mpJcblHTTgdZchS
 zZO4NM5nUpEWmj+E4hDopupuSaOSOEA+zchfaGC+UPXfR+brv5xb3HaUCgf5Kgpath
 sJqhb05lKZbQBGo8gVpcRBqK/SUAspqumSCd/AqGGt+MKUyXWjCvJ2aChUyRpS1m8E
 AgXsKl9qkJwHJmJSRWqN4MAKw8J4u4t1QsaFoh6tEpV/ql+71EGdelmk3wIvMXEIQq
 k2Le8os/vBX+cvn9x2+p9ZKL3xkn28naS0ZnFXdEMB+8ftnuONcsD65MfVpVADqC0J
 PdH3MFXaNkD6A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_124734_041084_F32BD103 
X-CRM114-Status: UNSURE (   7.90  )
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
Cc: linux-rdma@vger.kernel.org, yi.zhang@redhat.com, kamalheib1@gmail.com,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 15, 2020 at 01:23:06PM +0100, Bernard Metzler wrote:
> During connection setup, the application may choose to zero-size
> inbound and outbound READ queues, as well as the Receive queue.
> This patch fixes handling of zero-sized queues.

This fixes a crasher? Copy the fixes line and oops from  Kamal?

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
