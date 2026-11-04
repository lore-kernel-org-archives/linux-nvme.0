Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03490606A87B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Cc8Wfe9k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vPDII9erptSMUVl+p4sQW0aj/xlPNN974/4n1SlNE54=; b=Cc8Wfe9k25Cr1x
	1QCAs2reSX3Aftg/zUdzyrhConKtFBOTiKI17uMHerzEjNxUPNK+Hyd7NusGj+DGXnwMC9Dacoq20
	vtmCbsGllJq/paX5SwOLSC17t7+iJYoYf6uE//BQmp0IAAqHJovIwMWyXGnSMLCZu5RVYraS4dIO6
	SLHmEldE65C0DdXAPyIGJ8ugzpyW82QrrWeHpG/gqQNc/v2XP/UcUPh4shi1eyN1x2PFKZUCWFSlI
	OzQ1bq/ndlPd31ykfKwnaCWOeR/Bjygk2bkXFCZWUjBMWBBN9UyH6B2xHYMHJ0V1mW9zFmPeAof9A
	OuePTZ3jd77rRzlK+5sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOiRn-000000071KM-13gh;
	Wed, 04 Nov 2026 21:23:07 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOiRk-000000071Iz-2ZAF
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 21:23:05 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4LMFWq2050193
	for <linux-nvme@lists.infradead.org>; Wed, 4 Nov 2026 13:23:04 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrb4e8sym-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 13:23:03 -0800 (PST)
Received: from twshared9449.02.snb2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 4 Nov 2026 21:23:02 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id C69B32E753571;
	Wed,  4 Nov 2026 12:37:15 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
CC: Eric Biggers <ebiggers@kernel.org>, <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, <keyrings@vger.kernel.org>,
        <stable@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Roberto Sassu
	<roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric
 Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Hannes
 Reinecke <hare@kernel.org>,
        "open list:NVM EXPRESS DRIVER"
	<linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
In-Reply-To: <20261103030226.2685251-3-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-3-jarkko@kernel.org>
Subject: Re: (subset) [RFC PATCH v2 02/11] nvme-keyring: Add a missing
 key_put() call to nvme_tls_key_lookup()
Message-ID: <179382463580.3441171.16018709754015712565.b4-ty@kernel.org>
Date: Wed, 4 Nov 2026 12:37:15 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-GUID: Z_UUULjlksOzueHRJ6zT6snSA1WIIaAw
X-Proofpoint-ORIG-GUID: Z_UUULjlksOzueHRJ6zT6snSA1WIIaAw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA4NCBTYWx0ZWRfXx5+r2sxkCF5X
 V+VJK9gymsDLkMjazLpZWx3eQMb3vNrgs1UqSxf2P/ZFgMvTdueA8NR8jv2nzMnihB9UqHAd1xL
 CK9PEfoT6KrRzEv0XtG70GxkIGXR7ls=
X-Authority-Analysis: v=2.4 cv=DJ8acCNb c=1 sm=1 tr=0 ts=6aeba237 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VwQbUJbxAAAA:8 a=aadjRP30N3kj4PPyLK4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA4NCBTYWx0ZWRfXzX3R2rfHAOH8
 j9ELplPAjQAcB4J/p7QyrV1bXypmZX7zBleHDUtATiMOEP1mpc+HTqDiFjMTxtCc+8XOfHk6waI
 Z9QqK0Ea8W45b3975s1X9LXBRm6J3F98loC5clsIgFjuu6jEE2ptBzhG/nxbj9p8NjsdgaeACfK
 6bZca6BR5cAxGI7drxKREt6s/6PlLtbJs2IeuK6VzlRF+IzpJBRrbebG0S8992S7PiIPffMuKKd
 4HFpi5K1tiUNFjdrSuSLN8NrZc8XZgFAMXXJ0IkfiaU9ao/ANsbCTE8akXYFvo3qtVb9vh1ZCwN
 nqnxjV9XGF9b5Ragwo30gsvN2DhRJgTp0ReefHvl6d/VKmGdJhLAg/r652DIJCcejtKgdpXhcJ6
 CfogntJVjJI54eV8p9FHmt/GTkzfQ4NOj64mT36b6sYRapfsUu6Sp8nSOWbXsp4x9UDCiUlrK71
 j/4AWwW9t2oUbXWycjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_132304_662547_D1810896 
X-CRM114-Status: UNSURE (   8.88  )
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


On Tue, 3 Nov 2026 05:02:07 +0200, Jarkko Sakkinen wrote:
> Call key_put() before returning -EKEYREVOKED, as the reference count gets
> incremented by key_lookup().
> 
> 

Applied, thanks!

[02/11] nvme-keyring: Add a missing key_put() call to nvme_tls_key_lookup()
        commit: 404a8f6caa63822c1d2a45adbf07fd9c0567a7ef

Best regards,
-- 
Keith Busch <kbusch@kernel.org>


