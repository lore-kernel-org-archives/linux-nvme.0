Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32094C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 10:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c8zVsi5/AWYSIgCkdO/uvIIl9ShvBPVrnuBZB4gznIs=; b=yC9cM3pPg9Z+7ixr4uWc0n5b8b
	nCbDEoKVp+s7CDYPD9/x+U4Uw1o4hMtwi5DDO+d0hU8YBYWVcPOuuqaSZDtITCZlBb707n5aFaTM3
	/+g5k4D5hl+zqD+vBnmq6+F+ifH+FpotYetb06DE38v8sTIreDMdx9IBdoeVtXke9JzM5Rh+g6DTT
	PPxWk+VBfTuhDt7lyWWkC+UMvlzJVJZRwpYgsPji5jLI4rtDY8xbxqQt4Rd2N9hMW0frrCHmzpcmg
	aCCHaL/GPUC+lHDqGtMg7NZ3JwNIikXqCi51jaXtJdgJxJbwcYWAmQHmqwobIuRc8VOAxJ4eLik9L
	XwFelafA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBZW2-002fsj-A3; Wed, 13 Jul 2022 10:22:46 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBZVz-002fqT-2e
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 10:22:44 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220713102233epoutp01791edcde4587feec508dbf797eb32498~BXGtBMFaO2543525435epoutp01O
	for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 10:22:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220713102233epoutp01791edcde4587feec508dbf797eb32498~BXGtBMFaO2543525435epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1657707753;
	bh=c8zVsi5/AWYSIgCkdO/uvIIl9ShvBPVrnuBZB4gznIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p3LKL4IFyTMxW+eXQKZs5zDZq+TL2/WA/AZ2pZLfdVat6tV8sP8J0WpKB25apb44L
	 uQNCvry5CPELIN6kMNV2PQdkWu5ErDPA/cWvarZB2pAWPl5zJ+cVT+o6vbtZBtZS0x
	 wlK47yoPRVGXFIpKQTDC7Cf5NY8dEIpuu4IdhlAg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20220713102232epcas5p4a6f79d54f45fd0743b9c22cd8c1f9958~BXGr5aJFj2507625076epcas5p4F;
	Wed, 13 Jul 2022 10:22:32 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4LjYb93Mq6z4x9Pt; Wed, 13 Jul
	2022 10:22:29 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	12.4F.09639.2EC9EC26; Wed, 13 Jul 2022 19:22:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20220713102226epcas5p4b440c2e9d3c162110384380785c84909~BXGmTC24r2507625076epcas5p4v;
	Wed, 13 Jul 2022 10:22:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220713102226epsmtrp1a93f54d0c8be535a6e2451aa90bdd613~BXGmSOf150137901379epsmtrp1k;
	Wed, 13 Jul 2022 10:22:26 +0000 (GMT)
X-AuditID: b6c32a4b-e83ff700000025a7-48-62ce9ce235d7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	75.21.08905.2EC9EC26; Wed, 13 Jul 2022 19:22:26 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220713102224epsmtip275059c52f43b25c2e390ed661c099f6d~BXGk8iDbW1553415534epsmtip2U;
	Wed, 13 Jul 2022 10:22:24 +0000 (GMT)
Date: Wed, 13 Jul 2022 15:47:00 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Joel Granados <j.granados@samsung.com>, kbusch@kernel.org,
	sagi@grimberg.me, linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	k.jensen@samsung.com
