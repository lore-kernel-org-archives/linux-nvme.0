Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9795BC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8BsG80ZWjah583VEciKI6+aEIVkJPGAAnsoATkJLrr8=; b=dVIvaqla42asao82+T2zunIdeI
	51lo0k6W8NpsJsX1GUtHlkdJjJjdhKlKA9I5bz7TB6K3fsGl+lhNsDbqJMT8jn+hXus7TW4h0bjv1
	JszRmgrtHiU6FNLM6C6ANPk981cPBj/9bsWs9xMv5gceluqTTQHgDsQbJ11eZyA6cI3xu2CVOXnxZ
	d5QPwSdcD3rMs5ZfmfCThxn1WNrIHzaZfP2SRflaHcSSssyTorx49dBl1Io6F1dkawF17d6h3rv0a
	rVmqJvB9D21ptHb6VJSdifnw2PnOBWRxFLu3LW95baW+hBkGiPKEBqRS4FewkqhEOPNHa0cmFhZAc
	csCMSa8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp3zM-000000042Lw-27pY;
	Tue, 26 Mar 2024 10:25:04 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp3zH-000000042IW-17gv
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 10:25:03 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240326102454epoutp047977cfa4292f8ee1197872b078a41774~ASYU67VI21939819398epoutp04K
	for <linux-nvme@lists.infradead.org>; Tue, 26 Mar 2024 10:24:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240326102454epoutp047977cfa4292f8ee1197872b078a41774~ASYU67VI21939819398epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711448695;
	bh=8BsG80ZWjah583VEciKI6+aEIVkJPGAAnsoATkJLrr8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=pVXcDVttBjO/oRDUENiGyPrnmq411IHgFJFg+N+8gpN13FDmm4pxwy4y+Uyi/GkqN
	 IHCs1jnVM4xxtdeZDvWRDqvoVlon0BTyPIShtnKGlzm5OTt2FbSx2R4Pio/0p13w4/
	 pkqSN9G9oIDbwxgiPq6ryygL9dVJqK3QpMoVOWUk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240326102454epcas5p1bff3d0b2fa8591cc91bc38ac68b2a78b~ASYUWEv7Z1459814598epcas5p1-;
	Tue, 26 Mar 2024 10:24:54 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4V3mBs1NYLz4x9Px; Tue, 26 Mar
	2024 10:24:53 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F1.5D.09665.572A2066; Tue, 26 Mar 2024 19:24:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240326102452epcas5p180a1ec343ea902673c682f2b24d8828a~ASYS7cj012415724157epcas5p1N;
	Tue, 26 Mar 2024 10:24:52 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240326102452epsmtrp2e24fd026a503399dbc0ad42a8f2d11c3~ASYS6qnbZ2248622486epsmtrp2B;
	Tue, 26 Mar 2024 10:24:52 +0000 (GMT)
X-AuditID: b6c32a4b-5cdff700000025c1-ef-6602a2759456
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5E.76.08390.472A2066; Tue, 26 Mar 2024 19:24:52 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240326102451epsmtip2c30d1ff3297b4f3cdc00b8166e90ed67~ASYRghOJ_1724217242epsmtip29;
	Tue, 26 Mar 2024 10:24:51 +0000 (GMT)
Message-ID: <0fd68aba-b116-3a0c-c864-909bf2d7e80c@samsung.com>
Date: Tue, 26 Mar 2024 15:54:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 14/16] nvme: use the atomic queue limits update API
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>, Sven
	Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, Chaitanya
	Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240304140500.78583-15-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmpm7pIqY0g7PbWS22nO5jtPh5lc9i
	5eqjTBa7F35ksph06BqjxdOrs5gs5i97ym5x+toCdot1r9+zWPy5/Z/Jgctj1v2zbB7n721k
	8di0qpPNY/OSeo8Xm2cyeuy+2cDmsXjZTjaP3uZ3bB5HJ85m9+if188UwBWVbZORmpiSWqSQ
	mpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdK2SQlliTilQKCCxuFhJ
	386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITuj++ZJxoKJXBUv
	t+9kbWBcw9HFyMEhIWAi0d5Y0cXIxSEksJtRYsqhE4wQzidGicOHVjFDON8YJfY/nMDSxcgJ
	1rFxywqoqr2MElembWaCcN4ySszsP8sKUsUrYCdxuGMWI4jNIqAqMW3jOzaIuKDEyZlPwCaJ
	CiRL/Ow6ABYXFnCXmNrziRnEZhYQl7j1ZD7YUBGB34wSXx4/ZYFIpEpsfPWTGeRwNgFNiQuT
	S0HCnAKGEmvXzocqkZfY/nYO2NkSAic4JP7tucoOcbaLRPu3zVC2sMSr41ugbCmJz+/2skHY
	yRKXZp5jgrBLJB7vOQhl20u0nuoH28sMtHf9Ln2IXXwSvb+fMEHCkVeio00IolpR4t6kp6wQ
	trjEwxlLoGwPiWMH7rFAwmoVo8SuH5NZJjAqzEIKlllI3p+F5J1ZCJsXMLKsYpRMLSjOTU8t
	Ni0wzksth0d4cn7uJkZwYtby3sH46MEHvUOMTByMhxglOJiVRHhbvjCkCfGmJFZWpRblxxeV
	5qQWH2I0BcbPRGYp0eR8YG7IK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQim
	j4mDU6qB6U7LV7m50zJE+EsKXpjE/dgh4TZlRmLs3xNTXBROvN+2bq3B15aUX7cyS2dOa/mi
	dlHG9kVwm8Ux413Os13D9B/4Vqnn9n27c+GcUa/p2ueLlwZoVvO+3Fn1s8815tZ9zwc1sZPj
	JBTuLr7tcqO7ZOn3j6yshw5XfE05Jh4hF1ro2zSnqjhawnHC3OiG7IdZ5jd3pKg+Pp7l++XP
	8Tsr+zN9z+e9UJAKMMjVWuz6+/5i1djO690KNQ9z06bfT1n/UdLYqms77/ZYpw//uDiefYw9
	Ndm7qXqeB+P0zlcb1ywW7Zz5rZM7rd9xt+pzl9uv79pNDt4jvkQrcT6biBBva86kAg+71r/b
	svc4BL7VUWIpzkg01GIuKk4EAPgK65xVBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSvG7JIqY0g9YuPYstp/sYLX5e5bNY
	ufook8XuhR+ZLCYdusZo8fTqLCaL+cueslucvraA3WLd6/csFn9u/2dy4PKYdf8sm8f5extZ
	PDat6mTz2Lyk3uPF5pmMHrtvNrB5LF62k82jt/kdm8fRibPZPfrn9TMFcEVx2aSk5mSWpRbp
	2yVwZXTfPMlYMJGr4uX2nawNjGs4uhg5OSQETCQ2blnB2MXIxSEksJtRoufgeyaIhLhE87Uf
	7BC2sMTKf8/ZIYpeM0rc+feCBSTBK2AncbhjFiOIzSKgKjFt4zs2iLigxMmZT8BqRAWSJV7+
	mQg2SFjAXWJqzydmEJsZaMGtJ/OZQIaKCPwGGtr1D6iBAyiRKjH/XAhIjZDAKkaJk7PkQcJs
	ApoSFyaXgoQ5BQwl1q6dzwIxxkyia2sXI4QtL7H97RzmCYxCs5BcMQvJtllIWmYhaVnAyLKK
	UTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4BrW0djDuWfVB7xAjEwfjIUYJDmYlEd6W
	LwxpQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTBZTNw4
	b0+L99ETnyb9WvJj2pmLG3/WpltnfPXJv8mqnLHlyTnmJwlT935Qe9eRvlle7vCG26d2Mi6f
	9vHIz59P3I/+2O80r0bia3hdkT7Pxxlbs7uud3ycfnHf9r+bF77uesQVlLLctu/JkT3Pu9jN
	F9pHbYyp7+x7YJBxnG/awb2pz6YEbY6NWujXcCJaVPyDftIeo+je7Tt2rOub6izPpD5RwLbL
	0K25luP//bk9a8MqDdPjJqxiN3cRLdVKKy+/3vnGNeVbjccpjsmiStveKU1njdBk1hO/rFXX
	7JDQpu+348Ah/baXeUvdVi9+tk3hPN+EY8oxq4Lvrp4r9uhF6KQ1W4IiF+x2viOhsXVOpxJL
	cUaioRZzUXEiAJq95AIwAwAA
X-CMS-MailID: 20240326102452epcas5p180a1ec343ea902673c682f2b24d8828a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240304140712epcas5p43f81cdf9f37d5206cd0ac7201ff16eb7
References: <20240304140500.78583-1-hch@lst.de>
	<CGME20240304140712epcas5p43f81cdf9f37d5206cd0ac7201ff16eb7@epcas5p4.samsung.com>
	<20240304140500.78583-15-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_032501_684239_84FF4BDF 
X-CRM114-Status: GOOD (  15.01  )
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

On 3/4/2024 7:34 PM, Christoph Hellwig wrote:
> @@ -2098,11 +2091,26 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   	ns->head->nuse = le64_to_cpu(id->nuse);
>   	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
>   
> -	nvme_set_queue_limits(ns->ctrl, ns->queue);
> +	lim = queue_limits_start_update(ns->disk->queue);
> +	nvme_set_ctrl_limits(ns->ctrl, &lim);
>   	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm);
> -	nvme_set_chunk_sectors(ns, id);
> -	if (!nvme_update_disk_info(ns, id))
> +	nvme_set_chunk_sectors(ns, id, &lim);
> +	if (!nvme_update_disk_info(ns, id, &lim))
>   		capacity = 0;
> +	nvme_config_discard(ns, &lim);
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    ns->head->ids.csi == NVME_CSI_ZNS) {
> +		ret = nvme_update_zone_info(ns, lbaf, &lim);
> +		if (ret) {
> +			blk_mq_unfreeze_queue(ns->disk->queue);
> +			goto out;
> +		}
> +	}
> +	ret = queue_limits_commit_update(ns->disk->queue, &lim);
> +	if (ret) {
> +		blk_mq_unfreeze_queue(ns->disk->queue);
> +		goto out;
> +	}

Not sure if this has been discussed already.
But do we need something that does not update the limit but still 
releases the mutex (q->limits_lock)?
If nvme_update_zone_info() returns error, the mutex will not be released.

