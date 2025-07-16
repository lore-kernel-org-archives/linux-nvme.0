Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890B7C83F1B
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jul 2025 09:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UK+cRw6BHYgTBmSStxePjW4JegDUuN5eHUVjHh3Sfsw=; b=QEYZYLeJO5O6FcU4XlLgMhczq+
	U9DpOu3vAQ54m4DfolcgOgMVBPqyIQ+tMkHn+/Km9gguIHCI2oGTjhbwnICtBOcE0MbIZTYiVip0p
	lg7lbip0kCt1Nr8XANVB0HD4SF411mhLC0jedDKsgxiiU5jmsxhyihI4onYq7XxQFDPh1bZVXuXcy
	bopuND2Er0ptBeYMPvvTdmA5QOMIj9iIceJFt0d2oqFL97V2Q3Y1TOw9n0IFRzALOb3Z/EByfCOA7
	F5SJgjL27ojeqjZOT/+lR+fo3KX3zmQW2MsccPaIgpssBiahy5BtgigImOdRZlQorO87w3TA3Zgxe
	BRsrCVfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uby6X-00000007EeD-044m;
	Wed, 16 Jul 2025 09:07:09 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uby6S-00000007Edl-1iFf
	for linux-nvme@lists.infradead.org;
	Wed, 16 Jul 2025 09:07:07 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250716090657epoutp01ee0d9d9f411367bc2cafef306dec2484~SsBbbFXF30273902739epoutp01S
	for <linux-nvme@lists.infradead.org>; Wed, 16 Jul 2025 09:06:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250716090657epoutp01ee0d9d9f411367bc2cafef306dec2484~SsBbbFXF30273902739epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752656817;
	bh=UK+cRw6BHYgTBmSStxePjW4JegDUuN5eHUVjHh3Sfsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Irr1jidLTOmi+AAPyuMjxI+Y4ICrCtctTwbCaiRkiKyBAhCgsj8PbxAqxOqctB8h0
	 aFEtA4K/Y/W+wCpqEDNjz/N+4HU9nb2cXX7YX+Et7TNuUvTxXOZL/w9xyoyUP6bWK5
	 sVqBDrF0UVHJ0B5ZxTwEuWJUGtsc7GZyc3DHOTaU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250716090656epcas5p26d47c2071c38c26bf298cb3102ff6783~SsBbNtVV03245832458epcas5p2z;
	Wed, 16 Jul 2025 09:06:56 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.86]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bhqtm1zgSz3hhT4; Wed, 16 Jul
	2025 09:06:56 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250716084412epcas5p4c412b3a6b918366d7548c3c97e772ad6~SrtkYPm0t1570715707epcas5p4T;
	Wed, 16 Jul 2025 08:44:12 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250716084411epsmtip29395a4ec2326d3467d11e1e96bcff583~Srtjc1HHi0326203262epsmtip2F;
	Wed, 16 Jul 2025 08:44:11 +0000 (GMT)
Date: Wed, 16 Jul 2025 14:13:55 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	gost.dev@samsung.com, nitheshshetty@gmail.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Add support for FDP devices in fabrics passthru
 path
Message-ID: <20250716084301.aulmx23rmumae3ba@green245.gost>
MIME-Version: 1.0
In-Reply-To: <20250715080958.GA20790@lst.de>
X-CMS-MailID: 20250716084412epcas5p4c412b3a6b918366d7548c3c97e772ad6
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_17f05_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250715061856epcas5p196a0b67fe58b71e1f81f98a903e429c0
References: <CGME20250715061856epcas5p196a0b67fe58b71e1f81f98a903e429c0@epcas5p1.samsung.com>
	<20250715061804.1954522-1-nj.shetty@samsung.com>
	<20250715080958.GA20790@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250716_020705_903421_E1FC8027 
X-CRM114-Status: GOOD (  15.05  )
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

------CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_17f05_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 15/07/25 10:09AM, Christoph Hellwig wrote:
>On Tue, Jul 15, 2025 at 11:48:04AM +0530, Nitesh Shetty wrote:
>> In nvmet passthru path FDP is disabled, because of failure of
>> admin_get_features FDP(0x1d) feature command.
>> Supporting this through nvmet_setup_passthru_command enables FDP.
>
>I don't think this is safe - the feature has endurance group scope
>and thus can affect other controllers not passed through as well.
>
Agree, how about only enabling only for nvme_admin_get_features,
but not for nvme_admin_set_features, something like below?

--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -533,6 +533,8 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
  		case NVME_FEAT_HOST_ID:
  			req->execute = nvmet_execute_get_features;
  			return NVME_SC_SUCCESS;
+		case NVME_FEAT_FDP:
+			return nvmet_setup_passthru_command(req);
  		default:
  			return nvmet_passthru_get_set_features(req);
  		}

Thanks,
Nitesh

------CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_17f05_
Content-Type: text/plain; charset="utf-8"


------CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_17f05_--

