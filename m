Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA8606A338
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VBIWKGYM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=raiTjx+BmSkMR16aTA0YXPp0R1Sqdpp0zR0V56k7sp4=; b=VBIWKGYMNfIjQf
	fJRU6EzNkv5RoLCC7H4sJQpOob20o39jJaB1LwFBcRTWbIuHz/B89cDAbPAahwFJEcZ4RGkOTO7Bb
	yNJqKr7eZDjMYbURZZZykP2NtghI0O+VeCQnnO96liRDQIf4DBSUvDJ74Z66+/tju9n5GwvYusbLc
	986fdfd/DlGHnEfi6mSq3ODtqNGGSNrPDD8iJItW9vrsuYP4Pw7xpHemXlLfi4A1si/H+FctjcmZe
	CzmFm7PtIVGd0N+B34RinVmHlpaqUZz/t3BQtZB27/JZgOSsPVgZOKn8yWj2SRztPS7mnn5Tpn0xK
	WIGVWtSiubZLgXpidQ7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzPr-00000003BEj-13FL;
	Mon, 16 Nov 2026 16:18:47 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzPo-00000003BCz-0RSN
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 16:18:45 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGIfwR2162510
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:18:43 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxp1gjeep-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:18:42 -0800 (PST)
Received: from twshared77744.15.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 16:18:34 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 7EA1F2F08A7B8;
	Mon, 16 Nov 2026 08:18:29 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261112220058755zQhw_h6UkcVSjRnu478lb@zte.com.cn>
References: <20261112220058755zQhw_h6UkcVSjRnu478lb@zte.com.cn>
Subject: Re: [PATCH v2 0/2] nvmet: fix file backend short I/O and LBA range
 checks
Message-ID: <179484590951.648177.11841424492574370118.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 08:18:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-GUID: b78iyFvmJ0J61_uxlHvxQmbR9A-FSJU0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX0f/745H96eh4
 4IYGLj/IvahGKGtIlrd5d7l1nxMITJhCUnkH44ljAVXXC+cSzzX0SJEDCGYDtZ+LUCZY7RFC7Q6
 m7m+y7EfaVpOcHHcsOSLxD1knGC3dXhgVJtkaNxoLd0DzEbbsqoTb7jGWrMJI5DWDbSxgkaoUCG
 0bwkqV/Gc/Ff2f6v2CxfJeaId4c4ZjFAI8QN6YX+k5hfOAmiI8QKXPeEBHXLslGPETBUFV9qvL4
 WmywKznxWrgVm+A3j+vvky6hM0zkmrLD/ip+mgeqb5yWJTE2kb78uubqtp7sDQNYBOhFUiTODwm
 U1f4fVB1VKmXKnm+JCILsasUR+7MoRZXoBTEpQF3lXvGPFX/lABXorjJSwIvifPEY+tiycZ+ABe
 lY5p8+MqdxoDwngPJZzZNIej7qgUbtiMkK/QEybIDvFZu7CVI9fSXwjIcam40/B+cjnIcbUVNen
 0DhqE7TjwakuuulrFeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX2G6NHvzoabSC
 FGa3LbZYh65Rsvu1ebOSGxRRMc60BkgWlr4xlGvd7g12ND6EEePpRzRBpp1+tsYbC63z/qFnuTB
 cZlEa49WTEyPj9yE8VuxKo2NPemfW5g=
X-Authority-Analysis: v=2.4 cv=aMRlOr9m c=1 sm=1 tr=0 ts=6afb2ce2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=k5peSaqcjJABVPERissA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-ORIG-GUID: b78iyFvmJ0J61_uxlHvxQmbR9A-FSJU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_081844_284056_9DD5AEED 
X-CRM114-Status: GOOD (  10.71  )
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

On Thu, 12 Nov 2026 22:00:58 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> The file backend computes byte offsets from the LBA and block size with
> unchecked 64-bit arithmetic and does not handle short reads or writes.
> A host can therefore make the backend report success for a transfer that
> only covered part of the range, and a large LBA or length can wrap the
> range check and reach vfs_fallocate() with an out-of-range offset.
> 
> Patch 1 makes nvmet_file_execute_io() stop at an incomplete submit
> instead of advancing the position and eventually reporting success, and
> converts a zero-byte completion on the common path to -EIO.  Patch 2
> adds a shared overflow-safe range check and uses it for read, write,
> discard and write zeroes.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/2] nvmet: handle short reads and writes in the file backend
      commit: 1738de07a79b9abdcffe03571c442033b80e7fed
[2/2] nvmet: use overflow-safe range checks in the file backend
      commit: bcd5316e708d418f03707c183571549ad878cfff
--
Keith Busch <kbusch@kernel.org>


