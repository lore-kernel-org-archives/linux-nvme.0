Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB80606A332
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NAABGZGP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=i1xZpQV5oZnN1kcxMPrvykiqgbR3VKUWhrFmWBJd+/E=; b=NAABGZGPfaoLc/
	6SN+M1efI7QJ7NDBfVi0gbp+Thc+o3VLqgmHiZmPa8Wu6Vk9vo/T6jaUcUtQfY1h0zGlA5ZE4TlcN
	7g9qQ16Rxb1KXu9RmEUsK1hvSZBqpYgEQoSbfJAEIj7ScfY4HacMOuMH2mckkDGGPSa1HNdOSKjto
	vt0N5Uwt60cYSjycpLU0C4AvJBh0URHzw6oXJSuwftImrK07m/OPdWqlT4iKRMXQNLHkWFjpl26S4
	wPR6NuGLgVDixZjpC6+qYDEQcFTHCc1mRD2WwZiHn1a/R39MHA34laUwhGr7NfyN/z/6EVvRiLaWu
	qvrXeSPPh0llfFHx5FFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPMZg-0000000D0JP-3fsD;
	Fri, 06 Nov 2026 16:13:56 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPMZc-0000000D0F8-3gLx
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 16:13:55 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A6F2O3L1024418
	for <linux-nvme@lists.infradead.org>; Fri, 6 Nov 2026 08:13:52 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4hs3r0vq5g-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 08:13:51 -0800 (PST)
Received: from twshared98006.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 16:13:46 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 2725D2E8C4A3B;
	Fri,  6 Nov 2026 08:13:29 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
        Daniel
 Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
        Guixin Liu
	<kanie@linux.alibaba.com>
CC: <linux-nvme@lists.infradead.org>
In-Reply-To: <20261106022736.3582824-1-kanie@linux.alibaba.com>
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
Subject: Re: [PATCH v2 0/9] nvme: dead code cleanups
Message-ID: <179398160914.3651019.1245638944334202538.b4-ty@kernel.org>
Date: Fri, 6 Nov 2026 08:13:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=Cucq4X4D c=1 sm=1 tr=0 ts=6aedfcbf cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=VwQbUJbxAAAA:8 a=w9MrRKMOCNZfOmuLWAwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: r4OrX3hpGL3xbze82ocKPNTDAx53O6rk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX3dt+vATooLBM
 KHhxCCfm8m8Bq+VZbgU4RrazGCKZJY/vFf0QD0EzxUlO1I67isIA/hc5sSCuJWLr5vmJaZL4T3p
 shlHgZ32npRB+xEYsmM40S9BfBx1N4Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX2iObrhCgQ/wO
 LxEtAVVvxnBz21LaRLYtQTIj3TYEawFb4un83K8L6yUg80rbVqSCqeng8/rYmzwDXJdLxlwYwhW
 MZm49pnA6ElY5eheQ7aj31vpamgUg3lZeyQg1/z6zRKdzWKdWxka32BrAqYzced0Q5+kQZLQ5Yj
 4Pz0wAX/LCsQu4zeJjbNEn3HYCO3rEKclkadMH71nATiHFfCmfb3AbKPaPulKwUs0HwtyOHgYYj
 dVbTvZp/jUiYSjlEHEwA0R8uEjiSOeTjKmZhtsDfxmssJekstvBDshCp29vF0ySm1D/8dizGOER
 9B3X/kmVFa4WYLCOeqYffiTp3XyaIgTHI2famkLvnKJJ32641T5uL/jArkFt9KoYwcxokL32deK
 D/KTrJa55OXVHhEBGlw32Vtxa1bQ3kBSZhXQMo4B/BSoXWm+Be8eQBZTHndCM3fV1up/VCgVa/y
 UZRJYLy5vKgWtKPTVzQ==
X-Proofpoint-ORIG-GUID: r4OrX3hpGL3xbze82ocKPNTDAx53O6rk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_081353_087728_7ED34948 
X-CRM114-Status: GOOD (  16.30  )
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

On Fri, 6 Nov 2026 10:27:27 +0800, Guixin Liu wrote:
> A round of dead code removals in the nvme host and target drivers,
> all found by code inspection. Every patch stands on its own and can
> be picked individually:
> 
>  - the NVMEQ_DELETE_ERROR flag lost its only reader in 2020 and is
>    now write-only; dropping it also removes the nvme_del_cq_end()
>    wrapper, which degenerates to nvme_del_queue_end() without it
>  - struct fields never referenced since they were introduced:
>    nvme_fc_queue.seqno, nvme_dhchap_queue_context.entry,
>    nvmet_fc_ls_iod.fcpreq and nvmet_fc_tgt_queue.ninetypercent
>  - a hostnqn already-assigned check that can never fire because
>    opts->host is only set after the option parsing loop
>  - the reconnect_delay "off" case, copied from fast_io_fail_tmo but
>    unreachable for an unsigned value the parser bounds to positive
>    values, along with its sentence in the ABI documentation
>  - an address family map entry that both show and store skip, an
>    unreachable break in the passthru feature handling, and a drain
>    of an SQ list that is never populated
> 
> [...]

Thanks, applied to nvme-7.4.

[1/9] nvme-pci: remove write-only NVMEQ_DELETE_ERROR flag
      commit: 51a08d499c3a2e69ff2509a8c67249b51a52f0c2
[2/9] nvme-fc: remove dead seqno field in nvme_fc_queue
      commit: 21e384dfa497f5bdb987e104652e3a11cda80e75
[3/9] nvme-auth: remove dead entry field in nvme_dhchap_queue_context
      commit: 6e31e030e2004b94f663f7a8bef54e4db79d6db6
[4/9] nvme-fabrics: remove dead hostnqn already-assigned check
      commit: c621d47b7a454a105e7b873d61cd69dcf84d0451
[5/9] nvme: drop unreachable "off" case in reconnect_delay_show()
      commit: 9762c7ae1ee709f6dc3823d151391f89457b5492
[6/9] nvmet-fc: remove dead fields in nvmet_fc_ls_iod and nvmet_fc_tgt_queue
      commit: f7a3f5f72b8b8c53972a6848290e8121e786b4c4
[7/9] nvmet: remove unreachable "pcie" entry from the address family map
      commit: 16fc085d86144c7f6e1c9b70e9d9fe562f8d611e
[8/9] nvmet: passthru: remove unreachable break statements
      commit: 2b7982b06cc877584942d82d071a28a2a9e83603
[9/9] nvmet-pci-epf: don't drain the never-populated SQ list
      commit: 66e3ef5dad6d22a79cb32b614d2a37a166a5437b
--
Keith Busch <kbusch@kernel.org>


