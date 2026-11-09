Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFE8606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QIFjv4ej
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=g4LcYdOZH4gsznCUXscaCp9ueXDK0eydwQ4sKQHtqYo=; b=QIFjv4ejIkkp6L
	W2Q5ysw7jXgGZXfTvGcJ0nBDwHT1hKw1Rbc9q1yMQmRulV6cszu7R/1v4tpEp3pmyiOhna7CZyE5V
	FmlhLz1LUa3ndJrCop8V0RvVlDOBbK8PcVSVZ809N6rgcL+co5nDiGekCQxinehS8dQuH9ZRLl7Qk
	ofaGfxOfE94jVZTfjjw0gfa3KtR0OzS5mbRee/Mxzhmp/ckC6z/DhLqfVFCSgDCUGMI0FGDdcX20k
	BD1R9d3FaIN5iEHy+AWgWyh0BGpV1x7qJuwCNMvjXfhwM/SunmSEiTF2hIYJvhTBgzHZvHQj5Ir1j
	FPKfFACOXifapS2V7ORQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQTTI-00000001NlP-2Y2t;
	Mon, 09 Nov 2026 17:47:56 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQTSy-00000001Nhg-2Rj6
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 17:47:46 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A9HIWZZ1238192
	for <linux-nvme@lists.infradead.org>; Mon, 9 Nov 2026 09:47:27 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4ht0btb4cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2026 09:47:26 -0800 (PST)
Received: from twshared36767.32.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 9 Nov 2026 17:47:25 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 1CC432EB13629;
	Mon,  9 Nov 2026 09:47:13 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261105215807526OqR0Bg86VChvwhCEz5xGr@zte.com.cn>
References: <20261105215807526OqR0Bg86VChvwhCEz5xGr@zte.com.cn>
Subject: Re: [PATCH] nvme: reject invalid reconnect_delay sysfs values
Message-ID: <179424643310.2115845.680024030621638618.b4-ty@kernel.org>
Date: Mon, 9 Nov 2026 09:47:13 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3MCBTYWx0ZWRfX5ERAWp/N3Fig
 h8ySchNTYkEX7ECljwEXbqDRbB6vi3jv61eLLCrrsjo+eCgl/J0i9cz2G2p+GdS2hjWLBgVxptw
 +0KKdgSlmNX7meFXrQpm6qdvtZSa8so=
X-Proofpoint-ORIG-GUID: vOutZshcDAoqej6j2p6FouLX8IHAzmV7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3MCBTYWx0ZWRfX3or1TWtzKRpf
 UZlzg59u8ABIYjI2E80nbOiGHen7zRsBGjNWY98drHneOFkWte7oORiAA+2kK36WZZqmFQ72NkL
 p0JdjIICwEu8EnSH56s8RrW2gfawYDsGaLmHN3ap0p43W2NSDZLWg6mFbzVq2SvctfVQj8Ss0BC
 len+GeBmlhPsryXT11CgbmbeQaqS1MMFA6OEXVWPi+vG/CeRAEqgN3dh6vfCeZlI3l+A+c4RnFF
 +tbWJK0PrFw5RKOsfsWqW7UgBzidMn1GeC716hOwOlIgq9/+R1ve61PPWbydxkvoeHNk74osUSl
 gHLH/8y040CGJZIQGpVGj8zrXEXXGMlGNnbDG/MLpgiwJn2pGC5mljd5POcWAIDE2N5VzVZmZEG
 u+orI2cm45AtXBCYAFUdv9urn4dTZzqlA9N7vvzmbZpxsdgDnAdKosc1Dz3blNSOoW6FyQi26OB
 p36tWK5ApPfhbWUxi8Q==
X-Proofpoint-GUID: vOutZshcDAoqej6j2p6FouLX8IHAzmV7
X-Authority-Analysis: v=2.4 cv=d65gWhjE c=1 sm=1 tr=0 ts=6af2072e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=vuk_V-wIeD6UzulCNUMA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_094745_171520_34D29541 
X-CRM114-Status: UNSURE (   7.32  )
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

On Thu, 5 Nov 2026 21:58:07 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> nvme_ctrl_reconnect_delay_store() stores whatever kstrtou32() accepted
> into opts->reconnect_delay without validating it.  The nvme-fabrics
> option parser refuses reconnect_delay values that are zero or negative,
> and the rest of the driver relies on that: nvme_ctrl_loss_tmo_store()
> computes
> 
> 	opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
> 					    opts->reconnect_delay);
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme: reject invalid reconnect_delay sysfs values
      commit: f92fe8dea19c743eb9e4d998ae0384344dd40091
--
Keith Busch <kbusch@kernel.org>


