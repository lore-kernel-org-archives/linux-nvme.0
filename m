Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FF7606A6F8
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MFgqnYkl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=eo0+yx3GhZH+2NEI9cv9dZEY9GTkOnGCKzMkei2rOj4=; b=MFgqnYklzCwiv8
	SkHMnq4VIjXPrv8yiHErGW0UptOsKmoquTkBWg6jzFIaWPdKDMD0zaE5J1LMz5NzHvR8JsZdi4l/o
	+r+JewWaXT9gQujNKfqlPdjIlQWmYu0T003/l94zpwlW/5/MAIO8yp6wE7b1ULL109I/VxBz6WirS
	MWpfoLM1LL4VF1pmpPHuze8GeTAKjUzVws5zXcPOX5vFOcfPoGW94auM8YyjGFdi6bUH25/lW5iKe
	69od7xyTSHlwMUCbLzfeX1WvPvY+FDK2PDu0gIKFni6+DLnc1Vh+94Q7Q568+JC8kPZj1/lJmSDZq
	780yI3Re6+eZSS4xAivg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUht-0000000G973-0bw4;
	Fri, 20 Nov 2026 19:55:37 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUh6-0000000G8mn-0a85
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 19:54:54 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AKEfbKV4076606
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:47 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4j2bb2p536-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:47 -0800 (PST)
Received: from twshared24494.03.snb2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 19:54:40 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id D42FD2F49353A;
	Fri, 20 Nov 2026 11:54:35 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <linux-nvme@lists.infradead.org>, Gleb Chesnokov <gleb.chesnokov@scst.dev>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <0099f610-a48b-4557-8515-e4df444262e8@scst.dev>
References: <0099f610-a48b-4557-8515-e4df444262e8@scst.dev>
Subject: Re: [PATCH] nvmet: report backend transport errors as path errors
Message-ID: <179520447586.200813.7403174515660179966.b4-ty@kernel.org>
Date: Fri, 20 Nov 2026 11:54:35 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=KqnYSmWN c=1 sm=1 tr=0 ts=6b00a587 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=VwQbUJbxAAAA:8 a=iTW6AIvZo88YF_rOJHYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfXzlLyq39cmyTB
 vkemIc+IoUr53Kxf98J0OOJogXol+ZMI8KOMIxS4MGjesEkFt21R7858pW9pC4KcyUIY5LccWSu
 rhVrafVIWNkkB51M9n8w4TkDtizGo9+1MYJaw4raxTcexhHioGS64XXmi1VlIEsjnBh9MVxlEEK
 at9GqIHCRZNu9bqo1plVnOiJNzJ1JrMNMmVk6y/PI43LBRdjRwiTRrz00HewkcKXvQRAXuYgI5d
 fSGGXXMv0aCs+kU3wkIqN3DUxrKW+enM7pttoLjG32JmZf6NG7gVCH+Xwoyra5r7lfqjHgIn+VH
 NY+OXz5Vej20MD3A/Mi/0qn+JeU20hYvSdPxF3az7IsTZPWwX+4eK0Pt1A2ig6DFjKj72NUm+XZ
 zvaur7k96vKlMrq4t8pDDBEUuvqvP7AD0VZ5L8ui5XAP/TrsOXW5Vj5vxSwRm77eGSmI1A487y2
 tlrYtaXN3tGsMarAaJg==
X-Proofpoint-ORIG-GUID: wsiPy57ugigx5Hf22qWwgXpHQCa2uQXw
X-Proofpoint-GUID: wsiPy57ugigx5Hf22qWwgXpHQCa2uQXw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX3bbV5xWKn4Yz
 4YYIrUaw/Phq5TkrHH60daS6L0fmizwh/KcjH8JOLHAIFU6+BNp3m73bqkn+Ng8T/LXwlJ2Ho6d
 ECBvqSdHjXoEGillZTrHfY6Y2Z9f1oI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_115452_226606_646F8660 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.2 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 14:02:47 +0300, Gleb Chesnokov wrote:
> The block backend maps BLK_STS_TRANSPORT to NVME_SC_INTERNAL with DNR
> set. This discards the backend's transport error classification. A Linux
> native multipath host completes the request before considering path
> failover, even if another controller can still access the namespace.
> 
> Map BLK_STS_TRANSPORT to NVME_SC_INTERNAL_PATH_ERROR without DNR instead.
> The transport failure is behind the controller, so report an internal
> path error rather than a host path error. Associate the error log entry
> with the namespace, as for the existing access-denied status.
> 
> [...]

Thanks, applied to nvme-7.5.

[1/1] nvmet: report backend transport errors as path errors
      commit: 3b90e37012c0c5297ccbd7b531287b943c818bba
--
Keith Busch <kbusch@kernel.org>


