Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082B2606D815
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v48Lsmqu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6bxWa9BhJ936wj2QTmk50qV7AcXRwA1UfxmnMBLdpAM=; b=v48LsmqukEIPcV
	o0jRY9EriF7v1yT67KQwMzGBn7Tyv1CKVoQnz3CHKFqtTuZ+JvRI8f2N7m5AHT1EoPBQUKw0FC3bd
	P1hHIM4Gbo7BgHO6ejgE5K5l6JMf/DJUYfNXEWbF9/xRqmz9xYVfVKlWqhRIWgzDfFKQcCPgMTV5R
	U4U+7VanD5cn6gKgdjOY+5f5VeD8xi8SZiyNSXzahnVj/77mvOEbRH+453VyEwzSgx2/S7LNsj1Q8
	4tHcnmztegZlO16Bo8WL1hAVABRYHMTkbDWyLmb4oP2YCLUapjw3VTEcPKILGaW6nXnAC5jz9hTBm
	ddd2D+mEtc6DgPc62uKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOz8B-00000009NG2-0xE3;
	Thu, 05 Nov 2026 15:11:59 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOz84-00000009NEi-08m1
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 15:11:53 +0000
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5ESS6E4164510
	for <linux-nvme@lists.infradead.org>; Thu, 5 Nov 2026 07:11:50 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrqp21qy1-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Nov 2026 07:11:50 -0800 (PST)
Received: from twshared13996.31.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 15:11:47 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 8E6E42E7EC6F0;
	Thu,  5 Nov 2026 07:11:31 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn>
References: <20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn>
Subject: Re: [PATCH 0/2] nvmet: fix configfs attribute validation
Message-ID: <179389149158.2132554.16810927122814072564.b4-ty@kernel.org>
Date: Thu, 5 Nov 2026 07:11:31 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfXw3pLV1YGLGZf
 v6cvTp/lRw7KAT2R3UoHwGq72F6c2DuqfEG6bVJQo4e76Z5aruQ5bOWmwxc4rLqnXvOy6/eck7v
 iHeaZodhVz66IAtmCx9WICkmq5E7GdlvNw03aAIkQrjFxb0p1gcjPZgQV05OGA8GeHEZ7oSG/7F
 TmXnwAnxWsOANXI7kdfNxYJSlBeKaxplrQHLBWOL2MvRF1rr5zCKfCzxywsEQQRcNRnd0+3e91C
 kDSrE5OpAcVLWrMN/despxIxKC3HggmKx453cNLNollsUDyu0sCA7O8auJtTeJmJnApZQQtUAhD
 FWqP22vTKyyF2zy4Gz24P/5I9WHNm7Ti6KDAAa3ViblTvECUpjq4yTfg33KdDrcUw79iVFfJRyV
 qM+Lbe8pbcdlzAr4DkDSF2NmiqGRRfUj8lDxVg/KyR2ZtwVXKDWqCq2WgS3uWwAZs4sPKQmh0iC
 1X6rigk7WFYTHjDMlAg==
X-Proofpoint-GUID: HHqPWZmhCr7CaNwbIER-BTLUwpID1MGm
X-Proofpoint-ORIG-GUID: HHqPWZmhCr7CaNwbIER-BTLUwpID1MGm
X-Authority-Analysis: v=2.4 cv=L8mI0OT8 c=1 sm=1 tr=0 ts=6aec9cb6 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=9dzKPAul-E0u2g9dFJgA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfX5+ckeeyggIKy
 u/C5GWOSi38sI9NdM0sO/0Mcfz+y6U+XOdXIofCoUMQCn1JlhC6ZAhH1PzBoX20CyJ4Bq9c1tuh
 u2BfEvQf3hEv1SMvdgM5kuuXpbzlPmI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_071152_082050_CDCF97B9 
X-CRM114-Status: UNSURE (   8.92  )
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


On Wed, 04 Nov 2026 03:07:20 +0800, shao.mingyin@zte.com.cn wrote:
> This series fixes two independent configfs attribute bugs in nvmet.
> 
> Patch 1 fixes a use-after-free when attr_tbkas is written while a
> controller is going away.  The store callback walked subsys->ctrls under
> nvmet_config_sem only, while the list is protected by subsys->lock and
> nvmet_ctrl_free() does not take nvmet_config_sem.  Take subsys->lock for
> the walk, as the qid_max store callback already does.
> 
> [...]

Applied, thanks!

[1/2] nvmet: take subsys->lock when forcing reconnects for tbkas
      commit: fb205953868a7f29317ad619366a5faf2bb268a7
[2/2] nvmet: bound the traddr and trsvcid configfs writes
      commit: 21d6e9f2fb79da2a516901697bd562c361ed6160

Best regards,
-- 
Keith Busch <kbusch@kernel.org>


