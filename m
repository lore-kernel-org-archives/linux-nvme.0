Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1D606B390
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bnqTwLIR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nM/9kvkcUFjnGBNraQqkEM6/RU/cH+NVkIsatlJqafk=; b=bnqTwLIRfNaiIM
	lv5iaGy2bFD1XaT4M/oROaknpLgbN+N4Hbzgo3a0HX/M07eukRpPO5mSCCHTTFtcu500YVF3X4fB/
	EPiOZpsIrZmHdxTPzLWe3nlLuc1pKC6r8EmOCaUD8MedIMz+NSt56TInhrLBY5kBmBiHGcithBNbZ
	TOW1bqBoP+AUn9DhxOqwWgFiyYZ2U2B5/EJmoYpRtiecTRvF6CpIi4wxt6p0p6K4gZvIl8qVqd5v3
	ihVd5dpoVaV36my+JQwO4XiIjN6uo+E8zqeVbcNSToxuXkdXlbpK4T9yb9XfaDaBGumgfqE+6PvQO
	lkTf/CEUQZbMojdDzf4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhjU-00000006uXs-47tl;
	Wed, 04 Nov 2026 20:37:20 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhjS-00000006uXQ-2tgM
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 20:37:20 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4KM2ao1913989
	for <linux-nvme@lists.infradead.org>; Wed, 4 Nov 2026 12:37:18 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrb4e8ddn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 12:37:17 -0800 (PST)
Received: from twshared36767.32.frc3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 4 Nov 2026 20:37:16 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id CCC9E2E753572;
	Wed,  4 Nov 2026 12:37:15 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@meta.com>
CC: <axboe@kernel.dk>, <hch@lst.de>
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
Subject: Re: (subset) [PATCH 00/19] nvme patch pile
Message-ID: <179382463583.3441171.8379846133187682101.b4-ty@kernel.org>
Date: Wed, 4 Nov 2026 12:37:15 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-GUID: qxzOSXX8iVnsUDM-pttEbs5cOTRO4aKW
X-Proofpoint-ORIG-GUID: qxzOSXX8iVnsUDM-pttEbs5cOTRO4aKW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA4MiBTYWx0ZWRfX/sc7quzGZDUs
 qL5HJvh3ywa/0CrnsIUsfmAmSO4K0hsdcX67w8UG8eHyVwhuefgcQUMOB0Ndw/iFhxpWWDy/jR3
 BbYYfbC9qh4iGRCFOte8SLlFLuVfiik=
X-Authority-Analysis: v=2.4 cv=DJ8acCNb c=1 sm=1 tr=0 ts=6aeb977d cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VwQbUJbxAAAA:8 a=cIrYLgdAOKFo7nbOkFIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA4MiBTYWx0ZWRfX9qO54XRyeMAh
 NUj/YIdnDlhkP/TyGFC7iJcUGD3qB303njeo7doUHaSr7sEiVIDcimXiC5lano7bWe/s9lXmFd/
 HLzXFo9C/66O4ddOqdCplj7q5R7jKY3N4mfK4MO3GRPx613P72dpqEZuts5U5gIL9jIRAh+92XP
 y7E90tFqiGlD07iRyFAgBEkhC/ANIXEoF7dH9pp+I9mXMj24GmLHDafPnCPOFzXCRn85LLKjWZY
 UF2W1Iu8NdnmbtDS5RUsSfmtuvGoHKTRlI/yaMWO4wTlg5jPsgyPssWpYHlzBLm6llimSTXHCSV
 ZKsZrPmntGtYW+Zhpg8qKzy/6J5uywzAG5hVVyMatrPbmiQUE7PbCghxs3hcteEqWEhkBL7RFiN
 FDBri/1lF2+k8ljmYyNDqXNtUAcQYSe4ttjZX3Mi6SHliVQXGapE1k3HHQhRK+JOlZoSurQSAjX
 qrsE7TLFve6pZLMQnTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_123718_742802_2F977562 
X-CRM114-Status: GOOD (  13.30  )
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


On Thu, 29 Oct 2026 08:52:33 -0700, Keith Busch wrote:
> Jens sent a large patch series of various proposed fixes in parts of the
> block stack. The original series can be found here:
> 
>   https://lore.kernel.org/linux-block/20261028164415.1262013-1-axboe@kernel.dk/
> 
> I want the nvme patches considered separately and applied through the
> nvme subsystem tree, so this is following up on that: this series pulls
> out many of the nvme patches from that series, and I'm sending this to
> the linux-nvme mailing list for further visibility.
> 
> [...]

Applied, thanks!

[01/19] nvme-loop: delete the controller if a reset fails
        commit: bc2170d365861d29dce20f982093873baad09804
[02/19] nvmet-tcp: ask for the TLS record type on every receive
        commit: 77f72de389e3774dc95d7cd03a98a73e47013abd
[04/19] nvmet-auth: keep the old keys if the new ones fail
        commit: 41ad4af45ac90259c652135b24539a08a92a7491
[07/19] nvmet-tcp: let the accept work come to an end
        (no commit info)
[12/19] nvmet-rdma: disconnect only established queues
        commit: 000a9f4492abad6008682b55571ddc31941963e3
[13/19] nvmet-rdma: take a device off the list last
        commit: 86ae3841aea4e29d7ac08d5614ca3823dc8dfbc9
[14/19] nvmet-rdma: queue the release work under the mutex
        commit: 80095787f776967361cca76357f19e5445e0cd75
[15/19] nvmet-rdma: disconnect a queue on device removal
        commit: a4387799d4228866dc1746b466cd17e1c638d050

Best regards,
-- 
Keith Busch <kbusch@kernel.org>