Subject: Re: [PATCH 3/5] nvme: refactor namespace probing
Message-ID: <20220713101700.GA16726@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220713054914.1888305-4-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTQ/fRnHNJBn936VrcPLCTyWLl6qNM
	Fkv3P2S0ONm4h9Vi0qFrjBbzlz1lt1j3+j2LA7vH+XsbWTw2repk89i8pN5j980GNo++LasY
	A1ijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5Q
	UihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIV
	JmRnzDo8l71gF29F2+52xgbGJu4uRk4OCQETiYb/25m6GLk4hAR2M0rsWNzJDpIQEvjEKNG5
	jhMi8Y1RYtqLg2wwHeuu/meFSOxllPi8/CUzhPOMUWLtqsmMIFUsAqoSnbM3A83l4GAT0JS4
	MLkUJCwioCTx9NVZRpB6ZoH5jBIfr05kAUkIC1hKNPz7xgxi8wroSizsXckGYQtKnJz5hAVk
	DqeAkcTBPXEgYVEBZYkD246DnS0h0Mgh0fr7NwvEdS4SPcsbmCBsYYlXx7ewQ9hSEi/726Ds
	ZIlLM89B1ZRIPN5zEMq2l2g91Q92A7NApsSX1e8YIWw+id7fT8B+kRDglehoE4IoV5S4N+kp
	K4QtLvFwxhIo20NizvN9bJAwWcso8ehJE/sERrlZSN6ZhWQFhG0l0fmhiXUW0ApmAWmJ5f84
	IExNifW79Bcwsq5ilEwtKM5NTy02LTDOSy2Hx3Fyfu4mRnDC1PLewfjowQe9Q4xMHIyHGCU4
	mJVEeP+cPZUkxJuSWFmVWpQfX1Sak1p8iNEUGD0TmaVEk/OBKTuvJN7QxNLAxMzMzMTS2MxQ
	SZzX6+qmJCGB9MSS1OzU1ILUIpg+Jg5OqQaml48iRH+d/N18bf2x8LrvL7f2ZHoVBvFJa2Rc
	sHP+9HTv57+PxJ9PLwnIuX0yTf7rvGSG2aZd1TmF/w/bBykp/GbYUdpneWJqxh7F2VuMi84x
	NrcxXVB+md1fnHR30c3vKl5fqpmW3j8YkNnHqbeorVfk79PoD1/rXVKn5qhEPPrl5xb87eSU
	EPPbr1OSv7+ULI9Ycar6Rc6H9dv/qj3dlG3LfPlZvd2cgx++Ka2bd1FVNFhzvU3Eld1Huh/8
	LUpfWZ2b0pi18uOE4ozWBzmW7suyo3+xNT01Y5qd5LHc+LhieuXzE1OO8goeacu36nkwmTnG
	XqakdPVXrxknphzcVTpz+omJ3PJi2WoRnlXcSizFGYmGWsxFxYkAf0hvWyEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSvO6jOeeSDJZ2CljcPLCTyWLl6qNM
	Fkv3P2S0ONm4h9Vi0qFrjBbzlz1lt1j3+j2LA7vH+XsbWTw2repk89i8pN5j980GNo++LasY
	A1ijuGxSUnMyy1KL9O0SuDIWnPrEWvCSq2LCmstsDYynOboYOTkkBEwk1l39zwpiCwnsZpR4
	0WUKEReXaL72gx3CFpZY+e85kM0FVPOEUWLVq6dgDSwCqhKdszczdTFycLAJaEpcmFwKEhYR
	UJJ4+uosI0g9s8B8RokTC/ezgCSEBSwlGv59YwaxeQV0JRb2rmSDGLqWUWLK8qXsEAlBiZMz
	n4A1MAuYSczb/JAZZAGzgLTE8n8cICangJHEwT1xIBWiAsoSB7YdZ5rAKDgLSfMsJM2zEJoX
	MDKvYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjgAtzR2M21d90DvEyMTBeIhRgoNZ
	SYT3z9lTSUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUw
	OacL6XxbbiP10/Bfb1eWbn2m51oG9Uv71h895fXITKhl8x4F1i3rGx4cf34q8CDzuYagtFBD
	uQ9b/MRDNnpouhtKp1q+3TPR+bTGumefnzzwslsx8abIZjem33dt1toqh110Xv9NWTOlJE3U
	PuTc9l9xMq852FPZVzz6+rdDUX/7ka0f9Znn13iXzWCW83Dfvfgz/6elW76Vrfnx8sGnIEuX
	73d5/jVM2+L2V7lCo2BxxovLvdWCtyw11Q3yCw79SuNevGhl5/YvPM/kt3nuvrfVaULP96d5
	74K6Sh+4trg4B5rfLAhLvt6+8U+0kCtzibHtt98+Qv+WauoGhjofCznTqrFLbnKQSmrA5e8t
	SizFGYmGWsxFxYkAnR6F6e8CAAA=
X-CMS-MailID: 20220713102226epcas5p4b440c2e9d3c162110384380785c84909
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----HMHzcl7Kov5y0bbYah5tgDYyhjafTXQAGx6UUfEgMJOMVZI4=_127cbd_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713054931epcas5p1293ad393b3977d9e289c413c96984fe5
References: <20220713054914.1888305-1-hch@lst.de>
	<CGME20220713054931epcas5p1293ad393b3977d9e289c413c96984fe5@epcas5p1.samsung.com>
	<20220713054914.1888305-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_032243_464949_8F619A93 
X-CRM114-Status: GOOD (  19.14  )
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

------HMHzcl7Kov5y0bbYah5tgDYyhjafTXQAGx6UUfEgMJOMVZI4=_127cbd_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Jul 13, 2022 at 07:49:12AM +0200, Christoph Hellwig wrote:

> static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
> {
>-	struct nvme_ns_ids ids = { };
>-	struct nvme_id_ns_cs_indep *id;
>+	struct nvme_ns_info info = { .nsid = nsid };
> 	struct nvme_ns *ns;
>-	bool ready = true;
>
>-	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
>+	if (nvme_identify_ns_descs(ctrl, &info))
> 		return;
>
>-	if (ids.csi != NVME_CSI_NVM && !nvme_multi_css(ctrl)) {
>+	if (info.ids.csi != NVME_CSI_NVM && !nvme_multi_css(ctrl)) {
> 		dev_warn(ctrl->device,
> 			"command set not reported for nsid: %d\n", nsid);
> 		return;
> 	}
>
> 	/*
>-	 * Check if the namespace is ready.  If not ignore it, we will get an
>-	 * AEN once it becomes ready and restart the scan.
>+	 * If available try to use the Command Set Idependent Identify Namespace
>+	 * data structure to find all the generic information that is needed to
>+	 * set up a namespace.  If not fall back to the legacy version.
> 	 */
>-	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) &&
>-	    !nvme_identify_ns_cs_indep(ctrl, nsid, &id)) {
>-		ready = id->nstat & NVME_NSTAT_NRDY;
>-		kfree(id);
>+	if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
>+		if (nvme_ns_info_from_id_cs_indep(ctrl, &info))
>+			return;

Is this return fine if independent id-ns fails? Earlier behavior was to
ingore such failure.


------HMHzcl7Kov5y0bbYah5tgDYyhjafTXQAGx6UUfEgMJOMVZI4=_127cbd_
Content-Type: text/plain; charset="utf-8"


------HMHzcl7Kov5y0bbYah5tgDYyhjafTXQAGx6UUfEgMJOMVZI4=_127cbd_--

