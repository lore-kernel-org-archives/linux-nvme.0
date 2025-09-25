Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D594CAC5B9
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 18:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JyfJbOr4FPBdl+V+aO2gF9yBV+nlou8/xVouFbJmoYo=; b=Ha+WTpsIT7f0bUnqtfoUO5vYmJ
	0JTMAx1Qi1ty3QWpbJEtlSM/SjJ3pwk0Q3TGBXN5RermWO3p68gubEpQUA1h13XzZNms756SIr55A
	IYSEOOT4m70y1+g/FZ9OVSyM/sCqQw/oWyzWBiNtxBjnwrjxJzti9YNRWbRkKY7LgQqmpYaH5vI/a
	FUVl6BEh/e8TES3R/PtkYRIrX64G6kPyvc/EEweL80JtBkZeo8HmM0VXF5VN2UtLcjMDP/xjEBzIR
	FsHuSs6eIGlLKsAtBeF2c/gZYl6TAwWOYwmTDpFWuV6OGV4Oh6MrN1XTg/UCWsGxr+8dAx6b8mIte
	A9XHK/ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1r9r-0000000C6mq-3T0a;
	Thu, 25 Sep 2025 18:57:35 +0000
Received: from omta036.useast.a.cloudfilter.net ([44.202.169.35])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1r9p-0000000C6kW-0lxb
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 18:57:34 +0000
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id 1d9IvhmjeKXDJ1r9nvg1nq; Thu, 25 Sep 2025 18:57:32 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1r9kvmAniLidY1r9kvAXGP; Thu, 25 Sep 2025 18:57:28 +0000
X-Authority-Analysis: v=2.4 cv=bq1MBFai c=1 sm=1 tr=0 ts=68d59098
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=kbmabLdzh3uUJaiPGAIkPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=EiXV_-hVxRXBCySLXD0A:9 a=QEXdDO2ut3YA:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JyfJbOr4FPBdl+V+aO2gF9yBV+nlou8/xVouFbJmoYo=; b=i5HQtdbHdtH3vcVpqbjjn2ie8U
	AWcvRl2YSGLCnC8cV6XqBsEJdnlpnAvjUrFErksi/KCc8KNonWXPxEwobhD9e8T2RlVjVMRT79lHk
	oR4v5EqdjbxbONQge8+Xd3FNFf9UuKPvKu48QrCExjMQdSI8yeKRYYopGwUSnbjEH/fqqa1hPBEJB
	dsb5oCZV8T/k9uBRwisgb3wSqr7jJKjhOgoouzJul35rNGpQSZb88dRjAIISc4dMVWGrp/SJBR6gp
	h6IdV2vh7T6/zgTsGmZpy900iL7eBZkP2XOgLTyfiRpRm74h6iowDE6XmhlSMEv0Cbw146oLujSpt
	P6+8+VBQ==;
Received: from [83.214.221.223] (port=45832 helo=[192.168.1.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v1r9g-00000000TKO-01Gd;
	Thu, 25 Sep 2025 13:57:24 -0500
Message-ID: <7b1342ce-0f30-4481-bf3b-ef3c92b9bcf8@embeddedor.com>
Date: Thu, 25 Sep 2025 20:57:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "scsi: qla2xxx: Fix memcpy() field-spanning write
 issue"
To: John Meneghini <jmeneghi@redhat.com>, bgurney@redhat.com,
 martin.petersen@oracle.com
Cc: axboe@kernel.dk, emilne@redhat.com, gustavoars@kernel.org, hare@suse.de,
 hch@lst.de, james.smart@broadcom.com, kbusch@kernel.org, kees@kernel.org,
 linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, njavali@marvell.com, sagi@grimberg.me
References: <yq1zfajqpec.fsf@ca-mkp.ca.oracle.com>
 <20250925130729.776904-1-jmeneghi@redhat.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250925130729.776904-1-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 83.214.221.223
X-Source-L: No
X-Exim-ID: 1v1r9g-00000000TKO-01Gd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.104]) [83.214.221.223]:45832
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJP1879xesiZNRBvOuRojKus+KcLdynX1CdOW5JQZKodVE25he1htz3UK+5HYCIimOoqed6PMmtW0XJMxKAkVvMAoyK9XkHTtuu4Pr0NGEi+z5uHLSZG
 Grwy+4x04CCKfGaeyvB9AoYmKeYfoiZrKIrhbG0bNC/fRtE+ZoCAALDVrDWGSsYCXLE3lAsftOb7HNfP7z7i28JaU+WJU4mK5WEZuPp3XQZJCdeAoVhEWsTj
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_115733_303943_4B1BDDFF 
X-CRM114-Status: UNSURE (   3.64  )
X-CRM114-Notice: Please train this message.
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



On 9/25/25 15:07, John Meneghini wrote:
> This reverts commit 6f4b10226b6b1e7d1ff3cdb006cf0f6da6eed71e.
> 
> We've been testing this patch and it turns out there is a significant
> bug here. This leaks memory and causes a driver hang.
> 
> Link:
> https://lore.kernel.org/linux-scsi/yq1zfajqpec.fsf@ca-mkp.ca.oracle.com/
> 
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo


